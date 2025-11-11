Return-Path: <netdev+bounces-237706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A480C4F22A
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 17:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88263B85BA
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 16:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191CF3A1CF2;
	Tue, 11 Nov 2025 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VcxKMTdr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACF0377EBB;
	Tue, 11 Nov 2025 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879963; cv=none; b=s5sWDDgBvQTXTe2rYlk7lK5eIsGB4MK6DG6MlxPc4uZrLPX3HvfoS1f2Dx+lN/3bWs5jxlWizeCjAFp3uWzI9L3OAmkLRsSCDMshywJEeotrDtzIJRmzcEODFqsp1tQfwKcqpjE8K19kLZVNHnZ/MHhS9ck3pMeosI7xuvO+sDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879963; c=relaxed/simple;
	bh=Irrh/WMb2YZkLZ9X0VUJAWMO052t7dNADxKM31U8lOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zy5HZD0xuaTA0vjq5tDvGVSerw2wkS5KiMP3ttNQcnCqqg6bj/YrcL3hKc1yHCHglZeJVkQ4P8blxUFCTfaCo3AFoa2Bh7vnO+YgszWhyTVkoR9v2CWOXNE1bLc1VFk2KpqheU4Ob2oR6UKhsB4prb0dLcmnWDdTpKnbjYjP/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VcxKMTdr; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762879961; x=1794415961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Irrh/WMb2YZkLZ9X0VUJAWMO052t7dNADxKM31U8lOQ=;
  b=VcxKMTdr6fuuE5k6WwsnLWLfpjk4k53eOFVohaZHuVL7WPPNxOvx2R/y
   2hL/2YqZz2NidXyXOTjkhXmZ5q3fpwp17pOLRzQEqM7moucY1RbvpzdKE
   IIwjEY9TSvAbd5iCGkntVIMK2Qb+YCApKLh5rKDdaSR89V64uCfIeIruV
   y4aarfKZH6BpTTJuK1qjok1v5fj0XqsreAYFjdqoXDqQu9G05WR0X77bX
   bgPKPcuHO1WxsiANjB6aryJL6FnwAo7kUM5yU+4uFbri0aFzcQEB4zT18
   LV9UwH+AaLQJJbspUS6vdNbA/90OfrrqARYoLpFg9mLkp0x7HRvspY/V1
   A==;
X-CSE-ConnectionGUID: wWdOofY5TWW6I5EXFGqXOw==
X-CSE-MsgGUID: Iqh3RYYsRfiKEz+7ATBwrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="64647272"
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="64647272"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 08:52:36 -0800
X-CSE-ConnectionGUID: 7moGsZunRyO9WGPELpD3Bg==
X-CSE-MsgGUID: v6pu9y1QTb6FxQKdsQ49FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="194202545"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 11 Nov 2025 08:52:35 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 70E3898; Tue, 11 Nov 2025 17:52:33 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v1 2/7] ptp: ocp: Make ptp_ocp_unregister_ext() NULL-aware
Date: Tue, 11 Nov 2025 17:52:09 +0100
Message-ID: <20251111165232.1198222-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251111165232.1198222-1-andriy.shevchenko@linux.intel.com>
References: <20251111165232.1198222-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's a common practice to make resource release functions be NULL-aware.
Make ptp_ocp_unregister_ext() NULL-aware.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ptp/ptp_ocp.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 95889f85ffb2..28243fb1d78f 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -2225,6 +2225,9 @@ ptp_ocp_ts_enable(void *priv, u32 req, bool enable)
 static void
 ptp_ocp_unregister_ext(struct ptp_ocp_ext_src *ext)
 {
+	if (!ext)
+		return;
+
 	ext->info->enable(ext, ~0, false);
 	pci_free_irq(ext->bp->pdev, ext->irq_vec, ext);
 	kfree(ext);
@@ -4558,21 +4561,14 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 	ptp_ocp_detach_sysfs(bp);
 	ptp_ocp_attr_group_del(bp);
 	timer_delete_sync(&bp->watchdog);
-	if (bp->ts0)
-		ptp_ocp_unregister_ext(bp->ts0);
-	if (bp->ts1)
-		ptp_ocp_unregister_ext(bp->ts1);
-	if (bp->ts2)
-		ptp_ocp_unregister_ext(bp->ts2);
-	if (bp->ts3)
-		ptp_ocp_unregister_ext(bp->ts3);
-	if (bp->ts4)
-		ptp_ocp_unregister_ext(bp->ts4);
-	if (bp->pps)
-		ptp_ocp_unregister_ext(bp->pps);
+	ptp_ocp_unregister_ext(bp->ts0);
+	ptp_ocp_unregister_ext(bp->ts1);
+	ptp_ocp_unregister_ext(bp->ts2);
+	ptp_ocp_unregister_ext(bp->ts3);
+	ptp_ocp_unregister_ext(bp->ts4);
+	ptp_ocp_unregister_ext(bp->pps);
 	for (i = 0; i < 4; i++)
-		if (bp->signal_out[i])
-			ptp_ocp_unregister_ext(bp->signal_out[i]);
+		ptp_ocp_unregister_ext(bp->signal_out[i]);
 	for (i = 0; i < __PORT_COUNT; i++)
 		if (bp->port[i].line != -1)
 			serial8250_unregister_port(bp->port[i].line);
-- 
2.50.1


