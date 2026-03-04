Return-Path: <netdev+bounces-263561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iM+YGVibp2ksigAAu9opvQ
	(envelope-from <netdev+bounces-263561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:39:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5D31F9EDF
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBF0E30EACB2
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 02:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F03320A00;
	Wed,  4 Mar 2026 02:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="pm+E0Fkv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bxwSot6m"
X-Original-To: netdev@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC1619CD0A;
	Wed,  4 Mar 2026 02:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772591926; cv=none; b=p7RoIUZvSy+I8RKWEcxJQ/6tDgbQC/fyrSyxTrlIZ9TV7rDee0XG97G+btsSEExAcufh0KzVu/iBeujujKk/IJaEXP3jBVpRTMZnr3NGr/aznxZxtgfjxwqj/rrAj7Jr6el1p/vuIn/4TA995qanNFqr5hLxyclZFvx3ANjnijs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772591926; c=relaxed/simple;
	bh=W28EGMrqfkkBU0RTmd8CR/RLpiidOAZBqWiskgfiwv8=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=TwZEkDHapYpPu+jeEPfrrAMfK+MUFZOACu4/5FWqLwEo6klh72sBD6qqFz7WPcohuwE3GDQNvZdeVaqNMwgAPNrN4MdZxH3Tner7R4JTC8Mde+EgQBms5Rbi3q2AhglT+OiZ0jq08LLbpBgC531Aj5/C6QPHy3PqY8AwDJ1QuWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=pm+E0Fkv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bxwSot6m; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.stl.internal (Postfix) with ESMTP id DDC631300522;
	Tue,  3 Mar 2026 21:38:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 03 Mar 2026 21:38:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1772591920; x=1772599120; bh=WficCb+kB7p/dgkqD9LoaM48YgbCFiXh
	MEJl3TAqrPY=; b=pm+E0FkvSd/cHEGw8Cg10ZN3Z4AeJKJUbkQ/PYppC/uvfld9
	ZiSaJ5OOstlPJ08HFSPhYcd3Gyx4dGz5x49AURPiAlqe+uaFtuGbL+A2E/lR6Hsg
	1H2KGbd7yn1VOWsEvvFi54L50zTmeIAnzFl/cnNDa8T3KZukvPydthafmiHeHi2C
	4atXkSte/W2OV6GHSM+akQOzJk4wg7foAfjpjmVaUwQmWjCro/L1PAHTsuA7/TIX
	crAFBO6xXKtlQuo0Gz+lyMrRI+GJ8BDGW7IubOLi8ox2FnF5uUgeEpqjMQvjxFoN
	GD5hzSrge3PGDpe1Q5fOfXx9tT9twUZPk8AxiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772591920; x=
	1772599120; bh=WficCb+kB7p/dgkqD9LoaM48YgbCFiXhMEJl3TAqrPY=; b=b
	xwSot6mmNdrHosajsdk9dj3e0Y660Wr82hgpsewOyg77M+iZ4/ZPsG1TVGL+ENP5
	Tplwk8HF3KaX1oQe5se7pGQOM3QfSoLO5RMCWf8KNu9JQSKqz/oftYbg/Il2t1Wz
	r8rN71OTXxDdJh9ykpFT/OhI8HmBNqzE3DFkZAcQ7oueOXyugmJAWW0ZJavDNA7c
	oebML0tGpPKuxOXCAkLHKS2inMRIdBtZVVsG5cYK7s52w9LpghgfYBMra/84k6vX
	zGtQNPgc7ViFdAaMNbAHV9JKD8QDDOuOb8p3sKbD100ZGHE3t4d9rnM87U3g+ZU3
	F4/n4+wwTaWVFCuiYJ4PQ==
X-ME-Sender: <xms:L5unaSWtEJFjIlY34muwupe592BcE2QK_B6KePrMl8439hSJw8UL8A>
    <xme:L5unacOxZMGBL3pldftk8B6iVNL0Fdb7B4G0pwqnePRx9_r81Q-bOacgNlhK_-9Z7
    cVkvV4fI0E61_YpY-8ywVvwjuqZXAA_KAFv79W_vvE-NeMBDZ1wEXA>
X-ME-Received: <xmr:L5unadxzkZgmDePP6ObYG52RR2fdOAUAa7Z0y4OT5y9bRRmSJvNMZ6UP6k5-XvluLKCF0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedvvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertdejnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepgeefgffhgffhhfejgfevkefhueekvefftefhgfdtuddtfeffueehleegleeiuefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvse
    hjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopeeffedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtph
    htthhopehsughfsehfohhmihgthhgvvhdrmhgvpdhrtghpthhtohepvgguugihiiekjees
    ghhmrghilhdrtghomhdprhgtphhtthhopehjohgrmhgrkhhisehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghp
    thhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopegvughumh
    griigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhgrohhluhhosehgohhoghhl
    vgdrtghomhdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvth
X-ME-Proxy: <xmx:L5unaRjJ_QxF9I2ON8mDTN5PMAmVkrzrPKqTlCuhjBvNubFNG7rLkQ>
    <xmx:L5unaUTnwcbXI1JJ98fUh7gGcR0m1N5bFArs1Kywgo1lIb7BU1l_-g>
    <xmx:L5unaeMQluRl0m-mXtS7tToTtRJ6lsyT4mSfQ2fcaJxecS78UyJXsQ>
    <xmx:L5unaZFtM53nnTrqNut8eU3qkY-b9faTb44wMf_SQgdQtL-X1ihhzg>
    <xmx:MJunaWxz0dL5g6cP1W--_JcUY8bBe31AqdCl3ek34cenrjc1opgwgohg>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 21:38:38 -0500 (EST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id E99489FD44; Tue,  3 Mar 2026 18:38:37 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id E58759FCB1;
	Tue,  3 Mar 2026 18:38:37 -0800 (PST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
cc: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
    netdev@vger.kernel.org, jiayuna.chen@linux.dev,
    jiayuna.chen@shopee.com, "Jiayuan Chen" <jiayuan.chen@shopee.com>,
    syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
    "Andrew Lunn" <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    "Eric Dumazet" <edumazet@google.com>,
    "Jakub Kicinski" <kuba@kernel.org>,
    "Paolo Abeni" <pabeni@redhat.com>,
    "Alexei Starovoitov" <ast@kernel.org>,
    "Daniel Borkmann" <daniel@iogearbox.net>,
    "Jesper Dangaard Brouer" <hawk@kernel.org>,
    "John Fastabend" <john.fastabend@gmail.com>,
    "Stanislav Fomichev" <sdf@fomichev.me>,
    "Andrii Nakryiko" <andrii@kernel.org>,
    "Eduard Zingerman" <eddyz87@gmail.com>,
    "Martin KaFai Lau" <martin.lau@linux.dev>,
    "Song Liu" <song@kernel.org>,
    "Yonghong Song" <yonghong.song@linux.dev>,
    "KP Singh" <kpsingh@kernel.org>, "Hao Luo" <haoluo@google.com>,
    "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>,
    "Clark Williams" <clrkwllms@kernel.org>,
    "Steven Rostedt" <rostedt@goodmis.org>,
    "Jussi Maki" <joamaki@gmail.com>, linux-kernel@vger.kernel.org,
    bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
    linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v3 1/2] bonding: fix null-ptr-deref in bond_rr_gen_slave_id()
In-reply-to: <e4a2a652784ec206728eb3a929a9892238c61f06@linux.dev>
References: <20260228021918.141002-1-jiayuan.chen@linux.dev> <20260228021918.141002-2-jiayuan.chen@linux.dev> <999129.1772247707@famine> <08041bd78c06981b18b3de90a95e0c951bf1623c@linux.dev> <20260302081021.MiQQ_LQr@linutronix.de> <e4a2a652784ec206728eb3a929a9892238c61f06@linux.dev>
Comments: In-reply-to "Jiayuan Chen" <jiayuan.chen@linux.dev>
   message dated "Mon, 02 Mar 2026 10:15:22 +0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Mar 2026 18:38:37 -0800
Message-ID: <1262700.1772591917@famine>
X-Rspamd-Queue-Id: AE5D31F9EDF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263561-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,vger.kernel.org,linux.dev,shopee.com,syzkaller.appspotmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,goodmis.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,jvosburgh.net:dkim,jvosburgh.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,linutronix.de:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,80e046b8da2820b6ba73];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

>March 2, 2026 at 16:10, "Sebastian Andrzej Siewior" <bigeasy@linutronix.de=
 mailto:bigeasy@linutronix.de?to=3D%22Sebastian%20Andrzej%20Siewior%22%20%3=
Cbigeasy%40linutronix.de%3E > wrote:
>
>
>>=20
>> On 2026-02-28 03:36:24 [+0000], Jiayuan Chen wrote:
>>=20
>> >=20
>> > My only concern is that this will waste a percpu u32 per bond
>> >  device for the majority of bonding use cases (which use modes other t=
han
>> >  balance-rr), which could be a few hundred bytes on a large machine.
>> >=20=20
>> >  Does everything work reliably if the rr_tx_counter allocation
>> >  happens conditionally on mode =3D=3D BOND_MODE_ROUNDROBIN in bond_set=
up, as
>> >  well as in bond_option_mode_set?
>> >=20
>> =E2=80=A6
>>=20
>> >=20
>> > An alternative would be to allocate conditionally in bond_init() (sinc=
e the default mode is round-robin)
>> >  and manage allocation/deallocation in bond_option_mode_set() when the=
 mode changes.
>> >=20
>> This sounds reasonable.
>>=20
>> >=20
>> > This is a trade-off between the added complexity of conditional alloc/=
free across multiple code
>> >  paths and saving a per-CPU u32 for non-round-robin bonds.
>> >=20=20
>> >  For the per-CPU u32 overhead, it's only 4 extra bytes per CPU per bon=
d device =E2=80=94 and machines with
>> >  that many CPUs tend to have plenty of memory to match.
>> >=20
>> 4 bytes is the minimum allocation for per-CPU memory. The memory is
>> already "there" it is just not assigned. So for the 4 byte allocation it
>> is needed to find a single area (the smallest allocation size).
>> In case there no free block, a new block will be allocated and mapped
>> for each CPU which the part that costs memory.
>> That said, we should not waste memory but it is not _that_ expensive
>> either for a bond device. Things change if here are hundreds of devices.
>
>
>Hi Jay, Sebastian,
>
>Sorry, the conditional alloc/free approach in bond_option_mode_set()
>I suggested earlier doesn't work well on closer inspection.
>
>Since bond_option_mode_set() requires the bond to be down, and as this
>bug shows, the XDP redirect path can still reach a downed bond device,
>we need to carefully order the operations:
>
>when switching to RR, alloc rr_tx_counter before setting mode;
>when switching away, set mode before freeing rr_tx_counter.
>
>Strictly speaking, this also requires smp_wmb()/smp_rmb() pairs to
>guarantee the ordering is visible to other CPUs =E2=80=94 the write side in
>bond_option_mode_set() and the read side in the XDP path.
>
>In practice the race window is very small and unlikely to trigger, but
>leaving out the barriers would look incorrect, and adding them to the
>XDP hot path feels wrong for saving only 4 bytes per CPU per bond device.

	Ok, fair enough.

	Can you repost the last version, and please note in the commit
log that we're deliberately allowing the memory to be allocated but
unused for most cases for the above reasons?  I'm also thinking that a
short comment in the code along the lines of "unused in most modes but
needed for XDP" is worthwhile.

	Assuming Jakub, Eric, and Paolo don't object to the patch, I
think we should have it documented that we're doing this on purpose so
nobody tries to "fix" it later.

	-J


>smp_wmb()/smp_rmb() (no test):=20
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_ma=
in.c
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -4279,12 +4279,6 @@ static int bond_open(struct net_device *bond_dev)
>	struct list_head *iter;
>	struct slave *slave;
>
>-     if (BOND_MODE(bond) =3D=3D BOND_MODE_ROUNDROBIN && !bond->rr_tx_coun=
ter) {
>-             bond->rr_tx_counter =3D alloc_percpu(u32);
>-             if (!bond->rr_tx_counter)
>-                     return -ENOMEM;
>-     }
>-
>	/* reset slave->backup and slave->inactive */
>	if (bond_has_slaves(bond)) {
>			bond_for_each_slave(bond, slave, iter) {
>@@ -5532,6 +5526,8 @@ bond_xdp_get_xmit_slave(struct net_device *bond_dev,=
 struct xdp_buff *xdp)
>
>	switch (BOND_MODE(bond)) {
>	case BOND_MODE_ROUNDROBIN:
>+             /* Pairs with smp_wmb() in bond_option_mode_set() */
>+             smp_rmb();
>			slave =3D bond_xdp_xmit_roundrobin_slave_get(bond, xdp);
>			break;
>
>@@ -6411,6 +6407,14 @@ static int bond_init(struct net_device *bond_dev)
>	if (!bond->wq)
>			return -ENOMEM;
>
>+     /* Default mode is round-robin, allocate rr_tx_counter for it.
>+      * For mode changes, bond_option_mode_set() manages the lifecycle.
>+      */
>+     bond->rr_tx_counter =3D alloc_percpu(u32);
>+     if (!bond->rr_tx_counter) {
>+             destroy_workqueue(bond->wq);
>+             return -ENOMEM;
>+     }
>+
>	bond->notifier_ctx =3D false;
>
>diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond=
_options.c
>--- a/drivers/net/bonding/bond_options.c
>+++ b/drivers/net/bonding/bond_options.c
>@@ -918,7 +918,27 @@ static int bond_option_mode_set(struct bonding *bond,
>	/* don't cache arp_validate between modes */
>	bond->params.arp_validate =3D BOND_ARP_VALIDATE_NONE;
>-     bond->params.mode =3D newval->value;
>+
>+     if (newval->value =3D=3D BOND_MODE_ROUNDROBIN) {
>+             /* Switching to round-robin: allocate before setting mode,
>+              * so XDP path seeing BOND_MODE_ROUNDROBIN always finds
>+              * rr_tx_counter allocated.
>+              */
>+             if (!bond->rr_tx_counter) {
>+                     bond->rr_tx_counter =3D alloc_percpu(u32);
>+                     if (!bond->rr_tx_counter)
>+                             return -ENOMEM;
>+             }
>+             /* Pairs with smp_rmb() in bond_xdp_get_xmit_slave() */
>+             smp_wmb();
>+             bond->params.mode =3D newval->value;
>+     } else {
>+             /* Switching away: set mode first so XDP no longer
>+              * enters RR branch before we free rr_tx_counter.
>+              */
>+             bond->params.mode =3D newval->value;
>+             /* Pairs with smp_rmb() in bond_xdp_get_xmit_slave() */
>+             smp_wmb();
>+             free_percpu(bond->rr_tx_counter);
>+             bond->rr_tx_counter =3D NULL;
>+     }
>
>Thanks,
>Jiayuan
>
>
>> >=20
>> > Thanks
>> >=20=20
>> >  -J
>> >=20
>> Sebastian
>>

---
	-Jay Vosburgh, jv@jvosburgh.net

