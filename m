Return-Path: <netdev+bounces-127622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D10A975E28
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42ECC1F23B33
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 00:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEA0BA53;
	Thu, 12 Sep 2024 00:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="d2i8nrft"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9878F45
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 00:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726102328; cv=none; b=Fr+57w8W4qfQlUchwMJWrqmq4wZZFPUG/3aAPK0LkZ4Uu04JrJu7fHZozeS+iwIRASVLRkMNe9bMQIHrycH9ksSehXvb017pr/I76qePyA5TGlY7YarjRBlQSumIZ5ZtD5bGEn8jp3G0KLRvIaZUiO9Tty838wf8O3aghcg3mzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726102328; c=relaxed/simple;
	bh=iib71BNfyrAC6UueJW+t2KLLgfU29dlk2u37KvErv6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EafPDLZ4BZ+yy/eKhpRgNwDK8rr0QUxsIhQjGHV+pSm2/PeXn0jkPN5DoU3/1FdfQ9AFOXk3+qnob1TEmcPrI2/3XVht/BPGkGQHv9QQp2haUTVLU0NfieD7RLkX2ec5fj7q33CuktYgxK/dO6jIUy9QNwLJOgs4+OzFdJYCFks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=d2i8nrft; arc=none smtp.client-ip=173.37.86.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2502; q=dns/txt; s=iport;
  t=1726102327; x=1727311927;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t0rqkMc8HjfbIn3U/+CQ+I+q77C8C5XeOzngzgKJHSc=;
  b=d2i8nrft5WVVObPjix3VM2D6MFoeeOFyyTCztdH3V4VHFRmoE5F+5yFJ
   SLGGLu7D1rmbzxE3Uv/PBeeQ2ax+l3Nr+u0FpRkSZxbPNMoRveQ3v9fx6
   hbPgW9THDx1mR0coOTM0RB6FaipVxjWs29Dik6PfIFx4RGrZB4BLpxCkN
   M=;
X-CSE-ConnectionGUID: az8occRES+69vdo82vPFsw==
X-CSE-MsgGUID: bCeuqGAIT+elxpVAgB12BA==
X-IronPort-AV: E=Sophos;i="6.10,221,1719878400"; 
   d="scan'208";a="259666493"
Received: from rcdn-core-12.cisco.com ([173.37.93.148])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 00:50:58 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-core-12.cisco.com (8.15.2/8.15.2) with ESMTP id 48C0ovLi029192;
	Thu, 12 Sep 2024 00:50:57 GMT
Received: by cisco.com (Postfix, from userid 412739)
	id B127820F2003; Wed, 11 Sep 2024 17:50:57 -0700 (PDT)
From: Nelson Escobar <neescoba@cisco.com>
To: netdev@vger.kernel.org
Cc: satishkh@cisco.com, johndale@cisco.com,
        Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next v3 0/4] enic: Report per queue stats
Date: Wed, 11 Sep 2024 17:50:35 -0700
Message-Id: <20240912005039.10797-1-neescoba@cisco.com>
X-Mailer: git-send-email 2.35.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-core-12.cisco.com

Hi,

This is V3 of a series that adds per queue stats report to enic driver.
Per Jakub's suggestion, I've removed the stats present in qstats from the
ethtool output.

Patch #1: Use a macro instead of static const variables for array sizes.  I
          didn't want to add more static const variables in the next patch
          so clean up the existing ones first.

Patch #2: Collect per queue statistics

Patch #3: Report per queue stats in netdev qstats

Patch #4: Report some per queue stats in ethtool

# NETIF="eno6" tools/testing/selftests/drivers/net/stats.py
KTAP version 1
1..5
ok 1 stats.check_pause # XFAIL pause not supported by the device
ok 2 stats.check_fec # XFAIL FEC not supported by the device
ok 3 stats.pkt_byte_sum
ok 4 stats.qstat_by_ifindex
ok 5 stats.check_down
# Totals: pass:3 fail:0 xfail:2 xpass:0 skip:0 error:0

# tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml --dump qstats-get --json '{"ifindex": "34"}'
[{'ifindex': 34,
  'rx-bytes': 66762680,
  'rx-csum-unnecessary': 1009345,
  'rx-hw-drop-overruns': 0,
  'rx-hw-drops': 0,
  'rx-packets': 1009673,
  'tx-bytes': 137936674899,
  'tx-csum-none': 125,
  'tx-hw-gso-packets': 2408712,
  'tx-needs-csum': 2431531,
  'tx-packets': 15475466,
  'tx-stop': 0,
  'tx-wake': 0}]

---

V3:
  - Added a few more stats to be reported in netdev qstats
  - Removed stats reported in netdev qstats from the ethtool output per
    Jakub's suggestion
  - Patch order changes and commit message change to better reflect that
    ethtool patch only contains stats not in netdev qstats
  - Some minor changes like renaming the 'csum' counter to 'csum_none' and
    changes to counter comments to make things a little clearer
v2: https://lore.kernel.org/all/20240905010900.24152-1-neescoba@cisco.com/
  - Split the ethtool stats reporting into its own patch
  - Added a patch for reporting stats with netdev qstats per Jakub's
    suggestion
v1: https://lore.kernel.org/all/20240823235401.29996-1-neescoba@cisco.com/


Nelson Escobar (4):
  enic: Use macro instead of static const variables for array sizes
  enic: Collect per queue statistics
  enic: Report per queue statistics in netdev qstats
  enic: Report some per queue statistics in ethtool

 drivers/net/ethernet/cisco/enic/enic.h        |  38 ++++-
 .../net/ethernet/cisco/enic/enic_ethtool.c    | 102 ++++++++++--
 drivers/net/ethernet/cisco/enic/enic_main.c   | 157 ++++++++++++++++--
 3 files changed, 269 insertions(+), 28 deletions(-)

-- 
2.35.2


