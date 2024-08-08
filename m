Return-Path: <netdev+bounces-116683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D7794B5B8
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 06:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E2C7B23182
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 04:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7713A339AB;
	Thu,  8 Aug 2024 04:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jd+6QFWF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D386911C83
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 04:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723089649; cv=none; b=B/mVOeR4ed0VqSR5xRYYPsBGzqLnvjzU7xGrgZ3AmYgfoxaazWi9v9pzYTdJKS6igWr6yoUDyZoStMFeBm/pm48tPgLJFtCaYMA9t32V4/P7mJLiOv2G4AjHMCI+XoeMUiZ0MAAwMiTQrqEaMFW5mP+k4+g6Sf5fOxBOyYhUJQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723089649; c=relaxed/simple;
	bh=9rKz+Ww1+UQMsLhIA3xzyWpuPQy6eq4H7PHvSeEXErI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s6kh/2xoky/MroV7ewMAXVGq2VMBCIf3H/vtqku3p9LDqzcKR8gBrZfHDTvb3Uw09lx2rKebvyqUXTRMWS/lietdLnvjNeE2kVTJcsNiEUGFUtyUJf8hdSlMDN1CKiJInGsrRJ42ZlIiTENdAtNfzlG6EVJOiVYBPaTCGXqTnvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jd+6QFWF; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723089648; x=1754625648;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LHy5F8i77R5GzGkwx1y4d35b4giGid4OKNXhLaq/m+M=;
  b=jd+6QFWFMzv2h3m0Cw+9Npuwd4EFnA9iI1xSqBSAb6K02E2BZ6dzZFJw
   L+/oor/ffBId/I5Av4Tr8KRL6QszGYxl4IZnzyo4tnFjIz0lPZwW+Nl/m
   GyolRYEqIcGzepzUSAxlkC1iiTtAziJxjwF7kitRR335q65v03qhob1j0
   4=;
X-IronPort-AV: E=Sophos;i="6.09,271,1716249600"; 
   d="scan'208";a="442054679"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 04:00:42 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:46163]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.206:2525] with esmtp (Farcaster)
 id 881229a2-9f56-4305-b9f0-be391a277d60; Thu, 8 Aug 2024 04:00:41 +0000 (UTC)
X-Farcaster-Flow-ID: 881229a2-9f56-4305-b9f0-be391a277d60
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 8 Aug 2024 04:00:39 +0000
Received: from 88665a182662.ant.amazon.com (10.135.210.149) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 8 Aug 2024 04:00:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Vineeth Karumanchi <vineeth.karumanchi@amd.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net] net: macb: Use rcu_dereference() for idev->ifa_list in macb_suspend().
Date: Wed, 7 Aug 2024 21:00:21 -0700
Message-ID: <20240808040021.6971-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

In macb_suspend(), idev->ifa_list is fetched with rcu_access_pointer()
and later the pointer is dereferenced as ifa->ifa_local.

So, idev->ifa_list must be fetched with rcu_dereference().

Fixes: 0cb8de39a776 ("net: macb: Add ARP support to WOL")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 11665be3a22c..dcd3f54ed0cf 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5250,8 +5250,8 @@ static int __maybe_unused macb_suspend(struct device *dev)
 	if (bp->wol & MACB_WOL_ENABLED) {
 		/* Check for IP address in WOL ARP mode */
 		idev = __in_dev_get_rcu(bp->dev);
-		if (idev && idev->ifa_list)
-			ifa = rcu_access_pointer(idev->ifa_list);
+		if (idev)
+			ifa = rcu_dereference(idev->ifa_list);
 		if ((bp->wolopts & WAKE_ARP) && !ifa) {
 			netdev_err(netdev, "IP address not assigned as required by WoL walk ARP\n");
 			return -EOPNOTSUPP;
-- 
2.30.2


