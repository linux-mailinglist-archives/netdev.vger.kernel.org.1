Return-Path: <netdev+bounces-256286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mC2wJRDwgWlAMwMAu9opvQ
	(envelope-from <netdev+bounces-256286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:54:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EEDD9676
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4AA930199F4
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 12:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B46346AE1;
	Tue,  3 Feb 2026 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="McWJVt3T"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4746F346AFD
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 12:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123276; cv=none; b=pK50QPc/5aqKFj8pnmb8EMVJbyRa3CBMof57jJ0R1meXvmeReIWLHLmTPSlS3XD8N3gukewMrdNUFqM9oH2lqhDw84SfeHVuB31ZdYU1uMWMSNXUz0BFL1yPn7fG1Vhq6MPxMW0On9cWMTKvEmMPE4dMURuNayqy39MdDuD0LEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123276; c=relaxed/simple;
	bh=GJ4pw5k18Hf+2dXSAacfYNhboIqlnHhtpos94DI6fD0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oA/7t65vxQlc1r8SW8cau37v+fS7PxxLsDgDRsYseEikVF2vmjr5hrPsrJhzpnETlxMDsX3uj53yIoTR333NmKF3TnRaL3+4btxBZu+53rHva5xGuBBs9YObt5v/tbySG6IC6Pcp+94OHnLAXU+kWlbmPcv6bFoncoI/iYp3H1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=McWJVt3T; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1770123275; x=1801659275;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OXp+EGxucYPxD48JSNx0qV+Yw8ErjHN/lXwrb+uzKyk=;
  b=McWJVt3T4MqKi995qx16mMjfZnVCewmULo9pUDRV3HHPwJKzQAPv4rTQ
   +RHJDjVN4qJmZyP4e6tygoTz3kzHVKmMcYl/3DxxSbx9zgFBhs2aAwpPZ
   wf50pA+UE+IfpafffEslMWAilYuhA/tAVW8EvAGuGE/4jKUfC6pHPozAT
   Pj9j5QyrKStBWQQ/zAVTOqe4361iZ0kIh4mVOSuqjU380PN4uVtG/HG4N
   1ZXpauIP0kW6n1PMNNVd/XeQv7X3Vk3XDr+mddKXzjmWxysTnIqyrjOyv
   kjT2ezIApah6MGFvs4d7czjvwexfgOGVG6MGkFzRz6SSVtp27V0NlL5OW
   w==;
X-CSE-ConnectionGUID: LCyvKWRqTWqhscHaIuLiVQ==
X-CSE-MsgGUID: +1eosR/KRcquiZCc2Q8WTg==
X-IronPort-AV: E=Sophos;i="6.21,270,1763424000"; 
   d="scan'208";a="11723383"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 12:54:34 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:16885]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.67:2525] with esmtp (Farcaster)
 id 8566367f-1b4f-41de-98ea-1ed2801adaaf; Tue, 3 Feb 2026 12:54:34 +0000 (UTC)
X-Farcaster-Flow-ID: 8566367f-1b4f-41de-98ea-1ed2801adaaf
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 3 Feb 2026 12:54:33 +0000
Received: from 603e5f7bc1fe.amazon.com (10.37.245.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 3 Feb 2026 12:54:31 +0000
From: Takashi Kozu <takkozu@amazon.com>
To: <horms@kernel.org>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <aleksandr.loktionov@intel.com>,
	<pmenzel@molgen.mpg.de>, <piotr.kwapulinski@intel.com>, <enjuk@amazon.com>,
	Takashi Kozu <takkozu@amazon.com>
Subject: [PATCH iwl-next v6 0/3] igb: add RSS key get/set support
Date: Tue, 3 Feb 2026 21:54:10 +0900
Message-ID: <20260203125417.37285-5-takkozu@amazon.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D037UWC003.ant.amazon.com (10.13.139.231) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-256286-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takkozu@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 73EEDD9676
X-Rspamd-Action: no action

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
  v6:
      - fix a typo in the 3/3 commit message. (igc_set_rxfh() → igb_set_rxfh())

  v5:
      - delete 'has_user_rss_key' flag because it's unnecessary. 

  v4: 
      - modify the position of the declaration in the igb_write_rss_key() so that it is at the start of the block.

  v3: 
      - add ASSERT_RTNL() to explicitly show that an rtnl lock is being used
      - Move netdev_rss_key_fill() function from igb_setup_mrqc() to igb_sw_init()
      - Add kernel-doc header to igb_write_rss_key()

      <Test>
      - tools/testing/selftests/drivers/net/hw/rss_api.py is successful
      Run the following command

      # NETIF=enp0s3 python tools/testing/selftests/drivers/net/hw/rss_api.py | grep -v "# Exception" 

      Then, I checked the diffs before and after applying the patch

      $ diff beforePatch.txt afterPatch.txt 
      9c9
      < not ok 6 rss_api.test_rxfh_nl_set_key
      ---
      > ok 6 rss_api.test_rxfh_nl_set_key
      16c16
      < # Totals: pass:4 fail:8 xfail:0 xpass:0 skip:0 error:0
      ---
      > # Totals: pass:5 fail:7 xfail:0 xpass:0 skip:0 error:0

      The failing tests originally fails due to hardware.

      - tools/testing/selftests/drivers/net/hw/toeplitz.py is untested since there is no actual hardware, but since the logic around wr32() is preserved as it is, key writing to the device remain the same.
      

  v2: Fix typos (igc_* → igb_*) 
      https://lore.kernel.org/intel-wired-lan/20260108052020.84218-5-takkozu@amazon.com/T/

  v1: https://lore.kernel.org/all/20251205082106.4028-5-takkozu@amazon.com/


Takashi Kozu (3):
  igb: prepare for RSS key get/set support
  igb: expose RSS key via ethtool get_rxfh
  igb: allow configuring RSS key via ethtool set_rxfh

 drivers/net/ethernet/intel/igb/igb.h         |  3 +
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 85 ++++++++++++++------
 drivers/net/ethernet/intel/igb/igb_main.c    |  8 +-
 3 files changed, 66 insertions(+), 30 deletions(-)

-- 
2.52.0


