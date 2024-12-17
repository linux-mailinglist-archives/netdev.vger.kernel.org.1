Return-Path: <netdev+bounces-152719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 363F29F5879
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 22:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282AD188B33F
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 21:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783B61F9415;
	Tue, 17 Dec 2024 21:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2kUwDnh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BB91F9EAA
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 21:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469732; cv=none; b=AEXhHSJRSWU+euxVIJN7cuoLv1wI18/gO4ZroWfB+0qsTsvouL5yVjhfS1+pHnmuwv0NBBKXWrYTtoisljwg2YNnAzh8b+uzyc5IH/YI2G0tLdwr2PdAloTQX9+Q+j/mYyDtljnABgzCwjEgZFxaZA92zxLyIOixe3K1eqGTZ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469732; c=relaxed/simple;
	bh=IXkXg69wbt2m9zSjVm/D2OAKlEca6Qb6vTLu4GFD83k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOqi5GP+kG6vthfLwMtFVHy43t2LMQTDBXiHrWQnfvvqTv8Y++RK38xgDA2IzZcIgWezivrusy+yKJUUofrv+swOCdA39+YfaEHNAC/17bh5ioXVUPjE4OS/6HgXn57roCM+JJtTZdPvDQElP2ykThNC7griEhqaa/QlFZw3Hnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2kUwDnh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734469731; x=1766005731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IXkXg69wbt2m9zSjVm/D2OAKlEca6Qb6vTLu4GFD83k=;
  b=c2kUwDnhBX7btN8wqnb9CPbi1S74RQIGR+VHoJlAWvDKiAZuVA9ec+e5
   HlmHJmg/EODBk9kKj8kLooLsmiLuBXNRDzYOOHYH0eDQHB9xEHdT72ZlT
   0iuQrhBrFAZH3burywrxs9uAvWLUqC+rKzC+UAbfIMnuc3unS3L3FFdJz
   BU5elKpUv9UVoBX5keHzTw1U42qXbedCY2Rh0BBAtZF8QJBJi1dcU+v8i
   Tqz+PUCjWAujdCxJQ+aNkRd0G0F/UOwHid5jhE2mJ1kNGw4v6xAmV41yy
   eL+W3EkaWGZcyBPghL+RIuSn6MBZgEgpjxKdCAXiQVbwsrSFmS0nBDgPp
   w==;
X-CSE-ConnectionGUID: hmFRRdW4R2mptRmB4Cpzyw==
X-CSE-MsgGUID: 8nWA5YXmRoi++vLdn/VB1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="34794834"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="34794834"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 13:08:50 -0800
X-CSE-ConnectionGUID: XyYvSRBfSim3eTfAT55Gog==
X-CSE-MsgGUID: hDAUtNPaTm2DqByu4zlDIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="97436303"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 17 Dec 2024 13:08:48 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	mateusz.polchlopek@intel.com,
	joe@perches.com,
	horms@kernel.org,
	jiri@resnulli.us,
	apw@canonical.com,
	lukas.bulwahn@gmail.com,
	dwaipayanray1@gmail.com,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next v2 2/6] devlink: add devlink_fmsg_put() macro
Date: Tue, 17 Dec 2024 13:08:29 -0800
Message-ID: <20241217210835.3702003-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217210835.3702003-1-anthony.l.nguyen@intel.com>
References: <20241217210835.3702003-1-anthony.l.nguyen@intel.com>
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
2.47.1


