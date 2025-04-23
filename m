Return-Path: <netdev+bounces-185221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6824CA99576
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 18:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01DA91885F90
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 16:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8259B284694;
	Wed, 23 Apr 2025 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+3rX2Qe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F8F17B421
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426093; cv=none; b=LrtgcLOZaH/tXsVMPQB2ncFSIsFHajVQDiWhkWU54NsWBFKTqWd0w1G6ILqhULiT0GTCn2Dftfa9QtG2jf1R6s8hjfUPQpXuH00Kw8+5NOkv6IPi1AhkQO3j59cucAxzrD7xfPAM7nGIo3lSR2lQW30aAK05j7DQZOJ8NaEAExk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426093; c=relaxed/simple;
	bh=bXXIovlNwDDSL/qXa0t+pqlwF7YhlNYF0hxtdu3MOBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bgwxm8QHoninLOj9oqlCWwC4Ah2VgsUa2eTwXr58C8RbMChLUeg2rFxuq9aKnw61zBL6quCwMvdWyQg/de2i7LDU7f/Gkz2vanHJ4M2vEPQKN8A8PSS94OJ/SKShgRheqRamRwDjPZB4HBTZOtdcZgp9if6QKgBjd11fqTmErIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+3rX2Qe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745426088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hX0ZWPxzqOkirz1sKOlbutSepxCMmH8RyV6IiHrCUKw=;
	b=Z+3rX2QefkFffHArhOLlyRXdk6WtDqigqAz5CQm1wGN9QWFV8/PAiScQNW2pU0M4uuUQnC
	821qYp9MB2o7bu/xNmAHIqTgDj3JN2Tj3vTcFZjmwJ++ly12OxEEW+tYkN1daEFFXRQHNd
	TwyNwIZEdU02SYFNse+3MlSnlZQJ56U=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-GZNi6YfTMwmBGFlipNcmXQ-1; Wed, 23 Apr 2025 12:34:32 -0400
X-MC-Unique: GZNi6YfTMwmBGFlipNcmXQ-1
X-Mimecast-MFC-AGG-ID: GZNi6YfTMwmBGFlipNcmXQ_1745426070
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5e2a31f75so5028585a.1
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 09:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745426070; x=1746030870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hX0ZWPxzqOkirz1sKOlbutSepxCMmH8RyV6IiHrCUKw=;
        b=QUp8HOrhbrHW5Uud8u6xbgfMr2X7OhvYLtDXw9C7XGdFAT65hh3t/MYXdckCAYr2Aq
         6/E84lqhVMIV5aYwjIxeSFKrluNFxRiYSTq58akVG58uvRK0bdc/Vd7XD/nCRY6hmuNB
         RSGg0d/hFFbUAfKtyLGox+nTVaIqonkeIGgrrRYP0fZffn30DJpn5xkr60DcGfk/yuYZ
         0eTKot9H2vIZJ4LEH4/934VmM5mUxe9sfunJnupkbvIWkMtdTiDTltUTUoYn7F0oBhgL
         q2fuEx4cvpy+ImgIfbwKpMncUs2RsmNAtX9yeeVBBhYWsddFIhQkvjwzfuvQHCMf3swc
         R4gg==
X-Forwarded-Encrypted: i=1; AJvYcCWHvWKsF1aPTMpfYQmD83hFrwH3Rec5GaRbwqeNa0G+3E9Uitv9GqfySwjKg7hfSGfa/vB1gY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrnNNOwCch6PdNOKuPOS6dSH561zNO4wx+RtpJXpZnPdJ553CA
	4nBZEVtKArCOBVe9bIOOrhmWkglVvLc4QIcKQ+b6EyqEB2L/6LNRtny7dXTXGA07IWAHiTvIGOG
	Kq8LZ6ZeL6erSCJfYSrvVs7wcTIbLnxaaZkoAH/51hRkd6Mf5Bc2VEA==
X-Gm-Gg: ASbGnctZvOk2Kusn27M31PfFjRiw5UzQRRMYWtjT8/h4eBegjprd4FpIboyQnFieUE2
	M90j8Niur/QFvKmBoUGygya+O0kal81PmGJ1ZQ8OWPt25d5R0iSGpvyUyNUyU/l0LikZTclZF7z
	KtVGmOOnrhgxIgyO2JB298BJ/K8acl89lJIFcvwf5xY+lhqBW5wa2tD4riJbfOkkzQcl6qhKdor
	PPvHcpDxkr/+MH4dEbL8C58+BWJgY4/OvtFmt1msmfuGaCvtCXJNpKqXNqzDFZcfelRImicgKd9
	c0V9lmOG4gFxNMos+w==
X-Received: by 2002:a05:620a:28d0:b0:7c5:6df2:b7a5 with SMTP id af79cd13be357-7c927fa2b71mr3166544685a.29.1745426070347;
        Wed, 23 Apr 2025 09:34:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/i+wfr+aLg9YJcmFsbtb0FZaYC+Ua4737Sifb8T35B0q4/iqB5jGvO/7HQVtCV2sdLcI6OQ==
X-Received: by 2002:a05:620a:28d0:b0:7c5:6df2:b7a5 with SMTP id af79cd13be357-7c927fa2b71mr3166538685a.29.1745426069796;
        Wed, 23 Apr 2025 09:34:29 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.206.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b69579sm700021485a.91.2025.04.23.09.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 09:34:29 -0700 (PDT)
Date: Wed, 23 Apr 2025 18:34:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>, Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] vsock: Linger on unsent data
Message-ID: <k47d2h7dwn26eti2p6nv2fupuybabvbexwinvxv7jnfbn6o3ep@cqtbaqlqyfrq>
References: <20250421-vsock-linger-v2-0-fe9febd64668@rbox.co>
 <20250421-vsock-linger-v2-1-fe9febd64668@rbox.co>
 <km2nad6hkdi3ngtho2xexyhhosh4aq37scir2hgxkcfiwes2wd@5dyliiq7cpuh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <km2nad6hkdi3ngtho2xexyhhosh4aq37scir2hgxkcfiwes2wd@5dyliiq7cpuh>

On Wed, Apr 23, 2025 at 05:53:12PM +0200, Luigi Leonardi wrote:
>Hi Michal,
>
>On Mon, Apr 21, 2025 at 11:50:41PM +0200, Michal Luczaj wrote:
>>Currently vsock's lingering effectively boils down to waiting (or timing
>>out) until packets are consumed or dropped by the peer; be it by receiving
>>the data, closing or shutting down the connection.
>>
>>To align with the semantics described in the SO_LINGER section of man
>>socket(7) and to mimic AF_INET's behaviour more closely, change the logic
>>of a lingering close(): instead of waiting for all data to be handled,
>>block until data is considered sent from the vsock's transport point of
>>view. That is until worker picks the packets for processing and decrements
>>virtio_vsock_sock::bytes_unsent down to 0.
>>
>>Note that such lingering is limited to transports that actually implement
>>vsock_transport::unsent_bytes() callback. This excludes Hyper-V and VMCI,
>>under which no lingering would be observed.
>>
>>The implementation does not adhere strictly to man page's interpretation of
>>SO_LINGER: shutdown() will not trigger the lingering. This follows AF_INET.
>>
>>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>---
>>net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++--
>>1 file changed, 11 insertions(+), 2 deletions(-)
>>
>>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>index 7f7de6d8809655fe522749fbbc9025df71f071bd..aeb7f3794f7cfc251dde878cb44fdcc54814c89c 100644
>>--- a/net/vmw_vsock/virtio_transport_common.c
>>+++ b/net/vmw_vsock/virtio_transport_common.c
>>@@ -1196,12 +1196,21 @@ static void virtio_transport_wait_close(struct sock *sk, long timeout)
>>{
>>	if (timeout) {
>>		DEFINE_WAIT_FUNC(wait, woken_wake_function);
>>+		ssize_t (*unsent)(struct vsock_sock *vsk);
>>+		struct vsock_sock *vsk = vsock_sk(sk);
>>+
>>+		/* Some transports (Hyper-V, VMCI) do not implement
>>+		 * unsent_bytes. For those, no lingering on close().
>>+		 */
>>+		unsent = vsk->transport->unsent_bytes;
>>+		if (!unsent)
>>+			return;
>
>IIUC if `unsent_bytes` is not implemented, virtio_transport_wait_close 
>basically does nothing. My concern is that we are breaking the 
>userspace due to a change in the behavior: Before this patch, with a 
>vmci/hyper-v transport, this function would wait for SOCK_DONE to be 
>set, but not anymore.

Wait, we are in virtio_transport_common.c, why we are talking about 
Hyper-V and VMCI?

I asked to check `vsk->transport->unsent_bytes` in the v1, because this 
code was part of af_vsock.c, but now we are back to virtio code, so I'm 
confused...

Stefano

>
>>
>>		add_wait_queue(sk_sleep(sk), &wait);
>>
>>		do {
>>-			if (sk_wait_event(sk, &timeout,
>>-					  sock_flag(sk, SOCK_DONE), &wait))
>>+			if (sk_wait_event(sk, &timeout, unsent(vsk) == 0,
>>+					  &wait))
>>				break;
>>		} while (!signal_pending(current) && timeout);
>>
>>
>>-- 2.49.0
>>
>
>Thanks,
>Luigi
>


