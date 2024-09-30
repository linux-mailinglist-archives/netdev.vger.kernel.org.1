Return-Path: <netdev+bounces-130389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAC298A582
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8800C1F246C1
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C234B191F61;
	Mon, 30 Sep 2024 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pv5JBnRu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148571917FE;
	Mon, 30 Sep 2024 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703560; cv=none; b=rc9RkYUAYtfZlvhZJud4hCQibAvTdblyPC70c5PiKFJdWA44bd/Ivu6tOJ0wMzIBy83sUuR/a5QihTq0wu2yywgwALm5FDc4NMPcw9wfV6BH2OFmvOhw0BCCDZ3pJxc6AsXO7uiFn69XVi7M/QlUsWVxH1YmtbfTNd9Toyk+2D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703560; c=relaxed/simple;
	bh=96Ef9ZUCJFyA404S4Dx1uLHxi8lVp3eys4W081XNkGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BI04A694IXh1PKaX4uadtgjdeZA5eFxtA6ErjVFc+pESBvqtecYfA0a5+efoeQwHt13USdVqYzBd7aYmhynXjbcd9pPCsmna8si+IufmDDdb5xjhDIpT16R1Hxr70KjYKL/wbvPi624jG5n+4bVDmaeyoSjiswBwr3vDMgxbEAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pv5JBnRu; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727703559; x=1759239559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=96Ef9ZUCJFyA404S4Dx1uLHxi8lVp3eys4W081XNkGs=;
  b=Pv5JBnRu0yYBLNHlv5UtifD5MLIWd8GOMjrmcUmajA38+YNGIcoACkGc
   QcPl9sVF/TPty7I4B4BkuN5Au2mqsMwhRykOfY6m82uMJDtPFn/pMYG6V
   bBb39ti5lJt/7kAayF8wTGuqakmf+TfJG/VFJWEBsBYIXmO6yYl5YfPvG
   yVgKTqFGADL1Ef3UqzHdxdQyN6d3YHpsKQasMjeHtdWpjyAljDNYZ9B2h
   t/WNl8vzZW+rMrY7q7OxW/08UO4bTdOWhTytIw8z9C2rUQT9oP2CqBUNs
   9TmPtN+3R/hDcYy7//ghpAIxpf5RsCPgtuV+qdWPU8baSMUUAaz9AIOwv
   w==;
X-CSE-ConnectionGUID: wwKatH+KTEGnxeY/mCo6RA==
X-CSE-MsgGUID: +3pTTiReRlmHQUNqlWj55A==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26600995"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26600995"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 06:39:18 -0700
X-CSE-ConnectionGUID: CwbcORSOSgyNIn+abgkOaw==
X-CSE-MsgGUID: ZzwVvQa7SDeuYgN0ZPQDOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="104109626"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 30 Sep 2024 06:39:15 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 6918C28169;
	Mon, 30 Sep 2024 14:39:13 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH 3/7] devlink: add devlink_fmsg_dump_skb() function
Date: Mon, 30 Sep 2024 15:37:20 +0200
Message-Id: <20240930133724.610512-4-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240930133724.610512-1-przemyslaw.kitszel@intel.com>
References: <20240930133724.610512-1-przemyslaw.kitszel@intel.com>
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
---
 include/net/devlink.h |  2 ++
 net/devlink/health.c  | 67 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 85739bb731c1..7f5b36554778 100644
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
@@ -2018,6 +2019,7 @@ int devlink_compat_switch_id_get(struct net_device *dev,
 
 int devlink_nl_port_handle_fill(struct sk_buff *msg, struct devlink_port *devlink_port);
 size_t devlink_nl_port_handle_size(struct devlink_port *devlink_port);
+void devlink_fmsg_dump_skb(struct devlink_fmsg *fmsg, const struct sk_buff *skb);
 
 #else
 
diff --git a/net/devlink/health.c b/net/devlink/health.c
index acb8c0e174bb..b98ca650284c 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -1241,3 +1241,70 @@ int devlink_nl_health_reporter_test_doit(struct sk_buff *skb,
 
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
+	devlink_fmsg_put(fmsg, "csum", skb->csum);
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
2.39.3


