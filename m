Return-Path: <netdev+bounces-115477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EAE946769
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 06:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50DF81C20C7A
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 04:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D57176036;
	Sat,  3 Aug 2024 04:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQrkZD6h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBA413AA45
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 04:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722659218; cv=none; b=P24i7fkm8479SRHAEfvnh/2qjiLNBvBCdRM0RTWDeeTQXKF9kiodRMUvyUQRgjAT9xZfsrvQVT4llJHG3y1euBGsjzg15PKMuHkQDv5IBd/+Ss1jcFi00hy/4H+bqsbfjckzzZHD3kzpKWF1wsvslneA/VrkmJHKQPooxlKDVkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722659218; c=relaxed/simple;
	bh=cyUTzafVte4Ok26ws+m3VmOISRt34XVwsM/b2oWy5Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpiAYFQvvNpw1aKfDUQPc6iC9rN0LcPUaksbBSblQLF3shbyVf9I99uoiCI8djZcHRP95iDuMrQqrk0I5zRrbtZldUOeNYSUPVW3+RkDpp7vZYQaGHr68NtX94vrfqMPK0Z5aGJROLW3nfWHP/rTOOL4iNeZncUEKUBDd/hHvQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQrkZD6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D2AC4AF0B;
	Sat,  3 Aug 2024 04:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722659217;
	bh=cyUTzafVte4Ok26ws+m3VmOISRt34XVwsM/b2oWy5Ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EQrkZD6h2+YJX+cWeiJLFpSoJFBGJ8mw+h/zuAAu/LuuVZVdBPrLQbhI/dsAD5J4Z
	 etM+/4RRgl9/ujCzXlTY6SYPMGh4Flt3c/RrR617zTmHwQBbVvzYd+ySsVQLkP8W3V
	 yQtbpfIWjgsazZNqk1NpCLxFzWqj/Wh9W5hde4EjIpnJxAKtldQMmEBVZzvf5XaQyf
	 UpCWXuqLyRRbygVCIXdP7S0ysTacBVNSq7WEPFv/GcqmfKh8wEu6xWSpLqqCHV9K6w
	 itGiaVSwI9N0XhQJrmhb85EP5afvc9NplV0j+zSwdRat6sZyFtUAEWid7AL5YAoCaB
	 8oRYBYiwg7Q6Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dxu@dxuuu.xyz,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	donald.hunter@gmail.com,
	gal.pressman@linux.dev,
	tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 10/12] ethtool: rss: support skipping contexts during dump
Date: Fri,  2 Aug 2024 21:26:22 -0700
Message-ID: <20240803042624.970352-11-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803042624.970352-1-kuba@kernel.org>
References: <20240803042624.970352-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Applications may want to deal with dynamic RSS contexts only.
So dumping context 0 will be counter-productive for them.
Support starting the dump from a given context ID.

Alternative would be to implement a dump flag to skip just
context 0, not sure which is better...

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/ethtool.yaml     |  4 ++++
 Documentation/networking/ethtool-netlink.rst | 12 ++++++++++--
 include/uapi/linux/ethtool_netlink.h         |  1 +
 net/ethtool/netlink.h                        |  2 +-
 net/ethtool/rss.c                            | 12 +++++++++++-
 5 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index cf69eedae51d..4c2334c213b0 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1028,6 +1028,9 @@ doc: Partial family for Ethtool Netlink.
       -
         name: input_xfrm
         type: u32
+      -
+        name: start-context
+        type: u32
   -
     name: plca
     attributes:
@@ -1766,6 +1769,7 @@ doc: Partial family for Ethtool Netlink.
         request:
           attributes:
             - header
+            - start-context
         reply: *rss-reply
     -
       name: plca-get-cfg
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index d5f246aceb9f..82c5542c80ce 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1866,10 +1866,18 @@ RSS context of an interface similar to ``ETHTOOL_GRSSH`` ioctl request.
 
 Request contents:
 
-=====================================  ======  ==========================
+=====================================  ======  ============================
   ``ETHTOOL_A_RSS_HEADER``             nested  request header
   ``ETHTOOL_A_RSS_CONTEXT``            u32     context number
-=====================================  ======  ==========================
+  ``ETHTOOL_A_RSS_START_CONTEXT``      u32     start context number (dumps)
+=====================================  ======  ============================
+
+``ETHTOOL_A_RSS_CONTEXT`` specifies which RSS context number to query,
+if not set context 0 (the main context) is queried. Dumps can be filtered
+by device (only listing contexts of a given netdev). Filtering single
+context number is not supported but ``ETHTOOL_A_RSS_START_CONTEXT``
+can be used to start dumping context from the given number (primarily
+used to ignore context 0s and only dump additional contexts).
 
 Kernel response contents:
 
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 6d5bdcc67631..93c57525a975 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -965,6 +965,7 @@ enum {
 	ETHTOOL_A_RSS_INDIR,		/* binary */
 	ETHTOOL_A_RSS_HKEY,		/* binary */
 	ETHTOOL_A_RSS_INPUT_XFRM,	/* u32 */
+	ETHTOOL_A_RSS_START_CONTEXT,	/* u32 */
 
 	__ETHTOOL_A_RSS_CNT,
 	ETHTOOL_A_RSS_MAX = (__ETHTOOL_A_RSS_CNT - 1),
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 919371383b23..236c189fc968 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -449,7 +449,7 @@ extern const struct nla_policy ethnl_module_get_policy[ETHTOOL_A_MODULE_HEADER +
 extern const struct nla_policy ethnl_module_set_policy[ETHTOOL_A_MODULE_POWER_MODE_POLICY + 1];
 extern const struct nla_policy ethnl_pse_get_policy[ETHTOOL_A_PSE_HEADER + 1];
 extern const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1];
-extern const struct nla_policy ethnl_rss_get_policy[ETHTOOL_A_RSS_CONTEXT + 1];
+extern const struct nla_policy ethnl_rss_get_policy[ETHTOOL_A_RSS_START_CONTEXT + 1];
 extern const struct nla_policy ethnl_plca_get_cfg_policy[ETHTOOL_A_PLCA_HEADER + 1];
 extern const struct nla_policy ethnl_plca_set_cfg_policy[ETHTOOL_A_PLCA_MAX + 1];
 extern const struct nla_policy ethnl_plca_get_status_policy[ETHTOOL_A_PLCA_HEADER + 1];
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 62e7b6fe605d..659468965de7 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -28,6 +28,7 @@ struct rss_reply_data {
 const struct nla_policy ethnl_rss_get_policy[] = {
 	[ETHTOOL_A_RSS_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
 	[ETHTOOL_A_RSS_CONTEXT] = { .type = NLA_U32 },
+	[ETHTOOL_A_RSS_START_CONTEXT] = { .type = NLA_U32 },
 };
 
 static int
@@ -38,6 +39,10 @@ rss_parse_request(struct ethnl_req_info *req_info, struct nlattr **tb,
 
 	if (tb[ETHTOOL_A_RSS_CONTEXT])
 		request->rss_context = nla_get_u32(tb[ETHTOOL_A_RSS_CONTEXT]);
+	if (tb[ETHTOOL_A_RSS_START_CONTEXT]) {
+		NL_SET_BAD_ATTR(extack, tb[ETHTOOL_A_RSS_START_CONTEXT]);
+		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -213,6 +218,7 @@ struct rss_nl_dump_ctx {
 	unsigned long		ctx_idx;
 
 	unsigned int		one_ifindex;
+	unsigned int		start_ctx;
 };
 
 static struct rss_nl_dump_ctx *rss_dump_ctx(struct netlink_callback *cb)
@@ -235,6 +241,10 @@ int ethnl_rss_dump_start(struct netlink_callback *cb)
 		NL_SET_BAD_ATTR(info->extack, tb[ETHTOOL_A_RSS_CONTEXT]);
 		return -EINVAL;
 	}
+	if (tb[ETHTOOL_A_RSS_START_CONTEXT]) {
+		ctx->start_ctx = nla_get_u32(tb[ETHTOOL_A_RSS_START_CONTEXT]);
+		ctx->ctx_idx = ctx->start_ctx;
+	}
 
 	ret = ethnl_parse_header_dev_get(&req_info,
 					 tb[ETHTOOL_A_RSS_HEADER],
@@ -315,7 +325,7 @@ rss_dump_one_dev(struct sk_buff *skb, struct netlink_callback *cb,
 		if (ret)
 			return ret;
 	}
-	ctx->ctx_idx = 0;
+	ctx->ctx_idx = ctx->start_ctx;
 
 	return 0;
 }
-- 
2.45.2


