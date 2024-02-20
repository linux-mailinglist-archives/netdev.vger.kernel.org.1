Return-Path: <netdev+bounces-73446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A9D85CA2C
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 22:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75F9F1F21FA4
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 21:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233D81534E6;
	Tue, 20 Feb 2024 21:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZxXMN/G7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741BE152DF1
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 21:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708465500; cv=none; b=u3OlY1TfwTPbogxq7HeaOAg2kNPfM/WRj+fk1o82YLVWSmg0EX9I7UHHDvoclqPHfqjE2YwSh6J8F726H01M41O0Z/fmeNs8M101GJh5Un3ZZbWwk65U7jEs1EVLazrJfDyvRQt8rasgUkl8qScuUn2RjRWd5E4th6shBgzfW/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708465500; c=relaxed/simple;
	bh=3txDGLVm+23oFpsEJVasDz2/nYmE7TaxWl9yE+Vo/Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EybooFAm1o9mWHLHPk9WREMrDHUrh50VmAbjOvUS/84j7SsLXd1u4uQzSs0chpUmRQuCvzTu1w6PuVxkPGUBUR9n9yCo/5rzfmXT2oGJrkh/vX4Gfha2NIAkjjGXVvGG+yk1t7OjjTkMrzgqZr6IRoR3332zFl5cDLzOeZo6pgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZxXMN/G7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708465498; x=1740001498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3txDGLVm+23oFpsEJVasDz2/nYmE7TaxWl9yE+Vo/Do=;
  b=ZxXMN/G7zz01PsuFOInamZMFClYAicT2N0ns1XzFBN1/1oXjgvkBtrf3
   qrvzSMhVP8NclCCRKbg3qA+XeaDLXcMlOvXP3nm3nk78gWZy6cT738p9U
   Sw4d+u/5l8Acdxp95aG8FCyqmueWjnKl8EHmwrcQazAxTugR9DRu7YuGV
   0LLXHzfb2+Nz14UPfGQ1g+AaM+5jocSefeCtlxsy4svchkdwFGaXHcqUb
   zCsRNynizeUZFldEG0y/T4+k70ToUT0es/MzgsqX2lrGDWgLLSAlIZquV
   XpqcdaubGsjYJ5/7Wn7V5CNu9GGZrZ1EA4bD40kZH1JLheTwfmG9KsV8u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2472744"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2472744"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 13:44:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9614946"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 20 Feb 2024 13:44:53 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	anthony.l.nguyen@intel.com,
	vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	Igor Bagnucki <igor.bagnucki@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 5/6] ice: fix pin phase adjust updates on PF reset
Date: Tue, 20 Feb 2024 13:44:41 -0800
Message-ID: <20240220214444.1039759-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240220214444.1039759-1-anthony.l.nguyen@intel.com>
References: <20240220214444.1039759-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Do not allow to set phase adjust value for a pin if PF reset is in
progress, this would cause confusing netlink extack errors as the firmware
cannot process the request properly during the reset time.

Return (-EBUSY) and report extack error for the user who tries configure
pin phase adjust during the reset time.

Test by looping execution of below steps until netlink error appears:
- perform PF reset
$ echo 1 > /sys/class/net/<ice PF>/device/reset
- change pin phase adjust value:
$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
	--do pin-set --json '{"id":0, "phase-adjust":1000}'

Fixes: 90e1c90750d7 ("ice: dpll: implement phase related callbacks")
Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 395e10c246f7..adfa1f2a80a6 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -963,6 +963,9 @@ ice_dpll_pin_phase_adjust_set(const struct dpll_pin *pin, void *pin_priv,
 	u8 flag, flags_en = 0;
 	int ret;
 
+	if (ice_dpll_is_reset(pf, extack))
+		return -EBUSY;
+
 	mutex_lock(&pf->dplls.lock);
 	switch (type) {
 	case ICE_DPLL_PIN_TYPE_INPUT:
-- 
2.41.0


