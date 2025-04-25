Return-Path: <netdev+bounces-185928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196A2A9C290
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 10:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ABBE9215AB
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 08:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99C7235C01;
	Fri, 25 Apr 2025 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgntEEmk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CC72356DA;
	Fri, 25 Apr 2025 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571473; cv=none; b=KzcBMsg7P1xbMk0xdIouOfg8zzpDqXm4kW2QW7vPfsY2oapS971fcN8zjPuhuLDwHxNYjgrB1boFrb9g/BPMQtyDjetm5KFPLWD+dNg4P+sFG6z4JUbUbG27x8VZ2E/2RhzqzADFcU6E52s9TO0X5Lw7N+jB/VCFWJtRGyig9aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571473; c=relaxed/simple;
	bh=SEMgzMn37zNgwDTilpI6l6F226AcCY0igc/LqqVT8B8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nJg82OTwuwZLW2LSdlTMMWIuvG8Tx8bVykSAX6hiRZf+4XqwI0JNJVzIl26cp6Zg+Naffd3ruI6nAD2e21OysUiHBn238AUIfUWTOPsBLWDIMO8lb63bGLYSAzp7HIZ69FDNKMBUkzA6t3eLYovqGzUWSaS3o5SAvBF24V72hC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgntEEmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C630C4CEE4;
	Fri, 25 Apr 2025 08:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745571473;
	bh=SEMgzMn37zNgwDTilpI6l6F226AcCY0igc/LqqVT8B8=;
	h=From:To:Cc:Subject:Date:From;
	b=TgntEEmkOE0f9Gz3cIAv2HmvxIvjnoHLlmmga4WEYlLMYki8EMBwFBGkCTCww9ZrR
	 MQZSRTWvULMXvvTG+VVKlpvHKaiYHTaJfk7GKrydhk1ptGVk994fSGvkeD9x7E2/G5
	 5L4CchERkjeC5mW1xYnv9lOeK/m4pOFyNsB7MMNLLHJlttVapdZVZSPBjMpXYIDxtu
	 8abDeZkxln7pQey+52lQb+tI0Sjy5ysO3lt2lkDoFZMgNuFnFthMaosVHOEqmYQzY7
	 l0Ire9TOwhBHfo44Gw8p+zTlguDQIOcfh3niR8q3V25PBnKShuzB5mxpRtU1uEIuD7
	 m7x2kdQLgvppA==
From: Philipp Stanner <phasta@kernel.org>
To: Sunil Goutham <sgoutham@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	Daniele Venzano <venza@brownhat.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Stanner <phasta@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org
Subject: [PATCH v2 0/8] Phase out hybrid PCI devres API
Date: Fri, 25 Apr 2025 10:57:33 +0200
Message-ID: <20250425085740.65304-2-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
  - Rename error path. (Jakub)
  - Apply some RBs

Fixes a number of minor issues with the usage of the PCI API in net.
Notbaly, it replaces calls to the sometimes-managed
pci_request_regions() to the always-managed pcim_request_all_regions(),
enabling us to remove that hybrid functionality from PCI.
Philipp Stanner (8):
  net: prestera: Use pure PCI devres API
  net: octeontx2: Use pure PCI devres API
  net: tulip: Use pure PCI devres API
  net: ethernet: natsemi: Use pure PCI devres API
  net: ethernet: sis900: Use pure PCI devres API
  net: mdio: thunder: Use pure PCI devres API
  net: thunder_bgx: Use pure PCI devres API
  net: thunder_bgx: Don't disable PCI device manually

 drivers/net/ethernet/cavium/thunder/thunder_bgx.c  | 13 ++++---------
 drivers/net/ethernet/dec/tulip/tulip_core.c        |  2 +-
 drivers/net/ethernet/dec/tulip/winbond-840.c       |  2 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   | 14 ++++----------
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   | 14 ++++----------
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c   | 12 +++++-------
 .../net/ethernet/marvell/prestera/prestera_pci.c   |  6 ++----
 drivers/net/ethernet/natsemi/natsemi.c             |  2 +-
 drivers/net/ethernet/sis/sis900.c                  |  2 +-
 drivers/net/mdio/mdio-thunder.c                    | 10 +++-------
 10 files changed, 26 insertions(+), 51 deletions(-)

-- 
2.48.1


