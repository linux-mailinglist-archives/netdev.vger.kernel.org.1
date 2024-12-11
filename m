Return-Path: <netdev+bounces-151245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF199EDA08
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 23:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D7E18873AE
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 22:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F92820469D;
	Wed, 11 Dec 2024 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CzS40reN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D2D20456D
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 22:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956364; cv=none; b=dlzdZbbnZX9QLUDDbLNukN8QOXMOTsH0kXddJMWkMw+SlzvAzy53WAW06JhipHEqec9z6/RMSGjZjBTL1VUKkoAAocQxzg2lvSj5nZA2Eu6udjD3Gm88WcXcBAf0aJb0MF9+KFnzjOL9Dbhtp8YQYJLEBB71NF/j3GkAqT+XSMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956364; c=relaxed/simple;
	bh=/ipPID80lOfWAtFE1JfuL0fyBRP0NPdvpji+0aqWNPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAcrL5rxfQz+0xC6Gm+fW57NhKDaJysmQM1zHDnH/ydnmZN+sSgiuVo+mW76Rb/wxWge1/JWM9Y9B9s/zy108g65DuIMt0HLdXXX+tPp+YpagkGn/wcivYGd2uNM5JvezPISOpHWN8jXVcZB2BjQnsOkHe8uNHqkpQ8s9PEUx7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CzS40reN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733956362; x=1765492362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/ipPID80lOfWAtFE1JfuL0fyBRP0NPdvpji+0aqWNPE=;
  b=CzS40reNhYu4NllpfcQRY0WFRXLdI77ArKQobV6kLvfLyxqh1O1B6+eE
   aI9uAWKlm9JIRcM+MFH6eLls7G7vYjXVr1rF6TMM4stwb2oD+yOcgyUDv
   g5YfoUd3PNHlJ5mjpOBgYux15qamwHVwoW88NGBZLCWtJcszHNHfoTldG
   2LryY+PS+6QhAT4sm/wsloD4nqeutg0+enSPZZ1xne6og/F6BqzCu6bXx
   XVaHWlP7nc49cWGSHILuGPLzUNchOuFkfmZov5hptC/bw6d3qL5WZywe7
   20earpXjeuz6VFB8YWMaCsT42YR8wlqILKhzkY2D68RdF9uhaJFvfffg0
   A==;
X-CSE-ConnectionGUID: zgdV5ADgTEOZOn7g5etTHw==
X-CSE-MsgGUID: ESDQTxSoShykgFwHVSZnZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34599609"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="34599609"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 14:32:39 -0800
X-CSE-ConnectionGUID: XblL9bgDSTCl0iaNTd3EXg==
X-CSE-MsgGUID: 1Eu75P+yQxGkW0XzX7eFWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="96192929"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 11 Dec 2024 14:32:38 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	wojciech.drewek@intel.com,
	mateusz.polchlopek@intel.com,
	joe@perches.com,
	horms@kernel.org,
	jiri@resnulli.us,
	apw@canonical.com,
	lukas.bulwahn@gmail.com,
	dwaipayanray1@gmail.com,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 2/7] devlink: add devlink_fmsg_put() macro
Date: Wed, 11 Dec 2024 14:32:10 -0800
Message-ID: <20241211223231.397203-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241211223231.397203-1-anthony.l.nguyen@intel.com>
References: <20241211223231.397203-1-anthony.l.nguyen@intel.com>
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

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 include/net/devlink.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index fbb9a2668e24..b5e1427ea4d7 100644
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
2.42.0


