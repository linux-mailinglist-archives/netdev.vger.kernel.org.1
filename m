Return-Path: <netdev+bounces-243267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F0BC9C652
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 18:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9FDF5342FFC
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 17:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3D32C21C6;
	Tue,  2 Dec 2025 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rzSt+A/n"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496F02C0F78
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764696548; cv=none; b=SRnv0ruA9TH7x57oetGXbmmN8DB/Z29SdIsoFqscfa/ou2/1y6RDOrA5pLtGmpC9KnntLaJKEvn1U+gRZ8yRLgE/oEqsI2gkdczLkBpjsUOfkCtt3T1Lr8vjmm1d2TJjmwAiZ8oQtL2PvGjGDD8ahUDD/Ml0YUBkt1h4heaVRf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764696548; c=relaxed/simple;
	bh=bbyXr8Rsfc1UFlXiWJBghoTTRdZXqJHgATkSXcF1OKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JE3C8y7DGyglFmTSHUKM+msM+w7/6fhQUJybd+s7bFyQs4hU98/lFziW8OdW7CoJrtet/uAEAzaXtw0E//QDx4w5ef8eIDqCigqa165dTHuRFDgjQy/BAGD7iA5YRF1xgZXxSAOBsZ7BWCgC5kvYjKnp+eTNbbx/81JjO/BUcBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rzSt+A/n; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764696530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mXbJh4w+pouSRV49yhKkyT8jZ3EhfqR8F6nsdHsJ00Y=;
	b=rzSt+A/n2n/+AjP46vDOkkmHHALSfqeRG9IehgD7Cys7nHIW99RvlnXTndA27Jbi5WYp9Z
	deE0u43bXMt0Tl1udxFofkZ+FgVHLpGbtWeOILRU/mu4rbh9V8wXtWK4JqnTTK/xlmK6Mp
	cFdBLWBPsTQxBnP+Hj9dx64lk2+CpcQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: phy: marvell-88q2xxx: Fix clamped value in mv88q2xxx_hwmon_write
Date: Tue,  2 Dec 2025 18:27:44 +0100
Message-ID: <20251202172743.453055-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The local variable 'val' was never clamped to -75000 or 180000 because
the return value of clamp_val() was not used. Fix this by assigning the
clamped value back to 'val', and use clamp() instead of clamp_val().

Cc: stable@vger.kernel.org
Fixes: a557a92e6881 ("net: phy: marvell-88q2xxx: add support for temperature sensor")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/net/phy/marvell-88q2xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index f3d83b04c953..201dee1a1698 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -698,7 +698,7 @@ static int mv88q2xxx_hwmon_write(struct device *dev,
 
 	switch (attr) {
 	case hwmon_temp_max:
-		clamp_val(val, -75000, 180000);
+		val = clamp(val, -75000, 180000);
 		val = (val / 1000) + 75;
 		val = FIELD_PREP(MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_MASK,
 				 val);
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


