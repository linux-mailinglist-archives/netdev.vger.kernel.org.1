Return-Path: <netdev+bounces-243270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4F3C9C670
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 18:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D6868346AE2
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 17:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF672BE629;
	Tue,  2 Dec 2025 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZ8hrMqp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ViVmkg7O"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF28201004
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764696738; cv=none; b=pvj064vLL+ri90/GdaVpPgFlIKv4rMoVmNXjU/+tBGFWFItTjUSFmbX8t7FWypcHWQ+R2kkzckvT0q/26pFcA76Wus9tiUDI/7hBenwT2VwpPm6i5rwtheQ0tUU8TLu+NUAngodVF3jChuvseYPC2sg08UZnbBc6LinfLQLGe54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764696738; c=relaxed/simple;
	bh=F6qNKnChlWGludiIEe75rjtPWOYr3EoU4LzmZlpxVjY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VRl9hOHDeR0WmZDWsRGcY/8YEi1arBw+tSaXZVQxZKK5+gETfq9m23lkuRgQdpGE6U4SbdIT7ZjjOS/4j+hgNMbW4e8ne/xPBIFjMdqlBa6uIG57h/Vh3tzh8muS8SeGyKtUX2Z7M+bJh5oeIjccVLv03yWl4N05YXgi7GlGffA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZ8hrMqp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ViVmkg7O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764696735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H1YoTU8GRVU7Zur+pN9ZcEurWleBimg49CA6CwEcJMw=;
	b=UZ8hrMqppnWWEbfi9kjNR2t2Cuo3bbNh7abntHPremRpWXRZC2M/Z9z48pZIFTzUSXB/h6
	mEff2cF5UsGdr2zcKZufbLhVel1zcJyOQ4kHNyIlp42zk+Z6CSeBKi9X/8aMoLXdjU5fGG
	vvW9Cr9g6RdNN0cyQ+4Nbm/iHdQ4F8M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-oat_B_cnNU2HS8uv-YYuBA-1; Tue, 02 Dec 2025 12:32:13 -0500
X-MC-Unique: oat_B_cnNU2HS8uv-YYuBA-1
X-Mimecast-MFC-AGG-ID: oat_B_cnNU2HS8uv-YYuBA_1764696732
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47904cdb9bbso363385e9.1
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 09:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764696732; x=1765301532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1YoTU8GRVU7Zur+pN9ZcEurWleBimg49CA6CwEcJMw=;
        b=ViVmkg7OhyPDZdlM8atdLcwWNRbbgoN9Nn6xqwwnx5x/6/DLCMK734ubCLU2fYzx7b
         gX13bUkcwU3QHciark4w/dM4uzaWWtobvPfkQsp8jn+oeIahgA9+6boCHKMHHz9qwvzY
         Dm/pRWthpZ+j3LPeGirPfNCG3MV5fzeNoN72yh/SdjPH2we1uazH43nfHJKA+N/c451K
         Wlebf6RBdSQWpr85vrVoJ1vRJzrSUGqC7iZ6BrS4A5vUyg8xpOZhNmEFusqejEJGrDgI
         UM8xytzmfbvWOdCMLu7b1zK78Ra1exzrE857vJy7wvp5f9vzP1oSbaMA4m8bEyclQGNJ
         jnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764696732; x=1765301532;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H1YoTU8GRVU7Zur+pN9ZcEurWleBimg49CA6CwEcJMw=;
        b=dCcIAfkwP+B7eYWWPKSJLq/afz9GXR65CLNklUex1rKFWscHypsBL2zaUmjrm5Pp+o
         Yz6FrjJMSABS1hv2Vqh+TH+0rD21rawh+vxTBLg5wsP900M4vBbx3rZGHfRrTG/M5lWW
         VPIqlyQc7TEOMolaIKlrYQFyn2R+htuFueXEne8j1txovXI7945EV9m/kcXZi1VXXxhF
         w3MpwTzXT7285tqx23vDmiv2JACImAAIu5mkGDz2SqNzcbMzWuGF0lYGRYBGRbo6z4qV
         rsM1qgf5OfPiGZH6IOtsY79ca72TWDgvc2/RDjByD55JgVZH8xs+7nvxWHy+gFdhyN0N
         e9OA==
X-Forwarded-Encrypted: i=1; AJvYcCVN05q6Yj0At+9xvBLsSk+7s29dWa4vIcp3cbY8Vj/TbGI8Qlx1+Xx4bgcFh24TfEoPSkJxjB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzTwSeR2Q4O2FI3xUkyl/ex6vPOcpM7VAef4YageI+Ey6gC+MZ
	cl7euZSeH0ATZfvci02Qjm+jsdi5BQNtUTx71qhhYFA7CJXtUxZzzgi2R9lbIFsGzgdhDSGCur1
	nxOshknTodSAvViVkJBFdj7iCDKp2pdL8K4XhzPB2ePtp7t630kK7//yBtA==
X-Gm-Gg: ASbGncvnVWPhmcxqHIsATbtgMPk6A9mHVkkNC1w0ndLjKHpP2WV1Ck9v5zZkL0N47/a
	BbTTgKWV8FApINMgyqWj/BwZBuytHPYWKqGXg1/zBkxwfUEmesF5UAdXP8ljaokkTrqHEemIsb7
	gSQUi9Jdv6voa0UBFRtILnYzK3odUAH073wBFWCxcfwl71uf7bGDyW6VOsA5tvN2y0y88XOQHs+
	BN5i0rhpHbcyCXBcfJmcxvqpwZ917nEiI8nijw08WlmRvjaQtI1mJ8cvUbJHr+LCGv/2kErYzMd
	QnAu4l/cV4g5CQlDsJV+/qUHIjBJTpSqKU8+i9cuqjWL2I9xGdj8VdcKgarR2SeDU94s96TZr81
	4igbXVjhO2A4wW/Ac5ZnjWYn3WTlEqafmWS2j8yIi/3W4
X-Received: by 2002:a05:600c:3ba8:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-47926f9a512mr38485795e9.11.1764696732228;
        Tue, 02 Dec 2025 09:32:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvWwe4s+fK0X/s6WMOf6VaMgTwxGAPQAiIaOHWMzjFgH2gRHK5qBARTthuyjCb/jzmGH1sjw==
X-Received: by 2002:a05:600c:3ba8:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-47926f9a512mr38485485e9.11.1764696731717;
        Tue, 02 Dec 2025 09:32:11 -0800 (PST)
Received: from localhost (net-5-89-201-160.cust.vodafonedsl.it. [5.89.201.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5c304csm33635453f8f.8.2025.12.02.09.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 09:32:11 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>,
 netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, =?utf-8?Q?Gr=C3=A9gory?= Clement
 <gregory.clement@bootlin.com>, =?utf-8?Q?Beno=C3=AEt?= Monin
 <benoit.monin@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH RFC net-next 2/6] cadence: macb/gem: handle
 multi-descriptor frame reception
In-Reply-To: <DEJIOQFT9I2J.16KSODWK6IH6L@bootlin.com>
References: <20251119135330.551835-1-pvalerio@redhat.com>
 <20251119135330.551835-3-pvalerio@redhat.com>
 <DEJIOQFT9I2J.16KSODWK6IH6L@bootlin.com>
Date: Tue, 02 Dec 2025 18:32:10 +0100
Message-ID: <87cy4wzt5x.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27 Nov 2025 at 02:38:45 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> w=
rote:

> On Wed Nov 19, 2025 at 2:53 PM CET, Paolo Valerio wrote:
>> Add support for receiving network frames that span multiple DMA
>> descriptors in the Cadence MACB/GEM Ethernet driver.
>>
>> The patch removes the requirement that limited frame reception to
>> a single descriptor (RX_SOF && RX_EOF), also avoiding potential
>> contiguous multi-page allocation for large frames. It also uses
>> page pool fragments allocation instead of full page for saving
>> memory.
>>
>> Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
>> ---
>>  drivers/net/ethernet/cadence/macb.h      |   4 +-
>>  drivers/net/ethernet/cadence/macb_main.c | 180 ++++++++++++++---------
>>  2 files changed, 111 insertions(+), 73 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/=
cadence/macb.h
>> index dcf768bd1bc1..e2f397b7a27f 100644
>> --- a/drivers/net/ethernet/cadence/macb.h
>> +++ b/drivers/net/ethernet/cadence/macb.h
>> @@ -960,8 +960,7 @@ struct macb_dma_desc_ptp {
>>  #define PPM_FRACTION	16
>>=20=20
>>  /* The buf includes headroom compatible with both skb and xdpf */
>> -#define MACB_PP_HEADROOM		XDP_PACKET_HEADROOM
>> -#define MACB_PP_MAX_BUF_SIZE(num)	(((num) * PAGE_SIZE) - MACB_PP_HEADRO=
OM)
>> +#define MACB_PP_HEADROOM	XDP_PACKET_HEADROOM
>>=20=20
>>  /* struct macb_tx_skb - data about an skb which is being transmitted
>>   * @skb: skb currently being transmitted, only set for the last buffer
>> @@ -1273,6 +1272,7 @@ struct macb_queue {
>>  	struct napi_struct	napi_rx;
>>  	struct queue_stats stats;
>>  	struct page_pool	*page_pool;
>> +	struct sk_buff		*skb;
>>  };
>>=20=20
>>  struct ethtool_rx_fs_item {
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethe=
rnet/cadence/macb_main.c
>> index 985c81913ba6..be0c8e101639 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -1250,21 +1250,25 @@ static int macb_tx_complete(struct macb_queue *q=
ueue, int budget)
>>  	return packets;
>>  }
>>=20=20
>> -static void *gem_page_pool_get_buff(struct page_pool *pool,
>> +static void *gem_page_pool_get_buff(struct  macb_queue *queue,
>>  				    dma_addr_t *dma_addr, gfp_t gfp_mask)
>>  {
>> +	struct macb *bp =3D queue->bp;
>>  	struct page *page;
>> +	int offset;
>>=20=20
>> -	if (!pool)
>> +	if (!queue->page_pool)
>>  		return NULL;
>>=20=20
>> -	page =3D page_pool_alloc_pages(pool, gfp_mask | __GFP_NOWARN);
>> +	page =3D page_pool_alloc_frag(queue->page_pool, &offset,
>> +				    bp->rx_buffer_size,
>> +				    gfp_mask | __GFP_NOWARN);
>>  	if (!page)
>>  		return NULL;
>>=20=20
>> -	*dma_addr =3D page_pool_get_dma_addr(page) + MACB_PP_HEADROOM;
>> +	*dma_addr =3D page_pool_get_dma_addr(page) + MACB_PP_HEADROOM + offset;
>>=20=20
>> -	return page_address(page);
>> +	return page_address(page) + offset;
>>  }
>>=20=20
>>  static void gem_rx_refill(struct macb_queue *queue, bool napi)
>> @@ -1286,7 +1290,7 @@ static void gem_rx_refill(struct macb_queue *queue=
, bool napi)
>>=20=20
>>  		if (!queue->rx_buff[entry]) {
>>  			/* allocate sk_buff for this free entry in ring */
>> -			data =3D gem_page_pool_get_buff(queue->page_pool, &paddr,
>> +			data =3D gem_page_pool_get_buff(queue, &paddr,
>>  						      napi ? GFP_ATOMIC : GFP_KERNEL);
>>  			if (unlikely(!data)) {
>>  				netdev_err(bp->dev,
>> @@ -1344,20 +1348,17 @@ static int gem_rx(struct macb_queue *queue, stru=
ct napi_struct *napi,
>>  		  int budget)
>>  {
>>  	struct macb *bp =3D queue->bp;
>> -	int			buffer_size;
>>  	unsigned int		len;
>>  	unsigned int		entry;
>>  	void			*data;
>> -	struct sk_buff		*skb;
>>  	struct macb_dma_desc	*desc;
>> +	int			data_len;
>>  	int			count =3D 0;
>>=20=20
>> -	buffer_size =3D DIV_ROUND_UP(bp->rx_buffer_size, PAGE_SIZE) * PAGE_SIZ=
E;
>> -
>>  	while (count < budget) {
>>  		u32 ctrl;
>>  		dma_addr_t addr;
>> -		bool rxused;
>> +		bool rxused, first_frame;
>>=20=20
>>  		entry =3D macb_rx_ring_wrap(bp, queue->rx_tail);
>>  		desc =3D macb_rx_desc(queue, entry);
>> @@ -1368,6 +1369,9 @@ static int gem_rx(struct macb_queue *queue, struct=
 napi_struct *napi,
>>  		rxused =3D (desc->addr & MACB_BIT(RX_USED)) ? true : false;
>>  		addr =3D macb_get_addr(bp, desc);
>>=20=20
>> +		dma_sync_single_for_cpu(&bp->pdev->dev,
>> +					addr, bp->rx_buffer_size - bp->rx_offset,
>> +					page_pool_get_dma_dir(queue->page_pool));
>
> page_pool_get_dma_dir() will always return the same value, we could
> hardcode it.
>
>>  		if (!rxused)
>>  			break;
>>=20=20
>> @@ -1379,13 +1383,6 @@ static int gem_rx(struct macb_queue *queue, struc=
t napi_struct *napi,
>>  		queue->rx_tail++;
>>  		count++;
>>=20=20
>> -		if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF))) {
>> -			netdev_err(bp->dev,
>> -				   "not whole frame pointed by descriptor\n");
>> -			bp->dev->stats.rx_dropped++;
>> -			queue->stats.rx_dropped++;
>> -			break;
>> -		}
>>  		data =3D queue->rx_buff[entry];
>>  		if (unlikely(!data)) {
>>  			netdev_err(bp->dev,
>> @@ -1395,64 +1392,102 @@ static int gem_rx(struct macb_queue *queue, str=
uct napi_struct *napi,
>>  			break;
>>  		}
>>=20=20
>> -		skb =3D napi_build_skb(data, buffer_size);
>> -		if (unlikely(!skb)) {
>> -			netdev_err(bp->dev,
>> -				   "Unable to allocate sk_buff\n");
>> -			page_pool_put_full_page(queue->page_pool,
>> -						virt_to_head_page(data),
>> -						false);
>> -			break;
>> +		first_frame =3D ctrl & MACB_BIT(RX_SOF);
>> +		len =3D ctrl & bp->rx_frm_len_mask;
>> +
>> +		if (len) {
>> +			data_len =3D len;
>> +			if (!first_frame)
>> +				data_len -=3D queue->skb->len;
>> +		} else {
>> +			data_len =3D SKB_WITH_OVERHEAD(bp->rx_buffer_size) - bp->rx_offset;
>>  		}
>>=20=20
>> -		/* Properly align Ethernet header.
>> -		 *
>> -		 * Hardware can add dummy bytes if asked using the RBOF
>> -		 * field inside the NCFGR register. That feature isn't
>> -		 * available if hardware is RSC capable.
>> -		 *
>> -		 * We cannot fallback to doing the 2-byte shift before
>> -		 * DMA mapping because the address field does not allow
>> -		 * setting the low 2/3 bits.
>> -		 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
>> -		 */
>> -		skb_reserve(skb, bp->rx_offset);
>> -		skb_mark_for_recycle(skb);
>> +		if (first_frame) {
>> +			queue->skb =3D napi_build_skb(data, bp->rx_buffer_size);
>> +			if (unlikely(!queue->skb)) {
>> +				netdev_err(bp->dev,
>> +					   "Unable to allocate sk_buff\n");
>> +				goto free_frags;
>> +			}
>> +
>> +			/* Properly align Ethernet header.
>> +			 *
>> +			 * Hardware can add dummy bytes if asked using the RBOF
>> +			 * field inside the NCFGR register. That feature isn't
>> +			 * available if hardware is RSC capable.
>> +			 *
>> +			 * We cannot fallback to doing the 2-byte shift before
>> +			 * DMA mapping because the address field does not allow
>> +			 * setting the low 2/3 bits.
>> +			 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
>> +			 */
>> +			skb_reserve(queue->skb, bp->rx_offset);
>> +			skb_mark_for_recycle(queue->skb);
>> +			skb_put(queue->skb, data_len);
>> +			queue->skb->protocol =3D eth_type_trans(queue->skb, bp->dev);
>> +
>> +			skb_checksum_none_assert(queue->skb);
>> +			if (bp->dev->features & NETIF_F_RXCSUM &&
>> +			    !(bp->dev->flags & IFF_PROMISC) &&
>> +			    GEM_BFEXT(RX_CSUM, ctrl) & GEM_RX_CSUM_CHECKED_MASK)
>> +				queue->skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>> +		} else {
>> +			if (!queue->skb) {
>> +				netdev_err(bp->dev,
>> +					   "Received non-starting frame while expecting it\n");
>> +				goto free_frags;
>> +			}
>
> Here as well we want `queue->rx_buff[entry] =3D NULL;` no?
> Maybe put it in the free_frags codepath to ensure it isn't forgotten?
>

That's correct, that slipped in this RFC.

>> +			struct skb_shared_info *shinfo =3D skb_shinfo(queue->skb);
>> +			struct page *page =3D virt_to_head_page(data);
>> +			int nr_frags =3D shinfo->nr_frags;
>
> Variable definitions in the middle of a scope? I think it is acceptable
> when using __attribute__((cleanup)) but otherwise not so much (yet).
>

I guess I simply forgot to move them.
Ack for this and for the previous ones.

>> +			if (nr_frags >=3D ARRAY_SIZE(shinfo->frags))
>> +				goto free_frags;
>> +
>> +			skb_add_rx_frag(queue->skb, nr_frags, page,
>> +					data - page_address(page) + bp->rx_offset,
>> +					data_len, bp->rx_buffer_size);
>> +		}
>>=20=20
>>  		/* now everything is ready for receiving packet */
>>  		queue->rx_buff[entry] =3D NULL;
>> -		len =3D ctrl & bp->rx_frm_len_mask;
>> -
>> -		netdev_vdbg(bp->dev, "gem_rx %u (len %u)\n", entry, len);
>>=20=20
>> -		dma_sync_single_for_cpu(&bp->pdev->dev,
>> -					addr, len,
>> -					page_pool_get_dma_dir(queue->page_pool));
>> -		skb_put(skb, len);
>> -		skb->protocol =3D eth_type_trans(skb, bp->dev);
>> -		skb_checksum_none_assert(skb);
>> -		if (bp->dev->features & NETIF_F_RXCSUM &&
>> -		    !(bp->dev->flags & IFF_PROMISC) &&
>> -		    GEM_BFEXT(RX_CSUM, ctrl) & GEM_RX_CSUM_CHECKED_MASK)
>> -			skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>> +		netdev_vdbg(bp->dev, "%s %u (len %u)\n", __func__, entry, data_len);
>>=20=20
>> -		bp->dev->stats.rx_packets++;
>> -		queue->stats.rx_packets++;
>> -		bp->dev->stats.rx_bytes +=3D skb->len;
>> -		queue->stats.rx_bytes +=3D skb->len;
>> +		if (ctrl & MACB_BIT(RX_EOF)) {
>> +			bp->dev->stats.rx_packets++;
>> +			queue->stats.rx_packets++;
>> +			bp->dev->stats.rx_bytes +=3D queue->skb->len;
>> +			queue->stats.rx_bytes +=3D queue->skb->len;
>>=20=20
>> -		gem_ptp_do_rxstamp(bp, skb, desc);
>> +			gem_ptp_do_rxstamp(bp, queue->skb, desc);
>>=20=20
>>  #if defined(DEBUG) && defined(VERBOSE_DEBUG)
>> -		netdev_vdbg(bp->dev, "received skb of length %u, csum: %08x\n",
>> -			    skb->len, skb->csum);
>> -		print_hex_dump(KERN_DEBUG, " mac: ", DUMP_PREFIX_ADDRESS, 16, 1,
>> -			       skb_mac_header(skb), 16, true);
>> -		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_ADDRESS, 16, 1,
>> -			       skb->data, 32, true);
>> +			netdev_vdbg(bp->dev, "received skb of length %u, csum: %08x\n",
>> +				    queue->skb->len, queue->skb->csum);
>> +			print_hex_dump(KERN_DEBUG, " mac: ", DUMP_PREFIX_ADDRESS, 16, 1,
>> +				       skb_mac_header(queue->skb), 16, true);
>> +			print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_ADDRESS, 16, 1,
>> +				       queue->skb->data, 32, true);
>>  #endif
>>=20=20
>> -		napi_gro_receive(napi, skb);
>> +			napi_gro_receive(napi, queue->skb);
>> +			queue->skb =3D NULL;
>> +		}
>> +
>> +		continue;
>> +
>> +free_frags:
>> +		if (queue->skb) {
>> +			dev_kfree_skb(queue->skb);
>> +			queue->skb =3D NULL;
>> +		} else {
>> +			page_pool_put_full_page(queue->page_pool,
>> +						virt_to_head_page(data),
>> +						false);
>> +		}
>>  	}
>>=20=20
>>  	gem_rx_refill(queue, true);
>> @@ -2394,7 +2429,10 @@ static void macb_init_rx_buffer_size(struct macb =
*bp, size_t size)
>>  	if (!macb_is_gem(bp)) {
>>  		bp->rx_buffer_size =3D MACB_RX_BUFFER_SIZE;
>>  	} else {
>> -		bp->rx_buffer_size =3D size;
>> +		bp->rx_buffer_size =3D size + SKB_DATA_ALIGN(sizeof(struct skb_shared=
_info))
>> +			+ MACB_PP_HEADROOM;
>> +		if (bp->rx_buffer_size > PAGE_SIZE)
>> +			bp->rx_buffer_size =3D PAGE_SIZE;
>>=20=20
>>  		if (bp->rx_buffer_size % RX_BUFFER_MULTIPLE) {
>>  			netdev_dbg(bp->dev,
>> @@ -2589,18 +2627,15 @@ static int macb_alloc_consistent(struct macb *bp)
>>=20=20
>>  static void gem_create_page_pool(struct macb_queue *queue)
>>  {
>> -	unsigned int num_pages =3D DIV_ROUND_UP(queue->bp->rx_buffer_size, PAG=
E_SIZE);
>> -	struct macb *bp =3D queue->bp;
>>  	struct page_pool_params pp_params =3D {
>> -		.order =3D order_base_2(num_pages),
>> +		.order =3D 0,
>>  		.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
>>  		.pool_size =3D queue->bp->rx_ring_size,
>>  		.nid =3D NUMA_NO_NODE,
>>  		.dma_dir =3D DMA_FROM_DEVICE,
>>  		.dev =3D &queue->bp->pdev->dev,
>>  		.napi =3D &queue->napi_rx,
>> -		.offset =3D bp->rx_offset,
>> -		.max_len =3D MACB_PP_MAX_BUF_SIZE(num_pages),
>> +		.max_len =3D PAGE_SIZE,
>>  	};
>>  	struct page_pool *pool;
>
> I forgot about it in [PATCH 1/6], but the error handling if
> gem_create_page_pool() fails is odd. We set queue->page_pool to NULL
> and keep on going. Then once opened we'll fail allocating any buffer
> but still be open. Shouldn't we fail the link up operation?
>
> If we want to support this codepath (page pool not allocated), then we
> should unmask Rx interrupts only if alloc succeeded. I don't know if
> we'd want that though.
>
> 	queue_writel(queue, IER, bp->rx_intr_mask | ...);
>

Makes sense to fail the link up.
Doesn't this imply to move the page pool creation and refill into
macb_open()?

I didn't look into it, I'm not sure if this can potentially become a
bigger change.

>> @@ -2784,8 +2819,9 @@ static void macb_configure_dma(struct macb *bp)
>>  	unsigned int q;
>>  	u32 dmacfg;
>>=20=20
>> -	buffer_size =3D bp->rx_buffer_size / RX_BUFFER_MULTIPLE;
>>  	if (macb_is_gem(bp)) {
>> +		buffer_size =3D SKB_WITH_OVERHEAD(bp->rx_buffer_size) - bp->rx_offset;
>> +		buffer_size /=3D RX_BUFFER_MULTIPLE;
>>  		dmacfg =3D gem_readl(bp, DMACFG) & ~GEM_BF(RXBS, -1L);
>>  		for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue)=
 {
>>  			if (q)
>> @@ -2816,6 +2852,8 @@ static void macb_configure_dma(struct macb *bp)
>>  		netdev_dbg(bp->dev, "Cadence configure DMA with 0x%08x\n",
>>  			   dmacfg);
>>  		gem_writel(bp, DMACFG, dmacfg);
>> +	} else {
>> +		buffer_size =3D bp->rx_buffer_size / RX_BUFFER_MULTIPLE;
>>  	}
>>  }
>
> You do:
>
> static void macb_configure_dma(struct macb *bp)
> {
> 	u32 buffer_size;
>
> 	if (macb_is_gem(bp)) {
> 		buffer_size =3D SKB_WITH_OVERHEAD(bp->rx_buffer_size) - bp->rx_offset;
> 		buffer_size /=3D RX_BUFFER_MULTIPLE;
> 		// ... use buffer_size ...
> 	} else {
> 		buffer_size =3D bp->rx_buffer_size / RX_BUFFER_MULTIPLE;
> 	}
> }
>
> Instead I'd vote for:
>
> static void macb_configure_dma(struct macb *bp)
> {
> 	u32 buffer_size;
>
> 	if (!macb_is_gem(bp))
> 		return;
>
> 	buffer_size =3D SKB_WITH_OVERHEAD(bp->rx_buffer_size) - bp->rx_offset;
> 	buffer_size /=3D RX_BUFFER_MULTIPLE;
> 	// ... use buffer_size ...
> }
>
> Thanks,
>

I vote for this as well :)

> --
> Th=C3=A9o Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


