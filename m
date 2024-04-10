Return-Path: <netdev+bounces-86467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDAA89EE98
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 11:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FE71C21FA0
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462EE1553BB;
	Wed, 10 Apr 2024 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SAj4qosQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F3913D2BC
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740452; cv=none; b=WhMKauAhevWleWHT4LvPLW9ea4A2ooRjWSKI90GqXly9CwEXDT5y1sn5c364EoiaSlTAU7eAT9G2fvqJJGfCcarzFgZmV8Tm4r2OmJSvs/AOmlq6eJtcBwKiN/HZwuUPQ3AkL6AKysZEnmxTb9gMUWjFzidkRyYoaWwYfp7HM+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740452; c=relaxed/simple;
	bh=EJMiye72Cy+NnSl5O7Q3HBP37tYyV6F07zqXmt61660=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p0jxcDqUzI3DclVI0yumRGKyUHgHnF9gZLUptWnTcodvdGrK40XS6ZKjpW4OyTVU7oYU1gDFIW2jw/1s5popO6/7Ol2kxlN766a1y33FUVlAbVtZNAl9xH2fvypJPC6jg2eVaJboQJFXzVNd5UHW6eyeCjWG+LBTx7Gt9wRLwPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SAj4qosQ; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712740451; x=1744276451;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=biyfjtsldvtgSzLvB0kfuu/pWC67yOKLCZpt5ZtFtU4=;
  b=SAj4qosQMyyk6UriKu4T/T8GoRKCfn8sMGIKj63uTfr5ZjbMwAHL5Fne
   knrUVFfok7sUgMpgeJYVOSf+Di34dg6Nrispuxk7uBy1NXKXe4CKFqgJG
   DLr+ltwkbWU9PUrJLk2WqqA5/Vgjh2d/3cFgIxPic3Xcr4ZAQgingI2SL
   Q=;
X-IronPort-AV: E=Sophos;i="6.07,190,1708387200"; 
   d="scan'208";a="197613615"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 09:14:08 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:57480]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.0:2525] with esmtp (Farcaster)
 id 558ea0eb-0de4-4aec-8dd3-379209e0a4e5; Wed, 10 Apr 2024 09:14:07 +0000 (UTC)
X-Farcaster-Flow-ID: 558ea0eb-0de4-4aec-8dd3-379209e0a4e5
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 09:14:07 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 09:14:06 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Wed, 10 Apr 2024 09:14:03
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
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, Netanel Belgazal
	<netanel@annapurnalabs.com>, Sameeh Jubran <sameehj@amazon.com>
Subject: [PATCH v1 net 0/4] ENA driver bug fixes
Date: Wed, 10 Apr 2024 09:13:54 +0000
Message-ID: <20240410091358.16289-1-darinzon@amazon.com>
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

This patchset contains multiple bug fixes for the
ENA driver.

David Arinzon (4):
  net: ena: Fix potential sign extension issue
  net: ena: Wrong missing IO completions check order
  net: ena: Fix incorrect descriptor free behavior
  net: ena: Set tx_info->xdpf value to NULL

 drivers/net/ethernet/amazon/ena/ena_com.c    |  2 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 35 +++++++++++++-------
 drivers/net/ethernet/amazon/ena/ena_xdp.c    |  4 ++-
 3 files changed, 27 insertions(+), 14 deletions(-)

-- 
2.40.1


