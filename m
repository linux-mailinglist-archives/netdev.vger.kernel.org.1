Return-Path: <netdev+bounces-94266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE89C8BEE6A
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 22:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735E92841AF
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 20:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E555786E;
	Tue,  7 May 2024 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFNEz7Ik"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675A120315;
	Tue,  7 May 2024 20:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715115292; cv=none; b=t5fYkl17nmsqDYwx78p+bBV6VZZTsp9gTP2vwKdnghdhe2VlGr26uxhCmSEUJw3N2vxb1/0/HKw6Gsl86Xqwca97/r3OBdU72hCZI2wVC9Xa+cnUWaevLDEudk84YT2fTwLJ2OaAEOm1K7PkjYWj1ON2Ac8FeSwIRz2Tm4SmX48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715115292; c=relaxed/simple;
	bh=ByjaozowwXMBmPG6teJv9IpV569M7F1fPCHE8e+B4o0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uXM32ULzpbOaLQTZG6floxGwlh6EjCjiirubt8E2Jl59OyMRf6yVR3L8BhzM9HQZsEDWtfkvUuIwt/fY14dPktEexHThM1LBxbawlU8K3HMW96O1qxwniMhe+1TseHp3wmve5voZrLQGoXjjgueoxm+Dz4fcM5c/BHFBnrUVmtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFNEz7Ik; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715115290; x=1746651290;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ByjaozowwXMBmPG6teJv9IpV569M7F1fPCHE8e+B4o0=;
  b=oFNEz7IkNj2GgvOXF2r6CAmWNiV+j6sDa+t9kKnDzsV5YecKdDhhLnwI
   K7l1oXbCivtymBjo6f1UF032gqZlZ2SILa2YJc3KRzTuy+My7rZFdSBtC
   mLua8B91K4R26m/dWSB4f3nJAkdDrICJ7fS6tBeqJBChESPAl8ED0Ut1P
   iSH/MeKiQqmQvWXgH1z0fuVoLVNdMHk3vjaqpl1ykaAgRjFAlDiqxn44F
   z6i+Lnk3I6QgIrLRPgk/eXRgVxAabbrILOLik2ecwxoPTnopec6jyreBC
   pq/wCYCELTGLiH+4KUmF2yhLP29dcDeja/LdHxlqDgoyLNcqMwZRjW7Hx
   g==;
X-CSE-ConnectionGUID: 8Mg4w7WSRTiCB/9yfUidIA==
X-CSE-MsgGUID: qvaYYkptSFqtgcd5jD8Vtw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="21547342"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="21547342"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 13:54:49 -0700
X-CSE-ConnectionGUID: XdIgqTA6QnCcgd6HpXiE8Q==
X-CSE-MsgGUID: bXqcioePQBKRkpCvFvxQiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="28615166"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 07 May 2024 13:54:49 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	peterz@infradead.org,
	linux-kernel@vger.kernel.org,
	Arpana Arland <arpanax.arland@intel.com>
Subject: [PATCH net-next] ice: add and use roundup_u64 instead of open coding equivalent
Date: Tue,  7 May 2024 13:54:39 -0700
Message-ID: <20240507205441.1657884-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

In ice_ptp_cfg_clkout(), the ice driver needs to calculate the nearest next
second of a current time value specified in nanoseconds. It implements this
using div64_u64, because the time value is a u64. It could use div_u64
since NSEC_PER_SEC is smaller than 32-bits.

Ideally this would be implemented directly with roundup(), but that can't
work on all platforms due to a division which requires using the specific
macros and functions due to platform restrictions, and to ensure that the
most appropriate and fast instructions are used.

The kernel doesn't currently provide any 64-bit equivalents for doing
roundup. Attempting to use roundup() on a 32-bit platform will result in a
link failure due to not having a direct 64-bit division.

The closest equivalent for this is DIV64_U64_ROUND_UP, which does a
division always rounding up. However, this only computes the division, and
forces use of the div64_u64 in cases where the divisor is a 32bit value and
could make use of div_u64.

Introduce DIV_U64_ROUND_UP based on div_u64, and then use it to implement
roundup_u64 which takes a u64 input value and a u32 rounding value.

The name roundup_u64 matches the naming scheme of div_u64, and future
patches could implement roundup64_u64 if they need to round by a multiple
that is greater than 32-bits.

Replace the logic in ice_ptp.c which does this equivalent with the newly
added roundup_u64.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c |  3 +--
 include/linux/math64.h                   | 29 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 0f17fc1181d2..a95af8d638a0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1714,8 +1714,7 @@ static int ice_ptp_cfg_clkout(struct ice_pf *pf, unsigned int chan,
 	 * maintaining phase
 	 */
 	if (start_time < current_time)
-		start_time = div64_u64(current_time + NSEC_PER_SEC - 1,
-				       NSEC_PER_SEC) * NSEC_PER_SEC + phase;
+		start_time = roundup_u64(current_time, NSEC_PER_SEC) + phase;
 
 	if (ice_is_e810(hw))
 		start_time -= E810_OUT_PROP_DELAY_NS;
diff --git a/include/linux/math64.h b/include/linux/math64.h
index bf74478926d4..553043ebf4cc 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -301,6 +301,19 @@ u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div);
 #define DIV64_U64_ROUND_UP(ll, d)	\
 	({ u64 _tmp = (d); div64_u64((ll) + _tmp - 1, _tmp); })
 
+/**
+ * DIV_U64_ROUND_UP - unsigned 64bit divide with 32bit divisor rounded up
+ * @ll: unsigned 64bit dividend
+ * @d: unsigned 32bit divisor
+ *
+ * Divide unsigned 64bit dividend by unsigned 32bit divisor
+ * and round up.
+ *
+ * Return: dividend / divisor rounded up
+ */
+#define DIV_U64_ROUND_UP(ll, d)		\
+	({ u32 _tmp = (d); div_u64((ll) + _tmp - 1, _tmp); })
+
 /**
  * DIV64_U64_ROUND_CLOSEST - unsigned 64bit divide with 64bit divisor rounded to nearest integer
  * @dividend: unsigned 64bit dividend
@@ -346,4 +359,20 @@ u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div);
 		div_s64((__x - (__d / 2)), __d);	\
 }							\
 )
+
+/**
+ * roundup_u64 - Round up a 64bit value to the next specified 32bit multiple
+ * @x: the value to up
+ * @y: 32bit multiple to round up to
+ * @y: multiple to round up to
+ *
+ * Rounds @x to the next multiple of @y. For 32bit @x values, see roundup and
+ * the faster round_up() for powers of 2.
+ *
+ * Return: rounded up value
+ */
+static inline u64 roundup_u64(u64 x, u32 y)
+{
+	return DIV_U64_ROUND_UP(x, y) * y;
+}
 #endif /* _LINUX_MATH64_H */
-- 
2.41.0


