Return-Path: <netdev+bounces-162521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 652FDA272E0
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9822F1886B88
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4492163A3;
	Tue,  4 Feb 2025 13:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMh2ia3U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAE820FA8E;
	Tue,  4 Feb 2025 13:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738674569; cv=none; b=YeJYiMtfEimJnsD7WlNiOPR6c8vsulJWZ7VHKf1nZkXn2Mk3a+lzuyYKcJlTWEDjwcE318mBCLF0vKI5IeFZGUKffQ2Q1j/v+8RK3AXulx0qMZ365wp0WDoZDkzYW6ndyNrNxb/gDOga57q/hSQGIWtYapCD11qgVss2EOUtyQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738674569; c=relaxed/simple;
	bh=6gsVmK4T4cIRFpGtGiT/93doyPMbX0pCR2n5z0J7Hx8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LoEnBj4uQ2JUB0YPeyHIS0jOeqIPWWU+5V+6Hsw7pVza0dcc0YTTETgDam+gU7mFSdYcfrHUA17aCkeZPJy6s5l7Z8dh/LgbokaRVOisLxFfPJSN7mYfsqfubeENvd3pTML646eUHtdV/aB/dC7DLewrCb3a3fntY+Um2ks22DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMh2ia3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3826CC4CEE4;
	Tue,  4 Feb 2025 13:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738674569;
	bh=6gsVmK4T4cIRFpGtGiT/93doyPMbX0pCR2n5z0J7Hx8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=kMh2ia3UU81zb3Cnmn1qv3qvkuVPA7Zmhqi3aTMSwKKySRqbXbw2DDZsma+1+5fIZ
	 q5J0hknJaK4i6pveX4DNljXcHHPWyrlCr/10MTKXOUKQ7IPZxKumQnUtPL7NN1+slg
	 uAGgHM4XICMToOZpYaWRbHvnXU0J0aqtHcqnHVca+O/cys8fZbtCzk+b1tQ0oXb1wO
	 77BFZEb+FIwHmLco93op8aIxxM1lmwvjfzgUxOohRIOuKSEV1Pp9qHsTjlhvZMhUrX
	 IrEo1ZfOp0GvBrojP38oENDUINkioW8rfBrQefU2fWIQOFOYcw4WYHCwPD24f6nujq
	 sRQW/atTXrHFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E982C02194;
	Tue,  4 Feb 2025 13:09:29 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH net-next v3 0/3] net: phy: dp83822: Add support for
 changing the transmit amplitude voltage
Date: Tue, 04 Feb 2025 14:09:14 +0100
Message-Id: <20250204-dp83822-tx-swing-v3-0-9798e96500d9@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHoRomcC/23NzQrDIBAE4FcJnmtZNzE/PfU9Sg+JbhOhNUHFp
 oS8e8VTKTkOw3yzMU/OkGeXYmOOovFmtimUp4KpqbcjcaNTZghYCRQl10tbtog8rNy/jR25HPp
 aCeoGqCVLs8XRw6yZvDFLgVtaA7unZjI+zO6Tv6LIfWIliCM2Cg68IS37TrcAAq5PQ8NEzp3V/
 MpexB8D4cDAZECjuk6rCmts/ox93794UIfCAQEAAA==
X-Change-ID: 20241213-dp83822-tx-swing-5ba6c1e9b065
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738674559; l=1426;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=6gsVmK4T4cIRFpGtGiT/93doyPMbX0pCR2n5z0J7Hx8=;
 b=0kJ29CA2L590d0YONKMhzfT0n2FN1Z2wr1mVYGZ1i2P6OgvaTo54FWZLXiYLbetGJ8HzJdhJo
 wz++O1H95JfDSHCdj56IvMiOrG+C4FX6kUjX+jgZjA4643DOfQ79Zsw
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

Add support for changing the transmit amplitude voltage in 100BASE-TX mode.
Add support for configuration via DT.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
Changes in v3:
- Switch to tx-amplitude-100base-tx-percent in bindings
- Link to v2: https://lore.kernel.org/r/20250120-dp83822-tx-swing-v2-0-07c99dc42627@liebherr.com

Changes in v2:
- Remove binding ti,tx-amplitude-100base-tx-millivolt from ti,dp83822.yaml
- Add binding tx-amplitude-100base-tx-gain-milli to ethernet-phy.yaml
- Add helper to get tx amplitude gain from DT
- Link to v1: https://lore.kernel.org/r/20250113-dp83822-tx-swing-v1-0-7ed5a9d80010@liebherr.com

---
Dimitri Fedrau (3):
      dt-bindings: net: ethernet-phy: add property tx-amplitude-100base-tx-percent
      net: phy: Add helper for getting tx amplitude gain
      net: phy: dp83822: Add support for changing the transmit amplitude voltage

 .../devicetree/bindings/net/ethernet-phy.yaml      |  7 ++++
 drivers/net/phy/dp83822.c                          | 37 ++++++++++++++++++++++
 drivers/net/phy/phy_device.c                       | 20 +++++++++---
 include/linux/phy.h                                |  3 ++
 4 files changed, 63 insertions(+), 4 deletions(-)
---
base-commit: c2933b2befe25309f4c5cfbea0ca80909735fd76
change-id: 20241213-dp83822-tx-swing-5ba6c1e9b065

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



