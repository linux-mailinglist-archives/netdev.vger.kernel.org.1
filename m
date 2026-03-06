Return-Path: <netdev+bounces-264627-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BiyDwg/qmnGNwEAu9opvQ
	(envelope-from <netdev+bounces-264627-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:42:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC3E21AACB
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00634302614A
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 02:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B5B327BFC;
	Fri,  6 Mar 2026 02:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fnjQCxqX"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F70353ED9
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 02:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772764933; cv=none; b=pPu7OxmDfCJb8JvBlwI98cGvu2jS/my2mWqqRLfJ0FCnJILsMGqYeaID9WvIQek5R5w4NiPUGGwBtiRjvTbMhX6BYcPqSpdHL/2GuiXOVH51h9uF8fwEOW4B2dUR2oUVVHxR3tU2iLthV7ECVBYVNbI7hgblnMQdIax4lPBhYh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772764933; c=relaxed/simple;
	bh=v4cflm4NiRNKit0+IyjvwCr+f6yIyaerrT9iAHpzkIU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=otvC5F73tBha3rlpZtTs6UQLCX6pb3N8awnzmFpZRPQ+ZBEH3CJPQoOykusVJ+SjlPj1Jms94SEvKH11kmGvFtPPV4+zBJRwURqJcrVb1j/ugIhE6ZRbCx3fNEgU+3ED6jIqhYetaDcG5BwGve+DWMUh0soXmZDrj9g8ITDcsfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fnjQCxqX; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772764929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/7M8Q3sVB0HPgbs9UCg3aqgHeu4f7DPzAlrQa5392Y=;
	b=fnjQCxqXAMRp37ZcPFn9LlnceurWpFBB9B2+YtuSlaxPqcpkS+UHJi0+LkQoG8VLp90//y
	g4wAh6ZSpng0H91NYyOONQGjyId1JhnzdUEh/00XwLhdZMZgwvZ5Vjb0lFdFX1oeGVMjEM
	89ppIQryir/ENCv097hDuCwxq9ZZbDc=
Date: Fri, 06 Mar 2026 02:42:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <e08dcb78a13fc69be07d28d032cebe3734797a3a@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v4 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
To: "Jay Vosburgh" <jv@jvosburgh.net>, "Nikolay Aleksandrov"
 <razor@blackwall.org>
Cc: netdev@vger.kernel.org, jiayuan.chen@shopee.com,
 syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Jesper Dangaard Brouer"
 <hawk@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "KP Singh" <kpsingh@kernel.org>, "Hao
 Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 "Clark Williams" <clrkwllms@kernel.org>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Jussi Maki" <joamaki@gmail.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <1356528.1772744631@famine>
References: <20260304074301.35482-1-jiayuan.chen@linux.dev>
 <20260304074301.35482-2-jiayuan.chen@linux.dev>
 <aahWymAi_CtRG0gJ@penguin> <1293120.1772645248@famine>
 <aahsuPt7cY8LxETN@penguin> <1356528.1772744631@famine>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 8FC3E21AACB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264627-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,shopee.com,syzkaller.appspotmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,linutronix.de,goodmis.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,80e046b8da2820b6ba73];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jvosburgh.net:email,linux.dev:dkim,linux.dev:mid,appspotmail.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,shopee.com:email,blackwall.org:email]
X-Rspamd-Action: no action

2026/3/6 05:03, "Jay Vosburgh" <jv@jvosburgh.net mailto:jv@jvosburgh.net?=
to=3D%22Jay%20Vosburgh%22%20%3Cjv%40jvosburgh.net%3E > wrote:


>=20
>=20Nikolay Aleksandrov <razor@blackwall.org> wrote:
>=20
>=20>=20
>=20> On Wed, Mar 04, 2026 at 09:27:28AM -0800, Jay Vosburgh wrote:
> >=20
>=20> >=20
>=20> > Nikolay Aleksandrov <razor@blackwall.org> wrote:
> > >=20=20
>=20> >  >On Wed, Mar 04, 2026 at 03:42:57PM +0800, Jiayuan Chen wrote:
> > >  >> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> > >  >>=20
>=20> >  >> bond_rr_gen_slave_id() dereferences bond->rr_tx_counter witho=
ut a NULL
> > >  >> check. rr_tx_counter is a per-CPU counter only allocated in bon=
d_open()
> > >  >> when the bond mode is round-robin. If the bond device was never=
 brought
> > >  >> up, rr_tx_counter remains NULL, causing a null-ptr-deref.
> > >  >>=20
>=20> >  >> The XDP redirect path can reach this code even when the bond =
is not up:
> > >  >> bpf_master_redirect_enabled_key is a global static key, so when=
 any bond
> > >  >> device has native XDP attached, the XDP_TX -> xdp_master_redire=
ct()
> > >  >> interception is enabled for all bond slaves system-wide. This a=
llows the
> > >  >> path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
> > >  >> bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() =
to be
> > >  >> reached on a bond that was never opened.
> > >  >>=20
>=20> >  >> Fix this by allocating rr_tx_counter unconditionally in bond_=
init()
> > >  >> (ndo_init), which is called by register_netdevice() and covers =
both
> > >  >> device creation paths (bond_create() and bond_newlink()). This =
also
> > >  >> handles the case where bond mode is changed to round-robin afte=
r device
> > >  >> creation. The conditional allocation in bond_open() is removed.=
 Since
> > >  >> bond_destructor() already unconditionally calls
> > >  >> free_percpu(bond->rr_tx_counter), the lifecycle is clean: alloc=
ate at
> > >  >> ndo_init, free at destructor.
> > >  >>=20
>=20> >  >> Note: rr_tx_counter is only used by round-robin mode, so this
> > >  >> deliberately allocates a per-cpu u32 that goes unused for other=
 modes.
> > >  >> Conditional allocation (e.g., in bond_option_mode_set) was cons=
idered
> > >  >> but rejected: the XDP path can race with mode changes on a down=
ed bond,
> > >  >> and adding memory barriers to the XDP hot path is not justified=
 for
> > >  >> saving 4 bytes per CPU.
> > >  >>=20
>=20> >  >> Fixes: 879af96ffd72 ("net, core: Add support for XDP redirect=
ion to slave device")
> > >  >> Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.=
com
> > >  >> Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00=
cc.GAE@google.com/T/
> > >  >> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> > >  >> ---
> > >  >> drivers/net/bonding/bond_main.c | 19 +++++++++++++------
> > >  >> 1 file changed, 13 insertions(+), 6 deletions(-)
> > >  >>=20
>=20> >  >
> > >  >IMO it's not worth it to waste memory in all modes, for an unpopu=
lar mode.
> > >  >I think it'd be better to add a null check in bond_rr_gen_slave_i=
d(),
> > >  >READ/WRITE_ONCE() should be enough since it is allocated only onc=
e, and
> > >  >freed when the xmit code cannot be reachable anymore (otherwise w=
e'd have
> > >  >more bugs now). The branch will be successfully predicted practic=
ally always,
> > >  >and you can also mark the ptr being null as unlikely. That way on=
ly RR takes
> > >  >a very minimal hit, if any.
> > >=20=20
>=20> >  Is what you're suggesting different from Jiayuan's proposal[0],
> > >  in the sense of needing barriers in the XDP hot path to insure ord=
ering?
> > >=20=20
>=20> >  If I understand correctly, your suggestion is something like
> > >  (totally untested):
> > >=20
>=20> Basically yes, that is what I'm proposing + an unlikely() around th=
at
> > null check since it is really unlikely and will be always predicted
> > correctly, this way it's only for RR mode.
> >=20
>=20 Jiayuan,
>=20
>=20 Do you agree that the patch below (including Nikolay's
> suggestion to add "unlikely") resolves the original issue without memor=
y
> waste, and without introducing performance issues (barriers) into the
> XDP path?


Sure, it's basically similar to what my v1 did, but the patch below can b=
e more generic.

https://lore.kernel.org/netdev/20260224112545.37888-1-jiayuan.chen@linux.=
dev/T/#m08e3e53a8aa8d837ddc9242f4b14f2651a2b00aa

>  -J
>=20
>=20>=20
>=20> >=20
>=20> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bondin=
g/bond_main.c
> > >  index eb27cacc26d7..ac2a4fc0aad0 100644
> > >  --- a/drivers/net/bonding/bond_main.c
> > >  +++ b/drivers/net/bonding/bond_main.c
> > >  @@ -4273,13 +4273,17 @@ void bond_work_cancel_all(struct bonding *=
bond)
> > >  static int bond_open(struct net_device *bond_dev)
> > >  {
> > >  struct bonding *bond =3D netdev_priv(bond_dev);
> > >  + u32 __percpu *rr_tx_tmp;
> > >  struct list_head *iter;
> > >  struct slave *slave;
> > >=20=20
>=20> >  - if (BOND_MODE(bond) =3D=3D BOND_MODE_ROUNDROBIN && !bond->rr_t=
x_counter) {
> > >  - bond->rr_tx_counter =3D alloc_percpu(u32);
> > >  - if (!bond->rr_tx_counter)
> > >  + if (BOND_MODE(bond) =3D=3D BOND_MODE_ROUNDROBIN &&
> > >  + !READ_ONCE(bond->rr_tx_counter)) {
> > >  + rr_tx_tmp =3D alloc_percpu(u32);
> > >  + if (!rr_tx_tmp)
> > >  return -ENOMEM;
> > >  + WRITE_ONCE(bond->rr_tx_counter, rr_tx_tmp);
> > >  +
> > >  }
> > >=20=20
>=20> >  /* reset slave->backup and slave->inactive */
> > >  @@ -4866,6 +4870,9 @@ static u32 bond_rr_gen_slave_id(struct bondi=
ng *bond)
> > >  struct reciprocal_value reciprocal_packets_per_slave;
> > >  int packets_per_slave =3D bond->params.packets_per_slave;
> > >=20=20
>=20> >  + if (!READ_ONCE(bond->rr_tx_counter))
> > >  + packets_per_slave =3D 0;
> > >  +
> > >  switch (packets_per_slave) {
> > >  case 0:
> > >  slave_id =3D get_random_u32();
> > >=20=20
>=20> >  -J
> > >=20=20
>=20> >=20=20
>=20> >  [0] https://lore.kernel.org/netdev/e4a2a652784ec206728eb3a929a98=
92238c61f06@linux.dev/
> > >
> >=20
>=20---
>  -Jay Vosburgh, jv@jvosburgh.net
>

