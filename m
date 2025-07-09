Return-Path: <netdev+bounces-205454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155D3AFEC5D
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 16:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B815619CE
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 14:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5419C2E764D;
	Wed,  9 Jul 2025 14:40:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.blochl.de (mail.blochl.de [151.80.40.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139FE2E3B1E;
	Wed,  9 Jul 2025 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.40.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072033; cv=none; b=YGlDSsKhCit65IK92INqWshTF+umrl6LC9NefT2TUPms3ylfEgv8XdOYYvWy4i9yADcHX8sTvrOTTV3l23iJi9h1aJTU0thDEXopyJzAL298hf6Ncjf2vqqcZj+/TfWnWwVTSpl05n9NhDEErvcW5+z2aas/R+X4en9L24TPMrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072033; c=relaxed/simple;
	bh=SSQ6OOrCgKe5nsjTjjkPzJ85GYNygGyEU7YQde9k2fg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I2nSTpKyF5HCzVHMeiuWb1ZgyTkXN9XmENIwy0a0xs8D66sW1s4n9eLKyb5mPp2Z6lDjrRj2vnvmHPLnOUWlwxu6tYhiz01wiFmfx3uelcnOhAxJ3E5OiqSQxtsli3juIHI2XkKJwoRJswvzJxbbf/ZyjtiQK96YHKSycMjBTEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blochl.de; spf=pass smtp.mailfrom=blochl.de; arc=none smtp.client-ip=151.80.40.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blochl.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blochl.de
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.blochl.de E74C64466472
Authentication-Results: mail.blochl.de; dmarc=none (p=none dis=none) header.from=blochl.de
Authentication-Results: mail.blochl.de; spf=fail smtp.mailfrom=blochl.de
Received: from workknecht.fritz.box (ppp-93-104-0-143.dynamic.mnet-online.de [93.104.0.143])
	by smtp.blochl.de (Postfix) with ESMTPSA id E74C64466472;
	Wed, 09 Jul 2025 14:34:24 +0000 (UTC)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.4.2 at 472b552e6fe8
From: =?utf-8?q?Markus_Bl=C3=B6chl?= <markus@blochl.de>
Date: Wed, 09 Jul 2025 16:34:19 +0200
Subject: [PATCH] e1000e: Populate entire system_counterval_t in
 get_time_fn() callback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250709-e1000e_crossts-v1-1-f8a80c792e4f@blochl.de>
X-B4-Tracking: v=1; b=H4sIAOp9bmgC/x3MQQqAIBBA0avIrBMm0ayuEhFSU82mwokIxLsnL
 d/i/wRCkUmgVwkiPSx8HgV1pWDew7GR5qUYDBqHHjtNNSLSNMdT5BbtvXWNt2vTmgAluiKt/P7
 DYcz5A02qk+JgAAAA
X-Change-ID: 20250709-e1000e_crossts-7745674f682a
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 markus.bloechl@ipetronik.com, John Stultz <jstultz@google.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (smtp.blochl.de [0.0.0.0]); Wed, 09 Jul 2025 14:34:25 +0000 (UTC)

get_time_fn() callback implementations are expected to fill out the
entire system_counterval_t struct as it may be initially uninitialized.

This broke with the removal of convert_art_to_tsc() helper functions
which left use_nsecs uninitialized.

Assign the entire struct again.

Fixes: bd48b50be50a ("e1000e: Replace convert_art_to_tsc()")
Cc: stable@vger.kernel.org
---
Notes:

Related-To: <https://lore.kernel.org/lkml/txyrr26hxe3xpq3ebqb5ewkgvhvp7xalotaouwludjtjifnah2@7tmgczln4aoo/>
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


