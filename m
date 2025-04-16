Return-Path: <netdev+bounces-183374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC53A90879
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03101443408
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B4B213259;
	Wed, 16 Apr 2025 16:14:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43356211704
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820091; cv=none; b=n6ZEpIFJr2xoePd/N0t8ZAWtapA0QSD5rXdBAY/q+bk50aYVey4cTZcYGnjDOs+zfOT/o/JLXRCE+awCNDf6DFM8L8pws7Pi6Dz/nrhrLtqzvp3sCNuhyTDwQQycI+OCsYQIbzf9BAnNYKiVgN5wH8rpG33H5Gszt2qmtjo1g+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820091; c=relaxed/simple;
	bh=8EofjnALU1aphS3lTh1VvkVFJxt8Z2SpLNqKU5ee8Y0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G7mNgYKwNtYIIFciiewSqebZBdXPRDlFU1GxSSBmtjtM+vPhAfZNLSpVEfKoUu9LNABucyUS0q59LXIe33aKg48HAT481ywl2sXJ8Dh9UONz9pviHkL42Bx8GfqUElgRvi2Y11klzjtcfeKWqLCtDld7FgdDfIdV94PYcB1w0AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u55PN-0002Fz-D7; Wed, 16 Apr 2025 18:14:41 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u55PN-000c9E-0D;
	Wed, 16 Apr 2025 18:14:41 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u55PM-00CGQ8-3D;
	Wed, 16 Apr 2025 18:14:40 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v1 0/4] net: selftest: improve test string formatting and checksum handling
Date: Wed, 16 Apr 2025 18:14:35 +0200
Message-Id: <20250416161439.2922994-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

This patchset addresses two issues in the current net selftest
framework:

- Truncated test names: Existing test names are prefixed with an index,
  reducing the available space within the ETH_GSTRING_LEN limit.  This
  patch removes the index to allow more descriptive names.

- Inconsistent checksum behavior: On DSA setups and similar
  environments, checksum offloading is not always available or
  appropriate. The previous selftests did not distinguish between software
  and hardware checksum modes, leading to unreliable results. This
  patchset introduces explicit csum_mode handling and adds separate tests
  for both software and hardware checksum validation.

Oleksij Rempel (4):
  net: selftests: drop test index from net_selftest_get_strings()
  net: selftest: prepare for detailed error handling in
    net_test_get_skb()
  net: selftest: add checksum mode support and SW checksum handling
  net: selftest: add PHY loopback tests with HW checksum offload

 net/core/selftests.c | 307 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 290 insertions(+), 17 deletions(-)

--
2.39.5


