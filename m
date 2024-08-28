Return-Path: <netdev+bounces-122967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8F09634E3
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE452872C7
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC841AC446;
	Wed, 28 Aug 2024 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fkZB8XMR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418181553A2
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 22:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884727; cv=none; b=k0VpCJPDbfVwPDN0MAmQdZtBC5KtphAIO+WJniq7VvJiOpc43p91qpXZU2RDbBh/HDJIvuKi+XYbhwaNFnc1LbRD10J0DFYxJMrjTXxAXU0D6rnF0jEq9FQO/mZdHMzrYb1Q0+V/drDXxMZowKrpjU0XIKj2xMVtyCuGtC0A8G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884727; c=relaxed/simple;
	bh=KZWolL2TmTaVYvdYvu+u9TBPy20nwbHqirp669p/JBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rhicr0YYCBJBbu1tBd1kRjLwxR1gw1aW8YVVVXMTrsMFIh4C5AQt6i7XwGDZl+1R3YH5n5KZZ6Ids3K17L4/7LQ6S3s+65vOzF9WoNDk5U9l4tGN2x0R5ZeosKjUncE9ANYAV44n+EnPFnYqwjkhRH5FV4IXI6LPjAAeKiZa/4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fkZB8XMR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724884725; x=1756420725;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KZWolL2TmTaVYvdYvu+u9TBPy20nwbHqirp669p/JBU=;
  b=fkZB8XMRrRu2hYy1ZYaOeeZEUGrKaKaE373U0qZWFzFcf5R2tk6UxP8f
   iTeOfpE2OCIdA7QXMAjNXvKeE/gIye8tHgIqCkyLzIyRugOGE5PLvfSh2
   5KTwNY7xNkRAKo7X9+E5GqxBLIpiGqM39RDGrgF1H+Bmgo99zE8XYNsSz
   Jh3sZRE+Ur1YCQrguXanF+m19ymsx/LGy9eyQpLfke4Yw7b/wD0PqMPF4
   truUcK1IIQR9VJVPbsLorZr20n5yWorkpBXZJk4fNz1QF14FdQCcrPADT
   3/+qPXEIrz1ppoQ2cZMNv6ea3+EjrxiCzkRFaH0NlppoftkLcqkmv4mMn
   Q==;
X-CSE-ConnectionGUID: bTRWTAv6RhmEj+jDMGI4CQ==
X-CSE-MsgGUID: ugklGi2rTFOywh6CEvlEEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23608248"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23608248"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:38:45 -0700
X-CSE-ConnectionGUID: NGV8akfdSHeke9aq93rXpg==
X-CSE-MsgGUID: Zk9WEy4wR0mTYEksNkKUVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="100888382"
Received: from fpallare-mobl3.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.245.244.218])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:38:40 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pavan.kumar.linga@intel.com,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net] idpf: fix VF dynamic interrupt ctl register initialization
Date: Wed, 28 Aug 2024 16:38:25 -0600
Message-ID: <20240828223825.426647-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VF's dynamic interrupt ctl "dyn_ctl_intrvl_s" is not initialized
in idpf_vf_intr_reg_init(). This resulted in the following UBSAN error
whenever a VF is created:

[  564.345655] UBSAN: shift-out-of-bounds in drivers/net/ethernet/intel/idpf/idpf_txrx.c:3654:10
[  564.345663] shift exponent 4294967295 is too large for 32-bit type 'int'
[  564.345671] CPU: 33 UID: 0 PID: 2458 Comm: NetworkManager Not tainted 6.11.0-rc4+ #1
[  564.345678] Hardware name: Intel Corporation M50CYP2SBSTD/M50CYP2SBSTD, BIOS SE5C6200.86B.0027.P10.2201070222 01/07/2022
[  564.345683] Call Trace:
[  564.345688]  <TASK>
[  564.345693]  dump_stack_lvl+0x91/0xb0
[  564.345708]  __ubsan_handle_shift_out_of_bounds+0x16b/0x320
[  564.345730]  idpf_vport_intr_update_itr_ena_irq.cold+0x13/0x39 [idpf]
[  564.345755]  ? __pfx_idpf_vport_intr_update_itr_ena_irq+0x10/0x10 [idpf]
[  564.345771]  ? static_obj+0x95/0xd0
[  564.345782]  ? lockdep_init_map_type+0x1a5/0x800
[  564.345794]  idpf_vport_intr_ena+0x5ef/0x9f0 [idpf]
[  564.345814]  idpf_vport_open+0x2cc/0x1240 [idpf]
[  564.345837]  idpf_open+0x6d/0xc0 [idpf]
[  564.345850]  __dev_open+0x241/0x420

Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
index 629cb5cb7c9f..5d4182ca0ff6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
@@ -98,6 +98,7 @@ static int idpf_vf_intr_reg_init(struct idpf_vport *vport)
 						  reg_vals[vec_id].dyn_ctl_reg);
 		intr->dyn_ctl_intena_m = VF_INT_DYN_CTLN_INTENA_M;
 		intr->dyn_ctl_itridx_s = VF_INT_DYN_CTLN_ITR_INDX_S;
+		intr->dyn_ctl_intrvl_s = VF_INT_DYN_CTLN_INTERVAL_S;
 
 		spacing = IDPF_ITR_IDX_SPACING(reg_vals[vec_id].itrn_index_spacing,
 					       IDPF_VF_ITR_IDX_SPACING);
-- 
2.43.0


