Return-Path: <netdev+bounces-122697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEE39623EF
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 11:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF74B1C212F3
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 09:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44F0166F14;
	Wed, 28 Aug 2024 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UJQUHEN6"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72785156F4A;
	Wed, 28 Aug 2024 09:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838672; cv=none; b=EVWCCvLanBAmaEDo4puWKy+TApJG1jgPoTXy+6vkPitM0F6R9pc0/Kl5UTcj/iXxqTJAlhJy3JtEKBCU26PDkHzO66lZT1lTq2Yw+6vvr6UM+9smdtCulZV2sYH5qXQWKWd3Lp3ucbwgIGexWT8BxAbq8yfuytc5B4Q7JATcHB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838672; c=relaxed/simple;
	bh=W5dNiwh08spGQWHVtWR9qi5GSQL22gM2rJTVdfKL0sA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p1fKfAUt/+8iecD0yDPPnKis30YUbgVB3qTdZCOmEFKxVz/ZGiw94YQUiyZnA4Qt2xpPttSrtNrmANoaIdPzMM2LiCJokHgakpLYaThcTQZiFtDT0MhwvUzeD17ZUPfS8t6OJE+ded7L7bMhz47gR+Vi1YZE3+C/6XRXmvPhtF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UJQUHEN6; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A93E31C0006;
	Wed, 28 Aug 2024 09:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724838667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NMcd5krJpu4QF1dh3WskwIyNsu7j6t8kCT18xYrFnZ8=;
	b=UJQUHEN6WjzuygPF/gNH6m6xV66KuChGtnbdjHjNy/mO6EoX5nlf3A4CUz4i+QCGya7YsB
	PR2IICydmOpbTI9fTNk9wx5mM+3e0rMfOyySAan9GzJTPGi4ZziXlhw89MN/ET54A1zwnz
	YWsVUP27SRojnn1xoeGozJbz5fwgU8CoNX5inPgjGPUPY7ZVgd8VJhOqvQd9pKjqfqfhrF
	rsfdIuybAHLJXXYxKu+66BdJ39p/6JRnVTvgCbdCNlxoJW1GuJ3EGNJUBL6S08IhzdvnCZ
	makAnbdtqH0BfWWbA84V3k8oYErKeZpFHA3uaIddZ+PxlChvZXDkfWJlyQd2Iw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next 0/6] net: ethernet: fs_enet: Cleanup and phylink conversion
Date: Wed, 28 Aug 2024 11:50:56 +0200
Message-ID: <20240828095103.132625-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

This series aims at improving the fs_enet code and port it's PHY
handling from direct phylib access to using phylink instead.

Although this driver is quite old, there are still some users out there,
running an upstream kernel. The development I'm doing is on an MPC885
device, which uses fs_enet, as well as a MPC866-based device.

The main motivation for that work is to eventually support ethernet interfaces
that have more than one PHY attached to the MAC upstream, for which
phylink might be a pre-requisite. That work isn't submitted yet, and the
final solution might not even require phylink.

Regardless, I do believe that this series is relevant, as it does some
cleanup to the driver, and having it use phylink brings some nice
improvements as it simplifies the DT parsing, fixed-link handling and
removes code in that driver that predates even phylib itself.

The series is structured in the following way :

- Patches 1 and 2 are cosmetic changes. The former converts the source
  to SPDX, while the latter has fs_enet-main.c pass checkpatch. Patch 2 is
  really not mandatory in this series, and I understand that this isn't
  the easiest or most pleasant patch to review. OTOH, this allows
  getting a clean checkpatch output for the main part of the driver.

- Patches 3, 4 and 5 drop some leftovers from back when the driver didn't
  use phylib, and brings the use of phylib macros.

- Patch 6 is the actual phylink port, which also cleans the bits of code
  that become irrelevant when using phylink.

Testing was done on an MPC866 and MPC885, any test on other platforms
that use fs_enet are more than welcome.

Thanks,

Maxime

Maxime Chevallier (6):
  net: ethernet: fs_enet: convert to SPDX
  net: ethernet: fs_enet: cosmetic cleanups
  net: ethernet: fs_enet: drop the .adjust_link custom fs_ops
  net: ethernet: fs_enet: drop unused phy_info and mii_if_info
  net: ethernet: fs_enet: fcc: use macros for speed and duplex values
  net: ethernet: fs_enet: phylink conversion

 .../net/ethernet/freescale/fs_enet/Kconfig    |   2 +-
 .../ethernet/freescale/fs_enet/fs_enet-main.c | 421 ++++++++----------
 .../net/ethernet/freescale/fs_enet/fs_enet.h  |  24 +-
 .../net/ethernet/freescale/fs_enet/mac-fcc.c  |  16 +-
 .../net/ethernet/freescale/fs_enet/mac-fec.c  |  14 +-
 .../net/ethernet/freescale/fs_enet/mac-scc.c  |  10 +-
 .../ethernet/freescale/fs_enet/mii-bitbang.c  |   5 +-
 .../net/ethernet/freescale/fs_enet/mii-fec.c  |   5 +-
 8 files changed, 209 insertions(+), 288 deletions(-)

-- 
2.45.2


