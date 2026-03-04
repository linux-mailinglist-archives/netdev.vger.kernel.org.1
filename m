Return-Path: <netdev+bounces-263631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHo/F63ip2mrlAAAu9opvQ
	(envelope-from <netdev+bounces-263631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:43:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5096E1FBC2F
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D7263015A70
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 07:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A4337F8C4;
	Wed,  4 Mar 2026 07:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hPttfdbf"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E1418A6DB
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 07:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610218; cv=none; b=WDExHl8/Xb6gW85Zm5HchcVSntPx37s1YNAa3EjyMgnsW0ChurykLzH9hXoU2jf9xSHMc0sTiVRRrtQkr8yfOrk04rHAY1b1pUO6UQWnui8wia0iJMBNAAjyNytUx3xj0cY/G08rnc+LrvJl01Ol5ABZ9i6dvhYvqkWFDysivVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610218; c=relaxed/simple;
	bh=ds9fEzCzgnOh8aZtFA8qphSeg7jiatW+uffLqHndLZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2yNUwDclgHARVr3bgKzKFbdqCDSS59l4bLGJy9eu0UE/7mnvRF3RaeTchwVUu9fU2XMeATSrp/DTetp2La27V4Yy8nhrGlJuaiCmxlJiF4cuLwoWk+JMhQOQ55KGaZvz3e96HXPgeA+UnyKE45Inj4oMcsBYfSqlbN58HQfM0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hPttfdbf; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772610214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gkKYESAH5YFAD03Jj76NpTW6HeKRoN5KgHV8fqdKUwk=;
	b=hPttfdbfoMJn5mkbkpzGib/ixwWVH0nVRqwVGlyIaVXN9oRVzmBs5c5HBelUUTKaec9iba
	Z4Jz4Xq/vaUOzJG9K2wyfuWbtmATt2rQlm63ShEphIYdfmjN+vIRmhWudq7wFzXodtx9iD
	4n9V8PUb0fIoIDas7XPnB0O36Oqu4Hg=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: jv@jvosburgh.net,
	netdev@vger.kernel.org
Cc: jiayuan.chen@linux.dev,
	jiayuan.chen@shopee.com,
	syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
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
Subject: [PATCH net v4 1/2] bonding: fix null-ptr-deref in bond_rr_gen_slave_id()
Date: Wed,  4 Mar 2026 15:42:57 +0800
Message-ID: <20260304074301.35482-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260304074301.35482-1-jiayuan.chen@linux.dev>
References: <20260304074301.35482-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 5096E1FBC2F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,shopee.com,syzkaller.appspotmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linutronix.de,goodmis.org,vger.kernel.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[32];
	TAGGED_FROM(0.00)[bounces-263631-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,80e046b8da2820b6ba73];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,shopee.com:email,linux.dev:dkim,linux.dev:mid]
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

Fix this by allocating rr_tx_counter unconditionally in bond_init()
(ndo_init), which is called by register_netdevice() and covers both
device creation paths (bond_create() and bond_newlink()). This also
handles the case where bond mode is changed to round-robin after device
creation. The conditional allocation in bond_open() is removed. Since
bond_destructor() already unconditionally calls
free_percpu(bond->rr_tx_counter), the lifecycle is clean: allocate at
ndo_init, free at destructor.

Note: rr_tx_counter is only used by round-robin mode, so this
deliberately allocates a per-cpu u32 that goes unused for other modes.
Conditional allocation (e.g., in bond_option_mode_set) was considered
but rejected: the XDP path can race with mode changes on a downed bond,
and adding memory barriers to the XDP hot path is not justified for
saving 4 bytes per CPU.

Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 drivers/net/bonding/bond_main.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 78cff904cdc3..55b5c7a6cb5f 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4279,12 +4279,6 @@ static int bond_open(struct net_device *bond_dev)
 	struct list_head *iter;
 	struct slave *slave;
 
-	if (BOND_MODE(bond) == BOND_MODE_ROUNDROBIN && !bond->rr_tx_counter) {
-		bond->rr_tx_counter = alloc_percpu(u32);
-		if (!bond->rr_tx_counter)
-			return -ENOMEM;
-	}
-
 	/* reset slave->backup and slave->inactive */
 	if (bond_has_slaves(bond)) {
 		bond_for_each_slave(bond, slave, iter) {
@@ -6411,6 +6405,19 @@ static int bond_init(struct net_device *bond_dev)
 	if (!bond->wq)
 		return -ENOMEM;
 
+	/* rr_tx_counter is only used in round-robin mode, but we allocate
+	 * it unconditionally because the XDP redirect path
+	 * (xdp_master_redirect -> bond_xdp_get_xmit_slave) can reach here
+	 * even when the bond is not up, and deferring allocation to
+	 * bond_open or bond_option_mode_set would require memory barriers
+	 * on the XDP hot path. The cost is a per-cpu u32 per bond device.
+	 */
+	bond->rr_tx_counter = alloc_percpu(u32);
+	if (!bond->rr_tx_counter) {
+		destroy_workqueue(bond->wq);
+		return -ENOMEM;
+	}
+
 	bond->notifier_ctx = false;
 
 	spin_lock_init(&bond->stats_lock);
-- 
2.43.0


