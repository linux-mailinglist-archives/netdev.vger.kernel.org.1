Return-Path: <netdev+bounces-225668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A44DB96B1A
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 18:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB452E390B
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E3D26A0B3;
	Tue, 23 Sep 2025 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Urym+XVf"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC784AD24;
	Tue, 23 Sep 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643257; cv=none; b=Z0cOuVT6SaGfIGpWV1+K+eY8C5e9THfE7eaaIR0nf1rrnOeVpDY4SNXsfzESL3X65TorBQpTnf2Fu+HiuNclN4MYF986VlcUHHJj+FkMSPGqX/Lz53W8sYznKFripE8XecbCSTy2NgJ9uV8y/wmnrCXbNAbU9OpK5FTujI72J1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643257; c=relaxed/simple;
	bh=K7M/K8PJaKiTPwz6Eczu59Ns1Bon47X7ntTa0Mc316Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dxbdKqP5vghmVOcag+rnG+XGnHc5gPaGM4opqsZlKwquaYQDsy4+qZHas5QugiBf2KPhvu6CrpvaRIoHxykuanyIlADWACFL871jvMqD/ZGidu+de9xvgMrR0f+WNtTZiJtmIfKHjGLzTIiiG4OI8Fl87BWlBFhaT/vNBrioljc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Urym+XVf; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EC70A1A0E34;
	Tue, 23 Sep 2025 16:00:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B823260690;
	Tue, 23 Sep 2025 16:00:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B51A102F1970;
	Tue, 23 Sep 2025 18:00:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758643249; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=icwF1/4dEy4IPtNLQ9Fgq/jQqRBedbtujUnUyxMQyX4=;
	b=Urym+XVf2RqOOxlrMBQbWD850F/+/94MWb+fzY88jJaMJzM4UtYab9j/uItH15hRP8tY4/
	/L0xvol0ZFvzTZiIiEijE73gDzYlkfezWOtdZ5wQvCgSCw9NcrjhR7ZEqqrNaLfWbX5UNU
	A3VIMLhYhe7oKGHPSp96ibe7w7Ow5NM0VJJBNLkDCwLoBr4twTSlLU47iAn4mkQvLh6ZTo
	rLMVXBFwB/0W7ezxlMGs/0/mbIN/d/1VaK2tpHwCWbsbwaBZT/8bckSGRDyishTE99E36O
	sEXLMQZgCXnPzNsumLQkQtZ/VdWiPPeKyS79KpNQBtAS2U/n1/ywBtbX9AY1EA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net v6 0/5] net: macb: various fixes
Date: Tue, 23 Sep 2025 18:00:22 +0200
Message-Id: <20250923-macb-fixes-v6-0-772d655cdeb6@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABbE0mgC/23NTQ7CIBAF4Ks0rMUw/LTFlfcwLlocLIktBhqia
 Xp3CRutunzz5ptZSMTgMJJDtZCAyUXnpxzqXUXM0E1XpO6SM+GMK9aylo6d6al1D4wUuVUNQwA
 ugWRwD1iKvH8iE87knIeDi7MPz/IgiVL9u5UEZZS1FqzpFTTaHnvv55ub9saP5VCSH5izDZYZc
 2GE1pJrqOUvVm+sYYtVxlaC6ETNwOAXXtf1BTVkKX4lAQAA
X-Change-ID: 20250808-macb-fixes-e2f570e11241
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Harini Katakam <harini.katakam@xilinx.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sean Anderson <sean.anderson@linux.dev>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

This would have been a RESEND if it wasn't for that oneline RCT fix.
Rebased and tested on the latest net/main as well, still working fine
on EyeQ5 hardware.

Fix a few disparate topics in MACB:

[PATCH net v6 1/5] dt-bindings: net: cdns,macb: allow tsu_clk without tx_clk
[PATCH net v6 2/5] net: macb: remove illusion about TBQPH/RBQPH being per-queue
[PATCH net v6 3/5] net: macb: move ring size computation to functions
[PATCH net v6 4/5] net: macb: single dma_alloc_coherent() for DMA descriptors
[PATCH net v6 5/5] net: macb: avoid dealing with endianness in macb_set_hwaddr()

Patch 3/5 is a rework that simplifies patch 4/5. It is the only non-fix.

Pending series on MACB are: (1) many cleanup patches, (2) patches for
EyeQ5 support and (3) XDP work. Those will be sent targeting
net-next/main once this series lands there, aiming to minimise merge
conflicts. Old version of(1) and (2) are visible in the V2 revision [0].

Thanks,
Have a nice day,
Théo

[0]: https://lore.kernel.org/lkml/20250627-macb-v2-0-ff8207d0bb77@bootlin.com/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v6:
- RCT fix on top/bottom variables in macb_set_hwaddr().
- Link to v5: https://lore.kernel.org/r/20250910-macb-fixes-v5-0-f413a3601ce4@bootlin.com

Changes in v5:
- Fix hwaddr endianness patch following comment by Russell [2].
  [2]: https://lore.kernel.org/lkml/DCKQTNSCJD5Q.BKVVU59U0MU@bootlin.com/
- Take 4 Acked-by: Nicolas Ferre.
- Take Tested-by: Nicolas Ferre.
- Link to v4: https://lore.kernel.org/r/20250820-macb-fixes-v4-0-23c399429164@bootlin.com

Changes in v4:
- Drop 11 patches that are only cleanups. That includes the
  RBOF/skb_reserve() patch that, after discussion with Sean [1], has
  had its Fixes trailer dropped. "move ring size computation to
  functions" is the only non-fix patch that is kept, as it is depended
  upon by further patches. Dropped patches:
    dt-bindings: net: cdns,macb: sort compatibles
    net: macb: match skb_reserve(skb, NET_IP_ALIGN) with HW alignment
    net: macb: use BIT() macro for capability definitions
    net: macb: remove gap in MACB_CAPS_* flags
    net: macb: Remove local variables clk_init and init in macb_probe()
    net: macb: drop macb_config NULL checking
    net: macb: simplify macb_dma_desc_get_size()
    net: macb: simplify macb_adj_dma_desc_idx()
    net: macb: move bp->hw_dma_cap flags to bp->caps
    net: macb: introduce DMA descriptor helpers (is 64bit? is PTP?)
    net: macb: sort #includes
  [1]: https://lore.kernel.org/lkml/d4bead1c-697a-46d8-ba9c-64292fccb19f@linux.dev/
- Wrap code to 80 chars.
- Link to v3: https://lore.kernel.org/r/20250808-macb-fixes-v3-0-08f1fcb5179f@bootlin.com

Changes in v3:
- Cover letter: drop addresses that reject emails:
  cyrille.pitchen@atmel.com
  hskinnemoen@atmel.com
  jeff@garzik.org
  rafalo@cadence.com
- dt-bindings: Take 2x Reviewed-by Krzysztof.
- dt-bindings: add Fixes trailer to "allow tsu_clk without tx_clk"
  patch, to highlight we are not introducing new behavior.
- Reorder commits; move fixes first followed by cleanup patches.
- Drop all EyeQ5 related commits.
- New commit: "remove gap in MACB_CAPS_* flags".
- New commit: "move ring size computation to functions".
- New commit: "move bp->hw_dma_cap flags to bp->caps".
- Rename introduced helpers macb_dma_is_64b() to macb_dma64() and,
  macb_dma_is_ptp() to macb_dma_ptp().
- Rename MACB_CAPS_RSC_CAPABLE -> MACB_CAPS_RSC.
- Fix commit message typos: "maxime" -> "maximise", etc.
- Take 7x Reviewed-by: Sean Anderson.
- Add details to some commit messages.
- Link to v2: https://lore.kernel.org/r/20250627-macb-v2-0-ff8207d0bb77@bootlin.com

---
Théo Lebrun (5):
      dt-bindings: net: cdns,macb: allow tsu_clk without tx_clk
      net: macb: remove illusion about TBQPH/RBQPH being per-queue
      net: macb: move ring size computation to functions
      net: macb: single dma_alloc_coherent() for DMA descriptors
      net: macb: avoid dealing with endianness in macb_set_hwaddr()

 .../devicetree/bindings/net/cdns,macb.yaml         |   2 +-
 drivers/net/ethernet/cadence/macb.h                |   4 -
 drivers/net/ethernet/cadence/macb_main.c           | 138 ++++++++++-----------
 3 files changed, 69 insertions(+), 75 deletions(-)
---
base-commit: 3a5dc79698c028c922bdaa75274a967107e25f02
change-id: 20250808-macb-fixes-e2f570e11241

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


