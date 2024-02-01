Return-Path: <netdev+bounces-67772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FF6844E54
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 02:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479FE1C22970
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 01:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7114C524B;
	Thu,  1 Feb 2024 01:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ICJx1FP5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81793EAEE;
	Thu,  1 Feb 2024 01:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706749671; cv=none; b=Z02AxPe41bWRRDC9tke+VlRlCHClPBqqH69FT4lt/mYFRAUiRV4o6tjC3j8mCWkcYN8xhLl8IIPGzOBP8Qu7tmchD47GhQ8+478VlltIW7qRmjAtUOAZbRVEfwngArziv7d35Lhw/ebT3CG3mhxEMi/LDzDvVncqX7lvwu3aVeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706749671; c=relaxed/simple;
	bh=Q49t9tgKLdd3l/qVdsyAv3HTVljrJUbfMRdC2dUnPw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o87pEtxjFGAAwFClb6HLnRMU0VZEhkR89h3J+bmX5Y3NHWhbjv6onuVRZgNwk40zktSPsj+EwqAo0raEcpcZa6Yj67JivfPKw9c/2rR4yV903WoIyuoTugTJwM9AMN649Qb2qYbyHdT+jzo+sVcBZ4qzPWzAQO86LK7mJAz5H30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ICJx1FP5; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706749670; x=1738285670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q49t9tgKLdd3l/qVdsyAv3HTVljrJUbfMRdC2dUnPw0=;
  b=ICJx1FP52qRZJpOG61erIYiQWIoCpLG7G0M9tZ1bh5FNnM2h6+oWhCHW
   C9P11ZPt8umrUlw/SiPkpxZUVyNcAXTi4qJRGf/OhKarZE/+6/pr0irM5
   LUojRJlgOJTrXtDJBKjY+HO5SKrpRoqEIeYxPvZJWkaZxspzyOJBflTMI
   L43nuGZ5ydZ8/qh+zZ79clgQ5N7mC5JEACoNv7GEON8HEMn5uw0vVamn6
   jn6WBMM55pquCP7TrSw2owH3XmRNy5FVgdfyGZlakjhZet3js2f/XC9xk
   WZqOO1h6xRqyrtbUGqYt1qNWjjax6p/gB3eStfD1Q0ddAtWpvVL/aH7Pr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="11145819"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="11145819"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:07:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="37057406"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:07:48 -0800
Received: from debox1-desk4.lan (unknown [10.212.205.115])
	by linux.intel.com (Postfix) with ESMTP id 5236A580DF0;
	Wed, 31 Jan 2024 17:07:48 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: netdev@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	david.e.box@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 1/8] platform/x86/intel/sdsi: Set message size during writes
Date: Wed, 31 Jan 2024 17:07:40 -0800
Message-Id: <20240201010747.471141-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201010747.471141-1-david.e.box@linux.intel.com>
References: <20240201010747.471141-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New mailbox commands will support sending multi packet writes and updated
firmware now requires that the message size be written for all commands
along with the packet size. Since the driver doesn't perform writes larger
than the packet size, set the message size to the same value.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/sdsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index 556e7c6dbb05..a70c071de6e2 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -252,6 +252,7 @@ static int sdsi_mbox_cmd_write(struct sdsi_priv *priv, struct sdsi_mbox_info *in
 		  FIELD_PREP(CTRL_SOM, 1) |
 		  FIELD_PREP(CTRL_RUN_BUSY, 1) |
 		  FIELD_PREP(CTRL_READ_WRITE, 1) |
+		  FIELD_PREP(CTRL_MSG_SIZE, info->size) |
 		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
 	writeq(control, priv->control_addr);
 
-- 
2.34.1


