Return-Path: <netdev+bounces-56451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6493880EECD
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 15:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1C61F2139D
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 14:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C0C745C3;
	Tue, 12 Dec 2023 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDNZRE1C"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016D98E;
	Tue, 12 Dec 2023 06:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702391392; x=1733927392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tC4nqzPPkN2y5U1+kXQLWaCibaTxMNcqk0oLrJfP9KY=;
  b=SDNZRE1C0WvK46b1KUE5s0Pfy7LIkGGIWaFRiu8LUECAFzGtqNAKJMGk
   ASeCbFD8tKUJKqdw8/4kXTaJ/CaXp1SsZtJg2koM0d/IGl4dGImUmP7Po
   f+I/pFQ1oHGvTUkmmAsEVHXdZE4Y7gqFgcHtt1DqSuUZzH896ef6AlitA
   CAhudX3Eqy0qYm5DwTgPDThII7u8j99gE/Lx2KfINFWK+VMyV1zc0SyFz
   JUawTzroU+8DXYwwq+MjUUvI4s57sHpsVKTk8uClDCnnOsaqej6aTEJYf
   uXcqV5/jdvb/PJsq3QimdhXvd/l/x8HoJEUeRh1ea/Gwj/2PzSE+9b4bY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1887348"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="1887348"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 06:29:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1104923746"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="1104923746"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga005.fm.intel.com with ESMTP; 12 Dec 2023 06:29:48 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Michal Kubecek <mkubecek@suse.cz>,
	Jiri Pirko <jiri@resnulli.us>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] ethtool: add SET for TCP_DATA_SPLIT ringparam
Date: Tue, 12 Dec 2023 15:27:51 +0100
Message-ID: <20231212142752.935000-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231212142752.935000-1-aleksander.lobakin@intel.com>
References: <20231212142752.935000-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow up commit 9690ae604290 ("ethtool: add header/data split
indication") and add the set part of Ethtool's header split, i.e.
ability to enable/disable header split via the Ethtool Netlink
interface. This might be helpful to optimize the setup for particular
workloads, for example, to avoid XDP frags, and so on.
A driver should advertise ``ETHTOOL_RING_USE_TCP_DATA_SPLIT`` in its
ops->supported_ring_params to allow doing that. "Unknown" passed from
the userspace when the header split is supported means the driver is
free to choose the preferred state.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/ethtool.h |  2 ++
 net/ethtool/rings.c     | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index deb683d3360f..67b30940234b 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -95,6 +95,7 @@ struct kernel_ethtool_ringparam {
  * @ETHTOOL_RING_USE_TX_PUSH: capture for setting tx_push
  * @ETHTOOL_RING_USE_RX_PUSH: capture for setting rx_push
  * @ETHTOOL_RING_USE_TX_PUSH_BUF_LEN: capture for setting tx_push_buf_len
+ * @ETHTOOL_RING_USE_TCP_DATA_SPLIT: capture for setting tcp_data_split
  */
 enum ethtool_supported_ring_param {
 	ETHTOOL_RING_USE_RX_BUF_LEN		= BIT(0),
@@ -102,6 +103,7 @@ enum ethtool_supported_ring_param {
 	ETHTOOL_RING_USE_TX_PUSH		= BIT(2),
 	ETHTOOL_RING_USE_RX_PUSH		= BIT(3),
 	ETHTOOL_RING_USE_TX_PUSH_BUF_LEN	= BIT(4),
+	ETHTOOL_RING_USE_TCP_DATA_SPLIT		= BIT(5),
 };
 
 #define __ETH_RSS_HASH_BIT(bit)	((u32)1 << (bit))
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index fb09f774ea01..b7865a14fdf8 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -124,6 +124,8 @@ const struct nla_policy ethnl_rings_set_policy[] = {
 	[ETHTOOL_A_RINGS_RX_JUMBO]		= { .type = NLA_U32 },
 	[ETHTOOL_A_RINGS_TX]			= { .type = NLA_U32 },
 	[ETHTOOL_A_RINGS_RX_BUF_LEN]            = NLA_POLICY_MIN(NLA_U32, 1),
+	[ETHTOOL_A_RINGS_TCP_DATA_SPLIT]	=
+		NLA_POLICY_MAX(NLA_U8, ETHTOOL_TCP_DATA_SPLIT_ENABLED),
 	[ETHTOOL_A_RINGS_CQE_SIZE]		= NLA_POLICY_MIN(NLA_U32, 1),
 	[ETHTOOL_A_RINGS_TX_PUSH]		= NLA_POLICY_MAX(NLA_U8, 1),
 	[ETHTOOL_A_RINGS_RX_PUSH]		= NLA_POLICY_MAX(NLA_U8, 1),
@@ -145,6 +147,14 @@ ethnl_set_rings_validate(struct ethnl_req_info *req_info,
 		return -EOPNOTSUPP;
 	}
 
+	if (tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT] &&
+	    !(ops->supported_ring_params & ETHTOOL_RING_USE_TCP_DATA_SPLIT)) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT],
+				    "setting TCP data split is not supported");
+		return -EOPNOTSUPP;
+	}
+
 	if (tb[ETHTOOL_A_RINGS_CQE_SIZE] &&
 	    !(ops->supported_ring_params & ETHTOOL_RING_USE_CQE_SIZE)) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
@@ -202,6 +212,8 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 	ethnl_update_u32(&ringparam.tx_pending, tb[ETHTOOL_A_RINGS_TX], &mod);
 	ethnl_update_u32(&kernel_ringparam.rx_buf_len,
 			 tb[ETHTOOL_A_RINGS_RX_BUF_LEN], &mod);
+	ethnl_update_u8(&kernel_ringparam.tcp_data_split,
+			tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT], &mod);
 	ethnl_update_u32(&kernel_ringparam.cqe_size,
 			 tb[ETHTOOL_A_RINGS_CQE_SIZE], &mod);
 	ethnl_update_u8(&kernel_ringparam.tx_push,
-- 
2.43.0


