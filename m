Return-Path: <netdev+bounces-150824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85C69EBAD2
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4D8282CEF
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 20:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C587422758D;
	Tue, 10 Dec 2024 20:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lKf8BNzh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE388226873
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 20:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733862451; cv=none; b=gqAmq9+EFVTxVjKCsfGyRpAf5Z7xtZQNMOYSFkS93YrogxSwGkyoVseJBRDbloSRvpIar3LD3+P/OXKKFQVlGHqzY91965jQ8cte8aO2uWzyK3xE+xm0Tyq1SuICuEDAcBz+3enm6NrHCXywWiA5w3s4jVnJdO5ox4cDYrRcBHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733862451; c=relaxed/simple;
	bh=skVQJEQjh8PC596WXX1gHp2HG9BJ5E3hayeoU1RTyeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fURNKB8/I9BYFhu99NcrjbSZYVb4RnklSYooJQKWI5q3hF+AzN3gAr3IrKiz2lYpHTTVeWOpdbQ+q6EjBabCN1FXMQDUvktz6wot7a7gyu58HUijZOkEmyGqp5tlNZrOcJxOaez05VdtkHtjycWZbmNhVkuP6laNiNqdoKDUKHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lKf8BNzh; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733862450; x=1765398450;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=skVQJEQjh8PC596WXX1gHp2HG9BJ5E3hayeoU1RTyeQ=;
  b=lKf8BNzhSB41XWBdg1C3/45+9gDt2VNiL9BKpdjXUD9R9InOOQBQm6aq
   sfd55D7ShKJoMTMZFat9bKUstxJuyO+8bTUy48V/ZeFDxqw1tmNzgffk2
   DW0wtbRT9Xz6yq9c/kePacj6ShMjaO9nJJ0XDhR4zuTNL09M7G4L6E7nN
   PZZ54ryUjpKxxzPDs7IcVRJd3NK04luhoSeAgOewvBsjsP3hpXXXpYpfU
   9thqafBuR9LMchKmbUZQsM0bnJQ7QKKBrJvzjCIJO5eE6GNcMYPtVCvlL
   5+W9ur5c8kERvYCDX2SiB4UO7z5jhSgAbI8YOUd7uH6BHCD3NOX77VkF/
   Q==;
X-CSE-ConnectionGUID: QDbm37PVRiWciR6Wq20DJA==
X-CSE-MsgGUID: RLOKWQDfRJGRlvBrMYWtXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34147283"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="34147283"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:27:27 -0800
X-CSE-ConnectionGUID: fdP03dYbSZyvoGIaw0ef7g==
X-CSE-MsgGUID: LIBi5eFVT9OTZmxBU0BcvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="126424082"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:27:27 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 10 Dec 2024 12:27:11 -0800
Subject: [PATCH net-next v10 02/10] lib: packing: demote truncation error
 in pack() to a warning in __pack()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-packing-pack-fields-and-ice-implementation-v10-2-ee56a47479ac@intel.com>
References: <20241210-packing-pack-fields-and-ice-implementation-v10-0-ee56a47479ac@intel.com>
In-Reply-To: <20241210-packing-pack-fields-and-ice-implementation-v10-0-ee56a47479ac@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.2

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Most of the sanity checks in pack() and unpack() can be covered at
compile time. There is only one exception, and that is truncation of the
uval during a pack() operation.

We'd like the error-less __pack() to catch that condition as well. But
at the same time, it is currently the responsibility of consumer drivers
(currently just sja1105) to print anything at all when this error
occurs, and then discard the return code.

We can just print a loud warning in the library code and continue with
the truncated __pack() operation. In practice, having the warning is
very important, see commit 24deec6b9e4a ("net: dsa: sja1105: disallow
C45 transactions on the BASE-TX MDIO bus") where the bug was caught
exactly by noticing this print.

Add the first print to the packing library, and at the same time remove
the print for the same condition from the sja1105 driver, to avoid
double printing.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/dsa/sja1105/sja1105_static_config.c |  8 ++------
 lib/packing.c                                   | 26 ++++++++++---------------
 2 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_static_config.c b/drivers/net/dsa/sja1105/sja1105_static_config.c
index baba204ad62f6b507a6ccf3337248dd02b777249..3d790f8c6f4dab3640ede014345ef469fefb7085 100644
--- a/drivers/net/dsa/sja1105/sja1105_static_config.c
+++ b/drivers/net/dsa/sja1105/sja1105_static_config.c
@@ -26,12 +26,8 @@ void sja1105_pack(void *buf, const u64 *val, int start, int end, size_t len)
 		pr_err("Start bit (%d) expected to be larger than end (%d)\n",
 		       start, end);
 	} else if (rc == -ERANGE) {
-		if ((start - end + 1) > 64)
-			pr_err("Field %d-%d too large for 64 bits!\n",
-			       start, end);
-		else
-			pr_err("Cannot store %llx inside bits %d-%d (would truncate)\n",
-			       *val, start, end);
+		pr_err("Field %d-%d too large for 64 bits!\n",
+		       start, end);
 	}
 	dump_stack();
 }
diff --git a/lib/packing.c b/lib/packing.c
index f237b8af99f5fa8e839c38126769c50b2bfe6361..09a2d195b9433b61c86f3b63ff019ab319c83e97 100644
--- a/lib/packing.c
+++ b/lib/packing.c
@@ -59,8 +59,17 @@ static void __pack(void *pbuf, u64 uval, size_t startbit, size_t endbit,
 	 */
 	int plogical_first_u8 = startbit / BITS_PER_BYTE;
 	int plogical_last_u8 = endbit / BITS_PER_BYTE;
+	int value_width = startbit - endbit + 1;
 	int box;
 
+	/* Check if "uval" fits in "value_width" bits.
+	 * The test only works for value_width < 64, but in the latter case,
+	 * any 64-bit uval will surely fit.
+	 */
+	WARN(value_width < 64 && uval >= (1ull << value_width),
+	     "Cannot store 0x%llx inside bits %zu-%zu - will truncate\n",
+	     uval, startbit, endbit);
+
 	/* Iterate through an idealistic view of the pbuf as an u64 with
 	 * no quirks, u8 by u8 (aligned at u8 boundaries), from high to low
 	 * logical bit significance. "box" denotes the current logical u8.
@@ -143,9 +152,6 @@ static void __pack(void *pbuf, u64 uval, size_t startbit, size_t endbit,
 int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
 	 u8 quirks)
 {
-	/* width of the field to access in the pbuf */
-	u64 value_width;
-
 	/* startbit is expected to be larger than endbit, and both are
 	 * expected to be within the logically addressable range of the buffer.
 	 */
@@ -153,19 +159,7 @@ int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
 		/* Invalid function call */
 		return -EINVAL;
 
-	value_width = startbit - endbit + 1;
-	if (unlikely(value_width > 64))
-		return -ERANGE;
-
-	/* Check if "uval" fits in "value_width" bits.
-	 * If value_width is 64, the check will fail, but any
-	 * 64-bit uval will surely fit.
-	 */
-	if (value_width < 64 && uval >= (1ull << value_width))
-		/* Cannot store "uval" inside "value_width" bits.
-		 * Truncating "uval" is most certainly not desirable,
-		 * so simply erroring out is appropriate.
-		 */
+	if (unlikely(startbit - endbit >= 64))
 		return -ERANGE;
 
 	__pack(pbuf, uval, startbit, endbit, pbuflen, quirks);

-- 
2.47.0.265.g4ca455297942


