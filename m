Return-Path: <netdev+bounces-265368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ATrDZ85rmnCAgIAu9opvQ
	(envelope-from <netdev+bounces-265368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 04:08:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B39233750
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 04:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29E4F3008D14
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 03:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1C127510E;
	Mon,  9 Mar 2026 03:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FqAcjUMv"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C8125B305
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 03:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773025673; cv=none; b=ewlN+TXEvXRRgUTu5bDT1/QhXl9poMz7xx5UF9jFhluQS9PCL4/VrjAex3oIPck55YmfchlHt4Xxi54JTfmD27F7YvZOfe5VKpZuEmIaZvrZDZeCEX5+HUzl0dlik6bjEhdqeWzn/p1UqPNmaGwlzsGDmqjdH6aj0xycXmRJfO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773025673; c=relaxed/simple;
	bh=SDkQow/iRhpF2zE7xjggzNljs0gpgOKw/Olgq+NraIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/W9M1UgPrjATEqw0ZXEBc3snA0oShxwqjQPlF/BIJ7TGc5l402gFUv+vVYsyPt7NQgluua0QApJ+At2TX7S8yw2/MWYanzzQJdJZF/NcRLl+yALqw5yAywoy6yVZCP2Xt3qXZNTA7bbSui7bD+W++AgeiT6Tja4IKzWhXBeqsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FqAcjUMv; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773025670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BbFK3npR4cMGVcnEOFnm47SSMGdvc4FOwwf4HNartog=;
	b=FqAcjUMvAptrQ08/l3alSH2vVt6DcaCNmtJ7AYBH2v1WAo95Srl77ipgPnPGroL1qeNyr2
	WKO/EGkgLYG0tbd/rxhV47qY1cOTnjQckZXA/FmX1di5m/c2KRxsLj2B6wc5jXHU9K2qfD
	23WMQzt8zLlvBZxuM1vjeE/f5aCZ2n0=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: razor@blackwall.org,
	jiayuan.chen@shopee.com,
	jiayuan.chen@linux.dev,
	syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jussi Maki <joamaki@gmail.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH net v5 1/2] bonding: fix null-ptr-deref in bond_rr_gen_slave_id()
Date: Mon,  9 Mar 2026 11:06:58 +0800
Message-ID: <20260309030702.128520-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260309030702.128520-1-jiayuan.chen@linux.dev>
References: <20260309030702.128520-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: A0B39233750
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265368-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[blackwall.org,shopee.com,linux.dev,syzkaller.appspotmail.com,jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linutronix.de,goodmis.org,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,80e046b8da2820b6ba73];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
when the bond mode is round-robin. If the bond device was never brought
up, rr_tx_counter remains NULL, causing a null-ptr-deref.

The XDP redirect path can reach this code even when the bond is not up:
bpf_master_redirect_enabled_key is a global static key, so when any bond
device has native XDP attached, the XDP_TX -> xdp_master_redirect()
interception is enabled for all bond slaves system-wide. This allows the
path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
reached on a bond that was never opened.

Fix this by adding a NULL check with unlikely() in bond_rr_gen_slave_id()
before dereferencing rr_tx_counter. When rr_tx_counter is NULL (bond was
never opened), fall back to get_random_u32() for slave selection. The
allocation in bond_open() is kept, with WRITE_ONCE() added to safely
publish the pointer to the XDP read side. A plain read suffices for the
!bond->rr_tx_counter guard in bond_open() itself, as bond_open() runs
under RTNL lock and is the only writer of rr_tx_counter.

Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 drivers/net/bonding/bond_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 444519078da3..b8ec87625ce3 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4290,9 +4290,11 @@ static int bond_open(struct net_device *bond_dev)
 	struct slave *slave;
 
 	if (BOND_MODE(bond) == BOND_MODE_ROUNDROBIN && !bond->rr_tx_counter) {
-		bond->rr_tx_counter = alloc_percpu(u32);
-		if (!bond->rr_tx_counter)
+		u32 __percpu *rr_tx_tmp = alloc_percpu(u32);
+
+		if (!rr_tx_tmp)
 			return -ENOMEM;
+		WRITE_ONCE(bond->rr_tx_counter, rr_tx_tmp);
 	}
 
 	/* reset slave->backup and slave->inactive */
@@ -4883,6 +4885,9 @@ static u32 bond_rr_gen_slave_id(struct bonding *bond)
 	struct reciprocal_value reciprocal_packets_per_slave;
 	int packets_per_slave = bond->params.packets_per_slave;
 
+	if (unlikely(!READ_ONCE(bond->rr_tx_counter)))
+		return get_random_u32();
+
 	switch (packets_per_slave) {
 	case 0:
 		slave_id = get_random_u32();
-- 
2.43.0


