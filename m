Return-Path: <netdev+bounces-204591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F54CAFB4F2
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17F71895945
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 13:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147C12BEFE9;
	Mon,  7 Jul 2025 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVFAV9hq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707902BEC3E
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 13:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751895781; cv=none; b=fs9xOQtJRuC06DtIpDYqZvXcO2UV8D2M/wX8GXZZ4K0kF1gwiQHLRWFIAi+KyxcgvHm0qvsppaXCUyItXDrMvwVQYqZbYBf38vOpyCX6NJWZSdidNudsvoFpgAR11LDhKcepvKXG7sNzm5j5pa8lbXFARt/zkNRJ88i0StKMHZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751895781; c=relaxed/simple;
	bh=xltTqBYmsiirVvBdNqG5/Fyy6AbHsBrBr+WSXMtuttA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/T7M6QquM0HRPmsOUJkWgP8KwjHIUVhayfgqWagkqoyjvxPJQbwPtP8OBz6O7ALj9lspavL3UYgA1JpU3pjcLSJsG7iVR7ak8c9/YQv9nxXq4jwKn/hwASXCr3KlbqxfdnlTEE16/JjPoX61Ytq9f5bGksrTllfmrQJB2AWF8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dVFAV9hq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751895778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VsmgUKFf5I0+AJIsgxdkjg4irOxBPoSgMLTf3OScQaQ=;
	b=dVFAV9hqfihLamnCChTjmvQdBWwa5yraYDQW4/KHfrxWSye0sNcnlsMO5oW4XX/la8wMII
	nzOBpBhQb6WbMn7b7Xp5KcwvRCoCjaziPwBPSnrc1dHXXJeim/JKhB+vnOeB1KoziFQPGh
	J9MCrLts/sZkLPHUH2ZPckXRZpfmykw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-xFr1KxkcNimcLG-riKJCdw-1; Mon, 07 Jul 2025 09:42:56 -0400
X-MC-Unique: xFr1KxkcNimcLG-riKJCdw-1
X-Mimecast-MFC-AGG-ID: xFr1KxkcNimcLG-riKJCdw_1751895774
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a50049f8eeso1436353f8f.3
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 06:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751895773; x=1752500573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsmgUKFf5I0+AJIsgxdkjg4irOxBPoSgMLTf3OScQaQ=;
        b=qxpm9/lvUoiXvj+BqmlzmtmRxc4sSdS08vB5VUZAfdcSqpHGkvOr2cOPT9C/F2X5y8
         5TGHkFsz5NBQoG0dt+wgM7mW6mfUceqcLWMO98lGvx6WsTyc7k4qGybKGTHQeEJDsgsi
         UUsq7zHQw8TeuhRTgGk0tx4KG9o9zh4djOgNGf/urIi969Q56j+ork7dM79BYmSxoysc
         dLaW2J3iPv8amzLSvFeveA/waoKJQon7MFcTN7pwW61rk8MFN+QG21zyOiuvZCZK1VSm
         xq2w6QBqK49UpriXELz74yWnce3cYhzOK2JCM18nJ47zedvIROGB1npPyap6792NoLXh
         lfzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/DtHC8ksS1r+dCMueHql9SbpYP//znRMSyxKcfhW69HuOaTD9KNIJksO0lJTPCypAcmkx/tI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx7/ytGspP7oPAc627dd4HerS6dskAGfe5STY9jrj9RsvRyIpA
	UCM4I1TPeEsUbx/TtUnNVBBCXkNwlgyra91eVPzyz3ci9pakeXDDNAwOeIzzOW4BsUlnutxgoYm
	EtrSzPCo47NT4+6x91bnkoy05XIsWXY6q9H0dMcZsVW1WLwC7UL7Yj1BnCPNACyE47g==
X-Gm-Gg: ASbGncslPySHbanrG3YXVogLpOpQlHq9pjwKT8aNShPK2Vwme/zk2gTUkLqO4cIJ6GA
	6ucEKlcOecYRCD0NSSsLAuCWscZMSvv8qDEcHOKuJ8QAC4Up/6RlS/onycOhJzjtUo6y+bqAxVc
	YKxwP098puO0mCxk5Fj/MKciKym1Do6LY+6e/q4Uy8g/DLhI1X/lULqb4rS+XUx6W0Qph3L5Afa
	7wKe0m6lG/bdWnAmnaVxIB6seYdUV/Tlolm6D2uFURQ+DS7LIZyjEtTpzmSpXPBvNrI/S6Az+Mq
	leLzF17tVjj76lobHtaTtoc8VBr0
X-Received: by 2002:a05:6000:400b:b0:3a5:1cc5:4a17 with SMTP id ffacd0b85a97d-3b49aa7d51dmr6564058f8f.42.1751895773409;
        Mon, 07 Jul 2025 06:42:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY8SiQF+6f5+bf4//S2AtBghoAdxNERSqvvMXKZJvwoNLtCvWhRhxkkv/MOEbunhybnSwajg==
X-Received: by 2002:a05:6000:400b:b0:3a5:1cc5:4a17 with SMTP id ffacd0b85a97d-3b49aa7d51dmr6564020f8f.42.1751895772808;
        Mon, 07 Jul 2025 06:42:52 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.144.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a997b492sm140318785e9.13.2025.07.07.06.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 06:42:52 -0700 (PDT)
Date: Mon, 7 Jul 2025 15:42:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xuewei Niu <niuxuewei.nxw@antgroup.com>, fupan.lfp@antgroup.com
Subject: Re: [PATCH net-next v5 1/4] hv_sock: Return the readable bytes in
 hvs_stream_has_data()
Message-ID: <xphwpqqi42w5b3jug3vfooybrlft3z5ewravl7jvzci7ogs3nh@5i7yi66dg7fa>
References: <20250706-siocinq-v5-0-8d0b96a87465@antgroup.com>
 <20250706-siocinq-v5-1-8d0b96a87465@antgroup.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250706-siocinq-v5-1-8d0b96a87465@antgroup.com>

On Sun, Jul 06, 2025 at 12:36:29PM +0800, Xuewei Niu wrote:
>When hv_sock was originally added, __vsock_stream_recvmsg() and
>vsock_stream_has_data() actually only needed to know whether there
>is any readable data or not, so hvs_stream_has_data() was written to
>return 1 or 0 for simplicity.
>
>However, now hvs_stream_has_data() should return the readable bytes
>because vsock_data_ready() -> vsock_stream_has_data() needs to know the
>actual bytes rather than a boolean value of 1 or 0.
>
>The SIOCINQ ioctl support also needs hvs_stream_has_data() to return
>the readable bytes.
>
>Let hvs_stream_has_data() return the readable bytes of the payload in
>the next host-to-guest VMBus hv_sock packet.
>
>Note: there may be multpile incoming hv_sock packets pending in the

s/multpile/multiple

>VMBus channel's ringbuffer, but so far there is not a VMBus API that
>allows us to know all the readable bytes in total without reading and
>caching the payload of the multiple packets, so let's just return the
>readable bytes of the next single packet. In the future, we'll either
>add a VMBus API that allows us to know the total readable bytes without
>touching the data in the ringbuffer, or the hv_sock driver needs to
>understand the VMBus packet format and parse the packets directly.
>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>---
> net/vmw_vsock/hyperv_transport.c | 17 ++++++++++++++---
> 1 file changed, 14 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index 31342ab502b4fc35feb812d2c94e0e35ded73771..432fcbbd14d4f44bd2550be8376e42ce65122758 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -694,15 +694,26 @@ static ssize_t hvs_stream_enqueue(struct vsock_sock *vsk, struct msghdr *msg,
> static s64 hvs_stream_has_data(struct vsock_sock *vsk)
> {
> 	struct hvsock *hvs = vsk->trans;
>+	bool need_refill;
> 	s64 ret;
>
> 	if (hvs->recv_data_len > 0)
>-		return 1;
>+		return hvs->recv_data_len;
>
> 	switch (hvs_channel_readable_payload(hvs->chan)) {
> 	case 1:
>-		ret = 1;
>-		break;
>+		need_refill = !hvs->recv_desc;
>+		if (!need_refill)
>+			return -EIO;
>+
>+		hvs->recv_desc = hv_pkt_iter_first(hvs->chan);
>+		if (!hvs->recv_desc)
>+			return -ENOBUFS;
>+
>+		ret = hvs_update_recv_data(hvs);
>+		if (ret)
>+			return ret;
>+		return hvs->recv_data_len;
> 	case 0:
> 		vsk->peer_shutdown |= SEND_SHUTDOWN;
> 		ret = 0;
>
>-- 
>2.34.1
>


