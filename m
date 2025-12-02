Return-Path: <netdev+bounces-243268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1120DC9C65B
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 18:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 86A1F34300F
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 17:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F80201004;
	Tue,  2 Dec 2025 17:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDF2mFRQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s6IDx044"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A772BEFEB
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764696638; cv=none; b=luQusc/kk/4myDNHRkjGZ408BxXM8PPs6BeP7gNnpIViAtdvP8MXIZCaiVa0JgGraWAJ+E82oj4tyerecK9M72TmJyJAM08QUa3umlotLIe/Deu5+JEIBVfgTJHo6xunxk2eJBq8+Cl7+uNwcZGC5Rcx58wWZ1qn40hA7CxbcBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764696638; c=relaxed/simple;
	bh=sWhbJAZsTiVaG3HjIMIKWmV4pvJ32PDUOCgaqrFA6cU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qIjaFIKIEbDBAiEDGKaK97VaOd2fP3cjH5mvcp63FPuzfFgYKaPTO585stWJPPsmuBMEMJGJpMRya+ithL2EVI5ebgy8WTXVv4qBUfQI72ZOd5oSk9rANC1eRlYmxVnhTMiwl6GmtQiLJj0B49BfzbbNAOcigFq8LW6xqbwcC/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDF2mFRQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s6IDx044; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764696633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wllPBv/q6yPRomDjIKVicAknZ0CwKik0/wKXlpvmn/A=;
	b=bDF2mFRQyuN8L0/9eZ6Jcw3J3KmGUSl4jl53TDwTJEV9dOn/7qB8bCLnY/b1XzU2ywc28f
	2n/avvPMnGDKHco2l9VcIVNglpF4LXqzyFEN3i2R5TkJxeOOFW1sB9McyQVD2AUsXb2Vzb
	YoFhzANAnCFJ/1pcc/54LclxKU1EWRU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-QXCAQUOAOcW7uIq5w3FahA-1; Tue, 02 Dec 2025 12:30:32 -0500
X-MC-Unique: QXCAQUOAOcW7uIq5w3FahA-1
X-Mimecast-MFC-AGG-ID: QXCAQUOAOcW7uIq5w3FahA_1764696631
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b2b9c7ab6so3330524f8f.2
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 09:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764696631; x=1765301431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wllPBv/q6yPRomDjIKVicAknZ0CwKik0/wKXlpvmn/A=;
        b=s6IDx044gVXMVArARb4JwPJ9Eux3MhbeBfS/wOdiv8FFMYzPeccl+EpV7Uk/Pun5Wv
         6x1kq/2xK4KIRtufU+TigEwZGSeJG4LEf0oxGOBV6FajYOK/IZxOMe8SIcdeYsXrpgPE
         WSYjP1VNyV0lUHW9vpkoKoPUaSR79NpXeawhwYBBoGFIE9x/RLiMkxTARdK9bjuhuQLP
         iDyi2rn2NYVxScb4GfQde5qha+UcgCkI8GCJ3Dchuv+dbFC4VlwAosSOQdHrrp1Dm/8f
         6UTtK5a76kZ0P2ykzUOSWmQduzLdWOUkPSZtYLu6mvm2mueKfX/9QfXgqX24hc3P6rkV
         dwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764696631; x=1765301431;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wllPBv/q6yPRomDjIKVicAknZ0CwKik0/wKXlpvmn/A=;
        b=HKEy/Ewg4nd+B8rVNGSuUTBjzfiwSaLYXndqROnoV8OVQkJzkKY+WqdAOqGUOgnQeO
         ubuHnL1xyyeSy2TQs8PobFnOX2mD1K5ud/f0H3CRwEPVveNwzRkiOn35r67vtGCYY3NQ
         PX8Xki1+Kq7oTb6MyK0DZwJINZjrmN+fNQJXLI0ZuE26V/c9R5ol4GO8mow+/MU2R1Dt
         cPa53rhbk1UPp7DS2gMIcDGgMHmEr3EkSi1+sNjPfqZZVoHpkrlZ8PXrfBHp0aChNNfK
         zIBqcq6XCGHFCj6coLs158gP1UsgIa3gJU6yhphrBXzC9tGDKS3LZKrd7pXmrwAXo6/l
         9qsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmcMPbeOPPPQmbOBxSZawFzrfKKZnQ/mrTq45uLYtF0b6Uhkz4wkqgAhZZmCwQ5UOCnX70oLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+aslafZMUzJJIqUACw8CjUaSOWed6MnGHYZLWTHiasVoQu+SQ
	zRrvM3pf8omWeKQ7+Ct/loVlGRPj36NJ3gZ7NGq1rblAJwliUDi4+6NLGsCvs5+QwHONKhpvkGV
	RiSy4Fd6iXs30zP2D9owz1nPT1gjh3o41AhC1GPMzVVxfoFjnYYjFedUlTA==
X-Gm-Gg: ASbGncsH7B0ywEkJ4I9WL1E/UD44HT8g76Z/Ya50I+Mcz4eCDx0DesIUPGGkOVMvmJJ
	u1QdnMr+JOUI4rnxJ1e10T6wn04p9EhkLddpVj9qaOchvFNpIIjxKBxVcHqyVfteiZZ15wXLaab
	rwx13oSfhOrcDj9EbqKbG8ciumA3Hyj//KoNSxjefhByuu4n4ev1it9eVNvm8r3B+lsKSKNemrE
	TVJ+HLxBAKwQSOqhRG+qsFMITt/4453YxWA0M+lhonj7kwwSA7hA0kx0TBc28Vu7tw/CzDdoiVa
	J00uan/JKRNMr8Gi9K5ojelt72T0wHr/QMZS6qhF64s+JxJtKwi2GFOTjXGU6GMrn+FkneH6a/E
	+s4AYQgmDZ4NBhVzW8dpZeAu/I4VJEqsyY4a3mLEcL/7+
X-Received: by 2002:a05:600c:b8a:b0:477:561f:6fc8 with SMTP id 5b1f17b1804b1-4792a490752mr4839465e9.5.1764696631306;
        Tue, 02 Dec 2025 09:30:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8lIoP74keDzbmUg5uXhOifGuDzWa7DYkpkA9uR633XAGF9aNA4KVIGS/KS0Xn56AqKm/CdQ==
X-Received: by 2002:a05:600c:b8a:b0:477:561f:6fc8 with SMTP id 5b1f17b1804b1-4792a490752mr4838945e9.5.1764696630805;
        Tue, 02 Dec 2025 09:30:30 -0800 (PST)
Received: from localhost (net-5-89-201-160.cust.vodafonedsl.it. [5.89.201.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5e3857sm34966471f8f.19.2025.12.02.09.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 09:30:30 -0800 (PST)
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
Subject: Re: [PATCH RFC net-next 1/6] cadence: macb/gem: Add page pool support
In-Reply-To: <DEJIBSTL1UKX.2IQYBHZMHS65O@bootlin.com>
References: <20251119135330.551835-1-pvalerio@redhat.com>
 <20251119135330.551835-2-pvalerio@redhat.com>
 <DEJIBSTL1UKX.2IQYBHZMHS65O@bootlin.com>
Date: Tue, 02 Dec 2025 18:30:29 +0100
Message-ID: <87ecpczt8q.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27 Nov 2025 at 02:21:52 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> w=
rote:

> Hello Paolo,
>
> On Wed Nov 19, 2025 at 2:53 PM CET, Paolo Valerio wrote:
>> Subject: [PATCH RFC net-next 1/6] cadence: macb/gem: Add page pool suppo=
rt
>
> `git log --oneline drivers/net/ethernet/cadence/` tells us all commits
> in this series should be prefixed with "net: macb: ".
>

ack

>> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/=
cadence/macb.h
>> index 87414a2ddf6e..dcf768bd1bc1 100644
>> --- a/drivers/net/ethernet/cadence/macb.h
>> +++ b/drivers/net/ethernet/cadence/macb.h
>> @@ -14,6 +14,8 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/phy/phy.h>
>>  #include <linux/workqueue.h>
>> +#include <net/page_pool/helpers.h>
>> +#include <net/xdp.h>
>>=20=20
>>  #define MACB_GREGS_NBR 16
>>  #define MACB_GREGS_VERSION 2
>> @@ -957,6 +959,10 @@ struct macb_dma_desc_ptp {
>>  /* Scaled PPM fraction */
>>  #define PPM_FRACTION	16
>>=20=20
>> +/* The buf includes headroom compatible with both skb and xdpf */
>> +#define MACB_PP_HEADROOM		XDP_PACKET_HEADROOM
>> +#define MACB_PP_MAX_BUF_SIZE(num)	(((num) * PAGE_SIZE) - MACB_PP_HEADRO=
OM)
>
> From my previous review, you know I think MACB_PP_MAX_BUF_SIZE() should
> disappear.
>
> I also don't see the point of MACB_PP_HEADROOM. Maybe if it was
> max(XDP_PACKET_HEADROOM, NET_SKB_PAD) it would be more useful, but that
> isn't useful anyway. Can we drop it and use XDP_PACKET_HEADROOM directly
> in the code?
>

sure

>>  /* struct macb_tx_skb - data about an skb which is being transmitted
>>   * @skb: skb currently being transmitted, only set for the last buffer
>>   *       of the frame
>> @@ -1262,10 +1268,11 @@ struct macb_queue {
>>  	unsigned int		rx_tail;
>>  	unsigned int		rx_prepared_head;
>>  	struct macb_dma_desc	*rx_ring;
>> -	struct sk_buff		**rx_skbuff;
>> +	void			**rx_buff;
>
> It would help review if the s/rx_skbuff/rx_buff/ renaming was done in a
> separate commit with a commit message being "this only renames X and
> implies no functional changes".
>

ack, will do

>>  	void			*rx_buffers;
>>  	struct napi_struct	napi_rx;
>>  	struct queue_stats stats;
>> +	struct page_pool	*page_pool;
>>  };
>>=20=20
>>  struct ethtool_rx_fs_item {
>> @@ -1289,6 +1296,7 @@ struct macb {
>>  	struct macb_dma_desc	*rx_ring_tieoff;
>>  	dma_addr_t		rx_ring_tieoff_dma;
>>  	size_t			rx_buffer_size;
>> +	u16			rx_offset;
>
> u16 makes me worried that we might do mistakes. For example the
> following propagates the u16 type.
>
>         bp->rx_offset + data - page_address(page)
>
> We can spare the additional 6 bytes and turn it into a size_t. It'll
> fall in holes anyway, at least it does for my target according to pahole.
>

will do

>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethe=
rnet/cadence/macb_main.c
>> index e461f5072884..985c81913ba6 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -1250,11 +1250,28 @@ static int macb_tx_complete(struct macb_queue *q=
ueue, int budget)
>>  	return packets;
>>  }
>>=20=20
>> -static void gem_rx_refill(struct macb_queue *queue)
>> +static void *gem_page_pool_get_buff(struct page_pool *pool,
>> +				    dma_addr_t *dma_addr, gfp_t gfp_mask)
>> +{
>> +	struct page *page;
>> +
>> +	if (!pool)
>> +		return NULL;
>> +
>> +	page =3D page_pool_alloc_pages(pool, gfp_mask | __GFP_NOWARN);
>> +	if (!page)
>> +		return NULL;
>> +
>> +	*dma_addr =3D page_pool_get_dma_addr(page) + MACB_PP_HEADROOM;
>> +
>> +	return page_address(page);
>> +}
>
> Do we need a separate function called from only one location? Or we
> could change its name to highlight it allocates and does not just "get"
> a buffer.
>

I guess it's fine to open-code this.

>> @@ -1267,25 +1284,17 @@ static void gem_rx_refill(struct macb_queue *que=
ue)
>>=20=20
>>  		desc =3D macb_rx_desc(queue, entry);
>>=20=20
>> -		if (!queue->rx_skbuff[entry]) {
>> +		if (!queue->rx_buff[entry]) {
>>  			/* allocate sk_buff for this free entry in ring */
>> -			skb =3D netdev_alloc_skb(bp->dev, bp->rx_buffer_size);
>> -			if (unlikely(!skb)) {
>> +			data =3D gem_page_pool_get_buff(queue->page_pool, &paddr,
>> +						      napi ? GFP_ATOMIC : GFP_KERNEL);
>
> I don't get why the gfp flags computation is spread across
> gem_page_pool_get_buff() and gem_rx_refill().
>

Not sure I get the point here.
This will be open-coded, so atomic vs non-atomic flag will not be passed
to gem_page_pool_get_buff() anymore after the change.
Not sure this answer your question.

>> @@ -1349,12 +1344,16 @@ static int gem_rx(struct macb_queue *queue, stru=
ct napi_struct *napi,
>>  		  int budget)
>>  {
>>  	struct macb *bp =3D queue->bp;
>> +	int			buffer_size;
>>  	unsigned int		len;
>>  	unsigned int		entry;
>> +	void			*data;
>>  	struct sk_buff		*skb;
>>  	struct macb_dma_desc	*desc;
>>  	int			count =3D 0;
>>=20=20
>> +	buffer_size =3D DIV_ROUND_UP(bp->rx_buffer_size, PAGE_SIZE) * PAGE_SIZ=
E;
>
> This looks like
>
>         buffer_size =3D ALIGN(bp->rx_buffer_size, PAGE_SIZE);
>
> no? Anyway I think it should be dropped. It does get dropped next patch
> in this RFC.
>

will proceed squashing the two patches

>> @@ -1387,24 +1386,49 @@ static int gem_rx(struct macb_queue *queue, stru=
ct napi_struct *napi,
>>  			queue->stats.rx_dropped++;
>>  			break;
>>  		}
>> -		skb =3D queue->rx_skbuff[entry];
>> -		if (unlikely(!skb)) {
>> +		data =3D queue->rx_buff[entry];
>> +		if (unlikely(!data)) {
>>  			netdev_err(bp->dev,
>>  				   "inconsistent Rx descriptor chain\n");
>>  			bp->dev->stats.rx_dropped++;
>>  			queue->stats.rx_dropped++;
>>  			break;
>>  		}
>> +
>> +		skb =3D napi_build_skb(data, buffer_size);
>> +		if (unlikely(!skb)) {
>> +			netdev_err(bp->dev,
>> +				   "Unable to allocate sk_buff\n");
>> +			page_pool_put_full_page(queue->page_pool,
>> +						virt_to_head_page(data),
>> +						false);
>> +			break;
>
> We should `queue->rx_skbuff[entry] =3D NULL` here no?
> We free a page and keep a pointer to it.
>

This will be squashed, but the point is still valid as it's the same as
the other patch

>> +		}
>> +
>> +		/* Properly align Ethernet header.
>> +		 *
>> +		 * Hardware can add dummy bytes if asked using the RBOF
>> +		 * field inside the NCFGR register. That feature isn't
>> +		 * available if hardware is RSC capable.
>> +		 *
>> +		 * We cannot fallback to doing the 2-byte shift before
>> +		 * DMA mapping because the address field does not allow
>> +		 * setting the low 2/3 bits.
>> +		 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
>> +		 */
>> +		skb_reserve(skb, bp->rx_offset);
>> +		skb_mark_for_recycle(skb);
>
> I have a platform with RSC support and NET_IP_ALIGN=3D2. What is yours
> like? It'd be nice if we can test different cases of this RBOF topic.
>

my caps:
macb 1f00100000.ethernet: Cadence caps 0x00548061

Bit RSC looks unset and NET_IP_ALIGN is 0 in my case.

>>  		/* now everything is ready for receiving packet */
>> -		queue->rx_skbuff[entry] =3D NULL;
>> +		queue->rx_buff[entry] =3D NULL;
>>  		len =3D ctrl & bp->rx_frm_len_mask;
>>=20=20
>>  		netdev_vdbg(bp->dev, "gem_rx %u (len %u)\n", entry, len);
>>=20=20
>> +		dma_sync_single_for_cpu(&bp->pdev->dev,
>> +					addr, len,
>> +					page_pool_get_dma_dir(queue->page_pool));
>
> Any reason for the call to dma_sync_single_for_cpu(), we could hardcode
> it to DMA_FROM_DEVICE no?
>

I saw in the other reply you found the answer

>> @@ -2477,13 +2497,13 @@ static int gem_alloc_rx_buffers(struct macb *bp)
>>=20=20
>>  	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue) {
>>  		size =3D bp->rx_ring_size * sizeof(struct sk_buff *);
>
> sizeof is called with the wrong type. Not that it matters because
> pointers are pointers, but we can take this opportunity to move to
>
>         sizeof(*queue->rx_buff)
>

definitely

>> -		queue->rx_skbuff =3D kzalloc(size, GFP_KERNEL);
>> -		if (!queue->rx_skbuff)
>> +		queue->rx_buff =3D kzalloc(size, GFP_KERNEL);
>> +		if (!queue->rx_buff)
>>  			return -ENOMEM;
>>  		else
>>  			netdev_dbg(bp->dev,
>> -				   "Allocated %d RX struct sk_buff entries at %p\n",
>> -				   bp->rx_ring_size, queue->rx_skbuff);
>> +				   "Allocated %d RX buff entries at %p\n",
>> +				   bp->rx_ring_size, queue->rx_buff);
>
> Opportunity to deindent this block?
>

ack

> Thanks,
>
> --
> Th=C3=A9o Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


