Return-Path: <netdev+bounces-197264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A628AD7FCE
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 02:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44413B68C6
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 00:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285AE1BFE00;
	Fri, 13 Jun 2025 00:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJs/tlbz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A0A191F8C;
	Fri, 13 Jun 2025 00:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749776085; cv=none; b=O3tq9S6cXKUxxiYFDTLCMaFpe6hkz+UPfnSB4Icfievoey95oo3p7tikQ2HNSFb7Nco9Sd86q/e9JX4az3qCSl45Bir73sMEjB51oiibExs+ATQOhGHM0gSfsV4gUHmIyor4hGiQAYO+p+DgNx/57e/zWwPI2U9XXWtpk34uB74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749776085; c=relaxed/simple;
	bh=miidOCgNftdZhEwsnB1znqJxT7McGoipeBLAxIdGNME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tVil1ZiHMnzpanuF9egTehzKVNU2KKuu7SGswVgPBB7XYcTihnlcJunG7HywlBp7yHQ/E8Q5JkbcJ7RkNwe+ybXpM4ei/h/YGu/uGH7fdCv5fgxGA7A1bNe5wc39vopJG3ZpNJRmdDy2G9TnzpDHFRQwI/yrR8xxaWFCEa7bw60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJs/tlbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951C9C4CEEA;
	Fri, 13 Jun 2025 00:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749776084;
	bh=miidOCgNftdZhEwsnB1znqJxT7McGoipeBLAxIdGNME=;
	h=From:To:Cc:Subject:Date:From;
	b=TJs/tlbz+hvIWLpeTL8b9c8ESSGj4MAUzINv7BqZdvllDr6UkbydMaCCMp4LkF3Sx
	 RIxiEPlm0bxjqyfOqqrQQ3WEEwhbBed1TymDBL0zWaotiD5Tv0wq/Yup+a9ycT0ofL
	 XnoRsQAPuv2OjQh8IBxa4W9zXsXyu5ahXoFNr8Ua0h8MuR0t29B93IqSNEPExmH9NZ
	 5AitKXeeI+NuRhCdR9Y7wyY9N3eN0+Jg3GgY6FpIeHxRSzmS0T3WKzQJolVYzeIukQ
	 zZnFtW4KuQQvg/GmKQvpBsUHkKgJyGdbLlljnomANPhoZ4lthO108RStwgGG5dsF8j
	 ALLo5ig2wSN7w==
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
Subject: [PATCH net-next 0/6] eth: migrate to new RXFH callbacks (get-only drivres)
Date: Thu, 12 Jun 2025 17:54:03 -0700
Message-ID: <20250613005409.3544529-1-kuba@kernel.org>
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

Jakub Kicinski (6):
  eth: cisco: migrate to new RXFH callbacks
  eth: cxgb4: migrate to new RXFH callbacks
  eth: lan743x: migrate to new RXFH callbacks
  eth: e1000e: migrate to new RXFH callbacks
  eth: enetc: migrate to new RXFH callbacks
  eth: sfc: falcon: migrate to new RXFH callbacks

 .../ethernet/chelsio/cxgb4/cxgb4_ethtool.c    | 105 +++++++++---------
 .../net/ethernet/cisco/enic/enic_ethtool.c    |   8 +-
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  10 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c   |  77 ++++++-------
 .../net/ethernet/microchip/lan743x_ethtool.c  |  31 ++++--
 drivers/net/ethernet/sfc/falcon/ethtool.c     |  51 +++++----
 6 files changed, 145 insertions(+), 137 deletions(-)

-- 
2.49.0


