Return-Path: <netdev+bounces-172234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E181A50F19
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 23:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575C5188520F
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 22:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5FA206F0D;
	Wed,  5 Mar 2025 22:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw0p+F5o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC9C1FC7FE
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 22:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215152; cv=none; b=oZ07fYiQkjWDXpFHMUyshj1cHnI2ixdkf3SwRHML8bImiUekyJmRZU+40Kb2Mw6KPf1QmO7WPJbyYqDKPMz5zciOvCiwM9qFcgQjvMdP9AmtAd+Wv7kWpSKE/SH1AeXMtiAmiyKgiK2sFNUrHd5YE/ENrvvLPIazGTrcgoBdJOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215152; c=relaxed/simple;
	bh=jgy9s7WDLsJDeNHEcz6cm24sjQSY+T2tUWyU4xkFVg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BYx4DfXbHrQpLOXxwKeeme8qsE4HkjL7bTE4sHC0nIk0B8eq3YtLggf84pHoMC9Ag+QBaxqF110706/h6MaZuPfwlUzTwFUkKyBOJyHyanYIziJkIiCMbeLc9AlmsXLXemPU1iDV413rul5RcT3ulWcBiD6pBDzxWCKOVjVPpng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw0p+F5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47F2C4CED1;
	Wed,  5 Mar 2025 22:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741215152;
	bh=jgy9s7WDLsJDeNHEcz6cm24sjQSY+T2tUWyU4xkFVg4=;
	h=From:To:Cc:Subject:Date:From;
	b=Bw0p+F5oU5ZOTF3I2H7WmGImiuZ5wE5O2oSvOJvtBIf6QKKwgRPV24zWfE7nSSV4W
	 dpMsqXqLAFf1E6DkIWugip9bH4rDSMBHJGFA1kNWp/MwShaVYOVprJmlDVXQUnLOwQ
	 h9DAeDZ9cQfnSUM7iTwXb1ZsOROqlwGzObMjhsBrfno4PgdcEGPcH/9iMKAaChVv28
	 bRXMnBw7ByPeslSZeDW0S9f5SJSWlAA6UcZSK9W+fyzzcVLy4GV3F39wrgDWI6ScDC
	 sCgZB0K62/Vcu4n1/atY2u7xxdSLvKqspGIMKNv9jI+zGP8EHbGF+2M9ndzSYDx4Mk
	 m8x6t5OBbNsfg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 00/10] eth: bnxt: maintain basic pkt/byte counters in SW
Date: Wed,  5 Mar 2025 14:52:05 -0800
Message-ID: <20250305225215.1567043-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some workloads want to be able to track bandwidth utilization on
the scale of 10s of msecs. bnxt uses HW stats and async stats
updates, with update frequency controlled via ethtool -C.
Updating all HW stats more often than 100 msec is both hard for
the device and consumes PCIe bandwidth. Switch to maintaining
basic Rx / Tx packet and byte counters in SW.

Tested with drivers/net/stats.py:
  # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0

Manually tested by comparing the ethtool -S stats (which continues
to show HW stats) with qstats, and total interface stats.
With and without HW-GRO, and with XDP on / off.
Stopping and starting the interface also doesn't corrupt the values.

v3:
 - try to include vlan tag and padding length in the stats
v2: https://lore.kernel.org/20250228012534.3460918-1-kuba@kernel.org
 - fix skipping XDP vs the XDP Tx ring handling (Michael)
 - rename the defines as well as the structs (Przemek)
 - fix counding frag'ed packets in XDP Tx
v1: https://lore.kernel.org/20250226211003.2790916-1-kuba@kernel.org

Jakub Kicinski (10):
  eth: bnxt: use napi_consume_skb()
  eth: bnxt: don't run xdp programs on fallback traffic
  eth: bnxt: rename ring_err_stats -> ring_drv_stats
  eth: bnxt: snapshot driver stats
  eth: bnxt: don't use ifdef to check for CONFIG_INET in GRO
  eth: bnxt: consolidate the GRO-but-not-really paths in bnxt_gro_skb()
  eth: bnxt: extract VLAN info early on
  eth: bnxt: maintain rx pkt/byte stats in SW
  eth: bnxt: maintain tx pkt/byte stats in SW
  eth: bnxt: count xdp xmit packets

 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  49 +++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |   5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 272 +++++++++++-------
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  20 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  47 ++-
 5 files changed, 264 insertions(+), 129 deletions(-)

-- 
2.48.1


