Return-Path: <netdev+bounces-213301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA074B247AB
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 12:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1601B65E8C
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C77C2F656D;
	Wed, 13 Aug 2025 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j42eRtXv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C89B2F530F
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081962; cv=none; b=qmvfP5pA3janRnkrNoHr3mYn6fzJoHHDX3Nw1LtNuBqzFBuro46PMHWNC1/bjZDIFr1wFiLbWaLXZOD8Cl62zJbFh8Z5kAWpOhYvALNbybBXYBX9pdPYkLZ3zuQVGxRPyyoeEpR8ITg7R2drg2aXDq+IaJz0mUD/QaWdIJjg79o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081962; c=relaxed/simple;
	bh=zWpQ1c5L9NPlZEjWZnLW6PcxCzV9reX84W6tSG08Wtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuuYRz7JqgGcEwEV6kF0zbtHKSRu7O4uKUXBPwPMxq6ICFL3uV6a5GbZnp7+GdjETHQHT4HLFQCRvzpYFjTvGAshXAqAIsQVH92zxxf7yQ9MO3eTeW45+CzN1Ebaa5xBVRXAoUXC41biSIbQuy6VhbMPriJsDunA0ge+t5tINWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j42eRtXv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755081961; x=1786617961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zWpQ1c5L9NPlZEjWZnLW6PcxCzV9reX84W6tSG08Wtg=;
  b=j42eRtXvrD9FAV/7qZwJM5gaFVUVI+T5hcU0WLBruwHZKsGeZnnsNVKR
   7i3Psh/qY82HMYZs2Nr/ubjVYqmJY5oiCOm0brQEYbL+NdUBlU5lCLC57
   i+0tZdLN6pkwhvrO6HpG3fqLnv5R1gx27Jf70HcO427ZCA/9Hdkbr2aYA
   1fycSTXV7uX77HpeFpik3VoCojmpXfLn502bGli7QnFm8n3J2eikryyY6
   SALyxUu9EHq6+GQwZDfiB6l+NO1qmtRRMnXbm7VcSR/8YNTecFWvBjfRl
   cZr3rh8U7pnKt0o9YjldBCKNW1PVIRZS2S7e8y742SzMbwY86q5r+DJI2
   A==;
X-CSE-ConnectionGUID: np9QM8m5TzWKPTB3tsAAGA==
X-CSE-MsgGUID: MMiS6kZeQZCTo6WIw9X8nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="44949624"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="44949624"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 03:46:00 -0700
X-CSE-ConnectionGUID: IHL64nbVRseMDAx3NFzYjw==
X-CSE-MsgGUID: j4eYLnsZS0S5JxslVjayxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="166066915"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 13 Aug 2025 03:45:58 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.245.219])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id E670128785;
	Wed, 13 Aug 2025 11:45:56 +0100 (IST)
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
Subject: [PATCH iwl-net 4/8] i40e: fix input validation logic for action_meta
Date: Wed, 13 Aug 2025 12:45:14 +0200
Message-ID: <20250813104552.61027-5-przemyslaw.kitszel@intel.com>
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

Fix condition to check 'greater or equal' to prevent OOB dereference.

Fixes: e284fc280473 ("i40e: Add and delete cloud filter")
Cc: stable@vger.kernel.org
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index b6db4d78c02d..c85715f75435 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3603,7 +3603,7 @@ static int i40e_validate_cloud_filter(struct i40e_vf *vf,
 
 	/* action_meta is TC number here to which the filter is applied */
 	if (!tc_filter->action_meta ||
-	    tc_filter->action_meta > vf->num_tc) {
+	    tc_filter->action_meta >= vf->num_tc) {
 		dev_info(&pf->pdev->dev, "VF %d: Invalid TC number %u\n",
 			 vf->vf_id, tc_filter->action_meta);
 		goto err;
-- 
2.50.0


