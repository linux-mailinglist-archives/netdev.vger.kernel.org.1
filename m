Return-Path: <netdev+bounces-236785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8C8C4020E
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 14:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255B23A2E96
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 13:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25CE2E6CB2;
	Fri,  7 Nov 2025 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kJ/Heg/R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nR5POVWE"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F582E265A
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522320; cv=none; b=WnUCL2LeiWBofJPoabq9KoAjVizAZ/+3DfqjKDJOD+MXL0UgF7KinvGIoes8lUoUERDPiFUr8OFHzC2U6D+KHSf1UJNfdtiRQ1OBzeCukoIcXJfsr7vavjWcLsfWfTG1/iUskuuD4JQNYHVD/gBJ88a4/7qu/TP8Az6fuCqSRdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522320; c=relaxed/simple;
	bh=foAcTjM6CYHB5ODdYaGawtcLYzlZonOMK1Rd88vPyJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z9eF2f2TlEoaQ7XJzHr95q/b6v8B50d2eAU5r9anvW8NFA+QOs5OESLBKmjv1/j+12DKDxV/wEL7n4zGeZYIH+ApseJuELuQDecwC/uQbHwkSpMR7aAql5a9u67IPLn2g4sZ2C9i6ObHdhvQkt4FjXYlpPvJmz8joaA9Al5d+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kJ/Heg/R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nR5POVWE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762522311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5fO9mmsxHq9O1ddXqChORt2eOtAnsTaAOoJHS0IxQ8Q=;
	b=kJ/Heg/RdoCUieJJ+67f3jn2pAZzKuTXyfEAbEWyu+nGJhO44b5xEHbSzqgzguguMx/cqx
	TVkvGnIacVTLBwnnnUX2HdK/8qNV0X7D7BvMpMj9TYIUqi6AsZYZFarO79ZWeuKQ1Ffe7t
	F9WYvwrUCZOpv2KdKd/yGQ5UYZkdIdcjZyiOz/HRyalrtbArgKSC4qHmkVLr1uxIPcMVNB
	EWR4s4Ay7OgpRKSh01tHG6p9k1SW57xkBgL1QS1SSJCSprpZmJtWDjSzfZPJG2lSKqIzb+
	p9cyjjX1j/B8Zxszr2Frzv1ZHKGDcBzrfMgShEbSSHyO+jMTlQtikS62HATHIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762522311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5fO9mmsxHq9O1ddXqChORt2eOtAnsTaAOoJHS0IxQ8Q=;
	b=nR5POVWEuLP/R5GRY7lD1V+LZdStW/XCGlEFUK6f7wYlWSamZx0AvUZHH3B404QmXju0lA
	ESAncrzPutXTJOAQ==
Date: Fri, 07 Nov 2025 14:31:36 +0100
Subject: [PATCH iwl-next] igc: Restore default Qbv schedule when changing
 channels
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-igc_mqprio_channels-v1-1-42415562d0f8@linutronix.de>
X-B4-Tracking: v=1; b=H4sIALf0DWkC/x2MWwqAIBAArxL7nZBGz6tESI+tFspKowTx7lmfA
 zPjwKAmNFBHDjTeZGhXAXgcwbB0akZGY2AQicg4TwpG8yC389C0y09QuBomUlHxPMeyKnsI5aF
 xIvtfG6BnZQrtBa33L6c6pYtvAAAA
X-Change-ID: 20251107-igc_mqprio_channels-2329166e898b
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1866; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=foAcTjM6CYHB5ODdYaGawtcLYzlZonOMK1Rd88vPyJ8=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBpDfTGEFAhlkg4C741nCPBhUf/BgN+qRbiwHHhg
 iBA69oF05GJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCaQ30xgAKCRDBk9HyqkZz
 gvk+D/9fiRza8YBdwGxKRdGGsINkb/CM0irnSIH1Ddw3z+eLhA10BnFuoVjI8LSFsXprxsxW9p3
 RuEWmRz+BG+GLRTqVsPLOk6O6b5C/UTW9MvYT5kCCYeABPdbS8ql1TXlwS3IvvcNlr9ot7FUiXl
 IbKaL4wObZsHPYvMn1aw6p8+8pXju4k0xdgsTsHt5wFcMvHXNN7r1iZs+6h9nockGVTHK+6wpoZ
 dBVBjpy6dckCBZLXim/xPZcmL+itS717RVHh1yuHPvhTHSiS1NoBaenpWl2sO+JA+a+7YXpDFrT
 16bap9M8XhQLfgcEvvmv+rf+Zsk8JvZGsiL9dzE5M4W8lNWRAEZKrhHMi4yGSIxB8GUQKbMbDxf
 enHrcNVWfNR5fctb7+wEUQ221qBKAzAw7siZEznC/C67zlCvSBoHOimJJX6NpfyCSrDYwATbxHC
 aEB1t064Dkk8VRdOQ0g3ZJJxrqvk0BT09d2b+jNYLwb16hh38Vz583BGTGrkZa2YTXQCgRaRAmr
 9RzWSqTUGuQjUlAfwnGNY0Gpr2oiSgM4HmXsNzAMh8Rc7orSohdUGLQ+/Yoc2OpzQOkJ3qSt74l
 vu9mdh14GIH7kWfmPMGaACbO5ux5wfaBqGhAikPtNwlzElNuWMItpSgusy6Ea12WhKRxEbBoYw+
 crJFix69Egz6pGg==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

The MQPRIO (and ETF) offload utilizes the TSN Tx mode. This mode is always
coupled to Qbv. Therefore, the driver sets a default Qbv schedule of all gates
opened and a cycle time of 1s. This schedule is set during probe.

However, the following sequence of events lead to Tx issues:

 - Boot a dual core system
   probe():
     igc_tsn_clear_schedule():
       -> Default Schedule is set
       Note: At this point the driver has allocated two Tx/Rx queues, because
       there are only two CPU(s).

 - ethtool -L enp3s0 combined 4
   igc_ethtool_set_channels():
     igc_reinit_queues()
       -> Default schedule is gone, per Tx ring start and end time are zero

  - tc qdisc replace dev enp3s0 handle 100 parent root mqprio \
      num_tc 4 map 3 3 2 2 0 1 1 1 3 3 3 3 3 3 3 3 \
      queues 1@0 1@1 1@2 1@3 hw 1
    igc_tsn_offload_apply():
      igc_tsn_enable_offload():
        -> Writes zeros to IGC_STQT(i) and IGC_ENDQT(i) -> Boom

Therefore, restore the default Qbv schedule after changing the amount of
channels.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 728d7ca5338bf27c3ce50a2a497b238c38cfa338..e4200fcb2682ccd5b57abb0d2b8e4eb30df117df 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7761,6 +7761,8 @@ int igc_reinit_queues(struct igc_adapter *adapter)
 	if (netif_running(netdev))
 		err = igc_open(netdev);
 
+	igc_tsn_clear_schedule(adapter);
+
 	return err;
 }
 

---
base-commit: 6fc33710cd6c55397e606eeb544bdf56ee87aae5
change-id: 20251107-igc_mqprio_channels-2329166e898b

Best regards,
-- 
Kurt Kanzenbach <kurt@linutronix.de>


