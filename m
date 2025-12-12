Return-Path: <netdev+bounces-244550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F49CB9B24
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 20:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0021E314631B
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 19:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7FB3218B8;
	Fri, 12 Dec 2025 19:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="rcVDa5YA"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDA93126D8;
	Fri, 12 Dec 2025 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765568304; cv=none; b=ht0RzKRmzOJF5RhBdafrz30JzkJrgx/TuP6xjxz9Lfr5TjW8zd5wdpIZTMdEH6sQtJrxF85Mcftnxr0EAaZt3xjRgZRdy02ieJjpWsMhCH31yIdc8A7kw62YIZ6xEb+UWqsROH2XZkOr7IzaUGZzqxc+2JXZ7eZX3Bu+fumyREU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765568304; c=relaxed/simple;
	bh=qGRxQF8GFDnNcaSRGguN86dTeYa8fKIIpe8exdR+8yE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s8tSaU9sYziGc2JBBH994lRhUnq2D+0doTF+jg5cRUXxQzmCiKOQNcrPvOEe0cpfao3iSl9Nl4/4PiyGLT4sTjz79BfVVSGy+ebtGOnP4ZvsMUjxGGlvhSMVoH5kEYu8lV2kmq0CczK4WiGrSqpB95Echs4243QFgqbsqUpsrvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=rcVDa5YA; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xy-007TcT-UY; Fri, 12 Dec 2025 20:38:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=Gz2PF6SRur9iX1hthbk/yf6ubztCbT5FrnIggMPjKuA=; b=rcVDa5YAtioXHHVFgViVLZVf/H
	UsgytYd98oJzotmL6Uz1rLYrBDtNcBajZ6A0uKmzGLd6NpSRstQJ+R62nDgaQvkGegAka3G3QCC11
	X0oMvTj3XNCvh7LHxM9gCaw4VG6znltNOkSCEL8Osrl/CSMSLXep+vIyNMu5wTYD611YLaBQqE9Y5
	SKFTjQMeCLSCd39S9LIx/MxqJuXOCJl0/hHzQ/NZFGosKhJN7blvUmwhCw5VoZM89WTrngWC5uMSE
	Txbo9nWxITLP9PrisAfEmcWMW8D8kbeXnTHh4zcjEJJ+2FNShrHaW3HuPInJ0hJYPO0Z7iYdkHslp
	hLdlVHPA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xy-0006uz-KF; Fri, 12 Dec 2025 20:38:14 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vU8xf-0030pR-Ru; Fri, 12 Dec 2025 20:37:55 +0100
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
Subject: [PATCH v2 07/16] bitfield: FIELD_MODIFY: Only do a single read/write on  the target
Date: Fri, 12 Dec 2025 19:37:12 +0000
Message-Id: <20251212193721.740055-8-david.laight.linux@gmail.com>
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

Replace the:
        *reg &= ~mask; *reg |= new_value;
with a single assignment.
While the compiler will usually optimise the extra access away
it isn't guaranteed.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/bitfield.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index f1859e28df5d..c354ca2ef1a0 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -200,8 +200,7 @@
 		__auto_type _val = 1 ? (val) : _mask;					\
 		typecheck_pointer(_reg_p);						\
 		__BF_FIELD_CHECK(_mask, *(_reg_p), _val, "FIELD_MODIFY: ");		\
-		*(_reg_p) &= ~(_mask);							\
-		*(_reg_p) |= (_val << __bf_shf(_mask)) & _mask;				\
+		*_reg_p = (*_reg_p & ~_mask) | ((_val << __bf_shf(_mask)) & _mask);	\
 	})
 
 extern void __compiletime_error("value doesn't fit into mask")
-- 
2.39.5


