Return-Path: <netdev+bounces-294656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1LtzFSXiH2oUrwAAu9opvQ
	(envelope-from <netdev+bounces-294656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:13:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5215F635932
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 10:13:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mMoHmWTw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294656-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294656-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12B9131135ED
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A133A5E77;
	Wed,  3 Jun 2026 07:39:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6768339B486
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:39:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472349; cv=none; b=oa3K3+9IGU8/cmP0DDfVcAlFpMmn0WS5ckbDPNND5YKwpen0sF4WFqzsE7r6IppRKl5orygu72JfpdEul2l9QoYdfpdBza0/1SD0KiQ8QBkYkrJIfjMQHrmlMT3ttpPuOcwarnoe3UqQF9+pRmC9XJYfhLOhgcEnnrJomtFSKps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472349; c=relaxed/simple;
	bh=XujChRV8mAQ3o04pNBJvnDGEeim/+01kf8fjL88Qhcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tbi4MKHpKhcPyHftRfeRhBqmg1HMe/KS4oy3iSKtxqin1ioc2y4/a2Gqp8ZcwITTDgpF+9EgKwpo4utkNaQ1CAu3eawkRsbjw3Sf8bm7SGFyPZQ9lb1WHkAdKjMQF5qGaWnbfXRFmzednuiNz7x0RX7gO7duqJSiXtNvWWkT+YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMoHmWTw; arc=none smtp.client-ip=74.125.82.169
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304545f5206so16812493eec.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 00:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780472345; x=1781077145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=03qJ+adv11Q2sSTj1AKdKlt3vl/S6TLS74I5VOZF2oE=;
        b=mMoHmWTwwTuaVhKPYqFNN0c322IFktkN6m1K5jBwUxl00Bm0BK8fZ9yRtMkmPknA7g
         IthCD+gv7naEvsOEDShv31lGyDkLG4IvpZc/5JvA1IMS0uGebrw9JK9BEZ8+Oi1qw1Wo
         z4QkLaRn30Hk8FQDXB6iboVO1GxpM3rkVyk/XctWmdhqp7Vva5GXJwrhHvb7K7FaFXsK
         vnmKt4tC8ka9+f3NjYnhT4qTLq/DWvXI3FHNH0lEqeFZBs3VzdNLvWB3D58YYFioAW5d
         v4XxsPUFqea2gMHg8TpcPV9FQPJrlKM+RtMMNakJAA2N6laOG24OW0gOphRsMT7xdolC
         MvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780472345; x=1781077145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03qJ+adv11Q2sSTj1AKdKlt3vl/S6TLS74I5VOZF2oE=;
        b=o+sD+kn6p0T2NsVcuEzbgQAaFuj02Uaqp7zNrTqOdhQI4leZtkbf5DPaQo7R5zKUCI
         rZ8j7XBYRG6bvm58XXDAzUZYGRE28UPbwPkZhg9Kg8Yp12H9wJmkXp0ZKJcNYathgYcY
         dpqhNAleiSC0XSHGmX2BbBeiNgUOTANdUSJOnfpVk57L2RnpLkWicfWbKIQf6ZX6Qnj1
         hGNFbSUnmxtgwe3wqSLkQa0mxWhp4DcbSFfK8dfVm44o+sfo3RnwUduRhvPJA9WaOLXG
         tkhvduZT5T6HMEbDsGXURzYrGb665BNvUEkI7OOt6uKLeBRhMtZLk9K5gNBqfOO/Wp9y
         oIzg==
X-Forwarded-Encrypted: i=1; AFNElJ9QnCobloxk3YWc2ZgnEYpt269s78GfuayF1ODd0unk8ShglVj+YxscnXPkQNxCSVpubTuadXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4K7jMzOkPhMZreqHKsDmEDJSyxKjNBFDnv3AUwwvmZ9AZATQ5
	aOX8Z9lP4hL2R9BOAj4CH5yexHT2rH6j85uX4d2V6IPRv1TOCa6sk50i
X-Gm-Gg: Acq92OErbDPbJi+mQl2knicpQOfkrC6AseIZccskj3GicVeiF/JoA4bLNM6V6fZAIyS
	A0cy7866a0RqnNqCfZfhfTcjN7I16WmnB/71FF5hrAgKVuEXz805u7gJmpILY0tzDfZK2byNpa1
	TOg5jdzB0MvevZn6r5VrDIrIL/tU2vk3DDNx91DYqBO3XrimWnE4Hxf8l84udmZhRcnOQkVslIR
	qd9GCzKUL0qeFUte+q5T+jY0yanZiQAIBcGfZIL4KK6X7QUT5vx5SnJHCPH9jWfHmLR09mD1s2r
	aiAm2zrLyuwiBtqGe/l5mKcpR5DY6MUo5h0n1ujvD+SADUuyqZ5kyKm+HsYF1uBtSphbjIESUdV
	T1TMraBbIcVaf/7nrIvWk0Vfm+9z+MqDw/geMHrsBltVHTW9fAjgfYwLwK6NrvBgxtZO4viTRu7
	K7vGvmo/qg4c86SDeaN763zZhpOHUV0JJNH+eXciWxTPdTc6kqIudoQAK0yy+a8oubyOqyEAfpu
	QK3HNc=
X-Received: by 2002:a05:7300:fd09:b0:304:3c33:7ad6 with SMTP id 5a478bee46e88-3074fa6669fmr1180259eec.11.1780472345373;
        Wed, 03 Jun 2026 00:39:05 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df805d1sm1567896eec.28.2026.06.03.00.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 00:39:04 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: pablo@netfilter.org
Cc: fw@strlen.de,
	phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH nf] netfilter: nf_conntrack: destroy stale expectfn expectations on unregister
Date: Wed,  3 Jun 2026 00:38:17 -0700
Message-ID: <20260603073815.2159603-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[strlen.de,nwl.cc,vger.kernel.org,netfilter.org,asu.edu,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294656-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5215F635932

NAT helpers such as nf_nat_h323 store a raw pointer to module text in
exp->expectfn (e.g. ip_nat_q931_expect). nf_ct_helper_expectfn_unregister()
only unlinks the callback descriptor and never walks the expectation table,
so an expectation pending at module removal survives with a dangling
exp->expectfn into freed module text.

When the expected connection arrives, init_conntrack() invokes
exp->expectfn(), now a stale pointer into the unloaded module. Reproduced
on a KASAN build by loading the H.323 helpers, creating a Q.931
expectation, unloading nf_nat_h323, then connecting to the expected port:

 Oops: int3: 0000 [#1] SMP KASAN NOPTI
 RIP: 0010:0xffffffffa06102d1
  init_conntrack.isra.0 (net/netfilter/nf_conntrack_core.c:1862)
  nf_conntrack_in (net/netfilter/nf_conntrack_core.c:2049)
  ipv4_conntrack_local (net/netfilter/nf_conntrack_proto.c:223)
  nf_hook_slow (net/netfilter/core.c:619)
  __ip_local_out (net/ipv4/ip_output.c:120)
  __tcp_transmit_skb (net/ipv4/tcp_output.c:1715)
  tcp_connect (net/ipv4/tcp_output.c:4374)
  tcp_v4_connect (net/ipv4/tcp_ipv4.c:345)
  __sys_connect (net/socket.c:2167)
 Modules linked in: nf_conntrack_h323 [last unloaded: nf_nat_h323]

Reaching the dangling state requires CAP_SYS_MODULE in the initial user
namespace to remove a NAT helper that still has live expectations, so this
is a robustness fix; leaving an expectation pointing at freed text is wrong
regardless.

Add nf_ct_helper_expectfn_destroy(), which walks the expectation table and
drops every expectation whose ->expectfn matches the descriptor being torn
down. Call it from each NAT helper's exit path after the existing RCU grace
period, so no expectation outlives the code it points at and no extra
synchronize_rcu() is introduced. With the fix, the same reproducer runs to
completion without the Oops.

Fixes: f587de0e2feb ("[NETFILTER]: nf_conntrack/nf_nat: add H.323 helper port")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 include/net/netfilter/nf_conntrack_helper.h |  1 +
 net/ipv4/netfilter/nf_nat_h323.c            |  2 ++
 net/netfilter/nf_conntrack_helper.c         | 19 +++++++++++++++++++
 net/netfilter/nf_nat_core.c                 |  2 ++
 net/netfilter/nf_nat_sip.c                  |  1 +
 5 files changed, 25 insertions(+)

diff --git a/include/net/netfilter/nf_conntrack_helper.h b/include/net/netfilter/nf_conntrack_helper.h
index de2f956abf34..24cf3d2d9745 100644
--- a/include/net/netfilter/nf_conntrack_helper.h
+++ b/include/net/netfilter/nf_conntrack_helper.h
@@ -155,6 +155,7 @@ void nf_ct_helper_log(struct sk_buff *skb, const struct nf_conn *ct,
 
 void nf_ct_helper_expectfn_register(struct nf_ct_helper_expectfn *n);
 void nf_ct_helper_expectfn_unregister(struct nf_ct_helper_expectfn *n);
+void nf_ct_helper_expectfn_destroy(const struct nf_ct_helper_expectfn *n);
 struct nf_ct_helper_expectfn *
 nf_ct_helper_expectfn_find_by_name(const char *name);
 struct nf_ct_helper_expectfn *
diff --git a/net/ipv4/netfilter/nf_nat_h323.c b/net/ipv4/netfilter/nf_nat_h323.c
index faee20af4856..10e1b0837731 100644
--- a/net/ipv4/netfilter/nf_nat_h323.c
+++ b/net/ipv4/netfilter/nf_nat_h323.c
@@ -555,6 +555,8 @@ static void __exit nf_nat_h323_fini(void)
 	nf_ct_helper_expectfn_unregister(&q931_nat);
 	nf_ct_helper_expectfn_unregister(&callforwarding_nat);
 	synchronize_rcu();
+	nf_ct_helper_expectfn_destroy(&q931_nat);
+	nf_ct_helper_expectfn_destroy(&callforwarding_nat);
 }
 
 /****************************************************************************/
diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
index 17e971bd4c74..2c5a71735561 100644
--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -283,6 +283,25 @@ void nf_ct_helper_expectfn_unregister(struct nf_ct_helper_expectfn *n)
 }
 EXPORT_SYMBOL_GPL(nf_ct_helper_expectfn_unregister);
 
+static bool expect_iter_expectfn(struct nf_conntrack_expect *exp, void *data)
+{
+	const struct nf_ct_helper_expectfn *n = data;
+
+	/* Relies on registered expectfn descriptors having unique ->expectfn
+	 * pointers, which holds for the in-tree NAT helpers.
+	 */
+	return exp->expectfn == n->expectfn;
+}
+
+/* Destroy expectations still pointing at @n->expectfn; call after the
+ * caller's RCU grace period so none outlives the (often modular) callback.
+ */
+void nf_ct_helper_expectfn_destroy(const struct nf_ct_helper_expectfn *n)
+{
+	nf_ct_expect_iterate_destroy(expect_iter_expectfn, (void *)n);
+}
+EXPORT_SYMBOL_GPL(nf_ct_helper_expectfn_destroy);
+
 /* Caller should hold the rcu lock */
 struct nf_ct_helper_expectfn *
 nf_ct_helper_expectfn_find_by_name(const char *name)
diff --git a/net/netfilter/nf_nat_core.c b/net/netfilter/nf_nat_core.c
index 74ec224ce0d6..2bbf5163c0e2 100644
--- a/net/netfilter/nf_nat_core.c
+++ b/net/netfilter/nf_nat_core.c
@@ -1341,6 +1341,7 @@ static int __init nf_nat_init(void)
 		RCU_INIT_POINTER(nf_nat_hook, NULL);
 		nf_ct_helper_expectfn_unregister(&follow_master_nat);
 		synchronize_net();
+		nf_ct_helper_expectfn_destroy(&follow_master_nat);
 		unregister_pernet_subsys(&nat_net_ops);
 		kvfree(nf_nat_bysource);
 	}
@@ -1358,6 +1359,7 @@ static void __exit nf_nat_cleanup(void)
 	RCU_INIT_POINTER(nf_nat_hook, NULL);
 
 	synchronize_net();
+	nf_ct_helper_expectfn_destroy(&follow_master_nat);
 	kvfree(nf_nat_bysource);
 	unregister_pernet_subsys(&nat_net_ops);
 }
diff --git a/net/netfilter/nf_nat_sip.c b/net/netfilter/nf_nat_sip.c
index 9fbfc6bff0c2..00838c0cc5bb 100644
--- a/net/netfilter/nf_nat_sip.c
+++ b/net/netfilter/nf_nat_sip.c
@@ -655,6 +655,7 @@ static void __exit nf_nat_sip_fini(void)
 	RCU_INIT_POINTER(nf_nat_sip_hooks, NULL);
 	nf_ct_helper_expectfn_unregister(&sip_nat);
 	synchronize_rcu();
+	nf_ct_helper_expectfn_destroy(&sip_nat);
 }
 
 static const struct nf_nat_sip_hooks sip_hooks = {
-- 
2.43.0


