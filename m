Return-Path: <netdev+bounces-244539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E79F5CB9A79
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 20:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE1A430BEA7C
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 19:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B8530C373;
	Fri, 12 Dec 2025 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="pagUMnJu"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C292F83DC;
	Fri, 12 Dec 2025 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765568297; cv=none; b=FITsWjn/ElxfH4AXQWZ/L7gYqkV/LtiEM+/mD/sXJXoPnJnhJDxleE2ZEYsgyFRg7TcGGZEqUlkuqH7GnFkXlGFRs6ADMf5tVYQVmm2GWWKWpKxBmzs+YVksXWeKvCLzh3J1jUCTZBxr7yiAqcsNxCBQ1ybLLeriqEDhvzRRmKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765568297; c=relaxed/simple;
	bh=zAilw6c1cTSLXleqFwparWwFnbwn1cLEm5G/XlL7Ptg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HLtAbEEjdu+cwRdUm4hVWBHZodzMK65wPzGBVKgF1r8ODTSLRlWhLpJNdlfMU9akWGvE9ruZGhm7LvL7dRa8t4JshdOCphGbNSi6qKORRjuTiRi8wvEgRIgGPVWvTJE3TUEKSqlI5eG9Hq+DOSkjPjN7qtc+me/arEprMR56LLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=pagUMnJu; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xu-007Tao-Tr; Fri, 12 Dec 2025 20:38:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=gClv2ms3a8GLsRYy6HjqpYNYZFcf9BvN9jrm2mdq1WA=; b=pagUMnJuCRnozopuHaivaccyLT
	r2pGb7PaZDYxLpM6osM7m7vz8KS09ge9xR/l0xhNbNcZow/5z5y66+dlsJgz15f+r7pCjFKDxZWYq
	gI5jLfMAl7+AQk6/Mk7f6N7C4vX+vNA8/LWkMi0okplFi333u8tX8/KZ6NdNK+6EvYQ1ZKmG5CLf7
	3hIvLwfScFl3TqOw5jGZ99gP8G0Y/eATz7rtY/9geL6+kFc9DV5EAn+C5Z8HqG/a2+f3FTWhigRjq
	/97QXdh7j4Fem4VgmPj7yWl5DWNc/YXK7jXffW7tftTH3K0CSuLvHlu/icnlzX8tPSnL68+QZK++0
	HoiCd0/w==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xu-0006uh-Ig; Fri, 12 Dec 2025 20:38:10 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vU8xa-0030pR-JL; Fri, 12 Dec 2025 20:37:50 +0100
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
Subject: [PATCH v2 02/16] thunderbolt: Don't pass a bitfield to FIELD_GET
Date: Fri, 12 Dec 2025 19:37:07 +0000
Message-Id: <20251212193721.740055-3-david.laight.linux@gmail.com>
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

None of sizeof(), typeof() or __auto_type can be used with bitfields
which makes it difficult to assign a #define parameter to a local
without promoting char and short to int.

Change:
	u32 thunderbolt_version:8;
to the equivalent:
	u8 thunderbolt_version;
(and the other three bytes of 'DWORD 4' to match).

This is necessary so that FIELD_GET can use sizeof() to verify 'reg'.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

Changes for v2:
- Change structure definition instead of call to FIELD_GET().

FIELD_GET currently uses _Generic() which behaves differently for
gcc and clang (I suspect both are wrong!).
gcc treats 'u32 foo:8' as 'u8', but will take the 'default' for other
widths (which will generate an error in FIED_GET().
clang treats 'u32 foo:n' as 'u32'.

 drivers/thunderbolt/tb_regs.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index c0bf136236e6..f35f062beb34 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -180,14 +180,14 @@ struct tb_regs_switch_header {
 	u32 route_hi:31;
 	bool enabled:1;
 	/* DWORD 4 */
-	u32 plug_events_delay:8; /*
-				  * RW, pause between plug events in
-				  * milliseconds. Writing 0x00 is interpreted
-				  * as 255ms.
-				  */
-	u32 cmuv:8;
-	u32 __unknown4:8;
-	u32 thunderbolt_version:8;
+	u8 plug_events_delay; /*
+			       * RW, pause between plug events in
+			       * milliseconds. Writing 0x00 is interpreted
+			       * as 255ms.
+			       */
+	u8 cmuv;
+	u8 __unknown4;
+	u8 thunderbolt_version;
 } __packed;
 
 /* Used with the router thunderbolt_version */
-- 
2.39.5


