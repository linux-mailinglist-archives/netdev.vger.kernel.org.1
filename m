Return-Path: <netdev+bounces-238931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF166C6122A
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 10:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 575FC35F48A
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 09:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC82248F62;
	Sun, 16 Nov 2025 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EAwQc0UT"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA57231C91
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763286396; cv=none; b=RaWptfmoY7Rqu9X7gKM+1p0Ce0ccyNq3ztMmqalwa0WMWmCLlMboaCrFZz8S758P4ec60Ati5ibKiZWkRq+0xaDkMI+6lS56BxdDIxBeo+UNL7+aSSS/BHNWJQfrFdvWjP070exRuQDzz49CM0Z1vih0O4NQ2ZMzhQ5BhIVEz9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763286396; c=relaxed/simple;
	bh=x9hR9SjyCtIHLxgT9NqWko3gLVtNUDrKhW+nxCbwkLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tpuvx3i4Q05tZz9zcfFRWmFKsLgW2MLZ++piICkUSvsYrO3km3mQVUuqrDYcI0X4u3VuB6G5xN3jZ0ns6L4BpLeWlnsDnJK+ZiiqxBKd6Z4JZGKK7Rfpktc8Uj3NonxGvAgnJ8k8m3Hl+wAwzOYlKtcPB5j/635H+KUe9vcSoS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EAwQc0UT; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763286387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zNhPYwtelZQc8+GbYLnOTAnsgfYOcEfexBQ2xZktde0=;
	b=EAwQc0UTTagbB2ie7sAM/0Z/ttwTxwua7Sb2OOUVni0EnYpiIN4+uVHKsKl3xfEnuryu1D
	6O2oFV4jTQG2Y/v2HHoOGb3qvOhTwt5mC4fP0K9gjxntSyFQKRombIjlZzzLqZXdL4nOqY
	20CZ1ppcQr50mjEzFlhmOI79ZmQoCPY=
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
Subject: [PATCH net-next v5 0/2] convert drivers to use ndo_hwtstamp callbacks part 4
Date: Sun, 16 Nov 2025 09:46:08 +0000
Message-ID: <20251116094610.3932005-1-vadim.fedorenko@linux.dev>
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

v4 -> v5:
- add netif_running() check in bnx2x driver
- improve phrasing for netif_running() check
v3 -> v4:
- improve tx_type checks to the slightly more resilient variant
- restore netif_running() check in qede driver
v2 -> v3:
- keep bnx2x driver's logic as is. Improvements will be sent as
  follow-ups
v1 -> v2:
- remove unused variable in qede patch

Vadim Fedorenko (2):
  bnx2x: convert to use ndo_hwtstamp callbacks
  qede: convert to use ndo_hwtstamp callbacks

 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 72 ++++++++++++------
 drivers/net/ethernet/qlogic/qede/qede_main.c  | 22 +-----
 drivers/net/ethernet/qlogic/qede/qede_ptp.c   | 76 ++++++++++++-------
 drivers/net/ethernet/qlogic/qede/qede_ptp.h   |  6 +-
 4 files changed, 103 insertions(+), 73 deletions(-)

-- 
2.47.3


