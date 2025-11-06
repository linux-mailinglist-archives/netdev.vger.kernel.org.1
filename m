Return-Path: <netdev+bounces-236516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8F5C3D844
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 22:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 943B24E0EC9
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 21:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E613019B7;
	Thu,  6 Nov 2025 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V5ptA+lv"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8C3301702
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 21:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762465059; cv=none; b=jDwjj2R19Ze+XkdjSLP7+hRXFHx6NZNz4OKolBFskxfyoG9gDEKHgKrQpt9j90g/ugRWKxYzrKxjUtKncNYnvCj/c9zx7VZH1S4Z6ZcRXOJ0RHHb1zw/GQHP1XTOELG9cCTH7uYk9fKSd34mFBq6xepo02q9N9GKL3SxvOoocw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762465059; c=relaxed/simple;
	bh=wFZWw5BIN5id6L8ESlneA1pGQsxsjWHdRGQ81ASQ754=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eFan50/BE1pG1y3GOCtRqVoSBiXejeMNOQJy0HmtRxA+ykO8tRmYjuJDv795EQT7iyIj5KWO+Sl/TrRq5t+YkedAorlY9dHPJhOEK+XBYkYUfHaX0uHFvMI3992ESFt+4YGMv9off3aVLFbYplC36dF+y/EgarowreRHcAt5ImE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V5ptA+lv; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762465055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z9gyKzGxvGijUyngwteUNy+Sdowba3U6KGXQvvYXMmc=;
	b=V5ptA+lvlJYkPBBOR/4IcFHlGY4pfdOZZbNrcWr+lmlfqwdSI8f5okDE6JvMDf0Cx5IRew
	wYsrd0B/YIboK0M8FOFjQ9Jzrf+TZ7RFb8lOdhwATJbnewwE/b90DaS3oHzGoejKMx9dM4
	jIn1bGap6PXbEnpQ+AasFZxOPJXanRI=
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
Subject: [PATCH net-next v2 0/2] convert drivers to use ndo_hwtstamp callbacks part 4
Date: Thu,  6 Nov 2025 21:37:15 +0000
Message-ID: <20251106213717.3543174-1-vadim.fedorenko@linux.dev>
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

Vadim Fedorenko (2):
  bnx2x: convert to use ndo_hwtstamp callbacks
  qede: convert to use ndo_hwtstamp callbacks

 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 73 ++++++++++++-------
 drivers/net/ethernet/qlogic/qede/qede_main.c  | 22 +-----
 drivers/net/ethernet/qlogic/qede/qede_ptp.c   | 69 ++++++++++--------
 drivers/net/ethernet/qlogic/qede/qede_ptp.h   |  6 +-
 4 files changed, 93 insertions(+), 77 deletions(-)

-- 
2.47.3

