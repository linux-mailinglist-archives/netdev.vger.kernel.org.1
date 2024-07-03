Return-Path: <netdev+bounces-108862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A15892618A
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BA20B28251
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF36017A920;
	Wed,  3 Jul 2024 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQ6w/oRE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2573C12D76E;
	Wed,  3 Jul 2024 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720012363; cv=none; b=BbN24awB/pgYdEYNH/1vJJREM3pq+ZRvoJADB/gqUIYlLiQ9rfEEma4Hss7Ra089T+pUWgCZ32ecdy0SskFWtWWTf43fevjm9uA2hOQ0mlNG6+yPEICj5pm6J2BZP2gUR3bj9Z/N1oplc35Z1Q9qDY5SlD+PLics04+FSZI76Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720012363; c=relaxed/simple;
	bh=TjSxyaf3Cir+Qz6O6R1xqKNcZgjVvLcFv4QVgnNtdf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bY8IkDrtOs95eiM+iusLRIk7lWWfCs3ikO870CumQTvYsk5vqlPjmEJLz7rJdBY//IRQgYgppmrMgMGllCKG6VZDV6aMBK3VazOIl1Is24xNP1Ow7v8I7gVr1tQvAxKK2leSGPsAf5btV1iOLCNtGm0zAhjjJHoYLrUHkn8KQ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AQ6w/oRE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720012362; x=1751548362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TjSxyaf3Cir+Qz6O6R1xqKNcZgjVvLcFv4QVgnNtdf8=;
  b=AQ6w/oREJcvEkQE1OYj3uCDiZtg9YTn/m97nfaoxLQmayE5Yt02XywS7
   jQvbQYbSbQl4aRwNS3D1CamV4SvAapNhy7Wx2N7Rv8KTqZtb0V4uFmEBo
   aAgTTUSrxmB+RAuAEaUfoYyYCkum8maQBhXgH+yBKI9j8gqZGiiD4xI6O
   IdHvMFUV5GKRYU3tT8weG06uw3xtFcVE7NjyOGTSsBhBp+k1prwXd6XqZ
   1+MnUGaOa6486OFM9Qg4bkz9nA0TXbDW8ONplContD+aTgWPMtlaVgGGI
   N/+VMeXU+Xew+2Rgrk634NaKJ5QONDewwCaIBd7INUcXI1rD6RShGPlN6
   g==;
X-CSE-ConnectionGUID: TQxfY0qNSda0SWv5ZoFWqg==
X-CSE-MsgGUID: dv01nnyBSBmuFd85P8YG/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27857099"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="27857099"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 06:12:32 -0700
X-CSE-ConnectionGUID: wGi9JZcbS0KE/MV3OggP2g==
X-CSE-MsgGUID: FshCUYNJTqKk6J4RMxP/Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46321569"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa010.fm.intel.com with ESMTP; 03 Jul 2024 06:12:28 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A18C428779;
	Wed,  3 Jul 2024 14:12:26 +0100 (IST)
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
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v1 2/6] devlink: add devlink_fmsg_put() macro
Date: Wed,  3 Jul 2024 08:59:18 -0400
Message-Id: <20240703125922.5625-3-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240703125922.5625-1-mateusz.polchlopek@intel.com>
References: <20240703125922.5625-1-mateusz.polchlopek@intel.com>
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


