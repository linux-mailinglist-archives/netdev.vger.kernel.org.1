Return-Path: <netdev+bounces-164604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CAAA2E774
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E04618868A9
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06C119D072;
	Mon, 10 Feb 2025 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UdlG1pTt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TulK/1yR"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385A114A639
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739179181; cv=none; b=k6TiyoQflDwK61CjWTaBaDjaVK9Tkkjwdf4pp0fdDSVSZ3e6+ngrE0thb1vOqFEY/ralqH5QG2KuJiTC8PayTKXphcAMDWlkVzP5smh/4ox3SQ5+UicqjBOgPxbhrvrKBwfNxg+K4VIGi5b/SHyyl+AU4VYhya/qCOZQSpMcnHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739179181; c=relaxed/simple;
	bh=3AIrpIXR0RLR4O6Ma9nszz+1ni74W7Wyb++QRtN/mvQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l+x2yhjbgNmQm1yWNsqY9DpHwF+ibxO+9Ite/I2RKEW3m2hGuV1Dl0GsZ32BQu9tMSr7pAV17Jyu+9HW5CkfXvW3tOgrZmKAcdhcRmqRXemcy8Fj/yWn5nWvQ2fxef0V1JbwW9ShO8FIa8Sz5kzqtYFoValy2JZknf9VAFT9uk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UdlG1pTt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TulK/1yR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739179178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ix2EmGz88Zjmg5yPhCy0AMV3QC7r2VV+0+xpiwxQjRA=;
	b=UdlG1pTtn2aqez4G2wG5H0h3QDC6Xr6KsezXoVzbmBdY/67LnMuOs5ZbNuyAB3ozf5OXgp
	39+FIL8lbul5z3jNEkYPbLIXczDV3reQ5zU7C01Y67IYtCq86MXlqiGYDU2x4IW9ob15S/
	73jzUPcwkqgZP9bPktjvSBuSBW1k7rh3yND04+ld7Le/82/UpkxyjiflIu2cK6ZSK2w6Dp
	P7edAhF6brC+wBTwaeZFod0VVSIh3+swpm+EXqHboEuiM4clmUXzBbRS9N7MRM6507q2+s
	KQaSNqqexBHV1/7NA76HaiDMHwYNB1//mBUn8KTXA5G1oKmBAFm4gUc6BHD0EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739179178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ix2EmGz88Zjmg5yPhCy0AMV3QC7r2VV+0+xpiwxQjRA=;
	b=TulK/1yRQpdco/ARbXTOPCxlSrKl40Syw824xdUEIUopxj27XGCp2F6V7qxrq73Nkl7vXP
	cQxT7Mrhf7BBEwBg==
Subject: [PATCH 0/3] igb: XDP/ZC follow up
Date: Mon, 10 Feb 2025 10:19:34 +0100
Message-Id: <20250210-igb_irq-v1-0-bde078cdb9df@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKbEqWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIwMz3cz0pPjMokLdNNNEkxSTlNQkIwNzJaDqgqLUtMwKsEnRsbW1AIJ
 ScMxZAAAA
X-Change-ID: 20250206-igb_irq-f5a4d4deb207
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Joe Damato <jdamato@fastly.com>, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=942; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=3AIrpIXR0RLR4O6Ma9nszz+1ni74W7Wyb++QRtN/mvQ=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBnqcSogachtm51iVVzqCye+2W0qpWJsii2A7ODu
 Dg2gg7otG6JAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZ6nEqAAKCRDBk9HyqkZz
 gkSBD/9OcRsADRzX8fLdmYn9GRAHSr8KY6SsSpjxeFGtkB+EgUVuZIxGoKgU7qfSm5PI60puyAo
 YOmNk4HdQRBoNzdbUMVyrNOYo1mzeUbDFSSeBR9pNkn7wyWOhbDh2oMK7GbYiwz9bXHxCrYU8zY
 VaLBskEHSvgjwXkM36HGEwyBq8Zy0dNuT1/xdbYGb/f3H9g4b12iqlDYWAplgyHAPMWN0UAGhhJ
 ScBBvmIkrOu+VEQx/Cf9TAW9o1byPeIMh49fflxjHVEg+7rNV9Ewwqqk+uqVJVZB/DL9R0vTjO1
 CPeHQmbqerpxP8H7d5kmOavLBNXdsuVloZjlBPKPOAsC5NhkFrqpO4Nzhj7xgMbpoI0+Kr3qTtu
 4sN7VETWlXQhW83vGABGz953Cmc0aL5ErVcRjL0iYgw7lz8YxZRz6Pgk2DjsVRgjdMEjW+8EOdw
 E3GIHA2o/sUo5PqpolHRa/4opRvjyrlBFVQGMzNRirJgKg8SQ4TE/TjRfEbSqG3D7WK04ctMBtN
 ST7cOvZJzsAlVh5kCiSHXBIgWasJ/pZwyxa45z5VOOLGSJll5gcc1hNSXls9S/PeTOIA7XyJ6kK
 4XopRUhJLVoXZ+5H3ho19kbGMQAxLPOR0+El8Rz6R5CT3RUnk4myV10L10gAYR9So4N+QUcoMrT
 Bb+/9Ec7gtviqYw==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

This is a follow up for the igb XDP/ZC implementation. The first two 
patches link the IRQs and queues to NAPI instances. This is required to 
bring back the XDP/ZC busy polling support. The last patch removes 
undesired IRQs (injected via igb watchdog) while busy polling with 
napi_defer_hard_irqs and gro_flush_timeout set.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
Kurt Kanzenbach (3):
      igb: Link IRQs to NAPI instances
      igb: Link queues to NAPI instances
      igb: Get rid of spurious interrupts

 drivers/net/ethernet/intel/igb/igb.h      |  5 ++-
 drivers/net/ethernet/intel/igb/igb_main.c | 67 ++++++++++++++++++++++++++-----
 drivers/net/ethernet/intel/igb/igb_xsk.c  |  3 ++
 3 files changed, 65 insertions(+), 10 deletions(-)
---
base-commit: acdefab0dcbc3833b5a734ab80d792bb778517a0
change-id: 20250206-igb_irq-f5a4d4deb207

Best regards,
-- 
Kurt Kanzenbach <kurt@linutronix.de>


