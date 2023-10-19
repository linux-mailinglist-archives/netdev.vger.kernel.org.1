Return-Path: <netdev+bounces-42456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 502B67CEC59
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 01:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2F9280FA0
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 23:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB1C46668;
	Wed, 18 Oct 2023 23:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDmggQ+N"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FBC1EB27
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 23:51:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DFA113
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 16:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697673062; x=1729209062;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1IMC3PdUiUX8T4WA6Sj1FO8MyKaO4rh4sCxoia6ubWM=;
  b=iDmggQ+NnLWD8WIXURN0T56iMbxZaMZiUe1pWHGziZX5plTJDC8I5sue
   +VyNH9EAVC8dZG8MN+fNswfA+UUYu63DTZ1SKHI5/6vA6S0U4P3ntKpm0
   Kwjv+XVrYUiaGhigvfhLnJLJHyw9oktddjQkqsIHlMqDNtqVV3i53A7c0
   Twjo/aIXW4W/DbHgmbwwdJfCr2kwKdGxN89bsXPGrPSnRGqFh8zBEpjiv
   oeCNW+kXkJEtMwUEZLwHwkb/9s4XjSnfoEXBWH6kHouS5+Y44t2XFAiAO
   Mg9nh7Qdjcydvbt7bfuo/Vv46ln2hDtdjsqhP+rF3OB2srRIej8kjdFSr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="366383259"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="366383259"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:51:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="847459729"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="847459729"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Oct 2023 16:51:02 -0700
Subject: [net-next PATCH v5 10/10] netdev-genl: Add PID for the NAPI thread
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Wed, 18 Oct 2023 17:06:55 -0700
Message-ID: <169767401536.6692.10530784084869425614.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169767295948.6692.18077536155633460138.stgit@anambiarhost.jf.intel.com>
References: <169767295948.6692.18077536155633460138.stgit@anambiarhost.jf.intel.com>
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
index ad4b1ee0a2d1..e05fbdac2a58 100644
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


