Return-Path: <netdev+bounces-120598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B21959EDA
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E987B26A7C
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCDD1AF4E8;
	Wed, 21 Aug 2024 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PG/vLyr0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A083C1A7AFA
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247458; cv=none; b=YuBSVU4wRl+TsX5ueCR8p63NbTxc9m+eUp/ukOLOz0mDP4J2ehQrWYYsL0XgvGcjtOjA0tNrv3MZ4O+laq8Uttxhjyj3jpaDD/W+AkiTGgN1BXFASz6K0IhyIIi7GAdlupvu17XQQrpEbpnjU8LAoFkHCs5+pRDCZmsOzu5Sp5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247458; c=relaxed/simple;
	bh=qitX9JQl+WyawhjAqWcOOFfcGblZAsoaspxmb9DYPOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AOtawW7lHAwxfq5uB/z3P29nGZ6wDuJPALrp4VtTKse0IUvYSlxNLFSlZJ3yGzXi1rSProSOCIsxk3dHtA1uv8cfqAWM3TGbF8t84FmjNbtl+q0+WJ2pYcDfFglRzwH33/eANb+8jRS74OuXixcNVV3fbCGjYH9TWZh27OG3Kxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PG/vLyr0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724247457; x=1755783457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qitX9JQl+WyawhjAqWcOOFfcGblZAsoaspxmb9DYPOA=;
  b=PG/vLyr0yNOShCMMQxUMufkH9Vqu+WlHpx1mXJaENLnEBVNxRrdUMBLl
   3MY7+3v7vUnUTZWGLEj3O9vilx9iFy2TAOXNd8cZjhXU+oGOiLlrJPng0
   KUnT5+SB53LSCxOeyLZ7J/mfqnIANc93JTSkh/wPHjdpVIfwDssGxgiV6
   6/H26BF4BuZp5Ip6P1kjZsqpCT/S4/S6sOumHVxQMI1zm/u1pA/CtlFfd
   L0jyb+pNXC60EPRQ7f/nHzVJ2aty0N03cU5ce7gmPj985TEi3Z2+nXNgr
   I784eECEsuGWkvyq9J9f9ohsLwWVUqXUOTuz01YO8+jYzEsdSzazG8uot
   A==;
X-CSE-ConnectionGUID: ClyRoDFVTNm6C2IC91UIsg==
X-CSE-MsgGUID: tyTtdQ8eQx+mszQ6caExEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="45131438"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="45131438"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 06:37:36 -0700
X-CSE-ConnectionGUID: uTDmp3cfQ0iRcc1xjKBj9w==
X-CSE-MsgGUID: n51exEYgQSmLUuP2ZUxS+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61071268"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa008.fm.intel.com with ESMTP; 21 Aug 2024 06:37:32 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2A1D628793;
	Wed, 21 Aug 2024 14:37:30 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Jiri Pirko <jiri@resnulli.us>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com,
	akpm@linux-foundation.org,
	willemb@google.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [PATCH iwl-next v3 2/6] devlink: add devlink_fmsg_put() macro
Date: Wed, 21 Aug 2024 15:37:10 +0200
Message-Id: <20240821133714.61417-3-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240821133714.61417-1-przemyslaw.kitszel@intel.com>
References: <20240821133714.61417-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devlink_fmsg_put() that dispatches based on the type
of the value to put, example: bool -> devlink_fmsg_bool_pair_put().

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
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
2.39.3


