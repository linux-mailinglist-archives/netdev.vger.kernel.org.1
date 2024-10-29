Return-Path: <netdev+bounces-139891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD89C9B48B6
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 12:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7051C227F1
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 11:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC02205AB1;
	Tue, 29 Oct 2024 11:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EBAqimTT"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CE5193436;
	Tue, 29 Oct 2024 11:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202874; cv=none; b=Hmtn2EQPu8IyIpkSYxbQ0nakHlL7+vz7r0X5De4m6/n830y1GpIS+5RwVntAWXFuKO97QyVOTOGCTijaj8WFV6umBk8sk+4VNqU0r3YLop3pGSiXv8fyiZViOhsZyAeT1+fOniS62bqfs+jFRpB8OrFYwtcsQxYHIGXCbFwKTL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202874; c=relaxed/simple;
	bh=UcUxy1IH/tmxGDJJnCenAJWVix1uTow0kRuzSJ6rw5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rHsMrR3zUL4LIChKGNgMzFV2tw35zmTauYpqizynqWccHELKvkDQBu/9rscpCF9Ndv+XDzVnUhbdd0zJYiMxkJmF286qlALYONmITYE9PVqJfhUgoo9jBzBdRFWNs/RaVG5D2rnfxroGQMlBbBcI7NwFl/GsIuWhMtnVPvwiU2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EBAqimTT; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EFE3A1C0002;
	Tue, 29 Oct 2024 11:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730202862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lJpykFaYI1xkl+2h37OQVMMCDwoLFpotNWfg5DS8+W8=;
	b=EBAqimTTsliRJJCA4biH2rIBJLlKYw9TfFmBjIsErWLNjRJs5JfIWGGlchaFpSvbbSohgj
	4QMozgMOL/uUSh183b0LMH57cqD2OsdiUZVRaMKzDWsWfE45KqoakQxeM2cTEU2iKCaAN6
	t0bYztiTvQURcoiOXepIAcKhRT8lCZKpaydkj4cglLeGUYtWvSdZnn9X988mdRBOl0P021
	7tWGM4kSy1rk90+2bf72Sv3vmjm5gW04rZ36HDVatNMUjT6qqWj7Tck0226b778xWB+AZj
	9sTN1s9XFFSxgXPPpjYk45H4kMWrR3jBNiwIJQVOtsc5013jhUyIbMA4P97OYw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/7] Support external snapshots on dwmac1000
Date: Tue, 29 Oct 2024 12:54:08 +0100
Message-ID: <20241029115419.1160201-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

This series is another take on the pervious work [1] done by
Alexis Lothoré, that fixes the support for external snapshots
timestamping in GMAC3-based devices.

The registers that are used to configure this don't have the same layout
in the dwmac1000 compared to dwmac4 and others.

One example would be the TS seconds/nanoseconds registet for snapshots,
which aren't mapped at the 0x48/0x4c but rather at 0x30/0x34.

Another example is the was the snapshots are enabled. DWMAC4 has a
dedicated auxiliary control register (PTP_ACR at 0x40) while on
DWMAC1000, this is controled through the PTP Timestamp Control Reg using
fields maked as reserved on DWMAC4.

Interrupts are also not handled the same way, as on dwmac1000 they are
cleared by reading the Auxiliary Status Reg, which simply doesn't exist
on dwmac4.

All of this means that with the current state of the code, auxiliary
timestamps simply don't work on dwmac1000.

Besides that, there are some limitations in the number of external
snapshot channels. It was also found that the PPS out configuration is
also not done the same way, but fixing PPS out isn't in the scope of
this series.

To address that hardware difference, we introduce dedicated
ptp_clock_info ops and parameters as well as dedicated hwtstamp_ops for
the dwmac100/dwmac1000. This allows simplifying the code for these
platforms, and avoids the introduction of other sets of stmmac internal
callbacks.

The naming for the non-dwmac1000 ops wasn't changed, so we have :
 - dwmac1000_ptp & stmmac_ptp
 - dwmac1000_ptp_clock_ops & stmmac_ptp_clock_ops

where the "stmmac_*" ops use the dwmac4-or-later behaviour.

I have converted dwmac100 along the way to these ops, however that's
hasn't been tested nor fully confirmed that this is correct, as I don't
have datasheets for devices that uses dwmac100.

I've converted dwmac100 just on the hypothesis that the GMAC3_X PTP offset
being used in both dwmac1000 and dwmac100 means that they share these same
register layouts as well.

Patch 1 prepares the use of per-hw interface ptp_clock_info by avoiding
the modification of the global parameters. This allows making the
stmmac_ptp_clock_ops const.

Patch 2 adds the ptp_clock_info as an hwif parameter.

Patch 3 addresses the autodiscovery of the timestamping features, as
dwmac1000 doesn't provide these parameters

Patch 4 introduces the ptp_clock_info specific to dwmac1000 platforms,
and Patch 5 the hwtstamping info.

Patch 6 enables the timestamping interrupt for external snapshot

Patch 7 removes a non-necessary include from stmmac_ptp.c.

This was tested on dwmac_socfpga, however this wasn't tested on a
dwmac4-based platform.

[1]: https://lore.kernel.org/netdev/20230616100409.164583-1-alexis.lothore@bootlin.com/

Thanks Alexis for laying the groundwork for this,

Best regards,

Maxime

Maxime Chevallier (7):
  net: stmmac: Don't modify the global ptp ops directly
  net: stmmac: Use per-hw ptp clock ops
  net: stmmac: Only update the auto-discovered PTP clock features
  net: stmmac: Introduce dwmac1000 ptp_clock_info and operations
  net: stmmac: Introduce dwmac1000 timestamping operations
  net: stmmac: Enable timestamping interrupt on dwmac1000
  net: stmmac: Don't include dwmac4 definitions in stmmac_ptp

 drivers/net/ethernet/stmicro/stmmac/common.h  |  4 +
 .../net/ethernet/stmicro/stmmac/dwmac1000.h   | 15 +++-
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  | 85 +++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/hwif.c    | 14 ++-
 .../ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 11 +++
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 38 +++++++--
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.h  | 10 +++
 7 files changed, 165 insertions(+), 12 deletions(-)

-- 
2.47.0


