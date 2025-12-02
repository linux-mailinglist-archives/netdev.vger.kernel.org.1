Return-Path: <netdev+bounces-243272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC43C9C67C
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 18:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1C6A234A2D0
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 17:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A35B2BFC85;
	Tue,  2 Dec 2025 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVMml/AN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oobmBo3A"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE40F2940B
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764696768; cv=none; b=GhxLePLh0EqXGEE9wHaQjPG1F5Ea78qizhaMdsLE503aNlEyArPN7Y0/EhuQND2HFurlaj+szwXltKrOAJtoEw/bl7kNDD/9xZfnDcnZ+Term5dFNSdCFTEIyZfazxmsaBl/nMyFq0LCSAZ/WcX9y7Q/m2uoBenbiq2TWRzE220=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764696768; c=relaxed/simple;
	bh=cFSsCGz+4TKMd1YTPxeI4zP29xhTCQKjsZF1NZ1/gHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=soWfjoefwlHReJAmCbPhimKLg0iaCRKFQgUmfYaFxlJlW5Um9vQeK2yQEKVSIeO54wbYgr+rSPepQrzv2t/xgxQTuA9tp9S4jOui7sOCkBDC+IXF8MXGshoEzxo8bIW7pl9vObFJjoUAAmtEreJ0L1A7cfHLi3e5Bv+TZm7tXbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eVMml/AN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oobmBo3A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764696765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+HDJVvJl4bMj4d4ziuOQIqm2WL1j0kM9Q0KPsbSWGI=;
	b=eVMml/ANiYjUQ/dENhwEY4UjBg68tezQfdVbNyMza/wAnKbQvskuxpSv6a5Tfz9idm+wL9
	22axYbHf+7SIMMQoyo2T4iTRX4oNzonIrIbKAj2dFsNbRMQOg4581AYepK3LWfFBK252Ul
	aIEdRov7itTzgd4WugJYo09UVHID/sw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-xR4cDTUJO3u_nQs95JUHJA-1; Tue, 02 Dec 2025 12:32:44 -0500
X-MC-Unique: xR4cDTUJO3u_nQs95JUHJA-1
X-Mimecast-MFC-AGG-ID: xR4cDTUJO3u_nQs95JUHJA_1764696763
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b2ad2a58cso2627643f8f.0
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 09:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764696763; x=1765301563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+HDJVvJl4bMj4d4ziuOQIqm2WL1j0kM9Q0KPsbSWGI=;
        b=oobmBo3ACbecGM2zAsNEQbzTua289d/zUsiE4f/oBkEpmqJ3/nXMIrnDlectuOHoNM
         cQi9ESLTls2yqBbSq3IGu9y+ov19oUq6misriMpLnfrGtf9pmJ5eCJI8OyDj4tGylV/M
         ztIw/2HhahEQtH9tOElQth941AkITEo3kcE3IAIs0MY58WWQaYsXKwyqYBT3FOU4Ycf8
         vmgugVRwqGfiTzE+a+d27ou7KAF/LeVNcVwqNtcotJtOmBDbL6R51O/rQgzVTHjRDMNp
         jkrVP/NY6/3I3nsMFq7ofHb4iAZB1FeuU8SsCWF30BW5aRZMTZNWrNHDTVRGdNOb8Bll
         qpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764696763; x=1765301563;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E+HDJVvJl4bMj4d4ziuOQIqm2WL1j0kM9Q0KPsbSWGI=;
        b=kYjWMpK3dvUHeXa/g2WpPhz8jGj/TipyT1WzCW/P1k7oG1z04Gk4iVlV02E+pPwOPG
         zfNhzoKcVrd252LAm5R3SjUhUlIMDm3t4Po0+AZgB6BYyC2YY9JHeoPD0i76FLWVPcoS
         C2lw5qE1/D5q//wCgSufzOlnnG/com2l1m80JL4M7gH9JhnHhpQfTtn1LecDuaONRm3d
         v1Ib7E08oZFiYHL8QPVbSrMmqHgyHFMheO6BAe1PQLEaGqcMgIF8b5Wj8md5dfz/LlRo
         D3oxUgaTEwUQqjxjTP/1SBiUuoPVeGKSM3tc02f5PCvulerSCOdW2t0qDeeWMK1CUuJD
         dYqA==
X-Forwarded-Encrypted: i=1; AJvYcCV2WS6WKS1WioLh9KFkmqfOx52Ay/JOAqVCgtFquMpnCkD6IwpW3sg+cPnhZ9V+IHRloyxJbAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg6cOKJI4CI1dZGp4a+atZqPtk6QPOrMOC7hQgFYxrZrmXRkSi
	4z0/gxVOAabFcQP8dSmpqRr7ckoSIYyPtBJfNCQhnXoPVdkqw4/2O5jfM33MYtK/Ifr7EOLiPs2
	pd3d2TaHNpbe7AlQfMXc44Ug1Z+YKB2ZLgR6+IyHS9hxMCpW/Ot7g2bDksA==
X-Gm-Gg: ASbGncs4hVFQEsg3DGenmnvUwK6Uf39O48/MIOcAv4wL8XaX+1U88+S1q+m5UAG2sZ7
	b8RBW5nysnQIgNMRhEyR6YStTJ+z0cc5If2nBCYaIgU6NhroXm5q0szuib5A95Gr85M5YeK5FJZ
	lkAuWlkGJQ9bKig1W05/fFbNOZRaCvRpOR+DrBZi+dWGAbYPPYrVoygwgX8qeQd889FTMtCIYG2
	pIGz3H0jjY2tidrW9yJFqBuFpOqJc8E28DSafoNxcHAs0z1AlmQOTN1vBaVVp8masMePDUOfdcF
	9bS9sNlWrYYb7kxFg+XdICOrMeivfLdpk7dGIjCibOn/1LDirYT2b2CTJCtldFaMVviXdgRbjfJ
	Npk8QP3qqETrCWDulvTMkHk7oCo81o20UyRl3zNTdVfT4
X-Received: by 2002:a05:6000:2484:b0:42b:4061:23f3 with SMTP id ffacd0b85a97d-42cc1d0cfb8mr45412951f8f.44.1764696763108;
        Tue, 02 Dec 2025 09:32:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF1p78x5oVSl8J1K0hLdN33xdjQtXcOiVKx3z5y/DnKU9Es5F72q9mjudjOUjvHHxTW/iWDA==
X-Received: by 2002:a05:6000:2484:b0:42b:4061:23f3 with SMTP id ffacd0b85a97d-42cc1d0cfb8mr45412903f8f.44.1764696762602;
        Tue, 02 Dec 2025 09:32:42 -0800 (PST)
Received: from localhost (net-5-89-201-160.cust.vodafonedsl.it. [5.89.201.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca40945sm34929004f8f.30.2025.12.02.09.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 09:32:42 -0800 (PST)
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
Subject: Re: [PATCH RFC net-next 4/6] cadence: macb/gem: add XDP support for
 gem
In-Reply-To: <DEJK1461002Y.TQON2T91OS6B@bootlin.com>
References: <20251119135330.551835-1-pvalerio@redhat.com>
 <20251119135330.551835-5-pvalerio@redhat.com>
 <DEJK1461002Y.TQON2T91OS6B@bootlin.com>
Date: Tue, 02 Dec 2025 18:32:41 +0100
Message-ID: <87bjkgzt52.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27 Nov 2025 at 03:41:56 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> w=
rote:

> On Wed Nov 19, 2025 at 2:53 PM CET, Paolo Valerio wrote:
>> @@ -1273,6 +1275,7 @@ struct macb_queue {
>>  	struct queue_stats stats;
>>  	struct page_pool	*page_pool;
>>  	struct sk_buff		*skb;
>> +	struct xdp_rxq_info	xdp_q;
>>  };
>
> Those are always named `xdp_rxq` inside the kernel, we should stick with
> the calling convention no?
>

sure

>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethe=
rnet/cadence/macb_main.c
>> index 5829c1f773dd..53ea1958b8e4 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -1344,10 +1344,51 @@ static void discard_partial_frame(struct macb_qu=
eue *queue, unsigned int begin,
>>  	 */
>>  }
>>=20=20
>> +static u32 gem_xdp_run(struct macb_queue *queue, struct xdp_buff *xdp,
>> +		       struct net_device *dev)
>
> Why pass `struct net_device` explicitly? It is in queue->bp->dev.
>

let's avoid this

>> +{
>> +	struct bpf_prog *prog;
>> +	u32 act =3D XDP_PASS;
>> +
>> +	rcu_read_lock();
>> +
>> +	prog =3D rcu_dereference(queue->bp->prog);
>> +	if (!prog)
>> +		goto out;
>> +
>> +	act =3D bpf_prog_run_xdp(prog, xdp);
>> +	switch (act) {
>> +	case XDP_PASS:
>> +		goto out;
>> +	case XDP_REDIRECT:
>> +		if (unlikely(xdp_do_redirect(dev, xdp, prog))) {
>> +			act =3D XDP_DROP;
>> +			break;
>> +		}
>> +		goto out;
>
> Why the `unlikely()`?
>

just expecting the err path to be the exception, although this is not
consistend with the XDP_TX path.
Do you prefer to remove it?

>> +	default:
>> +		bpf_warn_invalid_xdp_action(dev, prog, act);
>> +		fallthrough;
>> +	case XDP_ABORTED:
>> +		trace_xdp_exception(dev, prog, act);
>> +		fallthrough;
>> +	case XDP_DROP:
>> +		break;
>> +	}
>> +
>> +	page_pool_put_full_page(queue->page_pool,
>> +				virt_to_head_page(xdp->data), true);
>
> Maybe move that to the XDP_DROP, it is the only `break` in the above
> switch statement. It will be used by the default and XDP_ABORTED cases
> through fallthrough. We can avoid the out label and its two gotos that
> way.
>

We'd not put to page pool in case the redirect fails or am I missing
something?

>>  static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
>>  		  int budget)
>>  {
>>  	struct macb *bp =3D queue->bp;
>> +	bool			xdp_flush =3D false;
>>  	unsigned int		len;
>>  	unsigned int		entry;
>>  	void			*data;
>> @@ -1356,9 +1397,11 @@ static int gem_rx(struct macb_queue *queue, struc=
t napi_struct *napi,
>>  	int			count =3D 0;
>>=20=20
>>  	while (count < budget) {
>> -		u32 ctrl;
>> -		dma_addr_t addr;
>>  		bool rxused, first_frame;
>> +		struct xdp_buff xdp;
>> +		dma_addr_t addr;
>> +		u32 ctrl;
>> +		u32 ret;
>>=20=20
>>  		entry =3D macb_rx_ring_wrap(bp, queue->rx_tail);
>>  		desc =3D macb_rx_desc(queue, entry);
>> @@ -1403,6 +1446,22 @@ static int gem_rx(struct macb_queue *queue, struc=
t napi_struct *napi,
>>  			data_len =3D SKB_WITH_OVERHEAD(bp->rx_buffer_size) - bp->rx_offset;
>>  		}
>>=20=20
>> +		if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF)))
>> +			goto skip_xdp;
>> +
>> +		xdp_init_buff(&xdp, bp->rx_buffer_size, &queue->xdp_q);
>> +		xdp_prepare_buff(&xdp, data, bp->rx_offset, len,
>> +				 false);
>> +		xdp_buff_clear_frags_flag(&xdp);
>
> You prepare the XDP buffer before checking an XDP program is attached.
> Could we avoid this work? We'd move the xdp_buff preparation into
> gem_xdp_run(), after the RCU pointer dereference.
>

ack, makes sense

>> -static void gem_create_page_pool(struct macb_queue *queue)
>> +static void gem_create_page_pool(struct macb_queue *queue, int qid)
>>  {
>>  	struct page_pool_params pp_params =3D {
>>  		.order =3D 0,
>>  		.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
>>  		.pool_size =3D queue->bp->rx_ring_size,
>>  		.nid =3D NUMA_NO_NODE,
>> -		.dma_dir =3D DMA_FROM_DEVICE,
>> +		.dma_dir =3D rcu_access_pointer(queue->bp->prog)
>> +				? DMA_BIDIRECTIONAL
>> +				: DMA_FROM_DEVICE,
>
> Ah, that is the reason for page_pool_get_dma_dir() calls!
>

:)

>>  static int macb_change_mtu(struct net_device *dev, int new_mtu)
>>  {
>> +	int frame_size =3D new_mtu + ETH_HLEN + ETH_FCS_LEN + MACB_MAX_PAD;
>> +	struct macb *bp =3D netdev_priv(dev);
>> +	struct bpf_prog *prog =3D bp->prog;
>
> No fancy RCU macro?
>

right, guess an rcu_access_pointer() call is needed here

>> +static int macb_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>> +{
>> +	struct macb *bp =3D netdev_priv(dev);
>> +
>> +	if (!macb_is_gem(bp))
>> +		return 0;
>
> Returning 0 sounds like a mistake, -EOPNOTSUPP sounds more appropriate.
>

agreed

>> +	switch (xdp->command) {
>> +	case XDP_SETUP_PROG:
>> +		return gem_xdp_setup(dev, xdp->prog, xdp->extack);
>> +	default:
>> +		return -EINVAL;
>
> Same here: we want -EOPNOTSUPP. Otherwise caller cannot dissociate an
> unsupported call from one that is supported but failed.
>

ack

>> +	}
>> +}
>> +
>>  static void gem_update_stats(struct macb *bp)
>>  {
>>  	struct macb_queue *queue;
>> @@ -4390,6 +4529,7 @@ static const struct net_device_ops macb_netdev_ops=
 =3D {
>>  	.ndo_hwtstamp_set	=3D macb_hwtstamp_set,
>>  	.ndo_hwtstamp_get	=3D macb_hwtstamp_get,
>>  	.ndo_setup_tc		=3D macb_setup_tc,
>> +	.ndo_bpf		=3D macb_xdp,
>
> We want it to be "gem_" prefixed as it does not support MACB.
>

ack

> Thanks,
>
> --
> Th=C3=A9o Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


