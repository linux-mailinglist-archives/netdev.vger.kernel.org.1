Return-Path: <netdev+bounces-234532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6976FC22CFA
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 01:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3473B8178
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 00:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D680170A37;
	Fri, 31 Oct 2025 00:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y0Q2Wgia"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6752AD13
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 00:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761871588; cv=none; b=VjfXuAx/mR309BGkYVunSMPs3rzQVe+buPfg2zI+W+HdprpfhZslCebdwvFgJ9I016PtsG3aZVNtAr+mUjn2TeLhx5CO3cIRy2S0TRJZX/qk6744uigkha7kQOtaX8MEthnYZE/lm1vXTpIj0ZvYSPQxmVK/tU7fCDxRROgHRss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761871588; c=relaxed/simple;
	bh=omgPPChYsPLF76LKT9QxPTW4WfpM3kWJ1y0NHZ1ZdB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DPHaKMsylO2juANbiwvN85ZAddmm6nPDV9HG6uOw1sBviNEwvMlIt6/2vDrCwlNHMsLksumGVoFl4458ecDOySQS9J9ePBSFW2NUPiu/9k7qSvPM/lomlYBLm1QInxmYHRw24jjjjgCdAvjpz4hedkrOKPUh6ypvzYTF3leY7Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y0Q2Wgia; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761871583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m8YGS2ySmkbY6H6MGCzUlZeNWLAE5gNYIvcEQl4fPK8=;
	b=Y0Q2WgiaKvxjefukVyBjSu/seielsrFiL2apyzJflIYdClgfF2T/NMsD6xwE68wueW1P4j
	R6X9HkCvazs/k0Hk5T6Ds3UsRPBQfn35GK/NeWHnqVUD7eca8jkTgUXyXbSr/nOENzCmP8
	Q7U1yUarEPOWXL919ypsaaNs9KUSEtE=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/7] convert drivers to use ndo_hwtstamp callbacks part 3
Date: Fri, 31 Oct 2025 00:46:00 +0000
Message-ID: <20251031004607.1983544-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patchset converts the rest of ethernet drivers to use ndo callbacks
instead ioctl to configure and report time stamping. The drivers in part
3 originally implemented only SIOCSHWTSTAMP command, but converted to
also provide configuration back to users.

Vadim Fedorenko (7):
  bnx2x: convert to use ndo_hwtstamp callbacks
  net: liquidio: convert to use ndo_hwtstamp callbacks
  net: liquidio_vf: convert to use ndo_hwtstamp callbacks
  net: octeon: mgmt: convert to use ndo_hwtstamp callbacks
  net: thunderx: convert to use ndo_hwtstamp callbacks
  net: pch_gbe: convert to use ndo_hwtstamp callbacks
  qede: convert to use ndo_hwtstamp callbacks

 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 53 +++++++++-------
 .../net/ethernet/cavium/liquidio/lio_main.c   | 50 ++++++---------
 .../ethernet/cavium/liquidio/lio_vf_main.c    | 48 ++++++--------
 .../net/ethernet/cavium/octeon/octeon_mgmt.c  | 62 ++++++++++---------
 .../net/ethernet/cavium/thunder/nicvf_main.c  | 45 ++++++++------
 .../ethernet/oki-semi/pch_gbe/pch_gbe_main.c  | 40 +++++++-----
 drivers/net/ethernet/qlogic/qede/qede_main.c  | 22 +------
 drivers/net/ethernet/qlogic/qede/qede_ptp.c   | 47 +++++++++-----
 drivers/net/ethernet/qlogic/qede/qede_ptp.h   |  6 +-
 9 files changed, 191 insertions(+), 182 deletions(-)

-- 
2.47.3


