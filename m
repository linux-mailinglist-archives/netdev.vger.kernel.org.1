Return-Path: <netdev+bounces-247960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 218E4D010E6
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 06:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5A0B3014DA2
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 05:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3692C3260;
	Thu,  8 Jan 2026 05:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="fL9L8iyO"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB025205E25
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 05:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767849710; cv=none; b=bz6VD48Zgb0YkkTtnRkFNv9jwtKJ0LolpZ9a7LOymo8oCTAKDer9QRZoK/U9U6hqefeq0WFTwsryZzD2s+acAFqwB+or76Fc/7hbxp7PXc1Z+ARGTVyUakAxze8/A4399uEd/uuOUUIOo8IBVzMv2YPMwSPgRWg7gY7EawU0t1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767849710; c=relaxed/simple;
	bh=j6hyHBHKC84mO8mOQYj0/L9Xdy8CF12/j9YYR/8V1eA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AiRVeAQ+5Pktyx3/a+8Mk6TdruC4RWFKAPB23xbweI2lgVLB6PZojTAXOsgT228KbFsLMlIWHVRuY6xhEVkdk93L1uPIT9XT4pxZw95B33jOXmbb+n766TNTfi6If4R9RyvwEb01EHKRAzoqh8HgSJynKVafjTT4aMzFnH+x/NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=fL9L8iyO; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1767849708; x=1799385708;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4yrd543BqppBfDDQcrJeipvTbsa3INp/g8US0rju7KA=;
  b=fL9L8iyO/u+peOnlLRAOiA/It58da0G7mXpGwEiXU1OAsR4J9VQdAYlp
   dQGoospiNbGmAvXCd/yqLzRfltl1158fgaGpwlP8U9vBLxPBVK7tt599R
   vYNDYVELnhKGUaYxHD82VRsuFrtx1Bpj7g7cfskk4mflDupGG8YBy34lJ
   iU6y70zosV4yvVQXtJIUPRK0S1Dgt/Yh6ICH1GLr5tfNbOcCXoL0PUsxo
   02iEvSVpN7BBOxf5v8xoEj+NyrQofksq+rIcw2AIoNlk1KDBS069ZgyOd
   M7DVNuC4js9BrS1t6z2PVbe6VG/stzky5zjmIWPZa9oKzKfSj3aLyaZqe
   w==;
X-CSE-ConnectionGUID: kQbvIKdVS/G/h4n9YHyFLQ==
X-CSE-MsgGUID: bgqAZ6JfQHKnoItBKZs+4g==
X-IronPort-AV: E=Sophos;i="6.21,209,1763424000"; 
   d="scan'208";a="10233129"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 05:20:39 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:30973]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.78:2525] with esmtp (Farcaster)
 id 6a82af07-4606-4a33-99c5-229ed34ef6e8; Thu, 8 Jan 2026 05:20:39 +0000 (UTC)
X-Farcaster-Flow-ID: 6a82af07-4606-4a33-99c5-229ed34ef6e8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Thu, 8 Jan 2026 05:20:37 +0000
Received: from 603e5f7bc1fe.amazon.com (10.37.244.10) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Thu, 8 Jan 2026 05:20:35 +0000
From: Takashi Kozu <takkozu@amazon.com>
To: <anthony.l.nguyen@intel.com>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, Takashi Kozu <takkozu@amazon.com>
Subject: [PATCH iwl-next v2 0/3] igb: add RSS key get/set support
Date: Thu, 8 Jan 2026 14:20:12 +0900
Message-ID: <20260108052020.84218-5-takkozu@amazon.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
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

<Changelog>

  v2: Fix typos (igc_* → igb_*) 

  v1: https://lore.kernel.org/all/20251205082106.4028-5-takkozu@amazon.com/

Takashi Kozu (3):
  Store the RSS key inside struct igb_adapter and introduce the
  igb: expose RSS key via ethtool get_rxfh
  igb: allow configuring RSS key via ethtool set_rxfh

 drivers/net/ethernet/intel/igb/igb.h         |  4 +
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 77 +++++++++++++-------
 drivers/net/ethernet/intel/igb/igb_main.c    |  7 +-
 3 files changed, 58 insertions(+), 30 deletions(-)

-- 
2.52.0


