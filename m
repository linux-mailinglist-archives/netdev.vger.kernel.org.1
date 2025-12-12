Return-Path: <netdev+bounces-244547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4366ECB9B1B
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 20:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FD8F3116D42
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 19:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B26314A9F;
	Fri, 12 Dec 2025 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="GbCAZmdY"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D36B30E0DF;
	Fri, 12 Dec 2025 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765568302; cv=none; b=JItok7ikyTD5rHStzqOsjNIbtvdKEDem7m00elxxhnBEGSacgoaXCIc89k7dhMUp1BpqZxNLqgJQfETt/XIe29YnhiyJx6qt8qeSfPcUhxdnwDt48svLl4cllaBs+Gh1AlI22nZdvI74lDdA1SOY28x3opJMyQV3uOxZFyQeCug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765568302; c=relaxed/simple;
	bh=eSanA0nLIBnaxYkOxEDR3V3ZjDGcD9zNpqK4QeXpRW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uP7W9K/V3iGs1w6BJeRMyZo4aD7YV1binykddWrRqU9glx47CP1P7HLgII8v+XVBj8gjg41Ls4FuKfTMvr6U0s7bbRy3rKupULhVO21yyAMebLq/Q4oom9icmrWIX8d9AZMX0/ER570SyuyBwp2qR0XV55t4WoX3Ukg2Vd38fPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=GbCAZmdY; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xw-0087cj-9E; Fri, 12 Dec 2025 20:38:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=E/tgkX0LFHmCKon+QMYZwmLD5pzvPWhgIG9AyUVS/4A=; b=GbCAZmdYgLDD6BsKEv/7nB5GEj
	SCi0M5uT3FlqXbwhSGRdAsoIZBKDw+DNz4YP/Tuxphx8LFDUFyOLUVMxTu2wlxOgYzzSZVndai3Z2
	tqGbsp45aznudJRQappgJddb+Wq47yHv0KZjbWnRhHzzJjH6O9jFNADB45lpo8ojMIu4jiZTyjIUS
	/57sbdSiOiyloDKXVoKJFp9zvI0B83/CSL1UDxkYo60A+uhtUWicciSeD+3lCLFPv2DCRoR1vlNcj
	TG5fF8kdwhwFl/+Asg0G4/XgPcihZIZCi28PCzl2Dp/c7GzqCbjf1e6oRGYkXq01hVq7d6BZ3UsPM
	qKHF3g7g==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vU8xv-0003A9-SF; Fri, 12 Dec 2025 20:38:12 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vU8xZ-0030pR-Ho; Fri, 12 Dec 2025 20:37:49 +0100
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
Subject: [PATCH v2 01/16] nfp: Call FIELD_PREP() in NFP_ETH_SET_BIT_CONFIG() wrapper
Date: Fri, 12 Dec 2025 19:37:06 +0000
Message-Id: <20251212193721.740055-2-david.laight.linux@gmail.com>
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

Rather than use a define that should be internal to the implementation
of FIELD_PREP(), pass the shifted 'val' to nfp_eth_set_bit_config()
and change the test for 'value unchanged' to match.

This is a simpler change than the one used to avoid calling both
FIELD_GET() and FIELD_PREP() with non-constant mask values.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

Unchanged for v2.

 .../ethernet/netronome/nfp/nfpcore/nfp_nsp_eth.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp_eth.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp_eth.c
index 5cfddc9a5d87..4a71ff47fbef 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp_eth.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp_eth.c
@@ -509,8 +509,7 @@ int nfp_eth_set_configured(struct nfp_cpp *cpp, unsigned int idx, bool configed)
 
 static int
 nfp_eth_set_bit_config(struct nfp_nsp *nsp, unsigned int raw_idx,
-		       const u64 mask, const unsigned int shift,
-		       u64 val, const u64 ctrl_bit)
+		       const u64 mask, u64 shifted_val, const u64 ctrl_bit)
 {
 	union eth_table_entry *entries = nfp_nsp_config_entries(nsp);
 	unsigned int idx = nfp_nsp_config_idx(nsp);
@@ -527,11 +526,11 @@ nfp_eth_set_bit_config(struct nfp_nsp *nsp, unsigned int raw_idx,
 
 	/* Check if we are already in requested state */
 	reg = le64_to_cpu(entries[idx].raw[raw_idx]);
-	if (val == (reg & mask) >> shift)
+	if (shifted_val == (reg & mask))
 		return 0;
 
 	reg &= ~mask;
-	reg |= (val << shift) & mask;
+	reg |= shifted_val;
 	entries[idx].raw[raw_idx] = cpu_to_le64(reg);
 
 	entries[idx].control |= cpu_to_le64(ctrl_bit);
@@ -571,12 +570,9 @@ int nfp_eth_set_idmode(struct nfp_cpp *cpp, unsigned int idx, bool state)
 	return nfp_eth_config_commit_end(nsp);
 }
 
-#define NFP_ETH_SET_BIT_CONFIG(nsp, raw_idx, mask, val, ctrl_bit)	\
-	({								\
-		__BF_FIELD_CHECK(mask, 0ULL, val, "NFP_ETH_SET_BIT_CONFIG: "); \
-		nfp_eth_set_bit_config(nsp, raw_idx, mask, __bf_shf(mask), \
-				       val, ctrl_bit);			\
-	})
+#define NFP_ETH_SET_BIT_CONFIG(nsp, raw_idx, mask, val, ctrl_bit)	  \
+	nfp_eth_set_bit_config(nsp, raw_idx, mask, FIELD_PREP(mask, val), \
+			       ctrl_bit)
 
 /**
  * __nfp_eth_set_aneg() - set PHY autonegotiation control bit
-- 
2.39.5


