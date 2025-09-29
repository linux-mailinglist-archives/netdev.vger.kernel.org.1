Return-Path: <netdev+bounces-227079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE41BA8023
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 07:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 186EF7B1B1E
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 05:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4979A29B8DC;
	Mon, 29 Sep 2025 05:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="b0t4dw05"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC5B1EB9E3
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 05:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759124565; cv=none; b=OeJSBFg5FRYCL7zGh2k7EYWklsgnKgBkX6ZBPAlt08J49m1fwF8aDXRvZOCaG5nCwInrlcEYJwk6QJhMRMBgajoB7NLhGglig+WTDa3k4dizzeg8BIGn8RrpAflTbEQ05u0ZIWVJGH+d9uGkyV0Tek/LOWlas0yzfmfCTOd7Mr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759124565; c=relaxed/simple;
	bh=AzxZ0mifU9d/hpXVa54Lpvy4Req08tXqaOTH0M76naI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WYDeT7trtO/Ar1tNvYJqXaORdeZ7D8+yd2C43Bkx451Fgk103mK2XevZgrAbEmWhL3H3cKEgMUhGjws6zDNXtCZv8aWkpDKMd8KI5b50S1TXOag+IQ7O6P5Una/QNTP85xBQx6Tr+a55qeMlqkGaCANY3DpoyBWBfmawqJ+mZLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=b0t4dw05; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1759124563; x=1790660563;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=44QAXdP/poMVHv+YMGfpyU6AtHMuuin3kSXxnLUy+/s=;
  b=b0t4dw05g8/2yfFSHdQCAg9eC6LxBS9Sjf0t46Xxb2JIZTAX/0u4nfvo
   I6lRAr9DbFdY+784CiBXVgLgw0wi4TrpnIQbXk3BsSzshWqojWNUv/MVd
   MAg0487TaHfsgMgnrXjlCtC9b0pxGBAv1bbcrrcEQ2q4g2O4PjqH6BgkE
   qSFgl+UVi6S5IhX0VbZn2MVGAz/lMGjaZT8JFi96RmfBfh/139ff4pDdQ
   39tvYA+U9e8CZ98fz+jaA59WKyWvkdSElf4gzx5wwOmDNISmSOoL3ksb1
   fUqpdu3ojiDlwDaRAyxo3j11KA2V9N42EsS29NIysrMb7TNBCuO+nNXHO
   g==;
X-CSE-ConnectionGUID: Hu4oy80wTpGHM7s2rJPy2w==
X-CSE-MsgGUID: uKrJlETsR3Sh0QQxGllZOQ==
X-IronPort-AV: E=Sophos;i="6.18,301,1751241600"; 
   d="scan'208";a="3911117"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 05:42:41 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:42282]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.1:2525] with esmtp (Farcaster)
 id 2086a5b1-aee2-4ecf-ab9b-5e311219dc7f; Mon, 29 Sep 2025 05:42:41 +0000 (UTC)
X-Farcaster-Flow-ID: 2086a5b1-aee2-4ecf-ab9b-5e311219dc7f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 29 Sep 2025 05:42:41 +0000
Received: from b0be8375a521.amazon.com (10.37.245.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 29 Sep 2025 05:42:39 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <oss-drivers@corigine.com>, <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Kohei Enju
	<enjuk@amazon.com>, Louis Peens <louis.peens@corigine.com>,
	<kohei.enju@gmail.com>
Subject: [PATCH net v1] nfp: fix RSS hash key size when RSS is not supported
Date: Mon, 29 Sep 2025 14:42:15 +0900
Message-ID: <20250929054230.68120-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The nfp_net_get_rxfh_key_size() function returns -EOPNOTSUPP when
devices don't support RSS, and callers treat the negative value as a
large positive value since the return type is u32.

Return 0 when devices don't support RSS, aligning with the ethtool
interface .get_rxfh_key_size() that requires returning 0 in such cases.

Fixes: 9ff304bfaf58 ("nfp: add support for reporting CRC32 hash function")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
index a36215195923..16c828dd5c1a 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
@@ -1788,7 +1788,7 @@ static u32 nfp_net_get_rxfh_key_size(struct net_device *netdev)
 	struct nfp_net *nn = netdev_priv(netdev);
 
 	if (!(nn->cap & NFP_NET_CFG_CTRL_RSS_ANY))
-		return -EOPNOTSUPP;
+		return 0;
 
 	return nfp_net_rss_key_sz(nn);
 }
-- 
2.48.1


