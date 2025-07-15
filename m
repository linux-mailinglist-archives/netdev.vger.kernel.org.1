Return-Path: <netdev+bounces-207044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E778B05730
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 11:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40091C22DA5
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 09:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26B72D8DC2;
	Tue, 15 Jul 2025 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJls0LXr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A552D8DA7
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573214; cv=none; b=NNTNB3rw8hrx30GSWWIsj3KbEWeKjoV1M1mpXE+uGK2YCRP5+rxPaNDLO3DU51pBukB5Hntp3m1vhrnKb4/mWrWiKgLESFdEFe5mbiL0kbqy1nEReMXACbGbOVLRKOdooXg4WKSvVLjG2XkETvBCjN3TqOCiSeEOMVCG0FquacI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573214; c=relaxed/simple;
	bh=6tGyBJtvc2RtGieTCJUc7+YbV5rIOi+F+HZmZMgrilY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaE1P53kracbLvoetuUNytz3sX1o+VSJSjV6O9hR16Gl70kO/wTOenTExTNfgPwEM8vjirDWcdFvui6yAukGFxDVwzDfaln1+vG3hYBww2slZiG7YAnE0nVRWsn1Rll+wQbpD+eZSypLYJxFvfu0R4k81hpPKtweGbyrefMuJO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iJls0LXr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752573210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4iPXF4gYG8U7aUqDfy3cGUXBvmWO/3o2DGgrJboTKas=;
	b=iJls0LXrwrwB+H0aB+Czi2O2qtBD8uZ2t0X5vXG8Xjv4+JGwZZEoMPB8SOJBXPKDTMOgiM
	U1BG6zLr0Y6n2Dws/aIGdTbqOfJoaDpzhokGxSVbRYD8q947nIaLL6+N98EnQUdIBCzRFu
	FoA8PQ6KsJN5xCkgZWmSa3ww2WSEgaw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-B0MqUUveMw6W9rIadhd8Mg-1; Tue, 15 Jul 2025 05:53:27 -0400
X-MC-Unique: B0MqUUveMw6W9rIadhd8Mg-1
X-Mimecast-MFC-AGG-ID: B0MqUUveMw6W9rIadhd8Mg_1752573207
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-704d5ca41f2so25435176d6.2
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 02:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573207; x=1753178007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iPXF4gYG8U7aUqDfy3cGUXBvmWO/3o2DGgrJboTKas=;
        b=bC9xQFS52TNY8Gwy9v6A/hF8TL7PZV//3WBQQfFeBX/7Op6Nz4u1jZcjEHm20pYVVc
         w/vaEtJWrpX5Ot7ToELvewM7ybss7ZIpC39Io1Ka5f1xa1+6YTRv3mfads56ZbV0bjt3
         6AEzUPfz/6I2EzJ1g8aZFVBwHUnY+spHFk/ZUpg0e7g2CMLZfEfRbKJVjmXJ1X0OYkVA
         r7Za3rLh7CjH+667QCd71p3Dpsi/uCDnpid8OaWL2HUFft69Auuo0BGIqZaQRjCto5mD
         MOUMc63PmYlyHyYpe7DdF1HMuQUEq7E94hRHIPQHiA7cZ2+frDZrCv+CmefjmnjpyM3V
         UcYA==
X-Forwarded-Encrypted: i=1; AJvYcCULjz3weNCeRLPfA4JMyOtyhd4GhtobQNudbFaiTrArK3Z2Leob4ymoQX2/bg2kAsTnABUeFK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV2fY3fEnUD2VGhJarhTf/d0f1eGSQkfL4pTGVP1Ya9+WYeG1E
	RVn6JT8tYhpYp+H4E3bZkCakDWwhty4NhKJdTr6ccUyJSzh2cX/wXJ4FZkc5f11ySm0lsxKINlU
	safX8txn5oaBDPLP+vrFi/deDGHj3ddnXn/vSS+GDXO2yONGexvGxxAAGnw==
X-Gm-Gg: ASbGnctmeYtl235MNjalgoTQgDL2c7E5CQcTS1RHFaCi8PaE/Sm66nO1J/5aAm/5tEN
	hxoBr+T6u/gk2OPtM6HRpbs6vOD+ZABDeHmPdxsf2SsdusTGIp+kNT8yNn43rU3E1iBGlWdlAoE
	o5N9wZ8liFHNeIzsRemGEfwy4h8i25cYFPDacYlPftB/2lNLNpDbITH70FP2NS7difxOnij0C/T
	kgdUsyZTttyzKGjxYewGvr6zjDqWEMN8q18ly29OZzKd4ou8LtyFr16mwK/L1WdT0H+9GsO+Ke/
	wyZ4ntA2NJZ9S8oM+PB9angfMbxYtBoe9TMNQWrEeA==
X-Received: by 2002:a05:6214:5c49:b0:6fa:c31a:af20 with SMTP id 6a1803df08f44-704a353d443mr226990116d6.5.1752573207206;
        Tue, 15 Jul 2025 02:53:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWPMdVgtbcgI78Os5fvtMkQsvRVpbE9a1O27Hj85Ywr6W1l9K18b6noTWD3ov2A5GOpnHzCA==
X-Received: by 2002:a05:6214:5c49:b0:6fa:c31a:af20 with SMTP id 6a1803df08f44-704a353d443mr226989786d6.5.1752573206613;
        Tue, 15 Jul 2025 02:53:26 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.142.44])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704aa850c20sm40166476d6.70.2025.07.15.02.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:53:26 -0700 (PDT)
Date: Tue, 15 Jul 2025 11:53:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/9] vsock/virtio: Validate length in packet header
 before skb_put()
Message-ID: <47gzwbsawomsgitmxcyd333k27qlwoail2k7ivwtqczbxuapyf@2gdxmlwlfsk4>
References: <20250714152103.6949-1-will@kernel.org>
 <20250714152103.6949-3-will@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250714152103.6949-3-will@kernel.org>

On Mon, Jul 14, 2025 at 04:20:56PM +0100, Will Deacon wrote:
>When receiving a vsock packet in the guest, only the virtqueue buffer
>size is validated prior to virtio_vsock_skb_rx_put(). Unfortunately,
>virtio_vsock_skb_rx_put() uses the length from the packet header as the
>length argument to skb_put(), potentially resulting in SKB overflow if
>the host has gone wonky.
>
>Validate the length as advertised by the packet header before calling
>virtio_vsock_skb_rx_put().
>
>Cc: <stable@vger.kernel.org>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> net/vmw_vsock/virtio_transport.c | 12 ++++++++++--
> 1 file changed, 10 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index f0e48e6911fc..bd2c6aaa1a93 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -624,8 +624,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 	do {
> 		virtqueue_disable_cb(vq);
> 		for (;;) {
>+			unsigned int len, payload_len;
>+			struct virtio_vsock_hdr *hdr;
> 			struct sk_buff *skb;
>-			unsigned int len;
>
> 			if (!virtio_transport_more_replies(vsock)) {
> 				/* Stop rx until the device processes already
>@@ -642,12 +643,19 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 			vsock->rx_buf_nr--;
>
> 			/* Drop short/long packets */
>-			if (unlikely(len < sizeof(struct virtio_vsock_hdr) ||
>+			if (unlikely(len < sizeof(*hdr) ||

pre-existing: in some part we use sizeof(*hdr) in other 
VIRTIO_VSOCK_SKB_HEADROOM, I think we should try to uniform that, but of 
course not for this series!

> 				     len > virtio_vsock_skb_len(skb))) {
> 				kfree_skb(skb);
> 				continue;
> 			}
>
>+			hdr = virtio_vsock_hdr(skb);
>+			payload_len = le32_to_cpu(hdr->len);
>+			if (payload_len > len - sizeof(*hdr)) {

Since this is an hot path, should we use `unlikely`, like in the 
previous check, to instruct the branch predictor?

The rest LGTM!

Thanks,
Stefano

>+				kfree_skb(skb);
>+				continue;
>+			}
>+
> 			virtio_vsock_skb_rx_put(skb);
> 			virtio_transport_deliver_tap_pkt(skb);
> 			virtio_transport_recv_pkt(&virtio_transport, skb);
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>


