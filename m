Return-Path: <netdev+bounces-243755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB11CA6BE0
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 09:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FA1C3095E4F
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 08:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3CC31DD98;
	Fri,  5 Dec 2025 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="tRl/1r6T"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3612E8B81
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 08:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764922977; cv=none; b=cV1Eu9j6sxq1NQLe/fCLWDc566NfEB658O14JZUW8nYTXkTBmEwPq9OrUVFtm0Adp6hoPz+Xcwizl4M2ixl5J+f5GI1zTGH3Ffh1vIFqy+q3Y022IkTS5s2S+EGztAJmzuCL2PPd0TYgXSiXIUHLBu2YqeQg/6cJ7c9BoPW6azY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764922977; c=relaxed/simple;
	bh=Y14Pkx2FmE5/pMVshJ5yKK1DHy42FiPihI5jfzHPo+4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XE7k1k9YUZduGXmWP8Sp1f4smxGmWk9bst9iwom0x86gwVv58DVAmnFd7u3dmF3WOGjsHGLr61C0P49dWIvont9ixgyIGImWfPdd6IhPGzdfey0LNPW3jWhUxPS7BgHpCLLdHma6l+BADDpOCMuM0Kh7xZXaps00StCGT1jqeBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=tRl/1r6T; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1764922972; x=1796458972;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XqPo7JqIZstKgaZBPJXpgD+PM4FvGVfp1OcbLWfUjhc=;
  b=tRl/1r6T8MPf7loOv4ggBrbc6/h3ATN6LAFkTZmBseMmi4KKDRsuEr+v
   KamxjBDKIquvj0gJADeawf8yJiryh4VLBGBzluBLbcLLPybRChCpuU57b
   4ELy45fW2ft/jnBd2ZaKHGleiQG7nltzogbqtb0bcsAHb5PhLsgTXmaQm
   0z/Ps/eIypKeKJ+glAOVwzhbl0cG81XxzvKgxghRyCJat0P/sjOYdW1NT
   1guOzyrNygKL55gPvgO4OtRxYFJho/xZsmWJGZ3g8vZB5AaxdxmnaqQwN
   GMHOUhNjUlq3PAI+b9jMGIamDMEUg9s6hUsF2KzF5NU51Vd5/1yplx2k+
   Q==;
X-CSE-ConnectionGUID: h2cvQgZdTWafkj+4Keik8A==
X-CSE-MsgGUID: qCruteymSn227fEsSi1OsQ==
X-IronPort-AV: E=Sophos;i="6.20,251,1758585600"; 
   d="scan'208";a="8296611"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 08:21:39 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:5620]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.201:2525] with esmtp (Farcaster)
 id c5622195-c63c-435f-bacf-adb027ae4b96; Fri, 5 Dec 2025 08:21:39 +0000 (UTC)
X-Farcaster-Flow-ID: c5622195-c63c-435f-bacf-adb027ae4b96
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 5 Dec 2025 08:21:39 +0000
Received: from 603e5f7bc1fe.amazon.com (10.37.244.13) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 5 Dec 2025 08:21:37 +0000
From: Takashi Kozu <takkozu@amazon.com>
To: <anthony.l.nguyen@intel.com>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, Takashi Kozu <takkozu@amazon.com>
Subject: [PATCH iwl-next v1 0/3] igb: add RSS key get/set support
Date: Fri, 5 Dec 2025 17:21:04 +0900
Message-ID: <20251205082106.4028-5-takkozu@amazon.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

This series adds ethtool get/set support for the RSS hash key in the igb
driver.
- `ethtool -x <dev>` to display the RSS key
- `ethtool -X <dev> hkey <key>` to configure the RSS key

Without patch:

# ethtool -x $DEV | grep key -A1
RSS hash key:
Operation not supported
# ethtool -X $DEV hkey 00:00:00:00:00:00:00:00:00:00:00:00:000
Cannot set RX flow hash configuration:
  Hash key setting not supported


With patch:

# ethtool -x $DEV | grep key -A1
RSS hash key:
86:5d:11:56:bd:6f:20:38:3b:f8:bb:df:00:3a:b0:24:95:9f:f9:f4:25:a3:01:3e:4a:15:d6:7c:4d:af:39:7e:4a:95:f2:fd:f6:b6:26:f7

# ethtool -X $DEV hkey 00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00
# ethtool -x $DEV | grep key -A1
RSS hash key:
00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00

Takashi Kozu (3):
  Store the RSS key inside struct igb_adapter and introduce the
  igb: expose RSS key via ethtool get_rxfh
  igb: allow configuring RSS key via ethtool set_rxfh

 drivers/net/ethernet/intel/igb/igb.h         |  4 +
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 77 +++++++++++++-------
 drivers/net/ethernet/intel/igb/igb_main.c    |  7 +-
 3 files changed, 58 insertions(+), 30 deletions(-)

-- 
2.51.1


