Return-Path: <netdev+bounces-262056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKZ/Aslaomko2QQAu9opvQ
	(envelope-from <netdev+bounces-262056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:02:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F0C1C00E2
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CDC2301E97B
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA29A2773DA;
	Sat, 28 Feb 2026 03:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="LXkaTa1b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SgKrfnvi"
X-Original-To: netdev@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E5322301;
	Sat, 28 Feb 2026 03:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772247713; cv=none; b=aJpL1++UP7yBYQd4qtsQOSHtcn7Q4TZ+Q6jaK2Bnv8cCUywjuf6kSh6hIxIMUFcBOfxUv23l8lIkegLBAfR3cuU09NEQkdShgAlvmTP33SBSuqMA339LNmEJ/G3+hoZyrMhYV8gtuePk3XcvFRg5ZpDdzqBmi5EhR4BAKuFASz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772247713; c=relaxed/simple;
	bh=892Drk9VO1sJ+BVcVRDSWIRnfiZ+k/eOSnKycFUUDBw=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=JBjnsdbANkhl+WfxSkqJPdfxkc2RKeNLg139Et48y9IRD3MM+awC5OxVpJpdjSESZm2gEb6MhHHvhzinzqgBvZkAfnUKlwVoQ1YxS8Q16wm9s1Evfk0X+xA1STbJZhfcB6ISWsq62AxWha7C/Fi7jxRqyRDOteN29Q8hfBTljMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=LXkaTa1b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SgKrfnvi; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id C90571380BF4;
	Fri, 27 Feb 2026 22:01:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 27 Feb 2026 22:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1772247709; x=1772254909; bh=qQeAuQCGUpIcxGGvnu5Nf
	O4U8+4EUinMWcXuxgk73x8=; b=LXkaTa1b78zc7lYs5sFD9LR9VRkkIKA0tzZDX
	XMCvP4yRJoMl+k04yjAz6F3zvO7CJXnT8cRqPnjvhHPDEsY6YoUE+pEmpwFdIWLE
	YBsoGps4QwlXk7zxtDrEQ0LXzZidUE8WODbjYIlwVA8rxUE/Yrn/0jlmDr5xTSw/
	jBwTD3gTg6d3rMvNdNs9y+G9EHhk3p+bx8DYLnreSnmuIvIXRo+wLNaRptK7o01c
	lZ1rb2ueZ/T5LyunpXRRwq1Y3VhEww5DWC1SP9+SGgMXJEIy94/ddu1VzcDCw9oV
	yVT1VHUmvaouZ3W/+BT21hxi9+HT88DjYfDlWF6RILEI1r7lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772247709; x=1772254909; bh=qQeAuQCGUpIcxGGvnu5NfO4U8+4EUinMWcX
	uxgk73x8=; b=SgKrfnvinJ8gsFA4oHsBLJx0OOKjwnY6VPBE2Ocmu7xwCH2B3NI
	LDXvNKKHflEwjvi5V0QvLOVlWNEkqtpA1557NcaH8IzfE5udk/jXrEKjcmRplmEl
	FRYJEG6VRZ++T72PE6IoZ9ffWR1GWsFJ2azkhfvwjkVLjp4uCkoRxljERtDP7vjQ
	mYFbZmel8kP2qvScc+F2tEaPUzoarCGKmBeDXSsnvuXFfvKDEek8EZYdYVoX1uFt
	k39gV7ebH4OKLj5ejM6/wo7RNjb1yzcz9UNmrVjPRM3jx4gDrVKrbGOJgsWv8Ox9
	uK9/PHgRVuWQTy6IgDqL8wIimeo9cZcTFdw==
X-ME-Sender: <xms:nFqiaUnZOODG0ms7fDL_T9Fe9Ehh8nZMZaZD9GcMwSSziUAhJ_91aw>
    <xme:nFqiaeMBKcfJHc6UZA8Ysp7uBYOrPVPXhKbhxiUF1pF0S9JNLx_aJCfqa3fQ3kf9R
    ocJoq1CEOC1OgII0Smxr1IcEKyLrrVhzIG6BR-IuEgPnUYUw85zHWDY>
X-ME-Received: <xmr:nFqiaeNARdd-dDZnXc_yYj9P2OIS_CjvNmf2SQVnlsBOMsEcN0F_GXLPjZnXk3Hg5vffaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvhedtjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepueffvedvvdefudejfeeuudfgtdfgudettdevfeeileffhffghfdtjeekhfeitdek
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvthdpnhgs
    pghrtghpthhtohepfeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvg
    hmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepshgufhesfhhomhhitghhvghv
    rdhmvgdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epjhhorghmrghkihesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhnhdrfhgrshht
    rggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoug
    hmihhsrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehhrgholhhuohesghhoohhglhgvrdgtohhmpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvght
X-ME-Proxy: <xmx:nFqiaalNrNmK8UpCXNwazjC_j8nHYMQIFFsx5-2p0XHGQ7nvK7mAeg>
    <xmx:nFqiacp4J3Go_Yw1vPWQH9DTQxlLiCfcFVlTOghPdrzq4FDisXQ_bQ>
    <xmx:nFqiaW62s_xG5E_8JChfbjZyvy4U1gPaw8IwFjOhaldPe6jUO82-ZQ>
    <xmx:nFqiaeI4u6llgwuLgpeDkzVUvGlk__f5eanmtLfrc1fQjBOXn8uT1w>
    <xmx:nVqiaaexi1XMQhpAFW4BwYjb-lJExr5VhnTNuPrSPWjGuQTHImjZeasM>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 22:01:48 -0500 (EST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 486C19FCAE; Fri, 27 Feb 2026 19:01:47 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 445479FC72;
	Fri, 27 Feb 2026 19:01:47 -0800 (PST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
cc: netdev@vger.kernel.org, jiayuna.chen@linux.dev,
    jiayuna.chen@shopee.com, Jiayuan Chen <jiayuan.chen@shopee.com>,
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
    Eduard Zingerman <eddyz87@gmail.com>,
    Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
    Yonghong Song <yonghong.song@linux.dev>,
    KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
    Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
    Clark Williams <clrkwllms@kernel.org>,
    Steven Rostedt <rostedt@goodmis.org>, Jussi Maki <joamaki@gmail.com>,
    linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
    linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v3 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
In-reply-to: <20260228021918.141002-2-jiayuan.chen@linux.dev>
References: <20260228021918.141002-1-jiayuan.chen@linux.dev>
 <20260228021918.141002-2-jiayuan.chen@linux.dev>
Comments: In-reply-to Jiayuan Chen <jiayuan.chen@linux.dev>
   message dated "Sat, 28 Feb 2026 10:19:13 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <999128.1772247707.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Feb 2026 19:01:47 -0800
Message-ID: <999129.1772247707@famine>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262056-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,shopee.com,syzkaller.appspotmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linutronix.de,goodmis.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,linux.dev:email,shopee.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,jvosburgh.net:email,jvosburgh.net:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,80e046b8da2820b6ba73];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 60F0C1C00E2
X-Rspamd-Action: no action

Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

>From: Jiayuan Chen <jiayuan.chen@shopee.com>
>
>bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
>check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
>when the bond mode is round-robin. If the bond device was never brought
>up, rr_tx_counter remains NULL, causing a null-ptr-deref.
>
>The XDP redirect path can reach this code even when the bond is not up:
>bpf_master_redirect_enabled_key is a global static key, so when any bond
>device has native XDP attached, the XDP_TX -> xdp_master_redirect()
>interception is enabled for all bond slaves system-wide. This allows the
>path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
>bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
>reached on a bond that was never opened.
>
>The normal TX path (bond_xmit_roundrobin) is not affected because TX
>requires the bond to be UP, which guarantees rr_tx_counter is allocated.
>However, bond_xmit_get_slave() (ndo_get_xmit_slave) has the same code
>pattern via bond_xmit_roundrobin_slave_get() and could theoretically
>hit the same issue.

	As a practical matter, though, I don't think the
ndo_get_xmit_slave path can actually hit the issue, as that looks to
only be called from Infiniband, which is only supported in bonding for
active-backup mode.

>Fix this by allocating rr_tx_counter unconditionally in bond_init()
>(ndo_init), which is called by register_netdevice() and covers both
>device creation paths (bond_create() and bond_newlink()). This also
>handles the case where bond mode is changed to round-robin after device
>creation. The conditional allocation in bond_open() is removed. Since
>bond_destructor() already unconditionally calls
>free_percpu(bond->rr_tx_counter), the lifecycle is clean: allocate at
>ndo_init, free at destructor.
>
>Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave=
 device")
>Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
>Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@goo=
gle.com/T/
>Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>

	My only concern is that this will waste a percpu u32 per bond
device for the majority of bonding use cases (which use modes other than
balance-rr), which could be a few hundred bytes on a large machine.

	Does everything work reliably if the rr_tx_counter allocation
happens conditionally on mode =3D=3D BOND_MODE_ROUNDROBIN in bond_setup, a=
s
well as in bond_option_mode_set?

	-J

>---
> drivers/net/bonding/bond_main.c | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 78cff904cdc3..9f63f67d8418 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -4279,12 +4279,6 @@ static int bond_open(struct net_device *bond_dev)
> 	struct list_head *iter;
> 	struct slave *slave;
> =

>-	if (BOND_MODE(bond) =3D=3D BOND_MODE_ROUNDROBIN && !bond->rr_tx_counter=
) {
>-		bond->rr_tx_counter =3D alloc_percpu(u32);
>-		if (!bond->rr_tx_counter)
>-			return -ENOMEM;
>-	}
>-
> 	/* reset slave->backup and slave->inactive */
> 	if (bond_has_slaves(bond)) {
> 		bond_for_each_slave(bond, slave, iter) {
>@@ -6411,6 +6405,12 @@ static int bond_init(struct net_device *bond_dev)
> 	if (!bond->wq)
> 		return -ENOMEM;
> =

>+	bond->rr_tx_counter =3D alloc_percpu(u32);
>+	if (!bond->rr_tx_counter) {
>+		destroy_workqueue(bond->wq);
>+		return -ENOMEM;
>+	}
>+
> 	bond->notifier_ctx =3D false;
> =

> 	spin_lock_init(&bond->stats_lock);
>-- =

>2.43.0
>

---
	-Jay Vosburgh, jv@jvosburgh.net

