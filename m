Return-Path: <netdev+bounces-225331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 225FFB92540
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25959188A90C
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705352D780A;
	Mon, 22 Sep 2025 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OlpXnVBK"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F443312826
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758560424; cv=none; b=gBFG/KH6ksyQIs300JdZvRfNk2H5LJDWRhPNWZvcrKkJ/NNDEzCYwUJH1i4PjVA//MiZXsB/vTkza81ybWJD3eaxudYT2ogSxmRc5Q82fGhrd1jZUwTW/0miDOebtA/1H2tdDZC8pqcjF2xgZjyWbLwq+O6wDEEDhipbufdSkQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758560424; c=relaxed/simple;
	bh=qZVBiIrfQZyUYbQRabvbo+mDaBlfpGJRHHIXvsBFvsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bARlCrhJx6/GW+L9YvaL8vPkFz2Z/osIhkxjP0r0UWUeFr6culZn1o/EEBGMwSWGAkHVWLFC9jmjz5KklD2J/Kme70sjArnTjd9OdmHiX0wYcAzkcNbdIFxsXNllcTWcNpC5sYE/sy8w4+GlbiNj2TKZMDO9WOgGjpwPj9e5cNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OlpXnVBK; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758560419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KonR8Va3M6+8JMJnQYJWvowsLvZQ1ZBzlJWjy35IOks=;
	b=OlpXnVBKRwq5okgvkXoE2+SFLOdN2ktF95U0FVr5xRLMpKQeBapj5b0yHHQiiF3FxTaMl0
	HPbK3YaZzxPwQMCn/FHdMZMJmHG4XMSICg8RUmwTsB93utktixh4Iapw//g56wm2IeV0rV
	XgZuFaJsvLV/xgdlU/FFR2+YphrgmVA=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next 0/4] convert 3 drivers to ndo_hwtstamp API
Date: Mon, 22 Sep 2025 16:51:14 +0000
Message-ID: <20250922165118.10057-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Convert tg3, bnxt_en and mlx5 to use ndo_hwtstamp API. These 3 drivers
were chosen because I have access to the HW and is able to test the
changes. Also there is a selftest provided to validated that the driver
correctly sets up timestamp configuration, according to what is exposed
as supported by the hardware. Selftest allows driver to fallback to some
wider scope of RX timestamping, i.e. it allows the driver to set up
ptpv2-event filter when ptpv2-l2-event is requested.

Vadim Fedorenko (4):
  tg3: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
  bnxt_en: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
  mlx5: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
  selftests: drv-net: add HW timestamping tests

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  8 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 35 ++++-----
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h |  7 +-
 drivers/net/ethernet/broadcom/tg3.c           | 66 +++++++---------
 drivers/net/ethernet/mellanox/mlx5/core/en.h  | 13 ++--
 .../net/ethernet/mellanox/mlx5/core/en/ptp.h  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/trap.h |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 47 +++++-------
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  2 +-
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.c | 17 +----
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.h |  1 -
 .../mellanox/mlx5/core/ipoib/ipoib_vlan.c     |  9 +--
 .../ethernet/mellanox/mlx5/core/lib/clock.h   | 14 ++--
 .../selftests/drivers/net/hw/nic_timestamp.py | 75 +++++++++++++++++++
 15 files changed, 167 insertions(+), 133 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/nic_timestamp.py

-- 
2.47.3


