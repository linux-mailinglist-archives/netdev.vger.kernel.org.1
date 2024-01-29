Return-Path: <netdev+bounces-66632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3BF8400A9
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 09:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05B2282A13
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 08:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A94854BDB;
	Mon, 29 Jan 2024 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="egUw4vCi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090C954BCC
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518555; cv=none; b=Gq2Rmwcas9bHrRbcDNU9+RWGhItequ34VCkdSIarKKIawgbkqb/k0nNyrG7JoUw+CopYH9AqjIvljHA1thSZYEVnz9L2mKd5nb3qp9Im7DHZjhafymSPwBSEq1CNJx3gb0Kdqedf/fOP8WVZIDyidRfGOhHxd+WrjHlp7EhCCTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518555; c=relaxed/simple;
	bh=7Xwfv8f5n/0roylanI2AVhmecF4+uBhkRLmVXINAn2I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdjaAJXkbOeFfWAG0Q1ksYfQPE62XOgzW91NJxfnsZOKXWNeqA7rcxGl2sZ/JtfzYsjwmLvOTjZmIl6JRQrs+BOOj+UQ7cdo4FZx0u0Lj4KT49h6C6A1VQD4smly4mGHWAER1cL2pT+oZeh0LXBFlh0+qkX7lodsXuM+lMomx28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=egUw4vCi; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706518553; x=1738054553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xJQrjmv5kbwgbrIGiSJEihUFrFIZVx3WNc1vVpc4CYA=;
  b=egUw4vCiqZh7+FoBQgL+nwliPL03gKF0X6yJkt5cWHDjDimPnZfWiNY0
   oaNKwDaWARgVlz4+Q2ZLapgj+bmedEOklOALIzmVTHiex/17RWwroy7p1
   v0xtUhMrevyu/uktt18qE0UUc9SSWRYB+xc55pH6WrsbcnufNIpBYG9vY
   o=;
X-IronPort-AV: E=Sophos;i="6.05,226,1701129600"; 
   d="scan'208";a="61845582"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 08:55:50 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com (Postfix) with ESMTPS id BDE66A27FB;
	Mon, 29 Jan 2024 08:55:49 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:27779]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.103:2525] with esmtp (Farcaster)
 id fe7d23ac-48bd-412a-8ece-76cbb66c0a20; Mon, 29 Jan 2024 08:55:49 +0000 (UTC)
X-Farcaster-Flow-ID: fe7d23ac-48bd-412a-8ece-76cbb66c0a20
Received: from EX19D010UWB003.ant.amazon.com (10.13.138.81) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 08:55:47 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D010UWB003.ant.amazon.com (10.13.138.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 08:55:46 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 08:55:44
 +0000
From: <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
	<alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky, Evgeny"
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, "Koler, Nati"
	<nkolder@amazon.com>
Subject: [PATCH v1 net-next 02/11] net: ena: Add more documentation for RX copybreak
Date: Mon, 29 Jan 2024 08:55:22 +0000
Message-ID: <20240129085531.15608-3-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240129085531.15608-1-darinzon@amazon.com>
References: <20240129085531.15608-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: Bulk

From: David Arinzon <darinzon@amazon.com>

This patch contains more details about the functionality
of RX copybreak.

Signed-off-by: Shay Agroskin <shayagr@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 .../networking/device_drivers/ethernet/amazon/ena.rst       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
index b842bcb..a4c7d0c 100644
--- a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
+++ b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
@@ -211,10 +211,16 @@ Documentation/networking/net_dim.rst
 
 RX copybreak
 ============
+
 The rx_copybreak is initialized by default to ENA_DEFAULT_RX_COPYBREAK
 and can be configured by the ETHTOOL_STUNABLE command of the
 SIOCETHTOOL ioctl.
 
+This option controls the maximum packet length for which the RX
+descriptor it was received on would be recycled. When a packet smaller
+than RX copybreak bytes is received, it is copied into a new memory
+buffer and the RX descriptor is returned to HW.
+
 Statistics
 ==========
 
-- 
2.40.1


