Return-Path: <netdev+bounces-297191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Qn9lL1NOKGqvBwMAu9opvQ
	(envelope-from <netdev+bounces-297191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:33:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDE1662FC4
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:33:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=jsSOJ7Se;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297191-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297191-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B86C0302C152
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 17:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A424C77C6;
	Tue,  9 Jun 2026 17:25:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C4148AE39;
	Tue,  9 Jun 2026 17:25:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025907; cv=none; b=tSOnsrkLeixYv9Bb5o1wdZ/2k14BEm+bI84JAaWpLIwanhsj/eC1voz6R4IBmvc7jEGdNK3yuhz14Ox/+P81O6bNZCce/JGAc2L115J8t23sE7mMGllQybm8Ad68zNp6PFd3hrijuJOePbmrjhhMbUmB7zNXkU4SteFYIA4mlMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025907; c=relaxed/simple;
	bh=R3LgZNeYMC5YZb9x2LhfI7SCcEY4bbrZV5kXT1rdB7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMp1KLpUegUeGL9mFp2Ljm9xtxwzrb0pfne7mocnsG4U+jjUNl50eqxF9Ga5kN9XATEgKI1buvyIVriud6zVUskcakzblEKFhL458HnCOLv/JnYLBSZQztZqBUomc5KTCFDSWNlf8o3zds/QCeFp+++qqH3/ltWVwR8vUwc+tKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jsSOJ7Se; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781025906; x=1812561906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R3LgZNeYMC5YZb9x2LhfI7SCcEY4bbrZV5kXT1rdB7c=;
  b=jsSOJ7Se3NFWgX8rPLn36rp9cp8uijwKeqFRlNETufCFTwILwMytYkGs
   lBAWgBN9wYTWBhVOg7sLIg64S5sSGrSnN1f0/AYUspDVlNUdqHNR3GEq8
   mtA+AOcMBLdNF5LcU0pURlYj2kpSoyMwU1qovBsRTRh7er+9gfcZ+ZF7K
   uQ38mfITwU8EWHd6pTYYll+VxgEEWcs3Mf5JeOTt2mB1yfV8Lv7nALt8S
   qaQNj+TcRfZCOxPMLRG3xN34zCrJmvLlhDUT22MMxqtAG4HE857CVb6fS
   ROJSOAdcoTqzZ1fIFmitK5/K9CaRFLWSRUe2gzHsSzraDmB9hwwgwR/Zj
   w==;
X-CSE-ConnectionGUID: B2y/wFieTo+SFSSwjy99JA==
X-CSE-MsgGUID: 3GVhJkeBT46xQlM31HN7Pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="99373430"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="99373430"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 10:25:05 -0700
X-CSE-ConnectionGUID: MERZpGPrRamlaZVZSuMdHQ==
X-CSE-MsgGUID: nT9MXXb5QQiEbzLvP9oPKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="250995093"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 09 Jun 2026 10:25:04 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	anthony.l.nguyen@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Patryk Holda <patryk.holda@intel.com>
Subject: [PATCH net 2/3] ixgbe: do not configure xps for XDP queues
Date: Tue,  9 Jun 2026 10:24:55 -0700
Message-ID: <20260609172458.4046222-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260609172458.4046222-1-anthony.l.nguyen@intel.com>
References: <20260609172458.4046222-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297191-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:larysa.zaremba@intel.com,m:anthony.l.nguyen@intel.com,m:maciej.fijalkowski@intel.com,m:magnus.karlsson@intel.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:bpf@vger.kernel.org,m:aleksander.lobakin@intel.com,m:aleksandr.loktionov@intel.com,m:horms@kernel.org,m:patryk.holda@intel.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BDE1662FC4

From: Larysa Zaremba <larysa.zaremba@intel.com>

netif_set_xps_queue() should not be called for an XDP Tx queue, since such
queues are not netdev-exposed. On systems with number of CPUs >=64, on E610
adapter, netdev is configured with maximum number queue pairs being 63
(due to MSI-X assignment), but configuring XDP results in 64 XDP queues.

So, during XDP program load, when netif_set_xps_queue() is called for the
last XDP queue, we get a WARNING with a call trace and KASAN report
afterwards (if enabled).

[ 2012.699800] WARNING: net/core/dev.c:2854 at __netif_set_xps_queue+0x116a/0x1e40, CPU#36: xdpsock/103668
[...]
[ 2012.700029] RIP: 0010:__netif_set_xps_queue+0x116a/0x1e40
[ 2012.700035] Code: b6 34 06 48 89 f8 83 e0 07 83 c0 01 40 38 f0 7c 09 40 84 f6 0f 85 03 0a 00 00 0f b7 44 24 40 66 43 89 44 6a 18 e9 01 fb ff ff <0f> 0b e9 f2 ee ff ff 44 8b 44 24 44 45 85 c0 74 50 4d 85 e4 0f 84
[ 2012.700040] RSP: 0018:ffff8882369aeb28 EFLAGS: 00010246
[ 2012.700046] RAX: 0000000000000000 RBX: 000000000000003f RCX: 0000000000000000
[ 2012.700050] RDX: 1ffff1111da3d891 RSI: ffff888120e34250 RDI: ffff8888ed1ec488
[ 2012.700054] RBP: ffff888913281560 R08: 0000000000000000 R09: ffff8888ed1ec000
[ 2012.700058] R10: ffff8888a2e83180 R11: 0000000000000000 R12: 0000000000007fa8
[ 2012.700061] R13: 000000000000003f R14: ffff888120e34854 R15: ffff8889132817c8
[ 2012.700065] FS:  00007fc8ea9ff740(0000) GS:ffff88884cefe000(0000) knlGS:0000000000000000
[ 2012.700069] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2012.700073] CR2: 00007f81c8000020 CR3: 00000002299f8006 CR4: 00000000007726f0
[ 2012.700077] PKRU: 55555554
[ 2012.700080] Call Trace:
[ 2012.700084]  <TASK>
[ 2012.700087]  ? ktime_get+0x61/0x150
[ 2012.700097]  ? usleep_range_state+0x133/0x1b0
[ 2012.700108]  ? __pfx_usleep_range_state+0x10/0x10
[ 2012.700114]  netif_set_xps_queue+0x31/0x50
[ 2012.700119]  ixgbe_configure_tx_ring+0x472/0x920 [ixgbe]
[...]
[ 2012.700486]  ixgbe_xdp+0x38f/0x750 [ixgbe]

[...]

[ 2012.701094] BUG: KASAN: slab-out-of-bounds in __netif_set_xps_queue+0x1ac5/0x1e40
[ 2012.701100] Write of size 4 at addr ffff88888d43cff8 by task xdpsock/103668

Skip XPS configuration for XDP Tx queues.

Fixes: 33fdc82f0883 ("ixgbe: add support for XDP_TX action")
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Patryk Holda <patryk.holda@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 2646ee6f295f..9ec250c26284 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3958,7 +3958,8 @@ void ixgbe_configure_tx_ring(struct ixgbe_adapter *adapter,
 	}
 
 	/* initialize XPS */
-	if (!test_and_set_bit(__IXGBE_TX_XPS_INIT_DONE, ring->state)) {
+	if (!ring_is_xdp(ring) &&
+	    !test_and_set_bit(__IXGBE_TX_XPS_INIT_DONE, ring->state)) {
 		struct ixgbe_q_vector *q_vector = ring->q_vector;
 
 		if (q_vector)
-- 
2.47.1


