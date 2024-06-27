Return-Path: <netdev+bounces-107357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E4191AAB6
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38CD51C24B61
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C9F198A08;
	Thu, 27 Jun 2024 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e91ZuNQK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC1E198827
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501100; cv=none; b=aPI9s1+XFdF0erQquN3StDQqHCCb83EXyJ9h66Okz6XVruhMjTQKFMU/fcbP4dawi3fxMs5v9sMmJ5MJkePAbYI9j3PwRlQ9zsqGDjr8VXqVAhLvn6QosuYEYOa71unv22jHuQWJC94pik2vyXmmkHxxZpJAuKAz88/hsVnoNUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501100; c=relaxed/simple;
	bh=i7BbOZrYnpbGWibWnhCboLr9HlYFVCb4RkJceAzyCZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWdIFmOqCG8zsDNJvaJKLvejpm21YPl3i2HxlaHFc5626h5xl0BqLk003C1zVUjVnO/qFU4KfraCPDhNgs1NRsRCBqumUkS7cWdYqekLYrgERbAF5GLptgzzYVyAH/88+xEpVC2HX2y3dQ/BDKh30xOvaVpBbqdW0l0mjC7hLwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e91ZuNQK; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719501099; x=1751037099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i7BbOZrYnpbGWibWnhCboLr9HlYFVCb4RkJceAzyCZE=;
  b=e91ZuNQKvsh+dXMw0vy91ObwUdvFgY+2dUr0kteV/HgKxS4eEyBj2yp5
   YgEpHqFRHKHtChCxyzTIyUf3/blLXVOAnZEwvZebWQzR4Kw7gzqq4/+Me
   iOjjwbp1xhmbCDvAUNlWCgUz13lUPBztMziotU6Crud14ZQUlPLq854Rc
   rEuBmu0jPsU0L9UJLY00x3AUTdes8CrLa4FbVJuAwYdsT1xPk2mOAmNjV
   KL7Y6blLjFDWYoCFWWA75MuL+K8PK7IlYCxH1KVRYHfLxiOPip3OGLju5
   aETHRl8BBX1epFbOcPZ9Wf7XglEoSnPJsNhfgFddl3TX9+vklopzAYjBf
   w==;
X-CSE-ConnectionGUID: OwubtzVkQYOS7/AOu768XA==
X-CSE-MsgGUID: 80rub5ANQ5qEHy1+zb9p8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="27222466"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="27222466"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 08:11:38 -0700
X-CSE-ConnectionGUID: WrIrOiGpSsqI/TlOkqpf5Q==
X-CSE-MsgGUID: PS1PPfeTS2qpCFTEBRMGQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="48759670"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.132])
  by fmviesa003.fm.intel.com with ESMTP; 27 Jun 2024 08:11:36 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-next 2/7] ice: Add SDPs support for E825C
Date: Thu, 27 Jun 2024 17:09:26 +0200
Message-ID: <20240627151127.284884-11-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627151127.284884-9-karol.kolacinski@intel.com>
References: <20240627151127.284884-9-karol.kolacinski@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_ptp.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 28b82c634194..e38563905ca7 100644
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
@@ -2623,9 +2633,13 @@ static void ice_ptp_set_funcs_e82x(struct ice_pf *pf)
 		pf->ptp.info.getcrosststamp = ice_ptp_getcrosststamp_e82x;
 
 #endif /* CONFIG_ICE_HWTS */
-	pf->ptp.info.enable = ice_ptp_gpio_enable;
-	pf->ptp.info.verify = ice_verify_pin;
-	pf->ptp.ice_pin_desc = ice_pin_desc_e82x;
+	if (ice_is_e825c(&pf->hw)) {
+		pf->ptp.ice_pin_desc = ice_pin_desc_e825c;
+		pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e825c);
+	} else {
+		pf->ptp.ice_pin_desc = ice_pin_desc_e82x;
+		pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e82x);
+	}
 	pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e82x);
 	ice_ptp_setup_pin_cfg(pf);
 }
@@ -2673,6 +2687,8 @@ static void ice_ptp_set_caps(struct ice_pf *pf)
 	info->settime64 = ice_ptp_settime64;
 	info->n_per_out = GLTSYN_TGT_H_IDX_MAX;
 	info->n_ext_ts = GLTSYN_EVNT_H_IDX_MAX;
+	info->enable = ice_ptp_gpio_enable;
+	info->verify = ice_verify_pin;
 
 	if (ice_is_e810(&pf->hw))
 		ice_ptp_set_funcs_e810(pf, info);
-- 
2.45.2


