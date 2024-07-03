Return-Path: <netdev+bounces-108870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E78C092619F
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BFE0B21B65
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7781017A5B0;
	Wed,  3 Jul 2024 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OyUVXXNE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B2B179970
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 13:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720012581; cv=none; b=jOijTxeTmkTzEuc4PVzSw7pd1ux6rGICUbe4q9vKa4A1CyA8vHBzpPEcPEodc1nFnwFHnjVIfDdeeAetovEBoaQz48DFhuqUQ0i24UVWWd5ccA5MTrmyP1viarMpqHXhggUVTf71ed08Eu4TVzVeN1GPN56wf7zNljaFL4mx0J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720012581; c=relaxed/simple;
	bh=rT0BeF4MDOJPjbgHUSfRBBx/GY1rVxmeWdmq+26n/ko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=apo56a5pBq1sscNTdnbS5zIZDeKS1ZJCHAOJOPCzYlHoqj5owCvAvUvffHMjyMOB5IhsWuRJsePjpEj1V+GYQwh5vaF1dQluHBTuF27Skm3Ec7AOEc91aqUQO60sPn/UWbf2XJumWbqPfu+8WePXNPG0AFpkcDv88b7HFUjhzG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OyUVXXNE; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720012581; x=1751548581;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rT0BeF4MDOJPjbgHUSfRBBx/GY1rVxmeWdmq+26n/ko=;
  b=OyUVXXNEQbl4eaQBGzaY9/Dlq4sQXLxQadN4VBWf7pC7CTYLai5x5DXf
   q40xLw+nd+P3Yndqd0vDWMoclV+qa9lMTfyLwKOrMBancW5u+AcxIIgeS
   YpSXb7pBYHupP/wNS7QobzK9blec0iFd+PBY35G3jAqNCpBiNv0rKfCR9
   YTY/mwumRieoSZca3rRpk6L6n8mQ6vEu9xr2DmPugcSYmiRnxSTGhHYOA
   snawWXJolKgdypwEM95KGUQoxz4oTShQZNWjl7NzwpQwnfE0YPOrIFx6z
   vA42gfK1GaoRrRoUX732woXHI6hC3D6i8d8ngJUtLmrIQ+lEJmr9KL7L5
   Q==;
X-CSE-ConnectionGUID: 3P16Jh9CQNKmh3hxbL/8Eg==
X-CSE-MsgGUID: BzFNlImaQSKD5oQtphSuJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17195090"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="17195090"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 06:16:15 -0700
X-CSE-ConnectionGUID: bCJ/DNArR0K9TLQNx7b8Fw==
X-CSE-MsgGUID: D6sK2YMtQc6mx/6dTNyedA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="83805886"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 03 Jul 2024 06:16:12 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 513C828779;
	Wed,  3 Jul 2024 14:16:11 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH iproute2-next 2/3] devlink: print missing params even if an unknown one is present
Date: Wed,  3 Jul 2024 15:15:20 +0200
Message-Id: <20240703131521.60284-3-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240703131521.60284-1-przemyslaw.kitszel@intel.com>
References: <20240703131521.60284-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Print all of the missing parameters, also in the presence of unknown ones.

Take for example a correct command:
    $ devlink resource set pci/0000:01:00.0 path /kvd/linear size 98304
And remove the "size" keyword:
    $ devlink resource set pci/0000:01:00.0 path /kvd/linear 98304
That yields output:
    Resource size expected.
    Unknown option "98304"

Prior to the patch only the last line of output was present. And if user
would forgot also the "path" keyword, there will be additional line:
    Resource path expected.
in the stderr.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 devlink/devlink.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 57bcc9658bdb..9907712e3ad0 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -1680,26 +1680,28 @@ static const struct dl_args_metadata dl_args_required[] = {
 static int dl_args_finding_required_validate(uint64_t o_required,
 					     uint64_t o_found)
 {
-	uint64_t o_flag;
-	int i;
+	uint64_t o_flag, o_missing = 0;
+	int i, err = 0;
 
 	for (i = 0; i < ARRAY_SIZE(dl_args_required); i++) {
 		o_flag = dl_args_required[i].o_flag;
 		if ((o_required & o_flag) && !(o_found & o_flag)) {
+			o_missing |= o_flag;
 			pr_err("%s\n", dl_args_required[i].err_msg);
-			return -ENOENT;
+			err = -ENOENT;
 		}
 	}
-	if (o_required & ~o_found) {
+	if (o_required & ~(o_found | o_missing)) {
 		pr_err("BUG: unknown argument required but not found\n");
 		return -EINVAL;
 	}
-	return 0;
+	return err;
 }
 
 static int dl_argv_parse(struct dl *dl, uint64_t o_required,
 			 uint64_t o_optional)
 {
+	const char *unknown_option = NULL;
 	struct dl_opts *opts = &dl->opts;
 	uint64_t o_all = o_required | o_optional;
 	char *str = dl_argv_next(dl);
@@ -2313,8 +2315,9 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
 			o_found |= DL_OPT_PORT_FN_MAX_IO_EQS;
 
 		} else {
-			pr_err("Unknown option \"%s\"\n", dl_argv(dl));
-			return -EINVAL;
+			if (!unknown_option)
+				unknown_option = dl_argv(dl);
+			dl_arg_inc(dl);
 		}
 	}
 
@@ -2325,7 +2328,15 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
 
 	opts->present = o_found;
 
-	return dl_args_finding_required_validate(o_required, o_found);
+	err = dl_args_finding_required_validate(o_required, o_found);
+
+	if (unknown_option) {
+		pr_err("Unknown option \"%s\"\n", unknown_option);
+		if (!err)
+			return -EINVAL;
+	}
+
+	return err;
 }
 
 static int dl_argv_dry_parse(struct dl *dl, uint64_t o_required,
-- 
2.39.3


