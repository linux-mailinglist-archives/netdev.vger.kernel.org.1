Return-Path: <netdev+bounces-206450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBD2B032E3
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 22:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BD88174FB3
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 20:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD38613B7A3;
	Sun, 13 Jul 2025 20:21:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.blochl.de (mail.blochl.de [151.80.40.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B854A00;
	Sun, 13 Jul 2025 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.40.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752438119; cv=none; b=T3woxUizF93ityFwOn0Horu6L0tUK1oZ4fw9Br0Gghkk0EO/UK3BunixPDXB3KsiOgllWiytE0R8osu481tSEFmfJtfek6W2eXuXf4YGdchpZvK9S/IWVotaHkIk3rGYcLrVSNjVtmPxe54J47QJ/XY5hqsHa78cmVoFWw/iBVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752438119; c=relaxed/simple;
	bh=th18XKX6O+o0xu2681Z5ey8GxGKru0OzWuqimCAWCSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jJiIsRlz7MZ5+2G8bfs7jF39rvtekTJKHP4P6Azh9KJ7NEu7M5IeSD2YpXCszv9y7s4b3DEGMX0hmTTZBg3Fi0diEWs/gFJYdPqdpjMIdwXpdVjVUQNiv4wDOUNal0hXYANdoVy0DddPgyPePSMH4LY3H93KQF5oJIKUBG5710E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blochl.de; spf=pass smtp.mailfrom=blochl.de; arc=none smtp.client-ip=151.80.40.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blochl.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blochl.de
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.blochl.de B84804466439
Authentication-Results: mail.blochl.de; dmarc=none (p=none dis=none) header.from=blochl.de
Authentication-Results: mail.blochl.de; spf=fail smtp.mailfrom=blochl.de
Received: from workknecht.fritz.box (ppp-93-104-0-143.dynamic.mnet-online.de [93.104.0.143])
	by smtp.blochl.de (Postfix) with ESMTPSA id B84804466439;
	Sun, 13 Jul 2025 20:21:45 +0000 (UTC)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.4.2 at 472b552e6fe8
From: =?utf-8?q?Markus_Bl=C3=B6chl?= <markus@blochl.de>
Date: Sun, 13 Jul 2025 22:21:41 +0200
Subject: [PATCH net] net: stmmac: intel: populate entire
 system_counterval_t in get_time_fn() callback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250713-stmmac_crossts-v1-1-31bfe051b5cb@blochl.de>
X-B4-Tracking: v=1; b=H4sIAFQVdGgC/x3MSQqAMAxA0atI1hY6KA5XEZFao2ZhK00RQby7x
 eVb/P8AYyRk6IsHIl7EFHyGKgtwu/UbClqyQUtdy0YZwek4rJtcDMyJhamW1s5t10llIUdnxJX
 ufziAxwTj+37rhsIvZQAAAA==
X-Change-ID: 20250713-stmmac_crossts-34d8ab89901a
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 John Stultz <jstultz@google.com>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 markus.bloechl@ipetronik.com, 
 =?utf-8?q?Markus_Bl=C3=B6chl?= <markus@blochl.de>
X-Mailer: b4 0.14.2
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (smtp.blochl.de [0.0.0.0]); Sun, 13 Jul 2025 20:21:46 +0000 (UTC)

get_time_fn() callback implementations are expected to fill out the
entire system_counterval_t struct as it may be initially uninitialized.

This broke with the removal of convert_art_to_tsc() helper functions
which left use_nsecs uninitialized.

Initially assign the entire struct with default values.

Fixes: f5e1d0db3f02 ("stmmac: intel: Remove convert_art_to_tsc()")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Blöchl <markus@blochl.de>
---
Notes:
    Related-To: <https://lore.kernel.org/lkml/txyrr26hxe3xpq3ebqb5ewkgvhvp7xalotaouwludjtjifnah2@7tmgczln4aoo/>
    Related-To: <https://lore.kernel.org/lkml/20250709-e1000e_crossts-v2-1-2aae94384c59@blochl.de/>
    Only compile tested
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 9a47015254bbe60b806b00b80dbd5b1d8f78a7c6..ea33ae39be6bbca5dc32c73e6d02e86a9d8d6e62 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -433,6 +433,12 @@ static int intel_crosststamp(ktime_t *device,
 		return -ETIMEDOUT;
 	}
 
+	*system = (struct system_counterval_t) {
+		.cycles = 0,
+		.cs_id = CSID_X86_ART,
+		.use_nsecs = false,
+	};
+
 	num_snapshot = (readl(ioaddr + GMAC_TIMESTAMP_STATUS) &
 			GMAC_TIMESTAMP_ATSNS_MASK) >>
 			GMAC_TIMESTAMP_ATSNS_SHIFT;
@@ -448,7 +454,7 @@ static int intel_crosststamp(ktime_t *device,
 	}
 
 	system->cycles *= intel_priv->crossts_adj;
-	system->cs_id = CSID_X86_ART;
+
 	priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 
 	return 0;

---
base-commit: 3cd752194e2ec2573d0e740f4a1edbfcc28257f5
change-id: 20250713-stmmac_crossts-34d8ab89901a

Best regards,
-- 
Markus Blöchl <markus@blochl.de>


