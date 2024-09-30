Return-Path: <netdev+bounces-130645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C7C98AFF9
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 00:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934531F22C15
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF521A0BFF;
	Mon, 30 Sep 2024 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JhZwESEX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F95319AA57
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 22:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727735773; cv=none; b=OqO0hx2L2tQ3uH1QMj/MkSpLstUifXQeDqjfzgRG2bajLY+f/6AipGqx3TuXO/s2yUMoAMcIVyG+klBSlEB1cRd+kUp7aSZMcWZ3BPurFKMWnSHx1nyUnSUY8k+ivHmwu8ZMUTfs60rkEwE3sAJTFnHaPhWZDxhO7NiPHWdJ4kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727735773; c=relaxed/simple;
	bh=xIrtZfFvS4XenpiTX/WFZf55dVsU48q+QRt9toQF/bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNbqnbLReFBiUnIAAVegx+ow14tNC58kdrAcNvmtKBnH3ZAfMv2Eo1U+cr99lFvuY+h5WKA3i4QIVLbfGFtlB3dbbwmksIfC+ZsHN7UV1cEPM8wEaCXB69eRL1Kcozhlzrpns3nIuZvYvmOhTEY+BCzIRzV4c8MCEarVRWxXd7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JhZwESEX; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727735772; x=1759271772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xIrtZfFvS4XenpiTX/WFZf55dVsU48q+QRt9toQF/bo=;
  b=JhZwESEX+SwsNU2caIvb82yJKbR4IIPx2fxOgOtGoQiqM1et//kmXIt9
   PAloVbxJgajv4Zgaa0O7Fe/vMWFbjfLxhqvmDl6oOFmb/UZTM+hDkNMIN
   92uyOktgM0EjE7Y2tvq/XSvY4jIY217atI9eCWfefAbNbLaKy+BhJE7Pc
   3dzujgZyJ2ltFyR8cMJ4eJHhY+IDY8lJA+8fpag4wh5C2H7o80SbVIDUB
   Pt0QLNRR5AJJnvvYAKlKTNUZclUvR9vzyfD8+hvLBRPopqXzmKxTItoWU
   tAIcSYxIU1mX3f4RbHJsoNu7ciku6XdmT5dk/AVqVijKJAwuCmsnBr3ys
   g==;
X-CSE-ConnectionGUID: 4tLm/10GSnuj8reacjBYfA==
X-CSE-MsgGUID: XCzjcK+mQxWDXYvxv+yFeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="30734896"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="30734896"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 15:36:06 -0700
X-CSE-ConnectionGUID: bZ9i+JIUTFqEYskGNMWigg==
X-CSE-MsgGUID: NgCcMIYESae3++jtrU6IJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73496630"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 30 Sep 2024 15:36:07 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ahmed Zaki <ahmed.zaki@intel.com>,
	anthony.l.nguyen@intel.com,
	willemb@google.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Krishneil Singh <krishneil.k.singh@intel.com>
Subject: [PATCH net 08/10] idpf: fix VF dynamic interrupt ctl register initialization
Date: Mon, 30 Sep 2024 15:35:55 -0700
Message-ID: <20240930223601.3137464-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20240930223601.3137464-1-anthony.l.nguyen@intel.com>
References: <20240930223601.3137464-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ahmed Zaki <ahmed.zaki@intel.com>

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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
index 99b8dbaf4225..aad62e270ae4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
@@ -99,6 +99,7 @@ static int idpf_vf_intr_reg_init(struct idpf_vport *vport)
 		intr->dyn_ctl_intena_m = VF_INT_DYN_CTLN_INTENA_M;
 		intr->dyn_ctl_intena_msk_m = VF_INT_DYN_CTLN_INTENA_MSK_M;
 		intr->dyn_ctl_itridx_s = VF_INT_DYN_CTLN_ITR_INDX_S;
+		intr->dyn_ctl_intrvl_s = VF_INT_DYN_CTLN_INTERVAL_S;
 		intr->dyn_ctl_wb_on_itr_m = VF_INT_DYN_CTLN_WB_ON_ITR_M;
 
 		spacing = IDPF_ITR_IDX_SPACING(reg_vals[vec_id].itrn_index_spacing,
-- 
2.42.0


