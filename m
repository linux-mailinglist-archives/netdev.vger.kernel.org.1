Return-Path: <netdev+bounces-264543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKVoLtnvqWlGIQEAu9opvQ
	(envelope-from <netdev+bounces-264543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:04:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B462185F9
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 562A630387CF
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 21:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CA834B1A1;
	Thu,  5 Mar 2026 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="GRZjokw8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tko4c20R"
X-Original-To: netdev@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A40534BA4B;
	Thu,  5 Mar 2026 21:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772744640; cv=none; b=kZDDHZBBkllozZB2c7jILU4R7QxE9ZkMiQ2XYOIAmNaG7K1IUTuEVQTBED4jcT1GyDuhgSZfhvUC+1+CFJBicdkjGrpEq8WmgFdYkV9yMvreE0dGaNOXYUUmPctMJXDw1CP7cDnLsJSQQRJXyBJbvIrRo/eCksHSkdLfpSXZWpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772744640; c=relaxed/simple;
	bh=ajba8rpFeSFjqa5KG8RXrm1I4HwjDwK0ae4x18tOu10=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=PHZPfITd3hZfEDk3vl7PoQulq+vRnaraMrPr/tazv8s4Bx6aoTnVlbWUUCgGcablsJRIOfiNzdTBqoPDtCIb9gim7G3ltw/u7bny9jQ5XPDnEx1+4563G/bmUvExs1caMFdGIAAdNU7gMtyIbtjVSIllLwIRgFhMS/GQzOSvaC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=GRZjokw8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tko4c20R; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 252C91300CC5;
	Thu,  5 Mar 2026 16:03:54 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 05 Mar 2026 16:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1772744633; x=1772751833; bh=4acJxYys885P1kZExhCla
	G7wmjnaUlLNMpGvlOc6Dh4=; b=GRZjokw84k3XuIZ33jvcwb3AaqZ0BvmceJU4W
	VvMm+wCNPqjtIUqX3XPxtMGHQB0SPfZuztaw5IXDKlspPCj783goEmDjkJG+yWe3
	laX9cFYZG3/vYJVQKD19wNROnI8eFUcSOZmEkcbw6VdNbhBU/cCm1cTjtQGCP/jU
	Qg5i+suqIBfVPKTvJfhMlPdj68TtJqoeWBWCyXqXdzhCO/f5DuUx5uxRtJ5I1YPr
	OJYg6V5ZuipREcyekfdPvMrlCKp/XuJCdODbCLzu3WYr+TaD3PY7vLE8txnnPBCH
	VxY3KiQ9bVbvKn6myU6je9Dz7qYJ+ja9ssDStl0XUrwPoyU5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772744633; x=1772751833; bh=4acJxYys885P1kZExhClaG7wmjnaUlLNMpG
	vlOc6Dh4=; b=tko4c20R9D/tnhWb5kg+OcfhEJBH4zEgRHJJM0DTmdQ5q065Wrt
	l3b7BQfqWpKhusRh9rqmkcqKZiTefB0B5ed8fgE83kt0iVGTaAWK0t5S+2/GENmw
	JzPO6ZJkqjbUaehtSzApZtssQeOl+fjmCyWoaoV4YpEK1kRotwNYnXXFBreHPMZ0
	R6dBlZyuOGNxO7oO7PCBBZiMRTkcitSwNv9BuBUZ7IdFYshz6B9CtMYHIbUerDnJ
	ax+6HBGE2E1Ydy4/Q5/eszqp3Mzfci12x2O1FMYXcUC4XlCdfvRFaBHSNlxSfDGI
	uQ2GY4Iha6KJF5auvDMjSpjPBUNTeByQrBg==
X-ME-Sender: <xms:uO-pafKTTkLJfcNuaQfy8ByO5VQWHhLuMuzjNnHl8VzF2Uk5C-IBhg>
    <xme:uO-paVcOcrB8KeeUr0uzwsjeqUXktgJ0gTXq0IeHj1UPccYR56gti92LvCjSHsLxd
    YUG-fg_4fq-n-vMeHZqlr5HneL2Yw0iszS3Edknd4_-WLKn2ac1_e0>
X-ME-Received: <xmr:uO-paWaieWA2ZRkvj2UV-JmSro39q73GJBSaGho2p3AiBR8zUHkC3xn4TxSR9zLpqRq-fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepueffvedvvdefudejfeeuudfgtdfgudettdevfeeileffhffghfdtjeekhfeitdek
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvthdpnhgs
    pghrtghpthhtohepfedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrgiioh
    hrsegslhgrtghkfigrlhhlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhl
    ohhfthdrnhgvthdprhgtphhtthhopehsughfsehfohhmihgthhgvvhdrmhgvpdhrtghpth
    htohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehjohgrmhgrkhhi
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmh
    grihhlrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdp
    rhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephh
    grohhluhhosehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:uO-paVXf5v6uE9WfSbjKDRt83GOqG6svuZeRN-hHIfqPv9Qmkn18Jw>
    <xmx:uO-paUCS4CoEL15ki9YSBwTMTCBC7KZ01wg6taxlNR5P1CP8-DG_iQ>
    <xmx:uO-paUB104dISLASCy54teg5wRUvgXHZatWVq8h41ZHgvQqJHy444g>
    <xmx:uO-paTqC1XEEWGelf3A7DfC1PsbJ6RFi8VBj-BR6-VZKODlqnvBXyQ>
    <xmx:ue-paVLe7-bpVBQJWIq6C0IqHFq-HPTy1OYFo3i1X4euHX9w38FK6a9k>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 16:03:52 -0500 (EST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 4B3549FCB4; Thu,  5 Mar 2026 13:03:51 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 47C419FC39;
	Thu,  5 Mar 2026 13:03:51 -0800 (PST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Nikolay Aleksandrov <razor@blackwall.org>
cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
    jiayuan.chen@shopee.com,
    syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
    Daniel Borkmann <daniel@iogearbox.net>,
    Jesper Dangaard Brouer <hawk@kernel.org>,
    John Fastabend <john.fastabend@gmail.com>,
    Stanislav Fomichev <sdf@fomichev.me>,
    Andrii Nakryiko <andrii@kernel.org>,
    Martin KaFai Lau <martin.lau@linux.dev>,
    Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
    Yonghong Song <yonghong.song@linux.dev>,
    KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
    Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
    Clark Williams <clrkwllms@kernel.org>,
    Steven Rostedt <rostedt@goodmis.org>, Jussi Maki <joamaki@gmail.com>,
    linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
    linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v4 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
In-reply-to: <aahsuPt7cY8LxETN@penguin>
References: <20260304074301.35482-1-jiayuan.chen@linux.dev>
 <20260304074301.35482-2-jiayuan.chen@linux.dev> <aahWymAi_CtRG0gJ@penguin>
 <1293120.1772645248@famine> <aahsuPt7cY8LxETN@penguin>
Comments: In-reply-to Nikolay Aleksandrov <razor@blackwall.org>
   message dated "Wed, 04 Mar 2026 19:32:40 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1356527.1772744631.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Mar 2026 13:03:51 -0800
Message-ID: <1356528.1772744631@famine>
X-Rspamd-Queue-Id: 78B462185F9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264543-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,vger.kernel.org,shopee.com,syzkaller.appspotmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linutronix.de,goodmis.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,blackwall.org:email,jvosburgh.net:dkim,jvosburgh.net:email,messagingengine.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,80e046b8da2820b6ba73];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Nikolay Aleksandrov <razor@blackwall.org> wrote:

>On Wed, Mar 04, 2026 at 09:27:28AM -0800, Jay Vosburgh wrote:
>> Nikolay Aleksandrov <razor@blackwall.org> wrote:
>> =

>> >On Wed, Mar 04, 2026 at 03:42:57PM +0800, Jiayuan Chen wrote:
>> >> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>> >> =

>> >> bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NU=
LL
>> >> check. rr_tx_counter is a per-CPU counter only allocated in bond_ope=
n()
>> >> when the bond mode is round-robin. If the bond device was never brou=
ght
>> >> up, rr_tx_counter remains NULL, causing a null-ptr-deref.
>> >> =

>> >> The XDP redirect path can reach this code even when the bond is not =
up:
>> >> bpf_master_redirect_enabled_key is a global static key, so when any =
bond
>> >> device has native XDP attached, the XDP_TX -> xdp_master_redirect()
>> >> interception is enabled for all bond slaves system-wide. This allows=
 the
>> >> path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
>> >> bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
>> >> reached on a bond that was never opened.
>> >> =

>> >> Fix this by allocating rr_tx_counter unconditionally in bond_init()
>> >> (ndo_init), which is called by register_netdevice() and covers both
>> >> device creation paths (bond_create() and bond_newlink()). This also
>> >> handles the case where bond mode is changed to round-robin after dev=
ice
>> >> creation. The conditional allocation in bond_open() is removed. Sinc=
e
>> >> bond_destructor() already unconditionally calls
>> >> free_percpu(bond->rr_tx_counter), the lifecycle is clean: allocate a=
t
>> >> ndo_init, free at destructor.
>> >> =

>> >> Note: rr_tx_counter is only used by round-robin mode, so this
>> >> deliberately allocates a per-cpu u32 that goes unused for other mode=
s.
>> >> Conditional allocation (e.g., in bond_option_mode_set) was considere=
d
>> >> but rejected: the XDP path can race with mode changes on a downed bo=
nd,
>> >> and adding memory barriers to the XDP hot path is not justified for
>> >> saving 4 bytes per CPU.
>> >> =

>> >> Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to =
slave device")
>> >> Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
>> >> Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GA=
E@google.com/T/
>> >> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
>> >> ---
>> >>  drivers/net/bonding/bond_main.c | 19 +++++++++++++------
>> >>  1 file changed, 13 insertions(+), 6 deletions(-)
>> >> =

>> >
>> >IMO it's not worth it to waste memory in all modes, for an unpopular m=
ode.
>> >I think it'd be better to add a null check in bond_rr_gen_slave_id(),
>> >READ/WRITE_ONCE() should be enough since it is allocated only once, an=
d
>> >freed when the xmit code cannot be reachable anymore (otherwise we'd h=
ave
>> >more bugs now). The branch will be successfully predicted practically =
always,
>> >and you can also mark the ptr being null as unlikely. That way only RR=
 takes
>> >a very minimal hit, if any.
>> =

>> 	Is what you're suggesting different from Jiayuan's proposal[0],
>> in the sense of needing barriers in the XDP hot path to insure ordering=
?
>> =

>> 	If I understand correctly, your suggestion is something like
>> (totally untested):
>> =

>
>Basically yes, that is what I'm proposing + an unlikely() around that
>null check since it is really unlikely and will be always predicted
>correctly, this way it's only for RR mode.

	Jiayuan,

	Do you agree that the patch below (including Nikolay's
suggestion to add "unlikely") resolves the original issue without memory
waste, and without introducing performance issues (barriers) into the
XDP path?

	-J


>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond=
_main.c
>> index eb27cacc26d7..ac2a4fc0aad0 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -4273,13 +4273,17 @@ void bond_work_cancel_all(struct bonding *bond)
>>  static int bond_open(struct net_device *bond_dev)
>>  {
>>  	struct bonding *bond =3D netdev_priv(bond_dev);
>> +	u32 __percpu *rr_tx_tmp;
>>  	struct list_head *iter;
>>  	struct slave *slave;
>>  =

>> -	if (BOND_MODE(bond) =3D=3D BOND_MODE_ROUNDROBIN && !bond->rr_tx_count=
er) {
>> -		bond->rr_tx_counter =3D alloc_percpu(u32);
>> -		if (!bond->rr_tx_counter)
>> +	if (BOND_MODE(bond) =3D=3D BOND_MODE_ROUNDROBIN &&
>> +	    !READ_ONCE(bond->rr_tx_counter)) {
>> +		rr_tx_tmp =3D alloc_percpu(u32);
>> +		if (!rr_tx_tmp)
>>  			return -ENOMEM;
>> +		WRITE_ONCE(bond->rr_tx_counter, rr_tx_tmp);
>> +
>>  	}
>>  =

>>  	/* reset slave->backup and slave->inactive */
>> @@ -4866,6 +4870,9 @@ static u32 bond_rr_gen_slave_id(struct bonding *b=
ond)
>>  	struct reciprocal_value reciprocal_packets_per_slave;
>>  	int packets_per_slave =3D bond->params.packets_per_slave;
>>  =

>> +	if (!READ_ONCE(bond->rr_tx_counter))
>> +		packets_per_slave =3D 0;
>> +
>>  	switch (packets_per_slave) {
>>  	case 0:
>>  		slave_id =3D get_random_u32();
>> =

>> 	-J
>> =

>> =

>> [0] https://lore.kernel.org/netdev/e4a2a652784ec206728eb3a929a9892238c6=
1f06@linux.dev/

---
	-Jay Vosburgh, jv@jvosburgh.net

