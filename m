Return-Path: <netdev+bounces-67198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7488884250B
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 13:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3521F26ED3
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 12:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11596A00C;
	Tue, 30 Jan 2024 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xlu32ACb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA61845BE7
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618253; cv=none; b=gKxyxHuRckOYAaT6CBH+2yzouBpTwPQoKH/a396ZFRtAN3Fo1byvUbWZ4EFqFwXrSVZXdaJdawe480YMeClCa/Qy9fzOF81Cx9fK944nMt1eqHCostssLkVDxNy5u8Xb7hey8e/Cp63bRelMrqZuqOtRVdGoJptbn1yODXq0+oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618253; c=relaxed/simple;
	bh=WKutTQq7GhOznoLwWC8bXoi3pIYHOUJrFoQCgiKfxEI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hN3qnt9Sa7Ybyu+8yluQlsNLMlbbRuiVfyaIhI/0fpVl2j8l1jMJGmGpMVWVv5bSAaG6fYbCWeeG3BLM9CCe1b4l8fALE4tQToyDvs6eR+OGerl2nZoonAqWRHzB5dO0Tl0PYSrIVvp2c5T44CaEuau2K7NHMujik0yVMA0k04o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xlu32ACb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706618250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0uAK0cmwppnHT4k7baIapXnRLl+447BDGm+lwiII50w=;
	b=Xlu32ACbFKFfFHBHeQ8MBRP6G4FBnu16wRJrjgeYin96MmbxhwFSm890HwgXcGGzxA39Ht
	dMjiQlwT5SDf3zNSHyXlb1X5sE5UKqawbPlb+rRzZccSBIMImXOogA6/j+0N+vfjqo7dTo
	ntFvtpVsBUM2fqZkjQVx0y3hG9AEtS4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-M5L7KFc2PlmeGbI_bF1tng-1; Tue, 30 Jan 2024 07:37:29 -0500
X-MC-Unique: M5L7KFc2PlmeGbI_bF1tng-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40ef6441d1aso4816545e9.0
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 04:37:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618248; x=1707223048;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0uAK0cmwppnHT4k7baIapXnRLl+447BDGm+lwiII50w=;
        b=GbtH4vqtUFj975KYRDiNJ8fa643qgK2rzJQwmAKxuh3scuQj5aXN5tC0pZ6lUVLxv8
         KX6NdMfLhh0zLjayELzw55ucvbVkrWV4LSS1L0f1fGz8+Fp+TK1AOkaJdxvPWLk6ZSx9
         M0q2ZJG1KxU3KNktYjKaX12FYgvmFev+iqQ6NmQEOz4bAOVDCBBMHbqOPQKwBS1nH25w
         TyOBU5b2Q20r5+REyGuR1iTlZXESTjBnT7HwEa9rHpfj+GED7EzkhUI2AnIzkL8xu5rT
         8y+AleWRNSv5Zf7X6wIc4N23hZb5ovc6HMuUtgiMuCrNliT7P8z6fy1sbF90U6uZdxyM
         9YXA==
X-Forwarded-Encrypted: i=0; AJvYcCWesoFbRshbSOMCJLF46f+YtTmzEYgXAJPGE3871Nd9va+M/yZYRLgLughkt6NqWbeHdWNmjSHAmkUlsFDKFqCIkP65gu2N
X-Gm-Message-State: AOJu0YxF/VWo/UAVTFYioB03rx1aYw1RBeGJ6IeBivIvWcTqOTFHhjOY
	Oj7+AC4k0dZj0BScipqcNqW9XOZERQ07LzT2EdX8bxH2G/hGeyvNvWQAwgaZSs9w+0vcS1jigAO
	KW+/15OJDlW5RKDUFHEfBbpjBy6z7sV7zBb/MVxJZSv+6qMA3zF1z2A==
X-Received: by 2002:adf:9b96:0:b0:33a:e605:57b9 with SMTP id d22-20020adf9b96000000b0033ae60557b9mr5853585wrc.3.1706618247889;
        Tue, 30 Jan 2024 04:37:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIaYCb9zGo00tPYm5nNmgztVlI+ozRaq0I9WLZDPvRlENagGs+1jjQRcrkHhcuFLe+133lwg==
X-Received: by 2002:adf:9b96:0:b0:33a:e605:57b9 with SMTP id d22-20020adf9b96000000b0033ae60557b9mr5853574wrc.3.1706618247508;
        Tue, 30 Jan 2024 04:37:27 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-232-203.dyn.eolo.it. [146.241.232.203])
        by smtp.gmail.com with ESMTPSA id e10-20020adfe38a000000b0033afcc069c3sm1176599wrm.84.2024.01.30.04.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:37:27 -0800 (PST)
Message-ID: <757018c2d9bd235cd2dad4363fb9a54354c9a372.camel@redhat.com>
Subject: Re: [PATCH net] ps3/gelic: Fix SKB allocation
From: Paolo Abeni <pabeni@redhat.com>
To: Geoff Levand <geoff@infradead.org>, sambat goson <sombat3960@gmail.com>,
  Christophe Leroy <christophe.leroy@csgroup.eu>, "David S. Miller"
 <davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Date: Tue, 30 Jan 2024 13:37:25 +0100
In-Reply-To: <1f5ffc7d-4b2e-4f07-bc7e-97d49ccff28c@infradead.org>
References: <1f5ffc7d-4b2e-4f07-bc7e-97d49ccff28c@infradead.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Fri, 2024-01-26 at 18:25 +0900, Geoff Levand wrote:
> Commit 3ce4f9c3fbb3 ("net/ps3_gelic_net: Add gelic_descr structures")
> of 6.8-rc1 did not set up the ps3 gelic network SKB's correctly,
> resulting in a kernel panic.
>    =20
> This fix changes the way the napi buffer and corresponding SKB are
> allocated and managed.
>    =20
> Reported-by: sambat goson <sombat3960@gmail.com>
> Fixes: 3ce4f9c3fbb3 ("net/ps3_gelic_net: Add gelic_descr structures")
> Signed-off-by: Geoff Levand <geoff@infradead.org>

The patch overall looks correct to me, but there are a few formal
issues worthy to be addressed, see below.

>=20
> diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/e=
thernet/toshiba/ps3_gelic_net.c
> index d5b75af163d3..1870f173e850 100644
> --- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> +++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> @@ -375,20 +375,16 @@ static int gelic_card_init_chain(struct gelic_card =
*card,
>  static int gelic_descr_prepare_rx(struct gelic_card *card,
>  				  struct gelic_descr *descr)
>  {
> -	static const unsigned int rx_skb_size =3D
> -		ALIGN(GELIC_NET_MAX_FRAME, GELIC_NET_RXBUF_ALIGN) +
> -		GELIC_NET_RXBUF_ALIGN - 1;
> +	static const unsigned int napi_buff_size =3D
> +		round_up(GELIC_NET_MAX_FRAME, GELIC_NET_RXBUF_ALIGN);
> +

No empty line in the declaration area.

> +	struct device *dev =3D ctodev(card);
>  	dma_addr_t cpu_addr;
> -	int offset;
> +	void *napi_buff;
> =20
>  	if (gelic_descr_get_status(descr) !=3D  GELIC_DESCR_DMA_NOT_IN_USE)
> -		dev_info(ctodev(card), "%s: ERROR status\n", __func__);
> +		dev_info(dev, "%s: ERROR status\n", __func__);
> =20
> -	descr->skb =3D netdev_alloc_skb(*card->netdev, rx_skb_size);
> -	if (!descr->skb) {
> -		descr->hw_regs.payload.dev_addr =3D 0; /* tell DMAC don't touch memory=
 */
> -		return -ENOMEM;
> -	}
>  	descr->hw_regs.dmac_cmd_status =3D 0;
>  	descr->hw_regs.result_size =3D 0;
>  	descr->hw_regs.valid_size =3D 0;
> @@ -397,24 +393,33 @@ static int gelic_descr_prepare_rx(struct gelic_card=
 *card,
>  	descr->hw_regs.payload.size =3D 0;
>  	descr->skb =3D NULL;
> =20
> -	offset =3D ((unsigned long)descr->skb->data) &
> -		(GELIC_NET_RXBUF_ALIGN - 1);
> -	if (offset)
> -		skb_reserve(descr->skb, GELIC_NET_RXBUF_ALIGN - offset);
> -	/* io-mmu-map the skb */
> -	cpu_addr =3D dma_map_single(ctodev(card), descr->skb->data,
> -				  GELIC_NET_MAX_FRAME, DMA_FROM_DEVICE);
> -	descr->hw_regs.payload.dev_addr =3D cpu_to_be32(cpu_addr);
> -	if (dma_mapping_error(ctodev(card), cpu_addr)) {
> -		dev_kfree_skb_any(descr->skb);
> +	napi_buff =3D napi_alloc_frag_align(napi_buff_size,
> +		GELIC_NET_RXBUF_ALIGN);

Please align with the above bracket:

	napi_buff =3D napi_alloc_frag_align(napi_buff_size,
					  GELIC_NET_RXBUF_ALIGN);

> +
> +	if (unlikely(!napi_buff)) {
> +		return -ENOMEM;
> +	}

The brackets are not needed here.

> +
> +	descr->skb =3D napi_build_skb(napi_buff, napi_buff_size);
> +
> +	if (unlikely(!descr->skb)) {
> +		skb_free_frag(napi_buff);
> +		return -ENOMEM;
> +	}
> +
> +	cpu_addr =3D dma_map_single(dev, napi_buff, napi_buff_size,
> +		DMA_FROM_DEVICE);

Please align with the above bracket

> +
> +	if (dma_mapping_error(dev, cpu_addr)) {
> +		skb_free_frag(napi_buff);
>  		descr->skb =3D NULL;
> -		dev_info(ctodev(card),
> -			 "%s:Could not iommu-map rx buffer\n", __func__);
> +		dev_err_once(dev, "%s:Could not iommu-map rx buffer\n",
> +			__func__);

Same here.

Side note: as a nice net-next follow-up you could move the skb
allocation into gelic_net_pass_skb_up() - so that the skbuff is hot in
the cache at rx time.


Cheers,

Paolo


