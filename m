Return-Path: <netdev+bounces-36396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDF57AF7F7
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 04:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 1D4701C20A65
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 02:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F9A5255;
	Wed, 27 Sep 2023 02:03:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7A4C8F
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 02:02:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CDE1C26C;
	Tue, 26 Sep 2023 19:02:56 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="385565355"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="385565355"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 19:02:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="725628857"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="725628857"
Received: from pinksteam.jf.intel.com ([10.165.239.231])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 19:02:41 -0700
From: joao@overdrivepizza.com
To: pablo@netfilter.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joao@overdrivepizza.com
Cc: kadlec@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rkannoth@marvell.com,
	wojciech.drewek@intel.com,
	steen.hegenlund@microhip.com,
	keescook@chromium.org,
	Joao Moreira <joao.moreira@intel.com>
Subject: [PATCH v2 2/2] Make num_actions unsigned
Date: Tue, 26 Sep 2023 19:02:21 -0700
Message-ID: <20230927020221.85292-3-joao@overdrivepizza.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230927020221.85292-1-joao@overdrivepizza.com>
References: <20230927020221.85292-1-joao@overdrivepizza.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NEUTRAL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Joao Moreira <joao.moreira@intel.com>

Currently, in nft_flow_rule_create function, num_actions is a signed
integer. Yet, it is processed within a loop which increments its
value. To prevent an overflow from occurring, make it unsigned and
also check if it reaches UINT_MAX when being incremented.

After checking with maintainers, it was mentioned that front-end will
cap the num_actions value and that it is not possible to reach such
condition for an overflow. Yet, for correctness, it is still better to
fix this.

This issue was observed by the commit author while reviewing a write-up
regarding a CVE within the same subsystem [1].

1 - https://nickgregory.me/post/2022/03/12/cve-2022-25636/

Signed-off-by: Joao Moreira <joao.moreira@intel.com>
---
 net/netfilter/nf_tables_offload.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index 12ab78fa5d84..d25088791a74 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -90,7 +90,8 @@ struct nft_flow_rule *nft_flow_rule_create(struct net *net,
 {
 	struct nft_offload_ctx *ctx;
 	struct nft_flow_rule *flow;
-	int num_actions = 0, err;
+	unsigned int num_actions = 0;
+	int err;
 	struct nft_expr *expr;
 
 	expr = nft_expr_first(rule);
@@ -99,6 +100,9 @@ struct nft_flow_rule *nft_flow_rule_create(struct net *net,
 		    expr->ops->offload_action(expr))
 			num_actions++;
 
+		if (num_actions == UINT_MAX)
+			return ERR_PTR(-ENOMEM);
+
 		expr = nft_expr_next(expr);
 	}
 
-- 
2.42.0


