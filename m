Return-Path: <netdev+bounces-244540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D322CB9A7F
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 20:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C94830C4096
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 19:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61BA30C618;
	Fri, 12 Dec 2025 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="EPcmFEeZ"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD8530B53F;
	Fri, 12 Dec 2025 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765568297; cv=none; b=ti7KhAwOqMWksPHcuy0KOzV10U656tN6BYDRUnc1ONbr5LM/7ZH1Z9c9EboxPcwsTvElsqGhfa3+/OE60Nip/jek3TCVfXcaOKVfWg3ZXwQrfXuGnvf+9SaW3LBHjObz7+2+6LzUQescwQVt++fJFpWnaLdYKlUEDvvI2vRLjZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765568297; c=relaxed/simple;
	bh=3MgYeGV5f97OocFYM35DoH9AT3refnY61WAO4MPnPfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nWv6tMrXzLd2nyIlTO96CoFtm8PQAuDiJ0uKN7xeQel6FVWaAXh5T70O9ywuS01Osuy7UcCNgAtZ/igqhImNZUpdw7Y5o2z8WeCWrxHz7djLAHq5HevrTHUvFAwRu6YLCM9s0JHyuCylh4qhgbkE0DcnJmvix9zJr71Obb5yJgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=EPcmFEeZ; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xv-007Tb4-O6; Fri, 12 Dec 2025 20:38:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=16a1w0ZjBufiGEzex6si94JfgFJX4Q/C1ixMUo2n3VE=; b=EPcmFEeZdJ091CaHHWYsMa3rTi
	CJcIBlGZo88idPArXWZT/oJ5ytgGwaQgus8fKqyzTmmXQYCzwXNfA5RcPMUBnlLx/0RTQAtqNhLY/
	dlcxMHeVwoTkRKDxj32yHtB6fmmg16PQVgsrhgbSwYgeNFCk2FKrqy031lAt50TqEIm06cvMiA5Pd
	6WHARMCcyjonLUlhgBVzZGzwBQRyMOW7qYi/mF2GdIIT4rIOPIxnzwinXVTud/zC7H8d5cokKbNT3
	sqt5+p7qr57TRZB3858RYCUjMIxAo/bnkfhROtKMXUqqnSTLuNZI5yzBKwlEiBQIwNYV3WTO0eSTH
	8QX588OA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xv-0003A3-EZ; Fri, 12 Dec 2025 20:38:11 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vU8xg-0030pR-TF; Fri, 12 Dec 2025 20:37:57 +0100
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
Subject: [PATCH v2 08/16] bitfield: Simplify __BF_FIELD_CHECK_REG()
Date: Fri, 12 Dec 2025 19:37:13 +0000
Message-Id: <20251212193721.740055-9-david.laight.linux@gmail.com>
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

Simplify the check for 'reg' being large enough to hold 'mask' using
sizeof (reg) rather than a convoluted scheme to generate an unsigned
type the same size as 'reg'.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/bitfield.h | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index c354ca2ef1a0..7160b762c979 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -45,22 +45,6 @@
 
 #define __bf_shf(x) (__builtin_ffsll(x) - 1)
 
-#define __scalar_type_to_unsigned_cases(type)				\
-		unsigned type:	(unsigned type)0,			\
-		signed type:	(unsigned type)0
-
-#define __unsigned_scalar_typeof(x) typeof(				\
-		_Generic((x),						\
-			char:	(unsigned char)0,			\
-			__scalar_type_to_unsigned_cases(char),		\
-			__scalar_type_to_unsigned_cases(short),		\
-			__scalar_type_to_unsigned_cases(int),		\
-			__scalar_type_to_unsigned_cases(long),		\
-			__scalar_type_to_unsigned_cases(long long),	\
-			default: (x)))
-
-#define __bf_cast_unsigned(type, x)	((__unsigned_scalar_typeof(type))(x))
-
 #define __BF_FIELD_CHECK_MASK(_mask, _val, _pfx)			\
 	({								\
 		BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),		\
@@ -75,8 +59,8 @@
 	})
 
 #define __BF_FIELD_CHECK_REG(mask, reg, pfx)				\
-	BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >		\
-			 __bf_cast_unsigned(reg, ~0ull),		\
+	BUILD_BUG_ON_MSG((mask) + 0U + 0UL + 0ULL >			\
+			 ~0ULL >> (64 - 8 * sizeof (reg)),		\
 			 pfx "type of reg too small for mask")
 
 #define __BF_FIELD_CHECK(mask, reg, val, pfx)				\
-- 
2.39.5


