Return-Path: <netdev+bounces-205504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77971AFEFDB
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 19:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74824488564
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD272264AA;
	Wed,  9 Jul 2025 17:28:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.blochl.de (mail.blochl.de [151.80.40.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C2621171D;
	Wed,  9 Jul 2025 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.40.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752082127; cv=none; b=HfUvwoOHHlWKQkSREcp70nPIZd6q/wBh1xhdjMyU5/ygP2ETV3qEd1xXXZLq0mFy3LTX6OQPX4QzdqkxaEegLwAecKnU/ybYQTSPgpYs+57aIK0I0Ped64wn9o/9pfUH3A0QAgoIGXB1jKVV5sEsLyO00AtWpyKFA2KpvskpT+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752082127; c=relaxed/simple;
	bh=GbbM/FhvQTBzWvNQNRBKpegqobekpqTyrcqSYpz/s38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UeeKtWU8A4a62yxU1j1MKoduE1wycgVJqlgiylahloUBKgmtv6ivmQFynYmZINRdmB/pcVp9qpSSlH0GW5XCEXg9UYYEH4xHdBGm9DDF33KwmD8uhFHAHadRfBn1wm1uOhCsWNzg5rGeJIpUgAIwbLjbHKYNnSHa1Gf2yjoxrdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blochl.de; spf=pass smtp.mailfrom=blochl.de; arc=none smtp.client-ip=151.80.40.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blochl.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blochl.de
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.blochl.de A45374466472
Authentication-Results: mail.blochl.de; dmarc=none (p=none dis=none) header.from=blochl.de
Authentication-Results: mail.blochl.de; spf=fail smtp.mailfrom=blochl.de
Received: from workknecht.fritz.box (ppp-93-104-0-143.dynamic.mnet-online.de [93.104.0.143])
	by smtp.blochl.de (Postfix) with ESMTPSA id A45374466472;
	Wed, 09 Jul 2025 17:28:37 +0000 (UTC)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.4.2 at 472b552e6fe8
From: =?utf-8?q?Markus_Bl=C3=B6chl?= <markus@blochl.de>
Date: Wed, 09 Jul 2025 19:28:07 +0200
Subject: [PATCH v2] e1000e: Populate entire system_counterval_t in
 get_time_fn() callback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250709-e1000e_crossts-v2-1-2aae94384c59@blochl.de>
X-B4-Tracking: v=1; b=H4sIAKambmgC/3XMQQrCMBCF4auUWRuZhLZJXXkPKRLTiQ2URjIlK
 CV3N3bv8n/wvh2YUiCGS7NDohw4xLWGOjXgZrs+SYSpNihUHWocBElEpLtLkXljoXXb9br1vVE
 W6umVyIf3Ad7G2nPgLabP4Wf5W/9SWQopvLEGnR4Utf76WKKbl/NEMJZSvthCBrSsAAAA
X-Change-ID: 20250709-e1000e_crossts-7745674f682a
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 markus.bloechl@ipetronik.com, John Stultz <jstultz@google.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Markus_Bl=C3=B6chl?= <markus@blochl.de>
X-Mailer: b4 0.14.2
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (smtp.blochl.de [0.0.0.0]); Wed, 09 Jul 2025 17:28:38 +0000 (UTC)

get_time_fn() callback implementations are expected to fill out the
entire system_counterval_t struct as it may be initially uninitialized.

This broke with the removal of convert_art_to_tsc() helper functions
which left use_nsecs uninitialized.

Assign the entire struct again.

Fixes: bd48b50be50a ("e1000e: Replace convert_art_to_tsc()")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Blöchl <markus@blochl.de>
---
Notes:
    Related-To: <https://lore.kernel.org/lkml/txyrr26hxe3xpq3ebqb5ewkgvhvp7xalotaouwludjtjifnah2@7tmgczln4aoo/>

Changes in v2:
- Add Lakshmi in Cc:
- Add Signed-off-by: trailer which was lost in b4 workflow
- Link to v1: https://lore.kernel.org/r/20250709-e1000e_crossts-v1-1-f8a80c792e4f@blochl.de
---
 drivers/net/ethernet/intel/e1000e/ptp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ptp.c b/drivers/net/ethernet/intel/e1000e/ptp.c
index ea3c3eb2ef2020d513d49c1368679f27d17edb04..f01506504ee3a11822930115e9ed07661d81532c 100644
--- a/drivers/net/ethernet/intel/e1000e/ptp.c
+++ b/drivers/net/ethernet/intel/e1000e/ptp.c
@@ -124,8 +124,11 @@ static int e1000e_phc_get_syncdevicetime(ktime_t *device,
 	sys_cycles = er32(PLTSTMPH);
 	sys_cycles <<= 32;
 	sys_cycles |= er32(PLTSTMPL);
-	system->cycles = sys_cycles;
-	system->cs_id = CSID_X86_ART;
+	*system = (struct system_counterval_t) {
+		.cycles = sys_cycles,
+		.cs_id = CSID_X86_ART,
+		.use_nsecs = false,
+	};
 
 	return 0;
 }

---
base-commit: 733923397fd95405a48f165c9b1fbc8c4b0a4681
change-id: 20250709-e1000e_crossts-7745674f682a

Best regards,
-- 
Markus Blöchl <markus@blochl.de>


