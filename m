Return-Path: <netdev+bounces-149810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88F49E7914
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 20:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5767E161D20
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 19:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F0921B8ED;
	Fri,  6 Dec 2024 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FW80srSZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BC821B1A9
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513752; cv=none; b=jMIQIykQxrwpy/R7AQBl7le0M/49GUU2FKGMYaExYo2HNtlaMxLAnmw/9+JxlV+eBF3uuMHQ8tDLWmjTAnFd2pu8hgVUaocEKahyeLWMnOSjCORr9il73XVp1P8bVs0VV9gzmzftmfDhHq9ybvry15FUkUmpIBmDEHzMb59SldU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513752; c=relaxed/simple;
	bh=T3ynUJ8Fi2Tne6qE3+hRozh+blkshHznDjbF8EfqyO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wx3BexdwX9iCZOf5/ML7mZPJKCISV4AcEQUr8NsO9gBMdd6j14x1PQ+uqalP5bdrqXbWNp+xVNB6KbtCQ647W7b/OgVrpnrbU2UxXP5rwKbLiR5HDDjCPiLtJ3xkAXzBKsGB46DihgkWgoyiVjVZYxv38/VmPG8eJLrUF6ZYxG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FW80srSZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733513751; x=1765049751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T3ynUJ8Fi2Tne6qE3+hRozh+blkshHznDjbF8EfqyO8=;
  b=FW80srSZQJ50oVl42vtz71xfYt+TS5DUX9gO2PF177pmkVsCPePbLg4L
   LKwb/1VV2AALaE1YBjofVeck6sYFsMlzAeANPrP9hKrCFNe45wsbvAuDr
   P60e9Mfyv1LprUC1nXHEvkj3uzDlZ1OuuH7gDiceFSiNlEb9MVXjAH6di
   WLIGTptzm30WwZpB09w13N0n4WKWTvTsRcwIm8InWPrgvL7738cRj0DsQ
   GvkhZDlNO/g5MNmfCwxGW/4OCtS3mBrZziChmo08Os/mjfwRFDeZlGMS3
   bTvf56kG3r1qEM8XbUm6i1BjrYxyuQ67co5IIFFyJTtqKnjg/WvYMHsXn
   g==;
X-CSE-ConnectionGUID: N6DycI52TQq6dPcD6uowAQ==
X-CSE-MsgGUID: dU/9H+aIQgutZIIfHkAzEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="33226574"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="33226574"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 11:35:46 -0800
X-CSE-ConnectionGUID: Mq9emR7uQtOG2WS5LLvZPQ==
X-CSE-MsgGUID: ap+4P27WSZaxwZ9maoA7Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="94301406"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 06 Dec 2024 11:35:47 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	grzegorz.nitka@intel.com,
	richardcochran@gmail.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 3/4] ice: Fix ETH56G FC-FEC Rx offset value
Date: Fri,  6 Dec 2024 11:35:40 -0800
Message-ID: <20241206193542.4121545-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241206193542.4121545-1-anthony.l.nguyen@intel.com>
References: <20241206193542.4121545-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Fix ETH56G FC-FEC incorrect Rx offset value by changing it from -255.96
to -469.26 ns.

Those values are derived from HW spec and reflect internal delays.
Hex value is a fixed point representation in Q23.9 format.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
index 585ce200c60f..bee674b43e13 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
@@ -131,7 +131,7 @@ struct ice_eth56g_mac_reg_cfg eth56g_mac_cfg[NUM_ICE_ETH56G_LNK_SPD] = {
 		.rx_offset = {
 			.serdes = 0xffffeb27, /* -10.42424 */
 			.no_fec = 0xffffcccd, /* -25.6 */
-			.fc = 0xfffe0014, /* -255.96 */
+			.fc = 0xfffc557b, /* -469.26 */
 			.sfd = 0x4a4, /* 2.32 */
 			.bs_ds = 0x32 /* 0.0969697 */
 		}
-- 
2.42.0


