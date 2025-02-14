Return-Path: <netdev+bounces-166440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 118FAA35FED
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731973AAC68
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1DD26618A;
	Fri, 14 Feb 2025 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WilpZguW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFC4265CBA;
	Fri, 14 Feb 2025 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739542466; cv=none; b=M2NO73RCel0AvVb39AsVTDR3rAK2pLzSvonHn0Coq98JSyTyfyx7UDG7fiDf9WHGUreIsUVRU8In7t87jp94+46kVMxi8vliRGr23qr5qKB4BfMdBQeH0EPn1yHdvAwggDhc5WMPVTUHeMUWtIXmEbE3zuXUEkqo5spWk2ldzqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739542466; c=relaxed/simple;
	bh=mKExfhVU1mGueFObQGf6TrT/sXrlbwhC802VWY3/t6I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qEh6gFM7uiyAi81XSwrZ2qaCHXmQeP25LctzQhNQF4W+E/voR1vbxA8JMKhlHV+qfg+Aq8O4PqlPt3RIEh/9eeiIN+225HJClblj24mwfHcR+qNBUei+sADH56mGEkhGDtWkFH+SKVP3jckO9bclVNTDuf8HTcN/UcTlQGifjrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WilpZguW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46D5AC4CED1;
	Fri, 14 Feb 2025 14:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739542466;
	bh=mKExfhVU1mGueFObQGf6TrT/sXrlbwhC802VWY3/t6I=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=WilpZguWESeKYgo1V11N4k8Pbk024J4qZlV43SMzRtHKCPRpVeDH94w7GP3N9dAib
	 ItIQHDE+akKhxcGB2V2h4vrmKUBAH051BgiqLxPpCjaD2feSrBvaz4BcevU7OKBh/X
	 I+ljZyKk8WVMda0HtjYp5cQfzgxqcxJn6rnMFYtdeBvKeHU/p1jI0kgXOvkqnZdjdp
	 cVYUcN7vHsdbxsilgU+aQIOz5kCvHrs1IKybYsso3qPtLYMyW/UyxXdz2/6PigPAdQ
	 zv9pQOfqnldyd2QS99YFqmrAcwVSIlZelEBjRPu/nEfOCmR34lCr3LvnYF+occs2bS
	 S29HCRsQsD/pA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316E2C02198;
	Fri, 14 Feb 2025 14:14:26 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH net-next v5 0/3] net: phy: dp83822: Add support for
 changing the transmit amplitude voltage
Date: Fri, 14 Feb 2025 15:14:08 +0100
Message-Id: <20250214-dp83822-tx-swing-v5-0-02ca72620599@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALBPr2cC/23NwW7DIBAE0F+JOIdqdw0Gcsp/VD3YsI2RGhyB5
 bqK/O9FvjSqOI5G8+YpCufIRVxOT5F5jSXOqQZ9Pgk/DenGMoaaBQEpJOxkeNjOEsllk+U7ppv
 U49B7ZDdCr0WdPTJ/xu0g30XiRSbeFvFRmymWZc4/x9eKR19ZDdhiV5QgDQc9uGABEK5fkceJc
 37z8/3wVnoxCBoGVQOMdy54RT2ZhtH9GQSqYXTVcMZZdr0GCK5hqBcDsWGoaiBbHoPBIWj1z9j
 3/RdtI8CKiQEAAA==
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
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739542465; l=2248;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=mKExfhVU1mGueFObQGf6TrT/sXrlbwhC802VWY3/t6I=;
 b=RNdzwZ9/nf1p22uBC/NIXeObi2rcn6NMKekvnCJosWzod7J2BRJGVHOmrPnX4CgqVnI1J7SiD
 qFLVEzBtyNtAGRDWAcX0lxlW2p0sK9iiMqUYP+1aOOve2i4nOVhciIX
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
Changes in v5:
- Remove default from binding
- Fix description in binding by defining what 100% gain means
- Switch to reverse christmas tree in phy_get_internal_delay
- Add kernel doc for phy_get_tx_amplitude_gain
- EXPORT_SYMBOL_GPL for phy_get_tx_amplitude_gain
- Link to v4: https://lore.kernel.org/r/20250211-dp83822-tx-swing-v4-0-1e8ebd71ad54@liebherr.com

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
 drivers/net/phy/dp83822.c                          | 38 ++++++++++++++++
 drivers/net/phy/phy_device.c                       | 53 ++++++++++++++--------
 include/linux/phy.h                                |  4 ++
 4 files changed, 83 insertions(+), 18 deletions(-)
---
base-commit: 7a7e0197133d18cfd9931e7d3a842d0f5730223f
change-id: 20241213-dp83822-tx-swing-5ba6c1e9b065

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



