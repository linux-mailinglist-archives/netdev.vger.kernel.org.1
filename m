Return-Path: <netdev+bounces-244087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F8FCAF8A6
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 11:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5947A3088B9D
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 10:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED2B303CA0;
	Tue,  9 Dec 2025 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="ahMmWdVl"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520302FD699
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765274616; cv=none; b=dzPkVbKh5uEAilJqihI3RsbX/mn2zXdez72e1D4ztH5Fu5acaPWhx0uhyOOTYD0NqEETh1qc+TMTwEOh4YTupaGeC4i5/5BF2izEN6z1F9A3Y2sIvEdVQCVFnJHPphAVfeG+SnG1nknauESyWdhH7br4WW7hd3WVFvqzgULQ85A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765274616; c=relaxed/simple;
	bh=rP9m/rvG+prYCOhaV5Vk15KN9R/2YCE3Pl0ckBAm7Jc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p2ipZV+stm6EMWCykMqjSNUh3OSICvphKte3/LAV0hUQMXTQNCLJcTC4WGe1xi7Yo5J/+EA2jUOBNG+WFipsMtjJnyzj1vonv6+ZZjDAnqRmXX2UmHCbQ6UPCRvIaJXkookPomrkKZbFhJfqXrOtSCOD7LuuOUsCHV6SD7L1Kfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=ahMmWdVl; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vSuZ7-00GyzV-CU; Tue, 09 Dec 2025 11:03:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=H2G28ggF6h59sr0IjReK2Fd4VYXjVxOwedV//eDOpk8=; b=ahMmWdVl8RLYzOF1MAadDGXmPt
	xiAVULaxy0b6WCEXncURcdHsvKgFllppN/7/PM0lipbp4T2aA7v7gtR4LOoqUlttXAXB/RkDo1Rs1
	Glnti1EHMlGAQPmqgXtw+IMiS+npBsYIaLHTPt4OUY+bQE1ejrTMNBuLIxiDKQRyvAGidwWLTZCR+
	yLQL3mPS9BvwWk4AhlbSTuKRKrtUI64a+XU6ghMHUbs6ilqpagwCy1S87ccKg+wlPy0KMBRU8SlRP
	ApkuNVAlW7JhmxkF7ycp0z6eWMMHaRTWatx70ihKcL/1/gpgPsldlmkzQiB5UNpoq97WCu1tcJWiD
	VSp2Wffg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vSuZ6-0000Dx-LZ; Tue, 09 Dec 2025 11:03:28 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vSuZ1-00CND9-CB; Tue, 09 Dec 2025 11:03:23 +0100
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
Subject: [PATCH 1/9] nfp: Call FIELD_PREP() in NFP_ETH_SET_BIT_CONFIG() wrapper
Date: Tue,  9 Dec 2025 10:03:05 +0000
Message-Id: <20251209100313.2867-2-david.laight.linux@gmail.com>
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

Rather than use a define that should be internal to the implementation
of FIELD_PREP(), pass the shifted 'val' to nfp_eth_set_bit_config()
and change the test for 'value unchanged' to match.

This is a simpler change than the one used to avoid calling both
FIELD_GET() and FIELD_PREP() with non-constant mask values.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
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


