Return-Path: <netdev+bounces-126437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B5F97127E
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D0F1C22882
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 08:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A431B29B8;
	Mon,  9 Sep 2024 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="M5TnPZ6W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B0E1B1515
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871637; cv=none; b=GPiKh6U2imkvho2DmYqsz77Ee3esFSmSiRoGpAS1l9tEGV37TkrHpP1tcpmvWkT2OsweMNIfc/4m11h2rdrjlDhU8v40VYSaaSzvZs8e2BypMVJzBcKufzNeaWYTOClIyP3zMtnrGJjcxHDcFSncwpYtgWYrApsYbj+Uux3ef38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871637; c=relaxed/simple;
	bh=0w121F/r0ODDhQmiXqvFr5WIomUDmM89V4g1ZxRTcOA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=riHC0BaUkJpt3OWgchD84tLKwzCH46458O5qA8GELbBMXOGMw520BS/qXol3PotYoL1NSHQSZosje2VoKwsRl+RFSZMOiDD8k5mfUFpequNjRSOoWyPxP0G9l/fGIA0qGiqY0dIXBV/s/Uzja3XEU/Rcoss3SRDzQnMrjzb8bTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=M5TnPZ6W; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725871636; x=1757407636;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qz+Ljv+3fmGuUkBkQHMpr1h3wVsNSrgOciqh53WavJU=;
  b=M5TnPZ6WduqmPSkmx1VJ/4BSS7UJLwdQ8RmseGlxXliNOjHO2JO6bRVd
   6mlP7ZHynJ4O5W8x34a3NUu4OZl0raWUg4EabtoPB5S2ekXbXtwcd+mKf
   dxDlDeQfkmaaPWm4ilk/A00uf1N/uvGv2dj+sy5VskURpTtc+13mFT2Cb
   0=;
X-IronPort-AV: E=Sophos;i="6.10,213,1719878400"; 
   d="scan'208";a="123993840"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 08:47:14 +0000
Received: from EX19MTAUEB002.ant.amazon.com [10.0.0.204:28588]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.28.21:2525] with esmtp (Farcaster)
 id b5bdd3af-05c2-4db1-9acf-fad2e2cf586d; Mon, 9 Sep 2024 08:47:13 +0000 (UTC)
X-Farcaster-Flow-ID: b5bdd3af-05c2-4db1-9acf-fad2e2cf586d
Received: from EX19D008UEC002.ant.amazon.com (10.252.135.242) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 9 Sep 2024 08:47:13 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEC002.ant.amazon.com (10.252.135.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 9 Sep 2024 08:47:12 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.174) by
 mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server id
 15.2.1258.34 via Frontend Transport; Mon, 9 Sep 2024 08:47:08 +0000
From: David Arinzon <darinzon@amazon.com>
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
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, "Beider, Ron"
	<rbeider@amazon.com>, "Chauskin, Igor" <igorch@amazon.com>
Subject: [PATCH v2 net-next 0/2] ENA driver metrics changes
Date: Mon, 9 Sep 2024 11:47:02 +0300
Message-ID: <20240909084704.13856-1-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patchset contains an introduction of new metrics
available to ENA users.

Changes from v1:
- Utilization of local `dev` variable rather than a mix
  of `adapter->ena_dev` and `dev` access in ENA ethtool code.
- Modification of the commit messages to make them more
  informative.

David Arinzon (2):
  net: ena: Add ENA Express metrics support
  net: ena: Extend customer metrics reporting support

 .../device_drivers/ethernet/amazon/ena.rst    |   5 +
 .../net/ethernet/amazon/ena/ena_admin_defs.h  |  72 ++++++++
 drivers/net/ethernet/amazon/ena/ena_com.c     | 173 +++++++++++++++---
 drivers/net/ethernet/amazon/ena/ena_com.h     |  68 +++++++
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 163 ++++++++++++++---
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  27 ++-
 drivers/net/ethernet/amazon/ena/ena_netdev.h  |   2 +-
 7 files changed, 442 insertions(+), 68 deletions(-)

-- 
2.40.1


