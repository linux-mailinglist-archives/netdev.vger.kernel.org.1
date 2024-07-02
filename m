Return-Path: <netdev+bounces-108488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E04923F4D
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61BF1C21D1D
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8861B5820;
	Tue,  2 Jul 2024 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FH0feRO6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462561B4C41
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927902; cv=none; b=D4/wOZI5n1we38Bv4Y4R9fZ4qU1166Ffbpr5PFpKMNMZl1zLnNh8AHd+NVwEENLmHZLEgObUR1qBFTqgYSgjOAP5o15x6rl7v83qlxErZtf4k2M8FC7xoMPd1qo8N/fpXkJw11+6J7cT+zvHGma7wF4sRhKh7PMmgoZhwGehbEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927902; c=relaxed/simple;
	bh=TksVP2DYBRUrQNbmSt8x5N5u/CVzkVSpIvGDTb+oyQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8wqCm/4it5LMnbTQmxZZsOH1nOADWxKaRe6eot1/sXDOmTlFQ4918zeKqqTlazp7bQAqZarYUiv13zn/ikQNgUfuyeG3e9JEoJtBY+hKVQUEGP/2pAw6R6VMxBGDp0vrqiaJupL/8RfqcovuHgMRpbxoXWjEGoe+g+ddeXrnqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FH0feRO6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719927901; x=1751463901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TksVP2DYBRUrQNbmSt8x5N5u/CVzkVSpIvGDTb+oyQ8=;
  b=FH0feRO671lLZn7jc6vG9/1ybRnJgTiH31u0YR7zqv8bLJy9x/BAp5Nx
   hRFrXx84j6FhEbCvp3p+JN83fqYyBGPZLgKMYE3eL0XYklBQ9ic1lALvS
   7dz4xMoq4dF6AQY9VpjkrpwbA5uZcL7wPcFAxVc4hOObn7cqlO6nZTgZ6
   CuB/n3dhLoeqndvX+vOZAKvsH48mEH0uD0EMW48f9fVMh/DI+S3ltywXV
   D/nZ+wItj0A0Q1Pbh/kLSW7VvrlQTrJYNcEXNDxeurLPT+hZxV3epipO0
   6s31jDSXPbUbn2yMgJUmuVKgdTbSOclSJw4g/tVX1fwphr6l+cpIYFWEA
   Q==;
X-CSE-ConnectionGUID: c78jD229Sf2XRj339Pwn4g==
X-CSE-MsgGUID: IyVUD4QgSsirvhaJ8QqU7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16826407"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="16826407"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 06:45:01 -0700
X-CSE-ConnectionGUID: RMd3SVy+SjKZ3rnfDiU2FQ==
X-CSE-MsgGUID: /MhW94SjQqGuI49TpXZCMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="83460512"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.132])
  by orviesa001.jf.intel.com with ESMTP; 02 Jul 2024 06:44:59 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH v2 iwl-next 2/7] ice: Add SDPs support for E825C
Date: Tue,  2 Jul 2024 15:41:31 +0200
Message-ID: <20240702134448.132374-11-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702134448.132374-9-karol.kolacinski@intel.com>
References: <20240702134448.132374-9-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support of PTP SDPs (Software Definable Pins) for E825C products.

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
V1 -> V2: Removed redundant n_pins assignment and enable and verify move

 drivers/net/ethernet/intel/ice/ice_ptp.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 030e55a39ef5..392b0d2fa61f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -20,6 +20,16 @@ static const struct ice_ptp_pin_desc ice_pin_desc_e82x[] = {
 	{  ONE_PPS,   {  5, -1 }},
 };
 
+static const struct ice_ptp_pin_desc ice_pin_desc_e825c[] = {
+	/* name,      gpio */
+	{  SDP0,      {  0,  0 }},
+	{  SDP1,      {  1,  1 }},
+	{  SDP2,      {  2,  2 }},
+	{  SDP3,      {  3,  3 }},
+	{  TIME_SYNC, { -1,  4 }},
+	{  ONE_PPS,   {  5, -1 }},
+};
+
 static const struct ice_ptp_pin_desc ice_pin_desc_e810[] = {
 	/* name,      gpio */
 	{  SDP0,      { 0,  0 }},
@@ -2624,8 +2634,14 @@ static void ice_ptp_set_funcs_e82x(struct ice_pf *pf)
 #endif /* CONFIG_ICE_HWTS */
 	pf->ptp.info.enable = ice_ptp_gpio_enable;
 	pf->ptp.info.verify = ice_verify_pin;
-	pf->ptp.ice_pin_desc = ice_pin_desc_e82x;
-	pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e82x);
+
+	if (ice_is_e825c(&pf->hw)) {
+		pf->ptp.ice_pin_desc = ice_pin_desc_e825c;
+		pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e825c);
+	} else {
+		pf->ptp.ice_pin_desc = ice_pin_desc_e82x;
+		pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e82x);
+	}
 	ice_ptp_setup_pin_cfg(pf);
 }
 
-- 
2.45.2


