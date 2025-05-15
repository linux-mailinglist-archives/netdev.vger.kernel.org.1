Return-Path: <netdev+bounces-190642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F1BAB80D0
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 10:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80AD416527C
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 08:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEAB28C5DF;
	Thu, 15 May 2025 08:31:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6F928A727
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 08:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297871; cv=none; b=LZRumzHSIYd4vgo3QVwxJHmvCZCQLVIBllKboEA+tfpuhiIU3Srq2vKpZ6mfwYYK5jnAMnQIp19oQqhnSB8fY+56QCMikFG0OI3Wwb14DUmtI7ij8s/889Ug4iC4ZDZHkoup8wEPa2LVIb0NzyJAjVO+ZiRQ9/yv0Eld5j9QPds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297871; c=relaxed/simple;
	bh=QWKTXstryQVK9ziGqhj64pq08M5GkeLVLt89up2UIqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UmFOuqUWShq9WJCZmlwiM1X+iMMeXqaATIAe9UZ6fHDOpCxgBmRgGs2RV+kyQIowxD6xUXB0sB64fs7BN1YC9zTwcuPH4ZXJO2TOhDBzBkx0L5HDDdYSCdsxDAslGBheiH3KnZyMMrFd9TNxvLGRBXTXX3JjXYotCdbBV/S8dB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uFTzZ-0002Xv-Sn; Thu, 15 May 2025 10:31:01 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uFTzY-002qOc-2e;
	Thu, 15 May 2025 10:31:01 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uFTzZ-00B8CP-0X;
	Thu, 15 May 2025 10:31:01 +0200
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
Subject: [PATCH net-next v4 0/4] net: selftest: improve test string formatting and checksum handling
Date: Thu, 15 May 2025 10:30:56 +0200
Message-Id: <20250515083100.2653102-1-o.rempel@pengutronix.de>
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

changes v4:
- s/Return /Return:/

changes v3:
- no functional changes
- rebase against latest net-next

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


