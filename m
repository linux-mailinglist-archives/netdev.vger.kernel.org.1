Return-Path: <netdev+bounces-305814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BxTbOVFQTmpzKgIAu9opvQ
	(envelope-from <netdev+bounces-305814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:27:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CB5726C98
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:27:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=chelsio.com (policy=reject);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305814-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305814-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1EAC3047408
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 13:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DB42EDD69;
	Wed,  8 Jul 2026 13:19:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEE8289367
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 13:19:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783516768; cv=none; b=g76AnZxy0mHOV8qV05ppQVSf4lH4BVknvIzp/Q9Xtvc3okNYtys9dM/PHZIb2XZY6R+Gg1kyhXv6rFKgHmcS683D9rIi+hzcGLeQOhK2DS8uXjYR3azt0wt9rcqjQJQpX7B3iGVGC++IowwBdrzseTtpn0XX+W3TjdT8CtuQYHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783516768; c=relaxed/simple;
	bh=qhIBDv16+DA9EAZfk6oPpiy1RrkgdACjEOYnaFzJIyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rle+29bn8UvIH6aWER8nyDwOVdffX4ufmExh8sKduRt56bOtvyjdfjTde0YmE+U+xDgitYviABQSciLX0FdQXY6XcWQ/HuLcoo2zFs++QZpRJw4YpAQgO/RNGAkohVNU/bx/kVFZM/gvhGijSzAzA3POL0kIE7A+gsddfxEmBm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Received: from fcoeperf6.blr.asicdesigners.com (fcoeperf6.blr.asicdesigners.com [10.193.187.161])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 668DGxc3024431;
	Wed, 8 Jul 2026 06:17:00 -0700
From: Harshita V Rajput <harshitha.vr@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com,
        harshitha.vr@chelsio.com
Subject: [PATCH net] cxgb4: consider EtherType when validating filter priority ordering
Date: Wed,  8 Jul 2026 18:46:07 +0530
Message-ID: <20260708131650.14747-1-harshitha.vr@chelsio.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[chelsio.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305814-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:bharat@chelsio.com,m:harshitha.vr@chelsio.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[harshitha.vr@chelsio.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshitha.vr@chelsio.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40CB5726C98

cxgb4_filter_prio_in_range() currently validates the priority
ordering of adjacent filters based only on tc_prio. This can
incorrectly reject insertion of a new filter when an existing
filter with a higher priority matches a different EtherType.

For example:
- An LLDP filter (pref 4) blocks IPv4 (pref 2) and IPv6 (pref 3)
  filters from being added.
- An IPv6 filter (pref 3) blocks an IPv4 (pref 2) filter from being
  added.

In both cases the filters match different EtherTypes, so they could
never have matched the same packet anyway.

Fix this by considering both tc_prio and the matched EtherType. A
neighbouring filter only blocks the new filter if it has no specific
EtherType set, or its EtherType is the same as the new filter's.
Filters with different EtherTypes are now allowed regardless of
priority order. Filters with the same EtherType still follow the
original strict priority check, since they really can overlap.

Fixes: 41ec03e534ca ("cxgb4: check rule prio conflicts before offload")
Signed-off-by: Harshita V Rajput <harshitha.vr@chelsio.com>
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 .../net/ethernet/chelsio/cxgb4/cxgb4_filter.c | 19 ++++++++++++++-----
 .../ethernet/chelsio/cxgb4/cxgb4_tc_flower.c  |  4 ++--
 .../chelsio/cxgb4/cxgb4_tc_matchall.c         |  2 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_tc_u32.c |  2 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_uld.h    |  2 +-
 5 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
index 657d96b9e2f6..8462455d9330 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
@@ -443,7 +443,7 @@ int cxgb4_get_filter_counters(struct net_device *dev, unsigned int fidx,
 }
 
 static bool cxgb4_filter_prio_in_range(struct tid_info *t, u32 idx, u8 nslots,
-				       u32 prio)
+				       u32 prio, u32 ethtype)
 {
 	struct filter_entry *prev_tab, *next_tab, *prev_fe, *next_fe;
 	u32 prev_ftid, next_ftid;
@@ -536,15 +536,24 @@ static bool cxgb4_filter_prio_in_range(struct tid_info *t, u32 idx, u8 nslots,
 	if (!prev_fe->fs.type)
 		prev_fe = &prev_tab[prev_ftid];
 
-	if ((prev_fe->valid && prev_fe->fs.tc_prio > prio) ||
-	    (next_fe->valid && next_fe->fs.tc_prio < prio))
+	/* Filters with different EtherTypes can never match the same
+	 * packet, so skip the priority check between them.
+	 */
+	if (prev_fe->valid && prev_fe->fs.tc_prio > prio &&
+	    (!prev_fe->fs.mask.ethtype || !ethtype ||
+	     prev_fe->fs.val.ethtype == ethtype))
+		return false;
+
+	if (next_fe->valid && next_fe->fs.tc_prio < prio &&
+	    (!next_fe->fs.mask.ethtype || !ethtype ||
+	     next_fe->fs.val.ethtype == ethtype))
 		return false;
 
 	return true;
 }
 
 int cxgb4_get_free_ftid(struct net_device *dev, u8 family, bool hash_en,
-			u32 tc_prio)
+			u32 tc_prio, u32 ethtype)
 {
 	struct adapter *adap = netdev2adap(dev);
 	struct tid_info *t = &adap->tids;
@@ -671,7 +680,7 @@ int cxgb4_get_free_ftid(struct net_device *dev, u8 family, bool hash_en,
 			 * with existing rules.
 			 */
 			if (cxgb4_filter_prio_in_range(t, ftid, n,
-						       tc_prio)) {
+						       tc_prio, ethtype)) {
 				ftid &= ~(n - 1);
 				found = true;
 				break;
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
index 41a2998ee2a0..754d9f5f0fe0 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
@@ -911,8 +911,8 @@ int cxgb4_flow_rule_replace(struct net_device *dev, struct flow_rule *rule,
 	 * rule. Only insert rule if its prio doesn't conflict with
 	 * existing rules.
 	 */
-	fidx = cxgb4_get_free_ftid(dev, inet_family, fs->hash,
-				   tc_prio);
+	fidx = cxgb4_get_free_ftid(dev, inet_family, fs->hash, tc_prio,
+				   fs->mask.ethtype ? fs->val.ethtype : 0);
 	if (fidx < 0) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "No free LETCAM index available");
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_matchall.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_matchall.c
index bc290430245e..bab263785082 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_matchall.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_matchall.c
@@ -312,7 +312,7 @@ static int cxgb4_matchall_add_filter(struct net_device *dev,
 	 * existing rules.
 	 */
 	fidx = cxgb4_get_free_ftid(dev, filter_type ? PF_INET6 : PF_INET,
-				   false, cls->common.prio);
+				   false, cls->common.prio, 0);
 	if (fidx < 0) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "No free LETCAM index available");
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32.c
index 1c1a7bc5a896..37a878f07f91 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32.c
@@ -174,7 +174,7 @@ int cxgb4_config_knode(struct net_device *dev, struct tc_cls_u32_offload *cls)
 	 * existing rules.
 	 */
 	filter_id = cxgb4_get_free_ftid(dev, inet_family, false,
-					TC_U32_NODE(cls->knode.handle));
+					TC_U32_NODE(cls->knode.handle), 0);
 	if (filter_id < 0) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "No free LETCAM index available");
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h
index d7713038386c..42efc239df88 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h
@@ -282,7 +282,7 @@ struct chcr_ktls {
 struct ch_filter_specification;
 
 int cxgb4_get_free_ftid(struct net_device *dev, u8 family, bool hash_en,
-			u32 tc_prio);
+			u32 tc_prio, u32 ethtype);
 int __cxgb4_set_filter(struct net_device *dev, int filter_id,
 		       struct ch_filter_specification *fs,
 		       struct filter_ctx *ctx);
-- 
2.43.0


