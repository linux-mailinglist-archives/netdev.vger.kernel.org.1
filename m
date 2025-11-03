Return-Path: <netdev+bounces-235148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B7AC2CB73
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 16:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86C13BF288
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 15:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5B3319845;
	Mon,  3 Nov 2025 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Grc8S/mP"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FE430C610
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182624; cv=none; b=kxHZJFiW4SZlGYAPjH7P2MGnsP5X2+xLqiVYoYJw/FxGkREQ37AxROnYt1l1PAVxf8/BYU6pb3IoerJHpMY+J5p0xu3kaWfKlMdaUj8eR8aZ6d+99jEHF9LTtPbofvoLupU/UdKb+aJsSn88zOG9Vxr/aqEdASUd0J9jELb/O4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182624; c=relaxed/simple;
	bh=1+HR+uyX2c6BnO5Xdy7ynJ5LcZS7WDt5sMz0zU+chvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KjdCLTLM/dzHeDm1oQTl1rDHFMzyuoxJJQxRosjcbNgBrJ2vgFW1eNOWyhBJUZVJOXhMfLOIu4P8HQT3+tqyLF1EZeJ5gtttZP9Psb7ekTJ68TbDI3pw39DYQK0kKWAQSmUAZmkB5xel4smmpavK9lKBJtc7Hwg60EePOB5Wzmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Grc8S/mP; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762182619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ijlTAHCPm96ALlj8X4uVVG+e1GRe0utTeH8fkvrs9R4=;
	b=Grc8S/mPFoo6wpRAYoRKJTL7DUbHAIXZxjkJ7xC3OFUXcplja4ZFzoE7QtIRIDJTmYm5eD
	YFQNVluRKo9KLWxZRWW2+bcnvM5/vj6yXKvbkAWK1soSfjYH6mu2ArFNVcCRO8ErNC3+Ls
	ozLuNki345RKzK6wZLfX/7JT7E05eno=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Manish Chopra <manishc@marvell.com>,
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
Subject: [PATCH net-next v2 0/7] convert drivers to use ndo_hwtstamp callbacks part 3
Date: Mon,  3 Nov 2025 15:09:45 +0000
Message-ID: <20251103150952.3538205-1-vadim.fedorenko@linux.dev>
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

v1 -> v2:
- avoid changing logic in phc_gbe driver for HWTSTAMP_FILTER_PTP_V1_L4_SYNC
  case
- nit fixing in patch 4 wording
- collect review tags

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
 .../ethernet/oki-semi/pch_gbe/pch_gbe_main.c  | 38 +++++++-----
 drivers/net/ethernet/qlogic/qede/qede_main.c  | 22 +------
 drivers/net/ethernet/qlogic/qede/qede_ptp.c   | 47 +++++++++-----
 drivers/net/ethernet/qlogic/qede/qede_ptp.h   |  6 +-
 9 files changed, 190 insertions(+), 181 deletions(-)

-- 
2.47.3

