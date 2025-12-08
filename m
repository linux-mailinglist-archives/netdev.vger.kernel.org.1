Return-Path: <netdev+bounces-244004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E693CAD33D
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 13:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16F10301CEB2
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 12:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EBF31282C;
	Mon,  8 Dec 2025 12:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4GORyON";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ufy2xpZG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B622EB5C6
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765198452; cv=none; b=ZJSjQmTdQjVeej0KO7wk+seUrsNqLA8jM17qGweKGRPsxeCWXif1FjW8Rwbq+AB0yqjGuQxDwfiylOTa7jlDYxzC3qXhlFiaPYPMv3G65/ht+hKJ5OQQnHZPCmgghb0Bi5KEyhMlkg3TJG5TobK2iPMfPe9CnteDsZy+Kz6Nu9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765198452; c=relaxed/simple;
	bh=otenajaSH15yRDbnr8OAFbbToyc4vbaczqqy/Aj5Xj0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UEhhan4lvqgaqcH4DIfoyLvrTS4GtcTCjk1dM+SJfNGeoHLGl3hxaCl0MSGmxLiCQbboBO4xEmyyl9aS9XW8x0LJL1GFTP9a1Bj73gmDi5BtHCDC89/yXhl1Ykd2mgLpo0BWOs1GpAFRBqnqEQ7GxQQWCA8zkxQZR9HImR0ZWxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4GORyON; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ufy2xpZG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765198448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dZrLfokJch/zwTDgq40U5KD4/0gDlTZwLuPBNgCzHiI=;
	b=a4GORyONSUE+vDVquY94/zlO6Ui/irnTP5X79RxSAxN9bGJwbm+aEWAdgKHcLkjDTLEDfw
	qv/qB152CAZhPfaZPAQ6QokZJi8fvgJL/s7fGJnehp8PK+FMt2/yAzmNeLhgma4ibLXHBL
	sFS8PJCPZdl38d7eaIhN7MBGsHbxXAA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-LBIHOfYxM6ym02a4ts5FEw-1; Mon, 08 Dec 2025 07:54:07 -0500
X-MC-Unique: LBIHOfYxM6ym02a4ts5FEw-1
X-Mimecast-MFC-AGG-ID: LBIHOfYxM6ym02a4ts5FEw_1765198446
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b3b5ed793so3167146f8f.2
        for <netdev@vger.kernel.org>; Mon, 08 Dec 2025 04:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765198446; x=1765803246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZrLfokJch/zwTDgq40U5KD4/0gDlTZwLuPBNgCzHiI=;
        b=Ufy2xpZGbHF3sllGik1oSi1acJbCQl7+m8+du+CHHt46UVaQWA2svcZ/DJtMRy6hXe
         Ce+sXqdFs8LyHTDDPUcM2U7EFSykVqnViZP32F84mnC2Ta8V1mZLcI95i9oWLW1GLQsG
         6XqRLlXuKdQL8xYX3h4nNik6AAVvH6GdAHYNs+bKL2/SRTJGRTgjIh/fZSy1kglndkB4
         Wdk8nxkRMyPhsLLkndBmZZay5MMEtumP7etpl1+iaBtT5q4kqFf3IbaDi0gn+u6JNWLd
         rb0x7qEXsGXc63z5VcyRKcviRSLhWBRWTIMSE6hY5qTD7AskZ1AKO5N3plTjggAIJxpO
         WBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765198446; x=1765803246;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dZrLfokJch/zwTDgq40U5KD4/0gDlTZwLuPBNgCzHiI=;
        b=LpD10XgW6iRYn8aGpHP/wujeNRjKnClcQB+80iTQZlSd+BSjVRERztR610T7wGbR4e
         A5/1ZzAJuR60yxXbXkWWcvnLRmVsrSq6iagd3NKYStswEhYAysV2OHCkX7GCaQZDfmOc
         ARe1e3IaJXvfPJ9ziBX8RZp2zriqNqUJYH7F8vMCzAfqbAYpeFXwWbunO0zy5Nx4GbXD
         a4r1Xfsy038d7ptNKrivsug/Au9q34zfoMXmmMio6TTvb6wDPLNsc2YOTlowaevWnrKs
         SkZyU5CSa77b7lO8gbAaV8ljr+QAO67Ayib23P9WJLYjRp3tt8D25aYSd13gaUyMMM7b
         0WdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXfWFdRwq7fu3l4egT2wV9Y2cR7dyfbkk6dExV2pw8UwGmvf7V2Rng+DqhczzT6aheZq8FmlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxUonH6umvVvHAL1P1FxGy6LjHlVXz9mARCjDVuWIWvyywF6Kt
	8RnIQ3WthHVZgTY5hkNn7N3cWrCd7e7rXMCRaoSi14U/YbGGTFSEH3iJXjYf80/E2Xwe7++KU1X
	8HaWR5ptDNLp/4P3UoUBODGPBIwywxqMoJKvoswMEU5lOPs5ekZy0LGte5+fOw4hP8/zK
X-Gm-Gg: ASbGncu/FrNqpsI59QM1kNFcN9s/bkwQE3Bg6ZGMFhe540iEcGq4qhmuzGnsBe4pJo/
	AmqAb3HlUBKfWAQ4yyexNLNIe6a0zjPufiXRo/rR2I4YzFWF5Dt7hs6clVjj262hnwThjhlAO8H
	GxMSp1spR7SxtAOOaXgQ9AqOFFNIAkqpszokHVCDur2RhbHJgwSmG1+a23kCLgeisCxmgabzhbM
	RvC6Wn5Fi0CLhqz9RNi/0d4chWqFvneEO+PePWGsM4nz3Yut1MUccZCU8dKSqcTkNjd01OzDfSB
	dgQj2n6s88j7cjtSTkeqvR5TKV3vdxCxbwhFiRCD0BV7zsxjisU4OHvqnI0JZncjgQtSfzXV42o
	LZElyCIZGyjdVBZvPBRkCQ8wDyav/mgExlWrsmQj+cdJ1xEqI+w==
X-Received: by 2002:a05:6000:2384:b0:42b:3746:3b85 with SMTP id ffacd0b85a97d-42f89f568f4mr8168527f8f.45.1765198445595;
        Mon, 08 Dec 2025 04:54:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEF58MLkClGBgc7ugAFM/yl0aGAgZoXmiKguORs5xF2G94PRjhPFg292jSDSU+a/ey80LvBRA==
X-Received: by 2002:a05:6000:2384:b0:42b:3746:3b85 with SMTP id ffacd0b85a97d-42f89f568f4mr8168483f8f.45.1765198445029;
        Mon, 08 Dec 2025 04:54:05 -0800 (PST)
Received: from localhost (net-188-216-85-168.cust.vodafonedsl.it. [188.216.85.168])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d222478sm25010483f8f.20.2025.12.08.04.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 04:54:04 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>, =?utf-8?Q?Th?=
 =?utf-8?Q?=C3=A9o?= Lebrun
 <theo.lebrun@bootlin.com>, netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, =?utf-8?Q?Gr=C3=A9gory?= Clement
 <gregory.clement@bootlin.com>, =?utf-8?Q?Beno=C3=AEt?= Monin
 <benoit.monin@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH RFC net-next 2/6] cadence: macb/gem: handle
 multi-descriptor frame reception
In-Reply-To: <DESRDBL2FBUZ.3LXAM56K3CQV2@bootlin.com>
References: <20251119135330.551835-1-pvalerio@redhat.com>
 <20251119135330.551835-3-pvalerio@redhat.com>
 <DEJIOQFT9I2J.16KSODWK6IH6L@bootlin.com> <87cy4wzt5x.fsf@redhat.com>
 <DESRDBL2FBUZ.3LXAM56K3CQV2@bootlin.com>
Date: Mon, 08 Dec 2025 13:53:58 +0100
Message-ID: <878qfd5e3d.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08 Dec 2025 at 11:21:00 AM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> w=
rote:

> Hello Paolo, Th=C3=A9o, netdev,
>
> On Tue Dec 2, 2025 at 6:32 PM CET, Paolo Valerio wrote:
>> On 27 Nov 2025 at 02:38:45 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com=
> wrote:
>>
>>> On Wed Nov 19, 2025 at 2:53 PM CET, Paolo Valerio wrote:
>>>> Add support for receiving network frames that span multiple DMA
>>>> descriptors in the Cadence MACB/GEM Ethernet driver.
>>>>
>>>> The patch removes the requirement that limited frame reception to
>>>> a single descriptor (RX_SOF && RX_EOF), also avoiding potential
>>>> contiguous multi-page allocation for large frames. It also uses
>>>> page pool fragments allocation instead of full page for saving
>>>> memory.
>>>>
>>>> Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
>>>> ---
>>>>  drivers/net/ethernet/cadence/macb.h      |   4 +-
>>>>  drivers/net/ethernet/cadence/macb_main.c | 180 ++++++++++++++---------
>>>>  2 files changed, 111 insertions(+), 73 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/etherne=
t/cadence/macb.h
>>>> index dcf768bd1bc1..e2f397b7a27f 100644
>>>> --- a/drivers/net/ethernet/cadence/macb.h
>>>> +++ b/drivers/net/ethernet/cadence/macb.h
>>>> @@ -960,8 +960,7 @@ struct macb_dma_desc_ptp {
>>>>  #define PPM_FRACTION	16
>>>>=20=20
>>>>  /* The buf includes headroom compatible with both skb and xdpf */
>>>> -#define MACB_PP_HEADROOM		XDP_PACKET_HEADROOM
>>>> -#define MACB_PP_MAX_BUF_SIZE(num)	(((num) * PAGE_SIZE) - MACB_PP_HEAD=
ROOM)
>>>> +#define MACB_PP_HEADROOM	XDP_PACKET_HEADROOM
>>>>=20=20
>>>>  /* struct macb_tx_skb - data about an skb which is being transmitted
>>>>   * @skb: skb currently being transmitted, only set for the last buffer
>>>> @@ -1273,6 +1272,7 @@ struct macb_queue {
>>>>  	struct napi_struct	napi_rx;
>>>>  	struct queue_stats stats;
>>>>  	struct page_pool	*page_pool;
>>>> +	struct sk_buff		*skb;
>>>>  };
>>>>=20=20
>>>>  struct ethtool_rx_fs_item {
>>>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/et=
hernet/cadence/macb_main.c
>>>> index 985c81913ba6..be0c8e101639 100644
>>>> --- a/drivers/net/ethernet/cadence/macb_main.c
>>>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>>>> @@ -1250,21 +1250,25 @@ static int macb_tx_complete(struct macb_queue =
*queue, int budget)
>>>>  	return packets;
>>>>  }
>>>>=20=20
>>>> -static void *gem_page_pool_get_buff(struct page_pool *pool,
>>>> +static void *gem_page_pool_get_buff(struct  macb_queue *queue,
>>>>  				    dma_addr_t *dma_addr, gfp_t gfp_mask)
>>>>  {
>>>> +	struct macb *bp =3D queue->bp;
>>>>  	struct page *page;
>>>> +	int offset;
>>>>=20=20
>>>> -	if (!pool)
>>>> +	if (!queue->page_pool)
>>>>  		return NULL;
>>>>=20=20
>>>> -	page =3D page_pool_alloc_pages(pool, gfp_mask | __GFP_NOWARN);
>>>> +	page =3D page_pool_alloc_frag(queue->page_pool, &offset,
>>>> +				    bp->rx_buffer_size,
>>>> +				    gfp_mask | __GFP_NOWARN);
>>>>  	if (!page)
>>>>  		return NULL;
>>>>=20=20
>>>> -	*dma_addr =3D page_pool_get_dma_addr(page) + MACB_PP_HEADROOM;
>>>> +	*dma_addr =3D page_pool_get_dma_addr(page) + MACB_PP_HEADROOM + offs=
et;
>>>>=20=20
>>>> -	return page_address(page);
>>>> +	return page_address(page) + offset;
>>>>  }
>>>>=20=20
>>>>  static void gem_rx_refill(struct macb_queue *queue, bool napi)
>>>> @@ -1286,7 +1290,7 @@ static void gem_rx_refill(struct macb_queue *que=
ue, bool napi)
>>>>=20=20
>>>>  		if (!queue->rx_buff[entry]) {
>>>>  			/* allocate sk_buff for this free entry in ring */
>>>> -			data =3D gem_page_pool_get_buff(queue->page_pool, &paddr,
>>>> +			data =3D gem_page_pool_get_buff(queue, &paddr,
>>>>  						      napi ? GFP_ATOMIC : GFP_KERNEL);
>>>>  			if (unlikely(!data)) {
>>>>  				netdev_err(bp->dev,
>>>> @@ -1344,20 +1348,17 @@ static int gem_rx(struct macb_queue *queue, st=
ruct napi_struct *napi,
>>>>  		  int budget)
>>>>  {
>>>>  	struct macb *bp =3D queue->bp;
>>>> -	int			buffer_size;
>>>>  	unsigned int		len;
>>>>  	unsigned int		entry;
>>>>  	void			*data;
>>>> -	struct sk_buff		*skb;
>>>>  	struct macb_dma_desc	*desc;
>>>> +	int			data_len;
>>>>  	int			count =3D 0;
>>>>=20=20
>>>> -	buffer_size =3D DIV_ROUND_UP(bp->rx_buffer_size, PAGE_SIZE) * PAGE_S=
IZE;
>>>> -
>>>>  	while (count < budget) {
>>>>  		u32 ctrl;
>>>>  		dma_addr_t addr;
>>>> -		bool rxused;
>>>> +		bool rxused, first_frame;
>>>>=20=20
>>>>  		entry =3D macb_rx_ring_wrap(bp, queue->rx_tail);
>>>>  		desc =3D macb_rx_desc(queue, entry);
>>>> @@ -1368,6 +1369,9 @@ static int gem_rx(struct macb_queue *queue, stru=
ct napi_struct *napi,
>>>>  		rxused =3D (desc->addr & MACB_BIT(RX_USED)) ? true : false;
>>>>  		addr =3D macb_get_addr(bp, desc);
>>>>=20=20
>>>> +		dma_sync_single_for_cpu(&bp->pdev->dev,
>>>> +					addr, bp->rx_buffer_size - bp->rx_offset,
>>>> +					page_pool_get_dma_dir(queue->page_pool));
>>>
>>> page_pool_get_dma_dir() will always return the same value, we could
>>> hardcode it.
>>>
>>>>  		if (!rxused)
>>>>  			break;
>>>>=20=20
>>>> @@ -1379,13 +1383,6 @@ static int gem_rx(struct macb_queue *queue, str=
uct napi_struct *napi,
>>>>  		queue->rx_tail++;
>>>>  		count++;
>>>>=20=20
>>>> -		if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF))) {
>>>> -			netdev_err(bp->dev,
>>>> -				   "not whole frame pointed by descriptor\n");
>>>> -			bp->dev->stats.rx_dropped++;
>>>> -			queue->stats.rx_dropped++;
>>>> -			break;
>>>> -		}
>>>>  		data =3D queue->rx_buff[entry];
>>>>  		if (unlikely(!data)) {
>>>>  			netdev_err(bp->dev,
>>>> @@ -1395,64 +1392,102 @@ static int gem_rx(struct macb_queue *queue, s=
truct napi_struct *napi,
>>>>  			break;
>>>>  		}
>>>>=20=20
>>>> -		skb =3D napi_build_skb(data, buffer_size);
>>>> -		if (unlikely(!skb)) {
>>>> -			netdev_err(bp->dev,
>>>> -				   "Unable to allocate sk_buff\n");
>>>> -			page_pool_put_full_page(queue->page_pool,
>>>> -						virt_to_head_page(data),
>>>> -						false);
>>>> -			break;
>>>> +		first_frame =3D ctrl & MACB_BIT(RX_SOF);
>>>> +		len =3D ctrl & bp->rx_frm_len_mask;
>>>> +
>>>> +		if (len) {
>>>> +			data_len =3D len;
>>>> +			if (!first_frame)
>>>> +				data_len -=3D queue->skb->len;
>>>> +		} else {
>>>> +			data_len =3D SKB_WITH_OVERHEAD(bp->rx_buffer_size) - bp->rx_offset;
>>>>  		}
>>>>=20=20
>>>> -		/* Properly align Ethernet header.
>>>> -		 *
>>>> -		 * Hardware can add dummy bytes if asked using the RBOF
>>>> -		 * field inside the NCFGR register. That feature isn't
>>>> -		 * available if hardware is RSC capable.
>>>> -		 *
>>>> -		 * We cannot fallback to doing the 2-byte shift before
>>>> -		 * DMA mapping because the address field does not allow
>>>> -		 * setting the low 2/3 bits.
>>>> -		 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
>>>> -		 */
>>>> -		skb_reserve(skb, bp->rx_offset);
>>>> -		skb_mark_for_recycle(skb);
>>>> +		if (first_frame) {
>>>> +			queue->skb =3D napi_build_skb(data, bp->rx_buffer_size);
>>>> +			if (unlikely(!queue->skb)) {
>>>> +				netdev_err(bp->dev,
>>>> +					   "Unable to allocate sk_buff\n");
>>>> +				goto free_frags;
>>>> +			}
>>>> +
>>>> +			/* Properly align Ethernet header.
>>>> +			 *
>>>> +			 * Hardware can add dummy bytes if asked using the RBOF
>>>> +			 * field inside the NCFGR register. That feature isn't
>>>> +			 * available if hardware is RSC capable.
>>>> +			 *
>>>> +			 * We cannot fallback to doing the 2-byte shift before
>>>> +			 * DMA mapping because the address field does not allow
>>>> +			 * setting the low 2/3 bits.
>>>> +			 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
>>>> +			 */
>>>> +			skb_reserve(queue->skb, bp->rx_offset);
>>>> +			skb_mark_for_recycle(queue->skb);
>>>> +			skb_put(queue->skb, data_len);
>>>> +			queue->skb->protocol =3D eth_type_trans(queue->skb, bp->dev);
>>>> +
>>>> +			skb_checksum_none_assert(queue->skb);
>>>> +			if (bp->dev->features & NETIF_F_RXCSUM &&
>>>> +			    !(bp->dev->flags & IFF_PROMISC) &&
>>>> +			    GEM_BFEXT(RX_CSUM, ctrl) & GEM_RX_CSUM_CHECKED_MASK)
>>>> +				queue->skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>>>> +		} else {
>>>> +			if (!queue->skb) {
>>>> +				netdev_err(bp->dev,
>>>> +					   "Received non-starting frame while expecting it\n");
>>>> +				goto free_frags;
>>>> +			}
>>>
>>> Here as well we want `queue->rx_buff[entry] =3D NULL;` no?
>>> Maybe put it in the free_frags codepath to ensure it isn't forgotten?
>>>
>>
>> That's correct, that slipped in this RFC.
>>
>>>> +			struct skb_shared_info *shinfo =3D skb_shinfo(queue->skb);
>>>> +			struct page *page =3D virt_to_head_page(data);
>>>> +			int nr_frags =3D shinfo->nr_frags;
>>>
>>> Variable definitions in the middle of a scope? I think it is acceptable
>>> when using __attribute__((cleanup)) but otherwise not so much (yet).
>>>
>>
>> I guess I simply forgot to move them.
>> Ack for this and for the previous ones.
>>
>>>> +			if (nr_frags >=3D ARRAY_SIZE(shinfo->frags))
>>>> +				goto free_frags;
>>>> +
>>>> +			skb_add_rx_frag(queue->skb, nr_frags, page,
>>>> +					data - page_address(page) + bp->rx_offset,
>>>> +					data_len, bp->rx_buffer_size);
>>>> +		}
>>>>=20=20
>>>>  		/* now everything is ready for receiving packet */
>>>>  		queue->rx_buff[entry] =3D NULL;
>>>> -		len =3D ctrl & bp->rx_frm_len_mask;
>>>> -
>>>> -		netdev_vdbg(bp->dev, "gem_rx %u (len %u)\n", entry, len);
>>>>=20=20
>>>> -		dma_sync_single_for_cpu(&bp->pdev->dev,
>>>> -					addr, len,
>>>> -					page_pool_get_dma_dir(queue->page_pool));
>>>> -		skb_put(skb, len);
>>>> -		skb->protocol =3D eth_type_trans(skb, bp->dev);
>>>> -		skb_checksum_none_assert(skb);
>>>> -		if (bp->dev->features & NETIF_F_RXCSUM &&
>>>> -		    !(bp->dev->flags & IFF_PROMISC) &&
>>>> -		    GEM_BFEXT(RX_CSUM, ctrl) & GEM_RX_CSUM_CHECKED_MASK)
>>>> -			skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>>>> +		netdev_vdbg(bp->dev, "%s %u (len %u)\n", __func__, entry, data_len);
>>>>=20=20
>>>> -		bp->dev->stats.rx_packets++;
>>>> -		queue->stats.rx_packets++;
>>>> -		bp->dev->stats.rx_bytes +=3D skb->len;
>>>> -		queue->stats.rx_bytes +=3D skb->len;
>>>> +		if (ctrl & MACB_BIT(RX_EOF)) {
>>>> +			bp->dev->stats.rx_packets++;
>>>> +			queue->stats.rx_packets++;
>>>> +			bp->dev->stats.rx_bytes +=3D queue->skb->len;
>>>> +			queue->stats.rx_bytes +=3D queue->skb->len;
>>>>=20=20
>>>> -		gem_ptp_do_rxstamp(bp, skb, desc);
>>>> +			gem_ptp_do_rxstamp(bp, queue->skb, desc);
>>>>=20=20
>>>>  #if defined(DEBUG) && defined(VERBOSE_DEBUG)
>>>> -		netdev_vdbg(bp->dev, "received skb of length %u, csum: %08x\n",
>>>> -			    skb->len, skb->csum);
>>>> -		print_hex_dump(KERN_DEBUG, " mac: ", DUMP_PREFIX_ADDRESS, 16, 1,
>>>> -			       skb_mac_header(skb), 16, true);
>>>> -		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_ADDRESS, 16, 1,
>>>> -			       skb->data, 32, true);
>>>> +			netdev_vdbg(bp->dev, "received skb of length %u, csum: %08x\n",
>>>> +				    queue->skb->len, queue->skb->csum);
>>>> +			print_hex_dump(KERN_DEBUG, " mac: ", DUMP_PREFIX_ADDRESS, 16, 1,
>>>> +				       skb_mac_header(queue->skb), 16, true);
>>>> +			print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_ADDRESS, 16, 1,
>>>> +				       queue->skb->data, 32, true);
>>>>  #endif
>>>>=20=20
>>>> -		napi_gro_receive(napi, skb);
>>>> +			napi_gro_receive(napi, queue->skb);
>>>> +			queue->skb =3D NULL;
>>>> +		}
>>>> +
>>>> +		continue;
>>>> +
>>>> +free_frags:
>>>> +		if (queue->skb) {
>>>> +			dev_kfree_skb(queue->skb);
>>>> +			queue->skb =3D NULL;
>>>> +		} else {
>>>> +			page_pool_put_full_page(queue->page_pool,
>>>> +						virt_to_head_page(data),
>>>> +						false);
>>>> +		}
>>>>  	}
>>>>=20=20
>>>>  	gem_rx_refill(queue, true);
>>>> @@ -2394,7 +2429,10 @@ static void macb_init_rx_buffer_size(struct mac=
b *bp, size_t size)
>>>>  	if (!macb_is_gem(bp)) {
>>>>  		bp->rx_buffer_size =3D MACB_RX_BUFFER_SIZE;
>>>>  	} else {
>>>> -		bp->rx_buffer_size =3D size;
>>>> +		bp->rx_buffer_size =3D size + SKB_DATA_ALIGN(sizeof(struct skb_shar=
ed_info))
>>>> +			+ MACB_PP_HEADROOM;
>>>> +		if (bp->rx_buffer_size > PAGE_SIZE)
>>>> +			bp->rx_buffer_size =3D PAGE_SIZE;
>>>>=20=20
>>>>  		if (bp->rx_buffer_size % RX_BUFFER_MULTIPLE) {
>>>>  			netdev_dbg(bp->dev,
>>>> @@ -2589,18 +2627,15 @@ static int macb_alloc_consistent(struct macb *=
bp)
>>>>=20=20
>>>>  static void gem_create_page_pool(struct macb_queue *queue)
>>>>  {
>>>> -	unsigned int num_pages =3D DIV_ROUND_UP(queue->bp->rx_buffer_size, P=
AGE_SIZE);
>>>> -	struct macb *bp =3D queue->bp;
>>>>  	struct page_pool_params pp_params =3D {
>>>> -		.order =3D order_base_2(num_pages),
>>>> +		.order =3D 0,
>>>>  		.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
>>>>  		.pool_size =3D queue->bp->rx_ring_size,
>>>>  		.nid =3D NUMA_NO_NODE,
>>>>  		.dma_dir =3D DMA_FROM_DEVICE,
>>>>  		.dev =3D &queue->bp->pdev->dev,
>>>>  		.napi =3D &queue->napi_rx,
>>>> -		.offset =3D bp->rx_offset,
>>>> -		.max_len =3D MACB_PP_MAX_BUF_SIZE(num_pages),
>>>> +		.max_len =3D PAGE_SIZE,
>>>>  	};
>>>>  	struct page_pool *pool;
>>>
>>> I forgot about it in [PATCH 1/6], but the error handling if
>>> gem_create_page_pool() fails is odd. We set queue->page_pool to NULL
>>> and keep on going. Then once opened we'll fail allocating any buffer
>>> but still be open. Shouldn't we fail the link up operation?
>>>
>>> If we want to support this codepath (page pool not allocated), then we
>>> should unmask Rx interrupts only if alloc succeeded. I don't know if
>>> we'd want that though.
>>>
>>> 	queue_writel(queue, IER, bp->rx_intr_mask | ...);
>>>
>>
>> Makes sense to fail the link up.
>> Doesn't this imply to move the page pool creation and refill into
>> macb_open()?
>>
>> I didn't look into it, I'm not sure if this can potentially become a
>> bigger change.
>
> So I looked into it. Indeed buffer alloc should be done at open, doing
> it at link up (that cannot fail) makes no sense. It is probably
> historical, because on MACB it is mog_alloc_rx_buffers() that does all
> the alloc. On GEM it only does the ring buffer but not each individual
> slot buffer, which is done by ->mog_init_rings() / gem_rx_refill().
>
> I am linking a patch that applies before your series. Then the rebase
> conflict resolution is pretty simple, and the gem_create_page_pool()
> function should be adapted something like:
>

Th=C3=A9o, thanks for looking into this. I was pretty much working on
something similar for my next respin.

Do you prefer to post the patch separately, or are you ok if I pick this
up and send it on your behalf as part of this set?

> -- >8 ------------------------------------------------------------------
>
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index 3dcba7d672bf..55237b840289 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2865,7 +2865,7 @@ static int macb_alloc_consistent(struct macb *bp)
>    return -ENOMEM;
>  }
>
> -static void gem_create_page_pool(struct macb_queue *queue, int qid)
> +static int gem_create_page_pool(struct macb_queue *queue, int qid)
>  {
>    struct page_pool_params pp_params =3D {
>       .order =3D 0,
> @@ -2885,7 +2885,8 @@ static void gem_create_page_pool(struct macb_queue =
*queue, int qid)
>    pool =3D page_pool_create(&pp_params);
>    if (IS_ERR(pool)) {
>       netdev_err(queue->bp->dev, "cannot create rx page pool\n");
> -     pool =3D NULL;
> +     err =3D PTR_ERR(pool);
> +     goto clear_pool_ptr;
>    }
>
>    queue->page_pool =3D pool;
> @@ -2904,13 +2905,15 @@ static void gem_create_page_pool(struct macb_queu=
e *queue, int qid)
>       goto unreg_info;
>    }
>
> -  return;
> +  return 0;
>
>  unreg_info:
>    xdp_rxq_info_unreg(&queue->xdp_q);
>  destroy_pool:
>    page_pool_destroy(pool);
> +clear_pool_ptr:
>    queue->page_pool =3D NULL;
> +  return err;
>  }
>
>  static void macb_init_tieoff(struct macb *bp)
>
> -- >8 ------------------------------------------------------------------
>
> Regards,
>
> --
> Th=C3=A9o Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


