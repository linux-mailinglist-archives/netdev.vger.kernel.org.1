Return-Path: <netdev+bounces-235953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351DAC37661
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 19:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825671A233F4
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 18:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D35333F360;
	Wed,  5 Nov 2025 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Li8/EakS"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB28433C525
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762368723; cv=none; b=QELS4IYscYAIhqVQVhJsNSVhHILrCATxDvFOQPtHaH1+1t8TeiqOhtEh1HMszCfF3CbgvzWcWQWUK5gwRqlEJb0pnv24O5SJyj0NyanUy2gFduBKiFGvli/mQ02qlrbLHDtB4LeCBrZilbnvrU6ySyC/R16F/JdWQtufx/b0Np4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762368723; c=relaxed/simple;
	bh=BgYQs7EHWjlrCIxZuA2LCwtLaQiGn84N+pC1JR1rjsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZTVGeF8O5iNTV5D10atNHJh9X5ZIvDBZZTPl8Er+AfpbydM7dthBaOlZCHY9aNBbPALNuEVA/g8xmkfrW+hO14DpPNbW0EncID5FjFh8um87oCuTi8DHwcEayTTJyr213JqLFAMn++aXknYq46IKOzzKLwsSeqM1E+BRcAFsWWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Li8/EakS; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762368717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hLHH9p7zX+53DK4qhsowtjrHcvVHvFafD9i1g8WXivU=;
	b=Li8/EakSkxUBDL6kcctZoibHUWKG/b13R9xOVmPNYH/OykDlc4DcUcRH56VIP//m6DfcDz
	cMrQjQ7CYALHQsbLO9iQuyyCYWonxEOXV+in+3vH8vESA8yOSH2R23P5ii8sVTJml1cOi7
	YZ5QWNdyEICbcXxR/5JLQ4EwoXoaBjI=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/2] convert drivers to use ndo_hwtstamp callbacks part 4
Date: Wed,  5 Nov 2025 18:51:31 +0000
Message-ID: <20251105185133.3542054-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patchset is a subset of part 3 patchset to convert bnx2x and qede
drviers to use ndo callbacks instead ioctl to configure and report time
stamping. These drivers implemented only SIOCSHWTSTAMP command, but
converted to also provide configuration back to users. Some logic is
changed to avoid reporting configuration which is not in sync with the
HW in case of error happened.

Vadim Fedorenko (2):
  bnx2x: convert to use ndo_hwtstamp callbacks
  qede: convert to use ndo_hwtstamp callbacks

 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 73 ++++++++++++-------
 drivers/net/ethernet/qlogic/qede/qede_main.c  | 22 +-----
 drivers/net/ethernet/qlogic/qede/qede_ptp.c   | 68 ++++++++++-------
 drivers/net/ethernet/qlogic/qede/qede_ptp.h   |  6 +-
 4 files changed, 93 insertions(+), 76 deletions(-)

-- 
2.47.3

