Return-Path: <netdev+bounces-47554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814287EA754
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 01:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D2728101F
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C980C63E;
	Tue, 14 Nov 2023 00:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uy0i2vPR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E9F10EB
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 00:14:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598B9D45
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 16:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699920853; x=1731456853;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FEMDWeqMRLy2qHRVTNm5t9Xs3E/bsV3tQjwruXxAB04=;
  b=Uy0i2vPR19TAOjc19P/+audBL0gzqI65m2bN0XTYBYevshEeUj84sTN7
   PSHvmdyAhB4B32qq/GoK59y4pTytC9v+TwlX+VayMDRsCFfObz54e02YS
   WWBhjofHm03GUvTtxl2VlMtjPeg2nJ47Q1D2u9LBXsUrnImKWsdBFCgH+
   nJ4wwt/r1mLb0s1ToG2OoSAPsHzDhU3D684iKLzS/kJPuxEvGNN3CZXCU
   rmEzZiDEd/LLZtMrTtRaCKrYkXjDFwnVn3crct056Tfot13FgUYDZo1bx
   4uk7KP0rSJ4MZ7wvoSi5DAs79VVHN98V6jgDS3PvcjNLiKxL70yO/TEbb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="421640903"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="421640903"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 16:14:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="888065214"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="888065214"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga004.jf.intel.com with ESMTP; 13 Nov 2023 16:14:12 -0800
Subject: [net-next PATCH v7 10/10] netdev-genl: Add PID for the NAPI thread
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 13 Nov 2023 16:30:27 -0800
Message-ID: <169992182753.3867.14284211374242186423.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169992138566.3867.856803351434134324.stgit@anambiarhost.jf.intel.com>
References: <169992138566.3867.856803351434134324.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

In the threaded NAPI mode, expose the PID of the NAPI thread.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 net/core/netdev-genl.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 6ea0a1f441f0..187c2f85c55c 100644
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
+		if (nla_put_u32(rsp, NETDEV_A_NAPI_PID, pid))
+			goto nla_put_failure;
+	}
+
 	genlmsg_end(rsp, hdr);
 
 	return 0;


