Return-Path: <netdev+bounces-183413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F35A909B7
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1BCF7AC2F8
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34140217677;
	Wed, 16 Apr 2025 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9uj64fa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07536216E01;
	Wed, 16 Apr 2025 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744823700; cv=none; b=QDni6hhLwholwsMQHoxZ8GzLM76jgyLx111sbIniU2tIiIVY+Lqe2KWdu5xXE30NuhwvJzAy23OysFHydAbs/PF3GsltVXxESNrY2XdS4socGJkGKNopzkYlBtlgpdMDOWlV6qtl0fZr4ScG2I67f1zAZ2DcCErahPIww0Bu7qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744823700; c=relaxed/simple;
	bh=rrCB5OTUZE7hdVNRyzzj/bm/DBwSH2wkplB+PM4ecfU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SpkFea2dBc1hwesYsQbBjdc+CAxGWIZZyGGrRWgFWUbBq0FrD+btUxQQV+Tr9mmleGAL7tNT1nFgZ1IZk2fY1jZ46d+dRqJUD83zMXDpFs4A8O1qk7vLob1rOe9MWBMf/nYOT/gLZdGrSBXk2hss2u1occnYjNeI6JBGw8B2IZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9uj64fa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67A76C4CEF3;
	Wed, 16 Apr 2025 17:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744823699;
	bh=rrCB5OTUZE7hdVNRyzzj/bm/DBwSH2wkplB+PM4ecfU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=j9uj64fam4Y9wd2ARffegNxVzhdJxzzDwlDjNoMneB7H5y8PlcdfiGyddsOdbd0gx
	 AKuvPcfkWC6ds26oPTuP6WB5jxuhCYVmrnrKRKm1ed9GfpaHbCEun7G4DxziR+c60X
	 Jq93H7yTrlShxpjbXwHVJOFO6zY9phWiB1Htr3zSqPfpI6Lu/SaY6v6sgMHaXyu1xI
	 RLa9YTGh+18ZeAxtErQE0KUH1wtY6l+7q6aXMZN+cEE538/Nj1SA8FQwNLUasV7e20
	 vEi7IimOjGcGaR+E+txkEUOxwZnjUn4KgEVyR6bsMcg0KwKoUOvnvdcx3S3V1q0ooq
	 02Unu44jBqIjg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D00EC369BA;
	Wed, 16 Apr 2025 17:14:59 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH net-next v3 0/4] net: phy: dp83822: Add support for
 changing the MAC series termination
Date: Wed, 16 Apr 2025 19:14:46 +0200
Message-Id: <20250416-dp83822-mac-impedance-v3-0-028ac426cddb@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIbl/2cC/3XNywqDMBQE0F+RrHtLzKPGrvofpYs8rjVQoyQSL
 OK/N0ihUHA5DHNmJQmjx0Su1UoiZp/8GErgp4rYXocngnclE0aZpJxKcJPiijEYtAU/TOh0sAh
 KUMGlobbFCynbKWLnl929k4AzBFxm8ihN79M8xvd+mOu9/9rNgZ1roGCcU1I3sjVC3l4eTY8xn
 u047GhmP0hQdQSxAnXYodFCt4qKP2jbtg89BHbNEAEAAA==
X-Change-ID: 20250305-dp83822-mac-impedance-840435b0c9e6
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Andrew Davis <afd@ti.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744823698; l=1944;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=rrCB5OTUZE7hdVNRyzzj/bm/DBwSH2wkplB+PM4ecfU=;
 b=PiRAcgqLqN2FBIxZgGgm9aXyDZvYEBE0SzKfRcaEYVP68Q+KngzXZApdwAClkyrzpOiRr+6tI
 ecsWZSK1OK5CNzUvHt1c1C2ZaDajaCH7/Wcz7ezalLnHSxmJmJCQyDQ
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

The dp83822 provides the possibility to set the resistance value of the
the MAC series termination. Modifying the resistance to an appropriate
value can reduce signal reflections and therefore improve signal quality.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
Changes in v3:
- Add maximum to mac-termination-ohms in ethernet-phy.yaml
- Add allowed values for mac-termination-ohms in ti,dp83822.yaml
- Added mac-termination-ohms in sample in ti,dp83822.yaml
- Link to v2: https://lore.kernel.org/r/20250408-dp83822-mac-impedance-v2-0-fefeba4a9804@liebherr.com

Changes in v2:
- Renamed "mac-series-termination-ohms" to "mac-termination-ohms"
- Added description for "mac-termination-ohms"
- Renamed "phy_get_mac_series_termination" to "phy_get_mac_termination"
- Dropped "mac_series_termination_modify" from dp83822_private
- Init mac_termination_index in dp8382x_probe
- Renamed "mac_series_termination" to "mac_termination"
- Link to v1: https://lore.kernel.org/r/20250307-dp83822-mac-impedance-v1-0-bdd85a759b45@liebherr.com

---
Dimitri Fedrau (4):
      dt-bindings: net: ethernet-phy: add property mac-termination-ohms
      dt-bindings: net: dp83822: add constraints for mac-termination-ohms
      net: phy: Add helper for getting MAC termination resistance
      net: phy: dp83822: Add support for changing the MAC termination

 .../devicetree/bindings/net/ethernet-phy.yaml      | 10 +++++++
 .../devicetree/bindings/net/ti,dp83822.yaml        |  4 +++
 drivers/net/phy/dp83822.c                          | 33 ++++++++++++++++++++++
 drivers/net/phy/phy_device.c                       | 15 ++++++++++
 include/linux/phy.h                                |  3 ++
 5 files changed, 65 insertions(+)
---
base-commit: ac1df712442c64b50cfdbe01da0e5aca8319b559
change-id: 20250305-dp83822-mac-impedance-840435b0c9e6

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



