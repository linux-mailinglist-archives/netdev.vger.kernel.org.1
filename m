Return-Path: <netdev+bounces-154449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8789FDFEF
	for <lists+netdev@lfdr.de>; Sun, 29 Dec 2024 17:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1317B1882587
	for <lists+netdev@lfdr.de>; Sun, 29 Dec 2024 16:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4B316F288;
	Sun, 29 Dec 2024 16:47:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps-ovh.mhejs.net (vps-ovh.mhejs.net [145.239.82.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4FDEEDE;
	Sun, 29 Dec 2024 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.82.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735490836; cv=none; b=uKX0MW3UeMo9pPiPouvfSrcmMD1hmPixRVF7v198YC4TQi6pO2PaSA7rT8+1BJoOTsnCWelzsNOlo22Q/Bjf4MrTLweUnm7OyLtBlNsasPWieFgeSmarNQqSO2JEn+8gpybwyuPnhmYG//GgAGrID2r9WDZF2YBq3OFd5lc7Uis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735490836; c=relaxed/simple;
	bh=ORFAZjjvwqS1zhpBWWulyEKLzVsdbsch1hq5qm3rHAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u7bbS7VJoexuvtnFGW3oz7vo3xAyeXjE7OGKkxYxWpB7QlyAE9a9ahBVN9FAAUFoEQ7KupByR+VGK8fptjpe+2Aeuy+YNJ17PtNM0m4f3yriygNiIVOBtNKavHk1Znm7V4tPG6qgtmoE1F/fW+rJML3L3DC75cKyY2I3rP2Hx+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name; spf=pass smtp.mailfrom=vps-ovh.mhejs.net; arc=none smtp.client-ip=145.239.82.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vps-ovh.mhejs.net
Received: from MUA
	by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <mhej@vps-ovh.mhejs.net>)
	id 1tRwRW-00000004nnT-2Rim;
	Sun, 29 Dec 2024 17:47:06 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: M Chetan Kumar <m.chetan.kumar@intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] net: wwan: iosm: Properly check for valid exec stage in ipc_mmio_init()
Date: Sun, 29 Dec 2024 17:46:58 +0100
Message-ID: <8b19125a825f9dcdd81c667c1e5c48ba28d505a6.1735490770.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: mhej@vps-ovh.mhejs.net

ipc_mmio_init() used the post-decrement operator in its loop continuing
condition of "retries" counter being "> 0", which meant that when this
condition caused loop exit "retries" counter reached -1.

But the later valid exec stage failure check only tests for "retries"
counter being exactly zero, so it didn't trigger in this case (but
would wrongly trigger if the code reaches a valid exec stage in the
very last loop iteration).

Fix this by using the pre-decrement operator instead, so the loop counter
is exactly zero on valid exec stage failure.

Fixes: dc0514f5d828 ("net: iosm: mmio scratchpad")
Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 drivers/net/wwan/iosm/iosm_ipc_mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_mmio.c b/drivers/net/wwan/iosm/iosm_ipc_mmio.c
index 63eb08c43c05..6764c13530b9 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_mmio.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_mmio.c
@@ -104,7 +104,7 @@ struct iosm_mmio *ipc_mmio_init(void __iomem *mmio, struct device *dev)
 			break;
 
 		msleep(20);
-	} while (retries-- > 0);
+	} while (--retries > 0);
 
 	if (!retries) {
 		dev_err(ipc_mmio->dev, "invalid exec stage %X", stage);

