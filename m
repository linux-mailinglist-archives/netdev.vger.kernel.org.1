Return-Path: <netdev+bounces-225693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C427B970A2
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 19:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2E719C5FA9
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 17:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C325280A20;
	Tue, 23 Sep 2025 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hrdUArVX"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFA81FECD4
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648814; cv=none; b=fE022jqsEz8oXwov6M4427aCQjc+1GZc6REMe0mWrSeKym4AGd47rLTpgryGV7jGy0clPTGq8Rbq0p6KqKqDMk8HltE89cvyqzE9H5CiBIjZ2TZxk1JS77I5cxoJgLuUcgvYTcatk/gRL24FpkwnfVQ9wshJk3S/McuSlxUtS/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648814; c=relaxed/simple;
	bh=1lafzdToXKWtkfh3+yx2fSULR2sMa9KXlZB2uKgg5zg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NkmXYi/EAa03fhVIajYxBMySIbp7iRk1ToWQl1exgtI7D6s5GlrZzE7weYT1aIEVK3nYt7jXGsSx1cwcmOwqmTkKaQwAyT1JHczTW5ncs4GfU5/d8WtCDgxWLDw3b01XCJYc3xF88vzFBo60WXDWlqftcw3d34ht4FpTnlm73zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hrdUArVX; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758648807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w3bDuwO479nV/lsJ+uCyXIf9Mo95oonhrzT6/860Eps=;
	b=hrdUArVXj5Z32qWPX7asvlk+hDS26OU4cM0HQQUOHcwxIlo6axaeAxtoDuBno4mRwxKCBE
	RvfqzQSzqSSLA3bPnaP820iOg1QhUc1cc1P7+CDtF6TjBentPw+s6BkZ+qWnyRCXTlqO4e
	Mskcz/hiVq3mAehuYbXgLCLjmUa9A1A=
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
Subject: [PATCH net-next v2 0/4] convert 3 drivers to ndo_hwtstamp API
Date: Tue, 23 Sep 2025 17:33:06 +0000
Message-ID: <20250923173310.139623-1-vadim.fedorenko@linux.dev>
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

v1 -> v2:
 * fix selftest error path and linter issues
 * collect Rb tags from Pavan and Michael
Vadim Fedorenko (4):
  tg3: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
  bnxt_en: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
  mlx5: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
  selftests: drv-net: add HW timestamping tests

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   8 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c |  35 +++---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h |   7 +-
 drivers/net/ethernet/broadcom/tg3.c           |  66 +++++-----
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  13 +-
 .../net/ethernet/mellanox/mlx5/core/en/ptp.h  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/trap.h |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  47 +++-----
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   2 +-
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.c |  17 +--
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.h |   1 -
 .../mellanox/mlx5/core/ipoib/ipoib_vlan.c     |   9 +-
 .../ethernet/mellanox/mlx5/core/lib/clock.h   |  14 +--
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/nic_timestamp.py | 113 ++++++++++++++++++
 16 files changed, 206 insertions(+), 133 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/nic_timestamp.py

-- 
2.47.3


