Return-Path: <netdev+bounces-31655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A060478F68C
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 03:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C926D1C20B2D
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 01:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC4615B2;
	Fri,  1 Sep 2023 01:04:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DB415A6
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 01:04:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE74E6A;
	Thu, 31 Aug 2023 18:04:34 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="375009845"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="375009845"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 18:04:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="733361469"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="733361469"
Received: from pinksteam.jf.intel.com ([10.165.239.231])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 18:04:31 -0700
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
Subject: [PATCH 2/2] Ensure num_actions is not a negative
Date: Thu, 31 Aug 2023 18:04:37 -0700
Message-ID: <20230901010437.126631-3-joao@overdrivepizza.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901010437.126631-1-joao@overdrivepizza.com>
References: <20230901010437.126631-1-joao@overdrivepizza.com>
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

In nft_flow_rule_create function, num_actions is a signed integer. Yet,
it is processed within a loop which increments its value. To prevent an
overflow from occurring, check if num_actions is not only equal to 0,
but also not negative.

After checking with maintainers, it was mentioned that front-end will
cap the num_actions vlaue and that it is not possible to reach such
condition for an overflow. Yet, for correctness, it is still better to
fix this.

Signed-off-by: Joao Moreira <joao.moreira@intel.com>
---
 net/netfilter/nf_tables_offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index 12ab78fa5d84..20dbc95de895 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -102,7 +102,7 @@ struct nft_flow_rule *nft_flow_rule_create(struct net *net,
 		expr = nft_expr_next(expr);
 	}
 
-	if (num_actions == 0)
+	if (num_actions <= 0)
 		return ERR_PTR(-EOPNOTSUPP);
 
 	flow = nft_flow_rule_alloc(num_actions);
-- 
2.41.0


