Return-Path: <netdev+bounces-51551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E973A7FB076
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 04:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B36CB2115D
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 03:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EB5883E;
	Tue, 28 Nov 2023 03:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XpsUw0Dm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5129C1A7
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 19:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701142434; x=1732678434;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kBfnDMj0eLuxkcItt0ZPkHag/uxwbD9FO0IpFVBpcBk=;
  b=XpsUw0DmBUxdXHwNFwoPcb6nEjlOI46atEpLP2dKxD4POdKOVQk0d7XS
   1FENU4bve8iQC10tGri2uWFQ2LF5PEBcLV1Wa+sGlwpcuu3In65ADqflC
   UXOwhZA3+NUgpJM14Ks5E04XQYSJdcbu7WZdIP8Pz2lNQijxxNhCW9CPk
   QfUJ88tldROpPK87OGAr9/hECdl6tyNxQbHr0iwt6UulkVHOk/4vPfUmf
   dJtpA5oPoBocKCLhBhT3RJ2z56ylwa2pkpW6XkE6IWU223DHPdcGx3cJy
   0/gNYnN01FMhAvQmJ2r8M3HiBLE0Sn5uNvHnz/u4LWFLM0oWSj6GEhHXC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="6095513"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="6095513"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 19:33:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="9807262"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orviesa002.jf.intel.com with ESMTP; 27 Nov 2023 19:33:54 -0800
Subject: [net-next PATCH v9 10/11] netdev-genl: Add PID for the NAPI thread
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 27 Nov 2023 19:50:20 -0800
Message-ID: <170114342017.10303.12870950288473709897.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <170114286635.10303.8773144948795839629.stgit@anambiarhost.jf.intel.com>
References: <170114286635.10303.8773144948795839629.stgit@anambiarhost.jf.intel.com>
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
index e87d2f2d7fec..b39e9c8c0dc1 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -152,6 +152,7 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			const struct genl_info *info)
 {
 	void *hdr;
+	pid_t pid;
 
 	if (WARN_ON_ONCE(!napi->dev))
 		return -EINVAL;
@@ -172,6 +173,12 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
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


