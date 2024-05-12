Return-Path: <netdev+bounces-95778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E47EE8C36BB
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 15:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777DF281361
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 13:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2124A23749;
	Sun, 12 May 2024 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qYUkaD/h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA69210FB
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715521609; cv=none; b=XwsNcoj3tJLi1siBWcK8Vn2SwFi9+H3nuWnJzRv8aXCubGvApAbVqZTMAjKyO5wBXDPin4sGMjal6xAsvoqZssh5bV8BXtWe7YO3XqjFnwiDPu1CjLBrR4V4a6nw5eE6Vopd2Z+EgCqieBYm2XCY4wupk7sZVO/vJ9/uKcN0wes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715521609; c=relaxed/simple;
	bh=+TLh0ZqPHrJ3c4eNN7oDbgleQUlJztC8pighhz36VaY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wt8dQLwxl+TryRX0QO2QxXTsV3ffopQ2y0Ey2nmBykOoUVU+PS6hH/UoWaWKHIV9TDFjcosa8d5UbaZNW1d+Htmn3JvOVrcsrSPQ/x8mXeyARTCphQlBp27gunYGO93HsgY0W3SsmwOAfMt9sapKAfYAJ5YqiAKRhkXUMLCN+MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qYUkaD/h; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715521607; x=1747057607;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0Ofl/BL1ugOGp6T6Eed7vv34jCrqgbFf1Hhx81q0jrk=;
  b=qYUkaD/hf9KLOBdhVlaUrr3w9yTVSZbloAUS3Op/k7/uqky3zvRZq6EP
   Vz4bgFZeJ4Vy6Sst7s2VTuTOqeHGOL9CIr8GE2yGvtgnLN+tLa7ulj8UM
   6AP5f4Elcv7OdCVFDrf6eXTw7ux75d0O+b7dk+4yGYMUNilEkRsoR+EnF
   0=;
X-IronPort-AV: E=Sophos;i="6.08,155,1712620800"; 
   d="scan'208";a="88588567"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 13:46:45 +0000
Received: from EX19MTAUEA001.ant.amazon.com [10.0.0.204:27725]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.61.78:2525] with esmtp (Farcaster)
 id 1a611ed6-1803-4693-884c-82a3db643019; Sun, 12 May 2024 13:46:44 +0000 (UTC)
X-Farcaster-Flow-ID: 1a611ed6-1803-4693-884c-82a3db643019
Received: from EX19D008UEC004.ant.amazon.com (10.252.135.170) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sun, 12 May 2024 13:46:44 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEC004.ant.amazon.com (10.252.135.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sun, 12 May 2024 13:46:43 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Sun, 12 May 2024 13:46:41
 +0000
From: <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
	<alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky, Evgeny"
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>
Subject: [PATCH v2 net-next 0/5] ENA driver changes May 2024
Date: Sun, 12 May 2024 13:46:32 +0000
Message-ID: <20240512134637.25299-1-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: David Arinzon <darinzon@amazon.com>

This patchset contains several misc and minor
changes to the ENA driver.

Changes from v1:
- Removed interrupt moderation hint from the
  patchset. The change is moved back to
  development state and will be released as
  part of a different patchset in the future. 

David Arinzon (5):
  net: ena: Add a counter for driver's reset failures
  net: ena: Reduce holes in ena_com structures
  net: ena: Add validation for completion descriptors consistency
  net: ena: Changes around strscpy calls
  net: ena: Change initial rx_usec interval

 drivers/net/ethernet/amazon/ena/ena_com.h     |  6 +--
 drivers/net/ethernet/amazon/ena/ena_eth_com.c | 37 ++++++++++++++-----
 drivers/net/ethernet/amazon/ena/ena_eth_com.h |  2 +-
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 17 +++++++--
 drivers/net/ethernet/amazon/ena/ena_netdev.c  | 37 ++++++++++++++-----
 drivers/net/ethernet/amazon/ena/ena_netdev.h  |  1 +
 .../net/ethernet/amazon/ena/ena_regs_defs.h   |  1 +
 7 files changed, 73 insertions(+), 28 deletions(-)

-- 
2.40.1


