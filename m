Return-Path: <netdev+bounces-159777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB1FA16DBD
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 14:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23B53A5983
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 13:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB861E25F6;
	Mon, 20 Jan 2025 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCsPbvyu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE20E1B85DB;
	Mon, 20 Jan 2025 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737381030; cv=none; b=fCJGKh1C2WvULILnT6KWgsKuf5BM1hPOENENFG7jKckChSy5TKKiVDy6MmtvpaDHnlTC6RyRRiI7pXf3DmL/NaO1u79Q7Ps3srZx2k6193O8OFG7jwXB3cLC7JH7CMeuClbOetANLEvMJk9kxSW6BThSA74PkUKyYkjOdRyYVoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737381030; c=relaxed/simple;
	bh=tgzpuPTlk55PqGR4hzKBitiv5FYSx8q9JuFUVygLiZU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lqyRUIZMx2zzlLJ3HaX2CwulV9OK4xuUTJgv5sEyfCcJQXGuto+2BNbOnsyj9+yGnypnohju4ZNBlF/NAIOs3XrWDnsuPSf0Vog4KOBbWuDYxp97u7OfKjOaHLWYzpSxM+lMup+XQZVVilG6FwrelafL/+3ZRxnJXEcNQ1cVWF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCsPbvyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED9B4C4CEDD;
	Mon, 20 Jan 2025 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737381030;
	bh=tgzpuPTlk55PqGR4hzKBitiv5FYSx8q9JuFUVygLiZU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=sCsPbvyuIHOPOcs45JCD0ioRRpldCkdSzHq97qXT1Ee5YWtbzsT4T0nbyeH3kEoBI
	 OVmCG6/VKeQFqixX8KYPK0tqdFclAx2xInml1Qo2K1mIII7Gora3T9/+8cTv9e8z79
	 QBgCG9cjfOc/e8wMoYWJx6rq0PdZVjD89NoIk9nuy+6TKbT+Ntl2z5VVzkFoSGOTMB
	 y8+2VQuzsaB/vDIM0cfQcfnPZfVzRgGylysHUuWaMc7yOgTtU87j2QpCY6zvPJyuRV
	 Ti0Eadqsh457rremp0FJMDp4T0kEfIV9gQqN/upyhR2rIpUmfotdK8WQ9ulRMVcoa/
	 n7z690fQ11kGA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9EBC02181;
	Mon, 20 Jan 2025 13:50:29 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH net-next v2 0/3] net: phy: dp83822: Add support for
 changing the transmit amplitude voltage
Date: Mon, 20 Jan 2025 14:50:20 +0100
Message-Id: <20250120-dp83822-tx-swing-v2-0-07c99dc42627@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJxUjmcC/22NQQ6CMBBFr0Jm7ZhpsQiuvIdhAXSESbQlbYMYw
 t1tWLt8efnvbxA5CEe4FRsEXiSKdxn0qYBh6tzIKDYzaNIXpVWJdq7LWmtMK8aPuBFN31WD4qa
 nykCezYGfsh7JBzhO6HhN0GYzSUw+fI+vRR0+Zw2pf9lFIeGVrekaWxMpur+E+4lDOA/+De2+7
 z/oBY0wvQAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737381028; l=1257;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=tgzpuPTlk55PqGR4hzKBitiv5FYSx8q9JuFUVygLiZU=;
 b=dPLIo5u0zT2/jV5kb4jkzAGVdakwVyp3mtlz9U3opi/THSQPsrot3icWRVzpytUmDEe1NtLo4
 DlVAJf7A1wdA66zxl4S/GHwUc03AMqxHPwOrh1r0oZ/E0d/YVdb9K2o
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
Changes in v2:
- Remove binding ti,tx-amplitude-100base-tx-millivolt from ti,dp83822.yaml
- Add binding tx-amplitude-100base-tx-gain-milli to ethernet-phy.yaml
- Add helper to get tx amplitude gain from DT
- Link to v1: https://lore.kernel.org/r/20250113-dp83822-tx-swing-v1-0-7ed5a9d80010@liebherr.com

---
Dimitri Fedrau (3):
      dt-bindings: net: ethernet-phy: add property tx-amplitude-100base-tx-gain-milli
      net: phy: Add helper for getting tx amplitude gain
      net: phy: dp83822: Add support for changing the transmit amplitude voltage

 .../devicetree/bindings/net/ethernet-phy.yaml      |  8 +++++
 drivers/net/phy/dp83822.c                          | 37 ++++++++++++++++++++++
 drivers/net/phy/phy_device.c                       | 20 +++++++++---
 include/linux/phy.h                                |  3 ++
 4 files changed, 64 insertions(+), 4 deletions(-)
---
base-commit: 64ff63aeefb03139ae27454bd4208244579ae88e
change-id: 20241213-dp83822-tx-swing-5ba6c1e9b065

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



