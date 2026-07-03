Return-Path: <netdev+bounces-304483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ha6PBTaOR2qibAAAu9opvQ
	(envelope-from <netdev+bounces-304483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 12:25:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6110C701312
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 12:25:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=FyDJGArv;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304483-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304483-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84C78300DF73
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 10:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E103B27CF;
	Fri,  3 Jul 2026 10:20:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2384437883D
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 10:20:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783074027; cv=none; b=nqj6K1dAYmX+RKkzG5YnlqOSLsyjmvZ2XCm+ezG63ovgToli7nGUNIPPUsZALw8fDxoMEUkIUCE305mEXc6z5vJ7EnglkdDLqowrHECGeIva1G8TuvhO9FcgOHLzwuRMiicwN45UTToAn+6R5Vc+B31veN4GGdEUj2A++5qXvyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783074027; c=relaxed/simple;
	bh=Yu1wHrTkR0HEuMsmwqJOjbY9Vm4RrjA9Z7iaBCKZBlA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XhmTsTNV7gHubAgYcYvHkQddeLvXBgHdZrIkzSbKD8g/AXOYrEjg159g5C5F0hNVjWtg3aAzppVf+Rr35lj7rXg8b3O2W6SZHY9zpI5HMISBZvB1TA3MCwywCz7vzaPzHvpymv/xI1mIc/vQI5uZs5n7FUjvuML1oNbALoygFXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FyDJGArv; arc=none smtp.client-ip=192.198.163.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783074026; x=1814610026;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yu1wHrTkR0HEuMsmwqJOjbY9Vm4RrjA9Z7iaBCKZBlA=;
  b=FyDJGArvPUkaNru/3h4rAFAjRFwZ5mPGkyBHC53qfJ/8Dx6fdkxPMwSi
   yBx2J2GFPIheqeGwDUoRjMT1pU4/z/1ONY4sqs3xLOUFF4hhjOyV0Px8i
   RVRDcP9rTR9waiPIFukiE2/kuQLJvGCzwAMW6kNELqnc1P5osAfD//T/Q
   hXMgW8OlGu1F8bkGBLQ+RvH5rQYfUovU/1R382Zk2nmaJAFi9Kk78MGoK
   6+0LwDH6P173nQ0/v8Y3VKt/oVvJgROCh00RMSmfSSPpGKgCnVrjyVcxX
   KNIkRDG2rxhMhklQnsB1E48E3d0CQ1KomfhUtMzfX3shgr0Kt9OThdL3L
   w==;
X-CSE-ConnectionGUID: gsNRod2fQf2m4J0sSWmqAA==
X-CSE-MsgGUID: mgMx3jTZQV26Zi+NeZ4u8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83880923"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83880923"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 03:20:25 -0700
X-CSE-ConnectionGUID: PzjsYPqQSWuocwtLnT+HfA==
X-CSE-MsgGUID: zh/rahnySXKbhZg+P0CQJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="291221630"
Received: from axxiablr1.iind.intel.com (HELO axxiablr1.gar.corp.intel.com) ([10.190.162.100])
  by orviesa001.jf.intel.com with ESMTP; 03 Jul 2026 03:20:22 -0700
From: Siddaraju DH <siddaraju.dh@intel.com>
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
Subject: [PATCH v2 ethtool] man: ethtool: link 10000baseCR to SFF-8431, Appendix-E SFP+ DA
Date: Fri,  3 Jul 2026 15:50:04 +0530
Message-Id: <20260703102004.1111597-1-siddaraju.dh@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304483-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:email,intel.com:mid,intel.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6110C701312

Annotate the 10000baseCR entry in the advertise mask table so users
understand what physical media this mode it actually represents.

10000baseCR does not correspond to any IEEE 802.3 *base-CR PMD.
It has no autonegotiation, no link training, and no mandatory FEC.
The industry standard for this media type is SFF-8431 Appendix-E
Direct Attach cable, also known as 10G_SFI_DA.

Link: https://lore.kernel.org/r/SN7PR11MB69003D33489DB1D6B17EF72A9AF52@SN7PR11MB6900.namprd11.prod.outlook.com

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


