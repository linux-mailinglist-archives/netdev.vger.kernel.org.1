Return-Path: <netdev+bounces-232834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836B9C09257
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 17:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2ECE3A775B
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 15:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271713002DF;
	Sat, 25 Oct 2025 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZADcKZji"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6AE21322F
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761404515; cv=none; b=upLsyPQGmXx8EbjyurZUEMQXbTvkJ5xdYpa0ohl0btbAs4bV0ZcioBh/qwyx7Cqk8c/ijBo4IlV9eX+Aqkxqe7cZIbRtfFAlZbJfdsH001aQJx+KEEKYmmjXqz1fo0p/nj32Qku92mDyeki70oDBW9qr0sMwCXsk025mfBIdNHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761404515; c=relaxed/simple;
	bh=c0kR08R5IAcF8RDrt05yjaWw2A/pmKNvO+hvr6PFZYM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J1I2X+z7UEpWDcMjen6lQjOZwwcSLNSsloKzi+eEM/rEVNF2XrjAeCq302479BjrmcgoqrUVNQ5zFnipUpclsRtJcs9JmN+dG1+rDx4uTtf2wIajxZzzPJ+bw8Cd6dfXYvD0hg6gBblnwzcsZxcj5jC2E7JGM9X4azxsPKyapow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZADcKZji; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1761404512; x=1792940512;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6rH7qvf1RZBkjVdwkDlcJfm9sBHxPRv2fdKfMYL++g0=;
  b=ZADcKZjiKmnJ9UxVe1HGYUEcwc0MbNimwrIfh/lUWjm0ZAuXBGV61EJC
   jkseczYKvjpX2x4tlwuKV3afcR4cUqL/u6MQt/gvm6qpf9rGjk+23cTRi
   ESxperAw8aeE5s3fu0r96lVZr/xPaWbhNvmEMQ/4UmAg2gDMHP+15cC3u
   9uvrNCOSdDgmXAEQQyjRCqr1/s3GqJ06ykjQwfDUelG9m8Yr4Rrr2PgTO
   D3qWwu1GZEl4VBuBMcsJXSSthdYvnc/9FRh2bCpxA9uwN00HdijeUzbPZ
   Rk/PNbdBPxcwEFGytR3+AArKQMXcnwj0bEhUMUE9c2ldW7BpteBFJPDVV
   A==;
X-CSE-ConnectionGUID: JqhhCBMlSdSNihIDIsM+Zg==
X-CSE-MsgGUID: yD1g/CtZQSyg3bF4O+czxw==
X-IronPort-AV: E=Sophos;i="6.18,281,1751241600"; 
   d="scan'208";a="5710376"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2025 15:01:50 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:6857]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.61:2525] with esmtp (Farcaster)
 id aceeaefd-0e9d-4774-a592-5cce947f4747; Sat, 25 Oct 2025 15:01:50 +0000 (UTC)
X-Farcaster-Flow-ID: aceeaefd-0e9d-4774-a592-5cce947f4747
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Sat, 25 Oct 2025 15:01:50 +0000
Received: from b0be8375a521.amazon.com (10.37.244.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Sat, 25 Oct 2025 15:01:47 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<kohei.enju@gmail.com>, Kohei Enju <enjuk@amazon.com>
Subject: [PATCH iwl-next v1 0/3] igc: add RSS key get/set support
Date: Sun, 26 Oct 2025 00:01:29 +0900
Message-ID: <20251025150136.47618-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA004.ant.amazon.com (10.13.139.68) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

This series adds ethtool get/set support for the RSS hash key in the igc
driver.
- `ethtool -x <dev>` to display the RSS key
- `ethtool -X <dev> hkey <key>` to configure the RSS key

Without patch:
 # ethtool -x $DEV | grep key -A1
 RSS hash key:
 Operation not supported
 # ethtool -X $DEV hkey be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef
 Cannot set RX flow hash configuration:
  Hash key setting not supported

With patch:
 # ethtool -x $DEV | grep key -A1
 RSS hash key:
 dd:7c:1f:06:1a:42:dc:e5:7e:90:2c:48:aa:3f:5d:5a:d7:da:ec:44:3e:3f:df:78:89:1e:3c:68:2e:59:da:a0:23:5a:32:5c:cf:5e:7e:7b
 # ethtool -X $DEV hkey be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef
 # ethtool -x $DEV | grep key -A1
 RSS hash key:
 be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef:be:ef

Kohei Enju (3):
  igc: prepare for RSS key get/set support
  igc: expose RSS key via ethtool get_rxfh
  igc: allow configuring RSS key via ethtool set_rxfh

 drivers/net/ethernet/intel/igc/igc.h         |  4 ++
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 60 ++++++++++++++------
 drivers/net/ethernet/intel/igc/igc_main.c    |  7 +--
 3 files changed, 50 insertions(+), 21 deletions(-)

-- 
2.51.0


