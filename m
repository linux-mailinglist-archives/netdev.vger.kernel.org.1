Return-Path: <netdev+bounces-106117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 063D7914E59
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E38E1C2141F
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB3D13D893;
	Mon, 24 Jun 2024 13:25:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BED13D889
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235541; cv=none; b=gw+uppwkIhknrItsnlY7EIsYIYqRIFYWXJha3W6xL+rbq/hhrf4Yaia7zWqC7HAdud8EDaFVunh2oUK4QamRRtt2it9/lYywAvmj7TTrUfsMKtP0bxO+2j1KN3ShUfgei3oOvRhfaw1LW5zE3gTopkRR1s+ngLpeS5jOXYq1SZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235541; c=relaxed/simple;
	bh=2HA87VcKDxd4qJxS5VjLpvA+r34etIBEyZvCeg6nLtw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Vqun0Zv62VJ9mBCata2XpLBTAWRzSgUiJDhw2Iikf/jJKk6RHss6oKVQKLRg7qQhu33aOc2iyTcV77VrV+/56uJgGE1Pt3uwMF/SB3fO4TMy7l1LtRLKLxRkxBrHMKv6dOHNwt/rlVNl5SMgKYXjm7uWjv2SQkKz/qg1m3EP7fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:d11f:2bfd:8d32:701a])
	by albert.telenet-ops.be with bizsmtp
	id fRRT2C00R4jBKfC06RRTCl; Mon, 24 Jun 2024 15:25:32 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sLjhF-000HSV-6r;
	Mon, 24 Jun 2024 15:25:27 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sLjhH-007u97-MX;
	Mon, 24 Jun 2024 15:25:27 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	Paul Barker <paul.barker.ct@bp.renesas.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH net-next v2 0/2] ravb: Add MII support for R-Car V4M
Date: Mon, 24 Jun 2024 15:25:23 +0200
Message-Id: <cover.1719234830.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

	Hi all,

All EtherAVB instances on R-Car Gen3/Gen4 SoCs support the RGMII
interface.  In addition, the first two EtherAVB instances on R-Car V4M
also support the MII interface, but this is not yet supported by the
driver.  This patch series adds support for MII on R-Car Gen4, after the
customary cleanup.

Changes compared to v1[1]:
  - New patch "ravb: Improve ravb_hw_info instance order",
  - Add Reviewed-by,
  - Rename ravb_emac_init_rcar_apsr() to ravb_emac_init_rcar_gen4(),
  - Restrict MII support to R-Car Gen4 by adding a new ravb_hw_info
    instance.

The corresponding pin control support is available in [2].

Compile-tested only, as all AVB interfaces on the Gray Hawk Single
development board are connected to RGMII PHYs.
No regressions on R-Car V4H.

Thanks for your comments!

[1] "[PATCH/RFC] net: ravb: Add MII support for R-Car V4M"
    https://lore.kernel.org/f0ef3e00aec461beb33869ab69ccb44a23d78f51.1718378166.git.geert+renesas@glider.be

[2] "[PATCH/RFC] pinctrl: renesas: r8a779h0: Add AVB MII pins and groups"
    https://lore.kernel.org/4a0a12227f2145ef53b18bc08f45b19dcd745fc6.1718378739.git.geert+renesas@glider.be/

Geert Uytterhoeven (2):
  ravb: Improve ravb_hw_info instance order
  ravb: Add MII support for R-Car V4M

 drivers/net/ethernet/renesas/ravb.h      |  1 +
 drivers/net/ethernet/renesas/ravb_main.c | 45 +++++++++++++++++++++---
 2 files changed, 41 insertions(+), 5 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

