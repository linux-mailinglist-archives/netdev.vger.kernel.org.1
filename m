Return-Path: <netdev+bounces-244544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB58CB9A94
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 20:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 781F0302F68D
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 19:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA0230EF66;
	Fri, 12 Dec 2025 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="hDKaCwM2"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8A830BB98
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765568301; cv=none; b=nshrKlt/vlBAhAfjRQ3/Ffwfdf7B5E2jJjPpQWQdJ04LxCsuQeINzqPSz8zzwJLUCMcEJwqcMgU2HgvS6uo7Z49u8dGeHxZUCWrPTyj+6aXq1suHzXzOilSWsPwcwyq7vc5V6kH5Z9LFk7CK4lK8aOPPTu4vm2w+pQSjcQ7lwbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765568301; c=relaxed/simple;
	bh=4DhYdBQ8yGIeD+NXQinvRz/pDWYNEBhrFO/YnPCkfe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J77YkZvdw3YvLE3/BNkAm3ym+i0HTQqvyYkhYUllQohLdNPYxc4jCmSakNg6/KzJ9Z8e0xdMeX4pXo1wkFz29w40r2Qw9GTgTe6WW5H3fwWDTohLExlzFqgaxaxoqctK7KQJktXauYwlJdwCmjBH7awRXdLIuCiexD2N8PHY3C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=hDKaCwM2; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xu-0087b7-29; Fri, 12 Dec 2025 20:38:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=LTG3TP4CYSEEXpFm2SzMNXKADoomq1D1zd91C1jNRlI=; b=hDKaCwM2e1S9f6NaM6UQaKwZ3W
	P4K4x6XuLm2PNvX0Iu9yIGFzxhLxYBSpnI556EyO1izvFbhpG96TiApCwb7zeBhEeFB5W+8KTLeM8
	toNuMg89W8hT2OoIqw5aOkvpCetLUYMGiHNTAWiTsSF7dqtR3t9qW38LKzHVMmxnqS86trxsflEIg
	qbRg5ZDVBlVAmQnltM1U88gzERaK6MF3XQxU1AZGb1gFaAFn+1hWDaSG7bTpwtqBb+hRDAM/PhWME
	j++vmTVx8StMjK1pJosHas9aHh0GMsU/Miiht7Nsx/7ltdHpWlxMD3jutcLg/8GMM56cJTi54qGpl
	iOEbZ/ow==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xt-00039r-Lp; Fri, 12 Dec 2025 20:38:09 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vU8xe-0030pR-RE; Fri, 12 Dec 2025 20:37:54 +0100
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
Subject: [PATCH v2 06/16] bitfield: Remove some pointless casts
Date: Fri, 12 Dec 2025 19:37:11 +0000
Message-Id: <20251212193721.740055-7-david.laight.linux@gmail.com>
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

Now that _val is always large enough to hold _mask there is no need
to cast it before the shift left.

This also corrects the incorrect parenthesis in FIELD_FIT(),
unlikely to be a real problem.

For FIELD_GET() and FIELD_MAX() there is no point casting the
result of the shift to the type of mask.
Even if mask were char/short the value will immediately be promoted
to 'signed int' as soon as it is used.
All that is likely to happen is an extra and with 0xff.

Remove the associated extra (...) around __auto_type variable.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/bitfield.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index c30120535680..f1859e28df5d 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -88,13 +88,13 @@
 #define __FIELD_PREP(mask, val, pfx)					\
 	({								\
 		__BF_FIELD_CHECK_MASK(mask, val, pfx);			\
-		((typeof(mask))(val) << __bf_shf(mask)) & (mask);	\
+		((val) << __bf_shf(mask)) & (mask);			\
 	})
 
 #define __FIELD_GET(mask, reg, pfx)					\
 	({								\
 		__BF_FIELD_CHECK_MASK(mask, 0U, pfx);			\
-		(typeof(mask))(((reg) & (mask)) >> __bf_shf(mask));	\
+		((reg) & (mask)) >> __bf_shf(mask);			\
 	})
 
 /**
@@ -108,7 +108,7 @@
 	({								\
 		__auto_type _mask = mask;				\
 		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_MAX: ");	\
-		(typeof(_mask))((_mask) >> __bf_shf(_mask));		\
+		(_mask >> __bf_shf(_mask));				\
 	})
 
 /**
@@ -123,7 +123,7 @@
 		__auto_type _mask = mask;				\
 		__auto_type _val = 1 ? (val) : _mask;			\
 		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_FIT: ");	\
-		!((((typeof(_mask))_val) << __bf_shf(_mask)) & ~(_mask)); \
+		!((_val << __bf_shf(_mask)) & ~_mask);			\
 	})
 
 /**
@@ -201,7 +201,7 @@
 		typecheck_pointer(_reg_p);						\
 		__BF_FIELD_CHECK(_mask, *(_reg_p), _val, "FIELD_MODIFY: ");		\
 		*(_reg_p) &= ~(_mask);							\
-		*(_reg_p) |= (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask));	\
+		*(_reg_p) |= (_val << __bf_shf(_mask)) & _mask;				\
 	})
 
 extern void __compiletime_error("value doesn't fit into mask")
-- 
2.39.5


