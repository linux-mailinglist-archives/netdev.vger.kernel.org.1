Return-Path: <netdev+bounces-249144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87540D14CB5
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 19:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 017AD300E3F3
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 18:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ECA3876B9;
	Mon, 12 Jan 2026 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lamw+ZXO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="drsjlDwA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8D0199EAD
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768243446; cv=none; b=UQQDV81l8Ok8c3O4Qmpe2+TGuS5yDtYwT+fVEC0Ig2cTZ6CjfChW+shh7xyai7FLg97+6rjs8paNri3yQ6ZMzPCz/pZECdOH7t7EZOsbIrAK1/Fv1yGIOnY46iUAXyK7lbWsb3vc9ZgSRWHm1ieOu+0839oQxBLacXKbEljp7v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768243446; c=relaxed/simple;
	bh=81uoW7RiAwd/+PcCjxOiwxmNlgN3vxRs63w6JR8K22M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X/evlq/Oo7FAVxe5LtHlQFMNVIXbFA0+N9pJJXbdwjuAcWDMzyeIo/CfRY601PPEEsZWuiUJzsGrxuIMTkiuHWqnwpaYGvdj4YM26Xkg3B5OyGZBzD8Y54vZ6RUls1uKRqM3x7ATSpvYNtQ1Wd1obJyp6FvMiqRRVC8YDUV4M7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lamw+ZXO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=drsjlDwA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768243443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8wNI2Of7BDtHuhDMnpSUxSe/SQ1yNas7uqHHF+UCzwM=;
	b=Lamw+ZXOR6e9bLl0z57pmpScSwVfdfGRvSQ4UEReMmNH9F9wbl/ACWI78IKNPRNyCvhb8K
	ckBod0z0xYC2YAM9AdvfTJAxiKyXUTeFrcIxmbZGLuXQ5mwXwdCTunn0mRsLzJCYc+QX3v
	yoHoIqhYunXsVpWfhDhgR6iH1TxxaeA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-QZXAMw3QOmyQj8mHNvCRXQ-1; Mon, 12 Jan 2026 13:43:28 -0500
X-MC-Unique: QZXAMw3QOmyQj8mHNvCRXQ-1
X-Mimecast-MFC-AGG-ID: QZXAMw3QOmyQj8mHNvCRXQ_1768243407
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso83614255e9.2
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 10:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768243407; x=1768848207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wNI2Of7BDtHuhDMnpSUxSe/SQ1yNas7uqHHF+UCzwM=;
        b=drsjlDwAP0L7BiQA0wXE+mE2UH6KAKBCVg2972g2mQXG6wMfXbNxgFd3X4WI6qh2lN
         /dJAu7TEd754zYXnISCVNKO6i0rcQGKAUDv27t39FV1mfjMeC8DUmDz5WpXd1jIuExUh
         MNJdah9XLbX6KR3F8nnyAxQp8iNWTVvgBHniJ6XQyyO99NsogzmTObCPMSRnxf4NXT/0
         TVLGI/c76PBwtGjqeFeHgPxfKadXlaUFLQtGIwDt33P2xfPsuGrHsfHiE25XcMBPTRCu
         4UlWvWiyFCIQgpSy/BRmfjFG5VX0AVr1B3rjxk8gK4YfMWh0JqY1YjPH/sZoufjX/0Rz
         cvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768243407; x=1768848207;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8wNI2Of7BDtHuhDMnpSUxSe/SQ1yNas7uqHHF+UCzwM=;
        b=jzTW5usvBgYtT94yM/SC4B4I+q3SWHgM2ZBe8zngUBJjahruF4bzRd5mXkYMSHWj+1
         FIu+O0ZfiWr9eL0pPyN1/0FF0vu9RPZJ1lhA9gLubq3BiHuN+5XbWZ1b8rQ4U6LrbR4E
         0fcvDGNbg6A88Y6KHql1iZclcRX+iKDTDyndsp0pi6hsG5Zx0cWwawtw9YCz3Zi3w4YU
         AqFg6zwjhCKJMSd8259+JZa5kk2GchGPEbim5J1Sh7xELOCJTWrc3zwc3N22nYD0oL1h
         5cB/7xWcDKFd0iGn+1aWMs/CkerYtswoEIb7OPnnMuSRkShQOeFrxnrUXztojTCKTamk
         eQOA==
X-Forwarded-Encrypted: i=1; AJvYcCXHVSrcxBrWPSfu1XwNHI3q04LCQ9zDUjTKc1fhN+p1ivXCJjCasV+pSW5956rdKstKrPhHq8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlPkRFd3vNWB2i8EFSnL1v5JiY3lBtp3zNCP7c1Jqg/jwI35yE
	YHwA095f58eE5zxOREu6SWyaf+cWCv1fI8LXGBcjhIkLV8fc9E0w8C9KkAli5PpHrjvIko4bg4S
	KEIPOlNvIajiIlL5BIBT1qAiXuFl9A8hWy31C1zlhQNWd3AEGP2K/s6s1Vg==
X-Gm-Gg: AY/fxX7qRK4Gg2E2E9mVUEUHITTPxD5A2YRL2uBfNHE9WE1KCoekrEEgTIInrhsJQVb
	GRlYSYb/qlp11HmrJvwoDPeCKhcn12EGkLi3eYUGSwAVa68oIK7/UZGAp3Ux6u9d+NIdfvfkHMA
	dy4OqUP3d3W2E7z9VaVINtm7p7tCawfsoB2xxJD5jJP3EzQb/kOPQR7KvJA8R2HNwHdapeetsVt
	krsBPlbxVm13fgl9Dn5dofKi3kIU61AhaQN1+RCD3lzSl2jvnv3VANWRjjcmxcuE2gVfx8XD3GN
	EbB2n8cMy7c1B3w4TLhjgXWAZP0wIMnUh8w8Ewv9flfLflMHdBFduh+Hjqf2iiLbBHH511coFOr
	hUf6ALtMVwIclhOWhMu3UcW07uZsMEiBxQ9Fzinp8SzQg4cc=
X-Received: by 2002:a05:600c:1992:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-47d84b4a815mr231630315e9.32.1768243406801;
        Mon, 12 Jan 2026 10:43:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGu3Vx93vXLk6SrfQLnulynU/0MvPaEyzfC4FWSzxWGXrMV9DGHBIYmvaQrc2mLdmUcHb2OOA==
X-Received: by 2002:a05:600c:1992:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-47d84b4a815mr231630035e9.32.1768243406215;
        Mon, 12 Jan 2026 10:43:26 -0800 (PST)
Received: from localhost (net-37-117-189-93.cust.vodafonedsl.it. [37.117.189.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f653cd6sm386290365e9.9.2026.01.12.10.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:43:25 -0800 (PST)
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
In-Reply-To: <87jyxmor0n.fsf@redhat.com>
References: <20251220235135.1078587-1-pvalerio@redhat.com>
 <20251220235135.1078587-4-pvalerio@redhat.com>
 <DFJBNAK0H1KV.1HVW5GR7V4Q2B@bootlin.com> <87jyxmor0n.fsf@redhat.com>
Date: Mon, 12 Jan 2026 19:43:14 +0100
Message-ID: <87344ahdtp.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12 Jan 2026 at 03:16:24 PM, Paolo Valerio <pvalerio@redhat.com> wrote:

> On 08 Jan 2026 at 04:43:43 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>=
 wrote:
>
>> On Sun Dec 21, 2025 at 12:51 AM CET, Paolo Valerio wrote:
>>> Use the page pool allocator for the data buffers and enable skb recycli=
ng
>>> support, instead of relying on netdev_alloc_skb allocating the entire s=
kb
>>> during the refill.
>>>
>>> The patch also add support for receiving network frames that span multi=
ple
>>> DMA descriptors in the Cadence MACB/GEM Ethernet driver.
>>>
>>> The patch removes the requirement that limited frame reception to
>>> a single descriptor (RX_SOF && RX_EOF), also avoiding potential
>>> contiguous multi-page allocation for large frames.
>>>
>>> Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
>>> ---
>>>  drivers/net/ethernet/cadence/Kconfig     |   1 +
>>>  drivers/net/ethernet/cadence/macb.h      |   5 +
>>>  drivers/net/ethernet/cadence/macb_main.c | 345 +++++++++++++++--------
>>>  3 files changed, 235 insertions(+), 116 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/cadence/Kconfig b/drivers/net/etherne=
t/cadence/Kconfig
>>> index 5b2a461dfd28..ae500f717433 100644
>>> --- a/drivers/net/ethernet/cadence/Kconfig
>>> +++ b/drivers/net/ethernet/cadence/Kconfig
>>> @@ -25,6 +25,7 @@ config MACB
>>>  	depends on PTP_1588_CLOCK_OPTIONAL
>>>  	select PHYLINK
>>>  	select CRC32
>>> +	select PAGE_POOL
>>>  	help
>>>  	  The Cadence MACB ethernet interface is found on many Atmel AT32 and
>>>  	  AT91 parts.  This driver also supports the Cadence GEM (Gigabit
>>> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet=
/cadence/macb.h
>>> index 3b184e9ac771..45c04157f153 100644
>>> --- a/drivers/net/ethernet/cadence/macb.h
>>> +++ b/drivers/net/ethernet/cadence/macb.h
>>> @@ -14,6 +14,8 @@
>>>  #include <linux/interrupt.h>
>>>  #include <linux/phy/phy.h>
>>>  #include <linux/workqueue.h>
>>> +#include <net/page_pool/helpers.h>
>>> +#include <net/xdp.h>
>>
>> nit: `#include <net/xdp.h>` is not needed yet.
>>
>
> ack
>
>>>=20=20
>>>  #define MACB_GREGS_NBR 16
>>>  #define MACB_GREGS_VERSION 2
>>> @@ -1266,6 +1268,8 @@ struct macb_queue {
>>>  	void			*rx_buffers;
>>>  	struct napi_struct	napi_rx;
>>>  	struct queue_stats stats;
>>> +	struct page_pool	*page_pool;
>>> +	struct sk_buff		*skb;
>>>  };
>>>=20=20
>>>  struct ethtool_rx_fs_item {
>>> @@ -1289,6 +1293,7 @@ struct macb {
>>>  	struct macb_dma_desc	*rx_ring_tieoff;
>>>  	dma_addr_t		rx_ring_tieoff_dma;
>>>  	size_t			rx_buffer_size;
>>> +	size_t			rx_headroom;
>>>=20=20
>>>  	unsigned int		rx_ring_size;
>>>  	unsigned int		tx_ring_size;
>>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
>>> index b4e2444b2e95..9e1efc1f56d8 100644
>>> --- a/drivers/net/ethernet/cadence/macb_main.c
>>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>>> @@ -1249,14 +1249,22 @@ static int macb_tx_complete(struct macb_queue *=
queue, int budget)
>>>  	return packets;
>>>  }
>>>=20=20
>>> -static int gem_rx_refill(struct macb_queue *queue)
>>> +static int gem_total_rx_buffer_size(struct macb *bp)
>>> +{
>>> +	return SKB_HEAD_ALIGN(bp->rx_buffer_size + bp->rx_headroom);
>>> +}
>>
>> nit: something closer to a buffer size, either `unsigned int` or
>> `size_t`, sounds better than an int return type.
>>
>
> will do
>
>>> +
>>> +static int gem_rx_refill(struct macb_queue *queue, bool napi)
>>>  {
>>>  	unsigned int		entry;
>>> -	struct sk_buff		*skb;
>>>  	dma_addr_t		paddr;
>>> +	void			*data;
>>>  	struct macb *bp =3D queue->bp;
>>>  	struct macb_dma_desc *desc;
>>> +	struct page *page;
>>> +	gfp_t gfp_alloc;
>>>  	int err =3D 0;
>>> +	int offset;
>>>=20=20
>>>  	while (CIRC_SPACE(queue->rx_prepared_head, queue->rx_tail,
>>>  			bp->rx_ring_size) > 0) {
>>> @@ -1268,25 +1276,20 @@ static int gem_rx_refill(struct macb_queue *que=
ue)
>>>  		desc =3D macb_rx_desc(queue, entry);
>>>=20=20
>>>  		if (!queue->rx_buff[entry]) {
>>> -			/* allocate sk_buff for this free entry in ring */
>>> -			skb =3D netdev_alloc_skb(bp->dev, bp->rx_buffer_size);
>>> -			if (unlikely(!skb)) {
>>> +			gfp_alloc =3D napi ? GFP_ATOMIC : GFP_KERNEL;
>>> +			page =3D page_pool_alloc_frag(queue->page_pool, &offset,
>>> +						    gem_total_rx_buffer_size(bp),
>>> +						    gfp_alloc | __GFP_NOWARN);
>>> +			if (!page) {
>>>  				netdev_err(bp->dev,
>>> -					   "Unable to allocate sk_buff\n");
>>> +					   "Unable to allocate page\n");
>>>  				err =3D -ENOMEM;
>>>  				break;
>>>  			}
>>>=20=20
>>> -			/* now fill corresponding descriptor entry */
>>> -			paddr =3D dma_map_single(&bp->pdev->dev, skb->data,
>>> -					       bp->rx_buffer_size,
>>> -					       DMA_FROM_DEVICE);
>>> -			if (dma_mapping_error(&bp->pdev->dev, paddr)) {
>>> -				dev_kfree_skb(skb);
>>> -				break;
>>> -			}
>>> -
>>> -			queue->rx_buff[entry] =3D skb;
>>> +			paddr =3D page_pool_get_dma_addr(page) + XDP_PACKET_HEADROOM + offs=
et;
>>> +			data =3D page_address(page) + offset;
>>> +			queue->rx_buff[entry] =3D data;
>>>=20=20
>>>  			if (entry =3D=3D bp->rx_ring_size - 1)
>>>  				paddr |=3D MACB_BIT(RX_WRAP);
>>> @@ -1296,20 +1299,6 @@ static int gem_rx_refill(struct macb_queue *queu=
e)
>>>  			 */
>>>  			dma_wmb();
>>>  			macb_set_addr(bp, desc, paddr);
>>> -
>>> -			/* Properly align Ethernet header.
>>> -			 *
>>> -			 * Hardware can add dummy bytes if asked using the RBOF
>>> -			 * field inside the NCFGR register. That feature isn't
>>> -			 * available if hardware is RSC capable.
>>> -			 *
>>> -			 * We cannot fallback to doing the 2-byte shift before
>>> -			 * DMA mapping because the address field does not allow
>>> -			 * setting the low 2/3 bits.
>>> -			 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
>>> -			 */
>>> -			if (!(bp->caps & MACB_CAPS_RSC))
>>> -				skb_reserve(skb, NET_IP_ALIGN);
>>>  		} else {
>>>  			desc->ctrl =3D 0;
>>>  			dma_wmb();
>>> @@ -1353,14 +1342,19 @@ static int gem_rx(struct macb_queue *queue, str=
uct napi_struct *napi,
>>>  	struct macb *bp =3D queue->bp;
>>>  	unsigned int		len;
>>>  	unsigned int		entry;
>>> -	struct sk_buff		*skb;
>>>  	struct macb_dma_desc	*desc;
>>> +	int			data_len;
>>>  	int			count =3D 0;
>>> +	void			*buff_head;
>>> +	struct skb_shared_info	*shinfo;
>>> +	struct page		*page;
>>> +	int			nr_frags;
>>
>> nit: you add 5 new stack variables, maybe you could apply reverse xmas
>> tree while at it. You do it for the loop body in [5/8].
>>
>
> sure
>
>>> +
>>>=20=20
>>>  	while (count < budget) {
>>>  		u32 ctrl;
>>>  		dma_addr_t addr;
>>> -		bool rxused;
>>> +		bool rxused, first_frame;
>>>=20=20
>>>  		entry =3D macb_rx_ring_wrap(bp, queue->rx_tail);
>>>  		desc =3D macb_rx_desc(queue, entry);
>>> @@ -1374,6 +1368,12 @@ static int gem_rx(struct macb_queue *queue, stru=
ct napi_struct *napi,
>>>  		if (!rxused)
>>>  			break;
>>>=20=20
>>> +		if (!(bp->caps & MACB_CAPS_RSC))
>>> +			addr +=3D NET_IP_ALIGN;
>>> +
>>> +		dma_sync_single_for_cpu(&bp->pdev->dev,
>>> +					addr, bp->rx_buffer_size,
>>> +					page_pool_get_dma_dir(queue->page_pool));
>>>  		/* Ensure ctrl is at least as up-to-date as rxused */
>>>  		dma_rmb();
>>>=20=20
>>> @@ -1382,58 +1382,118 @@ static int gem_rx(struct macb_queue *queue, st=
ruct napi_struct *napi,
>>>  		queue->rx_tail++;
>>>  		count++;
>>>=20=20
>>> -		if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF))) {
>>> -			netdev_err(bp->dev,
>>> -				   "not whole frame pointed by descriptor\n");
>>> -			bp->dev->stats.rx_dropped++;
>>> -			queue->stats.rx_dropped++;
>>> -			break;
>>> -		}
>>> -		skb =3D queue->rx_buff[entry];
>>> -		if (unlikely(!skb)) {
>>> +		buff_head =3D queue->rx_buff[entry];
>>> +		if (unlikely(!buff_head)) {
>>>  			netdev_err(bp->dev,
>>>  				   "inconsistent Rx descriptor chain\n");
>>>  			bp->dev->stats.rx_dropped++;
>>>  			queue->stats.rx_dropped++;
>>>  			break;
>>>  		}
>>> -		/* now everything is ready for receiving packet */
>>> -		queue->rx_buff[entry] =3D NULL;
>>> +
>>> +		first_frame =3D ctrl & MACB_BIT(RX_SOF);
>>>  		len =3D ctrl & bp->rx_frm_len_mask;
>>>=20=20
>>> -		netdev_vdbg(bp->dev, "gem_rx %u (len %u)\n", entry, len);
>>> +		if (len) {
>>> +			data_len =3D len;
>>> +			if (!first_frame)
>>> +				data_len -=3D queue->skb->len;
>>> +		} else {
>>> +			data_len =3D bp->rx_buffer_size;
>>> +		}
>>
>> Why deal with the `!len` case? How can it occur? User guide doesn't hint
>> that. It would mean we would grab uninitialised bytes as we assume len
>> is the max buffer size.
>>
>
> Good point. After taking a second look, !len may not be the most reliable
> way to check this.
> From the datasheet, status signals are only valid (with some exceptions)
> when MACB_BIT(RX_EOF) is set. As a side effect, len is always zero on my
> hw for frames without the EOF bit, but it's probably better to just rely
> on MACB_BIT(RX_EOF) instead of reading something that may end up being
> unreliable.
>
>>> +
>>> +		if (first_frame) {
>>> +			queue->skb =3D napi_build_skb(buff_head, gem_total_rx_buffer_size(b=
p));
>>> +			if (unlikely(!queue->skb)) {
>>> +				netdev_err(bp->dev,
>>> +					   "Unable to allocate sk_buff\n");
>>> +				goto free_frags;
>>> +			}
>>> +
>>> +			/* Properly align Ethernet header.
>>> +			 *
>>> +			 * Hardware can add dummy bytes if asked using the RBOF
>>> +			 * field inside the NCFGR register. That feature isn't
>>> +			 * available if hardware is RSC capable.
>>> +			 *
>>> +			 * We cannot fallback to doing the 2-byte shift before
>>> +			 * DMA mapping because the address field does not allow
>>> +			 * setting the low 2/3 bits.
>>> +			 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
>>> +			 */
>>> +			skb_reserve(queue->skb, bp->rx_headroom);
>>> +			skb_mark_for_recycle(queue->skb);
>>> +			skb_put(queue->skb, data_len);
>>> +			queue->skb->protocol =3D eth_type_trans(queue->skb, bp->dev);
>>> +
>>> +			skb_checksum_none_assert(queue->skb);
>>> +			if (bp->dev->features & NETIF_F_RXCSUM &&
>>> +			    !(bp->dev->flags & IFF_PROMISC) &&
>>> +			    GEM_BFEXT(RX_CSUM, ctrl) & GEM_RX_CSUM_CHECKED_MASK)
>>> +				queue->skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>>> +		} else {
>>> +			if (!queue->skb) {
>>> +				netdev_err(bp->dev,
>>> +					   "Received non-starting frame while expecting it\n");
>>> +				goto free_frags;
>>> +			}
>>> +
>>> +			shinfo =3D skb_shinfo(queue->skb);
>>> +			page =3D virt_to_head_page(buff_head);
>>> +			nr_frags =3D shinfo->nr_frags;
>>> +
>>> +			if (nr_frags >=3D ARRAY_SIZE(shinfo->frags))
>>> +				goto free_frags;
>>>=20=20
>>> -		skb_put(skb, len);
>>> -		dma_unmap_single(&bp->pdev->dev, addr,
>>> -				 bp->rx_buffer_size, DMA_FROM_DEVICE);
>>> +			skb_add_rx_frag(queue->skb, nr_frags, page,
>>> +					buff_head - page_address(page) + bp->rx_headroom,
>>> +					data_len, gem_total_rx_buffer_size(bp));
>>> +		}
>>> +
>>> +		/* now everything is ready for receiving packet */
>>> +		queue->rx_buff[entry] =3D NULL;
>>>=20=20
>>> -		skb->protocol =3D eth_type_trans(skb, bp->dev);
>>> -		skb_checksum_none_assert(skb);
>>> -		if (bp->dev->features & NETIF_F_RXCSUM &&
>>> -		    !(bp->dev->flags & IFF_PROMISC) &&
>>> -		    GEM_BFEXT(RX_CSUM, ctrl) & GEM_RX_CSUM_CHECKED_MASK)
>>> -			skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>>> +		netdev_vdbg(bp->dev, "%s %u (len %u)\n", __func__, entry, data_len);
>>>=20=20
>>> -		bp->dev->stats.rx_packets++;
>>> -		queue->stats.rx_packets++;
>>> -		bp->dev->stats.rx_bytes +=3D skb->len;
>>> -		queue->stats.rx_bytes +=3D skb->len;
>>> +		if (ctrl & MACB_BIT(RX_EOF)) {
>>> +			bp->dev->stats.rx_packets++;
>>> +			queue->stats.rx_packets++;
>>> +			bp->dev->stats.rx_bytes +=3D queue->skb->len;
>>> +			queue->stats.rx_bytes +=3D queue->skb->len;
>>>=20=20
>>> -		gem_ptp_do_rxstamp(bp, skb, desc);
>>> +			gem_ptp_do_rxstamp(bp, queue->skb, desc);
>>>=20=20
>>>  #if defined(DEBUG) && defined(VERBOSE_DEBUG)
>>> -		netdev_vdbg(bp->dev, "received skb of length %u, csum: %08x\n",
>>> -			    skb->len, skb->csum);
>>> -		print_hex_dump(KERN_DEBUG, " mac: ", DUMP_PREFIX_ADDRESS, 16, 1,
>>> -			       skb_mac_header(skb), 16, true);
>>> -		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_ADDRESS, 16, 1,
>>> -			       skb->data, 32, true);
>>> +			netdev_vdbg(bp->dev, "received skb of length %u, csum: %08x\n",
>>> +				    queue->skb->len, queue->skb->csum);
>>> +			print_hex_dump(KERN_DEBUG, " mac: ", DUMP_PREFIX_ADDRESS, 16, 1,
>>> +				       skb_mac_header(queue->skb), 16, true);
>>> +			print_hex_dump(KERN_DEBUG, "buff_head: ", DUMP_PREFIX_ADDRESS, 16, =
1,
>>> +				       queue->skb->buff_head, 32, true);
>>>  #endif
>>
>> nit: while you are at it, maybe replace with print_hex_dump_debug()?
>>
>
> sure
>
>>>=20=20
>>> -		napi_gro_receive(napi, skb);
>>> +			napi_gro_receive(napi, queue->skb);
>>> +			queue->skb =3D NULL;
>>> +		}
>>> +
>>> +		continue;
>>> +
>>> +free_frags:
>>> +		if (queue->skb) {
>>> +			dev_kfree_skb(queue->skb);
>>> +			queue->skb =3D NULL;
>>> +		} else {
>>> +			page_pool_put_full_page(queue->page_pool,
>>> +						virt_to_head_page(buff_head),
>>> +						false);
>>> +		}
>>> +
>>> +		bp->dev->stats.rx_dropped++;
>>> +		queue->stats.rx_dropped++;
>>> +		queue->rx_buff[entry] =3D NULL;
>>>  	}
>>>=20=20
>>> -	gem_rx_refill(queue);
>>> +	gem_rx_refill(queue, true);
>>>=20=20
>>>  	return count;
>>>  }
>>> @@ -2367,12 +2427,25 @@ static netdev_tx_t macb_start_xmit(struct sk_bu=
ff *skb, struct net_device *dev)
>>>  	return ret;
>>>  }
>>>=20=20
>>> -static void macb_init_rx_buffer_size(struct macb *bp, size_t size)
>>> +static void macb_init_rx_buffer_size(struct macb *bp, unsigned int mtu)
>>>  {
>>> +	int overhead;
>>
>> nit: Maybe `unsigned int` or `size_t` rather than `int`?
>>
>
> ack
>
>>> +	size_t size;
>>> +
>>>  	if (!macb_is_gem(bp)) {
>>>  		bp->rx_buffer_size =3D MACB_RX_BUFFER_SIZE;
>>>  	} else {
>>> -		bp->rx_buffer_size =3D size;
>>> +		size =3D mtu + ETH_HLEN + ETH_FCS_LEN;
>>> +		if (!(bp->caps & MACB_CAPS_RSC))
>>> +			size +=3D NET_IP_ALIGN;
>>
>> NET_IP_ALIGN looks like it is accounted for twice, once in
>> bp->rx_headroom and once in bp->rx_buffer_size. This gets fixed in
>> [5/8] where gem_max_rx_data_size() gets introduced.
>>
>
> ah, right
>
>>> +
>>> +		bp->rx_buffer_size =3D SKB_DATA_ALIGN(size);
>>> +		if (gem_total_rx_buffer_size(bp) > PAGE_SIZE) {
>>> +			overhead =3D bp->rx_headroom +
>>> +				SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>>> +			bp->rx_buffer_size =3D rounddown(PAGE_SIZE - overhead,
>>> +						       RX_BUFFER_MULTIPLE);
>>> +		}
>>
>> I've seen your comment in [0/8]. Do you have any advice on how to test
>> this clamping? All I can think of is to either configure a massive MTU
>> or, more easily, cheat with the headroom.
>>
>
> I normally test the set with 4k PAGE_SIZE and, as you said, setting the
> mtu to something bigger than that. This is still possible with 8k pages
> (given .jumbo_max_len =3D 10240).
>
>
>> Also, should we warn? It means MTU-sized packets will be received in
>> fragments. It will work but is probably unexpected by users and a
>> slowdown reason that users might want to know about.
>>
>
> I'm not sure about the warning as I don't see this as a user level detail.
> For debugging purpose, I guess we should be fine the last print out (even
> better once extended with your suggestion). Of course, feel free to disag=
ree.
>
>> --
>>
>> nit: while in macb_init_rx_buffer_size(), can you tweak the debug line
>> from mtu & rx_buffer_size to also have rx_headroom and total? So that
>> we have everything available to understand what is going on buffer size
>> wise. Something like:
>>
>> -       netdev_dbg(bp->dev, "mtu [%u] rx_buffer_size [%zu]\n",
>> -                  bp->dev->mtu, bp->rx_buffer_size);
>> +       netdev_info(bp->dev, "mtu [%u] rx_buffer_size [%zu] rx_headroom =
[%zu] total [%u]\n",
>> +                   bp->dev->mtu, bp->rx_buffer_size, bp->rx_headroom,
>> +                   gem_total_rx_buffer_size(bp));
>>

I missed this before:
I assume so, but just checking, is the promotion from dbg to info also
wanted?

>> Thanks,
>>
>> --
>> Th=C3=A9o Lebrun, Bootlin
>> Embedded Linux and Kernel engineering
>> https://bootlin.com


