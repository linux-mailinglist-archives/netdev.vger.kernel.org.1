Return-Path: <netdev+bounces-100322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E778D88D2
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 20:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D10C1B245C7
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 18:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FDE1386D8;
	Mon,  3 Jun 2024 18:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jDg3+UZN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985DD13AD20
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717440316; cv=none; b=dZty5M+WvAQdQXyKp284zi2HG7VU8+ya6ga1VJQW7Ed8/M1Ku5DPTUxY7hJwiYW6SDXOMFb0mRNkv72rV3r8vTD5u3XI+JQb17Ox2RoFxIeOlXDRUA+d8IbqBW6VRrhv3wIhCnKy0CP4dANs9xTE0sM1zsr4kxGfSRuSw9Ps+Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717440316; c=relaxed/simple;
	bh=3a4r7SyStC0TtS2GfY1JvWtSVnVpbpfOLb1Hk0c9r9E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hwumhQaZaCpdsDZlr6ZoiUVuX4PkOcc/9y2wcQBw1mZiWF7Lx4Y2bLZnsDiK9+6es3VbcrIxNQeU6KHRKSAQA66IKP0D37gog6yegklLqJNHbNEmVzRxCZBbvAhPIVnSAi7gwfURCmVh1d8L28qe0h/m0XupOVNTyb41kYobh4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jDg3+UZN; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717440314; x=1748976314;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3a4r7SyStC0TtS2GfY1JvWtSVnVpbpfOLb1Hk0c9r9E=;
  b=jDg3+UZNWNXYb5AC4aiw7+hel05Dc9N5AJRTPZ6iSiePziXYszGL92tG
   JvhLc5rMnsBmUDK8eZFYoXUJFWQPapPUILf43nPVDQB4D5BgJNEI9bSF9
   4Dj+0TbyAUlNFhSU13mvWfDf4NWAHeHOR+0C9b2FYi0QIDWpqFW27ikDL
   MwjtsQBeMMgo7v+qbTxPRAj4Pngo+laz6+NiLZhFWXH1u+20wMg1Z+mSz
   6h6jk0aM/YLo3oCZTidNI/PSJF9O+m3jGPeNGl7rcH7SqgtPK95DfsqeW
   MHoYC145LnYa6n59VR8oyQxwqHvTLICLmyktiMMT0h0HQi61nGnfFn7o8
   A==;
X-CSE-ConnectionGUID: b1bA4/VgSL26oVyOmOCkkA==
X-CSE-MsgGUID: OmVF7LIKSViOXzfbLSa5sQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="31451334"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="31451334"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 11:45:14 -0700
X-CSE-ConnectionGUID: e6DF74BqQ+qPxMT5vYT39w==
X-CSE-MsgGUID: 6hRgwVB4QLCx+NfqGa/6TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37423379"
Received: from unknown (HELO dcskidmo-M40.jf.intel.com) ([10.166.241.13])
  by orviesa006.jf.intel.com with ESMTP; 03 Jun 2024 11:45:15 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>
Subject: [PATCH iwl-net] idpf: extend tx watchdog timeout
Date: Mon,  3 Jun 2024 11:47:14 -0700
Message-Id: <20240603184714.3697911-1-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are several reasons for a TX completion to take longer than usual
to be written back by HW. For example, the completion for a packet that
misses a rule will have increased latency. The side effect of these
variable latencies for any given packet is out of order completions. The
stack sends packet X and Y. If packet X takes longer because of the rule
miss in the example above, but packet Y hits, it can go on the wire
immediately. Which also means it can be completed first.  The driver
will then receive a completion for packet Y before packet X.  The driver
will stash the buffers for packet X in a hash table to allow the tx send
queue descriptors for both packet X and Y to be reused. The driver will
receive the completion for packet X sometime later and have to search
the hash table for the associated packet.

The driver cleans packets directly on the ring first, i.e. not out of
order completions since they are to some extent considered "slow(er)
path". However, certain workloads can increase the frequency of out of
order completions thus introducing even more latency into the cleaning
path. Bump up the timeout value to account for these workloads.

Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index f1ee5584e8fa..3d4ae2ed9b96 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -770,8 +770,8 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 	else
 		netdev->netdev_ops = &idpf_netdev_ops_singleq;
 
-	/* setup watchdog timeout value to be 5 second */
-	netdev->watchdog_timeo = 5 * HZ;
+	/* setup watchdog timeout value to be 30 seconds */
+	netdev->watchdog_timeo = 30 * HZ;
 
 	netdev->dev_port = idx;
 
-- 
2.39.2


