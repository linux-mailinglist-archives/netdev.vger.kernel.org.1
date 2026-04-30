Return-Path: <netdev+bounces-282839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A2pKcBL82kTzQEAu9opvQ
	(envelope-from <netdev+bounces-282839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:32:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1CB4A2C5F
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B53B1300D172
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFEF3E639B;
	Thu, 30 Apr 2026 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dkZvQ6Id"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D50335081
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777552318; cv=none; b=cU1I6jrn/kAMi9CN2ac9uQGdLoppCL0FtLODwDaUkWMGZSkL67jXaZZxWpPr+C9kdUJjNaXEedWggKGkwg33oHY7EvNAfgBlmh3uOek/pZoCnvGo2CLlauaO/dKaabE8W9z8XAytaR8iRQL7NZNe44iC56UTA99djwL7Jq4Tw8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777552318; c=relaxed/simple;
	bh=wZ/elesy/7o01ujF9sto27cSfGzsZbuvXwSSNlM4CXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K3yO8HzlEgBZfdOw0h5R9X824HJauKhoq7pEkO1XGVaC1/toSNkW4obOmibQeqPDZnRSLTpDvNb7sRqS7JO1yRwhwdgTIpG99yNrZmJF2u7D5wH4Y3m8uM2/5EQm/yxzPcw07TA/T7Sa4tyke1QNSL6qQLLu2P20aqXphSQlQf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dkZvQ6Id; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777552317; x=1809088317;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wZ/elesy/7o01ujF9sto27cSfGzsZbuvXwSSNlM4CXE=;
  b=dkZvQ6IdJFx93pPxOlh0sSa2DzFrYyy4X70zQFbwM2KM3B3OIt3/9YSz
   kzFIvf+DPiL+MTjtTq66Ca7lpg4ZTWvXGjqShXO3Tag3H/nDFj0ZOqAfF
   WlITjEGf11cQTqsmb8QQbXj62P/bB0LcPaZ4zrpBNQSIDSnO3aKtQsioj
   3cQOWwt146lhUbut6myK+pvsmOjUK/KPPne72MdIFb4QlwHIrqJxju/eh
   JjmTh6F3aW3cebZSBECHDCsQPJl/25EQ2qG9vb1WkcRhmlDAGtfIMtBqN
   2rvpVW0i694oUD2s/eC/Jscj+s7yWiGkGqiIAClCBRBrUN1arZa/VBWWU
   Q==;
X-CSE-ConnectionGUID: BRSAqk86TayvLdr3MaJPJw==
X-CSE-MsgGUID: r0Nqd2ctQquTm5Lvpw+HVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78487641"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="78487641"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 05:31:56 -0700
X-CSE-ConnectionGUID: HoLNcZzvQ6icQ3rD2c9NCA==
X-CSE-MsgGUID: OtfPuoPHRcKyXdb1fTk7Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="236353093"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa004.fm.intel.com with ESMTP; 30 Apr 2026 05:31:55 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH net] ixgbe: fix X550 AQ PHY identification returning ixgbe_phy_unknown
Date: Thu, 30 Apr 2026 14:31:53 +0200
Message-ID: <20260430123154.132072-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0D1CB4A2C5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282839-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]

ixgbe_get_phy_id() reads the two MII_PHYSID registers and combines them
into hw->phy.id with the lower 4 revision bits masked out by
IXGBE_PHY_REVISION_MASK (0xFFFFFFF0).

Commit 5f1c3589b0f0 ("ixgbe: Correct X550 phy ID") replaced
X550_PHY_ID (0x01540220) with X550_PHY_ID2 (0x01540223) and
X550_PHY_ID3 (0x01540221).  These are the raw values read directly off
hardware, but after revision-bit masking both reduce to 0x01540220.
The switch cases in ixgbe_get_phy_type_from_id() therefore never match,
and X550 AQ PHY devices always fall through to ixgbe_phy_unknown.  A
wrong PHY type means the wrong ops vector is selected, resulting in
failed PHY initialization and no link.

Restore X550_PHY_ID (0x01540220) as the match value -- the
revision-stripped ID that the driver actually stores.  Keep X550_PHY_ID2
and X550_PHY_ID3 as documentation of the hardware-reported values.

Fixes: 5f1c3589b0f0 ("ixgbe: Correct X550 phy ID")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 3 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index ab733e7..ca98dad 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -364,8 +364,7 @@ static enum ixgbe_phy_type ixgbe_get_phy_type_from_id(u32 phy_id)
 	case TN1010_PHY_ID:
 		phy_type = ixgbe_phy_tn;
 		break;
-	case X550_PHY_ID2:
-	case X550_PHY_ID3:
+	case X550_PHY_ID:
 	case X540_PHY_ID:
 		phy_type = ixgbe_phy_aq;
 		break;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 61f2ef6..0d47622 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -1412,6 +1412,7 @@ struct ixgbe_nvm_version {
 #define TN1010_PHY_ID    0x00A19410
 #define TNX_FW_REV       0xB
 #define X540_PHY_ID      0x01540200
+#define X550_PHY_ID      0x01540220
 #define X550_PHY_ID2	0x01540223
 #define X550_PHY_ID3	0x01540221
 #define X557_PHY_ID      0x01540240
-- 
2.52.0


