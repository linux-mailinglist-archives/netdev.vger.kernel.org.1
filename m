Return-Path: <netdev+bounces-237705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE81C4F221
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 17:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542CE3B6BC4
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 16:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25423A1CE1;
	Tue, 11 Nov 2025 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cnai+Czy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5913A377E95;
	Tue, 11 Nov 2025 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879962; cv=none; b=Iiroxzmca8DLOkeRAeQ5b06BqilWqTFX5WZsOtKulhYXa/Im9QWPpXdmF3JjEZMK4+8eMicxg2kB3vw91Ik36TjFB8EhIn4CQ2CJnEhKG/yhGREkEdUf6wPlMSFB2bpYquvhp6a5cYWIUEBjHgJD/oQNxFuihyya0aN/rp2hYVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879962; c=relaxed/simple;
	bh=+mGRztWv8Nj0pIs9FKNvN2RogIeRUEerQvdBRdeidr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPi1Y9N+L14P5rOn0Xdyw577Z5t5KG72qbxUKjogwY3eGzvl8j7Ti4alBWjfNpwAnERcjj7KkiFBjAt1T4UJBhvbKCCeKsfUx2xh8YhMa6asrLWfmvb4/MCesPx+JuZ2c4mUImFGc48kX+MTWhAsTAUFksh3DGMlh/ABb+se8j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cnai+Czy; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762879960; x=1794415960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+mGRztWv8Nj0pIs9FKNvN2RogIeRUEerQvdBRdeidr8=;
  b=cnai+Czy8OLJ5knLNu5OBv+2ekgJiHk7OUr5zSsa45VXSZGgv+q3+6a4
   04uWCB2lrKrY9raUvtXy4aGzL8m4jIchyG06Mb6p8byChfy7Ht58J2wWc
   EepfROwXbSipQGJMTcZ8AwjkB1VYPAUkcS5RQzk2npIjMSRUHoSD+7aE1
   YcioA/3tzvL6yfQ1hVQ8BkP3sKxtJ+A2exlISeN8bvT5JKCVNWYU1gXVO
   e/40vzhtg6UrbZpK/JtgFm7AThpOvFhu0lUCBGfpsYGcQfKw4Yf+sxCF7
   qhOkYti+oSVaiHlaDFlEH7Ph9Mdnuk3S4jxEKSItFJk5ABvIrb0VZx8mv
   A==;
X-CSE-ConnectionGUID: mq6Qb1Y2QnKyFn9UwD60uQ==
X-CSE-MsgGUID: tXxOD7lgSp2odWCdFXtGyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="76049265"
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="76049265"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 08:52:40 -0800
X-CSE-ConnectionGUID: XUmvPO34Q86uSgoPcELyxw==
X-CSE-MsgGUID: 8knKY+ElQkeNWe6LEoQ1JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="193112859"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 11 Nov 2025 08:52:38 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7E2499B; Tue, 11 Nov 2025 17:52:33 +0100 (CET)
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
Subject: [PATCH net-next v1 5/7] ptp: ocp: Reuse META's PCI vendor ID
Date: Tue, 11 Nov 2025 17:52:12 +0100
Message-ID: <20251111165232.1198222-6-andriy.shevchenko@linux.intel.com>
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

The META's PCI vendor ID is listed already in the pci_ids.h.
Reuse it here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ptp/ptp_ocp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 67a4c60cbbcd..4c4b4a40e9d4 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -25,8 +25,7 @@
 #include <linux/crc16.h>
 #include <linux/dpll.h>
 
-#define PCI_VENDOR_ID_FACEBOOK			0x1d9b
-#define PCI_DEVICE_ID_FACEBOOK_TIMECARD		0x0400
+#define PCI_DEVICE_ID_META_TIMECARD		0x0400
 
 #define PCI_VENDOR_ID_CELESTICA			0x18d4
 #define PCI_DEVICE_ID_CELESTICA_TIMECARD	0x1008
@@ -1030,7 +1029,7 @@ static struct ocp_resource ocp_adva_resource[] = {
 };
 
 static const struct pci_device_id ptp_ocp_pcidev_id[] = {
-	{ PCI_DEVICE_DATA(FACEBOOK, TIMECARD, &ocp_fb_resource) },
+	{ PCI_DEVICE_DATA(META, TIMECARD, &ocp_fb_resource) },
 	{ PCI_DEVICE_DATA(CELESTICA, TIMECARD, &ocp_fb_resource) },
 	{ PCI_DEVICE_DATA(OROLIA, ARTCARD, &ocp_art_resource) },
 	{ PCI_DEVICE_DATA(ADVA, TIMECARD, &ocp_adva_resource) },
-- 
2.50.1


