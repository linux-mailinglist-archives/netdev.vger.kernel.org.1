Return-Path: <netdev+bounces-283729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ4cMONP+GmQsQIAu9opvQ
	(envelope-from <netdev+bounces-283729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:50:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C824B9A58
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0550D3021E78
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 07:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF51E30F7FB;
	Mon,  4 May 2026 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDNdhp93"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0211B86C7;
	Mon,  4 May 2026 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880776; cv=none; b=kqoSFUXykPCrZyYiyA8E8RHR5pky4/1h17Ja/zx2jHZmpRUYMxyC+WG2HZJT6fA/YhMhWrKtaacKhsluQjU9ijl4XyEtTmuM/2LlTir8pz36ZAosp8NmoMZxiHZ6heliToS+b754AKqB1Y4HkBsb8GjrHbMcbdSfbd4T9x7cLXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880776; c=relaxed/simple;
	bh=Cvd5ntP90qdguZuMHt7/zN+EWJYb38X76+r7tyG2oMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UsYdcnQHsNwV/aiZsUyDCqeqFGHm9pjtcvoMHQJQ6ZLjHkDiZAZsFsad5DMNp4oqL/PJ1j+6350X8/0cHc+78qAh4HTWbL/FZDfqsRHML/TNpe2BdOCg4gVfRjjCk5kjetuyo7AjThUuydwyRRShA4Kh4bqRn1owqVujHLGWcXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDNdhp93; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777880775; x=1809416775;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Cvd5ntP90qdguZuMHt7/zN+EWJYb38X76+r7tyG2oMg=;
  b=fDNdhp93zwt7CN6+Z8+GNhVsgP3OdBv9j/yi82rLuXkQnMoX9FyMwLvD
   QErh2PaBfl97czzwz3W90LfJrqvsmVloCETCsRRfA5BPgd+qiyjniGlqF
   eqzgMYdPXC6ExAwefLBEtmDWyK8zO2rUEowE/VG8ApEQhqlWoyikbAH+f
   Sy+kVM9XCb4fyM9xdv7ZsJqhXxOpNiJgZBD7+/SoRaWhRCBPH0uINLOhT
   KhYWifEjzSx9uOLly4luQSsG4pu886z7GfNMH5n8KSFO8INN0tvEf3trz
   0x0M2GQy7V1ySNVBbqsvfQfIk0OM+6sXpmGWPzUOjjbM4Erxl/dHue+Gm
   A==;
X-CSE-ConnectionGUID: cnD+M7akTze/w/Kqc38Ijw==
X-CSE-MsgGUID: bjDAbhgmSW2u7UGqjfCKUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="66265157"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="66265157"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:46:15 -0700
X-CSE-ConnectionGUID: 1vZ3ESfZTHyn/4VBf4lUJA==
X-CSE-MsgGUID: l4qatjVcSJy53T6XK8Hrbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="228949937"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 04 May 2026 00:46:12 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 07FEF98; Mon, 04 May 2026 09:46:11 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next v1 0/5] net: mdiobus: HIde ACPI implementation
Date: Mon,  4 May 2026 09:29:51 +0200
Message-ID: <20260504074610.40799-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 43C824B9A58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283729-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]

This mini-series is dedicated to hiding ACPI implementation details
from the wider users as they (as of today) do not need to know that.
That also introduces the agnostic API that is preferred over OF /
ACPI / et cetera one.

I haven't tried to unify __*_mdiobus_register() as it seems using
something that may differ in ACPI vs. OF cases, it can be done later
on, if one knows how to do that with all the details.

The change has been compile tested (including configurations with
CONFIG_ACPI=n).

Andy Shevchenko (5):
  net: mdiobus: Provide fwnode_mdiobus_register()
  net: mvmdio: Switch to using fwnode_mdiobus_register()
  net/fsl: xgmac_mdio: Switch to using fwnode_mdiobus_register()
  net/fsl: xgmac_mdio: Reuse existing pointer to fwnode
  net: mdiobus: Hide acpi_mdio.h

 drivers/net/ethernet/freescale/xgmac_mdio.c | 23 +++++---------
 drivers/net/ethernet/marvell/mvmdio.c       | 11 ++-----
 drivers/net/mdio/acpi_mdio.c                |  3 +-
 drivers/net/mdio/fwnode_mdio.c              | 16 ++++++++++
 drivers/net/mdio/mdio.h                     |  4 +++
 include/linux/acpi_mdio.h                   | 33 ---------------------
 include/linux/fwnode_mdio.h                 | 17 +++++++++++
 7 files changed, 49 insertions(+), 58 deletions(-)
 create mode 100644 drivers/net/mdio/mdio.h
 delete mode 100644 include/linux/acpi_mdio.h

-- 
2.50.1


