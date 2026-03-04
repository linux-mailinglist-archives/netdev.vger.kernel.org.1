Return-Path: <netdev+bounces-263656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGFgEcbxp2k1mwAAu9opvQ
	(envelope-from <netdev+bounces-263656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:48:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5861FCDB8
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8112305149F
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 08:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DC337C90A;
	Wed,  4 Mar 2026 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E3EtE0oN"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC68375F92
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772614059; cv=none; b=qEVa3xhyOb7KOHEWFNUdo3EPoOddbYUL8NGGc8xYmjKBBl1XEj3cTmvazIsAUulcFxmGiHBwjIjSRpDOHKsksNCsuGjUsedUvdx9vJRmu6QjAkzQlvvEct0PQzE/FxdrMxUyVcOTqtU4ijh+MtgZu9jKUtzjnX+n7oxhaiI0dOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772614059; c=relaxed/simple;
	bh=cgfolX/7P15FKtMsJb6MX1V6rbxoScmH5mSHaS1xVR4=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=BjwPeSu+fVqOALz7TQo0re6TX0FfIytrLdLli9peuEScHJ6kKe3v4Tp3qnXkzZQvMU4PxBs7M1hcz7qx4Y0BSaINtTfAk2X6wrB0O0zd68b6Gal2E6f3IsvesU8jSoGqxUN7wqlhu94N/eJ0uPcwWSK7F41c64+801jL3H4fyoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E3EtE0oN; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772614045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dc/aEcqelhTT2IvgJHrb+iCX75+YFw+/qXWWRUVS9lU=;
	b=E3EtE0oNbTyvC5M1kZvNH9BIoDQEjd51tBmBwvFLbjoxEfR6D46JqwqDREAxIuNb1pJU83
	ri5yj8mbfF0oimBpWeaatrFO5KgLm9VWGpSlYT96oZV/qJ4/URs8NOSCO/204RaxpZbwGL
	sSIr/CnDXTjXtyvL+7/fF3XTlhmEjB8=
Date: Wed, 04 Mar 2026 08:47:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <e5b871b9b2817219f50d43f7479df8d1cca38901@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v4 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
To: "Daniel Borkmann" <daniel@iogearbox.net>, jv@jvosburgh.net,
 netdev@vger.kernel.org
Cc: jiayuan.chen@shopee.com,
 syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "KP
 Singh" <kpsingh@kernel.org>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "Sebastian Andrzej
 Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Jussi
 Maki" <joamaki@gmail.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
In-Reply-To: <4d15be93-b497-4499-996d-9f3a67a2abc6@iogearbox.net>
References: <20260304074301.35482-1-jiayuan.chen@linux.dev>
 <20260304074301.35482-2-jiayuan.chen@linux.dev>
 <4d15be93-b497-4499-996d-9f3a67a2abc6@iogearbox.net>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: AE5861FCDB8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263656-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[shopee.com,syzkaller.appspotmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,fomichev.me,linux.dev,linutronix.de,goodmis.org,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,80e046b8da2820b6ba73];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iogearbox.net:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,shopee.com:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Action: no action

March 4, 2026 at 16:20, "Daniel Borkmann" <daniel@iogearbox.net mailto:da=
niel@iogearbox.net?to=3D%22Daniel%20Borkmann%22%20%3Cdaniel%40iogearbox.n=
et%3E > wrote:


>=20
>=20On 3/4/26 8:42 AM, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >  bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NU=
LL
> >  check. rr_tx_counter is a per-CPU counter only allocated in bond_ope=
n()
> >  when the bond mode is round-robin. If the bond device was never brou=
ght
> >  up, rr_tx_counter remains NULL, causing a null-ptr-deref.
> >  The XDP redirect path can reach this code even when the bond is not =
up:
> >  bpf_master_redirect_enabled_key is a global static key, so when any =
bond
> >  device has native XDP attached, the XDP_TX -> xdp_master_redirect()
> >  interception is enabled for all bond slaves system-wide. This allows=
 the
> >  path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
> >  bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
> >  reached on a bond that was never opened.
> >  Fix this by allocating rr_tx_counter unconditionally in bond_init()
> >  (ndo_init), which is called by register_netdevice() and covers both
> >  device creation paths (bond_create() and bond_newlink()). This also
> >  handles the case where bond mode is changed to round-robin after dev=
ice
> >  creation. The conditional allocation in bond_open() is removed. Sinc=
e
> >  bond_destructor() already unconditionally calls
> >  free_percpu(bond->rr_tx_counter), the lifecycle is clean: allocate a=
t
> >  ndo_init, free at destructor.
> >  Note: rr_tx_counter is only used by round-robin mode, so this
> >  deliberately allocates a per-cpu u32 that goes unused for other mode=
s.
> >  Conditional allocation (e.g., in bond_option_mode_set) was considere=
d
> >  but rejected: the XDP path can race with mode changes on a downed bo=
nd,
> >  and adding memory barriers to the XDP hot path is not justified for
> >  saving 4 bytes per CPU.
> >=20
>=20Arguably it's a corner case, but could we not just do sth like this t=
o
> actually check if the device is up and if not drop?
>=20
>=20diff --git a/net/core/filter.c b/net/core/filter.c
> index ba019ded773d..c447fd989a27 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4387,6 +4387,9 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
>  struct net_device *master, *slave;
>  master =3D netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
> + if (unlikely(!(master->flags & IFF_UP)))
> + return XDP_ABORTED;
> +
>  slave =3D master->netdev_ops->ndo_xdp_get_xmit_slave(master, xdp);
>  if (slave && slave !=3D xdp->rxq->dev) {
>  /* The target device is different from the receiving device, so
>

Hi Daniel,

It was discussed at [1].

The primary concern at the time was that assuming
bond->rr_tx_counter had been allocated based on the
interface being up was too implicit.

[1] https://lore.kernel.org/netdev/20260224112545.37888-1-jiayuan.chen@li=
nux.dev/T/#t

Feel free to share any other thoughts or ideas

Thanks,

