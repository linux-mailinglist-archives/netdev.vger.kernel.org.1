Return-Path: <netdev+bounces-249039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ECCD130B4
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6018830090B8
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C29A2B2D7;
	Mon, 12 Jan 2026 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLssFIE4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bBy5OUKN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEA527732
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227392; cv=none; b=RcOxkpCSOHU2TbI1I8fKtHL8W7XfN4x9pYOVDEPFK8Bx9j6Ps757rGiOiYS++XFE720koEzRZjWVBw5tKOz4pk3kUMF0v0w6Jag88W8UMAul7t9NbXUKH4qN0RAFn26d++mZyU5DCC7xMtqlYTW/xqKyLiGxPZdSroBmEdrQnIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227392; c=relaxed/simple;
	bh=4+pnmQgqhd1czHxEOGwf1E1wBhj637760UBpIYNnQ/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bcytvr/n6T1bX9MFxa9e0g7Y2JckznVFiasmkhdsIfcY8Ron9dPt6XR2V5iivL5ZvynIcZ3XeCAL2CV8OL8C2Q7RHaZpsiLgy2PPt76yc+4t/euivMF+bGrt8+4jmM9qOxMW3QVYW1yJPupiw3QeWrJGkap5Xo0caeyZsW/R9Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLssFIE4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bBy5OUKN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768227389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6bhUGrqBV3FoJ4RYUkaj/WBlm3E9rkwWBxx6hvThBwc=;
	b=gLssFIE4Pf8te33rAlXcFfs7wJbcOM7H/d/qiIh5HVqwbzcz6V/0Q0Ju4OZMKs6qPqTm3u
	kp7Pnanexl9YKWJp4YqEnBh+pBRZpyEQhUu+IufXHxQ8aEs+Bwao6Asyp9LRjSWkX6XiG9
	zeTcktsq8CUMLMSeylHyaSBzZJ5uZZ8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-oJDZUgStN1-Oo1ts_P_WgA-1; Mon, 12 Jan 2026 09:16:28 -0500
X-MC-Unique: oJDZUgStN1-Oo1ts_P_WgA-1
X-Mimecast-MFC-AGG-ID: oJDZUgStN1-Oo1ts_P_WgA_1768227387
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43065ad16a8so3623061f8f.1
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 06:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768227387; x=1768832187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6bhUGrqBV3FoJ4RYUkaj/WBlm3E9rkwWBxx6hvThBwc=;
        b=bBy5OUKNP5++/tBiF5o2R4i8a4ZTMmiO3J80efab/YAI7pYDh9vaHy8GTIRyKz3jZC
         HLu8PNE7RT2MD3KakS+Atwy1yczuz9mLo7r0rPaK1yDwY2wsspV8BHged3ztXHejKk1I
         8aIhAgXij1KjQVvjmZJHQIHc9I0vwxRAngVtpgH9Ehq9Y59ausiSAl5/EQQ/5i/JOg0f
         BZQJvcmspXg6cFzF4ewZi/TPYySWysWOifWJKa70bZKJB7c/1ZM7TM80huKPwzXvaudx
         P0vZTw0aqiewVXVCxTdu0LjBmCHqralSc5qa3h8S1AVdzCrFHYmspwGRi1WxJRBjjmSH
         +9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768227387; x=1768832187;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6bhUGrqBV3FoJ4RYUkaj/WBlm3E9rkwWBxx6hvThBwc=;
        b=J1+xP2lAdS3WGxhniIAX356FRiwwVzVGEFUL9oeVqgGAv3BaLohtaMGW0oCp4m4yu/
         RiaX1mOWE7udpkPMjHiYnQpu7q3brTtCFGa9cApEWgnb8wWwo/McYZAFU1hXVGMM1ET6
         4KGSFBcvkYHZop5GZ4rnciqire9vvjm/VfPfICeQzP73FOL7bIm4r5jCrq+58Jks1b5i
         zTHf+02orBs7GmS6PyPhU/kAv8GnoVfWZKz27z6q0sSP9rSAntEJapDtetDOws9xRaGf
         MwS2OC9dj7d4WClVAoOLvr/Hd+m5B92WEZc/cF5TkcTJUpMcPmhF2jBXDCsaLG6l+HeJ
         emkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE4eXdVaFdUI6Oic1j2QpbVAd3+AIQoCpvN9Acp2wg1NoAX0rqeD4aC6u29wcn6T5GjQ8mQX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK8qDuSGHW+xYByJG1Mn0ISPli2vy4depm59LA6MTHZjaBm+Fe
	27vbvA7HGwwN6eHewPBtVVj2Vwdf+7G97ELUAnB8H1Pl2PkSygMIk1pa4EGbRGo/2cTsjzFFaUZ
	kGO3yY8NnKx2x2FYQiOhamadjtAjgkrTGU7dp1ghBG1+jABKwL3KLAOe/Ug==
X-Gm-Gg: AY/fxX60m6ky1VzhIjYbSJaVYAjeCkzQri5e0Z5VKhEyIAh3/TBXkDoYnsI+fW30cSm
	U7/0RyKVCXghrvg19DgQMtY4kRTpfJRjAU+3+XlhgKiiC1rmuc/haDcMY415PaVly/ZTjg23hj+
	h0qAAQ3gVsT7lsz1kQb3PUS1RrOAPGEbLs7CtL1I0f7PaXeD8p5mGcFZ7ZL/qGvF78g/EJ5DfzA
	rQbK+Q6JJffs6ga/0uk6q2C8JY3yxZaHHSrMTBN/v2Rl8/qyfDjqvzArF1f02ihYzWFCFgQhYmv
	QKw5bK/hnlAYgEJe44bte8ka/9feNSz9cviodo9EGnmY2ztCz9AbAqnIIeH2M3thULNzMBi41oM
	1Rbiss+J5iUXmDTa/EhCC5rnLah2hTvGJs6VQaTyxhZEOsgA=
X-Received: by 2002:a05:6000:4284:b0:432:bc90:2cfa with SMTP id ffacd0b85a97d-432c374f5b2mr21938937f8f.33.1768227386422;
        Mon, 12 Jan 2026 06:16:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFv7zOvFKVlgyNqu+2DPq8VeerkFYZptKZNtybGzVfF1fd9yNHrvqnAVfaEDbpzXX5IiFU/cA==
X-Received: by 2002:a05:6000:4284:b0:432:bc90:2cfa with SMTP id ffacd0b85a97d-432c374f5b2mr21938870f8f.33.1768227385665;
        Mon, 12 Jan 2026 06:16:25 -0800 (PST)
Received: from localhost (net-37-117-189-93.cust.vodafonedsl.it. [37.117.189.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0daa78sm39403815f8f.6.2026.01.12.06.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:16:25 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>,
 netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, =?utf-8?Q?Th=C3=A9o?= Lebrun
 <theo.lebrun@bootlin.com>
Subject: Re: [PATCH RFC net-next v2 3/8] cadence: macb: Add page pool
 support handle multi-descriptor frame rx
In-Reply-To: <DFJBNAK0H1KV.1HVW5GR7V4Q2B@bootlin.com>
References: <20251220235135.1078587-1-pvalerio@redhat.com>
 <20251220235135.1078587-4-pvalerio@redhat.com>
 <DFJBNAK0H1KV.1HVW5GR7V4Q2B@bootlin.com>
Date: Mon, 12 Jan 2026 15:16:24 +0100
Message-ID: <87jyxmor0n.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08 Jan 2026 at 04:43:43 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> w=
rote:

> On Sun Dec 21, 2025 at 12:51 AM CET, Paolo Valerio wrote:
>> Use the page pool allocator for the data buffers and enable skb recycling
>> support, instead of relying on netdev_alloc_skb allocating the entire skb
>> during the refill.
>>
>> The patch also add support for receiving network frames that span multip=
le
>> DMA descriptors in the Cadence MACB/GEM Ethernet driver.
>>
>> The patch removes the requirement that limited frame reception to
>> a single descriptor (RX_SOF && RX_EOF), also avoiding potential
>> contiguous multi-page allocation for large frames.
>>
>> Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
>> ---
>>  drivers/net/ethernet/cadence/Kconfig     |   1 +
>>  drivers/net/ethernet/cadence/macb.h      |   5 +
>>  drivers/net/ethernet/cadence/macb_main.c | 345 +++++++++++++++--------
>>  3 files changed, 235 insertions(+), 116 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/cadence/Kconfig b/drivers/net/ethernet=
/cadence/Kconfig
>> index 5b2a461dfd28..ae500f717433 100644
>> --- a/drivers/net/ethernet/cadence/Kconfig
>> +++ b/drivers/net/ethernet/cadence/Kconfig
>> @@ -25,6 +25,7 @@ config MACB
>>  	depends on PTP_1588_CLOCK_OPTIONAL
>>  	select PHYLINK
>>  	select CRC32
>> +	select PAGE_POOL
>>  	help
>>  	  The Cadence MACB ethernet interface is found on many Atmel AT32 and
>>  	  AT91 parts.  This driver also supports the Cadence GEM (Gigabit
>> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/=
cadence/macb.h
>> index 3b184e9ac771..45c04157f153 100644
>> --- a/drivers/net/ethernet/cadence/macb.h
>> +++ b/drivers/net/ethernet/cadence/macb.h
>> @@ -14,6 +14,8 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/phy/phy.h>
>>  #include <linux/workqueue.h>
>> +#include <net/page_pool/helpers.h>
>> +#include <net/xdp.h>
>
> nit: `#include <net/xdp.h>` is not needed yet.
>

ack

>>=20=20
>>  #define MACB_GREGS_NBR 16
>>  #define MACB_GREGS_VERSION 2
>> @@ -1266,6 +1268,8 @@ struct macb_queue {
>>  	void			*rx_buffers;
>>  	struct napi_struct	napi_rx;
>>  	struct queue_stats stats;
>> +	struct page_pool	*page_pool;
>> +	struct sk_buff		*skb;
>>  };
>>=20=20
>>  struct ethtool_rx_fs_item {
>> @@ -1289,6 +1293,7 @@ struct macb {
>>  	struct macb_dma_desc	*rx_ring_tieoff;
>>  	dma_addr_t		rx_ring_tieoff_dma;
>>  	size_t			rx_buffer_size;
>> +	size_t			rx_headroom;
>>=20=20
>>  	unsigned int		rx_ring_size;
>>  	unsigned int		tx_ring_size;
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethe=
rnet/cadence/macb_main.c
>> index b4e2444b2e95..9e1efc1f56d8 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -1249,14 +1249,22 @@ static int macb_tx_complete(struct macb_queue *q=
ueue, int budget)
>>  	return packets;
>>  }
>>=20=20
>> -static int gem_rx_refill(struct macb_queue *queue)
>> +static int gem_total_rx_buffer_size(struct macb *bp)
>> +{
>> +	return SKB_HEAD_ALIGN(bp->rx_buffer_size + bp->rx_headroom);
>> +}
>
> nit: something closer to a buffer size, either `unsigned int` or
> `size_t`, sounds better than an int return type.
>

will do

>> +
>> +static int gem_rx_refill(struct macb_queue *queue, bool napi)
>>  {
>>  	unsigned int		entry;
>> -	struct sk_buff		*skb;
>>  	dma_addr_t		paddr;
>> +	void			*data;
>>  	struct macb *bp =3D queue->bp;
>>  	struct macb_dma_desc *desc;
>> +	struct page *page;
>> +	gfp_t gfp_alloc;
>>  	int err =3D 0;
>> +	int offset;
>>=20=20
>>  	while (CIRC_SPACE(queue->rx_prepared_head, queue->rx_tail,
>>  			bp->rx_ring_size) > 0) {
>> @@ -1268,25 +1276,20 @@ static int gem_rx_refill(struct macb_queue *queu=
e)
>>  		desc =3D macb_rx_desc(queue, entry);
>>=20=20
>>  		if (!queue->rx_buff[entry]) {
>> -			/* allocate sk_buff for this free entry in ring */
>> -			skb =3D netdev_alloc_skb(bp->dev, bp->rx_buffer_size);
>> -			if (unlikely(!skb)) {
>> +			gfp_alloc =3D napi ? GFP_ATOMIC : GFP_KERNEL;
>> +			page =3D page_pool_alloc_frag(queue->page_pool, &offset,
>> +						    gem_total_rx_buffer_size(bp),
>> +						    gfp_alloc | __GFP_NOWARN);
>> +			if (!page) {
>>  				netdev_err(bp->dev,
>> -					   "Unable to allocate sk_buff\n");
>> +					   "Unable to allocate page\n");
>>  				err =3D -ENOMEM;
>>  				break;
>>  			}
>>=20=20
>> -			/* now fill corresponding descriptor entry */
>> -			paddr =3D dma_map_single(&bp->pdev->dev, skb->data,
>> -					       bp->rx_buffer_size,
>> -					       DMA_FROM_DEVICE);
>> -			if (dma_mapping_error(&bp->pdev->dev, paddr)) {
>> -				dev_kfree_skb(skb);
>> -				break;
>> -			}
>> -
>> -			queue->rx_buff[entry] =3D skb;
>> +			paddr =3D page_pool_get_dma_addr(page) + XDP_PACKET_HEADROOM + offse=
t;
>> +			data =3D page_address(page) + offset;
>> +			queue->rx_buff[entry] =3D data;
>>=20=20
>>  			if (entry =3D=3D bp->rx_ring_size - 1)
>>  				paddr |=3D MACB_BIT(RX_WRAP);
>> @@ -1296,20 +1299,6 @@ static int gem_rx_refill(struct macb_queue *queue)
>>  			 */
>>  			dma_wmb();
>>  			macb_set_addr(bp, desc, paddr);
>> -
>> -			/* Properly align Ethernet header.
>> -			 *
>> -			 * Hardware can add dummy bytes if asked using the RBOF
>> -			 * field inside the NCFGR register. That feature isn't
>> -			 * available if hardware is RSC capable.
>> -			 *
>> -			 * We cannot fallback to doing the 2-byte shift before
>> -			 * DMA mapping because the address field does not allow
>> -			 * setting the low 2/3 bits.
>> -			 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
>> -			 */
>> -			if (!(bp->caps & MACB_CAPS_RSC))
>> -				skb_reserve(skb, NET_IP_ALIGN);
>>  		} else {
>>  			desc->ctrl =3D 0;
>>  			dma_wmb();
>> @@ -1353,14 +1342,19 @@ static int gem_rx(struct macb_queue *queue, stru=
ct napi_struct *napi,
>>  	struct macb *bp =3D queue->bp;
>>  	unsigned int		len;
>>  	unsigned int		entry;
>> -	struct sk_buff		*skb;
>>  	struct macb_dma_desc	*desc;
>> +	int			data_len;
>>  	int			count =3D 0;
>> +	void			*buff_head;
>> +	struct skb_shared_info	*shinfo;
>> +	struct page		*page;
>> +	int			nr_frags;
>
> nit: you add 5 new stack variables, maybe you could apply reverse xmas
> tree while at it. You do it for the loop body in [5/8].
>

sure

>> +
>>=20=20
>>  	while (count < budget) {
>>  		u32 ctrl;
>>  		dma_addr_t addr;
>> -		bool rxused;
>> +		bool rxused, first_frame;
>>=20=20
>>  		entry =3D macb_rx_ring_wrap(bp, queue->rx_tail);
>>  		desc =3D macb_rx_desc(queue, entry);
>> @@ -1374,6 +1368,12 @@ static int gem_rx(struct macb_queue *queue, struc=
t napi_struct *napi,
>>  		if (!rxused)
>>  			break;
>>=20=20
>> +		if (!(bp->caps & MACB_CAPS_RSC))
>> +			addr +=3D NET_IP_ALIGN;
>> +
>> +		dma_sync_single_for_cpu(&bp->pdev->dev,
>> +					addr, bp->rx_buffer_size,
>> +					page_pool_get_dma_dir(queue->page_pool));
>>  		/* Ensure ctrl is at least as up-to-date as rxused */
>>  		dma_rmb();
>>=20=20
>> @@ -1382,58 +1382,118 @@ static int gem_rx(struct macb_queue *queue, str=
uct napi_struct *napi,
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
>> -		skb =3D queue->rx_buff[entry];
>> -		if (unlikely(!skb)) {
>> +		buff_head =3D queue->rx_buff[entry];
>> +		if (unlikely(!buff_head)) {
>>  			netdev_err(bp->dev,
>>  				   "inconsistent Rx descriptor chain\n");
>>  			bp->dev->stats.rx_dropped++;
>>  			queue->stats.rx_dropped++;
>>  			break;
>>  		}
>> -		/* now everything is ready for receiving packet */
>> -		queue->rx_buff[entry] =3D NULL;
>> +
>> +		first_frame =3D ctrl & MACB_BIT(RX_SOF);
>>  		len =3D ctrl & bp->rx_frm_len_mask;
>>=20=20
>> -		netdev_vdbg(bp->dev, "gem_rx %u (len %u)\n", entry, len);
>> +		if (len) {
>> +			data_len =3D len;
>> +			if (!first_frame)
>> +				data_len -=3D queue->skb->len;
>> +		} else {
>> +			data_len =3D bp->rx_buffer_size;
>> +		}
>
> Why deal with the `!len` case? How can it occur? User guide doesn't hint
> that. It would mean we would grab uninitialised bytes as we assume len
> is the max buffer size.
>

Good point. After taking a second look, !len may not be the most reliable
way to check this.
From the datasheet, status signals are only valid (with some exceptions)
when MACB_BIT(RX_EOF) is set. As a side effect, len is always zero on my
hw for frames without the EOF bit, but it's probably better to just rely
on MACB_BIT(RX_EOF) instead of reading something that may end up being
unreliable.

>> +
>> +		if (first_frame) {
>> +			queue->skb =3D napi_build_skb(buff_head, gem_total_rx_buffer_size(bp=
));
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
>> +			skb_reserve(queue->skb, bp->rx_headroom);
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
>> +
>> +			shinfo =3D skb_shinfo(queue->skb);
>> +			page =3D virt_to_head_page(buff_head);
>> +			nr_frags =3D shinfo->nr_frags;
>> +
>> +			if (nr_frags >=3D ARRAY_SIZE(shinfo->frags))
>> +				goto free_frags;
>>=20=20
>> -		skb_put(skb, len);
>> -		dma_unmap_single(&bp->pdev->dev, addr,
>> -				 bp->rx_buffer_size, DMA_FROM_DEVICE);
>> +			skb_add_rx_frag(queue->skb, nr_frags, page,
>> +					buff_head - page_address(page) + bp->rx_headroom,
>> +					data_len, gem_total_rx_buffer_size(bp));
>> +		}
>> +
>> +		/* now everything is ready for receiving packet */
>> +		queue->rx_buff[entry] =3D NULL;
>>=20=20
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
>> +			print_hex_dump(KERN_DEBUG, "buff_head: ", DUMP_PREFIX_ADDRESS, 16, 1,
>> +				       queue->skb->buff_head, 32, true);
>>  #endif
>
> nit: while you are at it, maybe replace with print_hex_dump_debug()?
>

sure

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
>> +						virt_to_head_page(buff_head),
>> +						false);
>> +		}
>> +
>> +		bp->dev->stats.rx_dropped++;
>> +		queue->stats.rx_dropped++;
>> +		queue->rx_buff[entry] =3D NULL;
>>  	}
>>=20=20
>> -	gem_rx_refill(queue);
>> +	gem_rx_refill(queue, true);
>>=20=20
>>  	return count;
>>  }
>> @@ -2367,12 +2427,25 @@ static netdev_tx_t macb_start_xmit(struct sk_buf=
f *skb, struct net_device *dev)
>>  	return ret;
>>  }
>>=20=20
>> -static void macb_init_rx_buffer_size(struct macb *bp, size_t size)
>> +static void macb_init_rx_buffer_size(struct macb *bp, unsigned int mtu)
>>  {
>> +	int overhead;
>
> nit: Maybe `unsigned int` or `size_t` rather than `int`?
>

ack

>> +	size_t size;
>> +
>>  	if (!macb_is_gem(bp)) {
>>  		bp->rx_buffer_size =3D MACB_RX_BUFFER_SIZE;
>>  	} else {
>> -		bp->rx_buffer_size =3D size;
>> +		size =3D mtu + ETH_HLEN + ETH_FCS_LEN;
>> +		if (!(bp->caps & MACB_CAPS_RSC))
>> +			size +=3D NET_IP_ALIGN;
>
> NET_IP_ALIGN looks like it is accounted for twice, once in
> bp->rx_headroom and once in bp->rx_buffer_size. This gets fixed in
> [5/8] where gem_max_rx_data_size() gets introduced.
>

ah, right

>> +
>> +		bp->rx_buffer_size =3D SKB_DATA_ALIGN(size);
>> +		if (gem_total_rx_buffer_size(bp) > PAGE_SIZE) {
>> +			overhead =3D bp->rx_headroom +
>> +				SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>> +			bp->rx_buffer_size =3D rounddown(PAGE_SIZE - overhead,
>> +						       RX_BUFFER_MULTIPLE);
>> +		}
>
> I've seen your comment in [0/8]. Do you have any advice on how to test
> this clamping? All I can think of is to either configure a massive MTU
> or, more easily, cheat with the headroom.
>

I normally test the set with 4k PAGE_SIZE and, as you said, setting the
mtu to something bigger than that. This is still possible with 8k pages
(given .jumbo_max_len =3D 10240).


> Also, should we warn? It means MTU-sized packets will be received in
> fragments. It will work but is probably unexpected by users and a
> slowdown reason that users might want to know about.
>

I'm not sure about the warning as I don't see this as a user level detail.
For debugging purpose, I guess we should be fine the last print out (even
better once extended with your suggestion). Of course, feel free to disagre=
e.

> --
>
> nit: while in macb_init_rx_buffer_size(), can you tweak the debug line
> from mtu & rx_buffer_size to also have rx_headroom and total? So that
> we have everything available to understand what is going on buffer size
> wise. Something like:
>
> -       netdev_dbg(bp->dev, "mtu [%u] rx_buffer_size [%zu]\n",
> -                  bp->dev->mtu, bp->rx_buffer_size);
> +       netdev_info(bp->dev, "mtu [%u] rx_buffer_size [%zu] rx_headroom [=
%zu] total [%u]\n",
> +                   bp->dev->mtu, bp->rx_buffer_size, bp->rx_headroom,
> +                   gem_total_rx_buffer_size(bp));
>
> Thanks,
>
> --
> Th=C3=A9o Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


