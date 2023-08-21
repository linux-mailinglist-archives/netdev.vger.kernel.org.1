Return-Path: <netdev+bounces-29479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568E678362A
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 01:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D641C20A1E
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 23:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2B218AE1;
	Mon, 21 Aug 2023 23:10:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB701BF12
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 23:10:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D49B130
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 16:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692659451; x=1724195451;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OGRwt/afkyciGEHiVZ0pigIUDa54bQ+/IzJuRhPuc5g=;
  b=PskFao0pRzNkqkVQEhKjEySeh9n9ihm3lw90rQsrWx9OHM/RjHco2cQ6
   Ip+zajxxhRu06pCNyMFKGQmCNbLGeg8KS+onFxFZknDzTndTNw00TKvir
   9rpB0IRRTwpqkd7IIuOcZN8x10/4DCXHpEWqEH5YezXKSAOkuQ386ywEf
   +9kUzW/2pJrmSnTRQoc1zMiCNqKH0Bu2FiF9CNX7EBucw/6r3qmD8FQlR
   0OSwHPrFoIcchqppNMEAzqpv3USUWensZLuQ960EBiXnkQh+ALFEoyok7
   01IVJ8NzmA6WuKZa02gKZUcC4+QT3+Hwi2b1TE/n6+sXZeDBRfmE17CRx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="373698769"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="373698769"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 16:10:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="982647741"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="982647741"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga006.fm.intel.com with ESMTP; 21 Aug 2023 16:10:50 -0700
Subject: [net-next PATCH v2 9/9] netdev-genl: Add PID for the NAPI thread
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 21 Aug 2023 16:25:57 -0700
Message-ID: <169266035756.10199.12776067447174397659.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169266003844.10199.10450480941022607696.stgit@anambiarhost.jf.intel.com>
References: <169266003844.10199.10450480941022607696.stgit@anambiarhost.jf.intel.com>
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
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In the threaded NAPI mode, expose the PID of the NAPI thread.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 net/core/netdev-genl.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 63b8690d8ba3..47be577782e4 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -141,6 +141,7 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 	struct netdev_rx_queue *rx_queue, *rxq;
 	struct netdev_queue *tx_queue, *txq;
 	unsigned int rx_qid, tx_qid;
+	pid_t pid;
 	void *hdr;
 
 	if (!napi->dev)
@@ -171,6 +172,12 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 	if (napi->irq >= 0 && (nla_put_u32(rsp, NETDEV_A_NAPI_IRQ, napi->irq)))
 		goto nla_put_failure;
 
+	if (napi->thread) {
+		pid = task_pid_nr(napi->thread);
+		if (nla_put_s32(rsp, NETDEV_A_NAPI_PID, pid))
+			goto nla_put_failure;
+	}
+
 	genlmsg_end(rsp, hdr);
 
 	return 0;


