Return-Path: <netdev+bounces-166403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3EFA35F0D
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24EE1887086
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 13:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60A5263F4B;
	Fri, 14 Feb 2025 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLvu3qnv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574F877102
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539500; cv=none; b=hdLhA2NJ2e2VMKIxLM6c9IJqlQ3gq6zEGbAvUPqX9+mORJzmvKqxvWnCfiRj6H8MRJfKA9YgGqD9dqHM4CQ6IV23mmJKjR7Yhy58/eOz5d1+aEKd9CUdbqQawFLbNo3BqUmFlsu8MVN5Mmy7Fl6ITQR4ywn9O6xJB1SaEe0MTDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539500; c=relaxed/simple;
	bh=csA0PqTGnkvoBP2+btBM3glOUY4lCn/G/5P0Xmfr7h8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hdv80gChZlv2AeDmU0yXY69yywM9s3Kq8Rwu9DmskR3I2Pjc4mxWedJTvA0C2PqLZ/0s8Vm1nnmv53GIbn54QOg8TCuaTeGwESJO+gyWKdwhuVxIW/8vpURakoRcnf4anvC/k05rLx0TZh+6J5VMww+cVSqANrl0WRMSAe+1rTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLvu3qnv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739539499; x=1771075499;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=csA0PqTGnkvoBP2+btBM3glOUY4lCn/G/5P0Xmfr7h8=;
  b=HLvu3qnvMd+midwrPOQAM6kr1Ircakw8lVLiObBpx4TSNX0opp7ZbAKo
   YfGvlVD/3h3/VaXmWafrZPtQKav5SvYvv2mKvfAnt9x1iLhUWYwaUnCUH
   NL/9Lz8bZNjsdc3toi8qBXAeDMiai9XTmh8Re/F3dF2rTXAVF1EXuEJOW
   Z0ZYf8RC30SYXzNPAo7FIuslL9CK/tKN8s18toPMdFiaQjMYLhQ/4yqpr
   E6VXs8WXmROBxKww27bAmqOhnzhynl8fBmHM/kuYSUDfVnrh7x8LWr9IW
   WtMWv9uXlQnbQ/WSSaE5KdSCvkVkqfGSUVmRZK5Zo6FxaVa6zBSNZaHRX
   w==;
X-CSE-ConnectionGUID: qGtpCYmxS8KX8qAnY/cUPw==
X-CSE-MsgGUID: kc3RznnPSFK2zixG37yAFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="57818696"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="57818696"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 05:24:58 -0800
X-CSE-ConnectionGUID: pmQ8OQYNTGeQ/oS1FNNaSA==
X-CSE-MsgGUID: L6cStYbrRKiFHmMsDLRrQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113330117"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by orviesa010.jf.intel.com with ESMTP; 14 Feb 2025 05:24:56 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	pierre@stackhpc.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [net v1] devlink: fix xa_alloc_cyclic error handling
Date: Fri, 14 Feb 2025 14:24:53 +0100
Message-ID: <20250214132453.4108-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pierre Riteau <pierre@stackhpc.com> found suspicious handling an error
from xa_alloc_cyclic() in scheduler code [1]. The same is done in
devlink_rel_alloc().

In case of returning 1 from xa_alloc_cyclic() (wrapping) ERR_PTR(1) will
be returned, which will cause IS_ERR() to be false. Which can lead to
dereference not allocated pointer (rel).

Fix it by checking if err is lower than zero.

This wasn't found in real usecase, only noticed. Credit to Pierre.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 net/devlink/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index f49cd83f1955..7203c39532fc 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -117,7 +117,7 @@ static struct devlink_rel *devlink_rel_alloc(void)
 
 	err = xa_alloc_cyclic(&devlink_rels, &rel->index, rel,
 			      xa_limit_32b, &next, GFP_KERNEL);
-	if (err) {
+	if (err < 0) {
 		kfree(rel);
 		return ERR_PTR(err);
 	}
-- 
2.42.0


