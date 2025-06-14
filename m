Return-Path: <netdev+bounces-197801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4F9AD9E9C
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 20:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7790A176FE5
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 18:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CD718DB29;
	Sat, 14 Jun 2025 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwOxQR+A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E5B2E11DD;
	Sat, 14 Jun 2025 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749924407; cv=none; b=TBGZpsgqoqgHz5JhwGeLP/+o5p2dPAEe7vxn1rqiYz7LHCtQkY8hE1tnIxWmnXBXfrv+lroH4kg2dNCeKaSa/KZ1BKjGtIe+144435qm0MeNeIWWGDcppG+gmhnreaTtfworMCsr2x6CHyXdOn9wH8Vt8otTnRlFjQfkL1Fofj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749924407; c=relaxed/simple;
	bh=GQe3vrfC6orrT6DPM2+0wXCjddXUPwNZeSP449cMQjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ijKgtZ7YhbNtyECNJ4RBWzegFZiuRSd92s1PxPBjVEbF7E5WWU3KoR8HaDDeG+wk5ENnS46oucTyv+y4xSwFvGUJBE069nZN5pZ6RtPWlaVE0i6clyB0HGW1Df6puSvH7VbkIX4xn2JjdmWpYlpPArCfDP3azKbF0BXARnGxhRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwOxQR+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC023C4CEEB;
	Sat, 14 Jun 2025 18:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749924406;
	bh=GQe3vrfC6orrT6DPM2+0wXCjddXUPwNZeSP449cMQjY=;
	h=From:To:Cc:Subject:Date:From;
	b=hwOxQR+AQG8u5Qe+MZFTSPi2G11vCDnrmTUTIJPYrNtd9aE3zo1g4nAFcPJI68SDJ
	 fRbVvexSpKM+Epotztw//YSyVFXjwfXnfzf2Qnrp/aUQtg/ONDQuHAoppPxe0bszg9
	 pu5+UxjuZzhFJEDLKB1b2LrDZs0ZAOIZ9fc2zrbPaNGOdd9YPDmkrwavFbblZPlsGl
	 iabQRIC5Jvwkv7+8kbD3ZS3EjKsBO+W59tWK2x//FPLuQV7PGjNfj+OnjtRlqyiWFV
	 7tsT9feTe4tGLo89tvzutaTyI+p3ENpa7gEPB5O6fsT1ErElvjIPEvBWfBjytmEpTs
	 451CYGxPEI12g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bharat@chelsio.com,
	benve@cisco.com,
	satishkh@cisco.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	wei.fang@nxp.com,
	xiaoning.wang@nxp.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	bryan.whitehead@microchip.com,
	ecree.xilinx@gmail.com,
	rosenp@gmail.com,
	imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/5] eth: migrate to new RXFH callbacks (get-only drivers)
Date: Sat, 14 Jun 2025 11:06:33 -0700
Message-ID: <20250614180638.4166766-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate the drivers which only implement ETHTOOL_GRXFH to
the recently added dedicated .get_rxfh_fields ethtool callback.

v2:
 - fix enetc
 - move the sfc falcon patch to later series in case I need to refactor
v1: https://lore.kernel.org/20250613005409.3544529-1-kuba@kernel.org

Jakub Kicinski (5):
  eth: cisco: migrate to new RXFH callbacks
  eth: cxgb4: migrate to new RXFH callbacks
  eth: lan743x: migrate to new RXFH callbacks
  eth: e1000e: migrate to new RXFH callbacks
  eth: enetc: migrate to new RXFH callbacks

 .../ethernet/chelsio/cxgb4/cxgb4_ethtool.c    | 105 +++++++++---------
 .../net/ethernet/cisco/enic/enic_ethtool.c    |   8 +-
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  11 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c   |  77 ++++++-------
 .../net/ethernet/microchip/lan743x_ethtool.c  |  31 ++++--
 5 files changed, 118 insertions(+), 114 deletions(-)

-- 
2.49.0


