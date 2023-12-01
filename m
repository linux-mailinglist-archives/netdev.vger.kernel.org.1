Return-Path: <netdev+bounces-53149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A210B80175B
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 00:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C816281E3C
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4048B3F8D5;
	Fri,  1 Dec 2023 23:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aouc4bxo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691C710FF
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 15:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701472369; x=1733008369;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1+3nabDGChWCJsUj9P8JjMPNfsjUWo3SuvD/BldB78Q=;
  b=Aouc4bxoL6UzW6ebhSzwxYrL5NYfqaD6oabQX6EMO/B5i5dME5a5u5J2
   v0s4VXcSPtUX6Lc/10SaTV4LUeEJjvaMT8T6HeP+s9/cl2VeFdbQzQ90e
   HZe0+sTaSXfAIz4csk2E2+tI4bdrbdYizZWsO0091A65eqJGHcxnfmu3L
   hTV+WXfWBBA1WlvhCxe3pBoorh/SewZ02L/+mFH2A71UGSf1jTivAuZ5u
   2fRx/zrs3kClsBA0mQGPtHNV3L3eKwg05iSl2/wcv38iihdT5tILwMfMl
   WwDckIjiIC5USNe9Y3s1qJow/qwmXwFhZJUAF5aRWAKfqXwcoYEZ+fULR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="458522"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="458522"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 15:12:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="943228665"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="943228665"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga005.jf.intel.com with ESMTP; 01 Dec 2023 15:12:48 -0800
Subject: [net-next PATCH v11 10/11] netdev-genl: Add PID for the NAPI thread
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: edumazet@google.com, ast@kernel.org, sdf@google.com, lorenzo@kernel.org,
 tariqt@nvidia.com, daniel@iogearbox.net, anthony.l.nguyen@intel.com,
 lucien.xin@gmail.com, michael.chan@broadcom.com, hawk@kernel.org,
 sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Fri, 01 Dec 2023 15:29:18 -0800
Message-ID: <170147335818.5260.10253384006102593087.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <170147307026.5260.9300080745237900261.stgit@anambiarhost.jf.intel.com>
References: <170147307026.5260.9300080745237900261.stgit@anambiarhost.jf.intel.com>
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
index 9753c19e36de..fd98936da3ae 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -163,6 +163,7 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			const struct genl_info *info)
 {
 	void *hdr;
+	pid_t pid;
 
 	if (WARN_ON_ONCE(!napi->dev))
 		return -EINVAL;
@@ -183,6 +184,12 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
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


