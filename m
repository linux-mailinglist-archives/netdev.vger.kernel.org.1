Return-Path: <netdev+bounces-255208-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A7zCVvtfGmdPQIAu9opvQ
	(envelope-from <netdev+bounces-255208-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:41:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8E1BD62F
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B1C530498F0
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 17:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DA137F749;
	Fri, 30 Jan 2026 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="jjrA99IT"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE59137D11D;
	Fri, 30 Jan 2026 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794674; cv=none; b=NhOQSHb9Ie4DcPOoZ5IbdSNCz4xEH6tS8KnzWSm8/sJJQIqasK39d6+rk7oltZZ1UdOi+zp4iryAA9OldxQEJpOvw8yFss2Kfh0wmG3aPgy7myyQKMwFOK1vEZioEEXfUhPFNbnKlLMe2OxSMy0hrN1U0VDjAE1LtA56rDq4vqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794674; c=relaxed/simple;
	bh=eKrGQqZndJmbrN53FpEmbmtFGaPkTxWIUsyQnfI9a2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ue2sYrLxn9me9qHf2a1Miq54ylQ1hlYG7X1umlSAZvOrhResXLLpgupwEUfG7EjRfNO8Jk+HKAxk49+U48/iy35kf10ERubt0RbmA5sfpglNzGk2J/DEFlmM9ILjX4yWwJxkw6jiMXTY3VH6GNV5vcXuuO7wfDtImvUMJPjGcP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=jjrA99IT; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769794672; x=1801330672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ldAsiYfE+Zft1YuwKt94MhHJ/sfiO6sqo+h4iUvVj1s=;
  b=jjrA99ITKGYj/5tf89tp+oXOKK8Mc1hcnFcHKMZhC9Ybpws7QgoFELmx
   Q+Pj3lpSVv6qKumFiUIPbAQl8IZEEUzTa62Gu/zVIy28GZ+gL1tzVt84i
   NMRK1/f8HEnyQwGniKKSa25gb3TU/6bGOYtQE2XVuHj8pXAsuTupjhJeG
   AATBehxseSXOqlk8BbMdZQO8ebh5ALzjJYGwVqjEambBgkh06a6+JkUA7
   bx1FHJne2UBQlQc9U3MYDcNaA0WjdT6g1i/iVG13Y1fe4F6KjylnLJN/F
   O1ibLamJxmkUOPUyYK3CO2qRaU0X/68QULv08nng4eSm/KRlrX5bG3CCe
   w==;
X-CSE-ConnectionGUID: 7vK6jhG3QAydF2XPuesCIA==
X-CSE-MsgGUID: 98aam8x6R3Sk+Yxy6ds3sQ==
X-IronPort-AV: E=Sophos;i="6.21,263,1763424000"; 
   d="scan'208";a="11938904"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 17:37:52 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:9356]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.174:2525] with esmtp (Farcaster)
 id 8a299df5-e528-45d4-9fe7-56531cccbba8; Fri, 30 Jan 2026 17:37:52 +0000 (UTC)
X-Farcaster-Flow-ID: 8a299df5-e528-45d4-9fe7-56531cccbba8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 30 Jan 2026 17:37:50 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 30 Jan 2026 17:37:47 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Babis Chalios <mail@bchalios.io>, "Alexander
 Graf" <graf@amazon.de>, <mzxreary@0pointer.de>, Marco Cali
	<xmarcalx@amazon.co.uk>, David Woodhouse <dwmw@amazon.co.uk>, "Takahiro
 Itazuri" <itazur@amazon.com>
Subject: [PATCH v7 6/7] ptp: ptp_vmclock: remove dependency on CONFIG_ACPI
Date: Fri, 30 Jan 2026 17:36:05 +0000
Message-ID: <20260130173704.12575-7-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260130173704.12575-1-itazur@amazon.com>
References: <20260130173704.12575-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-255208-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[itazur@amazon.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.co.uk:email,amazon.es:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DB8E1BD62F
X-Rspamd-Action: no action

From: David Woodhouse <dwmw@amazon.co.uk>

Now that we added device tree support we can remove dependency on
CONFIG_ACPI.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Babis Chalios <bchalios@amazon.es>
Tested-by: Takahiro Itazuri <itazur@amazon.dom>
---
 drivers/ptp/Kconfig       |  2 +-
 drivers/ptp/ptp_vmclock.c | 14 ++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index 5f8ea34d1..b93640ca0 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -134,7 +134,7 @@ config PTP_1588_CLOCK_KVM
 config PTP_1588_CLOCK_VMCLOCK
 	tristate "Virtual machine PTP clock"
 	depends on X86_TSC || ARM_ARCH_TIMER
-	depends on PTP_1588_CLOCK && ACPI && ARCH_SUPPORTS_INT128
+	depends on PTP_1588_CLOCK && ARCH_SUPPORTS_INT128
 	default PTP_1588_CLOCK_KVM
 	help
 	  This driver adds support for using a virtual precision clock
diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index 2a173bd28..b6e9d4c96 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -490,6 +490,7 @@ static const struct file_operations vmclock_miscdev_fops = {
 
 /* module operations */
 
+#if IS_ENABLED(CONFIG_ACPI)
 static acpi_status vmclock_acpi_resources(struct acpi_resource *ares, void *data)
 {
 	struct vmclock_state *st = data;
@@ -573,6 +574,7 @@ static int vmclock_probe_acpi(struct device *dev, struct vmclock_state *st)
 
 	return 0;
 }
+#endif /* CONFIG_ACPI */
 
 static irqreturn_t vmclock_of_irq_handler(int __always_unused irq, void *_st)
 {
@@ -616,11 +618,11 @@ static int vmclock_setup_notification(struct device *dev,
 	if (!(le64_to_cpu(st->clk->flags) & VMCLOCK_FLAG_NOTIFICATION_PRESENT))
 		return 0;
 
-	if (has_acpi_companion(dev)) {
+#if IS_ENABLED(CONFIG_ACPI)
+	if (has_acpi_companion(dev))
 		return vmclock_setup_acpi_notification(dev);
-	} else {
-		return vmclock_setup_of_notification(dev);
-	}
+#endif
+	return vmclock_setup_of_notification(dev);
 }
 
 static void vmclock_remove(void *data)
@@ -633,10 +635,12 @@ static void vmclock_remove(void *data)
 		return;
 	}
 
+#if IS_ENABLED(CONFIG_ACPI)
 	if (has_acpi_companion(dev))
 		acpi_remove_notify_handler(ACPI_COMPANION(dev)->handle,
 					   ACPI_DEVICE_NOTIFY,
 					   vmclock_acpi_notification_handler);
+#endif
 
 	if (st->ptp_clock)
 		ptp_clock_unregister(st->ptp_clock);
@@ -664,9 +668,11 @@ static int vmclock_probe(struct platform_device *pdev)
 	if (!st)
 		return -ENOMEM;
 
+#if IS_ENABLED(CONFIG_ACPI)
 	if (has_acpi_companion(dev))
 		ret = vmclock_probe_acpi(dev, st);
 	else
+#endif
 		ret = vmclock_probe_dt(dev, st);
 
 	if (ret) {
-- 
2.50.1


