Return-Path: <netdev+bounces-258683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id y7cdCz6dj2nKRwEAu9opvQ
	(envelope-from <netdev+bounces-258683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 22:53:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8A3139AE3
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 22:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 826A13004C58
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 21:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4632BE63F;
	Fri, 13 Feb 2026 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="t6i1XhaM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SJHw8sZu"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8225A275AE1
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771019577; cv=none; b=UfJHLXGy4ImKpcIMvov9WsIjfm/6P9RFeK3/q3zU/jGs/xg39h9aBxlsikzWYzyEYAAG4c/oGbWS/H0COGIfrf0AfBF0mHUcl/Bt5iw2rpkcq+HWfkdjApVUbRn0WpU0K2FoxGOq+sYk+Kf5QsgygkyZJdmcVKRP47y/XRSAGY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771019577; c=relaxed/simple;
	bh=Gp2Pkd6dBcAD9gExMhUe1TlcdLCXbVfQ+Qhg4vA2cZg=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=tqvRTN0fva/ryNAd58GLcEepAz71AlPlO7uo+Qo8xGVAYhNVIGDcIQDg3BMjct8EoFWCzQ+hrVqhtO0LWo4u442I2mHTuJG5bceR0jGWF9K8/1XtU/wXADCBNrTEdfX5+WmNEDizc4H12KQf6ZGJtnsj9OG1uheW4Hsxptp8MUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=t6i1XhaM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SJHw8sZu; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5C6BA7A00E6;
	Fri, 13 Feb 2026 16:52:54 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 13 Feb 2026 16:52:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1771019574; x=1771105974; bh=7Ou3ogiwz3ERK34Cls8MU
	NR5fugGTwdYYsDzY79HHYw=; b=t6i1XhaMPys68gv8fFIrSKasoz+B4i89SB0Ng
	pr9ULipOh5LD9KWsmRA9Sz6idvVCk8/2pqEDx73D6bC6/VtduWmYlyXAr1clejvL
	zT2xTq6Y8mo1d2TH2Bqf8T6YToBnho3OFql1vWWxp/ZUx2MgDUnr11B9bBX/aIdo
	STzhnSj0ZdKzUJ/j8FJH7BFjI/qESD42pWwu1mwtJ837tIqjrAqCptbJNSxXRgz0
	oLhlnF6gD5VXFjoCqmwMtDSSpnZMv44+iqXCoJWtncQWsShsna1PhJZ46NG26nq7
	Xuh38XPBj81QFEPFgEEMCP/CCUl7OUZaCre0DDfY9ORFh17nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771019574; x=1771105974; bh=7Ou3ogiwz3ERK34Cls8MUNR5fugGTwdYYsD
	zY79HHYw=; b=SJHw8sZu7V45O/m3XLOQkqMuFnyymNpVtPFbOFPuIzv3YbnfE9W
	0u2Q9tu3vXDUE99/uEHvxrbap//0ZH6bH30QT+8Bvj67MKbZTUlkFFKAokAWLcD+
	m6prtj5u76WpplfqXlBjoBGs5oWWFK1vyKnJshsZTfXv4GW6NNNawNKpO0ipbTdW
	UiQB3i75BWAErO+Wh+UL7V04S8CXeZjpkucxaqEfoQDpdQSuCleiwPyXWAN1X2QF
	gySG1aU23IiDxQMUMhix3Xpa/bXLDp7id5ZMXhVDMw40KPXus9Z4xs5NMrAyDwQz
	7Tgs56fSdzHPjANzFyCym+IgSHzHV2hQ5hw==
X-ME-Sender: <xms:NZ2PacQJWBPxycbwrNPcJD0SWDJuzkOnpnZNPaMFZjWUkmJnBFzHAw>
    <xme:NZ2PacUgpoCKmI_1gOXdTZXSpHnd4mqzQ79CSaf8i8wnmiAIv1vrYIQTKUl7UvWBY
    j_p3TkCSnO-JHUAN6Hx80A3-2kM9kFYDNeucEbKFcE_3CmXW94pDeM>
X-ME-Received: <xmr:NZ2PadfG5ppsAchR8LUaZR8F5mdudO5qvaq91z8rCbKZOQxF5I6Oae_G1bVjM7CIJGqrUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdelfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepieefvdelfeeljeevtefhfeeiudeuiedvfeeiveelffduvdevfedtheffffetfeff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvse
    hjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpth
    htoheplhhiuhhhrghnghgsihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhm
    rgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgt
    phhtthhopehlihgrlhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehprggsvghnih
    esrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhgsohhhrggtsehsuhhsvgdrtgiipdhr
    tghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NZ2PaQKJqBh-oYHvQBiTCe2YER9FvukvaV2Oic-lM7fMovXkYI681Q>
    <xmx:NZ2PaaxRMnY47Y27NDPY1qjvPBuhsKEJ0xSYo5crIEdw7eawVMWF-Q>
    <xmx:NZ2PaWsE_ww3b8uD9x0IaxOkE-hMxeRvBxfH0PV2deSi6PSvH-guMA>
    <xmx:NZ2PadD_N0yO6TFq44SjfhpwG5BtS7HYKdI6LlnSqKNLs-eJQUuJJw>
    <xmx:Np2PadKn0MZWTvzkRR_hoUICe2gpq202y0vVLORPs3TR4sepBVXY27UF>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 16:52:53 -0500 (EST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 33D1C9FD44; Fri, 13 Feb 2026 13:52:52 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 32E2C9FC6F;
	Fri, 13 Feb 2026 13:52:52 -0800 (PST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Jiri Bohac <jbohac@suse.cz>,
    Liang Li <liali@redhat.com>
Subject: Re: [PATCH net] bonding: alb: fix UAF in rlb_arp_recv during bond
 up/down
In-reply-to: <20260213095424.84636-1-liuhangbin@gmail.com>
References: <20260213095424.84636-1-liuhangbin@gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Fri, 13 Feb 2026 09:54:24 +0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <418607.1771019572.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Feb 2026 13:52:52 -0800
Message-ID: <418608.1771019572@famine>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258683-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 0F8A3139AE3
X-Rspamd-Action: no action

Hangbin Liu <liuhangbin@gmail.com> wrote:

>The ALB RX path may access rx_hashtbl concurrently with bond
>teardown. During rapid bond up/down cycles, rlb_deinitialize()
>frees rx_hashtbl while RX handlers are still running, leading
>to a use-after-free detected by KASAN.
>
>[  214.174138] Oops: general protection fault, probably for non-canonical=
 address 0xdffffc000000001d: 0000 [#1] SMP KASAN PTI
>[  214.186478] KASAN: null-ptr-deref in range [0x00000000000000e8-0x00000=
000000000ef]
>[  214.194933] CPU: 30 UID: 0 PID: 2375 Comm: ping Kdump: loaded Not tain=
ted 6.19.0-rc8+ #2 PREEMPT(voluntary)
>[  214.205907] Hardware name: Dell Inc. PowerEdge R730/0WCJNT, BIOS 2.14.=
0 01/14/2022
>[  214.214357] RIP: 0010:rlb_arp_recv+0x505/0xab0 [bonding]
>[  214.220320] Code: 0f 85 2b 05 00 00 48 b8 00 00 00 00 00 fc ff df 40 0=
f b6 ed 48 c1 e5 06 49 03 ad 78 01 00 00 48 8d 7d 28 48 89 fa 48 c1 ea 03 =
<0f> b6
> 04 02 84 c0 74 06 0f 8e 12 05 00 00 80 7d 28 00 0f 84 8c 00
>[  214.241280] RSP: 0018:ffffc900073d8870 EFLAGS: 00010206
>[  214.247116] RAX: dffffc0000000000 RBX: ffff888168556822 RCX: ffff88816=
855681e
>[  214.255082] RDX: 000000000000001d RSI: dffffc0000000000 RDI: 000000000=
00000e8
>[  214.263048] RBP: 00000000000000c0 R08: 0000000000000002 R09: ffffed111=
92021c8
>[  214.271013] R10: ffff8888c9010e43 R11: 0000000000000001 R12: 1ffff9200=
0e7b119
>[  214.278978] R13: ffff8888c9010e00 R14: ffff888168556822 R15: ffff88816=
8556810
>[  214.286943] FS:  00007f85d2d9cb80(0000) GS:ffff88886ccb3000(0000) knlG=
S:0000000000000000
>[  214.295966] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[  214.302380] CR2: 00007f0d047b5e34 CR3: 00000008a1c2e002 CR4: 000000000=
01726f0
>[  214.310347] Call Trace:
>[  214.313070]  <IRQ>
>[  214.315318]  ? __pfx_rlb_arp_recv+0x10/0x10 [bonding]                 =
                                                                          =
       [  214.320975]  bond_handle_frame+0x166/0xb60 [bonding]
>[  214.326537]  ? __pfx_bond_handle_frame+0x10/0x10 [bonding]
>[  214.332680]  __netif_receive_skb_core.constprop.0+0x576/0x2710
>[  214.339199]  ? __pfx_arp_process+0x10/0x10
>[  214.343775]  ? sched_balance_find_src_group+0x98/0x630
>[  214.349513]  ? __pfx___netif_receive_skb_core.constprop.0+0x10/0x10
>[  214.356513]  ? arp_rcv+0x307/0x690
>[  214.360311]  ? __pfx_arp_rcv+0x10/0x10
>[  214.364499]  ? __lock_acquire+0x58c/0xbd0
>[  214.368975]  __netif_receive_skb_one_core+0xae/0x1b0
>[  214.374518]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
>[  214.380743]  ? lock_acquire+0x10b/0x140
>[  214.385026]  process_backlog+0x3f1/0x13a0
>[  214.389502]  ? process_backlog+0x3aa/0x13a0
>[  214.394174]  __napi_poll.constprop.0+0x9f/0x370
>[  214.399233]  net_rx_action+0x8c1/0xe60
>[  214.403423]  ? __pfx_net_rx_action+0x10/0x10
>[  214.408193]  ? lock_acquire.part.0+0xbd/0x260
>[  214.413058]  ? sched_clock_cpu+0x6c/0x540
>[  214.417540]  ? mark_held_locks+0x40/0x70
>[  214.421920]  handle_softirqs+0x1fd/0x860
>[  214.426302]  ? __pfx_handle_softirqs+0x10/0x10
>[  214.431264]  ? __neigh_event_send+0x2d6/0xf50
>[  214.436131]  do_softirq+0xb1/0xf0
>[  214.439830]  </IRQ>
>
>The issue is reproducible by looping ip link set bond0 up/down,
>where rlb_arp_recv() can race with rlb_deinitialize() and dereference
>a freed rx_hashtbl entry.
>
>Fix this by setting recv_probe to NULL before calling
>bond_alb_deinitialize(), and then calling synchronize_net() to wait
>for any concurrent RX processing to finish.

	I think the change looks good, however, to my reading the
sentence above describes the order of events as 1) recv_probe =3D NULL, 2)
bond_alb_deinitialize(), then 3) synchroninze_net(), whereas the changed
code below is 1, 3, then 2.

	The code order is correct, but I think the commit description
should match the code.

	-J

>This ensures that no RX handler can access rx_hashtbl after it is
>freed, while preserving the existing locking semantics.
>
>Reported-by: Liang Li <liali@redhat.com>
>Fixes: e53665c6eaa6 ("bonding: delete migrated IP addresses from the rlb =
hash table")
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>---
> drivers/net/bonding/bond_main.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 47f13d86cb7e..8e1057a2a061 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -4314,9 +4314,13 @@ static int bond_close(struct net_device *bond_dev)
> =

> 	bond_work_cancel_all(bond);
> 	bond->send_peer_notif =3D 0;
>+	bond->recv_probe =3D NULL;
>+
>+	/* Wait for any in-flight RX handlers */
>+	synchronize_net();
>+
> 	if (bond_is_lb(bond))
> 		bond_alb_deinitialize(bond);
>-	bond->recv_probe =3D NULL;
> =

> 	if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD &&
> 	    bond->params.broadcast_neighbor)
>-- =

>2.50.1
>

---
	-Jay Vosburgh, jv@jvosburgh.net

