Return-Path: <netdev+bounces-165085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5E9A305CF
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 09:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EA33A33C9
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 08:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ECF1EF0A3;
	Tue, 11 Feb 2025 08:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOgTNHdG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D35192B86;
	Tue, 11 Feb 2025 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739262835; cv=none; b=MOxloxCOsr5O/iu7mka84h9ykml5BcRNVfUBtcFCzGXuGh3YmmRXLtmB07HWlNKkPNeBQuFQw0UdUqrRhVwIhaGrpNck3AceACYxgLXwMcd7ILxBN41ylnExfqDApkNsDqPLO834DWVqZlViK0aR/GCcT6BCQ/vTZQDSjpxolT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739262835; c=relaxed/simple;
	bh=NX6m3Adayc0vNqxUwfaOwMkKFBcSZx8C8KPimyfNAR8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O30V6R5Zl/1/DBhcMS96BOs61nsksmD9WqaFh5leHPrX+ZK7nG2YDoeZHEHJ1z+Uh4nTn1jM22VOPvauyOccbC+gaxc7u+gQdJAL4djvMG0GwYM4j8bOQo3AQ7a60nXkR335RuJtzq8b6JykXITacY1+/F17Wtvm2K0DOdWP1vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOgTNHdG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C379CC4CEE4;
	Tue, 11 Feb 2025 08:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739262834;
	bh=NX6m3Adayc0vNqxUwfaOwMkKFBcSZx8C8KPimyfNAR8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=uOgTNHdG/tKy3sLMKLt+RJlI8dtuz4uFQG6+TDzUJj24vYaXR5Y7AkW2kAhYX/UbZ
	 elkbdHSsnSjCVxazsby8e/BYhxEOSXZOepy4a5d99Lm7URCtV/OUS0yvuiAu/n06r+
	 b+4YcQqdM6QjRyapPY5dYvb/7UtsgA6GQlSuqVL8BNqufUp7MgV8oUpJ0dAtuB5VOr
	 KuWM04krhLK0pvL0PwoFCWAfBI4I2ENqOPFvHyF0BIPtbO1CoDBmRQ9bphmHROnWSz
	 9tHUyRD9HzLj8b4DPBR5m7r/oV/gPxdZ+wJ+D2TeiSPF+W4+KWuNHoge/KLq1hVGD7
	 J7y3j6Y5g3JjQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E757C0219D;
	Tue, 11 Feb 2025 08:33:54 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH net-next v4 0/3] net: phy: dp83822: Add support for
 changing the transmit amplitude voltage
Date: Tue, 11 Feb 2025 09:33:46 +0100
Message-Id: <20250211-dp83822-tx-swing-v4-0-1e8ebd71ad54@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGoLq2cC/23NQQ6CMBQE0KuYrq35/aVAXXkP4wLaLzTRQlqCG
 MLdbbrRGJaTybxZWaTgKLLzYWWBZhfd4FMojgdm+sZ3xJ1NmSFgIVBIbsda1oh8Wnh8Od9x1Ta
 lEaRbKBVLszHQ3S2ZvDJPE/e0TOyWmt7FaQjv/DWL3CdWgdhjZ8GBV2RVo20NIODycNT2FMLJD
 M/szfhjIOwYmAyojNbWFFhitWPIr4FQ7BgyGbrSNelSAVj9Z2zb9gH4b5SzRQEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739262831; l=1880;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=NX6m3Adayc0vNqxUwfaOwMkKFBcSZx8C8KPimyfNAR8=;
 b=YhgSfLb+zmjwX3GngGcIPF4m91Jxb0cBPhjrgeoaKlLWSN6oMMnbo/y0v7T3CE8Z2dHVNdrmk
 u2jJx+DyLU3BsN9ZKWoayIgUABWGJUo2070thrqmcYcaYiNdMpAMEAg
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
Changes in v4:
- Remove type $ref from binding
- Remove '|' from description in binding
- Change helper function from:
    static int phy_get_int_delay_property(struct device *dev, const char *name)
  to:
    static int phy_get_u32_property(struct device *dev, const char *name, u32 *val)
- Apply helper function to phy_get_internal_delay
- Link to v3: https://lore.kernel.org/r/20250204-dp83822-tx-swing-v3-0-9798e96500d9@liebherr.com

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

 .../devicetree/bindings/net/ethernet-phy.yaml      |  6 +++
 drivers/net/phy/dp83822.c                          | 38 +++++++++++++++++++
 drivers/net/phy/phy_device.c                       | 44 +++++++++++++---------
 include/linux/phy.h                                |  4 ++
 4 files changed, 74 insertions(+), 18 deletions(-)
---
base-commit: c2933b2befe25309f4c5cfbea0ca80909735fd76
change-id: 20241213-dp83822-tx-swing-5ba6c1e9b065

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



