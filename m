Return-Path: <netdev+bounces-242742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0AFC94769
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 20:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 598304E2F03
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 19:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE6930FC21;
	Sat, 29 Nov 2025 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E7dSR+Af"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAF0262FED
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764446051; cv=none; b=LgnQBp0qaEi1oi7HyPeTK9+VhX8aL/kCe7Snzbb76Wr7Tcjw6cxTB6B6XeuEKTkxSorDw1t7+87dZN9npHg7urmi+iIZmV8wVOYJizIxqOg+ZcBRvUw4QLKgt5AhUH5DSPe86aq4MDhnVmnLbrUpHwpY8hruJrjmijFfW2k+Wsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764446051; c=relaxed/simple;
	bh=RnsyQk1wAhESAL9NZ6r7tQkFmlyPQfNHc0+oJKGgHHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LpX4sruEm2fBJkcLfHAFg9Shr0C/po4EsumrzUxJKD85Dtw25A8R1PbIR3TWIw0FnZxSSwTZMzVapLqzDphFl0qBUlqZKruj8DUlu3vOlwVS7ST+eesPuecaYzjEwieiaqw9XWgFBDAb528JLCGMPxjsUnjfrCeWFzNtVc/aBJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E7dSR+Af; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764446042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=co0b32nW5KE2GchwbO7OZkvJYPLPhNkU8cwwV1mqcBg=;
	b=E7dSR+AfoIXHP/qHW8PxKl3jcFEFYrMq/LHzUqhcP4DId8LeBzy21C+uWUlfKfRXirdjct
	+6g9+b/qLHifNnmIyZGIUoSDwkYNbbfltBl2ZVGSMYZtQJU9TijKQsdySEOfPqkYWomyJq
	BuiCS5X8X1J7JZgj0imADFsgoYQJjO8=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v2 0/4] support for hwtstamp_get in phy - part 2
Date: Sat, 29 Nov 2025 19:53:30 +0000
Message-ID: <20251129195334.985464-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There are 2 drivers which had some inconsistency in HW timestamping
configuration logic. Improve both of them and add hwtstamp_get()
callback.

v1 -> v2:
* add checks and return error in case of unsupported TX tiemstamps
* get function for lan8814 and lan8841 are the same - keep only one

Vadim Fedorenko (4):
  net: phy: micrel: improve HW timestamping config logic
  net: phy: micrel: add HW timestamp configuration reporting
  net: phy: microchip_rds_ptp: improve HW ts config logic
  net: phy: microchip_rds_ptp: add HW timestamp configuration reporting

 drivers/net/phy/micrel.c            | 35 ++++++++++++++++++++++++-----
 drivers/net/phy/microchip_rds_ptp.c | 34 +++++++++++++++++++++++-----
 2 files changed, 58 insertions(+), 11 deletions(-)

-- 
2.47.3


