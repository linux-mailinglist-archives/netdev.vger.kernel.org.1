Return-Path: <netdev+bounces-148732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B499E3028
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 00:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C1A283B5F
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 23:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4391DF997;
	Tue,  3 Dec 2024 23:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZPE/OULa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FF720C00E
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 23:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733270124; cv=none; b=sGY+/yWHbVKGT+QMaKFS+Qv2+oc62fH0PLogAUhnY1Oi6TN/lwQ++XOjvPkxH1KeeC0HpXag9NxjPgXNVELP0dkP2iSoeM4hkjbQPhVVC862QnNPktFKfqAKE/MBUF5V4PwDBtC9bHKyKtM5EOvRqwZrJh92xZkKir0jEUX7pEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733270124; c=relaxed/simple;
	bh=jodUwWeIxtpmGSQg3lH/cEWCDxX7pCJbS7cLi3YGGO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DIuA1kAwBKmdpO19yGU6XXKv3Fok5cBkzdWY2pTdVg7dKk5UoVbsHlfQCJcdUV578sJj7CNerwomg7JY2na1KIAe70uiRAKpYlOSHqRLCTATHtMel7nZNPCGAKYqIIYe+GgO4Pg+eKGIUfKoioeNfDUWqnH8axnfDz1gL0oDQ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZPE/OULa; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733270117; x=1764806117;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jodUwWeIxtpmGSQg3lH/cEWCDxX7pCJbS7cLi3YGGO8=;
  b=ZPE/OULafEnERCAsQG1say1XJZtCbQE1Oar0rTkhG/00Qu5/cZYq4X69
   J6NOvIpiEvUB56vFS8QVEw3SJtvCu32ErWBdeSB3eQRHhzF4Fh+rwPUTr
   qfm2hHbQG5HIWeldfpCnrUCLzqGzjLgUEKBERiTG07XHXfot4qQ8UEfY8
   Y4QgKUFbBJ2x5Xid7K6RIuRGhqJ42gLlpT2q8vUjNW6BKq4xHZcgMokQ8
   Y5tfx82E2hQ8qmcr+LG5HIwPZ/KjhxQUhIDR3gFSjzxV/kU32OoYaQaWT
   h9Oci3wK/lprHjSq8MWUf0k1qBX1+jrZptWEL9UcAndlXtnDeJ2UB+UtT
   Q==;
X-CSE-ConnectionGUID: xgMRbVWaRgespAzwAVvb0g==
X-CSE-MsgGUID: kMBHO3qBTG+o/3GS75SFTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="58918476"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="58918476"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 15:55:10 -0800
X-CSE-ConnectionGUID: Cbz2TY4uRXGzjULF+sztSA==
X-CSE-MsgGUID: VqZfz5uKTymO5doA9OvbWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="93679039"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 15:55:08 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 03 Dec 2024 15:53:49 -0800
Subject: [PATCH net-next v8 03/10] lib: packing: add pack_fields() and
 unpack_fields()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-packing-pack-fields-and-ice-implementation-v8-3-2ed68edfe583@intel.com>
References: <20241203-packing-pack-fields-and-ice-implementation-v8-0-2ed68edfe583@intel.com>
In-Reply-To: <20241203-packing-pack-fields-and-ice-implementation-v8-0-2ed68edfe583@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.2

From: Vladimir Oltean <vladimir.oltean@nxp.com>

This is new API which caters to the following requirements:

- Pack or unpack a large number of fields to/from a buffer with a small
  code footprint. The current alternative is to open-code a large number
  of calls to pack() and unpack(), or to use packing() to reduce that
  number to half. But packing() is not const-correct.

- Use unpacked numbers stored in variables smaller than u64. This
  reduces the rodata footprint of the stored field arrays.

- Perform error checking at compile time, rather than runtime, and return
  void from the API functions. Because the C preprocessor can't generate
  variable length code (loops), this is a bit tricky to do with macros.

  To handle this, implement macros which sanity check the packed field
  definitions based on their size. Finally, a single macro with a chain of
  __builtin_choose_expr() is used to select the appropriate macros. We
  enforce the use of ascending or descending order to avoid O(N^2) scaling
  when checking for overlap. Note that the macros are written with care to
  ensure that the compilers can correctly evaluate the resulting code at
  compile time. In particular, the expressions for the pbuflen and the
  ordering check are passed all the way down via macros. Earlier versions
  attempted to use statement expressions with local variables, but not all
  compilers were able to fully analyze these at compile time, resulting in
  BUILD_BUG_ON failures.

  The overlap macro is passed a condition determining whether the fields
  are expected to be in ascending or descending order based on the relative
  ordering of the first two fields. This allows users to keep the fields in
  whichever order is most natural for their hardware, while still keeping
  the overlap checks scaling to O(N).

  This method also enables calling CHECK_PACKED_FIELDS directly from within
  the pack_fields and unpack_fields macros, ensuring all drivers using this
  API will receive type checking, without needing to remember to call the
  CHECK_PACKED_FIELDS macro themselves.

- Reduced rodata footprint for the storage of the packed field arrays.
  To that end, we have struct packed_field_s (small) and packed_field_m
  (medium). More can be added as needed (unlikely for now). On these
  types, the same generic pack_fields() and unpack_fields() API can be
  used, thanks to the new C11 _Generic() selection feature, which can
  call pack_fields_s() or pack_fields_m(), depending on the type of the
  "fields" array - a simplistic form of polymorphism. It is evaluated at
  compile time which function will actually be called.

Over time, packing() is expected to be completely replaced either with
pack() or with pack_fields().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Makefile                          |    4 +
 include/linux/packing.h           | 2855 +++++++++++++++++++++++++++++++++++++
 lib/packing.c                     |  145 ++
 lib/packing_test.c                |   61 +
 scripts/gen_packed_field_checks.c |   38 +
 MAINTAINERS                       |    1 +
 scripts/Makefile                  |    2 +-
 7 files changed, 3105 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 8129de0b214f5b73a3b1cca0798041d74270836b..58496942a7d13c6a53e4210d83deb2cc2033d00a 100644
--- a/Makefile
+++ b/Makefile
@@ -1315,6 +1315,10 @@ PHONY += scripts_unifdef
 scripts_unifdef: scripts_basic
 	$(Q)$(MAKE) $(build)=scripts scripts/unifdef
 
+PHONY += scripts_gen_packed_field_checks
+scripts_gen_packed_field_checks: scripts_basic
+	$(Q)$(MAKE) $(build)=scripts scripts/gen_packed_field_checks
+
 # ---------------------------------------------------------------------------
 # Install
 
diff --git a/include/linux/packing.h b/include/linux/packing.h
index 5d36dcd06f60420325473dae3a0e9ac37d03da4b..c4fc76ae64a512cf977f3a89da25717bd99a5d91 100644
--- a/include/linux/packing.h
+++ b/include/linux/packing.h
@@ -8,6 +8,61 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
 
+#define GEN_PACKED_FIELD_MEMBERS(__type) \
+	__type startbit; \
+	__type endbit; \
+	__type offset; \
+	__type size
+
+/* Small packed field. Use with bit offsets < 256, buffers < 32B and
+ * unpacked structures < 256B.
+ */
+struct packed_field_s {
+	GEN_PACKED_FIELD_MEMBERS(u8);
+};
+
+/* Medium packed field. Use with bit offsets < 65536, buffers < 8KB and
+ * unpacked structures < 64KB.
+ */
+struct packed_field_m {
+	GEN_PACKED_FIELD_MEMBERS(u16);
+};
+
+#define PACKED_FIELD(start, end, struct_name, struct_field) \
+{ \
+	(start), \
+	(end), \
+	offsetof(struct_name, struct_field), \
+	sizeof_field(struct_name, struct_field), \
+}
+
+#define CHECK_PACKED_FIELD(field) ({ \
+	typeof(field) __f = (field); \
+	BUILD_BUG_ON(__f.startbit < __f.endbit); \
+	BUILD_BUG_ON(__f.startbit - __f.endbit >= BITS_PER_BYTE * __f.size); \
+	BUILD_BUG_ON(__f.size != 1 && __f.size != 2 && \
+		     __f.size != 4 && __f.size != 8); \
+})
+
+
+#define CHECK_PACKED_FIELD_OVERLAP(ascending, field1, field2) ({ \
+	typeof(field1) _f1 = (field1); typeof(field2) _f2 = (field2); \
+	const bool _a = (ascending); \
+	BUILD_BUG_ON(_a && _f1.startbit >= _f2.startbit); \
+	BUILD_BUG_ON(!_a && _f1.startbit <= _f2.startbit); \
+	BUILD_BUG_ON(max(_f1.endbit, _f2.endbit) <= \
+		     min(_f1.startbit, _f2.startbit)); \
+})
+
+#define CHECK_PACKED_FIELDS_SIZE(fields, pbuflen) ({ \
+	typeof(&(fields)[0]) _f = (fields); \
+	typeof(pbuflen) _len = (pbuflen); \
+	const size_t num_fields = ARRAY_SIZE(fields); \
+	BUILD_BUG_ON(!__builtin_constant_p(_len)); \
+	BUILD_BUG_ON(_f[0].startbit >= BITS_PER_BYTE * _len); \
+	BUILD_BUG_ON(_f[num_fields - 1].startbit >= BITS_PER_BYTE * _len); \
+})
+
 #define QUIRK_MSB_ON_THE_RIGHT	BIT(0)
 #define QUIRK_LITTLE_ENDIAN	BIT(1)
 #define QUIRK_LSW32_IS_FIRST	BIT(2)
@@ -26,4 +81,2804 @@ int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
 int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
 	   size_t pbuflen, u8 quirks);
 
+void pack_fields_s(void *pbuf, size_t pbuflen, const void *ustruct,
+		   const struct packed_field_s *fields, size_t num_fields,
+		   u8 quirks);
+
+void pack_fields_m(void *pbuf, size_t pbuflen, const void *ustruct,
+		   const struct packed_field_m *fields, size_t num_fields,
+		   u8 quirks);
+
+void unpack_fields_s(const void *pbuf, size_t pbuflen, void *ustruct,
+		     const struct packed_field_s *fields, size_t num_fields,
+		     u8 quirks);
+
+void unpack_fields_m(const void *pbuf, size_t pbuflen, void *ustruct,
+		     const struct packed_field_m *fields, size_t num_fields,
+		     u8 quirks);
+
+/* Do not hand-edit the following packed field check macros!
+ *
+ * They are generated using scripts/gen_packed_field_checks.c, which may be
+ * built via "make scripts_gen_packed_field_checks". If larger macro sizes are
+ * needed in the future, please use this program to re-generate the macros and
+ * insert them here.
+ */
+
+#define CHECK_PACKED_FIELDS_1(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 1); \
+	 CHECK_PACKED_FIELD(_f[0]); })
+
+#define CHECK_PACKED_FIELDS_2(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 2); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); })
+
+#define CHECK_PACKED_FIELDS_3(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 3); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); })
+
+#define CHECK_PACKED_FIELDS_4(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 4); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); })
+
+#define CHECK_PACKED_FIELDS_5(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 5); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); })
+
+#define CHECK_PACKED_FIELDS_6(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 6); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); })
+
+#define CHECK_PACKED_FIELDS_7(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 7); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); })
+
+#define CHECK_PACKED_FIELDS_8(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 8); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); })
+
+#define CHECK_PACKED_FIELDS_9(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 9); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); })
+
+#define CHECK_PACKED_FIELDS_10(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 10); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); })
+
+#define CHECK_PACKED_FIELDS_11(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 11); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); })
+
+#define CHECK_PACKED_FIELDS_12(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 12); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); })
+
+#define CHECK_PACKED_FIELDS_13(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 13); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); })
+
+#define CHECK_PACKED_FIELDS_14(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 14); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); })
+
+#define CHECK_PACKED_FIELDS_15(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 15); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); })
+
+#define CHECK_PACKED_FIELDS_16(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 16); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); })
+
+#define CHECK_PACKED_FIELDS_17(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 17); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); })
+
+#define CHECK_PACKED_FIELDS_18(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 18); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); })
+
+#define CHECK_PACKED_FIELDS_19(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 19); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); })
+
+#define CHECK_PACKED_FIELDS_20(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 20); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); })
+
+#define CHECK_PACKED_FIELDS_21(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 21); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); })
+
+#define CHECK_PACKED_FIELDS_22(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 22); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); })
+
+#define CHECK_PACKED_FIELDS_23(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 23); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); })
+
+#define CHECK_PACKED_FIELDS_24(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 24); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); })
+
+#define CHECK_PACKED_FIELDS_25(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 25); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); })
+
+#define CHECK_PACKED_FIELDS_26(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 26); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD(_f[25]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[24], _f[25]); })
+
+#define CHECK_PACKED_FIELDS_27(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 27); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD(_f[25]); \
+	 CHECK_PACKED_FIELD(_f[26]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[24], _f[25]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[25], _f[26]); })
+
+#define CHECK_PACKED_FIELDS_28(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 28); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD(_f[25]); \
+	 CHECK_PACKED_FIELD(_f[26]); \
+	 CHECK_PACKED_FIELD(_f[27]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[24], _f[25]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[25], _f[26]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[26], _f[27]); })
+
+#define CHECK_PACKED_FIELDS_29(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 29); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD(_f[25]); \
+	 CHECK_PACKED_FIELD(_f[26]); \
+	 CHECK_PACKED_FIELD(_f[27]); \
+	 CHECK_PACKED_FIELD(_f[28]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[24], _f[25]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[25], _f[26]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[26], _f[27]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[27], _f[28]); })
+
+#define CHECK_PACKED_FIELDS_30(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 30); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD(_f[25]); \
+	 CHECK_PACKED_FIELD(_f[26]); \
+	 CHECK_PACKED_FIELD(_f[27]); \
+	 CHECK_PACKED_FIELD(_f[28]); \
+	 CHECK_PACKED_FIELD(_f[29]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[24], _f[25]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[25], _f[26]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[26], _f[27]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[27], _f[28]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[28], _f[29]); })
+
+#define CHECK_PACKED_FIELDS_31(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 31); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD(_f[25]); \
+	 CHECK_PACKED_FIELD(_f[26]); \
+	 CHECK_PACKED_FIELD(_f[27]); \
+	 CHECK_PACKED_FIELD(_f[28]); \
+	 CHECK_PACKED_FIELD(_f[29]); \
+	 CHECK_PACKED_FIELD(_f[30]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[24], _f[25]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[25], _f[26]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[26], _f[27]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[27], _f[28]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[28], _f[29]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[29], _f[30]); })
+
+#define CHECK_PACKED_FIELDS_32(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 32); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD(_f[25]); \
+	 CHECK_PACKED_FIELD(_f[26]); \
+	 CHECK_PACKED_FIELD(_f[27]); \
+	 CHECK_PACKED_FIELD(_f[28]); \
+	 CHECK_PACKED_FIELD(_f[29]); \
+	 CHECK_PACKED_FIELD(_f[30]); \
+	 CHECK_PACKED_FIELD(_f[31]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[24], _f[25]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[25], _f[26]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[26], _f[27]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[27], _f[28]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[28], _f[29]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[29], _f[30]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[30], _f[31]); })
+
+#define CHECK_PACKED_FIELDS_33(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 33); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD(_f[25]); \
+	 CHECK_PACKED_FIELD(_f[26]); \
+	 CHECK_PACKED_FIELD(_f[27]); \
+	 CHECK_PACKED_FIELD(_f[28]); \
+	 CHECK_PACKED_FIELD(_f[29]); \
+	 CHECK_PACKED_FIELD(_f[30]); \
+	 CHECK_PACKED_FIELD(_f[31]); \
+	 CHECK_PACKED_FIELD(_f[32]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[24], _f[25]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[25], _f[26]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[26], _f[27]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[27], _f[28]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[28], _f[29]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[29], _f[30]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[30], _f[31]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[31], _f[32]); })
+
+#define CHECK_PACKED_FIELDS_34(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 34); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD(_f[25]); \
+	 CHECK_PACKED_FIELD(_f[26]); \
+	 CHECK_PACKED_FIELD(_f[27]); \
+	 CHECK_PACKED_FIELD(_f[28]); \
+	 CHECK_PACKED_FIELD(_f[29]); \
+	 CHECK_PACKED_FIELD(_f[30]); \
+	 CHECK_PACKED_FIELD(_f[31]); \
+	 CHECK_PACKED_FIELD(_f[32]); \
+	 CHECK_PACKED_FIELD(_f[33]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[24], _f[25]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[25], _f[26]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[26], _f[27]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[27], _f[28]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[28], _f[29]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[29], _f[30]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[30], _f[31]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[31], _f[32]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[32], _f[33]); })
+
+#define CHECK_PACKED_FIELDS_35(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 35); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD(_f[25]); \
+	 CHECK_PACKED_FIELD(_f[26]); \
+	 CHECK_PACKED_FIELD(_f[27]); \
+	 CHECK_PACKED_FIELD(_f[28]); \
+	 CHECK_PACKED_FIELD(_f[29]); \
+	 CHECK_PACKED_FIELD(_f[30]); \
+	 CHECK_PACKED_FIELD(_f[31]); \
+	 CHECK_PACKED_FIELD(_f[32]); \
+	 CHECK_PACKED_FIELD(_f[33]); \
+	 CHECK_PACKED_FIELD(_f[34]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[24], _f[25]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[25], _f[26]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[26], _f[27]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[27], _f[28]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[28], _f[29]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[29], _f[30]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[30], _f[31]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[31], _f[32]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[32], _f[33]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[33], _f[34]); })
+
+#define CHECK_PACKED_FIELDS_36(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 36); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD(_f[25]); \
+	 CHECK_PACKED_FIELD(_f[26]); \
+	 CHECK_PACKED_FIELD(_f[27]); \
+	 CHECK_PACKED_FIELD(_f[28]); \
+	 CHECK_PACKED_FIELD(_f[29]); \
+	 CHECK_PACKED_FIELD(_f[30]); \
+	 CHECK_PACKED_FIELD(_f[31]); \
+	 CHECK_PACKED_FIELD(_f[32]); \
+	 CHECK_PACKED_FIELD(_f[33]); \
+	 CHECK_PACKED_FIELD(_f[34]); \
+	 CHECK_PACKED_FIELD(_f[35]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[24], _f[25]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[25], _f[26]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[26], _f[27]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[27], _f[28]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[28], _f[29]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[29], _f[30]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[30], _f[31]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[31], _f[32]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[32], _f[33]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[33], _f[34]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[34], _f[35]); })
+
+#define CHECK_PACKED_FIELDS_37(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 37); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD(_f[25]); \
+	 CHECK_PACKED_FIELD(_f[26]); \
+	 CHECK_PACKED_FIELD(_f[27]); \
+	 CHECK_PACKED_FIELD(_f[28]); \
+	 CHECK_PACKED_FIELD(_f[29]); \
+	 CHECK_PACKED_FIELD(_f[30]); \
+	 CHECK_PACKED_FIELD(_f[31]); \
+	 CHECK_PACKED_FIELD(_f[32]); \
+	 CHECK_PACKED_FIELD(_f[33]); \
+	 CHECK_PACKED_FIELD(_f[34]); \
+	 CHECK_PACKED_FIELD(_f[35]); \
+	 CHECK_PACKED_FIELD(_f[36]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[24], _f[25]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[25], _f[26]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[26], _f[27]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[27], _f[28]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[28], _f[29]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[29], _f[30]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[30], _f[31]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[31], _f[32]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[32], _f[33]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[33], _f[34]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[34], _f[35]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[35], _f[36]); })
+
+#define CHECK_PACKED_FIELDS_38(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 38); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD(_f[25]); \
+	 CHECK_PACKED_FIELD(_f[26]); \
+	 CHECK_PACKED_FIELD(_f[27]); \
+	 CHECK_PACKED_FIELD(_f[28]); \
+	 CHECK_PACKED_FIELD(_f[29]); \
+	 CHECK_PACKED_FIELD(_f[30]); \
+	 CHECK_PACKED_FIELD(_f[31]); \
+	 CHECK_PACKED_FIELD(_f[32]); \
+	 CHECK_PACKED_FIELD(_f[33]); \
+	 CHECK_PACKED_FIELD(_f[34]); \
+	 CHECK_PACKED_FIELD(_f[35]); \
+	 CHECK_PACKED_FIELD(_f[36]); \
+	 CHECK_PACKED_FIELD(_f[37]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[24], _f[25]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[25], _f[26]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[26], _f[27]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[27], _f[28]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[28], _f[29]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[29], _f[30]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[30], _f[31]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[31], _f[32]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[32], _f[33]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[33], _f[34]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[34], _f[35]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[35], _f[36]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[36], _f[37]); })
+
+#define CHECK_PACKED_FIELDS_39(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 39); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD(_f[25]); \
+	 CHECK_PACKED_FIELD(_f[26]); \
+	 CHECK_PACKED_FIELD(_f[27]); \
+	 CHECK_PACKED_FIELD(_f[28]); \
+	 CHECK_PACKED_FIELD(_f[29]); \
+	 CHECK_PACKED_FIELD(_f[30]); \
+	 CHECK_PACKED_FIELD(_f[31]); \
+	 CHECK_PACKED_FIELD(_f[32]); \
+	 CHECK_PACKED_FIELD(_f[33]); \
+	 CHECK_PACKED_FIELD(_f[34]); \
+	 CHECK_PACKED_FIELD(_f[35]); \
+	 CHECK_PACKED_FIELD(_f[36]); \
+	 CHECK_PACKED_FIELD(_f[37]); \
+	 CHECK_PACKED_FIELD(_f[38]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[24], _f[25]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[25], _f[26]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[26], _f[27]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[27], _f[28]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[28], _f[29]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[29], _f[30]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[30], _f[31]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[31], _f[32]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[32], _f[33]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[33], _f[34]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[34], _f[35]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[35], _f[36]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[36], _f[37]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[37], _f[38]); })
+
+#define CHECK_PACKED_FIELDS_40(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 40); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD(_f[25]); \
+	 CHECK_PACKED_FIELD(_f[26]); \
+	 CHECK_PACKED_FIELD(_f[27]); \
+	 CHECK_PACKED_FIELD(_f[28]); \
+	 CHECK_PACKED_FIELD(_f[29]); \
+	 CHECK_PACKED_FIELD(_f[30]); \
+	 CHECK_PACKED_FIELD(_f[31]); \
+	 CHECK_PACKED_FIELD(_f[32]); \
+	 CHECK_PACKED_FIELD(_f[33]); \
+	 CHECK_PACKED_FIELD(_f[34]); \
+	 CHECK_PACKED_FIELD(_f[35]); \
+	 CHECK_PACKED_FIELD(_f[36]); \
+	 CHECK_PACKED_FIELD(_f[37]); \
+	 CHECK_PACKED_FIELD(_f[38]); \
+	 CHECK_PACKED_FIELD(_f[39]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[24], _f[25]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[25], _f[26]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[26], _f[27]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[27], _f[28]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[28], _f[29]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[29], _f[30]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[30], _f[31]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[31], _f[32]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[32], _f[33]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[33], _f[34]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[34], _f[35]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[35], _f[36]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[36], _f[37]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[37], _f[38]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[38], _f[39]); })
+
+#define CHECK_PACKED_FIELDS_41(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 41); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD(_f[25]); \
+	 CHECK_PACKED_FIELD(_f[26]); \
+	 CHECK_PACKED_FIELD(_f[27]); \
+	 CHECK_PACKED_FIELD(_f[28]); \
+	 CHECK_PACKED_FIELD(_f[29]); \
+	 CHECK_PACKED_FIELD(_f[30]); \
+	 CHECK_PACKED_FIELD(_f[31]); \
+	 CHECK_PACKED_FIELD(_f[32]); \
+	 CHECK_PACKED_FIELD(_f[33]); \
+	 CHECK_PACKED_FIELD(_f[34]); \
+	 CHECK_PACKED_FIELD(_f[35]); \
+	 CHECK_PACKED_FIELD(_f[36]); \
+	 CHECK_PACKED_FIELD(_f[37]); \
+	 CHECK_PACKED_FIELD(_f[38]); \
+	 CHECK_PACKED_FIELD(_f[39]); \
+	 CHECK_PACKED_FIELD(_f[40]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[24], _f[25]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[25], _f[26]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[26], _f[27]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[27], _f[28]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[28], _f[29]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[29], _f[30]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[30], _f[31]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[31], _f[32]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[32], _f[33]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[33], _f[34]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[34], _f[35]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[35], _f[36]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[36], _f[37]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[37], _f[38]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[38], _f[39]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[39], _f[40]); })
+
+#define CHECK_PACKED_FIELDS_42(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 42); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD(_f[25]); \
+	 CHECK_PACKED_FIELD(_f[26]); \
+	 CHECK_PACKED_FIELD(_f[27]); \
+	 CHECK_PACKED_FIELD(_f[28]); \
+	 CHECK_PACKED_FIELD(_f[29]); \
+	 CHECK_PACKED_FIELD(_f[30]); \
+	 CHECK_PACKED_FIELD(_f[31]); \
+	 CHECK_PACKED_FIELD(_f[32]); \
+	 CHECK_PACKED_FIELD(_f[33]); \
+	 CHECK_PACKED_FIELD(_f[34]); \
+	 CHECK_PACKED_FIELD(_f[35]); \
+	 CHECK_PACKED_FIELD(_f[36]); \
+	 CHECK_PACKED_FIELD(_f[37]); \
+	 CHECK_PACKED_FIELD(_f[38]); \
+	 CHECK_PACKED_FIELD(_f[39]); \
+	 CHECK_PACKED_FIELD(_f[40]); \
+	 CHECK_PACKED_FIELD(_f[41]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[24], _f[25]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[25], _f[26]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[26], _f[27]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[27], _f[28]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[28], _f[29]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[29], _f[30]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[30], _f[31]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[31], _f[32]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[32], _f[33]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[33], _f[34]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[34], _f[35]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[35], _f[36]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[36], _f[37]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[37], _f[38]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[38], _f[39]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[39], _f[40]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[40], _f[41]); })
+
+#define CHECK_PACKED_FIELDS_43(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 43); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD(_f[25]); \
+	 CHECK_PACKED_FIELD(_f[26]); \
+	 CHECK_PACKED_FIELD(_f[27]); \
+	 CHECK_PACKED_FIELD(_f[28]); \
+	 CHECK_PACKED_FIELD(_f[29]); \
+	 CHECK_PACKED_FIELD(_f[30]); \
+	 CHECK_PACKED_FIELD(_f[31]); \
+	 CHECK_PACKED_FIELD(_f[32]); \
+	 CHECK_PACKED_FIELD(_f[33]); \
+	 CHECK_PACKED_FIELD(_f[34]); \
+	 CHECK_PACKED_FIELD(_f[35]); \
+	 CHECK_PACKED_FIELD(_f[36]); \
+	 CHECK_PACKED_FIELD(_f[37]); \
+	 CHECK_PACKED_FIELD(_f[38]); \
+	 CHECK_PACKED_FIELD(_f[39]); \
+	 CHECK_PACKED_FIELD(_f[40]); \
+	 CHECK_PACKED_FIELD(_f[41]); \
+	 CHECK_PACKED_FIELD(_f[42]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[24], _f[25]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[25], _f[26]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[26], _f[27]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[27], _f[28]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[28], _f[29]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[29], _f[30]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[30], _f[31]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[31], _f[32]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[32], _f[33]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[33], _f[34]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[34], _f[35]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[35], _f[36]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[36], _f[37]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[37], _f[38]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[38], _f[39]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[39], _f[40]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[40], _f[41]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[41], _f[42]); })
+
+#define CHECK_PACKED_FIELDS_44(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 44); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD(_f[25]); \
+	 CHECK_PACKED_FIELD(_f[26]); \
+	 CHECK_PACKED_FIELD(_f[27]); \
+	 CHECK_PACKED_FIELD(_f[28]); \
+	 CHECK_PACKED_FIELD(_f[29]); \
+	 CHECK_PACKED_FIELD(_f[30]); \
+	 CHECK_PACKED_FIELD(_f[31]); \
+	 CHECK_PACKED_FIELD(_f[32]); \
+	 CHECK_PACKED_FIELD(_f[33]); \
+	 CHECK_PACKED_FIELD(_f[34]); \
+	 CHECK_PACKED_FIELD(_f[35]); \
+	 CHECK_PACKED_FIELD(_f[36]); \
+	 CHECK_PACKED_FIELD(_f[37]); \
+	 CHECK_PACKED_FIELD(_f[38]); \
+	 CHECK_PACKED_FIELD(_f[39]); \
+	 CHECK_PACKED_FIELD(_f[40]); \
+	 CHECK_PACKED_FIELD(_f[41]); \
+	 CHECK_PACKED_FIELD(_f[42]); \
+	 CHECK_PACKED_FIELD(_f[43]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[24], _f[25]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[25], _f[26]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[26], _f[27]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[27], _f[28]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[28], _f[29]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[29], _f[30]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[30], _f[31]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[31], _f[32]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[32], _f[33]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[33], _f[34]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[34], _f[35]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[35], _f[36]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[36], _f[37]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[37], _f[38]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[38], _f[39]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[39], _f[40]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[40], _f[41]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[41], _f[42]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[42], _f[43]); })
+
+#define CHECK_PACKED_FIELDS_45(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 45); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD(_f[25]); \
+	 CHECK_PACKED_FIELD(_f[26]); \
+	 CHECK_PACKED_FIELD(_f[27]); \
+	 CHECK_PACKED_FIELD(_f[28]); \
+	 CHECK_PACKED_FIELD(_f[29]); \
+	 CHECK_PACKED_FIELD(_f[30]); \
+	 CHECK_PACKED_FIELD(_f[31]); \
+	 CHECK_PACKED_FIELD(_f[32]); \
+	 CHECK_PACKED_FIELD(_f[33]); \
+	 CHECK_PACKED_FIELD(_f[34]); \
+	 CHECK_PACKED_FIELD(_f[35]); \
+	 CHECK_PACKED_FIELD(_f[36]); \
+	 CHECK_PACKED_FIELD(_f[37]); \
+	 CHECK_PACKED_FIELD(_f[38]); \
+	 CHECK_PACKED_FIELD(_f[39]); \
+	 CHECK_PACKED_FIELD(_f[40]); \
+	 CHECK_PACKED_FIELD(_f[41]); \
+	 CHECK_PACKED_FIELD(_f[42]); \
+	 CHECK_PACKED_FIELD(_f[43]); \
+	 CHECK_PACKED_FIELD(_f[44]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[24], _f[25]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[25], _f[26]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[26], _f[27]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[27], _f[28]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[28], _f[29]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[29], _f[30]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[30], _f[31]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[31], _f[32]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[32], _f[33]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[33], _f[34]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[34], _f[35]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[35], _f[36]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[36], _f[37]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[37], _f[38]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[38], _f[39]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[39], _f[40]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[40], _f[41]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[41], _f[42]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[42], _f[43]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[43], _f[44]); })
+
+#define CHECK_PACKED_FIELDS_46(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 46); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD(_f[25]); \
+	 CHECK_PACKED_FIELD(_f[26]); \
+	 CHECK_PACKED_FIELD(_f[27]); \
+	 CHECK_PACKED_FIELD(_f[28]); \
+	 CHECK_PACKED_FIELD(_f[29]); \
+	 CHECK_PACKED_FIELD(_f[30]); \
+	 CHECK_PACKED_FIELD(_f[31]); \
+	 CHECK_PACKED_FIELD(_f[32]); \
+	 CHECK_PACKED_FIELD(_f[33]); \
+	 CHECK_PACKED_FIELD(_f[34]); \
+	 CHECK_PACKED_FIELD(_f[35]); \
+	 CHECK_PACKED_FIELD(_f[36]); \
+	 CHECK_PACKED_FIELD(_f[37]); \
+	 CHECK_PACKED_FIELD(_f[38]); \
+	 CHECK_PACKED_FIELD(_f[39]); \
+	 CHECK_PACKED_FIELD(_f[40]); \
+	 CHECK_PACKED_FIELD(_f[41]); \
+	 CHECK_PACKED_FIELD(_f[42]); \
+	 CHECK_PACKED_FIELD(_f[43]); \
+	 CHECK_PACKED_FIELD(_f[44]); \
+	 CHECK_PACKED_FIELD(_f[45]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[24], _f[25]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[25], _f[26]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[26], _f[27]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[27], _f[28]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[28], _f[29]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[29], _f[30]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[30], _f[31]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[31], _f[32]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[32], _f[33]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[33], _f[34]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[34], _f[35]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[35], _f[36]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[36], _f[37]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[37], _f[38]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[38], _f[39]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[39], _f[40]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[40], _f[41]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[41], _f[42]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[42], _f[43]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[43], _f[44]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[44], _f[45]); })
+
+#define CHECK_PACKED_FIELDS_47(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 47); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD(_f[25]); \
+	 CHECK_PACKED_FIELD(_f[26]); \
+	 CHECK_PACKED_FIELD(_f[27]); \
+	 CHECK_PACKED_FIELD(_f[28]); \
+	 CHECK_PACKED_FIELD(_f[29]); \
+	 CHECK_PACKED_FIELD(_f[30]); \
+	 CHECK_PACKED_FIELD(_f[31]); \
+	 CHECK_PACKED_FIELD(_f[32]); \
+	 CHECK_PACKED_FIELD(_f[33]); \
+	 CHECK_PACKED_FIELD(_f[34]); \
+	 CHECK_PACKED_FIELD(_f[35]); \
+	 CHECK_PACKED_FIELD(_f[36]); \
+	 CHECK_PACKED_FIELD(_f[37]); \
+	 CHECK_PACKED_FIELD(_f[38]); \
+	 CHECK_PACKED_FIELD(_f[39]); \
+	 CHECK_PACKED_FIELD(_f[40]); \
+	 CHECK_PACKED_FIELD(_f[41]); \
+	 CHECK_PACKED_FIELD(_f[42]); \
+	 CHECK_PACKED_FIELD(_f[43]); \
+	 CHECK_PACKED_FIELD(_f[44]); \
+	 CHECK_PACKED_FIELD(_f[45]); \
+	 CHECK_PACKED_FIELD(_f[46]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[24], _f[25]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[25], _f[26]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[26], _f[27]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[27], _f[28]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[28], _f[29]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[29], _f[30]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[30], _f[31]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[31], _f[32]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[32], _f[33]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[33], _f[34]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[34], _f[35]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[35], _f[36]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[36], _f[37]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[37], _f[38]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[38], _f[39]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[39], _f[40]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[40], _f[41]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[41], _f[42]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[42], _f[43]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[43], _f[44]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[44], _f[45]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[45], _f[46]); })
+
+#define CHECK_PACKED_FIELDS_48(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 48); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD(_f[25]); \
+	 CHECK_PACKED_FIELD(_f[26]); \
+	 CHECK_PACKED_FIELD(_f[27]); \
+	 CHECK_PACKED_FIELD(_f[28]); \
+	 CHECK_PACKED_FIELD(_f[29]); \
+	 CHECK_PACKED_FIELD(_f[30]); \
+	 CHECK_PACKED_FIELD(_f[31]); \
+	 CHECK_PACKED_FIELD(_f[32]); \
+	 CHECK_PACKED_FIELD(_f[33]); \
+	 CHECK_PACKED_FIELD(_f[34]); \
+	 CHECK_PACKED_FIELD(_f[35]); \
+	 CHECK_PACKED_FIELD(_f[36]); \
+	 CHECK_PACKED_FIELD(_f[37]); \
+	 CHECK_PACKED_FIELD(_f[38]); \
+	 CHECK_PACKED_FIELD(_f[39]); \
+	 CHECK_PACKED_FIELD(_f[40]); \
+	 CHECK_PACKED_FIELD(_f[41]); \
+	 CHECK_PACKED_FIELD(_f[42]); \
+	 CHECK_PACKED_FIELD(_f[43]); \
+	 CHECK_PACKED_FIELD(_f[44]); \
+	 CHECK_PACKED_FIELD(_f[45]); \
+	 CHECK_PACKED_FIELD(_f[46]); \
+	 CHECK_PACKED_FIELD(_f[47]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[24], _f[25]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[25], _f[26]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[26], _f[27]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[27], _f[28]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[28], _f[29]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[29], _f[30]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[30], _f[31]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[31], _f[32]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[32], _f[33]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[33], _f[34]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[34], _f[35]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[35], _f[36]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[36], _f[37]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[37], _f[38]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[38], _f[39]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[39], _f[40]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[40], _f[41]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[41], _f[42]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[42], _f[43]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[43], _f[44]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[44], _f[45]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[45], _f[46]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[46], _f[47]); })
+
+#define CHECK_PACKED_FIELDS_49(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 49); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD(_f[25]); \
+	 CHECK_PACKED_FIELD(_f[26]); \
+	 CHECK_PACKED_FIELD(_f[27]); \
+	 CHECK_PACKED_FIELD(_f[28]); \
+	 CHECK_PACKED_FIELD(_f[29]); \
+	 CHECK_PACKED_FIELD(_f[30]); \
+	 CHECK_PACKED_FIELD(_f[31]); \
+	 CHECK_PACKED_FIELD(_f[32]); \
+	 CHECK_PACKED_FIELD(_f[33]); \
+	 CHECK_PACKED_FIELD(_f[34]); \
+	 CHECK_PACKED_FIELD(_f[35]); \
+	 CHECK_PACKED_FIELD(_f[36]); \
+	 CHECK_PACKED_FIELD(_f[37]); \
+	 CHECK_PACKED_FIELD(_f[38]); \
+	 CHECK_PACKED_FIELD(_f[39]); \
+	 CHECK_PACKED_FIELD(_f[40]); \
+	 CHECK_PACKED_FIELD(_f[41]); \
+	 CHECK_PACKED_FIELD(_f[42]); \
+	 CHECK_PACKED_FIELD(_f[43]); \
+	 CHECK_PACKED_FIELD(_f[44]); \
+	 CHECK_PACKED_FIELD(_f[45]); \
+	 CHECK_PACKED_FIELD(_f[46]); \
+	 CHECK_PACKED_FIELD(_f[47]); \
+	 CHECK_PACKED_FIELD(_f[48]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[24], _f[25]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[25], _f[26]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[26], _f[27]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[27], _f[28]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[28], _f[29]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[29], _f[30]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[30], _f[31]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[31], _f[32]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[32], _f[33]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[33], _f[34]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[34], _f[35]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[35], _f[36]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[36], _f[37]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[37], _f[38]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[38], _f[39]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[39], _f[40]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[40], _f[41]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[41], _f[42]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[42], _f[43]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[43], _f[44]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[44], _f[45]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[45], _f[46]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[46], _f[47]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[47], _f[48]); })
+
+#define CHECK_PACKED_FIELDS_50(fields) \
+	({ typeof(&(fields)[0]) _f = (fields); \
+	 BUILD_BUG_ON(ARRAY_SIZE(fields) != 50); \
+	 CHECK_PACKED_FIELD(_f[0]); \
+	 CHECK_PACKED_FIELD(_f[1]); \
+	 CHECK_PACKED_FIELD(_f[2]); \
+	 CHECK_PACKED_FIELD(_f[3]); \
+	 CHECK_PACKED_FIELD(_f[4]); \
+	 CHECK_PACKED_FIELD(_f[5]); \
+	 CHECK_PACKED_FIELD(_f[6]); \
+	 CHECK_PACKED_FIELD(_f[7]); \
+	 CHECK_PACKED_FIELD(_f[8]); \
+	 CHECK_PACKED_FIELD(_f[9]); \
+	 CHECK_PACKED_FIELD(_f[10]); \
+	 CHECK_PACKED_FIELD(_f[11]); \
+	 CHECK_PACKED_FIELD(_f[12]); \
+	 CHECK_PACKED_FIELD(_f[13]); \
+	 CHECK_PACKED_FIELD(_f[14]); \
+	 CHECK_PACKED_FIELD(_f[15]); \
+	 CHECK_PACKED_FIELD(_f[16]); \
+	 CHECK_PACKED_FIELD(_f[17]); \
+	 CHECK_PACKED_FIELD(_f[18]); \
+	 CHECK_PACKED_FIELD(_f[19]); \
+	 CHECK_PACKED_FIELD(_f[20]); \
+	 CHECK_PACKED_FIELD(_f[21]); \
+	 CHECK_PACKED_FIELD(_f[22]); \
+	 CHECK_PACKED_FIELD(_f[23]); \
+	 CHECK_PACKED_FIELD(_f[24]); \
+	 CHECK_PACKED_FIELD(_f[25]); \
+	 CHECK_PACKED_FIELD(_f[26]); \
+	 CHECK_PACKED_FIELD(_f[27]); \
+	 CHECK_PACKED_FIELD(_f[28]); \
+	 CHECK_PACKED_FIELD(_f[29]); \
+	 CHECK_PACKED_FIELD(_f[30]); \
+	 CHECK_PACKED_FIELD(_f[31]); \
+	 CHECK_PACKED_FIELD(_f[32]); \
+	 CHECK_PACKED_FIELD(_f[33]); \
+	 CHECK_PACKED_FIELD(_f[34]); \
+	 CHECK_PACKED_FIELD(_f[35]); \
+	 CHECK_PACKED_FIELD(_f[36]); \
+	 CHECK_PACKED_FIELD(_f[37]); \
+	 CHECK_PACKED_FIELD(_f[38]); \
+	 CHECK_PACKED_FIELD(_f[39]); \
+	 CHECK_PACKED_FIELD(_f[40]); \
+	 CHECK_PACKED_FIELD(_f[41]); \
+	 CHECK_PACKED_FIELD(_f[42]); \
+	 CHECK_PACKED_FIELD(_f[43]); \
+	 CHECK_PACKED_FIELD(_f[44]); \
+	 CHECK_PACKED_FIELD(_f[45]); \
+	 CHECK_PACKED_FIELD(_f[46]); \
+	 CHECK_PACKED_FIELD(_f[47]); \
+	 CHECK_PACKED_FIELD(_f[48]); \
+	 CHECK_PACKED_FIELD(_f[49]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[0], _f[1]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[1], _f[2]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[2], _f[3]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[3], _f[4]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[4], _f[5]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[5], _f[6]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[6], _f[7]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[7], _f[8]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[8], _f[9]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[9], _f[10]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[10], _f[11]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[11], _f[12]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[12], _f[13]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[13], _f[14]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[14], _f[15]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[15], _f[16]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[16], _f[17]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[17], _f[18]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[18], _f[19]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[19], _f[20]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[20], _f[21]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[21], _f[22]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[22], _f[23]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[23], _f[24]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[24], _f[25]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[25], _f[26]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[26], _f[27]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[27], _f[28]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[28], _f[29]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[29], _f[30]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[30], _f[31]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[31], _f[32]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[32], _f[33]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[33], _f[34]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[34], _f[35]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[35], _f[36]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[36], _f[37]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[37], _f[38]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[38], _f[39]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[39], _f[40]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[40], _f[41]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[41], _f[42]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[42], _f[43]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[43], _f[44]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[44], _f[45]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[45], _f[46]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[46], _f[47]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[47], _f[48]); \
+	 CHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[48], _f[49]); })
+
+#define CHECK_PACKED_FIELDS(fields) \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 1, CHECK_PACKED_FIELDS_1(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 2, CHECK_PACKED_FIELDS_2(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 3, CHECK_PACKED_FIELDS_3(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 4, CHECK_PACKED_FIELDS_4(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 5, CHECK_PACKED_FIELDS_5(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 6, CHECK_PACKED_FIELDS_6(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 7, CHECK_PACKED_FIELDS_7(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 8, CHECK_PACKED_FIELDS_8(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 9, CHECK_PACKED_FIELDS_9(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 10, CHECK_PACKED_FIELDS_10(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 11, CHECK_PACKED_FIELDS_11(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 12, CHECK_PACKED_FIELDS_12(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 13, CHECK_PACKED_FIELDS_13(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 14, CHECK_PACKED_FIELDS_14(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 15, CHECK_PACKED_FIELDS_15(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 16, CHECK_PACKED_FIELDS_16(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 17, CHECK_PACKED_FIELDS_17(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 18, CHECK_PACKED_FIELDS_18(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 19, CHECK_PACKED_FIELDS_19(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 20, CHECK_PACKED_FIELDS_20(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 21, CHECK_PACKED_FIELDS_21(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 22, CHECK_PACKED_FIELDS_22(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 23, CHECK_PACKED_FIELDS_23(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 24, CHECK_PACKED_FIELDS_24(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 25, CHECK_PACKED_FIELDS_25(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 26, CHECK_PACKED_FIELDS_26(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 27, CHECK_PACKED_FIELDS_27(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 28, CHECK_PACKED_FIELDS_28(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 29, CHECK_PACKED_FIELDS_29(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 30, CHECK_PACKED_FIELDS_30(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 31, CHECK_PACKED_FIELDS_31(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 32, CHECK_PACKED_FIELDS_32(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 33, CHECK_PACKED_FIELDS_33(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 34, CHECK_PACKED_FIELDS_34(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 35, CHECK_PACKED_FIELDS_35(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 36, CHECK_PACKED_FIELDS_36(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 37, CHECK_PACKED_FIELDS_37(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 38, CHECK_PACKED_FIELDS_38(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 39, CHECK_PACKED_FIELDS_39(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 40, CHECK_PACKED_FIELDS_40(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 41, CHECK_PACKED_FIELDS_41(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 42, CHECK_PACKED_FIELDS_42(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 43, CHECK_PACKED_FIELDS_43(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 44, CHECK_PACKED_FIELDS_44(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 45, CHECK_PACKED_FIELDS_45(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 46, CHECK_PACKED_FIELDS_46(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 47, CHECK_PACKED_FIELDS_47(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 48, CHECK_PACKED_FIELDS_48(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 49, CHECK_PACKED_FIELDS_49(fields), \
+	__builtin_choose_expr(ARRAY_SIZE(fields) == 50, CHECK_PACKED_FIELDS_50(fields), \
+	({ BUILD_BUG_ON_MSG(1, "CHECK_PACKED_FIELDS() must be regenerated to support array sizes larger than 50."); }) \
+	))))))))))))))))))))))))))))))))))))))))))))))))))
+
+/* End of generated content */
+
+#define pack_fields(pbuf, pbuflen, ustruct, fields, quirks) \
+	({ \
+		CHECK_PACKED_FIELDS(fields); \
+		CHECK_PACKED_FIELDS_SIZE((fields), (pbuflen)); \
+		_Generic((fields), \
+			 const struct packed_field_s * : pack_fields_s, \
+			 const struct packed_field_m * : pack_fields_m \
+			)((pbuf), (pbuflen), (ustruct), (fields), ARRAY_SIZE(fields), (quirks)); \
+	})
+
+#define unpack_fields(pbuf, pbuflen, ustruct, fields, quirks) \
+	({ \
+		CHECK_PACKED_FIELDS(fields); \
+		CHECK_PACKED_FIELDS_SIZE((fields), (pbuflen)); \
+		_Generic((fields), \
+			 const struct packed_field_s * : unpack_fields_s, \
+			 const struct packed_field_m * : unpack_fields_m \
+			)((pbuf), (pbuflen), (ustruct), (fields), ARRAY_SIZE(fields), (quirks)); \
+	})
+
 #endif
diff --git a/lib/packing.c b/lib/packing.c
index 09a2d195b9433b61c86f3b63ff019ab319c83e97..45164f73fe5bf9f2c547eb22016af7e44fed9eb0 100644
--- a/lib/packing.c
+++ b/lib/packing.c
@@ -5,10 +5,37 @@
 #include <linux/packing.h>
 #include <linux/module.h>
 #include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/bitrev.h>
 
+#define __pack_fields(pbuf, pbuflen, ustruct, fields, num_fields, quirks)	\
+	({									\
+		for (size_t i = 0; i < (num_fields); i++) {			\
+			typeof(&(fields)[0]) field = &(fields)[i];		\
+			u64 uval;						\
+										\
+			uval = ustruct_field_to_u64(ustruct, field->offset, field->size); \
+										\
+			__pack(pbuf, uval, field->startbit, field->endbit,	\
+			       pbuflen, quirks);				\
+		}								\
+	})
+
+#define __unpack_fields(pbuf, pbuflen, ustruct, fields, num_fields, quirks)	\
+	({									\
+		for (size_t i = 0; i < (num_fields); i++) {			\
+			typeof(&(fields)[0]) field = &fields[i];		\
+			u64 uval;						\
+										\
+			__unpack(pbuf, &uval, field->startbit, field->endbit,	\
+				 pbuflen, quirks);				\
+										\
+			u64_to_ustruct_field(ustruct, field->offset, field->size, uval); \
+		}								\
+	})
+
 /**
  * calculate_box_addr - Determine physical location of byte in buffer
  * @box: Index of byte within buffer seen as a logical big-endian big number
@@ -322,4 +349,122 @@ int packing(void *pbuf, u64 *uval, int startbit, int endbit, size_t pbuflen,
 }
 EXPORT_SYMBOL(packing);
 
+static u64 ustruct_field_to_u64(const void *ustruct, size_t field_offset,
+				size_t field_size)
+{
+	switch (field_size) {
+	case 1:
+		return *((u8 *)(ustruct + field_offset));
+	case 2:
+		return *((u16 *)(ustruct + field_offset));
+	case 4:
+		return *((u32 *)(ustruct + field_offset));
+	default:
+		return *((u64 *)(ustruct + field_offset));
+	}
+}
+
+static void u64_to_ustruct_field(void *ustruct, size_t field_offset,
+				 size_t field_size, u64 uval)
+{
+	switch (field_size) {
+	case 1:
+		*((u8 *)(ustruct + field_offset)) = uval;
+		break;
+	case 2:
+		*((u16 *)(ustruct + field_offset)) = uval;
+		break;
+	case 4:
+		*((u32 *)(ustruct + field_offset)) = uval;
+		break;
+	default:
+		*((u64 *)(ustruct + field_offset)) = uval;
+		break;
+	}
+}
+
+/**
+ * pack_fields_s - Pack array of small fields
+ *
+ * @pbuf: Pointer to a buffer holding the packed value.
+ * @pbuflen: The length in bytes of the packed buffer pointed to by @pbuf.
+ * @ustruct: Pointer to CPU-readable structure holding the unpacked value.
+ *	     It is expected (but not checked) that this has the same data type
+ *	     as all struct packed_field_s definitions.
+ * @fields: Array of small packed fields definition. They must not overlap.
+ * @num_fields: Length of @fields array.
+ * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
+ *	    QUIRK_MSB_ON_THE_RIGHT.
+ */
+void pack_fields_s(void *pbuf, size_t pbuflen, const void *ustruct,
+		   const struct packed_field_s *fields, size_t num_fields,
+		   u8 quirks)
+{
+	__pack_fields(pbuf, pbuflen, ustruct, fields, num_fields, quirks);
+}
+EXPORT_SYMBOL(pack_fields_s);
+
+/**
+ * pack_fields_m - Pack array of medium fields
+ *
+ * @pbuf: Pointer to a buffer holding the packed value.
+ * @pbuflen: The length in bytes of the packed buffer pointed to by @pbuf.
+ * @ustruct: Pointer to CPU-readable structure holding the unpacked value.
+ *	     It is expected (but not checked) that this has the same data type
+ *	     as all struct packed_field_s definitions.
+ * @fields: Array of medium packed fields definition. They must not overlap.
+ * @num_fields: Length of @fields array.
+ * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
+ *	    QUIRK_MSB_ON_THE_RIGHT.
+ */
+void pack_fields_m(void *pbuf, size_t pbuflen, const void *ustruct,
+		   const struct packed_field_m *fields, size_t num_fields,
+		   u8 quirks)
+{
+	__pack_fields(pbuf, pbuflen, ustruct, fields, num_fields, quirks);
+}
+EXPORT_SYMBOL(pack_fields_m);
+
+/**
+ * unpack_fields_s - Unpack array of small fields
+ *
+ * @pbuf: Pointer to a buffer holding the packed value.
+ * @pbuflen: The length in bytes of the packed buffer pointed to by @pbuf.
+ * @ustruct: Pointer to CPU-readable structure holding the unpacked value.
+ *	     It is expected (but not checked) that this has the same data type
+ *	     as all struct packed_field_s definitions.
+ * @fields: Array of small packed fields definition. They must not overlap.
+ * @num_fields: Length of @fields array.
+ * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
+ *	    QUIRK_MSB_ON_THE_RIGHT.
+ */
+void unpack_fields_s(const void *pbuf, size_t pbuflen, void *ustruct,
+		     const struct packed_field_s *fields, size_t num_fields,
+		     u8 quirks)
+{
+	__unpack_fields(pbuf, pbuflen, ustruct, fields, num_fields, quirks);
+}
+EXPORT_SYMBOL(unpack_fields_s);
+
+/**
+ * unpack_fields_m - Unpack array of medium fields
+ *
+ * @pbuf: Pointer to a buffer holding the packed value.
+ * @pbuflen: The length in bytes of the packed buffer pointed to by @pbuf.
+ * @ustruct: Pointer to CPU-readable structure holding the unpacked value.
+ *	     It is expected (but not checked) that this has the same data type
+ *	     as all struct packed_field_s definitions.
+ * @fields: Array of medium packed fields definition. They must not overlap.
+ * @num_fields: Length of @fields array.
+ * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
+ *	    QUIRK_MSB_ON_THE_RIGHT.
+ */
+void unpack_fields_m(const void *pbuf, size_t pbuflen, void *ustruct,
+		     const struct packed_field_m *fields, size_t num_fields,
+		     u8 quirks)
+{
+	__unpack_fields(pbuf, pbuflen, ustruct, fields, num_fields, quirks);
+}
+EXPORT_SYMBOL(unpack_fields_m);
+
 MODULE_DESCRIPTION("Generic bitfield packing and unpacking");
diff --git a/lib/packing_test.c b/lib/packing_test.c
index b38ea43c03fd83639f18a6f3e2a42eae36118c45..3b4167ce56bf65fa4d66cb55d3215aecc33f64c4 100644
--- a/lib/packing_test.c
+++ b/lib/packing_test.c
@@ -396,9 +396,70 @@ static void packing_test_unpack(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, uval, params->uval);
 }
 
+#define PACKED_BUF_SIZE 8
+
+typedef struct __packed { u8 buf[PACKED_BUF_SIZE]; } packed_buf_t;
+
+struct test_data {
+	u32 field3;
+	u16 field2;
+	u16 field4;
+	u16 field6;
+	u8 field1;
+	u8 field5;
+};
+
+static const struct packed_field_s test_fields[] = {
+	PACKED_FIELD(63, 61, struct test_data, field1),
+	PACKED_FIELD(60, 52, struct test_data, field2),
+	PACKED_FIELD(51, 28, struct test_data, field3),
+	PACKED_FIELD(27, 14, struct test_data, field4),
+	PACKED_FIELD(13, 9, struct test_data, field5),
+	PACKED_FIELD(8, 0, struct test_data, field6),
+};
+
+static void packing_test_pack_fields(struct kunit *test)
+{
+	const struct test_data data = {
+		.field1 = 0x2,
+		.field2 = 0x100,
+		.field3 = 0xF00050,
+		.field4 = 0x7D3,
+		.field5 = 0x9,
+		.field6 = 0x10B,
+	};
+	packed_buf_t expect = {
+		.buf = { 0x50, 0x0F, 0x00, 0x05, 0x01, 0xF4, 0xD3, 0x0B },
+	};
+	packed_buf_t buf = {};
+
+	pack_fields(&buf, sizeof(buf), &data, test_fields, 0);
+
+	KUNIT_EXPECT_MEMEQ(test, &expect, &buf, sizeof(buf));
+}
+
+static void packing_test_unpack_fields(struct kunit *test)
+{
+	const packed_buf_t buf = {
+		.buf = { 0x17, 0x28, 0x10, 0x19, 0x3D, 0xA9, 0x07, 0x9C },
+	};
+	struct test_data data = {};
+
+	unpack_fields(&buf, sizeof(buf), &data, test_fields, 0);
+
+	KUNIT_EXPECT_EQ(test, 0, data.field1);
+	KUNIT_EXPECT_EQ(test, 0x172, data.field2);
+	KUNIT_EXPECT_EQ(test, 0x810193, data.field3);
+	KUNIT_EXPECT_EQ(test, 0x36A4, data.field4);
+	KUNIT_EXPECT_EQ(test, 0x3, data.field5);
+	KUNIT_EXPECT_EQ(test, 0x19C, data.field6);
+}
+
 static struct kunit_case packing_test_cases[] = {
 	KUNIT_CASE_PARAM(packing_test_pack, packing_gen_params),
 	KUNIT_CASE_PARAM(packing_test_unpack, packing_gen_params),
+	KUNIT_CASE(packing_test_pack_fields),
+	KUNIT_CASE(packing_test_unpack_fields),
 	{},
 };
 
diff --git a/scripts/gen_packed_field_checks.c b/scripts/gen_packed_field_checks.c
new file mode 100644
index 0000000000000000000000000000000000000000..09a21afd640bdf37ad5ee9f6cfa1d4b9113efbcd
--- /dev/null
+++ b/scripts/gen_packed_field_checks.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2024, Intel Corporation
+#include <stdbool.h>
+#include <stdio.h>
+
+#define MAX_PACKED_FIELD_SIZE 50
+
+int main(int argc, char **argv)
+{
+	for (int i = 1; i <= MAX_PACKED_FIELD_SIZE; i++) {
+		printf("#define CHECK_PACKED_FIELDS_%d(fields) ({ \\\n", i);
+		printf("\ttypeof(&(fields)[0]) _f = (fields); \\\n");
+		printf("\tBUILD_BUG_ON(ARRAY_SIZE(fields) != %d); \\\n", i);
+
+		for (int j = 0; j < i; j++)
+			printf("\tCHECK_PACKED_FIELD(_f[%d]); \\\n", j);
+
+		for (int j = 1; j < i; j++)
+			printf("\tCHECK_PACKED_FIELD_OVERLAP(_f[0].startbit < _f[1].startbit, _f[%d], _f[%d]); \\\n",
+			       j - 1, j);
+
+		printf("})\n\n");
+	}
+
+	printf("#define CHECK_PACKED_FIELDS(fields) \\\n");
+
+	for (int i = 1; i <= MAX_PACKED_FIELD_SIZE; i++)
+		printf("\t__builtin_choose_expr(ARRAY_SIZE(fields) == %d, CHECK_PACKED_FIELDS_%d(fields), \\\n",
+		       i, i);
+
+	printf("\t({ BUILD_BUG_ON_MSG(1, \"CHECK_PACKED_FIELDS() must be regenerated to support array sizes larger than %d.\"); }) \\\n",
+	       MAX_PACKED_FIELD_SIZE);
+
+	for (int i = 1; i <= MAX_PACKED_FIELD_SIZE; i++)
+		printf(")");
+
+	printf("\n");
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index 0456a33ef65792bacb5d305a6384d245844fb743..397dfdab2d92a969d367dcf77207d387cda451e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17561,6 +17561,7 @@ F:	Documentation/core-api/packing.rst
 F:	include/linux/packing.h
 F:	lib/packing.c
 F:	lib/packing_test.c
+F:	scripts/gen_packed_field_checks.c
 
 PADATA PARALLEL EXECUTION MECHANISM
 M:	Steffen Klassert <steffen.klassert@secunet.com>
diff --git a/scripts/Makefile b/scripts/Makefile
index 6bcda4b9d054021b185488841cd36c6e0fb86d0c..546e8175e1c4c8209e67a7f92f7d1e795a030988 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -47,7 +47,7 @@ HOSTCFLAGS_sorttable.o += -DMCOUNT_SORT_ENABLED
 endif
 
 # The following programs are only built on demand
-hostprogs += unifdef
+hostprogs += unifdef gen_packed_field_checks
 
 # The module linker script is preprocessed on demand
 targets += module.lds

-- 
2.47.0.265.g4ca455297942


