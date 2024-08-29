Return-Path: <netdev+bounces-123393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 010B0964B4B
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 18:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07021F2740C
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA7F1B373F;
	Thu, 29 Aug 2024 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZahHLt/h"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37214DA14;
	Thu, 29 Aug 2024 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948144; cv=none; b=Wg6EI32ao/KFmkRgGaElK1kY3ZGKfBIQT7y1x1bQURzdT+trhc93WSNEywAKVKQFP9cRyTeFszh3MF/zpJuSZHjdIkOPslT/dUgev8Fq+QglxF+VNHErYBummDlrfHS/dOTzDyL3oCfAnLeiwHeIyoEmD8j1dz0mmIj2rA0wYV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948144; c=relaxed/simple;
	bh=pTJTFLkZ/wOEPuTqhzDl8nZhAhxcw1doqzncVaQUYis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OtnB93te3itJBCl3iyJGGeNlvglAkqv5HCjgrbBBN3XxBsqZ8jGyMG5WM/HK8NVL7ktVi8yP6HJulmDQqPt4A5oJxgAd3XTX84pFlGel5TDwCqcluEYudOsK9wEZzNd8+TONQB5kkW8Ab8785hSeldIAAr4yYWnhRn+WvehhFM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZahHLt/h; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 24B5EE0007;
	Thu, 29 Aug 2024 16:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724948134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fAR7srL4v3bw18EUN9RLJmZwLTb+oDsz1Nnj3gW1ymc=;
	b=ZahHLt/hMMvB70eolNrnzQfCt60xp/OVIN+BPDRNyq56Fu9cIeA5JHT7KnwsBalT7zHkTC
	qlDFyue9rT9Qz52/2LFduHvbjQ0lsK83GWHy6OiqGJnngjRLAzMAuvTVDRfs6iVBpItlC1
	lOVLOLp+H2ZfJkrWvjc8/UIPK3sif9fj2e0ORwfZtsKCwQY1kpBlay5RzzOld4mK6azHYs
	RhQHvX+PtHtlXA/bGAnAij8NCwc5qkDL0aeohgm1KLCUP4nNJwr9WzxzIOKnE0MjmNF+A/
	GXCc6AgzqxPFGBTPzrUEYi+DzJjSGPKbq8UfsZC0DXza1oikCOg3plIjrbAGfw==
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
	Simon Horman <horms@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next v2 0/7] net: ethernet: fs_enet: Cleanup and phylink conversion
Date: Thu, 29 Aug 2024 18:15:23 +0200
Message-ID: <20240829161531.610874-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi everyone,

This is V2 of the fs_enet cleanup and phylink conversion series. The
main difference from V1 is the introduction of patch 6, that uses
devm_get_clk_enabled to manage the register clock, a cleanup of the
probe error sequence, and the removal of the netif_running checks.

I also gathered Christophe's reviews and Acks (except on patch 6 that is
new).

This series is made of some cosmetic and cleanup patches to FS enet, the
last patch converts it to phylink for the PHY handling.

Link to V1: https://lore.kernel.org/netdev/20240828095103.132625-1-maxime.chevallier@bootlin.com/

Thanks,

Maxime

Maxime Chevallier (7):
  net: ethernet: fs_enet: convert to SPDX
  net: ethernet: fs_enet: cosmetic cleanups
  net: ethernet: fs_enet: drop the .adjust_link custom fs_ops
  net: ethernet: fs_enet: drop unused phy_info and mii_if_info
  net: ethernet: fs_enet: fcc: use macros for speed and duplex values
  net: ethernet: fs_enet: simplify clock handling with devm accessors
  net: ethernet: fs_enet: phylink conversion

 .../net/ethernet/freescale/fs_enet/Kconfig    |   2 +-
 .../ethernet/freescale/fs_enet/fs_enet-main.c | 434 ++++++++----------
 .../net/ethernet/freescale/fs_enet/fs_enet.h  |  26 +-
 .../net/ethernet/freescale/fs_enet/mac-fcc.c  |  16 +-
 .../net/ethernet/freescale/fs_enet/mac-fec.c  |  14 +-
 .../net/ethernet/freescale/fs_enet/mac-scc.c  |  10 +-
 .../ethernet/freescale/fs_enet/mii-bitbang.c  |   5 +-
 .../net/ethernet/freescale/fs_enet/mii-fec.c  |   5 +-
 8 files changed, 210 insertions(+), 302 deletions(-)

-- 
2.45.2


