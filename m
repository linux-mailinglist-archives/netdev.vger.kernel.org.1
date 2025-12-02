Return-Path: <netdev+bounces-243273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B517C9C67F
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 18:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5AD7F346961
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 17:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AE92C0279;
	Tue,  2 Dec 2025 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMjTez1E";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ia6ebyXC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850362BEFEB
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764696800; cv=none; b=FXZVCaDz5Od0nyzTWL5wrI1h0GCE37pIfXlWKZHpWW6Eo2HsCan3u8+V605+SNMKL0d8wTe1Qr5Mna+YPg7zuf1uQ6MpUr1fdFLSaXGqXaoxHxTwHSaDhqNORU/zMnziYXqdM2Izo/+g3YC60Sp+41zCTAjkYFV/BFYG+DdjtRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764696800; c=relaxed/simple;
	bh=DtizTPty4FLG/Q0RIWYMuKooIgTAqucxdweagP2QBgg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DycFLKk9xn6YMMU5vbBRyuMM+JFxQNTcrV1hggl/hQefXJsPzVdVHv44TZCVytSuC403xetCNUM8+wuR7iXfmtjqCTi4C9FzuzFv7p7qHcXlODXOF/Xom7/eANqWgXNvq+9E6KkcKEtK+HeNyR3cR7vTw9sd/BnYJvI+YnRQgAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WMjTez1E; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ia6ebyXC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764696797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GFU82GGL4oHKCPPWEIDymuHnOtBoPykaPXzCHEoqCjQ=;
	b=WMjTez1EmB3h92Pqt2yNP2NKjDRK8ZSi6U8wiIKuNqkvxQKIfoMImJpy0y3b8XNZbOqd3+
	34avFH51Rt6QVdo+U/NASAOpLTAEr7ywrWnYf/qXPkKUI5b+oGVx0xZVK8HnZZXcQvPlk0
	Iv6NtGiic0u9XFLxd8ZMsgt9M56g3Tw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-J_-OHJNHOHWzziVgIJZtGw-1; Tue, 02 Dec 2025 12:33:16 -0500
X-MC-Unique: J_-OHJNHOHWzziVgIJZtGw-1
X-Mimecast-MFC-AGG-ID: J_-OHJNHOHWzziVgIJZtGw_1764696795
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42e1e1ca008so29950f8f.0
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 09:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764696795; x=1765301595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFU82GGL4oHKCPPWEIDymuHnOtBoPykaPXzCHEoqCjQ=;
        b=ia6ebyXC1aSKZ0tHOf8rMqEdpKEyZ53gwSfC84QhjoAnSF1wjKZDN1L0v8r0Gc0y/C
         9r/iLUZ19H9CUMc2bY1qqK7HT8cvq+E/zh6sc80A+VBM7pS9BgTGnv30CB55HYb95TRD
         voTYY6etQtH22La1Q+ZGieooboNG7+WNCSzf63GSs69X/srlu8cfkWnQfIGNoX11ES1Y
         ZYKCdFTCoTtsl7pMkTrb4n6FOIrQBB412vxIxo931QWvSjNPDifjAxh3PhB9WDDZzOY9
         P99q2c2STwPeNKa2UfMn4npprp0SQPCXTm5VynRL37XPEoqvJ+9lJfvDzpbPNitFJ1iE
         CQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764696795; x=1765301595;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GFU82GGL4oHKCPPWEIDymuHnOtBoPykaPXzCHEoqCjQ=;
        b=I7+2SrF1tB2BVsLhfuHufq5E+tuO5xdqE4fnUNjvbk6b0M6nQIrTB2jBQKt2ye8nPu
         P34rXctzYMSjJ3FWBnYjlcpraeE4sSDcyE34ZnAcm6bRzwjXRhEUkvr5bpFzQQ+fpEBn
         K/XZE8JEXaPeIYceOZRnDpQeifBU9SGJztJ8fLMJXGc708QJPOE4t03ydt7CyeQpcDgM
         LZ1CskOEF+8znh8eYD+f8XOeHkkb1PByL76+hd1v7fq9Zq49eRPkLIOYXbqV5mXOT6FJ
         ep+OwgihDKtINOu4nTPJzphFFY/pAp5lnM9PxCEOAyPBtnaMcw445sxO/byJP2ik4RuP
         ZfvQ==
X-Forwarded-Encrypted: i=1; AJvYcCURlY8IRTlBQf7AZTknfDIDWsNFX/B+6ktsr3yZK2VAC4/WaGs6sIgUz0rhgVkdtXk0y33tLHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYSFXu1+WZpY0dSPQOk84nDw4t8q+2+hQ7VsFXOKL9y24fOFHc
	pEMuJWwDgsC3F7NSC3oGfi2VHnYIixWW2PnPUfFSj1/eu2K88YyeTuT3aa/MXtWIFtmcXqJ7A96
	H/k0SliQMdp08bgS3TlnibBuWo0rqKg8/aXygwxYviHUnH8BJELW4rz9oFw==
X-Gm-Gg: ASbGnctr/JdVIOu2Z8ynf+75cX+t4xztxURzcE0XEd/gr8fc/TgYgo1wktSyOS9OiWr
	JoVUTlUMoxR2SYP/hjn3dH5z8pE6tEhGpinIv4LrZMW2SSd6SzumPXayUbCL0s5MPgyWC/y2Ph0
	pepwic24DdzZ3fSID/cTna6kTzwKbhdIeghNibA9bXbkDWgdp5ADI/rGJ/7W9ZZmwaPe4FJCIb9
	Hiru41STIgdM2VIsLqaSwGDwfPXSFg+i/PVG9KkLfOtarMhyDgCxTrW8yBqBRCL2yNPSQMbI3U5
	8b1H4tLHLEOG4ZmFCeQo1jTHt8J7Njhq2iv5fFTOIiivTigM0/GipOGeAkVoMCjDn+2bPlt+D99
	xGXQdNZFJ0Q+4RtiUqhVBoXFeTSFYT5bHlmwFfmE5jbG7
X-Received: by 2002:a05:6000:61e:b0:429:eb05:1c69 with SMTP id ffacd0b85a97d-42f6313c9a6mr4053664f8f.2.1764696795104;
        Tue, 02 Dec 2025 09:33:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPM+hZn4Z4IqdyyCE2/UiT8RlKc0vv9rEDrM9bJd9WFYSr3/kM+4O2Itf1fYUVjaVR2XO0fw==
X-Received: by 2002:a05:6000:61e:b0:429:eb05:1c69 with SMTP id ffacd0b85a97d-42f6313c9a6mr4053637f8f.2.1764696794673;
        Tue, 02 Dec 2025 09:33:14 -0800 (PST)
Received: from localhost (net-5-89-201-160.cust.vodafonedsl.it. [5.89.201.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a310sm36026206f8f.26.2025.12.02.09.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 09:33:14 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>,
 netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, =?utf-8?Q?Gr=C3=A9gory?= Clement
 <gregory.clement@bootlin.com>, =?utf-8?Q?Beno=C3=AEt?= Monin
 <benoit.monin@bootlin.com>
Subject: Re: [PATCH RFC net-next 5/6] cadence: macb/gem: make tx path skb
 agnostic
In-Reply-To: <DEJK6OLX6FL7.2SV8LF9U4S0VU@bootlin.com>
References: <20251119135330.551835-1-pvalerio@redhat.com>
 <20251119135330.551835-6-pvalerio@redhat.com>
 <DEJK6OLX6FL7.2SV8LF9U4S0VU@bootlin.com>
Date: Tue, 02 Dec 2025 18:33:13 +0100
Message-ID: <87a500zt46.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27 Nov 2025 at 03:49:13 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> w=
rote:

> On Wed Nov 19, 2025 at 2:53 PM CET, Paolo Valerio wrote:
>> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/=
cadence/macb.h
>> index 2f665260a84d..67bb98d3cb00 100644
>> --- a/drivers/net/ethernet/cadence/macb.h
>> +++ b/drivers/net/ethernet/cadence/macb.h
>> @@ -964,19 +964,27 @@ struct macb_dma_desc_ptp {
>>  #define MACB_PP_HEADROOM	XDP_PACKET_HEADROOM
>>  #define MACB_MAX_PAD		(MACB_PP_HEADROOM + SKB_DATA_ALIGN(sizeof(struct =
skb_shared_info)))
>>=20=20
>> -/* struct macb_tx_skb - data about an skb which is being transmitted
>> - * @skb: skb currently being transmitted, only set for the last buffer
>> - *       of the frame
>> +enum macb_tx_buff_type {
>> +	MACB_TYPE_SKB,
>> +	MACB_TYPE_XDP_TX,
>> +	MACB_TYPE_XDP_NDO,
>> +};
>> +
>> +/* struct macb_tx_buff - data about an skb or xdp frame which is being =
transmitted
>> + * @data: pointer to skb or xdp frame being transmitted, only set
>> + *        for the last buffer for sk_buff
>>   * @mapping: DMA address of the skb's fragment buffer
>>   * @size: size of the DMA mapped buffer
>>   * @mapped_as_page: true when buffer was mapped with skb_frag_dma_map(),
>>   *                  false when buffer was mapped with dma_map_single()
>> + * @type: type of buffer (MACB_TYPE_SKB, MACB_TYPE_XDP_TX, MACB_TYPE_XD=
P_NDO)
>>   */
>> -struct macb_tx_skb {
>> -	struct sk_buff		*skb;
>> -	dma_addr_t		mapping;
>> -	size_t			size;
>> -	bool			mapped_as_page;
>> +struct macb_tx_buff {
>> +	void				*data;
>> +	dma_addr_t			mapping;
>> +	size_t				size;
>> +	bool				mapped_as_page;
>> +	enum macb_tx_buff_type		type;
>>  };
>
> Here as well, reviewing would be helped by moving the tx_skb to tx_buff
> renaming to a separate commit that has no functional change.
>
> As said in [0], I am not a fan of the field name `data`.
> Let's discuss it there.
>
> [0]: https://lore.kernel.org/all/DEITSIO441QL.X81MVLL3EIV4@bootlin.com/
>

sure

>> -static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb, =
int budget)
>> +static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff,
>> +			  int budget)
>>  {
>> -	if (tx_skb->mapping) {
>> -		if (tx_skb->mapped_as_page)
>> -			dma_unmap_page(&bp->pdev->dev, tx_skb->mapping,
>> -				       tx_skb->size, DMA_TO_DEVICE);
>> +	if (tx_buff->mapping) {
>> +		if (tx_buff->mapped_as_page)
>> +			dma_unmap_page(&bp->pdev->dev, tx_buff->mapping,
>> +				       tx_buff->size, DMA_TO_DEVICE);
>>  		else
>> -			dma_unmap_single(&bp->pdev->dev, tx_skb->mapping,
>> -					 tx_skb->size, DMA_TO_DEVICE);
>> -		tx_skb->mapping =3D 0;
>> +			dma_unmap_single(&bp->pdev->dev, tx_buff->mapping,
>> +					 tx_buff->size, DMA_TO_DEVICE);
>> +		tx_buff->mapping =3D 0;
>>  	}
>>=20=20
>> -	if (tx_skb->skb) {
>> -		napi_consume_skb(tx_skb->skb, budget);
>> -		tx_skb->skb =3D NULL;
>> +	if (tx_buff->data) {
>> +		if (tx_buff->type !=3D MACB_TYPE_SKB)
>> +			netdev_err(bp->dev, "BUG: Unexpected tx buffer type while unmapping =
(%d)",
>> +				   tx_buff->type);
>> +		napi_consume_skb(tx_buff->data, budget);
>> +		tx_buff->data =3D NULL;
>>  	}
>
> This code does not make much sense by itself. We check `tx_buff->type !=3D
> MACB_TYPE_SKB` but call napi_consume_skb() in all cases. I remember it
> changes in the next commit.
>
>> @@ -1069,16 +1073,23 @@ static void macb_tx_error_task(struct work_struc=
t *work)
>>=20=20
>>  		desc =3D macb_tx_desc(queue, tail);
>>  		ctrl =3D desc->ctrl;
>> -		tx_skb =3D macb_tx_skb(queue, tail);
>> -		skb =3D tx_skb->skb;
>> +		tx_buff =3D macb_tx_buff(queue, tail);
>> +
>> +		if (tx_buff->type !=3D MACB_TYPE_SKB)
>> +			netdev_err(bp->dev, "BUG: Unexpected tx buffer type (%d)",
>> +				   tx_buff->type);
>> +		skb =3D tx_buff->data;
>
> Same here: `tx_buff->type !=3D MACB_TYPE_SKB` does not make sense if we
> keep on going with the SKB case anyways.
>
>>=20=20
>>  		if (ctrl & MACB_BIT(TX_USED)) {
>>  			/* skb is set for the last buffer of the frame */
>>  			while (!skb) {
>> -				macb_tx_unmap(bp, tx_skb, 0);
>> +				macb_tx_unmap(bp, tx_buff, 0);
>>  				tail++;
>> -				tx_skb =3D macb_tx_skb(queue, tail);
>> -				skb =3D tx_skb->skb;
>> +				tx_buff =3D macb_tx_buff(queue, tail);
>> +				if (tx_buff->type !=3D MACB_TYPE_SKB)
>> +					netdev_err(bp->dev, "BUG: Unexpected tx buffer type (%d)",
>> +						   tx_buff->type);
>> +				skb =3D tx_buff->data;
>
> Same.
>

yeah, I'll revisit this and the ones above

>> @@ -5050,7 +5066,7 @@ static netdev_tx_t at91ether_start_xmit(struct sk_=
buff *skb,
>>  		netif_stop_queue(dev);
>>=20=20
>>  		/* Store packet information (to free when Tx completed) */
>> -		lp->rm9200_txq[desc].skb =3D skb;
>> +		lp->rm9200_txq[desc].data =3D skb;
>>  		lp->rm9200_txq[desc].size =3D skb->len;
>>  		lp->rm9200_txq[desc].mapping =3D dma_map_single(&lp->pdev->dev, skb->=
data,
>>  							      skb->len, DMA_TO_DEVICE);
>
> We might want to assign `lp->rm9200_txq[desc].type` here, to ensure all
> `struct macb_tx_buff` instances are fully initialised.
>

good catch

> Thanks,
>
> --
> Th=C3=A9o Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


