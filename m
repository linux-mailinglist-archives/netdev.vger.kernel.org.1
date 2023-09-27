Return-Path: <netdev+bounces-36395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20FB7AF7F8
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 04:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8FC63281F6A
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 02:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006595227;
	Wed, 27 Sep 2023 02:02:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6CA4C8B
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 02:02:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1631C26B;
	Tue, 26 Sep 2023 19:02:55 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="385565342"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="385565342"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 19:02:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="725628836"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="725628836"
Received: from pinksteam.jf.intel.com ([10.165.239.231])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 19:02:39 -0700
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
Subject: [PATCH v2 1/2] Make loop indexes unsigned
Date: Tue, 26 Sep 2023 19:02:20 -0700
Message-ID: <20230927020221.85292-2-joao@overdrivepizza.com>
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

Both flow_rule_alloc and offload_action_alloc functions received an
unsigned num_actions parameters which are then operated within a loop.
The index of this loop is declared as a signed int. If it was possible
to pass a large enough num_actions to these functions, it would lead to
an out of bounds write.

After checking with maintainers, it was mentioned that front-end will
cap the num_actions value and that it is not possible to reach this
function with such a large number. Yet, for correctness, it is still
better to fix this.

This issue was observed by the commit author while reviewing a write-up
regarding a CVE within the same subsystem [1].

1 - https://nickgregory.me/post/2022/03/12/cve-2022-25636/

Signed-off-by: Joao Moreira <joao.moreira@intel.com>
---
 net/core/flow_offload.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/flow_offload.c b/net/core/flow_offload.c
index bc5169482710..bc3f53a09d8f 100644
--- a/net/core/flow_offload.c
+++ b/net/core/flow_offload.c
@@ -10,7 +10,7 @@
 struct flow_rule *flow_rule_alloc(unsigned int num_actions)
 {
 	struct flow_rule *rule;
-	int i;
+	unsigned int i;
 
 	rule = kzalloc(struct_size(rule, action.entries, num_actions),
 		       GFP_KERNEL);
@@ -31,7 +31,7 @@ EXPORT_SYMBOL(flow_rule_alloc);
 struct flow_offload_action *offload_action_alloc(unsigned int num_actions)
 {
 	struct flow_offload_action *fl_action;
-	int i;
+	unsigned int i;
 
 	fl_action = kzalloc(struct_size(fl_action, action.entries, num_actions),
 			    GFP_KERNEL);
-- 
2.42.0


