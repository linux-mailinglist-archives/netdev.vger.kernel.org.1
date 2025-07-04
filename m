Return-Path: <netdev+bounces-204046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 154ECAF8A98
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 10:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4201C86323
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97BA2E7BB7;
	Fri,  4 Jul 2025 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ieVxKGns"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE122E425B;
	Fri,  4 Jul 2025 07:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615684; cv=none; b=ivqMU5pmqK7c6EBR/NQXbZasYaG6EUa//luomj2iw+N5aXExcUMjtWuuX1DGz/6WN+19ne1Hlw2MJ/z8s+Ih0XmNnbQMVqKNkeC9gZwq92p56zo2XKYoRY2mzNanW6bOk+Zj3VFd6YUBX0Y7IWjd7kqq9AlDDXTXkogyOFFxrPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615684; c=relaxed/simple;
	bh=8QGS586pL2Vx2KX9XeLloe4i2zvKJP8iAOXD73uMv0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T/r5Bg/e6e52vezdkVRfYHJPaez/mR+pTYVIVFNziKHV/aZTP4O58ZWYYQOmQYV102ZV5tjIua1XDNHmoYH0SW3fdvF0A/RD0znp+7WDt4HaRLWd6LnHYvQWqEGXeVW/4psrrrTIWHv1mchNLJk5iSA64jKQnySKzS8ngf7EjOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ieVxKGns; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615683; x=1783151683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8QGS586pL2Vx2KX9XeLloe4i2zvKJP8iAOXD73uMv0c=;
  b=ieVxKGnsRTK/XMNVsxHqXDSaL2XpkOb9qoibpfComGY3ASw7h8p3RZPY
   yH1ltL3ifhdCpVPKXk2dBZxZhhndkqu+8klU8WmTX2awMr+MRZ+DIZa7y
   QWRH+aUM3uBosadx3PgISIHCMJhHGFcbFtqk17VCJUsbkKLqMdAGXkNjf
   L5mg9KeYfpsjpg95IOP7OAOk6cW9VVO9LlFmCCy9Vpqg19numRDUNbwVm
   dzNmd7xJE78AmZD2x2WLNYg52qNlJlNsidzDFzbYB73moq/J8R42HSs8S
   7/ybsrYQSl++NSgH9xgoysdvI+S2EsuuWWwhM1kn5VNRKT10FBWhDvHKF
   g==;
X-CSE-ConnectionGUID: ux1RhkpbReq2cnQJ5C8V+Q==
X-CSE-MsgGUID: rItfn04ST+G9trjB7SviyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64194118"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="64194118"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:42 -0700
X-CSE-ConnectionGUID: A742lPtkQpWtJwUYEUKHpQ==
X-CSE-MsgGUID: VgCYBLmTSoqFu9DCqiqNIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158616578"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:39 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id 02E4744394;
	Fri,  4 Jul 2025 10:54:37 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Alex Elder <elder@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 47/80] net: ipa: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:36 +0300
Message-Id: <20250704075436.3220762-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
pm_runtime_mark_last_busy().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
The cover letter of the set can be found here
<URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.

In brief, this patch depends on PM runtime patches adding marking the last
busy timestamp in autosuspend related functions. The patches are here, on
rc2:

        git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
                pm-runtime-6.17-rc1

 drivers/net/ipa/ipa_interrupt.c | 1 -
 drivers/net/ipa/ipa_main.c      | 1 -
 drivers/net/ipa/ipa_modem.c     | 4 ----
 drivers/net/ipa/ipa_smp2p.c     | 2 --
 drivers/net/ipa/ipa_uc.c        | 2 --
 5 files changed, 10 deletions(-)

diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
index 245a06997055..8336596b1247 100644
--- a/drivers/net/ipa/ipa_interrupt.c
+++ b/drivers/net/ipa/ipa_interrupt.c
@@ -149,7 +149,6 @@ static irqreturn_t ipa_isr_thread(int irq, void *dev_id)
 		iowrite32(pending, ipa->reg_virt + reg_offset(reg));
 	}
 out_power_put:
-	pm_runtime_mark_last_busy(dev);
 	(void)pm_runtime_put_autosuspend(dev);
 
 	return IRQ_HANDLED;
diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index f25f6e2cf58c..b37516de01fa 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -911,7 +911,6 @@ static int ipa_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_deconfig;
 done:
-	pm_runtime_mark_last_busy(dev);
 	(void)pm_runtime_put_autosuspend(dev);
 
 	return 0;
diff --git a/drivers/net/ipa/ipa_modem.c b/drivers/net/ipa/ipa_modem.c
index 8fe0d0e1a00f..9b136f6b8b4a 100644
--- a/drivers/net/ipa/ipa_modem.c
+++ b/drivers/net/ipa/ipa_modem.c
@@ -71,7 +71,6 @@ static int ipa_open(struct net_device *netdev)
 
 	netif_start_queue(netdev);
 
-	pm_runtime_mark_last_busy(dev);
 	(void)pm_runtime_put_autosuspend(dev);
 
 	return 0;
@@ -102,7 +101,6 @@ static int ipa_stop(struct net_device *netdev)
 	ipa_endpoint_disable_one(priv->rx);
 	ipa_endpoint_disable_one(priv->tx);
 out_power_put:
-	pm_runtime_mark_last_busy(dev);
 	(void)pm_runtime_put_autosuspend(dev);
 
 	return 0;
@@ -175,7 +173,6 @@ ipa_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 
 	ret = ipa_endpoint_skb_tx(endpoint, skb);
 
-	pm_runtime_mark_last_busy(dev);
 	(void)pm_runtime_put_autosuspend(dev);
 
 	if (ret) {
@@ -432,7 +429,6 @@ static void ipa_modem_crashed(struct ipa *ipa)
 		dev_err(dev, "error %d zeroing modem memory regions\n", ret);
 
 out_power_put:
-	pm_runtime_mark_last_busy(dev);
 	(void)pm_runtime_put_autosuspend(dev);
 }
 
diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
index fcaadd111a8a..420098796eec 100644
--- a/drivers/net/ipa/ipa_smp2p.c
+++ b/drivers/net/ipa/ipa_smp2p.c
@@ -171,7 +171,6 @@ static irqreturn_t ipa_smp2p_modem_setup_ready_isr(int irq, void *dev_id)
 	WARN(ret != 0, "error %d from ipa_setup()\n", ret);
 
 out_power_put:
-	pm_runtime_mark_last_busy(dev);
 	(void)pm_runtime_put_autosuspend(dev);
 
 	return IRQ_HANDLED;
@@ -213,7 +212,6 @@ static void ipa_smp2p_power_release(struct ipa *ipa)
 	if (!ipa->smp2p->power_on)
 		return;
 
-	pm_runtime_mark_last_busy(dev);
 	(void)pm_runtime_put_autosuspend(dev);
 	ipa->smp2p->power_on = false;
 }
diff --git a/drivers/net/ipa/ipa_uc.c b/drivers/net/ipa/ipa_uc.c
index 2963db83ab6b..dc7e92f2a4fb 100644
--- a/drivers/net/ipa/ipa_uc.c
+++ b/drivers/net/ipa/ipa_uc.c
@@ -158,7 +158,6 @@ static void ipa_uc_response_hdlr(struct ipa *ipa)
 		if (ipa->uc_powered) {
 			ipa->uc_loaded = true;
 			ipa_power_retention(ipa, true);
-			pm_runtime_mark_last_busy(dev);
 			(void)pm_runtime_put_autosuspend(dev);
 			ipa->uc_powered = false;
 		} else {
@@ -203,7 +202,6 @@ void ipa_uc_deconfig(struct ipa *ipa)
 	if (!ipa->uc_powered)
 		return;
 
-	pm_runtime_mark_last_busy(dev);
 	(void)pm_runtime_put_autosuspend(dev);
 }
 
-- 
2.39.5


