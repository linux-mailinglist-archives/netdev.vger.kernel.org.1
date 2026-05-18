Return-Path: <netdev+bounces-288822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INo2Af18Cmqe1wQAu9opvQ
	(envelope-from <netdev+bounces-288822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 04:44:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9154D56527A
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 04:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D64E83002304
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 02:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE564364949;
	Mon, 18 May 2026 02:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="g5iet8hg"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE12F405C49
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 02:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779072248; cv=none; b=Ikju/92kAMnI9XdMk5qnQxSszT35851maQU363Mpn2htgaMBpnxqsI83SlQwBvChGlx+9IAAu4bb/SoJBlqZg3hFxLyFX+bVzMd5TjXf5En6yEZjYvu4FldDa6L1iB/lntbvwtOlI/k4YBG9GNBX5VX76lmnMs+bE4GZsnsLH1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779072248; c=relaxed/simple;
	bh=H1oXTuMaB2MbYUoVnBzzGdvUtI9H6ECHDj2aGDqoxZQ=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=nienO/YfCaVZW8QFqer35RTFHOQPY0NcVfBd8JwZ65uJZQ5W6+Ebv1twYNTWqHVUDkM0lDezwFYg3D+0bEcsBwABZjI04jweuQPQOMQ74APpfg2g+0NO+PKT5Sns0eidIgNkvxY4mgqe6ZjWJP/kD5Y1hu2Vdl/Hv2OTU7Th1Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=g5iet8hg; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779072244; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=+iaLjbo5dq2Hqc/Ej323u/Jyjfolz7K16l9OxTh1NjY=;
	b=g5iet8hgeuiJKr9NV1Mrjgc02TMxS9e+KrN7YczNQUdVm+O12wMDxPxYOl6HG+IFNGNw46pY2tbS7a3jCBBG4EYI9IqhdomDmohFXo8mXmo5Trf2rv8UpLISOIQEd0iliTn38gOzM+asbhc6ctYPLoKSUJ17rJObejN60uXklzg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X32zwnP_1779072242;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X32zwnP_1779072242 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 10:44:03 +0800
Message-ID: <1779071709.526365-6-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v43 5/8] eea: implement packet receive logic
Date: Mon, 18 May 2026 10:35:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Dong Yibo <dong100@mucse.com>,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Dust Li <dust.li@linux.alibaba.com>,
 netdev@vger.kernel.org
References: <20260514095138.80680-1-xuanzhuo@linux.alibaba.com>
 <20260514095138.80680-6-xuanzhuo@linux.alibaba.com>
 <1779071647.763595-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1779071647.763595-5-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 9154D56527A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288822-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,linux.dev,mucse.com,stu.xidian.edu.cn,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Action: no action

On Mon, 18 May 2026 10:34:07 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> =
wrote:
> From sashiko:
>
>
> commit 142959c3285196e5751c147c32a4a954a804d736
> Author: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> eea: implement packet receive logic
> This commit implements the EEA RX path: page-pool buffer management,
> per-descriptor metadata handling, packet assembly via build_skb()/
> napi_alloc_skb(), and submission through napi_gro_receive().  It also
> introduces a one-shot hardware-timestamp offset captured at probe time.
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/e=
thernet/alibaba/eea/eea_net.c
> > index cfb18a07e296..bf8581bc27ed 100644
> > --- a/drivers/net/ethernet/alibaba/eea/eea_net.c
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
> > @@ -642,6 +642,15 @@ static struct eea_net *eea_netdev_alloc(struct eea=
_device *edev, u32 pairs)
> >  	return enet;
> >  }
> >
> > +static void eea_update_ts_off(struct eea_device *edev, struct eea_net =
*enet)
> > +{
> > +	u64 ts;
> > +
> > +	ts =3D eea_pci_device_ts(edev);
> > +
> > +	enet->hw_ts_offset =3D ktime_get_real() - ts;
> > +}
> Is the choice of ktime_get_real() as the anchor for hardware RX
> timestamps intentional?
> Consumers of skb_hwtstamps()->hwtstamp typically expect a stable
> monotonic timeline; tying the offset to CLOCK_REALTIME means any later
> settimeofday(), NTP step, leap-second adjustment, or a probe that
> happens before NTP sync will permanently bias every reported hwtstamp.
> There is also no ptp_clock_register()/PHC and no periodic resync, so
> the offset captured here is the one used forever.
> Is the capture itself meant to be atomic with respect to scheduling?
> 	ts =3D eea_pci_device_ts(edev);
> 	enet->hw_ts_offset =3D ktime_get_real() - ts;
> eea_pci_device_ts() performs an MMIO read across PCIe and is then
> followed by ktime_get_real() with no preempt/IRQ disabling, so any
> transit or preemption delay between the two reads is permanently
> baked into hw_ts_offset for the lifetime of the device.
> Does this code handle 48-bit wraparound of the device timestamp
> counter?
> EEA_DESC_TS(desc) masks desc->ts to 48 bits via
> EEA_DESC_TS_MASK =3D GENMASK_ULL(47, 0), and hw_ts_offset is taken
> exactly once here at probe/reprobe.  After roughly 3.26 days of
> device uptime (2^48 ns) the per-packet computation
> EEA_DESC_TS(desc) + enet->hw_ts_offset will jump backwards by ~2^48
> ns relative to wall time, with no wrap detector, no resync, and no
> cyclecounter/timecounter wrapper.
> There is also a width inconsistency between this capture and the
> per-packet path:
> drivers/net/ethernet/alibaba/eea/eea_pci.c:eea_pci_device_ts() {
>     return cfg_read64(ep_dev->reg, hw_ts);
> }
> returns the full 64-bit register, while EEA_DESC_TS(desc) masks the
> descriptor field to 48 bits.  If bits 48..63 of the hw_ts register
> are ever non-zero, every reported hwtstamp would be off by at least
> 2^48 ns.

Indeed, this part is currently just a basic architectural framework. I have=
 not
included a full PTP implementation in this version, as it is slated for fut=
ure
development. I acknowledge that this implementation is currently incomplete.


> > @@ -711,6 +722,8 @@ int eea_net_probe(struct eea_device *edev)
> >  	if (err)
> >  		goto err_reset_dev;
> >
> > +	eea_update_ts_off(edev, enet);
> > +
> >  	netdev_dbg(enet->netdev, "eea probe success.\n");
> >
> >  	/* Queue TX/RX implementation is still in progress. register_netdev is
> [ ... ]
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_rx.c b/drivers/net/et=
hernet/alibaba/eea/eea_rx.c
> > index b1265048fbc3..9c71a7cf950e 100644
> > --- a/drivers/net/ethernet/alibaba/eea/eea_rx.c
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_rx.c
> [ ... ]
> > +static void process_first_buf(struct eea_net_rx *rx, struct eea_rx_ctx=
 *ctx)
> > +{
> > +	struct eea_net *enet =3D rx->enet;
> > +	struct sk_buff *skb =3D NULL;
> > +
> > +	if (eea_harden_check_size(ctx, enet))
> > +		goto err;
> > +
> > +	rx->pkt.data_valid =3D ctx->flags & EEA_DESC_F_DATA_VALID;
> Is the EEA_DESC_F_DATA_VALID bit (the source of CHECKSUM_UNNECESSARY)
> meant to be sampled only on the first descriptor of a multi-descriptor
> packet?
> process_first_buf() is the only place rx->pkt.data_valid is assigned,
> and process_remain_buf() does not touch it.  Meanwhile in
> eea_submit_skb() the timestamp comes from the EOP descriptor:
>     if (rx->pkt.data_valid)
>         skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>     if (enet->cfg.ts_cfg.rx_filter =3D=3D HWTSTAMP_FILTER_ALL)
>         skb_hwtstamps(skb)->hwtstamp =3D EEA_DESC_TS(desc) +
>             enet->hw_ts_offset;
> If the device places per-packet metadata on the EOP descriptor (a
> common NIC layout), every multi-segment frame would silently fall
> back to CHECKSUM_NONE.  Could the descriptor used for the checksum
> flag and for the timestamp be documented or made consistent?

On the RX path, for multi-descriptor packets, the information contained in =
all
descriptors is essentially the same. Since they all describe the same packe=
t, we
only need to sample EEA_DESC_F_DATA_VALID once. As for the hardware timesta=
mp,
we simply retrieve it from the last descriptor as a matter of convenience.

> > +
> > +	if (ctx->hdr_len)
> > +		skb =3D eea_rx_build_split_hdr_skb(rx, ctx);
> > +	else
> > +		skb =3D eea_rx_build_skb(rx, ctx);
> > +
> > +	if (unlikely(!skb))
> > +		goto err;
> > +
> > +	rx->pkt.head_skb =3D skb;
> > +
> > +	return;
> > +
> > +err:
> > +	rx->pkt.do_drop =3D true;
> > +}
> > +
> > +static void eea_submit_skb(struct eea_net_rx *rx, struct sk_buff *skb,
> > +			   struct eea_rx_cdesc *desc)
> > +{
> > +	struct eea_net *enet =3D rx->enet;
> > +
> > +	if (rx->pkt.data_valid)
> > +		skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> > +
> > +	if (enet->cfg.ts_cfg.rx_filter =3D=3D HWTSTAMP_FILTER_ALL)
> > +		skb_hwtstamps(skb)->hwtstamp =3D EEA_DESC_TS(desc) +
> > +			enet->hw_ts_offset;
> Is the strict equality with HWTSTAMP_FILTER_ALL intentional?
> The usual driver convention for SIOCSHWTSTAMP is to either reject
> unsupported filters or upgrade them to ALL, so that consumers
> requesting more specific filters (PTP_V2_*, NTP_ALL, etc.) still
> get timestamps on matching frames.  With the strict comparison
> above, anything other than HWTSTAMP_FILTER_ALL yields no timestamps.
> There is no SIOCSHWTSTAMP setter in this series, so the branch is
> effectively unreachable today, but it may be worth revisiting
> together with whatever setter lands later.
> > +
> > +	skb_record_rx_queue(skb, rx->index);
> > +	skb->protocol =3D eth_type_trans(skb, enet->netdev);
> > +
> > +	napi_gro_receive(rx->napi, skb);
> > +}
> [ ... ]
> > +static int eea_cleanrx(struct eea_net_rx *rx, int budget,
> > +		       struct eea_rx_ctx *ctx)
> > +{
> > +	struct eea_rx_cdesc *desc;
> > +	struct eea_rx_meta *meta;
> > +	int recv, err;
> > +
> > +	for (recv =3D 0; recv < budget; ) {
> > +		desc =3D eea_ering_cq_get_desc(rx->ering);
> > +		if (!desc)
> > +			break;
> > +
> > +		err =3D eea_rx_desc_to_ctx(rx, ctx, desc);
> > +		if (unlikely(err)) {
> > +			if (ctx->meta)
> > +				eea_rx_meta_put(rx, ctx->meta);
> > +
> > +			if (rx->pkt.head_skb)
> > +				dev_kfree_skb(rx->pkt.head_skb);
> > +
> > +			/* A hardware error occurred; we are attempting to
> > +			 * mitigate the impact. Subsequent packets may be
> > +			 * corrupted.
> > +			 */
> > +			ctx->more =3D false;
> > +			goto ack;
> > +		}
> Can this recovery path forward arbitrary mid-payload bytes to the
> network stack as a fresh L2 frame?
> When eea_rx_desc_to_ctx() fails mid-stream (invalid id, or len
> greater than meta->len), this branch frees rx->pkt.head_skb, forces
> ctx->more =3D false, and jumps to ack.  The tail of the loop then
> runs:
>     if (!ctx->more) {
>         memset(&rx->pkt, 0, sizeof(rx->pkt));
>         ++recv;
>     }
> so no "still inside a device-side packet" indicator survives.  The
> next descriptor from the device =E2=80=94 which may be a continuation
> buffer of the original frame =E2=80=94 will be handled by process_first_b=
uf()
> because rx->pkt.idx =3D=3D 0.  If that continuation satisfies
> ctx->len >=3D ETH_HLEN, an skb is built from raw mid-payload bytes
> and submitted via eth_type_trans()/napi_gro_receive().
> Would setting rx->pkt.do_drop =3D true (and only clearing rx->pkt on
> the next observed !more) be a safer way to mitigate, given the
> existing comment already notes "subsequent packets may be
> corrupted"?


During multi-fragment processing=E2=80=94specifically, whether a mid-stream
exception might cause the driver to misidentify subsequent fragments as the
start of a new packet. However, from a driver perspective, there is little
we can do in such scenarios; if the hardware state becomes corrupted in
this way, it constitutes a critical hardware error that is effectively
beyond the driver's recovery capability.


> > +
> > +		meta =3D ctx->meta;
> > +
> > +		if (unlikely(rx->pkt.do_drop))
> > +			goto skip;
> > +
> > +		eea_rx_meta_dma_sync_for_cpu(rx, meta, ctx->len);
> > +
> > +		rx->pkt.recv_len +=3D ctx->len;
> > +		rx->pkt.recv_len +=3D ctx->hdr_len;
> > +
> > +		if (!rx->pkt.idx)
> > +			process_first_buf(rx, ctx);
> > +		else
> > +			process_remain_buf(rx, ctx);
> > +
> > +		++rx->pkt.idx;
> > +
> > +		if (!ctx->more && rx->pkt.head_skb)
> > +			eea_submit_skb(rx, rx->pkt.head_skb, desc);
> > +
> > +skip:
> > +		eea_rx_meta_put(rx, meta);
> > +ack:
> > +		eea_ering_cq_ack_desc(rx->ering, 1);
> > +
> > +		if (!ctx->more) {
> > +			memset(&rx->pkt, 0, sizeof(rx->pkt));
> > +			++recv;
> > +		}
> > +	}
> > +
> > +	return recv;
> > +}

