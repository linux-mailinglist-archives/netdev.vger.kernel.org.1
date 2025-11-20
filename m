Return-Path: <netdev+bounces-240470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB93C75600
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 563444EBF7F
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC1B369208;
	Thu, 20 Nov 2025 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUP7Q68P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AF7348867;
	Thu, 20 Nov 2025 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763655995; cv=none; b=q063MC+2A/dWL24X1PJlMXcqPzWNX7JPr/NqIERezW6IgsyQ7Bi5r680g18wTbihI0ywsdQtvs12wkOqZ+q4Ef0mO0vGWJWz2KUghTLAqiyJIyLiIEutau/D6bgX63Za0zPixpN3hnIyY7R/R10iHuX9kQlu0TzJN9o8VF3xyjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763655995; c=relaxed/simple;
	bh=uTA+9by6WkTj/YyfrRJaP6uWrGxXUK8E1OGGD6svXNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lztxnV4EFWwVRXb7/j24GzxMFryYU69sQlaI7iCDh7nq3X9MidEk8wv68qVa/8iUhSYURW0ouzQGPLtfdMolMTG0DVOYRnXfj6IFg4LFMH1t5nDpQmbI7kCJh55Z5jsZraeWESbVpmleaCpi6vHWZXsxwIZxoX5VoiiIJvyhEYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUP7Q68P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E99CC4CEF1;
	Thu, 20 Nov 2025 16:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763655995;
	bh=uTA+9by6WkTj/YyfrRJaP6uWrGxXUK8E1OGGD6svXNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OUP7Q68P6m2hQLa6Yx7/cAJrv+1/blhA4zCLQkPSXtvz+EUdA88migDRkMrmrJtr3
	 rwkZywC88dG/x/WIvmwd8dWAc4WjKgyQk1h2B2ff0i35FqCZYsW2PGjBXLvcrQojYh
	 zng3tHYtG+JYW92klZlGfZMReaaRa8rrgS1WNSmddn6MJlSkGxM+Xt6qEP12mruCq/
	 03ba7fOIMgi4EiaGOZYumPnQ4RzqkwT7XDOgMFpgi/W7gK5bx6+zy2Q7us9EAsnrOg
	 S1HiJKY7NOLd1ivURQSDxb4zo98lUBDZOfWf9Aduo8+KIqV/hV+zmoq6D6liINiaKn
	 dwI8HjbFJkVLw==
From: Conor Dooley <conor@kernel.org>
To: netdev@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Neil Armstrong <narmstrong@baylibre.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Abin Joseph <abin.joseph@amd.com>
Subject: [RFC net-next v1 2/7] net: macb: warn on pclk use as a tsu_clk fallback
Date: Thu, 20 Nov 2025 16:26:04 +0000
Message-ID: <20251120-guts-grandma-15cf7838b0aa@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120-jubilant-purposely-67ec45ce4e2f@spud>
References: <20251120-jubilant-purposely-67ec45ce4e2f@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3306; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=v3962aZmMGVHfkgDFXhApnPxgvXxwo2H9ZQ6D4IRJzc=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJnyjlISvNuTixaHS5zRuum9YtpeL9Gd2wMfnnvxYrvD/ xl+FlLZHaUsDGJcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiIpRTDXzHxP/+K5azEdgRr Npk+f77oxd69tzgvGVydXrg6YFLlBjaG/44bVqw1O7blu4GbwFeTrdxPrgWn6yml68RXJSl/fBc tyg4A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Not a serious patch as-is, but I think this pclk fallback code is not
really a good idea.

I think the reason that it exists is that there is a parameter for the
IP that will make the hardware use the pclk to clock the timestamper,
but from a devicetree and driver point of view I don't think this is
actually really relevant and this code is just bug prone.

It makes more sense for the binding/driver if the tsu_clk clock
represents whatever clock is clocking the timestamper, not specifically
the tsu_clk input to the IP block, because what it does at the moment
will register the ptp clock with an incorrect clock in the "right" (or
wrong I guess) circumstances. This can happen when the capability
MACB_CAPS_GEM_HAS_PTP is set for the integration, MACB_USE_HWSTAMP is
set (which a multiplatform kernel would) but the devicetree does not
provide a tsu_clk. Sure, that probably means the devicetree is wrong,
but there's no per-compatible clocks enforcement in the binding so
getting it right might not be so easy!

It's my opinion that, regardless of the way the parameter is set, it
makes sense for the binding/driver if the "tsu_clk" clock actually
represents the clock being used by the timestamper, not strictly the
clock provided to the tsu_clk input to the IP block. That's because
there appears to be nothing done differently between the two cases
w.r.t. configuring the hardware at runtime and it allows us to be sure
the ptp clock will not be registered with the wrong clock. Obviously,
for compatibility reasons I can't just delete this fallback though,
because there are devices using it, so just warn in the hopes that the
devices that actually use pclk for the timestamper can be updated to
explicitly provide it.

Out of the devices that claim MACB_CAPS_GEM_HAS_PTP the fu540, mpfs,
sama5d2 and sama7g5-emac (but not sama7g5-gem) are at risk of having
this problem. It may be that these platforms actually do use the pclk
for the timestamper (either by supplying pclk to the tsu_clk input of
the IP, or by having the IP block configured to use pclk instead of the
tsu_clk input). mpfs is wrong though, it does not use pclk for the
tsu_clk, so the driver is registering the ptp clock incorrectly.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
As I say, not a serious patch at the moment, but I'd like to know what
folks think here. All of the Xilinx platforms I looked at explicitly
provide the tsu_clk, so aren't impacted.
I know this changes the meaning of the dt-binding, but I don't think it
is harmful to do so, as it is a nop for any existing devices that
provide tsu_clk.
---
 drivers/net/ethernet/cadence/macb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ca2386b83473..b9248f52dd5b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3567,6 +3567,7 @@ static unsigned int gem_get_tsu_rate(struct macb *bp)
 	else if (!IS_ERR(bp->pclk)) {
 		tsu_clk = bp->pclk;
 		tsu_rate = clk_get_rate(tsu_clk);
+		dev_warn(&bp->pdev->dev, "devicetree missing tsu_clk, using pclk as fallback\n");
 	} else
 		return -ENOTSUPP;
 	return tsu_rate;
-- 
2.51.0


