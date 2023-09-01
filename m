Return-Path: <netdev+bounces-31654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7731778F688
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 03:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E369281714
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 01:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9B810E9;
	Fri,  1 Sep 2023 01:04:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA4410E3
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 01:04:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAD5E0;
	Thu, 31 Aug 2023 18:04:33 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="375009822"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="375009822"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 18:04:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="733361463"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="733361463"
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
Subject: [PATCH 0/2] Prevent potential write out of bounds
Date: Thu, 31 Aug 2023 18:04:35 -0700
Message-ID: <20230901010437.126631-1-joao@overdrivepizza.com>
X-Mailer: git-send-email 2.41.0
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

The function flow_rule_alloc in net/core/flow_offload.c [2] gets an
unsigned int num_actions (line 10) and later traverses the actions in
the rule (line 24) setting hw.stats to FLOW_ACTION_HW_STATS_DONT_CARE.

Within the same file, the loop in the line 24 compares a signed int
(i) to an unsigned int (num_actions), and then uses i as an array
index. If an integer overflow happens, then the array within the loop
is wrongly indexed, causing a write out of bounds.

After checking with maintainers, it seems that the front-end caps the
maximum value of num_action, thus it is not possible to reach the given
write out of bounds, yet, still, to prevent disasters it is better to
fix the signedness here.

Similarly, also it is also good to ensure that an overflow won't happen
in net/netfilter/nf_tables_offload.c's function nft_flow_rule_create by
checking that num_actions is not negative.

Tks,

Joao Moreira (2):
  Make loop indexes unsigned
  Ensure num_actions is not a negative

 net/core/flow_offload.c           | 4 ++--
 net/netfilter/nf_tables_offload.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.41.0


