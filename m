Return-Path: <netdev+bounces-143962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0E29C4D8B
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 05:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8D9284B76
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 04:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153731553AB;
	Tue, 12 Nov 2024 04:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWCoMSpl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C561DFE4
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 04:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731384061; cv=none; b=gx44ni8FiPENKv+nmsmivP1PuayboPzHmPGfMt+SULgOzRufhmfgitM8a95X3FaLlaxM2rf1/20u7qYPbRrIhCfB8Aw5BnZDFnshp+r6haXPYc4NOi9UjYpQ3LjD6TRrSOGiQ2pUjHONEVnKpd/F7NUPfnIkXzj3IcFLZf2GE4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731384061; c=relaxed/simple;
	bh=MInRnrIbroaebirZdPdyrVsqkuxDkA6P3CW9MGylKKw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TE31AFq0pHJFSDHk8G+mGeV8YoXCcUhLNMjwJ5wKfZZIc+dpmh+03gxIdIXeqRtE++mzFLIqBB8foWNXHVHdQ1ehfX1hFyZ2nkLYwY6kMz2KE2WK5FZIxKyKn2/oyPw65WwS+ImKkuKWfKJuOX8CdkUmU4XHtWA2GMRgcUz4Im8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CWCoMSpl; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731384060; x=1762920060;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MInRnrIbroaebirZdPdyrVsqkuxDkA6P3CW9MGylKKw=;
  b=CWCoMSplgzm0uBLWwQtWsyOn7UYJlTp4M705fK7TOp8iuHYe3OzluIRh
   fDDQsPK17csEvaZeOplTKZ98ezt4K20DwiWEKAu+VTFc3nQ3SPPgnes5/
   xbs18kf7Ctao7ZCJiiFc9YqWUP/nVISNKJI75M2OLhaFXg97EOq2Jr7k0
   tWON1cwMNT8HD4Waf3YfBM1wk0FT/rDcd/ylyFmSCM2j/M6kdpFciV2M/
   yZj14SottZVTy5UoTssxRpd2PBovafOUtIWnRlSWJsgYJg7xf4D0ToNSE
   gadAHnAjS1XZi3O0p0zoVN3b9zHYvip5sUtDHnRekZgJQR3dEt0rTwuXz
   Q==;
X-CSE-ConnectionGUID: 9zahqIAfTwCz89ZgxxUQ/Q==
X-CSE-MsgGUID: PDHS/RcISu+3eWqXvhQJxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31354598"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31354598"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 20:00:59 -0800
X-CSE-ConnectionGUID: NuP7CmulReOewYOoI0Lp1g==
X-CSE-MsgGUID: mTCYgI9ATySj7JT7n9vpug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,146,1728975600"; 
   d="scan'208";a="110505004"
Received: from unknown (HELO YongLiang-Ubuntu20-iLBPG12.png.intel.com) ([10.88.229.33])
  by fmviesa002.fm.intel.com with ESMTP; 11 Nov 2024 20:00:57 -0800
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>
Subject: [PATCH iproute2-next v1] tc: Add support for Hold/Release mechanism in TSN as per IEEE 802.1Q-2018
Date: Tue, 12 Nov 2024 12:00:29 +0800
Message-Id: <20241112040029.3196975-1-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit enhances the q_taprio module by adding support for the
Hold/Release mechanism in Time-Sensitive Networking (TSN), as specified
in the IEEE 802.1Q-2018 standard.

Changes include:
- Addition of `TC_TAPRIO_CMD_SET_AND_HOLD` and `TC_TAPRIO_CMD_SET_AND_RELEASE`
cases in the `entry_cmd_to_str` function to return "H" and "R" respectively.
- Addition of corresponding string comparisons in the `str_to_entry_cmd`
function to map "H" and "R" to `TC_TAPRIO_CMD_SET_AND_HOLD` and
`TC_TAPRIO_CMD_SET_AND_RELEASE`.

The Hold/Release feature works as follows:
- Set-And-Hold-MAC (H): This command sets the gates and holds the current
configuration, preventing any further changes until a release command is
issued.
- Set-And-Release-MAC (R): This command releases the hold, allowing
subsequent gate configuration changes to take effect.

These changes ensure that the q_taprio module can correctly interpret and
handle the Hold/Release commands, aligning with the IEEE 802.1Q-2018 standard
for enhanced TSN configuration.

Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>
---
 man/man8/tc-taprio.8 | 30 ++++++++++++++++++++++--------
 tc/q_taprio.c        |  8 ++++++++
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/man/man8/tc-taprio.8 b/man/man8/tc-taprio.8
index bf489b03..b7a81faf 100644
--- a/man/man8/tc-taprio.8
+++ b/man/man8/tc-taprio.8
@@ -115,14 +115,28 @@ parameters in a single schedule. Each one has the
 
 sched-entry <command> <gatemask> <interval>
 
-format. The only supported <command> is "S", which
-means "SetGateStates", following the IEEE 802.1Q-2018 definition
-(Table 8-7). <gate mask> is a bitmask where each bit is a associated
-with a traffic class, so bit 0 (the least significant bit) being "on"
-means that traffic class 0 is "active" for that schedule entry.
-<interval> is a time duration, in nanoseconds, that specifies for how
-long that state defined by <command> and <gate mask> should be held
-before moving to the next entry.
+format.
+
+<command> support the following values:
+.br
+.I "S"
+for SetGateStates
+.br
+.I "H"
+for Set-And-Hold-MAC
+.br
+.I "R"
+for Set-And-Release-MAC
+.br
+These commands follow the IEEE 802.1Q-2018 definition (Table 8-7).
+
+<gate mask> is a bitmask where each bit is associated with a traffic class, so
+bit 0 (the least significant bit) being "on" means that traffic class 0 is
+"active" for that schedule entry.
+
+<interval> is a time duration, in nanoseconds, that specifies for how long that
+state defined by <command> and <gate mask> should be held before moving to
+the next entry.
 
 .TP
 flags
diff --git a/tc/q_taprio.c b/tc/q_taprio.c
index 416a222a..689c7a8f 100644
--- a/tc/q_taprio.c
+++ b/tc/q_taprio.c
@@ -53,6 +53,10 @@ static const char *entry_cmd_to_str(__u8 cmd)
 	switch (cmd) {
 	case TC_TAPRIO_CMD_SET_GATES:
 		return "S";
+	case TC_TAPRIO_CMD_SET_AND_HOLD:
+		return "H";
+	case TC_TAPRIO_CMD_SET_AND_RELEASE:
+		return "R";
 	default:
 		return "Invalid";
 	}
@@ -62,6 +66,10 @@ static int str_to_entry_cmd(const char *str)
 {
 	if (strcmp(str, "S") == 0)
 		return TC_TAPRIO_CMD_SET_GATES;
+	else if (strcmp(str, "H") == 0)
+		return TC_TAPRIO_CMD_SET_AND_HOLD;
+	else if (strcmp(str, "R") == 0)
+		return TC_TAPRIO_CMD_SET_AND_RELEASE;
 
 	return -1;
 }
-- 
2.34.1


