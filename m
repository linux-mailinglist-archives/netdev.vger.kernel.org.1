Return-Path: <netdev+bounces-262597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBvtIIdkpWn0/QUAu9opvQ
	(envelope-from <netdev+bounces-262597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 11:20:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACA81D6589
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 11:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7AEA230200F2
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 10:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565A638F62E;
	Mon,  2 Mar 2026 10:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aERnsOFL"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F0394483
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446544; cv=none; b=jdmQOmaucmKaSl0rgBrj3Pn2a60TBHjEBO1ucKg6a4vAlCcl6rHqqi6wgPZ6kbXVCw3u6GmCX/uZPu6DMgxwHdKAPDd30VzMbqSRYqV9f9IVfPpeXAtP4I0Yn5K0qgGFB8CcqTnWxjP8IOQOPaT/1RzNlJ79g8w+n8FVBUUMMkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446544; c=relaxed/simple;
	bh=VM2a2BeuVgfGi1ShAXDtMB92p4B/RtLDTkk5cGM+saY=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=VH2qhUEXyMlikQqG8YOt3bdAzK9kThdTAduA/nSwmYg6Y5jGcOA5J/85UWHp38VKdSADZTCNjJMaCSwutZ5M/1ZImey5/t1hIEQthW4ow36JzQFuxEWnqkIZWyFZk/51qU3VlsOkg+FmuxsJGeSWDojCu7rEzOsj9CFFv5FxPr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aERnsOFL; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772446530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CSeL517KPCXAMzvziO2NinmrAr+nMWkzlUfOO21t6Vc=;
	b=aERnsOFLNEAqLlHB/bLDI13cu6rZN8FFkuVi6DTSGcbPUom+ThQEt2Hcr2k/fHnDr3RQoF
	6XerNbJjSsQGJEeUa5C7MU77RVHEXfDonFAjzT8ANp6fzkr6ewMEFyUqqxXEOUG6oKpw1m
	7ceXuMVeLXMxz2+c3sHcWH+CDafnvKE=
Date: Mon, 02 Mar 2026 10:15:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <e4a2a652784ec206728eb3a929a9892238c61f06@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v3 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: "Jay Vosburgh" <jv@jvosburgh.net>, netdev@vger.kernel.org,
 jiayuna.chen@linux.dev, jiayuna.chen@shopee.com, "Jiayuan Chen"
 <jiayuan.chen@shopee.com>,
 syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Jesper Dangaard Brouer"
 <hawk@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "KP Singh"
 <kpsingh@kernel.org>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Jussi
 Maki" <joamaki@gmail.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
In-Reply-To: <20260302081021.MiQQ_LQr@linutronix.de>
References: <20260228021918.141002-1-jiayuan.chen@linux.dev>
 <20260228021918.141002-2-jiayuan.chen@linux.dev>
 <999129.1772247707@famine>
 <08041bd78c06981b18b3de90a95e0c951bf1623c@linux.dev>
 <20260302081021.MiQQ_LQr@linutronix.de>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262597-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[jvosburgh.net,vger.kernel.org,linux.dev,shopee.com,syzkaller.appspotmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,goodmis.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,80e046b8da2820b6ba73];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: 7ACA81D6589
X-Rspamd-Action: no action

March 2, 2026 at 16:10, "Sebastian Andrzej Siewior" <bigeasy@linutronix.d=
e mailto:bigeasy@linutronix.de?to=3D%22Sebastian%20Andrzej%20Siewior%22%2=
0%3Cbigeasy%40linutronix.de%3E > wrote:


>=20
>=20On 2026-02-28 03:36:24 [+0000], Jiayuan Chen wrote:
>=20
>=20>=20
>=20> My only concern is that this will waste a percpu u32 per bond
> >  device for the majority of bonding use cases (which use modes other =
than
> >  balance-rr), which could be a few hundred bytes on a large machine.
> >=20=20
>=20>  Does everything work reliably if the rr_tx_counter allocation
> >  happens conditionally on mode =3D=3D BOND_MODE_ROUNDROBIN in bond_se=
tup, as
> >  well as in bond_option_mode_set?
> >=20
>=20=E2=80=A6
>=20
>=20>=20
>=20> An alternative would be to allocate conditionally in bond_init() (s=
ince the default mode is round-robin)
> >  and manage allocation/deallocation in bond_option_mode_set() when th=
e mode changes.
> >=20
>=20This sounds reasonable.
>=20
>=20>=20
>=20> This is a trade-off between the added complexity of conditional all=
oc/free across multiple code
> >  paths and saving a per-CPU u32 for non-round-robin bonds.
> >=20=20
>=20>  For the per-CPU u32 overhead, it's only 4 extra bytes per CPU per =
bond device =E2=80=94 and machines with
> >  that many CPUs tend to have plenty of memory to match.
> >=20
>=204 bytes is the minimum allocation for per-CPU memory. The memory is
> already "there" it is just not assigned. So for the 4 byte allocation i=
t
> is needed to find a single area (the smallest allocation size).
> In case there no free block, a new block will be allocated and mapped
> for each CPU which the part that costs memory.
> That said, we should not waste memory but it is not _that_ expensive
> either for a bond device. Things change if here are hundreds of devices=
.


Hi Jay, Sebastian,

Sorry, the conditional alloc/free approach in bond_option_mode_set()
I suggested earlier doesn't work well on closer inspection.

Since bond_option_mode_set() requires the bond to be down, and as this
bug shows, the XDP redirect path can still reach a downed bond device,
we need to carefully order the operations:

when switching to RR, alloc rr_tx_counter before setting mode;
when switching away, set mode before freeing rr_tx_counter.

Strictly speaking, this also requires smp_wmb()/smp_rmb() pairs to
guarantee the ordering is visible to other CPUs =E2=80=94 the write side =
in
bond_option_mode_set() and the read side in the XDP path.

In practice the race window is very small and unlikely to trigger, but
leaving out the barriers would look incorrect, and adding them to the
XDP hot path feels wrong for saving only 4 bytes per CPU per bond device.


smp_wmb()/smp_rmb() (no test):=20

diff=20--git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond=
_main.c
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4279,12 +4279,6 @@ static int bond_open(struct net_device *bond_dev)
	struct list_head *iter;
	struct slave *slave;

-     if (BOND_MODE(bond) =3D=3D BOND_MODE_ROUNDROBIN && !bond->rr_tx_cou=
nter) {
-             bond->rr_tx_counter =3D alloc_percpu(u32);
-             if (!bond->rr_tx_counter)
-                     return -ENOMEM;
-     }
-
	/* reset slave->backup and slave->inactive */
	if (bond_has_slaves(bond)) {
			bond_for_each_slave(bond, slave, iter) {
@@ -5532,6 +5526,8 @@ bond_xdp_get_xmit_slave(struct net_device *bond_dev=
, struct xdp_buff *xdp)

	switch (BOND_MODE(bond)) {
	case BOND_MODE_ROUNDROBIN:
+             /* Pairs with smp_wmb() in bond_option_mode_set() */
+             smp_rmb();
			slave =3D bond_xdp_xmit_roundrobin_slave_get(bond, xdp);
			break;

@@ -6411,6 +6407,14 @@ static int bond_init(struct net_device *bond_dev)
	if (!bond->wq)
			return -ENOMEM;

+     /* Default mode is round-robin, allocate rr_tx_counter for it.
+      * For mode changes, bond_option_mode_set() manages the lifecycle.
+      */
+     bond->rr_tx_counter =3D alloc_percpu(u32);
+     if (!bond->rr_tx_counter) {
+             destroy_workqueue(bond->wq);
+             return -ENOMEM;
+     }
+
	bond->notifier_ctx =3D false;

diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bon=
d_options.c
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -918,7 +918,27 @@ static int bond_option_mode_set(struct bonding *bond=
,
	/* don't cache arp_validate between modes */
	bond->params.arp_validate =3D BOND_ARP_VALIDATE_NONE;
-     bond->params.mode =3D newval->value;
+
+     if (newval->value =3D=3D BOND_MODE_ROUNDROBIN) {
+             /* Switching to round-robin: allocate before setting mode,
+              * so XDP path seeing BOND_MODE_ROUNDROBIN always finds
+              * rr_tx_counter allocated.
+              */
+             if (!bond->rr_tx_counter) {
+                     bond->rr_tx_counter =3D alloc_percpu(u32);
+                     if (!bond->rr_tx_counter)
+                             return -ENOMEM;
+             }
+             /* Pairs with smp_rmb() in bond_xdp_get_xmit_slave() */
+             smp_wmb();
+             bond->params.mode =3D newval->value;
+     } else {
+             /* Switching away: set mode first so XDP no longer
+              * enters RR branch before we free rr_tx_counter.
+              */
+             bond->params.mode =3D newval->value;
+             /* Pairs with smp_rmb() in bond_xdp_get_xmit_slave() */
+             smp_wmb();
+             free_percpu(bond->rr_tx_counter);
+             bond->rr_tx_counter =3D NULL;
+     }

Thanks,
Jiayuan


> >=20
>=20> Thanks
> >=20=20
>=20>  -J
> >=20
>=20Sebastian
>

