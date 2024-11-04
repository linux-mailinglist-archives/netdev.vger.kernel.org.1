Return-Path: <netdev+bounces-141708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9579BC106
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 23:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CCD51F22C1B
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 22:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAA31FEFA2;
	Mon,  4 Nov 2024 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqzZua8G"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBFF1FE0ED
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 22:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759809; cv=none; b=slU5rEVH+HCG+w7VPFZiUHcMuc7KCFTb8HmKYTb3ezl9SZeykczlXIFqVWcyWnQEksPycfhbNL8P+8fwxxbhjOsxiXvP/9LcXkXeXM0xr0/t41UOqwZ71kkwbM9uijHN50I1woHdkv/+U0thDijE8mvoZyXREC51inIAyXTsNKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759809; c=relaxed/simple;
	bh=EiKJf1+KTD45R2F3QILUk43HCVQm6LiEQvLOq8hnLTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ag6TFXH30dwLO+j6YMMXFMjrDWkTpVHRaipfiDPpginwF305PStMVIKnqmRMk8hW8UhFlIO/aJnvnKxBus9uK/4p/d5j/HBUSuH1iInBcdDECFBURDuyJBLXZNxhHeONX1yXeLhBxVfLG3ik/docDM26Tb8pjdWHK0KvnuBu/bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqzZua8G; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730759807; x=1762295807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EiKJf1+KTD45R2F3QILUk43HCVQm6LiEQvLOq8hnLTk=;
  b=lqzZua8GXEWs3gBRozRzdJMtRjzf2POAhB6gs8E3M3dhDyg2NPsWIZbK
   Tnce1wcup00BuYMQhmGCa4nsVZz/ZukU2W4D4KB1OVkPVjBOREiT+njlu
   /Jcz9flt6Yi3x372yy5Pouu0UIUOztj/0z6ygsFqWlZVY9civIpgRvxFW
   ptBe9qpGNoPdmil/dSbjAPN1FXY5rdkm3/d8VIvPfvUlVSsi777m2XX1d
   9A781tumFHXTfj2mKFyRYluDeRr67j0HireyOnkK736U56Rsxu7KjBulB
   jR+tIN0650wGqQeb8NJW1LJSLiKsygSd4uywYBXkPfKCNtphSIhTc3ZsC
   g==;
X-CSE-ConnectionGUID: ku/adgSwSHCx55oBQjiiIw==
X-CSE-MsgGUID: 65DavpZ9StWn1LlUKwcGxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="29901669"
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="29901669"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 14:36:45 -0800
X-CSE-ConnectionGUID: I3zQZecoTqGYujXdghq0jA==
X-CSE-MsgGUID: LThFhj4gSoGPZIlXFrhO5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="83316988"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 04 Nov 2024 14:36:45 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>,
	anthony.l.nguyen@intel.com,
	dima.ruinskiy@intel.com,
	horms@kernel.org,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH net 6/6] e1000e: Remove Meteor Lake SMBUS workarounds
Date: Mon,  4 Nov 2024 14:36:34 -0800
Message-ID: <20241104223639.2801097-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241104223639.2801097-1-anthony.l.nguyen@intel.com>
References: <20241104223639.2801097-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

This is a partial revert to commit 76a0a3f9cc2f ("e1000e: fix force smbus
during suspend flow"). That commit fixed a sporadic PHY access issue but
introduced a regression in runtime suspend flows.
The original issue on Meteor Lake systems was rare in terms of the
reproduction rate and the number of the systems affected.

After the integration of commit 0a6ad4d9e169 ("e1000e: avoid failing the
system during pm_suspend"), PHY access loss can no longer cause a
system-level suspend failure. As it only occurs when the LAN cable is
disconnected, and is recovered during system resume flow. Therefore, its
functional impact is low, and the priority is given to stabilizing
runtime suspend.

Fixes: 76a0a3f9cc2f ("e1000e: fix force smbus during suspend flow")
Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index ce227b56cf72..2f9655cf5dd9 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1205,12 +1205,10 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
 	if (ret_val)
 		goto out;
 
-	if (hw->mac.type != e1000_pch_mtp) {
-		ret_val = e1000e_force_smbus(hw);
-		if (ret_val) {
-			e_dbg("Failed to force SMBUS: %d\n", ret_val);
-			goto release;
-		}
+	ret_val = e1000e_force_smbus(hw);
+	if (ret_val) {
+		e_dbg("Failed to force SMBUS: %d\n", ret_val);
+		goto release;
 	}
 
 	/* Si workaround for ULP entry flow on i127/rev6 h/w.  Enable
@@ -1273,13 +1271,6 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
 	}
 
 release:
-	if (hw->mac.type == e1000_pch_mtp) {
-		ret_val = e1000e_force_smbus(hw);
-		if (ret_val)
-			e_dbg("Failed to force SMBUS over MTL system: %d\n",
-			      ret_val);
-	}
-
 	hw->phy.ops.release(hw);
 out:
 	if (ret_val)
-- 
2.42.0


