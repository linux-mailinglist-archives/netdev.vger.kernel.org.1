Return-Path: <netdev+bounces-151243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 585DE9EDA05
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 23:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B183188777E
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 22:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7567F204590;
	Wed, 11 Dec 2024 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ll/EvduN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5815E203D6F
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956363; cv=none; b=Z1oKb8Ls12IT5FAOG7yIwd7G9BSSs6H0pqN6gskLFO6+rjy58wxoHFAO2G45JoG2lzOxtZbinwHWxBv9K+KNEmby8Vy0OsJI7Yl0xf+VzlKHGAtOavH9pVWFHDP4k4lGZ2p41/YFwoqJHm5cFqLgjnL6p6waDKkGifPrKtAXCyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956363; c=relaxed/simple;
	bh=q5/jvoaAbVEVFmIuKVFj5pGMb4F+0KO21MYcpSLKILs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/vNzv6FQsy2eiIx8XX2PFCwAeComyR2L6NkpgEa6qI7nlvw/tvZ37D2X4S39gSSaS6OoPjf1a1Az9VC/g5MPCXwFn/+p6PfH2d20k7dAoT+PzDeSaTl2GrOQ2ope9in6wrhejU83H9CYFoqPDyZbukewZ6hlrZ5KpysTyGDLMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ll/EvduN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733956361; x=1765492361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q5/jvoaAbVEVFmIuKVFj5pGMb4F+0KO21MYcpSLKILs=;
  b=Ll/EvduNhQ9LzgUt6/Io5Ojwm+AuWXyHG/ntSKiPVDJI+mJm4dy3IIJ4
   GYvvVTowzrl2/ZFksKkMvEq09uxeBZHZXLMRdbiAskTxKGHVoxcQFMdb7
   5SHecTkuPvtVoLviAOrdF0sMIynrIjkeBZu6UEYSKNR7wI+ePpreA2PnA
   2yML6p440bsfeIPt4ec6XNOzc1QQiqOqv8blceC4o0BLOtPfpHyPleF90
   2tNzhloeZQOurHWAQoU2j3A5lsrkAiHrF1w7B8ayYWIQkG1LYBJrdpaj9
   /nNOYsjAiHx5jhm5Lw/cIWojRJ3zUYy9vL0y8Il1r3axT8hn1PN1PthUz
   w==;
X-CSE-ConnectionGUID: gHibzICZQX6Bs5nJYcfZ/A==
X-CSE-MsgGUID: ro3eMWB1SbiYaRE+6mqz5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34599620"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="34599620"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 14:32:39 -0800
X-CSE-ConnectionGUID: iPcNF0jYRaOKFgwvPL8bUQ==
X-CSE-MsgGUID: 7Jp5yDcOTiGV65R4XRGHRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="96192933"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 11 Dec 2024 14:32:39 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	wojciech.drewek@intel.com,
	joe@perches.com,
	horms@kernel.org,
	jiri@resnulli.us,
	apw@canonical.com,
	lukas.bulwahn@gmail.com,
	dwaipayanray1@gmail.com,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 3/7] devlink: add devlink_fmsg_dump_skb() function
Date: Wed, 11 Dec 2024 14:32:11 -0800
Message-ID: <20241211223231.397203-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241211223231.397203-1-anthony.l.nguyen@intel.com>
References: <20241211223231.397203-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Add devlink_fmsg_dump_skb() function that adds some diagnostic
information about skb (like length, pkt type, MAC, etc) to devlink
fmsg mechanism using bunch of devlink_fmsg_put() function calls.

Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 include/net/devlink.h |  2 ++
 net/devlink/health.c  | 67 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index b5e1427ea4d7..58e33959c852 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1268,6 +1268,7 @@ enum devlink_trap_group_generic_id {
 		u16 :		devlink_fmsg_u32_pair_put,	\
 		u32 :		devlink_fmsg_u32_pair_put,	\
 		u64 :		devlink_fmsg_u64_pair_put,	\
+		int :		devlink_fmsg_u32_pair_put,	\
 		char * :	devlink_fmsg_string_pair_put,	\
 		const char * :	devlink_fmsg_string_pair_put)	\
 	(fmsg, name, (value)))
@@ -2005,6 +2006,7 @@ int devlink_compat_switch_id_get(struct net_device *dev,
 
 int devlink_nl_port_handle_fill(struct sk_buff *msg, struct devlink_port *devlink_port);
 size_t devlink_nl_port_handle_size(struct devlink_port *devlink_port);
+void devlink_fmsg_dump_skb(struct devlink_fmsg *fmsg, const struct sk_buff *skb);
 
 #else
 
diff --git a/net/devlink/health.c b/net/devlink/health.c
index b8d3084e6fe0..57db6799722a 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -1238,3 +1238,70 @@ int devlink_nl_health_reporter_test_doit(struct sk_buff *skb,
 
 	return reporter->ops->test(reporter, info->extack);
 }
+
+/**
+ * devlink_fmsg_dump_skb - Dump sk_buffer structure
+ * @fmsg: devlink formatted message pointer
+ * @skb: pointer to skb
+ *
+ * Dump diagnostic information about sk_buff structure, like headroom, length,
+ * tailroom, MAC, etc.
+ */
+void devlink_fmsg_dump_skb(struct devlink_fmsg *fmsg, const struct sk_buff *skb)
+{
+	struct skb_shared_info *sh = skb_shinfo(skb);
+	struct sock *sk = skb->sk;
+	bool has_mac, has_trans;
+
+	has_mac = skb_mac_header_was_set(skb);
+	has_trans = skb_transport_header_was_set(skb);
+
+	devlink_fmsg_pair_nest_start(fmsg, "skb");
+	devlink_fmsg_obj_nest_start(fmsg);
+	devlink_fmsg_put(fmsg, "actual len", skb->len);
+	devlink_fmsg_put(fmsg, "head len", skb_headlen(skb));
+	devlink_fmsg_put(fmsg, "data len", skb->data_len);
+	devlink_fmsg_put(fmsg, "tail len", skb_tailroom(skb));
+	devlink_fmsg_put(fmsg, "MAC", has_mac ? skb->mac_header : -1);
+	devlink_fmsg_put(fmsg, "MAC len",
+			 has_mac ? skb_mac_header_len(skb) : -1);
+	devlink_fmsg_put(fmsg, "network hdr", skb->network_header);
+	devlink_fmsg_put(fmsg, "network hdr len",
+			 has_trans ? skb_network_header_len(skb) : -1);
+	devlink_fmsg_put(fmsg, "transport hdr",
+			 has_trans ? skb->transport_header : -1);
+	devlink_fmsg_put(fmsg, "csum", (__force u32)skb->csum);
+	devlink_fmsg_put(fmsg, "csum_ip_summed", (u8)skb->ip_summed);
+	devlink_fmsg_put(fmsg, "csum_complete_sw", !!skb->csum_complete_sw);
+	devlink_fmsg_put(fmsg, "csum_valid", !!skb->csum_valid);
+	devlink_fmsg_put(fmsg, "csum_level", (u8)skb->csum_level);
+	devlink_fmsg_put(fmsg, "sw_hash", !!skb->sw_hash);
+	devlink_fmsg_put(fmsg, "l4_hash", !!skb->l4_hash);
+	devlink_fmsg_put(fmsg, "proto", ntohs(skb->protocol));
+	devlink_fmsg_put(fmsg, "pkt_type", (u8)skb->pkt_type);
+	devlink_fmsg_put(fmsg, "iif", skb->skb_iif);
+
+	if (sk) {
+		devlink_fmsg_pair_nest_start(fmsg, "sk");
+		devlink_fmsg_obj_nest_start(fmsg);
+		devlink_fmsg_put(fmsg, "family", sk->sk_type);
+		devlink_fmsg_put(fmsg, "type", sk->sk_type);
+		devlink_fmsg_put(fmsg, "proto", sk->sk_protocol);
+		devlink_fmsg_obj_nest_end(fmsg);
+		devlink_fmsg_pair_nest_end(fmsg);
+	}
+
+	devlink_fmsg_obj_nest_end(fmsg);
+	devlink_fmsg_pair_nest_end(fmsg);
+
+	devlink_fmsg_pair_nest_start(fmsg, "shinfo");
+	devlink_fmsg_obj_nest_start(fmsg);
+	devlink_fmsg_put(fmsg, "tx_flags", sh->tx_flags);
+	devlink_fmsg_put(fmsg, "nr_frags", sh->nr_frags);
+	devlink_fmsg_put(fmsg, "gso_size", sh->gso_size);
+	devlink_fmsg_put(fmsg, "gso_type", sh->gso_type);
+	devlink_fmsg_put(fmsg, "gso_segs", sh->gso_segs);
+	devlink_fmsg_obj_nest_end(fmsg);
+	devlink_fmsg_pair_nest_end(fmsg);
+}
+EXPORT_SYMBOL_GPL(devlink_fmsg_dump_skb);
-- 
2.42.0


