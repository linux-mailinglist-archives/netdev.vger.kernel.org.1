Return-Path: <netdev+bounces-172863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C5DA56559
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF6B1899836
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0CC211460;
	Fri,  7 Mar 2025 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlnKdO3x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF620E018;
	Fri,  7 Mar 2025 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343406; cv=none; b=TGDwgFGIQxv7jWhN/+vLUXMJzTU+/Ni3oeNe9hkfE7MyYefqTpbrU4Jb7JLymYkfh4ZukzZSOH00JE7CS5A32B4XSiLepvEoHOgCnH+0YttPs0gu1h6uSh1TFukrWiafpVN5oQc6RCz2izgTIqPjM7bDFQKtbtRW7XGMSjVec1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343406; c=relaxed/simple;
	bh=no+4i1s9VlIVDNY5C3a4f9S1IkOBhSH/FQS6r2TvsaY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SBEyoqiStYmyGd3ogbs/xPGTd6SzhK8M5w1AzrZLie6vDGXdoHogb/cASV2vi9uNtvxI4wpXP6Exodvg1NitBww3T1VbhS1AYoe+xGFLORh6N5xNm/OqlT5SG8NSbFZCkiJ6j4eb/TnPTG3EnvoDqPdCfp9pp1YE33gp/kXU+go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlnKdO3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AB53C4CED1;
	Fri,  7 Mar 2025 10:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741343405;
	bh=no+4i1s9VlIVDNY5C3a4f9S1IkOBhSH/FQS6r2TvsaY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=XlnKdO3xtlg5DERTRaPu4Jj+zE5/PjL+Ef542DGXi2MKIrIcbIoRkF4GDRaWxGH9F
	 VjRlOTtbNbrx9kQ1S9V0IpNhSnO6QlVyJRg5wgsNmYCxwndz0dR6WhmgB0sGPG5EqV
	 3By2J2pzJPicWzh0mAKvTBlMRL8F9lmUtBF6246p6LkGNlQuWvZV/KN0HwCzAMb/V1
	 XjbcSrW5RVeKhAqSslLNbQu7VYkowRQPZMJMCbdmfAva23Mb3vpUEtggwV7DzbNkSy
	 8ik75cdJTrNzd6t7Nud0Vqlxw4vemrGzZEwJgMOGk9h6T4OgSPLm2ws4ovfepDjE2a
	 4sVDDfW8u2Udg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7B8C19F32;
	Fri,  7 Mar 2025 10:30:05 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH net-next 0/3] net: phy: dp83822: Add support for changing
 the MAC series termination
Date: Fri, 07 Mar 2025 11:30:00 +0100
Message-Id: <20250307-dp83822-mac-impedance-v1-0-bdd85a759b45@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKjKymcC/x3MQQrDIBBG4auEWXfAaiy2VyldGP3bziJT0RACI
 XevZPkt3tupoQoaPYadKlZp8tOO62Wg9I36AUvuJmusN854ziW4YC3PMbHMBTlqAofRjM5PJt1
 xo96Wirds5/dJioUV20Kv4/gD0w/AmnEAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741343404; l=1035;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=no+4i1s9VlIVDNY5C3a4f9S1IkOBhSH/FQS6r2TvsaY=;
 b=TCkWSSDE1hhTziwDGZWPe+PbN0V3Vcq/0IiFoPbcdbTu8ZlgotwPZhjgQ+2bB2Ifp+Vpx7dhJ
 OhY+QxDJ1neARIm/ltqGfNpLey1Yg6TACe/NsHZOaVJfO7SR2Snn//9
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
Dimitri Fedrau (3):
      dt-bindings: net: ethernet-phy: add property mac-series-termination-ohms
      net: phy: Add helper for getting MAC series termination resistance
      net: phy: dp83822: Add support for changing the MAC series termination

 .../devicetree/bindings/net/ethernet-phy.yaml      |  5 +++
 drivers/net/phy/dp83822.c                          | 36 ++++++++++++++++++++++
 drivers/net/phy/phy_device.c                       | 15 +++++++++
 include/linux/phy.h                                |  3 ++
 4 files changed, 59 insertions(+)
---
base-commit: 865eddcf0afbcd54f79b81e6327ea40c997714c7
change-id: 20250305-dp83822-mac-impedance-840435b0c9e6

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



