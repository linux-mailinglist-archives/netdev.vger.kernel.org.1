Return-Path: <netdev+bounces-244552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 596FDCB9AE8
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 20:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C74D30146E9
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 19:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6B83233EE;
	Fri, 12 Dec 2025 19:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="bu2KWORW"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A95316197
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 19:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765568305; cv=none; b=Qqlke0OBMXOYBETc5crrIuYJ8IHMSIc66QptOndXHpgtntX6lNm1WLdp7Uz/y7PJ9Ru/BGrM7anj23U2ogfRny/X7/77RpWOtN0ijGlnsCps8hD994L6hKLVNIEsb9JmYIbq+BWJt/tccZLziBBwkB/Hxefjpox/P3ivpwX8jSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765568305; c=relaxed/simple;
	bh=0LivVI6n2Hn6n9OC7XzMKkHYvEuxGTxy2TCbVRFLvp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o2h7zbvZCryjHXo7woyJABTEaGAiKNQPqdxZkICenfIduRh/m2KO/ZMdkCic2nYTgPzKjqXeSA+j2Ky9RqZ9gBu2P0MlwKja3tlYi9jPgCliB/Z6U9WpkMlNgYEH75cezxAEqYzezT5sj+NQpYmNmncZ264r2fFv7YI4mwGwY2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=bu2KWORW; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xx-0087fN-97; Fri, 12 Dec 2025 20:38:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=K3GjdOlpY6miMHRcMr+AALWLshNL5czI7BOpgFx6os0=; b=bu2KWORW3Adja9xUa9PQSPIHCd
	m7v/JlPBqaiVxiddGomf5+e//NGcMrmdU14xBevFL7J9CiEQC8gXKX1oG8cMXugLfttp1D24e1Rrp
	32n3ZR7jQi696/px2IfrAXnxAiPR00U/OdtqSpGLzrcrwDqGbBBvJcndNkokLTOTWdkMWE5F7HwjI
	2ewng04+DRmokPV05S8vtly1MV5DhE33mBZSoRQGkWPtD7OJz6Iaeif06EszmPEMy/molKwrYSwoG
	kFycIHX6QmkOtdej9rG0HrlVe1vd7qs/GOgrA0Zx8XY68hKOplySl03QqGgCHzZRG8eV4u99hOXSC
	o8+W3Sgg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xw-0006ut-TP; Fri, 12 Dec 2025 20:38:13 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vU8xo-0030pR-77; Fri, 12 Dec 2025 20:38:04 +0100
From: david.laight.linux@gmail.com
To: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Crt Mori <cmo@melexis.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Luo Jie <quic_luoj@quicinc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v2 15/16] bitfield: Update comments for le/be functions
Date: Fri, 12 Dec 2025 19:37:20 +0000
Message-Id: <20251212193721.740055-16-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251212193721.740055-1-david.laight.linux@gmail.com>
References: <20251212193721.740055-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Make it clear the the values are converted to host order before
being acted on.
Order the explantions with the simple functions first.

These still need converting to kerneldoc format.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/bitfield.h | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 3bf82121a282..3f43683ebe96 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -184,24 +184,24 @@ do {								\
 /*
  * Primitives for manipulating bitfields both in host- and fixed-endian.
  *
- * * u32 le32_get_bits(__le32 val, u32 field) extracts the contents of the
- *   bitfield specified by @field in little-endian 32bit object @val and
- *   converts it to host-endian.
  *
- * * void le32p_replace_bits(__le32 *p, u32 v, u32 field) replaces
- *   the contents of the bitfield specified by @field in little-endian
- *   32bit object pointed to by @p with the value of @v.  New value is
- *   given in host-endian and stored as little-endian.
+ * * u32 le32_get_bits(__le32 val, u32 field) converts the little-endian 32bit
+ *   object @val to host-endian then extracts the contents of the bitfield
+ *   specified by @field.
+ *
+ * * __le32 le32_encode_bits(u32 v, u32 field) encodes the value of @v into
+ *   the bitfield specified by @field then converts the value to little-endian.
+ *   All the bits outside that bitfield being zero.
  *
- * * __le32 le32_replace_bits(__le32 old, u32 v, u32 field) is equivalent to
- *   ({__le32 tmp = old; le32p_replace_bits(&tmp, v, field); tmp;})
- *   In other words, instead of modifying an object in memory, it takes
- *   the initial value and returns the modified one.
+ * * __le32 le32_replace_bits(__le32 old, u32 v, u32 field) converts the
+ *   little-endian 32bit object @old to host order, replaces the contents
+ *   of the bitfield specified by @field with @v, then returns the value
+ *   converted back to little-endian.
  *
- * * __le32 le32_encode_bits(u32 v, u32 field) is equivalent to
- *   le32_replace_bits(0, v, field).  In other words, it returns a little-endian
- *   32bit object with the bitfield specified by @field containing the
- *   value of @v and all bits outside that bitfield being zero.
+ * * void le32p_replace_bits(__le32 *p, u32 v, u32 field) replaces
+ *   the contents of the bitfield specified by @field in little-endian
+ *   32bit object pointed to by @p with the value of @v.
+ *   Equivalent to *p = le32_replace_bits(*p, v, field).
  *
  * Such set of helpers is defined for each of little-, big- and host-endian
  * types; e.g. u64_get_bits(val, field) will return the contents of the bitfield
@@ -210,15 +210,13 @@ do {								\
  *
  * Fields to access are specified as GENMASK() values - an N-bit field
  * starting at bit #M is encoded as GENMASK(M + N - 1, M).  Note that
- * bit numbers refer to endianness of the object we are working with -
+ * bit numbers refer to the value after being converted to host order -
  * e.g. GENMASK(11, 0) in __be16 refers to the second byte and the lower
  * 4 bits of the first byte.  In __le16 it would refer to the first byte
  * and the lower 4 bits of the second byte, etc.
  *
- * Field specification must be a constant; __builtin_constant_p() doesn't
- * have to be true for it, but compiler must be able to evaluate it at
- * build time.  If it cannot or if the value does not encode any bitfield,
- * the build will fail.
+ * Field specification must be a non-zero constant, otherwise the build
+ * will fail.
  *
  * If the value being stored in a bitfield is a constant that does not fit
  * into that bitfield, a warning will be generated at compile time.
-- 
2.39.5


