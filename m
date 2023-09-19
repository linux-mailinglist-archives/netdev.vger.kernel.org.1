Return-Path: <netdev+bounces-35090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0D17A6E87
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 00:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C182813C7
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 22:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0D63B2B4;
	Tue, 19 Sep 2023 22:15:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC803262A2
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 22:15:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808CD194
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 15:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695161713; x=1726697713;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tTL0xnUIPkKtZCuH2wBxZi5twyVq7GcgGEVQrcNRZlg=;
  b=SRYGFh7Z8j04l9OQVYaufRaESfny4MuzksFyf+1n6fo4G8ZtvfHxoID9
   9/bQQRHCuiaRPaALYBCiYuxP3z5UYUN2I6nphg1J6QFxC7HlUT9J4GU0j
   w1wzVqRA7vtE30jorRJbZOOZ7l4DmuE0NPhPSPOheH4KEvU34fh2paK6i
   I4nlFHQPEOANklAMEOElXlNBFy/blQyONVOEf0KNmJRuIA1Uu0bN/WM0l
   evuqEhkbutPkvykBLJU1EJ9OmHwGlqpkRMHLKRo+XGJntqmjojynkoO0j
   5YyDYblBAmaz1CqzpUCxW14O3zwHg0B+opRHFUb9w9FjXAtznOws4923v
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="383904104"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="383904104"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 15:12:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="781454097"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="781454097"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga001.jf.intel.com with ESMTP; 19 Sep 2023 15:12:38 -0700
Subject: [net-next PATCH v3 10/10] netdev-genl: Add PID for the NAPI thread
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Tue, 19 Sep 2023 15:28:07 -0700
Message-ID: <169516248742.7377.5244523678685955808.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169516206704.7377.12938469824609831999.stgit@anambiarhost.jf.intel.com>
References: <169516206704.7377.12938469824609831999.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In the threaded NAPI mode, expose the PID of the NAPI thread.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 net/core/netdev-genl.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 2b3818615e1b..369fc31a4599 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -152,6 +152,7 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			const struct genl_info *info)
 {
 	void *hdr;
+	pid_t pid;
 
 	if (WARN_ON_ONCE(!napi->dev))
 		return -EINVAL;
@@ -170,6 +171,12 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 	if (napi->irq >= 0 && nla_put_u32(rsp, NETDEV_A_NAPI_IRQ, napi->irq))
 		goto nla_put_failure;
 
+	if (napi->thread) {
+		pid = task_pid_nr(napi->thread);
+		if (nla_put_s32(rsp, NETDEV_A_NAPI_PID, pid))
+			goto nla_put_failure;
+	}
+
 	genlmsg_end(rsp, hdr);
 
 	return 0;


