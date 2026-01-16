Return-Path: <netdev+bounces-250495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C48D2F572
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 11:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3855A3057F56
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 10:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BB435F8AF;
	Fri, 16 Jan 2026 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7BOVrZc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SguTFJKn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011E535F8C7
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768558290; cv=none; b=BINxYuDW+80ppvrH+OYKpuM6HNqxm2yZW0Rhmf8XaJG+YyWI/EhtZ5qFEBajAOe5ltBLfB9fTFJ4W2J1K9Rvdihnp87HGhACh66m2loSvSG6aeldiW13jhOXoQwNlRaYSipWKeHVBsTA/kol6ZZROZSi8HoF/iZxgfTLhHK0Zmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768558290; c=relaxed/simple;
	bh=GvKTSXpSnV61qIeIj7djXSRQdMUqOq9sB7I5GfaTK/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9kyqN2Dt7MVXy6vRk3DqwiI7uc9/G1TfmVArJ7XskruA7wZ2wMIGpKAt5ayUXTEl4aDSL2n7pZA3Tymvtc4efxDxsygftL9l7HB18Yn2EH+M9VT70gHY4YsKI+L5hLH2swdPzLiCdzen4kfdsPy4YklpQB6/WDDVrkI0ANiL6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A7BOVrZc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SguTFJKn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768558286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYdYs09o1BdUi4chDtWqrhvtiarKfR63xIzMRlbqh6g=;
	b=A7BOVrZcSOj8NtR1qeEtI0L0SXcEF22LYwdmkdics4UTOD1aYlpGGzn9LRpZtuIrEi8Vkk
	z59VVikqaeDdvqSKmB/JoduO0pJVyXrktQYwhQp5qob3yCHw33DnFbIGoIAwudrNewFzf3
	Ah3uWYLC9pM7IjrBi2/Q/VGnQbedQxA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-XWDIMKP-OWKHsrbfwu9v5Q-1; Fri, 16 Jan 2026 05:11:25 -0500
X-MC-Unique: XWDIMKP-OWKHsrbfwu9v5Q-1
X-Mimecast-MFC-AGG-ID: XWDIMKP-OWKHsrbfwu9v5Q_1768558284
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47ee868f5adso11925725e9.0
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 02:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768558284; x=1769163084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PYdYs09o1BdUi4chDtWqrhvtiarKfR63xIzMRlbqh6g=;
        b=SguTFJKn50YAKa86lhueg5kezwUXRjoOu3hY7Pjw9Y4Rbc6TcaRRm3drqTqhXguBqn
         Cnk2E4BvDMOtzuFutNwcHBhprztlLjEKdfmWV5r+W2eNInjs7Wp4h/OduCXEbQtUVkUL
         VoypiLNhVlpuQIK6Wa+z5ms3+MaToSYfsKlxgDNOUMAjX9hoA+8aNuL6vCrD/vlTbWVI
         h7/bIq+NblObGEJH4n0pD8xfc9OQ0KQYvmWUChZ67t2bj3xqWv6VyNc88wk7shOw4aiG
         FJh1fhs3LIlZATygoIHMAFIn7E8WH9LGBfFGOMuSTEIJRhDGn6mCmXXkOTFR2COFYYTN
         4KFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768558284; x=1769163084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYdYs09o1BdUi4chDtWqrhvtiarKfR63xIzMRlbqh6g=;
        b=u9ga56HAdYwpBcBkEmYfsfnAyFhqhrG9HxbKTu6kP5QsAQbxyJNNJ+S2dJxh8GZGxg
         r3Z1ih+QMEvtWs4LCsp8SM81b89F0jaxQBOthEbBjWRQrTeVEM5yGxzseJmyafPkhSeU
         8HYDh/CL2wRmVVz5H1bN1k3q8MD/upxvgkSf4HWJeWO0wRP6bcUf/XKybm2AsomqunRQ
         obfFRJHC8FB4wRekDhcWtwA6ujpyqsZ26OXxlP4wihX3HAHdkomyyzd7KS9Cd9M/K79y
         fswSmidIPtVLvb/7jhoFf00pFpJg5UWPRJJW2Jw8STYJDPEIWNssMOjPFmgEAH/Mph24
         n5/A==
X-Forwarded-Encrypted: i=1; AJvYcCVDJXD4EZMvWmGKqzfk9eXD1BTYXO/pD4m+v1rVA7WV1KdlYsPS/z/jLu61jZCaPC7fzBr5zLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLwXy9glgLi71mv1CxBx2MH0/+uWxLVgjnXgIRkHmNWT9+mUpy
	L5wv7rytdaXpsMm2c9vR2o8W+2QJqFkb3oUwVBu8eV+1gRIzBaXVw0WNo/yhrSvFCjnpGO9uo7L
	Rz9r6LJw4i3w+6Dg+WnvnwDl6DdD3pBvC0s4iOKOuuL/VAbaHYH89UdRZjWA9saZHyA==
X-Gm-Gg: AY/fxX5kjb0eMSeZW4qvNs5PELo7ShOVBda4JvvH2lMsvSczVjqEuz6WiX24Q4dTfLh
	Rr2UzrgBmGRpSZjgGuvGo6Ch6Dzu4U7sLDPW0jTSsZ7O+TLuXy7uicW8beQPq9YZ9uDEw0VWKqV
	GFyhOZyJZePMyUJD/GUWZT30B8RbG4UcsXrVK0RAiMnhyXDslbyQvYnBZ2VRjmSjw7lCt5YVsbI
	+dCQ8tJ9mJqcbDim9wzQaLP98UITx0WQ6cmt/7bqGhwo9V6msbShAOOLAOyiNVx1EuZcEGE8Xap
	GiOZS2He96pOiPObsId0w/XfFIYvnfwtP+MCn0RFk/bFL0RrWr+DsKr8ilIoJ8pJYBt6iRr9SoA
	1gIOTYSz10gEa1CLNHTkx52UdsStmRzkh4BfUEyPdDoYMU+ErNiZCE+a1yHk=
X-Received: by 2002:a05:600c:c178:b0:477:a977:b8c5 with SMTP id 5b1f17b1804b1-4801e34cd0emr32517705e9.31.1768558283730;
        Fri, 16 Jan 2026 02:11:23 -0800 (PST)
X-Received: by 2002:a05:600c:c178:b0:477:a977:b8c5 with SMTP id 5b1f17b1804b1-4801e34cd0emr32517485e9.31.1768558283318;
        Fri, 16 Jan 2026 02:11:23 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e8d90b3sm35848465e9.15.2026.01.16.02.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 02:11:22 -0800 (PST)
Date: Fri, 16 Jan 2026 11:11:20 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Luigi Leonardi <leonardi@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock/test: Do not filter kallsyms by symbol type
Message-ID: <aWoKNf1AI9s1bmYM@sgarzare-redhat>
References: <20260116-vsock_test-kallsyms-grep-v1-1-3320bc3346f2@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260116-vsock_test-kallsyms-grep-v1-1-3320bc3346f2@rbox.co>

On Fri, Jan 16, 2026 at 09:52:36AM +0100, Michal Luczaj wrote:
>Blamed commit implemented logic to discover available vsock transports by
>grepping /proc/kallsyms for known symbols. It incorrectly filtered entries
>by type 'd'.
>
>For some kernel configs having
>
>    CONFIG_VIRTIO_VSOCKETS=m
>    CONFIG_VSOCKETS_LOOPBACK=y
>
>kallsyms reports
>
>    0000000000000000 d virtio_transport	[vmw_vsock_virtio_transport]
>    0000000000000000 t loopback_transport
>
>Overzealous filtering might have affected vsock test suit, resulting in
>insufficient/misleading testing.
>
>Do not filter symbols by type. It never helped much.
>
>Fixes: 3070c05b7afd ("vsock/test: Introduce get_transports()")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
>man nm says: 't' stands for symbol is in the text (code) section. Is this
>correct for `static struct virtio_transport loopback_transport`?

I'm not an expert, but yeah I was expecting "d" too, but maybe since
it's static and built-in will be in the text section?

BTW I just checked and for example on my 6.18.4-100.fc42.x86_64 I have:

0000000000000000 t sock_fs_type
0000000000000000 t proto_net_ops
0000000000000000 t net_inuse_ops

And they are all static structs of built-in modules.
So it seems it is common.

>---
> tools/testing/vsock/util.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for the fix!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index 142c02a6834a..bf633cde82b0 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -25,7 +25,7 @@ enum transport {
> };
>
> static const char * const transport_ksyms[] = {
>-	#define x(name, symbol) "d " symbol "_transport",
>+	#define x(name, symbol) " " symbol "_transport",
> 	KNOWN_TRANSPORTS(x)
> 	#undef x
> };
>
>---
>base-commit: a74c7a58ca2ca1cbb93f4c01421cf24b8642b962
>change-id: 20260113-vsock_test-kallsyms-grep-e08cd920621d
>
>Best regards,
>-- 
>Michal Luczaj <mhal@rbox.co>
>


