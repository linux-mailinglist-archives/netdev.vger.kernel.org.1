Return-Path: <netdev+bounces-211077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1851B16793
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 22:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D2C18C2352
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 20:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAA7202C3E;
	Wed, 30 Jul 2025 20:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cPRVf3nX"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0648156CA;
	Wed, 30 Jul 2025 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753907139; cv=none; b=UU0F9Z0DuO2VKZFu/mARlm13nby7LkuthNZSi1gM9iCdl/pFBsJyEE2wkh2sk0DQiw+7BAYCWw7VKh0/NI5HK29McknIG4HS6P6xSe2kag0fPs7K7jqr9JyhRtuf754Zei8cNwJGUPAOq1egrj97jF5pl1OHet+DloR/r3WJ3tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753907139; c=relaxed/simple;
	bh=u12wcI6di+0QI17z5QIslTni50sbtImCXQArA8krxAg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QBMSRYPF4NuFScZqWtDgPheBGyzak+hfYENoC79R8hM5zgDkY+JtW4RpsCmvwmwC2MujMBAjIpfm4XQGFtN0D1D822tXqMhmOioAHikTkXgxxn5lA2iwbQbLI2xSqnLm0RtXIgqCORSwbrmpZwEGsGjFP5ZNWA94d7D6dpPnD+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cPRVf3nX; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 9EA54C0000F8;
	Wed, 30 Jul 2025 13:25:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 9EA54C0000F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1753907136;
	bh=u12wcI6di+0QI17z5QIslTni50sbtImCXQArA8krxAg=;
	h=From:To:Cc:Subject:Date:From;
	b=cPRVf3nXtVoUA42ddkED9sFYrxfTRFIjh/UJ5sXz1So3sABmLpgKpx1yvERSrAfJV
	 tDZJmqw7jcYT/EQyFt2Ildm7sKmhNsR+6vz6ALZjv1YJqvmONDz1qMIN9gA51Lz1Zi
	 jmbJqztRyjmPUzfg76c5DpCzpvAOLFRZZx9jtNLc=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 88D024002F44;
	Wed, 30 Jul 2025 16:25:35 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] net: mdio: mdio-bcm-unimac: Correct rate fallback logic
Date: Wed, 30 Jul 2025 13:25:33 -0700
Message-Id: <20250730202533.3463529-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the parent clock is a gated clock which has multiple parents, the
clock provider (clk-scmi typically) might return a rate of 0 since there
is not one of those particular parent clocks that should be chosen for
returning a rate. Prior to ee975351cf0c ("net: mdio: mdio-bcm-unimac:
Manage clock around I/O accesses"), we would not always be passing a
clock reference depending upon how mdio-bcm-unimac was instantiated. In
that case, we would take the fallback path where the rate is hard coded
to 250MHz.

Make sure that we still fallback to using a fixed rate for the divider
calculation, otherwise we simply ignore the desired MDIO bus clock
frequency which can prevent us from interfacing with Ethernet PHYs
properly.

Fixes: ee975351cf0c ("net: mdio: mdio-bcm-unimac: Manage clock around I/O accesses")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
Changes in v2:

- provide additional details as to how a parent clock can have a rate of
  0 (Andrew)

- incorporate Simon's feedback that an optional clock is NULL and
  therefore returns a rate of 0 as well

 drivers/net/mdio/mdio-bcm-unimac.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-bcm-unimac.c b/drivers/net/mdio/mdio-bcm-unimac.c
index b6e30bdf5325..7baab230008a 100644
--- a/drivers/net/mdio/mdio-bcm-unimac.c
+++ b/drivers/net/mdio/mdio-bcm-unimac.c
@@ -209,10 +209,9 @@ static int unimac_mdio_clk_set(struct unimac_mdio_priv *priv)
 	if (ret)
 		return ret;
 
-	if (!priv->clk)
+	rate = clk_get_rate(priv->clk);
+	if (!rate)
 		rate = 250000000;
-	else
-		rate = clk_get_rate(priv->clk);
 
 	div = (rate / (2 * priv->clk_freq)) - 1;
 	if (div & ~MDIO_CLK_DIV_MASK) {
-- 
2.34.1


