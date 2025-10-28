Return-Path: <netdev+bounces-233447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7527EC1363A
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 08:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11728566EB0
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 07:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1D6212FB9;
	Tue, 28 Oct 2025 07:54:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FFB7405A
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 07:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761638052; cv=none; b=VZ96yEdC4CDepFzRqtfEgctIB9rNsqllYs9EmZ3PSuGXl9yVnxV2w9YZaxVZOaOEdncjmvNPNSh6yTEHwpGNkVAoNM4RA48Yx6Gc/xTeiQDue2uM+T74E9BD+bhQEqpCpwwad2yS+VdmRFc/zuLfssJ7UFYZdzvGIOy2uQNCJlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761638052; c=relaxed/simple;
	bh=/nUgYEUyPA6TIENt//WlMDGNUaS7z9Hkn6eKAtIsvzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UnsqALwRFSeyftwU64qZbQNZwr/+cdbHPbyvPSPjo+rReuPuHvX5yELqcnykp/IVR3SU+fFQ0grRAJfrFaf5ODcYspqwTD022/BBD8cdpkVk1BUnMPkBD8dFgPPEsKBpBnIQf/ViGVSnYSm5vdSpTDgkAveGzJTuVBfBYdn/5Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from fcoeperf6.blr.asicdesigners.com (fcoeperf6.blr.asicdesigners.com [10.193.187.161])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 59S7re3J027682;
	Tue, 28 Oct 2025 00:53:41 -0700
From: Harshita V Rajput <harshitha.vr@chelsio.com>
To: kuba@kernel.org, davem@davemloft.net, kernelxing@tencent.com
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, Harshita V Rajput <harshitha.vr@chelsio.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH] cxgb4: flower: add support for fragmentation
Date: Tue, 28 Oct 2025 13:22:55 +0530
Message-ID: <20251028075255.1391596-1-harshitha.vr@chelsio.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for matching fragmented packets in tc flower
filters.

Previously, commit 93a8540aac72 ("cxgb4: flower: validate control flags")
added a check using flow_rule_match_has_control_flags() to reject
any rules with control flags, as the driver did not support
fragmentation at that time.

Now, with this patch, support for FLOW_DIS_IS_FRAGMENT is added:
- The driver checks for control flags using
  flow_rule_is_supp_control_flags(), as recommended in
  commit d11e63119432 ("flow_offload: add control flag checking helpers").
- If the fragmentation flag is present, the driver sets `fs->val.frag` and
  `fs->mask.frag` accordingly in the filter specification.

Since fragmentation is now supported, the earlier check that rejected all
control flags (flow_rule_match_has_control_flags()) has been removed.

Signed-off-by: Harshita V Rajput <harshitha.vr@chelsio.com>
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 .../ethernet/chelsio/cxgb4/cxgb4_tc_flower.c  | 40 +++++++++++--------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
index 0765d000eaef..e2b5554531b5 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
@@ -161,20 +161,9 @@ static struct ch_tc_flower_entry *ch_flower_lookup(struct adapter *adap,
 
 static void cxgb4_process_flow_match(struct net_device *dev,
 				     struct flow_rule *rule,
+				     u16 addr_type,
 				     struct ch_filter_specification *fs)
 {
-	u16 addr_type = 0;
-
-	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CONTROL)) {
-		struct flow_match_control match;
-
-		flow_rule_match_control(rule, &match);
-		addr_type = match.key->addr_type;
-	} else if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
-		addr_type = FLOW_DISSECTOR_KEY_IPV4_ADDRS;
-	} else if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV6_ADDRS)) {
-		addr_type = FLOW_DISSECTOR_KEY_IPV6_ADDRS;
-	}
 
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
 		struct flow_match_basic match;
@@ -327,9 +316,6 @@ static int cxgb4_validate_flow_match(struct netlink_ext_ack *extack,
 		return -EOPNOTSUPP;
 	}
 
-	if (flow_rule_match_has_control_flags(rule, extack))
-		return -EOPNOTSUPP;
-
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
 		struct flow_match_basic match;
 
@@ -858,6 +844,7 @@ int cxgb4_flow_rule_replace(struct net_device *dev, struct flow_rule *rule,
 {
 	struct adapter *adap = netdev2adap(dev);
 	struct filter_ctx ctx;
+	u16 addr_type = 0;
 	u8 inet_family;
 	int fidx, ret;
 
@@ -867,7 +854,28 @@ int cxgb4_flow_rule_replace(struct net_device *dev, struct flow_rule *rule,
 	if (cxgb4_validate_flow_match(extack, rule))
 		return -EOPNOTSUPP;
 
-	cxgb4_process_flow_match(dev, rule, fs);
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CONTROL)) {
+		struct flow_match_control match;
+
+		flow_rule_match_control(rule, &match);
+		addr_type = match.key->addr_type;
+
+		if (match.mask->flags & FLOW_DIS_IS_FRAGMENT) {
+			fs->val.frag = match.key->flags & FLOW_DIS_IS_FRAGMENT;
+			fs->mask.frag = true;
+		}
+
+		if (!flow_rule_is_supp_control_flags(FLOW_DIS_IS_FRAGMENT,
+						     match.mask->flags, extack))
+			return -EOPNOTSUPP;
+
+	} else if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
+		addr_type = FLOW_DISSECTOR_KEY_IPV4_ADDRS;
+	} else if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV6_ADDRS)) {
+		addr_type = FLOW_DISSECTOR_KEY_IPV6_ADDRS;
+	}
+
+	cxgb4_process_flow_match(dev, rule, addr_type, fs);
 	cxgb4_process_flow_actions(dev, &rule->action, fs);
 
 	fs->hash = is_filter_exact_match(adap, fs);
-- 
2.43.0


