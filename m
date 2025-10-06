Return-Path: <netdev+bounces-227954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAC2BBE0B9
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 14:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271D43BB2B3
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 12:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6334F27FB03;
	Mon,  6 Oct 2025 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="BlFWZn78"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FDA22DF99
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759754278; cv=none; b=SKl0NhPmQe2/2y/VgpApp8SJT1JwmFUMX+fpH7i1qJJoO8i/5JNPUq8ZnLRvSncwbHorQg4ME/7jv9UywtFsY9ii2u6j5XwFjGCtj34qaHA3OemtO94KVPTwRRce6AlmSlT+iEwjEuL1/3nn59cyQwCJLV3M75BOIxJfNlzw40s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759754278; c=relaxed/simple;
	bh=cmC0p/FaBaFn0fvpxFGWmbFooO7As/RqPxjDzVDzeMw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h3FJRJE9VYAGZZjPJHXX5SlsMEZ9M9Pocs23uNEGpr2Dt+giPQThtX3kxTPdmHJprvb32ehnnPhdscxVI8AmgJxz5kyCyheNWw3zsrx+fRYh91SVGbNtAC95/fxe0GMDNrgsI+7imX9nGt1+mdjotIV1uGdjZUZnTkun2VYX+IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=BlFWZn78; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1759754276; x=1791290276;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qs5ytD45HWUpJstnCcUiKnjWzlVtUweTMeMtiLibvB4=;
  b=BlFWZn78CeDtXlWrssOZr7de4GKaVMO4VtgLDbydUUo0opA0NiOZl83+
   l6xn4kbYtIsOe5r6SlyQbSx5gv+9JHlfcKQ0DLZly8EUzNHOulkSVshrL
   tmU6qwFsFooEBP2U4FralEoS1vGMr/M5KFbvBDGCiuKkoKpmI12V+FnJy
   W5+RcAI3OZamSLqxP2VK8yFU6zj+sM43TTXTtfjWedh8owR5yN0R41FBW
   nmODro55fK7TBfvMiu5Mi1Tusn0wd5pueCpUqrDYX4Qh7px21rbJCfTCp
   04GMRQ23PgiVA/ouU4U4Bn/5SYNLGzgYa8UjkYGVCGZwb+spCkD48pICT
   w==;
X-CSE-ConnectionGUID: hDdk2/oKRt2Am79RCwhBLw==
X-CSE-MsgGUID: R9vVZYuXSyKu/tHZEdlnYA==
X-IronPort-AV: E=Sophos;i="6.18,319,1751241600"; 
   d="scan'208";a="4169716"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 12:37:54 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:9413]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.125:2525] with esmtp (Farcaster)
 id 1d31a40f-eb9c-4f9f-bbb1-db87bf5b883f; Mon, 6 Oct 2025 12:37:54 +0000 (UTC)
X-Farcaster-Flow-ID: 1d31a40f-eb9c-4f9f-bbb1-db87bf5b883f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 6 Oct 2025 12:37:53 +0000
Received: from b0be8375a521.amazon.com (10.37.244.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 6 Oct 2025 12:37:51 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Auke Kok
	<auke-jan.h.kok@intel.com>, Jeff Garzik <jgarzik@redhat.com>, Sasha Neftin
	<sasha.neftin@intel.com>, Richard Cochran <richardcochran@gmail.com>, "Jacob
 Keller" <jacob.e.keller@intel.com>, <kohei.enju@gmail.com>, Kohei Enju
	<enjuk@amazon.com>
Subject: [PATCH iwl-net v1 0/3] igb/igc/ixgbe: use EOPNOTSUPP instead of ENOTSUPP
Date: Mon, 6 Oct 2025 21:35:20 +0900
Message-ID: <20251006123741.43462-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

This series fixes inconsistent errno usage in igb/igc/ixgbe. The drivers
return -ENOTSUPP instead of -EOPNOTSUPP in specific ethtool and PTP
functions, therefore userland programs would get "Unknown error 524".

Use -EOPNOTSUPP instead of -ENOTSUPP to fix the issue.

This series covers all incorrect usage of ENOTSUPP in Intel ethernet
drivers except the one in iavf, which should be targeted for iwl-next in
a separate series since it's just a comment. [1]

For igb and igc, I used a simple reproducer for testing [2] on I350 and
I226-V respectively.
Without this series:
 # strace -e ioctl ./errno-repro
 ioctl(3, SIOCETHTOOL, 0x7ffcde13cec0)   = -1 ENOTSUPP (Unknown error 524)

With this series:
 # strace -e ioctl ./errno-repro
 ioctl(3, SIOCETHTOOL, 0x7ffd69a28c40)   = -1 EOPNOTSUPP (Operation not supported)

For ixgbe, I used the testptp for testing on 82599ES.
Without this series:
 # strace -e ioctl ./testptp -d /dev/ptp1 -P 1
 ioctl(3, PTP_ENABLE_PPS, 0x1)           = -1 ENOTSUPP (Unknown error 524)

With this series:
 # strace -e ioctl ./testptp -d /dev/ptp1 -P 1
 ioctl(3, PTP_ENABLE_PPS, 0x1)           = -1 EOPNOTSUPP (Operation not supported)

[1]
 $ grep -nrI ENOTSUPP .
 ./igc/igc_ethtool.c:813:  return -ENOTSUPP;
 ./igb/igb_ethtool.c:2284: return -ENOTSUPP;
 ./ixgbe/ixgbe_ptp.c:644:  return -ENOTSUPP;
 ./iavf/iavf_main.c:2966:           * if the error isn't -ENOTSUPP

[2]
 #include <sys/ioctl.h>
 #include <net/if.h>
 #include <string.h>
 #include <unistd.h>
 #include <linux/sockios.h>
 #include <linux/ethtool.h>
 
 int main() {
     int sock = socket(AF_INET, SOCK_DGRAM, 0);
     struct ethtool_gstrings gstrings = {};
     struct ifreq ifr;
     int ret;
 
     gstrings.cmd = ETHTOOL_GSTRINGS;
     gstrings.string_set = ETH_SS_WOL_MODES;
 
     ifr.ifr_data = (char*)&gstrings;
     strcpy(ifr.ifr_name, "enp4s0");
 
     ret = ioctl(sock, SIOCETHTOOL, &ifr);
 
     close(sock);
     return ret;
 }

Kohei Enju (3):
  igb: use EOPNOTSUPP instead of ENOTSUPP in igb_get_sset_count()
  igc: use EOPNOTSUPP instead of ENOTSUPP in
    igc_ethtool_get_sset_count()
  ixgbe: use EOPNOTSUPP instead of ENOTSUPP in
    ixgbe_ptp_feature_enable()

 drivers/net/ethernet/intel/igb/igb_ethtool.c | 2 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.48.1


