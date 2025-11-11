Return-Path: <netdev+bounces-237681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D34BDC4EC34
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 16:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E39D1885C2C
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 15:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC8E363C73;
	Tue, 11 Nov 2025 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Js86nIKE"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837AA2FD7B1
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874360; cv=none; b=giWastvo6N8a8MBnYBUYr0lzNQBQ7FYcSar6qZXocnMy5Ma4mWniR3KFAyhH/gmA+/7l7tGbj6aJ2mt6mdagWWoxEXAw3PpfyUs/PIQdgg8udKafeUjAjAvsNo3kCKPdIX4EYiJ6ZDNH4NHFv9+h3hOSGzCrVeiQsXqMURSf510=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874360; c=relaxed/simple;
	bh=4HODVEaKMyCiHMBqajSwxh65SA7uYAJHrKrdE9kXyBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EJaiVOkZqqkALRmJF4QwvFovYNKmhOpLF1YeGFoeRldi8V8kKQQJ7sZr5vYY6+TgZftbQBOHCq69CLJeiktknD0UFzxx2UYy6uvboF72uhKV5PMaPIfstQwSmEHCTQRznlOam7PNcTbLmE0j00nqC0f1Dz/sPyDc8lXLa10H37w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Js86nIKE; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762874355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MSpG5nfJeLyvktQ4zVQr/UuCYez8rhd3QhFZsBfIKhk=;
	b=Js86nIKEap18zf53G8zriFU+nPZW6SfPpoVbthdnAs9NU+fDM177eEXkc66ekn50+V30Am
	c6RqIAR5jQzPWHN1x+96Cm2nruu6afv94xDLP1vdzaFyLNfCgmbInaP6WK7fwJDgnDv04Z
	m/HCWQQF8cQf1eraJl3xrvmwqG8UJDI=
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
Subject: [PATCH net-next v3 0/2] convert drivers to use ndo_hwtstamp callbacks part 4
Date: Tue, 11 Nov 2025 15:18:58 +0000
Message-ID: <20251111151900.1826871-1-vadim.fedorenko@linux.dev>
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

v1 -> v2:
- remove unused variable in qede patch
v2 -> v3:
- keep bnx2x driver's logic as is. Improvements will be sent as
  follow-ups

Vadim Fedorenko (2):
  bnx2x: convert to use ndo_hwtstamp callbacks
  qede: convert to use ndo_hwtstamp callbacks

 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 68 +++++++++++-------
 drivers/net/ethernet/qlogic/qede/qede_main.c  | 22 +-----
 drivers/net/ethernet/qlogic/qede/qede_ptp.c   | 69 +++++++++++--------
 drivers/net/ethernet/qlogic/qede/qede_ptp.h   |  6 +-
 4 files changed, 92 insertions(+), 73 deletions(-)

-- 
2.47.3

