Return-Path: <netdev+bounces-304219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d3/SEbp+RmpGXQsAu9opvQ
	(envelope-from <netdev+bounces-304219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 17:07:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4000A6F9335
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 17:07:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="noQuqZ/a";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304219-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304219-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D997230D1AF5
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 14:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DCA41735A;
	Thu,  2 Jul 2026 14:50:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9A741735E
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 14:50:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003811; cv=none; b=WYif9Lpt06WayimrFA8+7/eggsHkp2hFsDEKgZZCCgDKI17j78nZanFGjSQulUWB/etFpoR87eqz9ivoJNrVKt0CFmTXGSc46UDPRJV+mEl9CgEKx1LJNzvSluwUlBKdOtmnC+6Svedten+YCq4ExzBpBPdQlz7bpAZQnh5Qghs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003811; c=relaxed/simple;
	bh=+1ym3looAR4S/c8VBKN8HRx9Rs2UBvUpxqVS75SaGH0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EBa8Eyiexh92HaW0ukjWlbEt5glx3EN/B+yDQdW8Ivk1TMmdVvwFQTg/Dx1Wsw9gIFCbDi/CXml/lmvHPNTaxTyVRwytNzuk1xRXs7QR9Zi2a5qZMWWduTxCHj1/7/NwfijHXC2pBez367cDGxV1ebVfktkLX1/oYqzbn993bMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=noQuqZ/a; arc=none smtp.client-ip=198.175.65.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783003810; x=1814539810;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+1ym3looAR4S/c8VBKN8HRx9Rs2UBvUpxqVS75SaGH0=;
  b=noQuqZ/a6ou5EyfVsbuRYEdHsxcYLqWKBGZKsPFXZZfuRlx6Oyi9n3kG
   xChc3MCEt7KBpM3Si7nTahWoQSwrlOLW8mzVg9Tq+rXS4PoKTr2+gm5pV
   is84NsiY05DvKA4NlxzC9Xxc2H6DiSRKhcQNEiUOLlKeR2bCSDo4TTKfu
   PSa4JhaQbG9e/xzL74JyNBF0uC2Z/ZtKL4EfoyHyckeEioIvBEDDAlgt2
   WN8ynM4bl2vs4379lJKHZpA3ggPl287PQG0/nesuWcmuTQ7JfAehYDfFZ
   6x4ZQhmKKEjOqTUbi7PXZ68crAcnOnpe9Jb0ni6rQdrHI7AyPgRFmAZqY
   A==;
X-CSE-ConnectionGUID: 23wAnhBLRhCjzuvwSeYuPw==
X-CSE-MsgGUID: oR4ykBsWR+WMcyP+tNMFiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83851300"
X-IronPort-AV: E=Sophos;i="6.25,144,1779174000"; 
   d="scan'208";a="83851300"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 07:50:10 -0700
X-CSE-ConnectionGUID: VE5WT243SiSXPXEfjqvOwg==
X-CSE-MsgGUID: DPsoREJnRaapoKSm1gRc7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,144,1779174000"; 
   d="scan'208";a="248429040"
Received: from axxiablr1.iind.intel.com (HELO axxiablr1.gar.corp.intel.com) ([10.190.162.100])
  by fmviesa006.fm.intel.com with ESMTP; 02 Jul 2026 07:50:06 -0700
From: "D H, Siddaraju" <siddaraju.dh@intel.com>
To: Michal Kubecek <mkubecek@suse.cz>,
	Andrew Lunn <andrew@lunn.ch>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org
Cc: Shubham Das <Shubham.Das@intel.com>,
	Balaji Chintalapalle <balaji.chintalapalle@intel.com>,
	Vijay Srinivasan <vijay.srinivasan@intel.com>,
	Magnus Lindberg <magnus.k.lindberg@ericsson.com>,
	Niklas Damberg <niklas.damberg@ericsson.com>,
	Jonas Wirandi <jonas.wirandi@ericsson.com>,
	Siddaraju DH <siddarajudh@gmail.com>,
	Siddaraju DH <siddaraju.dh@intel.com>
Subject: [PATCH ethtool] man: ethtool: link 10000baseCR to SFF-8431, Appendix-E SFP+ DA
Date: Thu,  2 Jul 2026 20:20:02 +0530
Message-Id: <20260702145002.1024439-1-siddaraju.dh@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304219-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,ericsson.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:mkubecek@suse.cz,m:andrew@lunn.ch,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:Shubham.Das@intel.com,m:balaji.chintalapalle@intel.com,m:vijay.srinivasan@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:jonas.wirandi@ericsson.com,m:siddarajudh@gmail.com,m:siddaraju.dh@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[siddaraju.dh@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[siddaraju.dh@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,8.in:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4000A6F9335

From: Siddaraju DH <siddaraju.dh@intel.com>

Annotate the 10000baseCR entry in the advertise mask table so users
understand what physical media this mode it actually represents.

10000baseCR does not correspond to any IEEE 802.3 *base-CR PMD.
It has no autonegotiation, no link training, and no mandatory FEC.
The industry standard for this media type is SFF-8431 Appendix-E
Direct Attach cable, also known as 10G_SFI_DA.

This change follows the conversation from netdev mail thread with
subject: "the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?"

Signed-off-by: Siddaraju DH <siddaraju.dh@intel.com>
---
 ethtool.8.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ethtool.8.in b/ethtool.8.in
index 3173287..604de9e 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -937,7 +937,7 @@ lB	l	lB.
 0x40000	10000baseKX4 Full
 0x80000	10000baseKR Full
 0x100000	10000baseR_FEC
-0x40000000000	10000baseCR Full
+0x40000000000	10000baseCR Full	(a.k.a 10G_SFI_DA, SFF-8431 Appendix-E)
 0x80000000000	10000baseSR Full
 0x100000000000	10000baseLR Full
 0x200000000000	10000baseLRM Full
-- 
2.25.1


