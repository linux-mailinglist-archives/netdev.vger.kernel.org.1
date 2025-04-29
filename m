Return-Path: <netdev+bounces-186891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCCEAA3CDF
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 01:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 275F37A7208
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 23:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A33D23184B;
	Tue, 29 Apr 2025 23:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vqje/MwU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D550A280307
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 23:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970422; cv=none; b=MSNQMi3b1/yrjhZ7YLrUy9tUJguV1Ty8hkcu5WoNE9J4HqT6TYncZ5dtPlf09/7EmkfQRb12WivTJXwFxYEwjwW9z/3PCPPFjMuDHh3ZAEgvKdeW7LlJNjvEZ4XkVTQ5uNqUxCTBscp270ewpDi/iJ68033LGxwEX6phJMtGrX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970422; c=relaxed/simple;
	bh=7dDUZyMQdEF5M1IYD5xfBSI7m9WSH0zRtUcXyFp8Y/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDAVRqa80PrCJQfSZ37mmWYwMRT2tyiXHhNB9woj1CnE65Gdg0HQRACXjbUdrxYbot5dhADb8/qHx/kQMtygH4yDJl+TBSB/xXx/TWwgfBrLcx8MgPQKPE1CVF3HeCgGFalxRwWlsTDoo8y2sz8nZtTeWZMV/2R9g4q/tHir5/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vqje/MwU; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745970421; x=1777506421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7dDUZyMQdEF5M1IYD5xfBSI7m9WSH0zRtUcXyFp8Y/o=;
  b=Vqje/MwU0TJ9CEYpwrfzLGtDYc3c44h7GJj7ziQyNZnOhRO5bx7OnqcS
   rTILi2swC192LdN2pHD1Ywpyz81ruOmRWsa6L5ZaOYPArnMzZ6fiiTv36
   fTEFWJG96KDuW8do+alXE8hsgiRpUWw9hhA1YWTMlMkV0S2YT5uZmT1Bs
   jyHTinEe5aMepGiXyzhapt+PIdex2Ng169cKQMl5o/WV/uyIG2TIJW1VV
   qLxsmB7vjRPypgxQGiycKamDm4RS4+atu4WgRtHPk2y/Jc0/Ilayx2/M+
   xHtHa2pGMwkbf+8HA7fShEIX/CM/iMOqX1KvzBevE3M2j3Xj0+gS12WDT
   g==;
X-CSE-ConnectionGUID: lz5cp6OwSqOtl1MFT7tKRQ==
X-CSE-MsgGUID: KVVr5g5hRWyDznfUuN0TTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="58990054"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="58990054"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 16:47:00 -0700
X-CSE-ConnectionGUID: f8WkswYkSiqtO4OfAde8DA==
X-CSE-MsgGUID: lEvj/MwVRNSwdovMJ2rmjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="137979608"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 29 Apr 2025 16:46:58 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	anthony.l.nguyen@intel.com,
	bigeasy@linutronix.de,
	gerhard@engleder-embedded.com,
	jdamato@fastly.com,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 01/13] igb: Link IRQs to NAPI instances
Date: Tue, 29 Apr 2025 16:46:36 -0700
Message-ID: <20250429234651.3982025-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429234651.3982025-1-anthony.l.nguyen@intel.com>
References: <20250429234651.3982025-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kurt Kanzenbach <kurt@linutronix.de>

Link IRQs to NAPI instances via netdev-genl API. This allows users to query
that information via netlink:

|$ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
|                               --dump napi-get --json='{"ifindex": 2}'
|[{'defer-hard-irqs': 0,
|  'gro-flush-timeout': 0,
|  'id': 8204,
|  'ifindex': 2,
|  'irq': 127,
|  'irq-suspend-timeout': 0},
| {'defer-hard-irqs': 0,
|  'gro-flush-timeout': 0,
|  'id': 8203,
|  'ifindex': 2,
|  'irq': 126,
|  'irq-suspend-timeout': 0},
| {'defer-hard-irqs': 0,
|  'gro-flush-timeout': 0,
|  'id': 8202,
|  'ifindex': 2,
|  'irq': 125,
|  'irq-suspend-timeout': 0},
| {'defer-hard-irqs': 0,
|  'gro-flush-timeout': 0,
|  'id': 8201,
|  'ifindex': 2,
|  'irq': 124,
|  'irq-suspend-timeout': 0}]
|$ cat /proc/interrupts | grep enp2s0
|123:          0          1 IR-PCI-MSIX-0000:02:00.0   0-edge      enp2s0
|124:          0          7 IR-PCI-MSIX-0000:02:00.0   1-edge      enp2s0-TxRx-0
|125:          0          0 IR-PCI-MSIX-0000:02:00.0   2-edge      enp2s0-TxRx-1
|126:          0          5 IR-PCI-MSIX-0000:02:00.0   3-edge      enp2s0-TxRx-2
|127:          0          0 IR-PCI-MSIX-0000:02:00.0   4-edge      enp2s0-TxRx-3

Reviewed-by: Joe Damato <jdamato@fastly.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index c646c71915f0..401af6dce2a8 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -947,6 +947,9 @@ static int igb_request_msix(struct igb_adapter *adapter)
 				  q_vector);
 		if (err)
 			goto err_free;
+
+		netif_napi_set_irq(&q_vector->napi,
+				   adapter->msix_entries[vector].vector);
 	}
 
 	igb_configure_msix(adapter);
-- 
2.47.1


