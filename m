Return-Path: <netdev+bounces-109795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0A0929F3A
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B3DB23760
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFE5770E8;
	Mon,  8 Jul 2024 09:37:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAB16F2E2
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720431457; cv=none; b=f+aEMZmxIdEYM2E218zE2BQ8hoddZ4r4U3pWkc5qgB2XwrFjCppzZM6s+LtNFto4cPX+jhRy9YMuswjTbXlNEkoriTtqE24ZUqaoCVbv0WpF7l7kRM9JyVeXuFV4BbOWg7bd+pBbj/zPm3YBw7X6Qk/HSn/IofiwgUL5fVrVgZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720431457; c=relaxed/simple;
	bh=3682u2+RM5bTACboe7g/UHTGCKdEe8meJmTBGIUebxA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fJSAjerrRvStd+ftS6tKlSAsNTBiVFGdtqERUiqqXS/rb7KLWS3G6UcSuL+Nc9kqGLPvEls+tmLQC85IKwYdfbemKydeORx0JtNxzHdYAW4fpUJVkBIJG0/6Yq5a6UbJ2CDmIiQBtxhg2M0sHCCc/qRepju0nLGmnCiW+HqpNec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:5564:ad59:41e5:4080])
	by laurent.telenet-ops.be with bizsmtp
	id kxdS2C00i5NeGrf01xdSwW; Mon, 08 Jul 2024 11:37:27 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQko6-001PJ4-P4;
	Mon, 08 Jul 2024 11:37:26 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sQkoI-009RRR-KV;
	Mon, 08 Jul 2024 11:37:26 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Manish Chopra <manishc@marvell.com>,
	Rahul Verma <rahulv@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 00/12] arm64: dts: renesas: rcar-gen3/4: Add missing iommus properties
Date: Mon,  8 Jul 2024 11:37:12 +0200
Message-Id: <cover.1720430758.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

This patch series completes the description of Audio-DMAC, EthernetAVB,
Frame Compression Processor, Gigabit Ethernet, SDHI, and Serial-ATA
devices nodes on R-Car Gen3/Gen4 SoCs by adding iommus properties where
they are still missing, so they can be used with the IOMMU.

Note that this only covers device types that already have iommus
properties on other SoCs from the same family.  Device types that
currently lack such a property on all SoCs (e.g. PCIe, Video-IN, Image
Signal Processor) are not touched.

Thanks for your comments!

I plan to queue this in renesas-devel for v6.12.

Geert Uytterhoeven (12):
  arm64: dts: renesas: r8a774a1: Add missing iommus properties
  arm64: dts: renesas: r8a774b1: Add missing iommus properties
  arm64: dts: renesas: r8a774c0: Add missing iommus properties
  arm64: dts: renesas: r8a774e1: Add missing iommus properties
  arm64: dts: renesas: r8a77960: Add missing iommus properties
  arm64: dts: renesas: r8a77961: Add missing iommus properties
  arm64: dts: renesas: r8a77965: Add missing iommus properties
  arm64: dts: renesas: r8a77970: Add missing iommus property
  arm64: dts: renesas: r8a77980: Add missing iommus properties
  arm64: dts: renesas: r8a779a0: Add missing iommus properties
  arm64: dts: renesas: r8a779g0: Add missing iommus properties
  arm64: dts: renesas: r8a779h0: Add missing iommus properties

 arch/arm64/boot/dts/renesas/r8a774a1.dtsi |  6 ++++++
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi | 26 +++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi |  3 +++
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi |  8 +++++++
 arch/arm64/boot/dts/renesas/r8a77960.dtsi |  2 ++
 arch/arm64/boot/dts/renesas/r8a77961.dtsi |  2 ++
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 22 +++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a77970.dtsi |  1 +
 arch/arm64/boot/dts/renesas/r8a77980.dtsi |  2 ++
 arch/arm64/boot/dts/renesas/r8a779a0.dtsi | 20 +++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi |  5 +++++
 arch/arm64/boot/dts/renesas/r8a779h0.dtsi |  2 ++
 12 files changed, 99 insertions(+)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

