Return-Path: <netdev+bounces-242408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1ADC902D1
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 22:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 157A5351204
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 21:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7F5305E28;
	Thu, 27 Nov 2025 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oyVDb8wl"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7098D770FE
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 21:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764277990; cv=none; b=E21JesnDEmUOvuh2dT+wvIbYGGWDP+uqXSgYnpyF7KzZJM4rC5lofM+A/IvaURr8s20zaStOQ3r+CKgiSsMG/bL3zwSzsqFcN6+lZ7i//0aAwPtIPULSKpgFaykBZzqGbsvCXuuqIE9s5Ot2z7rqChLsFVoXQ0WrgRl9zshW2xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764277990; c=relaxed/simple;
	bh=ULewXSfeHOTFb+kLZW23Zz6sq7Rd86svbsekPJv23U0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nvf6gBFiaGFs8LB2ZjbnE20ieho+IZZbaxGrcXHkWnvgqoJX+GSliWLX7u6amKD2MkITxcMeotBkHYM6tT/qsB2eICFlnK3JYKtwtjCJ8pNDWub8qCvHZIdJU2fiVgypuoB7hAtYJwa6zPB0tSeYmio/f6ws0jwlJxLHP6KRGK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oyVDb8wl; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764277984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e+P4rOlZO6Z5FkAudzY5hA0X2HBP0apTZxRyLFrtTS4=;
	b=oyVDb8wlkN8uxPoc6Tx+7NBIj7u1uXGAlluLfgqiL5/WQULx3Sn1+t9EA9eY4iqnMkT7QD
	Q40wiBBziykm1XirXt2TB1olHjTPRRT3fSi3c2d9OSd8PAI4Yh20bPh73JBEvMz5W+fUS9
	wL47wqQ6B8ZsZRGru8527V6xnaox3wc=
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
Subject: [PATCH net-next 0/4] support for hwtstamp_get in phy - part 2
Date: Thu, 27 Nov 2025 21:12:41 +0000
Message-ID: <20251127211245.279737-1-vadim.fedorenko@linux.dev>
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

Vadim Fedorenko (4):
  net: phy: micrel: improve HW timestamping config logic
  net: phy: micrel: add HW timestamp configuration reporting
  net: phy: microchip_rds_ptp: improve HW ts config logic
  net: phy: microchip_rds_ptp: add HW timestamp configuration reporting

 drivers/net/phy/micrel.c            | 33 ++++++++++++++++++++++++++---
 drivers/net/phy/microchip_rds_ptp.c | 25 +++++++++++++++++-----
 2 files changed, 50 insertions(+), 8 deletions(-)

-- 
2.47.3


