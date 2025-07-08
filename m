Return-Path: <netdev+bounces-204923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C69AFC8D8
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 12:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7371BC33EB
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA8D2C327D;
	Tue,  8 Jul 2025 10:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWg6xLdo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781242C374B
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971790; cv=none; b=NGo09pWUEXUXwZJ4jiVDNDEcZpUJ900Mzq0O3tA7rH9MMfnHKyQJMANPJGMV9UJeK8wI5pLgX7wStNNvwB9FjEwbSIteUgZA/pdGRE3B/CQnLT6V/fxypxpqp0womnvyUGJ1K93pCtnGNVM36hv4h0q+EbOYK1zOHH5BAMyS6pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971790; c=relaxed/simple;
	bh=O7wwD7eSFM539CC00ixDKAsR7sbvVfXkvwV0BcTBHvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsyqL+fClxF7OPFbSoRt1ej3JBq7TTXLe+uu/GsWyKoFcQGYca7PyUA7A4grFl24aAqGel8b1ZWqC7096iddiHQ2G/fi/6w4h1nIZXY13aHcWD2RohOrM5exu5CGRC1BXY7tIGxgyP2UkzDujnEgRvE0RYg5qhBQ5UckkrT/B54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWg6xLdo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751971787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5iL4j1/i/5cwMCBnyJHYMariApq+4KsGPMs67Fmf6qo=;
	b=BWg6xLdoRbxP4T3tJhhEp46STTZMqBYI/kuPElw5vu1e5Q8f45HcRfffvVXmJxo7GJ+6tE
	wyOfMHdGsdOFn+ru36ViKjE2qzXYeBnZEFSg2IXuRXT36x19r2rgt77VGE/DgJlV9wAtJ0
	YfO1reIm7XQciw4/CU+pSCPbrOQL3Vw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-b4ZubaNDNOurmKynoM-PMA-1; Tue, 08 Jul 2025 06:49:46 -0400
X-MC-Unique: b4ZubaNDNOurmKynoM-PMA-1
X-Mimecast-MFC-AGG-ID: b4ZubaNDNOurmKynoM-PMA_1751971786
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4a587c85a60so85409301cf.2
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 03:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751971786; x=1752576586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iL4j1/i/5cwMCBnyJHYMariApq+4KsGPMs67Fmf6qo=;
        b=G5x1HAN5uVfQ18p1P23x6TH8g4y2bI4e/21YBmmoTc1lYg2p2YHJ/i0xqSfXA19uAR
         R/KDkhPlneBjlgijEjDq44UKYMN767M7y4SHy6jJCPiWINEhYfgd9Au+CEsBnSnXuMMm
         XPAYFiR+C79rNbZJW/lmGFLcD8xRz3Uzgj7/j6RDuxckJSyt6569yN0Uw7s8fG6BhEB2
         j9rNKWqlkLFaJOfkAVF3EKp1iqvpM5Jh9kRQw9HvunS3PhJKxmjFStsrah1ULcuH0dCu
         /dsc73yhoCy+icbjo9dozmiCsZ12/oZaIrD/XbmirbthhVES1iRTF9dNQwkIfv3hLWi+
         56yg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ+HR/Ztqnbv/L3oKnoOjHQ1o9WVvdAnH2l7AdhbR+bRkiulWYW1kfjvUQ18FFeN04afOGwtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyanIs7mCdv+/6oilXOhxmdTWHs9YC8oFpmcd0BSLwq7q+8U8Cs
	PpbuAkputqji9aeMyMnlLvMNWsXrUt7Sh29IJWOmOEcDC3m+bEyR/1yWx58T7G8ASKyHZFdLtkj
	T6snXFm6MjTUAt3y42l/TUU7EaL7lAqZz6vmBEQaLfsoJBE+Q3nIkzREV+A==
X-Gm-Gg: ASbGncvDJDxQMWY/Rb3Ipp1Xgfu8sjKc1T4yA+HVi2wAbzt9w0d6euu/RCOZoCded+k
	SCrVtl2me+YWOE0WuGEcP70Xh7v2lBm7XCeuKdzenUG0NmSqgRTu0FkeL/n65BrdEhSOpiT9SIV
	quhqCdus3ThQDuFdjIdmwEtrOLnR+3JnSVpAEURuSmIrGNM0MAJeSzHgOjLNwv0wDfy3GpjOGRx
	1rfNXz7Zr9Chgumsgwo+BEwQMdFegL8ncZQg+vqmS6LwUax137otsVVvTWAv8RbWNSN+jgpGhgN
	w8ADIQsxTqCwhYxO0aMmxV+4uM5p
X-Received: by 2002:a05:622a:d07:b0:4a7:6e08:6294 with SMTP id d75a77b69052e-4a9cdeeddf0mr40374041cf.19.1751971785754;
        Tue, 08 Jul 2025 03:49:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhYlU0uqUvfcleoNVAAhyRWfQZX9q6ookm+/i8X2MtWsxRCFgVRxkOKlEb0p2JpI6O3Qdagg==
X-Received: by 2002:a05:622a:d07:b0:4a7:6e08:6294 with SMTP id d75a77b69052e-4a9cdeeddf0mr40373621cf.19.1751971785234;
        Tue, 08 Jul 2025 03:49:45 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.147.103])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994a8e527sm78690641cf.67.2025.07.08.03.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 03:49:44 -0700 (PDT)
Date: Tue, 8 Jul 2025 12:49:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, niuxuewei97@gmail.com
Subject: Re: [PATCH net-next v6 1/4] hv_sock: Return the readable bytes in
 hvs_stream_has_data()
Message-ID: <o2u6lj6m7ro73vmza4zlrwwlvonjzkgdtd4xxrjn57xpa2lmpb@yik2rrzp2sos>
References: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
 <20250708-siocinq-v6-1-3775f9a9e359@antgroup.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250708-siocinq-v6-1-3775f9a9e359@antgroup.com>

On Tue, Jul 08, 2025 at 02:36:11PM +0800, Xuewei Niu wrote:
>From: Dexuan Cui <decui@microsoft.com>
>
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
>Note: there may be multiple incoming hv_sock packets pending in the
>VMBus channel's ringbuffer, but so far there is not a VMBus API that
>allows us to know all the readable bytes in total without reading and
>caching the payload of the multiple packets, so let's just return the
>readable bytes of the next single packet. In the future, we'll either
>add a VMBus API that allows us to know the total readable bytes without
>touching the data in the ringbuffer, or the hv_sock driver needs to
>understand the VMBus packet format and parse the packets directly.
>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> net/vmw_vsock/hyperv_transport.c | 17 ++++++++++++++---
> 1 file changed, 14 insertions(+), 3 deletions(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

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


