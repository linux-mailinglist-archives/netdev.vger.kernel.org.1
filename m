Return-Path: <netdev+bounces-284611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C1eBBOG+mlCPgMAu9opvQ
	(envelope-from <netdev+bounces-284611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:06:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D16944D4E1F
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D9053021ADC
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 00:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DF2224F3;
	Wed,  6 May 2026 00:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCtSkrZ2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43FF171AF;
	Wed,  6 May 2026 00:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778025994; cv=none; b=SmvIzVLPvoSiwNjBP5qtcO8Re6L1/CSCQm/l4OxaHxPPOBS7te1uByV9hi2uTwLZGJI9nH4UYGs+z+fT3QZPxVWRSp0PPYQNbEXg4CKQkzvhrkJZBnAZJGRARn0vHTLr3nHf/tAAOtOJd+/6Tdtt6S8FZFHKmFeLyfxqg54iEpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778025994; c=relaxed/simple;
	bh=uXIZ04UpLsLskFSVN25zZr1RR3jMI9tBpNWHRh2ZMLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBgQNfCoWC1OXBzEs+leOfBzZRA3HhJ9gqwh+kvIQ6rDsKvqDEZriJ70Pixg7MkVZbaeg5rJ/YrNh0WLHp04nRCAXKRy5NE1HZRwQzT+eiH4F8x+MuE2pj57/tHpT/QeY52okSwa0IOpnYEbAZD3V3KcXKn8Deqm3ggRXNgSOm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCtSkrZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779EDC2BCF6;
	Wed,  6 May 2026 00:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778025993;
	bh=uXIZ04UpLsLskFSVN25zZr1RR3jMI9tBpNWHRh2ZMLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YCtSkrZ2Bk7eyLK0NPh5+q/kSAL9S+AK9Ccr9Dw37B+3M6WjkUGpg1onnSs1C0d1K
	 I+tory1nQgmGsXmn8H/sLFiPednzMD/su3xJgfE3wnM3cBOO+1Ut7r6zo1kjst1Hqu
	 TLypvvL4TQPF2o9w4V3nTzjGuT1ew1A/9C/gWhlC9+1elX7SajokiPq3exmWLrAhIE
	 57L3iHwfQnuV5mNVJ8IC+6sXSuPgYR9BUqqxgRm35HhD7P4XACCuSRZ5B1bEk0umRg
	 GUwXAE4HrWC4dsEcNHhWcahj6Fl4BmJPi6CzK/xXkSce2+OZka264i4Vg6JG/n7Xwq
	 3A2ByW0yC0Ifw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 01/12] net: shaper: drop redundant xa_lock() bracketing
Date: Tue,  5 May 2026 17:06:17 -0700
Message-ID: <20260506000628.1501691-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506000628.1501691-1-kuba@kernel.org>
References: <20260506000628.1501691-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D16944D4E1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284611-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

The shaper insertion code is written in a way that suggests that
perhaps it was expecting readers to be fenced off by xa_lock.
This is not the case, readers of XArray are purely under RCU.

Remove the explicit taking of xa_lock() to simplify subsequent fixes.

All writers to hierarchy->shapers are serialized by the netdev instance
lock. For Netlink taken in net_shaper_nl_pre_doit_write().
net_shaper_set_real_num_tx_queues() has a netdev_assert_locked().
net_shaper_flush_netdev() runs after netdev is made inaccessible
to readers.

The explicit xa_lock() bracketing in pre_insert(), commit(), rollback()
and flush() therefore does not protect against any other writer.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/shaper/shaper.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 94bc9c7382ea..e28d20774713 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -373,10 +373,8 @@ static int net_shaper_pre_insert(struct net_shaper_binding *binding,
 	/* Mark 'tentative' shaper inside the hierarchy container.
 	 * xa_set_mark is a no-op if the previous store fails.
 	 */
-	xa_lock(&hierarchy->shapers);
-	prev = __xa_store(&hierarchy->shapers, index, cur, GFP_KERNEL);
-	__xa_set_mark(&hierarchy->shapers, index, NET_SHAPER_NOT_VALID);
-	xa_unlock(&hierarchy->shapers);
+	prev = xa_store(&hierarchy->shapers, index, cur, GFP_KERNEL);
+	xa_set_mark(&hierarchy->shapers, index, NET_SHAPER_NOT_VALID);
 	if (xa_err(prev)) {
 		NL_SET_ERR_MSG(extack, "Can't insert shaper into device store");
 		kfree_rcu(cur, rcu);
@@ -402,7 +400,6 @@ static void net_shaper_commit(struct net_shaper_binding *binding,
 	int index;
 	int i;
 
-	xa_lock(&hierarchy->shapers);
 	for (i = 0; i < nr_shapers; ++i) {
 		index = net_shaper_handle_to_index(&shapers[i].handle);
 
@@ -413,11 +410,10 @@ static void net_shaper_commit(struct net_shaper_binding *binding,
 		/* Successful update: drop the tentative mark
 		 * and update the hierarchy container.
 		 */
-		__xa_clear_mark(&hierarchy->shapers, index,
-				NET_SHAPER_NOT_VALID);
+		xa_clear_mark(&hierarchy->shapers, index,
+			      NET_SHAPER_NOT_VALID);
 		*cur = shapers[i];
 	}
-	xa_unlock(&hierarchy->shapers);
 }
 
 /* Rollback all the tentative inserts from the hierarchy. */
@@ -430,13 +426,11 @@ static void net_shaper_rollback(struct net_shaper_binding *binding)
 	if (!hierarchy)
 		return;
 
-	xa_lock(&hierarchy->shapers);
 	xa_for_each_marked(&hierarchy->shapers, index, cur,
 			   NET_SHAPER_NOT_VALID) {
-		__xa_erase(&hierarchy->shapers, index);
+		xa_erase(&hierarchy->shapers, index);
 		kfree(cur);
 	}
-	xa_unlock(&hierarchy->shapers);
 }
 
 static int net_shaper_parse_handle(const struct nlattr *attr,
@@ -1382,12 +1376,10 @@ static void net_shaper_flush(struct net_shaper_binding *binding)
 	if (!hierarchy)
 		return;
 
-	xa_lock(&hierarchy->shapers);
 	xa_for_each(&hierarchy->shapers, index, cur) {
-		__xa_erase(&hierarchy->shapers, index);
+		xa_erase(&hierarchy->shapers, index);
 		kfree(cur);
 	}
-	xa_unlock(&hierarchy->shapers);
 
 	kfree(hierarchy);
 }
-- 
2.54.0


