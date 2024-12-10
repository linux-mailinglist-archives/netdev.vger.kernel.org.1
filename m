Return-Path: <netdev+bounces-150825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8A49EBAD3
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD5C1888761
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 20:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A668227BBD;
	Tue, 10 Dec 2024 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JmDHOJH3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8863D22687F
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 20:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733862452; cv=none; b=c727wRaq7Kjxkp2Eowaiq8oYa4p4R/ze25Kcp63ca2ksXEBJq8ouAcCvUON1TZ4Ze7p2ccQQt6iMuFXiXa9puzx4fxR3gp+PIowEAv820ZX9WScdMaijRfPBmWTsKp3sz1Aoj3vTGuD1Dn6lYsMJkZ9lyo7kuLrKkG5zpUrbY1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733862452; c=relaxed/simple;
	bh=0X7DkGvuPPSGukzRFz4wxFD07KL54UfcNbYUvwu7034=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ov/BYA2YPkyOmUeP38enOPbxCuHQDuvVe9jLBxVpMp118mDz58S0c6zX8RmoZ3YLYEhknkhbmjHFbpKX/us6Y0oaSs48jizYQgImdKsr8T0QQsWsuvbrs+kG3sRhoVCtEQeyEa1uhTOXELxjxNcigTKn6dZbKJ9I2PuxCMeMzvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JmDHOJH3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733862450; x=1765398450;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=0X7DkGvuPPSGukzRFz4wxFD07KL54UfcNbYUvwu7034=;
  b=JmDHOJH3Zu48BtwJmcun6xBZKiL8sHAAQvTcjhjzxvi1WIo2xbuieh4K
   qrW+DiLJQf8P0qYMD06ImJ7JVzYTGiXezxfg+H6pwjyXDCxqiJq8H24qU
   u+5Kr1+6oIj7tup+u6ONVDxw/2g34a9ivI460Xo41O7POQdpF4bDdbn4j
   6bFwaWS6Zh9MY5losBaAbLDzAhmsZT6K4ZqgaIYEalK8SD1ggEQwG127Z
   2pXHTdBkuaoUwn8IpdBVEZZ2j9qWaW3pFn2wm6AyAaFxBuvmfwKKVDo4n
   od4Nvo9MNuQSYnp0x2Ti6HLc7MHvkWLZREaxlCM3eFVwIOZCH6S8YBcCt
   A==;
X-CSE-ConnectionGUID: UfYGE5/vTsmSAR6BMEazVw==
X-CSE-MsgGUID: DlZQ0vkORLq1AWXQtXEAoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34147296"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="34147296"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:27:28 -0800
X-CSE-ConnectionGUID: bPpEgIFkRiale5Kv/vxpqw==
X-CSE-MsgGUID: nFXX8BhWR7WqbzRoQmu6kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="126424089"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:27:28 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 10 Dec 2024 12:27:13 -0800
Subject: [PATCH net-next v10 04/10] lib: packing: document recently added
 APIs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-packing-pack-fields-and-ice-implementation-v10-4-ee56a47479ac@intel.com>
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

Extend the documentation for the packing library, covering the intended use
for the recently added APIs. This includes the pack() and unpack() macros,
as well as the pack_fields() and unpack_fields() macros.

Add a note that the packing() API is now deprecated in favor of pack() and
unpack().

For the pack_fields() and unpack_fields() APIs, explain the rationale for
when a driver may want to select this API. Provide an example which shows
how to define the fields and call the pack_fields() and unpack_fields()
macros.

Co-developed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Documentation/core-api/packing.rst | 118 +++++++++++++++++++++++++++++++++++--
 1 file changed, 113 insertions(+), 5 deletions(-)

diff --git a/Documentation/core-api/packing.rst b/Documentation/core-api/packing.rst
index 821691f23c541cee27995bb1d77e23ff04f82433..0ce2078c8e13dd54a5ab215ecebae750ef173ae9 100644
--- a/Documentation/core-api/packing.rst
+++ b/Documentation/core-api/packing.rst
@@ -227,11 +227,119 @@ Intended use
 
 Drivers that opt to use this API first need to identify which of the above 3
 quirk combinations (for a total of 8) match what the hardware documentation
-describes. Then they should wrap the packing() function, creating a new
-xxx_packing() that calls it using the proper QUIRK_* one-hot bits set.
+describes.
+
+There are 3 supported usage patterns, detailed below.
+
+packing()
+^^^^^^^^^
+
+This API function is deprecated.
 
 The packing() function returns an int-encoded error code, which protects the
 programmer against incorrect API use.  The errors are not expected to occur
-during runtime, therefore it is reasonable for xxx_packing() to return void
-and simply swallow those errors. Optionally it can dump stack or print the
-error description.
+during runtime, therefore it is reasonable to wrap packing() into a custom
+function which returns void and swallows those errors. Optionally it can
+dump stack or print the error description.
+
+.. code-block:: c
+
+  void my_packing(void *buf, u64 *val, int startbit, int endbit,
+                  size_t len, enum packing_op op)
+  {
+          int err;
+
+          /* Adjust quirks accordingly */
+          err = packing(buf, val, startbit, endbit, len, op, QUIRK_LSW32_IS_FIRST);
+          if (likely(!err))
+                  return;
+
+          if (err == -EINVAL) {
+                  pr_err("Start bit (%d) expected to be larger than end (%d)\n",
+                         startbit, endbit);
+          } else if (err == -ERANGE) {
+                  if ((startbit - endbit + 1) > 64)
+                          pr_err("Field %d-%d too large for 64 bits!\n",
+                                 startbit, endbit);
+                  else
+                          pr_err("Cannot store %llx inside bits %d-%d (would truncate)\n",
+                                 *val, startbit, endbit);
+          }
+          dump_stack();
+  }
+
+pack() and unpack()
+^^^^^^^^^^^^^^^^^^^
+
+These are const-correct variants of packing(), and eliminate the last "enum
+packing_op op" argument.
+
+Calling pack(...) is equivalent, and preferred, to calling packing(..., PACK).
+
+Calling unpack(...) is equivalent, and preferred, to calling packing(..., UNPACK).
+
+pack_fields() and unpack_fields()
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The library exposes optimized functions for the scenario where there are many
+fields represented in a buffer, and it encourages consumer drivers to avoid
+repetitive calls to pack() and unpack() for each field, but instead use
+pack_fields() and unpack_fields(), which reduces the code footprint.
+
+These APIs use field definitions in arrays of ``struct packed_field_u8`` or
+``struct packed_field_u16``, allowing consumer drivers to minimize the size
+of these arrays according to their custom requirements.
+
+The pack_fields() and unpack_fields() API functions are actually macros which
+automatically select the appropriate function at compile time, based on the
+type of the fields array passed in.
+
+An additional benefit over pack() and unpack() is that sanity checks on the
+field definitions are handled at compile time with ``BUILD_BUG_ON`` rather
+than only when the offending code is executed. These functions return void and
+wrapping them to handle unexpected errors is not necessary.
+
+It is recommended, but not required, that you wrap your packed buffer into a
+structured type with a fixed size. This generally makes it easier for the
+compiler to enforce that the correct size buffer is used.
+
+Here is an example of how to use the fields APIs:
+
+.. code-block:: c
+
+   /* Ordering inside the unpacked structure is flexible and can be different
+    * from the packed buffer. Here, it is optimized to reduce padding.
+    */
+   struct data {
+        u64 field3;
+        u32 field4;
+        u16 field1;
+        u8 field2;
+   };
+
+   #define SIZE 13
+
+   typdef struct __packed { u8 buf[SIZE]; } packed_buf_t;
+
+   static const struct packed_field_u8 fields[] = {
+           PACKED_FIELD(100, 90, struct data, field1),
+           PACKED_FIELD(90, 87, struct data, field2),
+           PACKED_FIELD(86, 30, struct data, field3),
+           PACKED_FIELD(29, 0, struct data, field4),
+   };
+
+   void unpack_your_data(const packed_buf_t *buf, struct data *unpacked)
+   {
+           BUILD_BUG_ON(sizeof(*buf) != SIZE;
+
+           unpack_fields(buf, sizeof(*buf), unpacked, fields,
+                         QUIRK_LITTLE_ENDIAN);
+   }
+
+   void pack_your_data(const struct data *unpacked, packed_buf_t *buf)
+   {
+           BUILD_BUG_ON(sizeof(*buf) != SIZE;
+
+           pack_fields(buf, sizeof(*buf), unpacked, fields,
+                       QUIRK_LITTLE_ENDIAN);
+   }

-- 
2.47.0.265.g4ca455297942


