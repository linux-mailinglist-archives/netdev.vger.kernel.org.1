Return-Path: <netdev+bounces-287128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM3aDLolA2oF1AEAu9opvQ
	(envelope-from <netdev+bounces-287128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:06:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CE67C520A69
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6501308F171
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7376E394EB7;
	Tue, 12 May 2026 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JF80eiLv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F076394EB0;
	Tue, 12 May 2026 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590662; cv=none; b=E346zfUk8+JHY1uiyOIkKUbH8XDtdhuo13hW9YXfTbvQnHYaq98TME5J+v9eSuVJFpfb9t62/g4r19+p5JJ93n4P5xjzVFM6S848s4qsekW3EnvDcubRBLaNqA0908ICDnnfmvi2fo70T9jpaTFx87HsgngrXclrZsmbXUznZcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590662; c=relaxed/simple;
	bh=kpG+VXwSiZgmZUnurmnl9yu9eusp8zOa+PomzsYrx/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eZNneUOBtSr0lIdhgvm5i2rzXNMm8yZWbHTzf8M+Vv+qyFn0OL+SFO0lnTIkLjtSOZCf4q3+ha8eSRJg9q2up85X8nN7MvQuKEZU6EESKzjrmoIRaleZnFIBWNpLoUtCMJdvPAMXJAvn2P2agiMBid3x7I0+AYux9pW1r2cP8Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JF80eiLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B401FC2BCB0;
	Tue, 12 May 2026 12:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778590662;
	bh=kpG+VXwSiZgmZUnurmnl9yu9eusp8zOa+PomzsYrx/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JF80eiLvhi+9JuIMxGXJmx2qRV2/Erl3gHkyJviejLYN9Mh5q4nGMOJ+VCknzard+
	 K8EETKdQ0Avv2tkDnK7ECvGTAWT8EX/kNE7QAQeIo0OmjWdzmbCYR18uv5Bpp+F2AG
	 Wiy4JkHqXHIzQmyDtvuKcwuyD1aA4L4wH2THuAT0dfWbEZE05qjZ+MHvzfzWDw4xgv
	 shb4B0HKZNrLmehYOGGXnkvypeHTbvXc1L0WDUTCJkSprLSKXOVquGjGw94Ecq4sWG
	 KfMDVwBT9Q8ZuhxdmTu5mFss9GbfiGl29vltXBc2rTF5Tke5Dsq5/0dHQn4P9kFzp6
	 717r+BHMIQnqw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, lorenzo@kernel.org,
 hawk@kernel.org, toke@redhat.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH RFC net-next 2/4] xdp: return status from generic_xdp_tx()
In-Reply-To: <20260509084858.773921-3-maciej.fijalkowski@intel.com>
References: <20260509084858.773921-1-maciej.fijalkowski@intel.com>
 <20260509084858.773921-3-maciej.fijalkowski@intel.com>
Date: Tue, 12 May 2026 14:57:38 +0200
Message-ID: <87bjekkcot.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CE67C520A69
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.49 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287128-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,all.your.base.are.belong.to.us:mid]
X-Rspamd-Action: no action

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Once veth will start to use __do_xdp_generic(), this will be helpful for
> correct stats values being incremented - otherwise we would not have a
> knowledge whether XDP_TX succeeded or not. With this being implemented we
> will only bump xdp_tx stat when actual transmission happened.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  include/linux/netdevice.h |  2 +-
>  kernel/bpf/devmap.c       |  2 +-
>  net/core/dev.c            | 11 +++++++++--
>  net/core/filter.c         |  2 +-
>  4 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 47417b2d48a4..473b18b0bb63 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -4255,7 +4255,7 @@ static inline void dev_consume_skb_any(struct sk_bu=
ff *skb)
>=20=20
>  u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
>  			     const struct bpf_prog *xdp_prog);
> -void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog=
);
> +int generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog);
>  int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **psk=
b);
>  int netif_rx(struct sk_buff *skb);
>  int __netif_rx(struct sk_buff *skb);
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 3d619d01088e..b7a4a0266345 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -714,7 +714,7 @@ int dev_map_generic_redirect(struct bpf_dtab_netdev *=
dst, struct sk_buff *skb,
>  		return 0;
>=20=20
>  	skb->dev =3D dst->dev;
> -	generic_xdp_tx(skb, xdp_prog);
> +	(void)generic_xdp_tx(skb, xdp_prog);

Why not propagate the error now that we can?

>=20=20
>  	return 0;
>  }
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 6cc2a5bed20f..09012cdea376 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5628,11 +5628,12 @@ static u32 netif_receive_generic_xdp(struct sk_bu=
ff **pskb,
>   * and DDOS attacks will be more effective. In-driver-XDP use dedicated =
TX
>   * queues, so they do not have this starvation issue.
>   */
> -void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog)
> +int generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog)
>  {
>  	struct net_device *dev =3D skb->dev;
>  	struct netdev_queue *txq;
>  	bool free_skb =3D true;
> +	int err =3D -ENETDOWN;
>  	int cpu, rc;
>=20=20
>  	txq =3D netdev_core_pick_tx(dev, skb, NULL);
> @@ -5640,8 +5641,12 @@ void generic_xdp_tx(struct sk_buff *skb, const str=
uct bpf_prog *xdp_prog)
>  	HARD_TX_LOCK(dev, txq, cpu);
>  	if (!netif_xmit_frozen_or_drv_stopped(txq)) {
>  		rc =3D netdev_start_xmit(skb, dev, txq, 0);
> -		if (dev_xmit_complete(rc))
> +		if (dev_xmit_complete(rc)) {
>  			free_skb =3D false;
> +			err =3D 0;
> +		} else {
> +			err =3D -EBUSY;
> +		}
>  	}
>  	HARD_TX_UNLOCK(dev, txq);
>  	if (free_skb) {
> @@ -5649,6 +5654,8 @@ void generic_xdp_tx(struct sk_buff *skb, const stru=
ct bpf_prog *xdp_prog)
>  		dev_core_stats_tx_dropped_inc(dev);
>  		kfree_skb(skb);
>  	}
> +
> +	return err;
>  }
>=20=20
>  static DEFINE_STATIC_KEY_FALSE(generic_xdp_needed_key);
> diff --git a/net/core/filter.c b/net/core/filter.c
> index bf9c37b27646..d6d14e0a1e35 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4619,7 +4619,7 @@ int xdp_do_generic_redirect(struct net_device *dev,=
 struct sk_buff *skb,
>=20=20
>  		skb->dev =3D fwd;
>  		_trace_xdp_redirect(dev, xdp_prog, ri->tgt_index);
> -		generic_xdp_tx(skb, xdp_prog);
> +		(void)generic_xdp_tx(skb, xdp_prog);


Dito.


Bj=C3=B6rn

