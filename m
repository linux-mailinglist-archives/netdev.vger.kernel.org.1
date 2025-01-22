Return-Path: <netdev+bounces-160370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D11A19679
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 17:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC7B188E432
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 16:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59060214816;
	Wed, 22 Jan 2025 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fy2c+8ZW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C15167DB7
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 16:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737563297; cv=none; b=ac7fqs7jnnU9lK8FkkDQN4Xq+7IgG2rWjjUl2yM5ls/yY/tbTyT/JaQAg5QUc6oov5UTbrE1FKMZN1yr/G8qGHyNNr1RLJkIUdc+reudw9mNBqY4SXeJ4O/G2Y920yz9bMsArJvuN5Eh97IwJqAcKjkGTvP07fLWwna/dq00fbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737563297; c=relaxed/simple;
	bh=jRyuSE9ZKH3JJkBu0z68kd7ijv5w+WGO/MiANG1uRM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4KZtekaSHAhrOTMeu3mVarGoauMB0qfxOSqquFfnSTBVKu2vi8c9ICv+xeZghE5OOicDXrgQjniwYB1ulJYHa1OXWX7HWWSLU4V2hUiDOE0ry+JGHhdFgRty3rPlHYmrrgdl6tFEWbeZSRmYkeptn6crg5avqQuw8w9fY5Vo+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fy2c+8ZW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737563294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lrchyXg/HU0XJbtKthBVKoKC+HahwM1mdawasoV9LBQ=;
	b=Fy2c+8ZWRAISmnKQZLiw7i+98IeTyjiz8e7BwITv/6U2R+snOyepDk4qiScR+ec/WrjSVE
	liokyfWTCtg2ZWgFQrowofQibGnkPTGizFNpfehJNX2EP1WPu8jXOwg/z/r7d8hBuHU0eP
	C0SS6r0c6rI0xTCgnC45DeUVeC8cVsk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-TmIhHak2N6mdrsYdwHbzYw-1; Wed, 22 Jan 2025 11:28:13 -0500
X-MC-Unique: TmIhHak2N6mdrsYdwHbzYw-1
X-Mimecast-MFC-AGG-ID: TmIhHak2N6mdrsYdwHbzYw
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b6f943f5abso1453468785a.3
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 08:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737563292; x=1738168092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrchyXg/HU0XJbtKthBVKoKC+HahwM1mdawasoV9LBQ=;
        b=Bh7sV4Ovli/tH8d7nVM4kAGPlueY4PV7jcg5xl0R9BGCSY8f7pSCyj/0r99edSiCrr
         PsHn5wF7T4R2qA8SGjlm2mwQIxko0Kl16myyZSmtWjLnwmoo25S8yyvQdywpJzYxy2KY
         5ZzgwTUQpKaKqp3W5A0c3ET6EqjzqPzSPi6uZNoel/6afWvKd7urkN9yS0Tj2xmwJqag
         0uV9rYoRRo/npKIw1R8k0S+dwh1t/tSugOue1VQL5/fsveeKVyZSMI5OMvbcQysj7Kbh
         XhtX6o7L0SWNnFLlNW8t+IvXcONzETJMS3KqJdeOs1jjU7sDg1eMHI9yk8SiwQkyMB2I
         xvfA==
X-Forwarded-Encrypted: i=1; AJvYcCXv8WJNbJhhOtDd/bG32vEppahdkhdrCBGMwQoJdpdF1FCMWRgWdbrbcYk1BQn+P8nHvRvYthY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgEvOI30W+tqbYpddV+N8bs12ISCtuHBwiMF7SRP8B6Z6D8S1z
	A6KAImyiuCdeNatL1rROT2hcQqR+gEY8i79BjmEOFGDk40EGuc4XYH3Joqw6tVmkvFx7Cnz3VWc
	kjny6HnGE+Cy32NpKwGjiRUDlHFHorNF7dh8b/KCv70eQw5AOqo36Hg==
X-Gm-Gg: ASbGnct6587lOCHX7iVoiN5unUDKAJfDwHHAXsIaiNsr8jNOEhrA+gtu/1nPL+DOl7D
	uAvmXTXTCqhIqp1UWgdQWbzxdDOItyTDL71bQZet9nRrEgT8ElnThEvuU1ZFhS7ct5bKZg1AVqy
	5u2inU99xEFCFF/nPrJ/WtZl4C04+ASfszyCCxxGRVBe7xEX7KP3I3EsKagrikOonVlyFbYHXre
	EGGiMdukDqM8TIOQ0MuuXsQCmINWabAKumcr0/nRRNwd+TPCY3NFY6S+cqredn4ZszWDOLOZw==
X-Received: by 2002:a05:620a:1a08:b0:7b7:106a:19b2 with SMTP id af79cd13be357-7be631f4d50mr3438225585a.23.1737563292642;
        Wed, 22 Jan 2025 08:28:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGClkPbHInvy/GblgeXY0upSxxBTXeIHS8CekhPKUpB3nzeuLmhh+1b/spwL0F8F79HOphYFQ==
X-Received: by 2002:a05:620a:1a08:b0:7b7:106a:19b2 with SMTP id af79cd13be357-7be631f4d50mr3438223585a.23.1737563292382;
        Wed, 22 Jan 2025 08:28:12 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e23bc8626sm47075391cf.52.2025.01.22.08.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 08:28:12 -0800 (PST)
Date: Wed, 22 Jan 2025 17:28:07 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2 2/6] vsock: Allow retrying on connect() failure
Message-ID: <sfqi47un2r7swyle27vnwdsp7d4o7kziuqkwb5rh2rfmc23c6y@ip2fseeevluc>
References: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
 <20250121-vsock-transport-vs-autobind-v2-2-aad6069a4e8c@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250121-vsock-transport-vs-autobind-v2-2-aad6069a4e8c@rbox.co>

On Tue, Jan 21, 2025 at 03:44:03PM +0100, Michal Luczaj wrote:
>sk_err is set when a (connectible) connect() fails. Effectively, this makes
>an otherwise still healthy SS_UNCONNECTED socket impossible to use for any
>subsequent connection attempts.
>
>Clear sk_err upon trying to establish a connection.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index cfe18bc8fdbe7ced073c6b3644d635fdbfa02610..075695173648d3a4ecbd04e908130efdbb393b41 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1523,6 +1523,11 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
> 		if (err < 0)
> 			goto out;
>
>+		/* sk_err might have been set as a result of an earlier
>+		 * (failed) connect attempt.
>+		 */
>+		sk->sk_err = 0;
Just to understand: Why do you reset sk_error after calling to 
transport->connect and not before?

My worry is that a transport might check this field and return an error.
IIUC with virtio-based transports this is not the case.
>+
> 		/* Mark sock as connecting and set the error code to in
> 		 * progress in case this is a non-blocking connect.
> 		 */
>
>-- 
>2.48.1
>

Thanks,
Luigi


