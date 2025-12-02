Return-Path: <netdev+bounces-243274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCFDC9C685
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 18:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 94DE1341C58
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 17:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067612C0279;
	Tue,  2 Dec 2025 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkXnheZa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPH2ucHA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB092BF3CA
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764696861; cv=none; b=mDwCkdM/NHdk9y616OrBmnEwUTQCyHfPG5nBWI2dfow400a543i99B2kqkbC0DjC7DVVD8MCaN8M7N6P14ni79fgRIX25jmf2GjCBfRDg2w8CDmNPn3mXksUiIrWxT9wPhjUvTB5/pF03ronYZkepocmLsouISsPD3MKtqm67kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764696861; c=relaxed/simple;
	bh=fK+bGxs4E3XL4siAdlABJQ03rsGkD+2F9w1Z90m5ClU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VZWzL5G/C5ekCSHGg0bqr3ynfAgCDFJwUiRbbfbMgfgbUc8YfYxuvtrirmL/lV7zu81mXmoywQ7OVmwlZLmecpORy8BPVEavQ+t1o1aRVWRYqvJ1juyUxDp3myRqbfDzuTy9iHXIOWUkBQxjDfQoi1WIVyC5gOMqDQJfrKKeWUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CkXnheZa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OPH2ucHA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764696858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6P04plaxYEkRT4fQKb+LwINbfyI9oL30MxuClRpFMuo=;
	b=CkXnheZaSqPZEA9Kpfi4ro2swYgjeuW5sqhcyXbZ0ZG93wYLyPOwHNZDnZzBOHGeLm2eJK
	Aa5bl0YD7iu8ThP2hSD3qMqzybqaEXVcqizL4KXjCSHa6UAaeH/z0fL49+WyrnkLXLzoKR
	czRWqK6HHFX+FJLZ3PhL9+feeYaJ7w8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-NPCPMV97P0aXN4aYD6Na1Q-1; Tue, 02 Dec 2025 12:34:17 -0500
X-MC-Unique: NPCPMV97P0aXN4aYD6Na1Q-1
X-Mimecast-MFC-AGG-ID: NPCPMV97P0aXN4aYD6Na1Q_1764696856
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42e2d6d13d1so1763208f8f.2
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 09:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764696856; x=1765301656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6P04plaxYEkRT4fQKb+LwINbfyI9oL30MxuClRpFMuo=;
        b=OPH2ucHA98T12UcfQjXSvvvm1whbF4CQG9IAMcVJuzLndnGu7dZs/Zv5xH+Pl3frCj
         xZaGNVuM0kVYWvYjfuW84bJuwZ01Zl+7rQ8/caZBRbVgxS3vRmPGp1klzS9MkSJ/JHmu
         xk08Tsj543ruXJs9aJSoTLm04VNl4p+QNTlOve99Lbkkefql5c3D9nwas27/l+o4hVNu
         JEpGfGU1vUugCevvM+gv1QvFrW1RPZM1j90RFP3UFeQsgvEhiV3dLl5EvsE5moP3E2V5
         BY8dLb6WMA4QpZRUOzZ734d+hz8UTzGrU6YuMiKMYqwsk/8SGY7c9qL+L5OQsrHcVj97
         We2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764696856; x=1765301656;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6P04plaxYEkRT4fQKb+LwINbfyI9oL30MxuClRpFMuo=;
        b=Oky2A3/hv4pUyDS7c5/xBglRtQjoqOXmHE0ttSDnvnD6R04gDFXVD+1+F07HaUrNwY
         ZQZTAZy5EeLlK/a7qeQTLSnC+7z4LcxIqPpxcPQnYd9Eb/tQBiIdm482fp6EpOh8P258
         JDpSUkL2lqLI2JEheFGIa411Lfa3TFmBPfg2rJdl8/nSOYdq4S+5h8KCoJBv1arY15Yh
         0Vv/Q2IWST7AmQcVyxZ6xlL5wu8YX3kfU9QxxY+6ayiPQOHhcZ8TTjL90DFhRekpBJug
         7lwdTjgeW8P4MLxpQEyd/V10qvHXku7DIPubo1QeR7u4f2kWiOgN8NHgPAX+T8guQhYv
         bZAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5PG5MHTlmMvWM1G6AzvmHD0QQOHoTZuq/8OMB0ViKA6Jrowk5ozYf3l7mkteWOLoGjyAykfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk9eR3cUhNyEEon1/HTl9d+3OwUP2xxSDjTMxGfzhU9/7A7+c+
	ZiC0dcmb/rog7CNkyUTcGFS2xpnNfuxr0wCU4JqPaVG+COPrHokYIV+8DuT3TynWIQi4dw9kgmo
	91WbEh6EJM3IOYEfb3tEhsA6hPnBWV+h2ra3KO7TIyl7gawxF83TM6BtgOg==
X-Gm-Gg: ASbGnctQ28L1MadC9uqzxtAgrlaHIt27buS2YrVi/udEPF9kuJW6nZpLc2rujLAT4vV
	Li+UxQMXkBHoabiO1o9RNBOf4orBlHXyMNyLe5GOf4zrDQNnpe9EC7qkw3ATpfhaSLsc5+y83PS
	+795Hdm0PPLwE+P1JlQoPscuIUczXf7oGQf5se+YZHTrEWX9wU2ux4DdBQ8nLpObFZvX/CKYA25
	ue3GbW0LKp76vG3BRhk6hcY3D5HhRJIU6Fh04WrxBe7DgYSqN9epMLcHW669CWbXg2d4Uj4XM3T
	OOcTO0LupACXgjjwb3eQVQlB+XXwwoJIAzHCyRiMdhbcsLZ8aZxkT+vsz7q68yvcJe8fBzeRvK7
	FHinZdRnWHfSk+rYwD1U1qgT4uZ9KxdwzqJrULD0/I4cC
X-Received: by 2002:a05:6000:26c4:b0:42b:2f79:755e with SMTP id ffacd0b85a97d-42cc1ab8874mr44431659f8f.3.1764696856236;
        Tue, 02 Dec 2025 09:34:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEg4E5WgRRH+R91ocxDpo3mTJ91NV+NlN9PbmFGR+J6PK1TwJSpi1Mj78rFZaUAHGs5T5Oc4Q==
X-Received: by 2002:a05:6000:26c4:b0:42b:2f79:755e with SMTP id ffacd0b85a97d-42cc1ab8874mr44431632f8f.3.1764696855567;
        Tue, 02 Dec 2025 09:34:15 -0800 (PST)
Received: from localhost (net-5-89-201-160.cust.vodafonedsl.it. [5.89.201.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a6fesm34866415f8f.20.2025.12.02.09.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 09:34:15 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>,
 netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH RFC net-next 6/6] cadence: macb/gem: introduce xmit support
In-Reply-To: <DEJKKYXTM4TH.2MK2CNLW7L5D3@bootlin.com>
References: <20251119135330.551835-1-pvalerio@redhat.com>
 <20251119135330.551835-7-pvalerio@redhat.com>
 <DEJKKYXTM4TH.2MK2CNLW7L5D3@bootlin.com>
Date: Tue, 02 Dec 2025 18:34:14 +0100
Message-ID: <878qfkzt2h.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27 Nov 2025 at 04:07:52 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> w=
rote:

> Hello Paolo, netdev,
>
> On Wed Nov 19, 2025 at 2:53 PM CET, Paolo Valerio wrote:
>> Add XDP_TX verdict support, also introduce ndo_xdp_xmit function for
>> redirection, and update macb_tx_unmap() to handle both skbs and xdp
>> frames advertising NETDEV_XDP_ACT_NDO_XMIT capability and the ability
>> to process XDP_TX verdicts.
>>
>> Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
>> ---
>>  drivers/net/ethernet/cadence/macb_main.c | 166 +++++++++++++++++++++--
>>  1 file changed, 153 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethe=
rnet/cadence/macb_main.c
>> index eeda1a3871a6..bd62d3febeb1 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -969,6 +969,17 @@ static int macb_halt_tx(struct macb *bp)
>>  					bp, TSR);
>>  }
>>=20=20
>> +static void release_buff(void *buff, enum macb_tx_buff_type type, int b=
udget)
>> +{
>> +	if (type =3D=3D MACB_TYPE_SKB) {
>> +		napi_consume_skb(buff, budget);
>> +	} else if (type =3D=3D MACB_TYPE_XDP_TX) {
>> +		xdp_return_frame_rx_napi(buff);
>> +	} else {
>> +		xdp_return_frame(buff);
>> +	}
>> +}
>> +
>>  static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff,
>>  			  int budget)
>>  {
>> @@ -983,10 +994,7 @@ static void macb_tx_unmap(struct macb *bp, struct m=
acb_tx_buff *tx_buff,
>>  	}
>>=20=20
>>  	if (tx_buff->data) {
>> -		if (tx_buff->type !=3D MACB_TYPE_SKB)
>> -			netdev_err(bp->dev, "BUG: Unexpected tx buffer type while unmapping =
(%d)",
>> -				   tx_buff->type);
>> -		napi_consume_skb(tx_buff->data, budget);
>> +		release_buff(tx_buff->data, tx_buff->type, budget);
>>  		tx_buff->data =3D NULL;
>>  	}
>>  }
>> @@ -1076,8 +1084,8 @@ static void macb_tx_error_task(struct work_struct =
*work)
>>  		tx_buff =3D macb_tx_buff(queue, tail);
>>=20=20
>>  		if (tx_buff->type !=3D MACB_TYPE_SKB)
>> -			netdev_err(bp->dev, "BUG: Unexpected tx buffer type (%d)",
>> -				   tx_buff->type);
>> +			goto unmap;
>> +
>>  		skb =3D tx_buff->data;
>>=20=20
>>  		if (ctrl & MACB_BIT(TX_USED)) {
>> @@ -1118,6 +1126,7 @@ static void macb_tx_error_task(struct work_struct =
*work)
>>  			desc->ctrl =3D ctrl | MACB_BIT(TX_USED);
>>  		}
>>=20=20
>> +unmap:
>>  		macb_tx_unmap(bp, tx_buff, 0);
>>  	}
>>=20=20
>> @@ -1196,6 +1205,7 @@ static int macb_tx_complete(struct macb_queue *que=
ue, int budget)
>>  	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
>>  	head =3D queue->tx_head;
>>  	for (tail =3D queue->tx_tail; tail !=3D head && packets < budget; tail=
++) {
>> +		void			*data =3D NULL;
>>  		struct macb_tx_buff	*tx_buff;
>>  		struct sk_buff		*skb;
>>  		struct macb_dma_desc	*desc;
>> @@ -1218,11 +1228,16 @@ static int macb_tx_complete(struct macb_queue *q=
ueue, int budget)
>>  		for (;; tail++) {
>>  			tx_buff =3D macb_tx_buff(queue, tail);
>>=20=20
>> -			if (tx_buff->type =3D=3D MACB_TYPE_SKB)
>> -				skb =3D tx_buff->data;
>> +			if (tx_buff->type !=3D MACB_TYPE_SKB) {
>> +				data =3D tx_buff->data;
>> +				goto unmap;
>> +			}
>>=20=20
>>  			/* First, update TX stats if needed */
>> -			if (skb) {
>> +			if (tx_buff->type =3D=3D MACB_TYPE_SKB && tx_buff->data) {
>> +				data =3D tx_buff->data;
>> +				skb =3D tx_buff->data;
>> +
>>  				if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
>>  				    !ptp_one_step_sync(skb))
>>  					gem_ptp_do_txstamp(bp, skb, desc);
>> @@ -1238,6 +1253,7 @@ static int macb_tx_complete(struct macb_queue *que=
ue, int budget)
>>  				bytes +=3D skb->len;
>>  			}
>>=20=20
>> +unmap:
>>  			/* Now we can safely release resources */
>>  			macb_tx_unmap(bp, tx_buff, budget);
>>=20=20
>> @@ -1245,7 +1261,7 @@ static int macb_tx_complete(struct macb_queue *que=
ue, int budget)
>>  			 * WARNING: at this point skb has been freed by
>>  			 * macb_tx_unmap().
>>  			 */
>> -			if (skb)
>> +			if (data)
>>  				break;
>>  		}
>>  	}
>> @@ -1357,8 +1373,124 @@ static void discard_partial_frame(struct macb_qu=
eue *queue, unsigned int begin,
>>  	 */
>>  }
>>=20=20
>> +static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdp=
f,
>> +				 struct net_device *dev, dma_addr_t addr)
>> +{
>> +	enum macb_tx_buff_type buff_type;
>> +	struct macb_tx_buff *tx_buff;
>> +	int cpu =3D smp_processor_id();
>> +	struct macb_dma_desc *desc;
>> +	struct macb_queue *queue;
>> +	unsigned long flags;
>> +	dma_addr_t mapping;
>> +	u16 queue_index;
>> +	int err =3D 0;
>> +	u32 ctrl;
>> +
>> +	queue_index =3D cpu % bp->num_queues;
>> +	queue =3D &bp->queues[queue_index];
>> +	buff_type =3D !addr ? MACB_TYPE_XDP_NDO : MACB_TYPE_XDP_TX;
>
> I am not the biggest fan of piggy-backing on !!addr to know which
> codepath called us. If the macb_xdp_submit_frame() call in gem_xdp_run()
> ever gives an addr=3D0 coming from macb_get_addr(bp, desc), then we will
> be submitting NDO typed frames and creating additional DMA mappings
> which would be a really hard to debug bug.
>

I guess we can add a separate boolean, WDYT?

>> +	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
>> +
>> +	/* This is a hard error, log it. */
>> +	if (CIRC_SPACE(queue->tx_head, queue->tx_tail,
>> +		       bp->tx_ring_size) < 1) {
>
> Hard wrapped line is not required, it fits in one line.
>

ack to this and all the remaning ones

>> +		netif_stop_subqueue(dev, queue_index);
>> +		netdev_dbg(bp->dev, "tx_head =3D %u, tx_tail =3D %u\n",
>> +			   queue->tx_head, queue->tx_tail);
>> +		err =3D -ENOMEM;
>> +		goto unlock;
>> +	}
>> +
>> +	if (!addr) {
>> +		mapping =3D dma_map_single(&bp->pdev->dev,
>> +					 xdpf->data,
>> +					 xdpf->len, DMA_TO_DEVICE);
>> +		if (unlikely(dma_mapping_error(&bp->pdev->dev, mapping))) {
>> +			err =3D -ENOMEM;
>> +			goto unlock;
>> +		}
>> +	} else {
>> +		mapping =3D addr;
>> +		dma_sync_single_for_device(&bp->pdev->dev, mapping,
>> +					   xdpf->len, DMA_BIDIRECTIONAL);
>> +	}
>> +
>> +	unsigned int tx_head =3D queue->tx_head + 1;
>
> Middle scope variable definition. Weirdly named as it isn't storing the
> current head offset but the future head offset.
>
>> +	ctrl =3D MACB_BIT(TX_USED);
>> +	desc =3D macb_tx_desc(queue, tx_head);
>> +	desc->ctrl =3D ctrl;
>> +
>> +	desc =3D macb_tx_desc(queue, queue->tx_head);
>> +	tx_buff =3D macb_tx_buff(queue, queue->tx_head);
>> +	tx_buff->data =3D xdpf;
>> +	tx_buff->type =3D buff_type;
>> +	tx_buff->mapping =3D mapping;
>> +	tx_buff->size =3D xdpf->len;
>> +	tx_buff->mapped_as_page =3D false;
>> +
>> +	ctrl =3D (u32)tx_buff->size;
>> +	ctrl |=3D MACB_BIT(TX_LAST);
>> +
>> +	if (unlikely(macb_tx_ring_wrap(bp, queue->tx_head) =3D=3D (bp->tx_ring=
_size - 1)))
>> +		ctrl |=3D MACB_BIT(TX_WRAP);
>> +
>> +	/* Set TX buffer descriptor */
>> +	macb_set_addr(bp, desc, tx_buff->mapping);
>> +	/* desc->addr must be visible to hardware before clearing
>> +	 * 'TX_USED' bit in desc->ctrl.
>> +	 */
>> +	wmb();
>> +	desc->ctrl =3D ctrl;
>> +	queue->tx_head =3D tx_head;
>> +
>> +	/* Make newly initialized descriptor visible to hardware */
>> +	wmb();
>> +
>> +	spin_lock(&bp->lock);
>> +	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
>> +	spin_unlock(&bp->lock);
>> +
>> +	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1)
>> +		netif_stop_subqueue(dev, queue_index);
>
> The above 30~40 lines are super similar to macb_start_xmit() &
> macb_tx_map(). They implement almost the same logic; can we avoid the
> duplication?
>
>> +
>> +unlock:
>> +	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
>> +
>> +	if (err)
>> +		release_buff(xdpf, buff_type, 0);
>> +
>> +	return err;
>> +}
>> +
>> +static int
>> +macb_xdp_xmit(struct net_device *dev, int num_frame,
>> +	      struct xdp_frame **frames, u32 flags)
>> +{
>> +	struct macb *bp =3D netdev_priv(dev);
>> +	u32 xmitted =3D 0;
>> +	int i;
>> +
>> +	if (!macb_is_gem(bp))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
>> +		return -EINVAL;
>> +
>> +	for (i =3D 0; i < num_frame; i++) {
>> +		if (macb_xdp_submit_frame(bp, frames[i], dev, 0))
>> +			break;
>> +
>> +		xmitted++;
>> +	}
>> +
>> +	return xmitted;
>> +}
>> +
>>  static u32 gem_xdp_run(struct macb_queue *queue, struct xdp_buff *xdp,
>> -		       struct net_device *dev)
>> +		       struct net_device *dev, dma_addr_t addr)
>>  {
>>  	struct bpf_prog *prog;
>>  	u32 act =3D XDP_PASS;
>> @@ -1379,6 +1511,12 @@ static u32 gem_xdp_run(struct macb_queue *queue, =
struct xdp_buff *xdp,
>>  			break;
>>  		}
>>  		goto out;
>> +	case XDP_TX:
>> +		struct xdp_frame *xdpf =3D xdp_convert_buff_to_frame(xdp);
>> +
>> +		if (!xdpf || macb_xdp_submit_frame(queue->bp, xdpf, dev, addr))
>> +			act =3D XDP_DROP;
>> +		goto out;
>>  	default:
>>  		bpf_warn_invalid_xdp_action(dev, prog, act);
>>  		fallthrough;
>> @@ -1467,7 +1605,7 @@ static int gem_rx(struct macb_queue *queue, struct=
 napi_struct *napi,
>>  				 false);
>>  		xdp_buff_clear_frags_flag(&xdp);
>>=20=20
>> -		ret =3D gem_xdp_run(queue, &xdp, bp->dev);
>> +		ret =3D gem_xdp_run(queue, &xdp, bp->dev, addr);
>>  		if (ret =3D=3D XDP_REDIRECT)
>>  			xdp_flush =3D true;
>>=20=20
>> @@ -4546,6 +4684,7 @@ static const struct net_device_ops macb_netdev_ops=
 =3D {
>>  	.ndo_hwtstamp_get	=3D macb_hwtstamp_get,
>>  	.ndo_setup_tc		=3D macb_setup_tc,
>>  	.ndo_bpf		=3D macb_xdp,
>> +	.ndo_xdp_xmit		=3D macb_xdp_xmit,
>
> I'd expect macb_xdp_xmit() to be called gem_xdp_xmit() as well.
>
> Thanks,
>
> --
> Th=C3=A9o Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


