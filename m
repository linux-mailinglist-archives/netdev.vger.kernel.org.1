Return-Path: <netdev+bounces-247387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 22206CF9436
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 17:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86621300D422
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 16:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF2522652D;
	Tue,  6 Jan 2026 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yck+PBC5"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBBB222585
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767715716; cv=none; b=o5l4pgY8txZivckowmb66jHmFJoidYjsqUGezFRVnaLG7cCmJ7mxZFXBMtyV+eomnJdcu5Dnj/LzwG8z9FQvtunXAHUUmP7u4fIhamb52gMlVqMhWQTy61PtVk5+pYS6L7AOU+qIoDa3ys4sa9kWshhNjw5zLVKkS19kdLk/31g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767715716; c=relaxed/simple;
	bh=WCk9/nrf1zZCRs6/RSTl5UQwr2ioagN6JdxPUCBA7kI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gg1rEeLn1O23NfipnAhEX7KDloiDOgeU1mG7RtAbTdsBGPkV1jKkNgOTTueLIWGc0Z87RY5c2EiS5eA6X2UAsqpQz3fQC3rJKzGOzqj0s+QNe+ORqMZc8nd0Ft1Lry2UyHkRf72GiNZP25IWLkaVzun1tSpwVdMbAGeCjP7nsHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yck+PBC5; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767715712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u9NSJvzDtxBozxV3hZEgmv72k15k774qAXVaSjhh6/A=;
	b=Yck+PBC5NWpAkYbo7i7yX1i90MATy5hEWaYXyeto8W3juZgPPSQcJHumR0IiUJRA8u/zkB
	DDDbkbFaV2UNFIm99FEomAc/uFcH1hlOB1wseEhFfGtHzbXV5BkFAe511k+0/8fRdpy4fV
	wx+EQxFElXWjoKkTzVLD24rJUrdL4tc=
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
Subject: [PATCH net-next v3 0/4] support for hwtstamp_get in phy - part 2
Date: Tue,  6 Jan 2026 16:07:19 +0000
Message-ID: <20260106160723.3925872-1-vadim.fedorenko@linux.dev>
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

v2 -> v3:
* fix the copy-paste check of rx_filter instead of tx_type
* add tx_type check for lan8841
link to v2: https://lore.kernel.org/netdev/f9919964-236c-4f2e-a7ec-9fe7969aaa55@linux.dev/
v1 -> v2:
* add checks and return error in case of unsupported TX tiemstamps
* get function for lan8814 and lan8841 are the same - keep only one

Vadim Fedorenko (4):
  net: phy: micrel: improve HW timestamping config logic
  net: phy: micrel: add HW timestamp configuration reporting
  net: phy: microchip_rds_ptp: improve HW ts config logic
  net: phy: microchip_rds_ptp: add HW timestamp configuration reporting

 drivers/net/phy/micrel.c            | 44 +++++++++++++++++++++++++----
 drivers/net/phy/microchip_rds_ptp.c | 34 ++++++++++++++++++----
 2 files changed, 67 insertions(+), 11 deletions(-)

-- 
2.47.3

