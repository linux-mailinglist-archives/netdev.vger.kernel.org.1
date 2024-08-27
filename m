Return-Path: <netdev+bounces-122263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8649608B0
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1BB1F23A82
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 11:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4491A00F7;
	Tue, 27 Aug 2024 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hu3tlNjF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677C11A00E2;
	Tue, 27 Aug 2024 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758185; cv=none; b=U2tAMqikDiTscyYkQ1utB5Iwe8qiKsGAmDI+aZhCSw/SUqMzw31aLu1VcT8ViEDhwNBav6IO+9gieK1Rf2HaQqp19Nzo9kOZKmO90HRZQwcuEqi9INyn0FU6myX3Ma6kh4WzTXihDNBTZcFY+kLs1ixEyOsBiSUuq8RbptWL/ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758185; c=relaxed/simple;
	bh=etuwT1euxSljZjW4oc24vh7whpGW5rQpbQ2KaCeHW/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TNlU0NuBSZDNyTh8LRFQ1wmxh2SpW09iaEWUB0I1cZEgkURKcSBqSlX85CkWty+D2mWJfHujBYiHMkMQ3CYWJau/xeBUWsRuZByGj8G3AEp3dsSs79Y97dZBqk7jTWX5fjZgSN35bvBBgv49QHP2r8KN6EJ/rQanp8qZRZTvFzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hu3tlNjF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6709CC58282;
	Tue, 27 Aug 2024 11:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724758185;
	bh=etuwT1euxSljZjW4oc24vh7whpGW5rQpbQ2KaCeHW/4=;
	h=From:To:Cc:Subject:Date:From;
	b=hu3tlNjFqxBvsAC1psinXwnoeGAeh+ElETFpdgav5V+6zLCAVxo/OaZ4BzvTrmZW3
	 xgNnt5OJ6avWOUWvSCSkLALv+NX32eKL1PsYKVOFYcrykowIDVLpIkzgpshxjjJfZs
	 grb+6h0ORRDr7N4nGU/i0lPCwvBk7l5drDI7uuCXhYDhSRkj5A9+fQNyQEQqOw4Uma
	 lVByBFoAoa0vV//crfyWqKzv+cu3OdRlROBit1544apTEq9+0WuXrKYBpP22gFnYAg
	 FZK5Z1wOjqCBvg7rdQBgKHnp9IKVAsJd4qePoFK+5E6Dl0t+mmNUvxoXmz1ck063E7
	 trLIJRAXHyjQw==
From: Conor Dooley <conor@kernel.org>
To: netdev@vger.kernel.org
Cc: conor@kernel.org,
	Steve Wilkins <steve.wilkins@raymarine.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	valentina.fernandezalanis@microchip.com,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next] net: macb: add support for configuring eee via ethtool
Date: Tue, 27 Aug 2024 12:29:23 +0100
Message-ID: <20240827-excuse-banister-30136f43ef50@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3478; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=/jWBHfktTnMnWwd+OtzS2TE8hmCXENAXH9kNHZHk7X8=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGlnd0y6d8t2cYtNTKJfS8Cq1wpPdNJSZlrZzzj0KsDT+ 9ySQImmjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzkoC7D/1ipkzpT5/b+P3po pdCk7VOP7/p45JNM8EwfiRe5cb8r73Uy/LPo32vqfFFUiavnoeztP5c782Y97tqzt+N4/61Q9ai 9qZwA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Steve Wilkins <steve.wilkins@raymarine.com>

Add ethtool_ops for configuring Energy Efficient Ethernet in the PHY.

Signed-off-by: Steve Wilkins <steve.wilkins@raymarine.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Steve sent me this patch (modulo the eee -> keee change), but I know
nothing about the macb driver, so I asked Nicolas whether the patch
made sense. His response was:
> Interesting although I have the feeling that some support from our MAC
> is missing for pretending to support the feature.
> I'm not sure the phylink without the MAC support is valid.
>
> I think we need a real task to be spawn to support EEE / LPI on cadence
> driver (but I don't see it scheduled in a way or another 🙁 ).

Since he was not sure, next port of call is lkml.. Is this patch
sufficient in isolation, or are additional changes required to the driver
for it?

The other drivers that I looked at that use phylink_ethtool_set_eee()
vary between doing what's done here and just forwarding the call, but
others are more complex, so without an understanding of the subsystem
I cannot tell :)

Alternatively, Steve, shout if you can tell me why forwarding to the phy
is sufficient, and I'll update the commit message and send this as
non-RFC.

Thanks,
Conor.

CC: valentina.fernandezalanis@microchip.com
CC: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: "David S. Miller" <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Russell King <linux@armlinux.org.uk>
CC: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/net/ethernet/cadence/macb_main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 95e8742dce1d..a2a222954ebf 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3321,6 +3321,20 @@ static int macb_set_link_ksettings(struct net_device *netdev,
 	return phylink_ethtool_ksettings_set(bp->phylink, kset);
 }
 
+static int macb_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
+{
+	struct macb *bp = netdev_priv(netdev);
+
+	return phylink_ethtool_get_eee(bp->phylink, edata);
+}
+
+static int macb_set_eee(struct net_device *netdev, struct ethtool_keee *edata)
+{
+	struct macb *bp = netdev_priv(netdev);
+
+	return phylink_ethtool_set_eee(bp->phylink, edata);
+}
+
 static void macb_get_ringparam(struct net_device *netdev,
 			       struct ethtool_ringparam *ring,
 			       struct kernel_ethtool_ringparam *kernel_ring,
@@ -3767,6 +3781,8 @@ static const struct ethtool_ops macb_ethtool_ops = {
 	.set_wol		= macb_set_wol,
 	.get_link_ksettings     = macb_get_link_ksettings,
 	.set_link_ksettings     = macb_set_link_ksettings,
+	.get_eee		= macb_get_eee,
+	.set_eee		= macb_set_eee,
 	.get_ringparam		= macb_get_ringparam,
 	.set_ringparam		= macb_set_ringparam,
 };
@@ -3783,6 +3799,8 @@ static const struct ethtool_ops gem_ethtool_ops = {
 	.get_sset_count		= gem_get_sset_count,
 	.get_link_ksettings     = macb_get_link_ksettings,
 	.set_link_ksettings     = macb_set_link_ksettings,
+	.get_eee		= macb_get_eee,
+	.set_eee		= macb_set_eee,
 	.get_ringparam		= macb_get_ringparam,
 	.set_ringparam		= macb_set_ringparam,
 	.get_rxnfc			= gem_get_rxnfc,
-- 
2.43.0


