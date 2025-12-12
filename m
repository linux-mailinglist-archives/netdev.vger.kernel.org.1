Return-Path: <netdev+bounces-244549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6916CB9B09
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 20:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1D7830615A1
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 19:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5EE31D38B;
	Fri, 12 Dec 2025 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="qzp4HEFr"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1981C3101A5;
	Fri, 12 Dec 2025 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765568304; cv=none; b=gIsTYkgseNb07W+ABsPymNH4jiYkLRjByYqH7Kc0GC1hn3vgaWORZ+oGdm4eCObihgGKHUBjozQvM6QdUY0kxSQIJcHjDG2RDUo7IHR/R3WRIfZ2CZPFkpbJDpPaEfMLitjvZSN5HwIVKj3GAonv1Vmp8eiMlLYRVXPO9fRdalo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765568304; c=relaxed/simple;
	bh=Ccr1EarAMFaJl6TVejUdtnp6jxA9i93IxK5KG/WKPVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tIgL3pKPCdbYjB/7XXQVBpV7Bdq+qPrafdqdKC0J2Glz04JycKvM9El63A02E0VqQ2sALn/7NmyXLo8s7ABIxb9cZtP9iGba9RW8mdyPCsqb6rBswNXfHDKV3Ch+jKCdjH4+LQg6i20WccHRDRx5cMRHIidVStQYL5j3Gm6QKGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=qzp4HEFr; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xv-007Tav-Bt; Fri, 12 Dec 2025 20:38:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=6+sXrUr5LvBqW8hHD2oULe/kxjAvnPiwR/5Jz/SJlSY=; b=qzp4HEFrE9mNFqiaaneQOvR2Bh
	mIGWY/Vbrpdzq8LWo5aPKldFXJ5VE5en4WQybR+PgzmrXFipuNHFCDItilEJ74OvVA5lfEwtl/Wht
	mXgRil8IKGcf/tvxRwwekGJswfmJVq6dG6ZBr1we6n0oinQPkaErGd/VIPVklOgL35wxEMeclCtnG
	vamzhonZWS7+29s3CvoddOh2Y5ZYVJAg24efZxAm4lsYsAifVS3WtPnyX9nc8yLK9g+umVOeNu4pt
	v23EHn44cACRuiy47aWRme6OPpz2YHyBE3vlom4/QJ5fHIC5kv+ggi6zXP/2Q8GHUJR8ObepWnRN+
	viGskkcA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xv-0006un-0k; Fri, 12 Dec 2025 20:38:11 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vU8xk-0030pR-1q; Fri, 12 Dec 2025 20:38:00 +0100
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
Subject: [PATCH v2 11/16] bitfield: Common up validation of the mask parameter
Date: Fri, 12 Dec 2025 19:37:16 +0000
Message-Id: <20251212193721.740055-12-david.laight.linux@gmail.com>
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

There are three places where the mask is checked for being non-zero
and contiguous.
Add a simple expression that checks it and use in all three places.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/bitfield.h | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 138f4c14786d..6f454ef43d24 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -45,13 +45,15 @@
 
 #define __bf_shf(x) (__builtin_ffsll(x) - 1)
 
+#define __BF_VALIDATE_MASK(mask) \
+	(!(mask) || ((mask) & ((mask) + ((mask) & -(mask)))))
+
 #define __BF_FIELD_CHECK_MASK(_mask, _pfx)				\
 	do {								\
 		BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),		\
 				 _pfx "mask is not constant");		\
-		BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");	\
-		__BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +			\
-					      (1ULL << __bf_shf(_mask))); \
+		BUILD_BUG_ON_MSG(__BF_VALIDATE_MASK(_mask),		\
+				 _pfx "mask is zero or not contiguous");	\
 	} while (0)
 
 #define __BF_FIELD_CHECK_VAL(mask, val, pfx)			\
@@ -122,8 +124,6 @@
 		__BF_FIELD_PREP(_mask, _val, "FIELD_PREP: ");		\
 	})
 
-#define __BF_CHECK_POW2(n)	BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
-
 /**
  * FIELD_PREP_CONST() - prepare a constant bitfield element
  * @_mask: shifted mask defining the field's length and position
@@ -138,12 +138,10 @@
  */
 #define FIELD_PREP_CONST(_mask, _val)					\
 	(								\
-		/* mask must be non-zero */				\
-		BUILD_BUG_ON_ZERO((_mask) == 0) +			\
+		/* mask must be non-zero and contiguous */		\
+		BUILD_BUG_ON_ZERO(__BF_VALIDATE_MASK(_mask)) +		\
 		/* check if value fits */				\
 		BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
-		/* check if mask is contiguous */			\
-		__BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +	\
 		/* and create the value */				\
 		(((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))	\
 	)
@@ -189,7 +187,7 @@ extern void __compiletime_error("bad bitfield mask")
 __bad_mask(void);
 static __always_inline u64 field_multiplier(u64 field)
 {
-	if ((field | (field - 1)) & ((field | (field - 1)) + 1))
+	if (__BF_VALIDATE_MASK(field))
 		__bad_mask();
 	return field & -field;
 }
-- 
2.39.5


