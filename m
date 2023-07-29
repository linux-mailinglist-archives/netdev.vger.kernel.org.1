Return-Path: <netdev+bounces-22486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 918DA7679A3
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 02:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C958C2828D3
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 00:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4912389;
	Sat, 29 Jul 2023 00:32:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F247C
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 00:32:52 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D682135
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 17:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690590771; x=1722126771;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MQXLUmc+tBe1giHyCfOBX9wafJYsxG10XeXcCZFyB+A=;
  b=h3w9hokWEszRZ7X4krhSxtHSo64Gu4pEoz3xVpj7HpkvZUe7O14Fc8yY
   TH1r1XQ2de87Kf7IG0eWiZqIX3osyboJunTPdC1fYFhmGiUXceqaiaxfT
   hGWlCNAgBscT1ftpZLtArlQBQq6blT2E8V2o2/UoTfD6aSLPrL5NirDnd
   P1a7FnnV7am79ZRsuzpHxJj7HJOgBNCSWh9cqmK0HyOywxzdCy7RHw3hY
   X70LGEkVsZdY0MCIAA8mfHmDAYncGfAKRsoKwco29MoHumTbvPUWyXQID
   sYyBWUc3EF6SoMQ7oyn1Gy6dTZuwxzxkzxh10AQ0FZG4HWqXebuQDlXFA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="435001873"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="435001873"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 17:32:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="974255924"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="974255924"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jul 2023 17:32:50 -0700
Subject: [net-next PATCH v1 9/9] netdev-genl: Add PID for the NAPI thread
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Fri, 28 Jul 2023 17:47:38 -0700
Message-ID: <169059165828.3736.1595843116804085813.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
References: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In the threaded NAPI mode, expose the PID of the NAPI thread.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 net/core/netdev-genl.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 8401f646a10b..60af99ffb9ec 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -141,6 +141,7 @@ netdev_nl_napi_fill_one(struct sk_buff *msg, struct napi_struct *napi)
 	struct netdev_queue *tx_queue, *txq;
 	unsigned int rx_qid, tx_qid;
 	struct nlattr *napi_info;
+	pid_t pid;
 
 	napi_info = nla_nest_start(msg, NETDEV_A_NAPI_NAPI_INFO);
 	if (!napi_info)
@@ -165,6 +166,12 @@ netdev_nl_napi_fill_one(struct sk_buff *msg, struct napi_struct *napi)
 		if (nla_put_u32(msg, NETDEV_A_NAPI_INFO_ENTRY_IRQ, napi->irq))
 			goto nla_put_failure;
 
+	if (napi->thread) {
+		pid = task_pid_nr(napi->thread);
+		if (nla_put_s32(msg, NETDEV_A_NAPI_INFO_ENTRY_PID, pid))
+			goto nla_put_failure;
+	}
+
 	nla_nest_end(msg, napi_info);
 	return 0;
 nla_put_failure:


