Return-Path: <netdev+bounces-111042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E25D92F837
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 11:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC421C2186E
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 09:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E91B157E8B;
	Fri, 12 Jul 2024 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2CJrjJ8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2B914D44E;
	Fri, 12 Jul 2024 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720777495; cv=none; b=TAEDuRaFYqKeB1vsyYohYKZxY0o3x3cussVt3B77eJFPbxm/aLEeUMUVaAvKkB2BmJBtDOiTCRvPM+BDSeBgHrrhuUPxbZpA/azO/Tg8OPY2H5OZA4g2HDNUnrNuPa25tSgwNH2Akr7HogVVqjAwLGF2zRhAzDuEhDilc0q3RGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720777495; c=relaxed/simple;
	bh=POev4s+Ksi1BGws715Coqmct4eY/UyjEjO3Tdt/94Hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HDJldqbrfgoQI/gzA/BGEfHehAs0sWj5JAeEiUgKWiaDR/8cZjcgFTL8PtBDgN7Y9/JozRq/tdcm3SmYgJyIapQnTlU2vfbTR3PjzJ9Q5NienWORorViAJUP//zFf0WzTZTwc2JRh5GkeKznQw/Ms28YQ+Il/9ZROnHcYPADSI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2CJrjJ8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720777494; x=1752313494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=POev4s+Ksi1BGws715Coqmct4eY/UyjEjO3Tdt/94Hk=;
  b=Y2CJrjJ84FvUJCQ3eohoHQgZIMvjyuPhzFSCZfjYxKiJX0MRzx3KR0bK
   bwfFDV1Vvz2x+eftCCw2ncofOpdk0syu65VKgV0o6etSRmsnsJFbSZFFs
   1nzJblQBoVSNuSD0uPoAHIUSq2qNbDFFQ7HxaXxiKDrYwerflVW/9unK6
   Eju3x0HFvUMMD+cyB6tl3xDddLjyMHNmQjIYgB75MCb8b3jgAt24JkmWP
   EKCm/X1/dXKn9dxXz0ROEg8Qc0lqYVOJbnyFyK+62NZ5O+3X29qrFQSV0
   MEWVzxUBKBZDcNUv5JHHc+SbS/uGzmfMrvDlwjWMVanJ+DHka4lVoXcQi
   g==;
X-CSE-ConnectionGUID: A8QnijM1ROefJNb8m/GZXw==
X-CSE-MsgGUID: 6WhCWCh/T9yZ86LVffoNlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18076961"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="18076961"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 02:44:53 -0700
X-CSE-ConnectionGUID: aywOp73iQoet+uQ2ePn+VQ==
X-CSE-MsgGUID: 3xygCHurSfW7mWIqbWhASg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="49524308"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa007.jf.intel.com with ESMTP; 12 Jul 2024 02:44:50 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2A1D31241E;
	Fri, 12 Jul 2024 10:44:48 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com,
	akpm@linux-foundation.org,
	willemb@google.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v2 2/6] devlink: add devlink_fmsg_put() macro
Date: Fri, 12 Jul 2024 05:32:47 -0400
Message-Id: <20240712093251.18683-3-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240712093251.18683-1-mateusz.polchlopek@intel.com>
References: <20240712093251.18683-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Add devlink_fmsg_put() that dispatches based on the type
of the value to put, example: bool -> devlink_fmsg_bool_pair_put().

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 include/net/devlink.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index db5eff6cb60f..85739bb731c1 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1261,6 +1261,17 @@ enum devlink_trap_group_generic_id {
 		.min_burst = _min_burst,				      \
 	}
 
+#define devlink_fmsg_put(fmsg, name, value) (			\
+	_Generic((value),					\
+		bool :		devlink_fmsg_bool_pair_put,	\
+		u8 :		devlink_fmsg_u8_pair_put,	\
+		u16 :		devlink_fmsg_u32_pair_put,	\
+		u32 :		devlink_fmsg_u32_pair_put,	\
+		u64 :		devlink_fmsg_u64_pair_put,	\
+		char * :	devlink_fmsg_string_pair_put,	\
+		const char * :	devlink_fmsg_string_pair_put)	\
+	(fmsg, name, (value)))
+
 enum {
 	/* device supports reload operations */
 	DEVLINK_F_RELOAD = 1UL << 0,
-- 
2.38.1


