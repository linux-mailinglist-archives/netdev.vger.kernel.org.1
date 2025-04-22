Return-Path: <netdev+bounces-184639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216CBA96A4E
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 14:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364CC16149B
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 12:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B569B280CFC;
	Tue, 22 Apr 2025 12:39:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530BB27E1AD
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745325560; cv=none; b=O3Eu/3hYmkSFSoXCat5cSE/Yynh7T2vAJAq5hFWCXOeZHlxl7+iktoUz3N2IVqmSdkr4235aV/MRTGknC5Y0FLUanoppqrNJfZENedPaPjMFY7RaUdpIm7+RpdyO178dZ4VMgw9+VQwzgcCurP673/QJ2RhaIIpF8tRQQ1zD41Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745325560; c=relaxed/simple;
	bh=BhEtMKzjeaskERsSKy6HSFs0ItPLGjxwUZ01f4eTLIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZYsbcSe9aYBuYdeMHVph4cqvtsO8r1FdC1yB7prDtn4/um18ne1MVRW0gyW6i9ifc1LV0cyThsrKJ6GkegGuYruh6e2JZzDsXgkUFPkokg3QEZQjxx2jKvturWIEy3qNlPg5DCttHMRrwwiiujv/J1gKllIBjHhe4gInuil4kfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u7Cu0-0001wH-Kp; Tue, 22 Apr 2025 14:39:04 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u7Ctz-001YQi-1F;
	Tue, 22 Apr 2025 14:39:03 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u7Ctz-008TQ0-10;
	Tue, 22 Apr 2025 14:39:03 +0200
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
Subject: [PATCH net-next v2 0/4] net: selftest: improve test string formatting and checksum handling
Date: Tue, 22 Apr 2025 14:38:58 +0200
Message-Id: <20250422123902.2019685-1-o.rempel@pengutronix.de>
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
  net: selftests: prepare for detailed error handling in
    net_test_get_skb()
  net: selftests: add checksum mode support and SW checksum handling
  net: selftests: add PHY loopback tests with HW checksum offload

 net/core/selftests.c | 308 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 291 insertions(+), 17 deletions(-)

--
2.39.5


