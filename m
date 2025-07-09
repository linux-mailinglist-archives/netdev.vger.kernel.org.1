Return-Path: <netdev+bounces-205460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA00EAFED00
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B6D1C46880
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B6B2E6113;
	Wed,  9 Jul 2025 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtadkfKR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABFD2E5421
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073271; cv=none; b=g+9j7S102fs3tPN94UIYLeztvyU4TxH/sHfdygJ/6pOogLzb7xzfM4AgfLSY6TLP+4F332IsVF/P/WVdCyeavjgxlwtoVYsNcF7B0bSrwfzzbGRecG0ivC1IKter+WzM8iNR/M+69koap5bLWFkkxHUc6nDyF9AxNo/2KwSErUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073271; c=relaxed/simple;
	bh=Y9ykHGirYpNqtGJXkqW0tDJEz7IdqI8cXIVyGrNiyQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVyMX/+YEfjs0X9p9fimOZPr7Rdmyrjpza2IG7mlTFeef7+GkyxP5LvgaXwpeoaYw8+2ZIdg+Rr767usEnz+OIvkflt84qbS7NUV+bNoTi40DcIRIVgoXCJTUsHqhDOeiJwX6DLjgntbKsc6jojGSurM6OyTTwyTDvHDjE3jFQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dtadkfKR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752073269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B+y5Mc7Ku9xFduFSvneUFDHlNdHuhrWh+oYLysJt700=;
	b=dtadkfKRy08AFtkTzldDSm8pUi/AJh8Itv/BkoGrPRv9soCA83hR7FX0FccNDs8r1tbWuD
	EILGAJyxQCFBBrhjQ1XwZEfo/y6EnzL1tnT2AQuB6TCkJ4VaZqnyUCNIgmyS+lNPMaPRgH
	U8ruU7cAOOED/44yAnTadFXcuSDEiu4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-HZx4v2XVNrO6FAvLAREumQ-1; Wed, 09 Jul 2025 11:01:05 -0400
X-MC-Unique: HZx4v2XVNrO6FAvLAREumQ-1
X-Mimecast-MFC-AGG-ID: HZx4v2XVNrO6FAvLAREumQ_1752073264
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso202335e9.0
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 08:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752073264; x=1752678064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+y5Mc7Ku9xFduFSvneUFDHlNdHuhrWh+oYLysJt700=;
        b=S0HtuzIpQmvKVmsQtY4sE7Y2ss1Nxjf8vlsJWYibu2bo5eKiIAuTrWoq1sF8xlL3SS
         yuwAOiY7StgfpwbKrl9Ix9RchiQ146kek7eU7T2KQP8lZxrAIRy1SJy8ti3WTwfNpcUh
         XocA5+hFoMoMReNHGK3kZPokXlhU/I3YgTIf1jC6Ne6Ytj0IHMTGOmu/m1edmUsxiax/
         B9yj8zfj37ws/BfOHR67BunO5Q+bji6t+uiLJwm9JbHqfM18lfMhJTZvUK7u8DmVmBM9
         bzF1EBnRY4UCOyYPzkSaE6AwHuzekE9t1S2az65BG134SxiREo6ZSw83r68GClV97O7E
         2aeg==
X-Forwarded-Encrypted: i=1; AJvYcCUk1Vw6OXZ3KVI2OoPVyDxcDVOlkraGUDZC7GYWeTcSFwSJFc9zH1lZ5OOQ5qnPAP25R/WKbts=@vger.kernel.org
X-Gm-Message-State: AOJu0YylFVxJF348xIAKuDuL78eCfD411QB2x6SlAQUMw3RdQFug2XDQ
	e9tAp2KrovKB+QUEaEa7A6FKGzduUmaeRrZrIffFRjrHTv4SZm2R3ij1DeOzsqNct19LlXMg0fp
	YZIXOs39fcwZ5lKVDHERjxnZ4qyo25IN7M+r9ElQZQJ4NHg7MAoz1DlF40A==
X-Gm-Gg: ASbGncuf/FEKEyDLNck9zG21Bj++7KqO6WB3fBQLtd69CZsnDYGnvhLCJxeDZcPfxPU
	lQxAvcfp519cPQwztXxKUizek7bZuFZA/mOK2unWtZXxkpicL/EwyqUV6P1/eQWewqGwM5sV0mS
	6zf2WRlfVW6aacHlClNU2c5SSil7c3yFwTPOMl+ZsSz4ev4OxLgCUG908Y2QQPkXVwobxgmLbi7
	PUPVdu7zjX7h1n5oIZRXPNb+KvKGgHip/pZ2aAVgnw+hXCjQsk7mcjOja+NU+taMfJRzKsM+Jqn
	U79FbKSYVwLD3o7vGXYPpwFZymY=
X-Received: by 2002:a05:600c:37ca:b0:453:5c7e:a806 with SMTP id 5b1f17b1804b1-454cd646fb2mr72509335e9.8.1752073262675;
        Wed, 09 Jul 2025 08:01:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxFA3JrFBZwnjsmUsRBbJZ6PJIlFVkCWBmo9J2d0qr9LD4rFkvuvX6RsAssbfW4rug3RVliA==
X-Received: by 2002:a05:600c:37ca:b0:453:5c7e:a806 with SMTP id 5b1f17b1804b1-454cd646fb2mr72507625e9.8.1752073261100;
        Wed, 09 Jul 2025 08:01:01 -0700 (PDT)
Received: from leonardi-redhat ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d511cb48sm26116305e9.36.2025.07.09.08.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 08:01:00 -0700 (PDT)
Date: Wed, 9 Jul 2025 17:00:58 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	niuxuewei97@gmail.com
Subject: Re: [PATCH net-next v6 2/4] vsock: Add support for SIOCINQ ioctl
Message-ID: <h44zrd5qem6vzcmoc45kccx2xaex2lnx6ybf63h5tzc23yfppv@toywbfazwjri>
References: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
 <20250708-siocinq-v6-2-3775f9a9e359@antgroup.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250708-siocinq-v6-2-3775f9a9e359@antgroup.com>

On Tue, Jul 08, 2025 at 02:36:12PM +0800, Xuewei Niu wrote:
>Add support for SIOCINQ ioctl, indicating the length of bytes unread in the
>socket. The value is obtained from `vsock_stream_has_data()`.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
> 1 file changed, 22 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 2e7a3034e965db30b6ee295370d866e6d8b1c341..bae6b89bb5fb7dd7a3a378f92097561a98a0c814 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1389,6 +1389,28 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
> 	vsk = vsock_sk(sk);
>
> 	switch (cmd) {
>+	case SIOCINQ: {
>+		ssize_t n_bytes;
>+
>+		if (!vsk->transport) {
>+			ret = -EOPNOTSUPP;
>+			break;
>+		}
>+
>+		if (sock_type_connectible(sk->sk_type) &&
>+		    sk->sk_state == TCP_LISTEN) {
>+			ret = -EINVAL;
>+			break;
>+		}
>+
>+		n_bytes = vsock_stream_has_data(vsk);
>+		if (n_bytes < 0) {
>+			ret = n_bytes;
>+			break;
>+		}
>+		ret = put_user(n_bytes, arg);
>+		break;
>+	}
> 	case SIOCOUTQ: {
> 		ssize_t n_bytes;
>
>
>-- 2.34.1
>

LGTM!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


