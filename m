Return-Path: <netdev+bounces-244090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE872CAF936
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 11:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C93F30220F6
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 10:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E4C322B85;
	Tue,  9 Dec 2025 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="mUrpEN13"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1E2301474;
	Tue,  9 Dec 2025 10:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765274628; cv=none; b=ZLf1KsD4Tkpiv5XgA+iflROpeUuQe+GuaVLw2TUr7Hs01F3fBbJEq+wHca/Y/SRXm/LQF+9kRaZBO59D6MRJHEiJSHL/JqS6KyoLca231inUmA/jMvj2b9cmdwlG0VvqKCG+obvy9So1xT44wLjEq5i45JlgMoJWEjHkfzgurLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765274628; c=relaxed/simple;
	bh=9GEZ1qcQcq+OU+/HJx1o4UIA998BTTxrtDXBo1mZRD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IsyM9bkmCK2ttfW0dVf72ndAeYQw2gHasXksiytouBZpp82VnSroyPcQBrQ6pPEprMyT6XM6m6P2lrDbZaJA7CF0pVhnvYVKgJwmx4PIRgVq2Tt152f3S0yEhlojulEgAAy1/snn/2Xag2xJFAC/ti58GJvbmfI8cdvafB35RDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=mUrpEN13; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vSuZ7-00HD4s-8r; Tue, 09 Dec 2025 11:03:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=YGnBBG9ZzprxJLEp94vtepq3lcPSfdeE6BD41wIj1gg=; b=mUrpEN13REkNMaUzxXJy60b3ra
	lR3EJczQGfp6BhxvZmLKXwOJRG4Cjf58rrzBDK1tRGJheVUlF3nI/pVTnGrLV0b5VXs99f1YboTU1
	TppUIsxBWefpljsR+brKOkzToAxRqku61ZAY0Y/+z9uQxq/LwIprA+6oNSq0Kp424/KkHow+kLK3h
	LZ17mF3czhqWsCVWxRMvhaU3Fk6i8SThjEFQTxi/E6+0XStJwrBf/j5rCrUm6hnWJFgIkuHTkTH/Y
	Ffl1xT6d90VvW3bJuyR/5T4KDHqAxwPsZWx4p1zgCWXdO8N96DB9wPxob5uAylZqs0pucEMj8wlel
	fmJMdaiQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vSuZ5-00074w-Vv; Tue, 09 Dec 2025 11:03:28 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vSuZ3-00CND9-Jl; Tue, 09 Dec 2025 11:03:25 +0100
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
	Simon Horman <simon.horman@netronome.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 3/9] bitmap: Use FIELD_PREP() in expansion of FIELD_PREP_WM16()
Date: Tue,  9 Dec 2025 10:03:07 +0000
Message-Id: <20251209100313.2867-4-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251209100313.2867-1-david.laight.linux@gmail.com>
References: <20251209100313.2867-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Instead of directly expanding __BF_FIELD_CHECK() (which really ought
not be used outside bitfield) and open-coding the generation of the
masked value, just call FIELD_PREP() and add an extra check for
the mask being at most 16 bits.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/hw_bitfield.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/linux/hw_bitfield.h b/include/linux/hw_bitfield.h
index df202e167ce4..d7f21b60449b 100644
--- a/include/linux/hw_bitfield.h
+++ b/include/linux/hw_bitfield.h
@@ -23,15 +23,14 @@
  * register, a bit in the lower half is only updated if the corresponding bit
  * in the upper half is high.
  */
-#define FIELD_PREP_WM16(_mask, _val)					     \
-	({								     \
-		typeof(_val) __val = _val;				     \
-		typeof(_mask) __mask = _mask;				     \
-		__BF_FIELD_CHECK(__mask, ((u16)0U), __val,		     \
-				 "HWORD_UPDATE: ");			     \
-		(((typeof(__mask))(__val) << __bf_shf(__mask)) & (__mask)) | \
-		((__mask) << 16);					     \
-	})
+#define FIELD_PREP_WM16(mask, val)				\
+({								\
+	__auto_type _mask = mask;				\
+	u32 _val = FIELD_PREP(_mask, val);			\
+	BUILD_BUG_ON_MSG(_mask > 0xffffu,			\
+			 "FIELD_PREP_WM16: mask too large");	\
+	_val | (_mask << 16);					\
+})
 
 /**
  * FIELD_PREP_WM16_CONST() - prepare a constant bitfield element with a mask in
-- 
2.39.5


