Return-Path: <netdev+bounces-207467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F21B0777F
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 15:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999E8A416E4
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 13:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750A41FCFEE;
	Wed, 16 Jul 2025 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYgKGcO7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FAF1EF0B9
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752674366; cv=none; b=EhUk6rfIVvwp40UhjuoSWpcHbcK4uUQBHcpY7P7ERDVlDKN+qYyxeO1/owzKS0dpvTH92py+1tz+5kI/x80RgFJtK2JXVB5wjzoGrIBbMY4ymOcDk7sYLYoBMvnZpJjTpeVbShyH/phpcEcMbi5jzAP3sFwE3FQ9sSO/atOdg0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752674366; c=relaxed/simple;
	bh=vHxPCtOGRmTWwUUNQPX/mlHvWm4lcQMqvFYAd3E7mz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGen4L8FR7TrOl0CLuv/YH2N/fDUO5znR5Njw01bnvP6XZZNbmlI2FIQVHRZMn7OWFaAzUpdLvR77QIlCLBaXpOO4uMHjVI/XuJO9kEPhZ1fEtgajA9pKgvQ3jsSmLVx6b0GyfDoQCismAn1ydX9Je0qrqoVvU92kfd3wozjKKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYgKGcO7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752674362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p3rw/fBA5XAemzUR/xM/HsYNQo7lSDwo1j9IVDjWp3c=;
	b=cYgKGcO7gwcpAXwsoszfY+KrL/FDNSAmUZstrsFXEv/Snuvk4GMNF/svzAtMyH3d6NU4l9
	5tiJjjWlyLnSlAd2ctYCqeLKwH+7QcKPKToFhU54xmkc7caSBBbKKxXp4gwM5q6lwDuOLM
	dpMYzXKFFyLpKZ/3Axf9S+pO5USMmto=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-ms-KkBWrM0OBDRxHvSL2eA-1; Wed, 16 Jul 2025 09:59:21 -0400
X-MC-Unique: ms-KkBWrM0OBDRxHvSL2eA-1
X-Mimecast-MFC-AGG-ID: ms-KkBWrM0OBDRxHvSL2eA_1752674360
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-453817323afso41725065e9.1
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 06:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752674359; x=1753279159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3rw/fBA5XAemzUR/xM/HsYNQo7lSDwo1j9IVDjWp3c=;
        b=hSTu/WQbyYOlcM1tMwPi3hJMaKttyfWTf/QNuYJnXUZsIFVazb8RaMfYl9J6RpzG6U
         ASqBcjQ5BcQwrNZ2z6vR5RYx+2DAT2rbmp2nwvwSND2EcmOcaV1R5qOVSC/fYDxBP05n
         hFVGPaLLi1Qp4X52z/HgjFyNLra1X2/C3J8yNYfKTZQ5VqkkekRvStxEFOkP0R3+A+SI
         OzuZ6xD809F2S5yjnesYwFaReY+x6R/JlCZTG0DSpo3Qd4KQSw+sMYKGZmRBlKA6XP21
         wuEg6shOnKOMl/Gjed97HEpCvjRdB6zzhhyE9RqaD6m5In9fyQRiCPqIi0MBYiHGYQhr
         7dbg==
X-Gm-Message-State: AOJu0Yy+gUITqjtDrqUkbJ1H8n14Nbay07Uwn8SRmQCOxRrIvxL9BMhK
	9G8tniQfgvYE2WggAedt50wsRnVzJIIcqZ8it/hptHCyhpAPlSWrxaJdToL4rVr7MJsnUmURbog
	75uzRyFvRiAaijVeXX9Pqc02GPhcTb1gv+4jMsZDffnjM++GRe7YM1OTNS6zF07WqFw==
X-Gm-Gg: ASbGncsXw2SQdf1Ulb08EjEGLH/dfpQvgiBMcJYFvEINTB8mTGjGtfQhG0D4kXSNwZM
	SpqmXNLmL1eIJFUxWPezLRMKYDuf0KZcfforn2upftxQ9C0u87g6ftnui3UYJz0KcYrFGf23Bc8
	JbetvbsFM/7OGTAPj7/2zgD3IleUfVccbmztUfbmDgoC0uw8NmtQCojGoLrn4DaC5lh1AxTCQbv
	sxtez0K0d1cOkXs5FiSo4yPlUynMrqMx5KK4r9bnMIhPMb5t2RLdGu2R3xxbBYksSl1AkYwD5ug
	lxvMPpXRolBXs3KEZ8xbMoRuEp2QTjFH
X-Received: by 2002:a05:600c:5246:b0:456:207e:fd86 with SMTP id 5b1f17b1804b1-4562e03bdf0mr35701055e9.2.1752674359552;
        Wed, 16 Jul 2025 06:59:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtBlIepy23CW5zO4OFRebEc+q6FcwXdViDGIwmEkFbQb1HdNuzCXykuQ+4KUs+XckpmR18SA==
X-Received: by 2002:a05:600c:5246:b0:456:207e:fd86 with SMTP id 5b1f17b1804b1-4562e03bdf0mr35700725e9.2.1752674359063;
        Wed, 16 Jul 2025 06:59:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e832dfbsm22006015e9.29.2025.07.16.06.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 06:59:18 -0700 (PDT)
Date: Wed, 16 Jul 2025 09:59:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] virtio-net: fix received length check in big
 packets
Message-ID: <20250716095850-mutt-send-email-mst@kernel.org>
References: <20250708144206.95091-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708144206.95091-1-minhquangbui99@gmail.com>

On Tue, Jul 08, 2025 at 09:42:06PM +0700, Bui Quang Minh wrote:
> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
> for big packets"), the allocated size for big packets is not
> MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
> number of allocated frags for big packets is stored in
> vi->big_packets_num_skbfrags. This commit fixes the received length
> check corresponding to that change. The current incorrect check can lead
> to NULL page pointer dereference in the below while loop when erroneous
> length is received.
> 
> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Changes in v2:
> - Remove incorrect give_pages call
> ---
>  drivers/net/virtio_net.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 5d674eb9a0f2..3a7f435c95ae 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -823,7 +823,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  {
>  	struct sk_buff *skb;
>  	struct virtio_net_common_hdr *hdr;
> -	unsigned int copy, hdr_len, hdr_padded_len;
> +	unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
>  	struct page *page_to_free = NULL;
>  	int tailroom, shinfo_size;
>  	char *p, *hdr_p, *buf;
> @@ -887,12 +887,15 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  	 * tries to receive more than is possible. This is usually
>  	 * the case of a broken device.
>  	 */
> -	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
> +	BUG_ON(offset >= PAGE_SIZE);
> +	max_remaining_len = (unsigned int)PAGE_SIZE - offset;
> +	max_remaining_len += vi->big_packets_num_skbfrags * PAGE_SIZE;
> +	if (unlikely(len > max_remaining_len)) {
>  		net_dbg_ratelimited("%s: too much data\n", skb->dev->name);
>  		dev_kfree_skb(skb);
>  		return NULL;
>  	}
> -	BUG_ON(offset >= PAGE_SIZE);
> +
>  	while (len) {
>  		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
>  		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
> -- 
> 2.43.0


