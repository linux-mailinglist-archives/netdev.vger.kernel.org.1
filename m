Return-Path: <netdev+bounces-180070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4802A7F6EA
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B171890000
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 07:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B982E263C78;
	Tue,  8 Apr 2025 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQdvLmS8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B2723F262;
	Tue,  8 Apr 2025 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744098340; cv=none; b=AzYBaVFJILWUrZo2oy5WaGyFR62jkCevl52qfmlKX+8Xo3ncjIM5liBCP9k+wh+C8gH+ChOK1krdaJ/DPP1JmQUt3USbEX0JUPKPD0ve2Hx1JA0rT1NNzwK/2F7PRs1ZCYib03E7FtJuuwf644C7poqG1VCNP7d1lj0t5CfdfN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744098340; c=relaxed/simple;
	bh=OvKGbB2FbzBCATO/Bgq5TPoN+AHARPbGu6KH2H1fDDw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DsCShPiScDo6KQm7knW8F3v/TwOg3bMEEP/56qCIac4+5nez3v1uYzChyLd3mX38SpLo6JOGzaZL4SyVZ0SgXG2VMwd9bFXvVXeilY/0sY4W7c3UVacJhq+83Xf/yb7Dp4NM62NYTn2wKHqZ7bCCXg4KKqyWUtx3VVdpqdrKB+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQdvLmS8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCAFEC4CEE5;
	Tue,  8 Apr 2025 07:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744098339;
	bh=OvKGbB2FbzBCATO/Bgq5TPoN+AHARPbGu6KH2H1fDDw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=tQdvLmS8MIfd49Xe4tK5hslcfvoCAGk+GU51525sTG1EZRm+xHftDRmZwWk73O8DU
	 ut29CtQx15xtyYbka91mmzQrdegSaHL4AVNmD5O9gYSE+zSYHeAR0qeSGke02gYC6j
	 pBAIpP5qgB5Sbvf4tkwRa8EWIah9aUx5WoTkCinS157Ay4DCmsYV930F7fqbk7lZAX
	 e3KnS1HYOosGypqzLu5+4LF5TK6uWD43Bx0MLjzFfKhB3qUcVvTNsO791OOemovqWI
	 THj9/H1ilGQkWS0oOgIb4YSbS87dtN4TsrLsGIpkvyApB2GmH41d5Mfs+I3Lo/FQll
	 vWcqE8g/8ljGw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C4CC3600C;
	Tue,  8 Apr 2025 07:45:39 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH net-next v2 0/3] net: phy: dp83822: Add support for
 changing the MAC series termination
Date: Tue, 08 Apr 2025 09:45:31 +0200
Message-Id: <20250408-dp83822-mac-impedance-v2-0-fefeba4a9804@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABvU9GcC/3WNywqDMBBFf0Vm3Skxmhpd9T+KizymdaBGSUQs4
 r83SLddHg733B0SRaYEXbFDpJUTTyGDvBTgBhNehOwzgxRSiUoo9LOutJQ4Goc8zuRNcIS6FnW
 lrHAt3SBv50hP3s7uAwItGGhboM9m4LRM8XMeruXpf+3mT3stUaD1XivTqNbW6v5msgPFeHXTC
 P1xHF/GHUuUxwAAAA==
X-Change-ID: 20250305-dp83822-mac-impedance-840435b0c9e6
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744098338; l=1500;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=OvKGbB2FbzBCATO/Bgq5TPoN+AHARPbGu6KH2H1fDDw=;
 b=LAP+5KozOfLFiM9ARSpBu0uYlfKBnWFlKSIEmHuCE92oEypvNMNHSfEJlTOZxY+HY6lLA1X/f
 tK9686IiRiaAPUOAdgx9IRqOWq4Szc8sSbjvHzzoEx48sIfqzoqz3aj
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
Changes in v2:
- Renamed "mac-series-termination-ohms" to "mac-termination-ohms"
- Added description for "mac-termination-ohms"
- Renamed "phy_get_mac_series_termination" to "phy_get_mac_termination"
- Dropped "mac_series_termination_modify" from dp83822_private
- Init mac_termination_index in dp8382x_probe
- Renamed "mac_series_termination" to "mac_termination"
- Link to v1: https://lore.kernel.org/r/20250307-dp83822-mac-impedance-v1-0-bdd85a759b45@liebherr.com

---
Dimitri Fedrau (3):
      dt-bindings: net: ethernet-phy: add property mac-termination-ohms
      net: phy: Add helper for getting MAC termination resistance
      net: phy: dp83822: Add support for changing the MAC termination

 .../devicetree/bindings/net/ethernet-phy.yaml      |  9 ++++++
 drivers/net/phy/dp83822.c                          | 33 ++++++++++++++++++++++
 drivers/net/phy/phy_device.c                       | 15 ++++++++++
 include/linux/phy.h                                |  3 ++
 4 files changed, 60 insertions(+)
---
base-commit: 61f96e684edd28ca40555ec49ea1555df31ba619
change-id: 20250305-dp83822-mac-impedance-840435b0c9e6

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



