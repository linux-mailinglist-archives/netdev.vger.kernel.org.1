Return-Path: <netdev+bounces-213299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D54B247A2
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 12:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCBA27B20BE
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0078C2F3C25;
	Wed, 13 Aug 2025 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ge0px0Ix"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D8D2D46A9
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081960; cv=none; b=mUo3CPLpwEsTCivHWQn7pR5TwNtIIxBZz06lcPCXvKcYI+MCkHQiUPJoTq3aSGRO5dYL1bL8+JOm7RebuazosB0AbHnz448zi9AJgaodZW/ulsZN10LhPmQHr79sNAkhmRFoQNjhHFm99U3LDFRWrvCpRhVoBxvdziGg8OY82u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081960; c=relaxed/simple;
	bh=4z9xVP7KPmCNxufYbAPRjD9usg6SJ9c7GW/z2DZdyqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHQkyHkK5/1WCbJ3TGxkakX+HIiE70actNc/H0fgp4EbeeE/vdch1uEWgUdaIWMGF5XMViCYbMa5wPOFt+a7R5ycUki7Odpx5w0XmXN78jxaJE5Y0VYVZ2DNbIavIGgkOsK1Wd2wfdKEzSTFTqd+9Ad91WdaqhSL1ULJZoDIlV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ge0px0Ix; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755081959; x=1786617959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4z9xVP7KPmCNxufYbAPRjD9usg6SJ9c7GW/z2DZdyqQ=;
  b=ge0px0IxIaV/gXDSrCnu35jpw/BPItcjhl6mGkQTHF1ylzzIm/VMr92s
   DVflVwA+ZtHLYaPp6XPfhDQ2bVO/gafD/vpn0kGtP+DF18w06TyPcBdPz
   6TLhzRIUWterxImeZiQg1cDUMXu+q88fkb57dlidvJg05jvfdvNg4XE9a
   3Xhj+VriuAsLB9Kt6QPxKlV3kdrxUihOU9BuwumMQrh7VXptxp4AsI/Y5
   m/f+MONj5mz/5geQCXfzBtL3vcSEd0BHoA3aV/vGskqFSOTLwC0/1bJny
   rKbJufP85xeyFaho9rZYkZfqseR/dm3RV3WOPHvvaWUXDuSnG8RZDqoVP
   A==;
X-CSE-ConnectionGUID: KfZ7LELPQCyt8EsZK03GRQ==
X-CSE-MsgGUID: KBY98t/oR3SIiXSknyMRSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="44949618"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="44949618"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 03:45:58 -0700
X-CSE-ConnectionGUID: 3kpDtVxTRmO+3RqIleOZ0w==
X-CSE-MsgGUID: lA4uhLofR3uNdHGQ6DqQ8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="166066908"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 13 Aug 2025 03:45:57 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.245.219])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 400C728779;
	Wed, 13 Aug 2025 11:45:55 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	jeremiah.kyle@intel.com,
	leszek.pepiak@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net 2/8] i40e: fix idx validation in i40e_validate_queue_map
Date: Wed, 13 Aug 2025 12:45:12 +0200
Message-ID: <20250813104552.61027-3-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250813104552.61027-1-przemyslaw.kitszel@intel.com>
References: <20250813104552.61027-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

Ensure idx is within range of active/initialized TCs when iterating over
vf->ch[idx] in i40e_validate_queue_map().

Fixes: c27eac48160d ("i40e: Enable ADq and create queue channel/s on VF")
Cc: stable@vger.kernel.org
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index cb37b2ac56f1..1c4f86221255 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2466,8 +2466,10 @@ static int i40e_validate_queue_map(struct i40e_vf *vf, u16 vsi_id,
 	u16 vsi_queue_id, queue_id;
 
 	for_each_set_bit(vsi_queue_id, &queuemap, I40E_MAX_VSI_QP) {
-		if (vf->adq_enabled) {
-			vsi_id = vf->ch[vsi_queue_id / I40E_MAX_VF_VSI].vsi_id;
+		u16 idx = vsi_queue_id / I40E_MAX_VF_VSI;
+
+		if (vf->adq_enabled && idx < vf->num_tc) {
+			vsi_id = vf->ch[idx].vsi_id;
 			queue_id = (vsi_queue_id % I40E_DEFAULT_QUEUES_PER_VF);
 		} else {
 			queue_id = vsi_queue_id;
-- 
2.50.0


