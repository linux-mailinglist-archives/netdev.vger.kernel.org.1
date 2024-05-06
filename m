Return-Path: <netdev+bounces-93662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC478BCA71
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 11:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328A51C20A2D
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 09:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9521422AC;
	Mon,  6 May 2024 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUCXW6lJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD371422BF
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714987264; cv=none; b=T4MKOA7nm0z37f0kaNpBsx5vkR48YUnUXRpqJy+77YVwcst9a3ZIM0apxuGvW3bZsH30fWZMcYHgnFHTJDR2DTTLcbs4ycoXmyToJjuaWK7P5Wut4M6YG53fQDlxtSFWUsBWagj1lHD5Uah/WlY/iaHaFZJhLd4R0HaYblQA6RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714987264; c=relaxed/simple;
	bh=Fha3yZLMfegqZTn/ElYbMFd4SvNFbiaVHb5N+V7JS8w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JgoJ76lnyWGyQj2rKpoxBzEH/tbtT5/feomW2wi01b/FFdiPyFq6aC7RYWZv/ZWJ1B88OmR2+FfdAsBOPWjd28jDOIA80NRJav/MP6LShabJ/tKiQICBwLYsi5zgVVDvkjloqRz3VC+IPO2rqn9SPJw5m7/FSabEGDu4D8uH52A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JUCXW6lJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714987261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dngaRH2esdrOLjwhkO76jT6lhIbdwVJ9Ca4vlBwXO8M=;
	b=JUCXW6lJ/aZcBPEEEt8a3rAsVEiEH+yWYnaw/hFlrY9ygrvESTtVQeSN05EQBoAV6UpaKJ
	7nDuqFsEobAc5lGTGaHTQqNjlaLgY0ShuQGw+kM7i0d5jLnceHoVRDhf8Ox0gkgX9rPixC
	sKGmyqT8vATvid70hpvfvZmz+A77CIg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-EbkB1JhFOWmCvFvAehNuBQ-1; Mon, 06 May 2024 05:20:59 -0400
X-MC-Unique: EbkB1JhFOWmCvFvAehNuBQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2e2288e5aebso2077261fa.3
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 02:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714987258; x=1715592058;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dngaRH2esdrOLjwhkO76jT6lhIbdwVJ9Ca4vlBwXO8M=;
        b=oIlaMDWOlzwHO/as7uuvLP+jHJh6W7XITcHUK6k7XWVgu4FzaTbmIG1edGPME2TRtg
         IDXCb5F0JzrHCoaL38edgSx6p46Y3KaBilRKYCyX7vaH9mxZgLenG4iouWB0Zv+6ZRT1
         27wCEatoCqlXjgFXLXlR1PKwbt/lpJaEtbR/ZFQY7tFWb/WexiwJZGWati80BN/Ccx3v
         Gnz4rY5otnEFDzUaxWdgo0e823IuwwGW+KbX9Xumk6obNB4NnytNfVEpaKv2lshHXkR/
         ScIVuG/kcKVzZPKu2/dgxu9w64+XXmDYSSDJHspvWKxBhFar7TpN41C89Cl21GENemV3
         KnyA==
X-Forwarded-Encrypted: i=1; AJvYcCUqeZLQ6mOF1ulNNy+MYB7TxBS9d0zY1X7ID3cAA/9LwFTaLm/5gRF+VYNnt9wFMP4A8MGo9od1xneUqwJZsPzYaeqObZbb
X-Gm-Message-State: AOJu0YyVxt1pMiYO1VzVpmEFFq/j5mnJr1RNZKbyVT42zYBtk9FYyuR2
	YZmwnns9+2dGTD0aYKW6/NazVuY2I/sfNcGzh0fjmPBEhvSGfh3GDrg1ZAfoqbEzJcRb2TOLfrA
	w+BY40phOhkChlGa3geZoWJ6eXH4G2l5QhG5iS4Gy/8GNvoJesI8k1Q==
X-Received: by 2002:a05:6512:28a:b0:51f:6b63:75a6 with SMTP id j10-20020a056512028a00b0051f6b6375a6mr5996549lfp.0.1714987257898;
        Mon, 06 May 2024 02:20:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdST0J6yVwiyxLUm9R/dFrBa98KnsNsBnAMimjt/z4ZFTxRa1KlFChs8/em57Im+iBxMgIxw==
X-Received: by 2002:a05:6512:28a:b0:51f:6b63:75a6 with SMTP id j10-20020a056512028a00b0051f6b6375a6mr5996535lfp.0.1714987257378;
        Mon, 06 May 2024 02:20:57 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b09b:b810:c326:df35:5f81:3c32])
        by smtp.gmail.com with ESMTPSA id jq10-20020a05600c55ca00b0041a63354889sm13320266wmb.1.2024.05.06.02.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 02:20:56 -0700 (PDT)
Message-ID: <bde7b5c39b19cbc6e32a92b94e731d26a8d47922.camel@redhat.com>
Subject: Re: [PATCH net-next v4 4/6] net: tn40xx: add basic Rx handling
From: Paolo Abeni <pabeni@redhat.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org
Cc: andrew@lunn.ch, kuba@kernel.org, jiri@resnulli.us, horms@kernel.org
Date: Mon, 06 May 2024 11:20:55 +0200
In-Reply-To: <20240501230552.53185-5-fujita.tomonori@gmail.com>
References: <20240501230552.53185-1-fujita.tomonori@gmail.com>
	 <20240501230552.53185-5-fujita.tomonori@gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


On Thu, 2024-05-02 at 08:05 +0900, FUJITA Tomonori wrote:
> +static struct tn40_rx_page *tn40_rx_page_alloc(struct tn40_priv *priv)
> +{
> +	struct tn40_rx_page *rx_page =3D &priv->rx_page_table.rx_pages;
> +	int page_size =3D priv->rx_page_table.page_size;
> +	struct page *page;
> +	gfp_t gfp_mask;
> +	dma_addr_t dma;
> +
> +	gfp_mask =3D GFP_ATOMIC | __GFP_NOWARN;
> +	if (page_size > PAGE_SIZE)
> +		gfp_mask |=3D __GFP_COMP;
> +
> +	page =3D alloc_pages(gfp_mask, get_order(page_size));
> +	if (likely(page)) {

Note that this allocation schema can be problematic when the NIC will
receive traffic from many different streams/connection: a single packet
can keep a full order 4 page in use leading to overall memory usage
much greater the what truesize will report.

See commit 3226b158e67c. Here the under-estimation could fair worse.

Drivers usually use order-0 or order-1 pages.

[...]
> +static void tn40_recycle_skb(struct tn40_priv *priv, struct tn40_rxd_des=
c *rxdd)
> +{

Minor nit: the function name is confusing, at it does recycle in
internal buffer, not a skbuff.

Cheers,

Paolo


