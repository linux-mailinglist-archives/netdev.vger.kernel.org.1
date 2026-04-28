Return-Path: <netdev+bounces-282096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EK4JGhkw8WnzeQEAu9opvQ
	(envelope-from <netdev+bounces-282096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:09:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A24A48C79E
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1CEA13016B16
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 22:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA94372EF9;
	Tue, 28 Apr 2026 22:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e8/slquh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com [74.125.82.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ABB37A48D
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 22:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777414150; cv=none; b=M5nIG3567P7h664b33BGpN1imGAvBpocC4Ql3CrLhUj9JshIBXriY+2SwQ8R2FsTNrT/s6YGpjJYe0YQ8G/ZF1f+Hju02A2fPcpSr4HxGC3O3hfjkWNJl8OM0dP0rn6cjysPx/p39pHphII8RvW+ow3VsfvIgNIh2WWglXrTkHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777414150; c=relaxed/simple;
	bh=MwnyuX3vGYdUGHZyQU51+ccvJFh/LMuWzMsKpUZYu14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jk5ugGoscChCI1qT68G0lRsgt4oyXu7x9mpoNgBJ3a/neYEgD8InPxNfXT6aE2Sdk799ZNdvqJgzrHTg2WX7s5CDA61Rh12xl98SVaKWtEUasLaU1lEiAayGS95q1yGgiabPcL8NUXY1HmT0W6ZbnFg8+ylzACPCBURiJ+SzXow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e8/slquh; arc=none smtp.client-ip=74.125.82.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f226.google.com with SMTP id 5a478bee46e88-2c156c4a9efso16596051eec.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777414148; x=1778018948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=71i+PxMxsvufi3+fVFnBy+e94Vu82te7Lq5tp4Vppuk=;
        b=cfOE67mz7WvK9tP3GUN1ddWFkwv7N8dpgByHBWHQ2KhVnvDBilbCHcRb4c4I+QoKCM
         GEWFXO8CCcoFUEPsYgZkh9JKanxzNuiev7iMPSPy7c23XbFGsssHZR5S2udxYGYjYvsD
         stvU9oubhuEL2nLQEfKS2ceuox+UmBqyoWnaIoUNbWPzbiISNrpmcCpVgaVTiORj+EE6
         b0EMQ89CwGfBa1IkQXxPijoTwgihE+l4oiZtaSwq1704FD7QN/4QITM/5N7hki+J1B2Z
         uOwlw7790ed4bqI4mxVddCgi0EXAA3UYskbigP/M3tZGhTNhyO7WC2L4G03DAYgoF6yF
         ZY3w==
X-Gm-Message-State: AOJu0YzxhkekCIiXYkh14/2EV6L6wbRBaF1jhcDPuvOsm0uplWeQrRdB
	oGA7LKIexk7Pzrs2KuG25NLNEQgg0eff7Hqi2ZcV+Ad54p4/uEIPOil5t1EfcgiAsqoLpv7o7NI
	+07T+K6ArmzWTBW+C0qz0ngHyybHa4Iw4XqPW/l0JMYS+pdvsqfRCjSgAY1AZwIC4//JD6RkDkv
	Zs9Eze4OA3dZf9gjhPXzxNYqAzTdV+DDPcCHx1zXCETqNWM1eKDAHRooZfjz8i+48ckTuhCIAMm
	EAsT1Wyhw==
X-Gm-Gg: AeBDietNiDBszJCifhjkbEqn52jcrG0meKXnXypBspcvwz5Jjy9lYxy3/WuY/ezJ/NL
	9Degkxd0/aoAr6HvbxULI5jzjd4lU1c+PygE6WmYnsH8z9rxmefCA8CHi4ggnVTd9HIlgQFXQtu
	Kjnp8eEZKLefb7ulmzJa9mWoexSkE+rJwhH2dv9layAXxpI2dFDQuXiSUysjPWFUQyfdZzBKQ9N
	/zD0y87W9ueeXVI1KuzAsbRHaivTtPacns52wUIZkAJkesmoyy+8DTHWFSYHdVEdZ2X5wVeak4u
	mqdEoimEDA0O3AlXAzrEpsBPMvk2PJiNILDOZTssWqp08GOlVVQZmkdgtxdWu8/SiRAaK7KyOfa
	Bz35f0XSfCrybWbEc/EXm2jEbDhJF/DWA6Eh0RdBL6Ru9RxuGKEfPVPe13hNkXf5jiFdQPlK/pF
	ydrv5W/3QrNyqoOprUmrDfW3ZK8i2ZNJIEx6+ZYZxxkgK37ipNuqR5+yFdfQtKw3NBpvo9
X-Received: by 2002:a05:7300:6da5:b0:2da:2ec2:64fe with SMTP id 5a478bee46e88-2ed1990a448mr739906eec.24.1777414148240;
        Tue, 28 Apr 2026 15:09:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2ed1bf8c1c5sm16305eec.10.2026.04.28.15.09.07
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2026 15:09:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50fbc70cfbdso198928591cf.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777414146; x=1778018946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71i+PxMxsvufi3+fVFnBy+e94Vu82te7Lq5tp4Vppuk=;
        b=e8/slquhexqfEgKBsYvRwyDvqmOcK2mdHhQYQx1aMCML99FPvJOQBkLSInBIkeEph8
         NhzjD5x/SXB1NHZnxL3ZEADhN8U1Ve5y36XCkw8tG7flmOkP5AeDAPO+5Q1t/Sq6Fd1g
         ncGD2MoAptItVtzO+M0lbmRrAaizp+IDVXSgI=
X-Received: by 2002:ac8:7dcf:0:b0:50e:5a87:6c0c with SMTP id d75a77b69052e-510189a8378mr22956631cf.24.1777414146518;
        Tue, 28 Apr 2026 15:09:06 -0700 (PDT)
X-Received: by 2002:ac8:7dcf:0:b0:50e:5a87:6c0c with SMTP id d75a77b69052e-510189a8378mr22956081cf.24.1777414145941;
        Tue, 28 Apr 2026 15:09:05 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5101ae3ced9sm1410181cf.14.2026.04.28.15.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:09:05 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next 2/2] net: bcmasp: Keep PHY link during WoL sleep cycle
Date: Tue, 28 Apr 2026 15:08:58 -0700
Message-Id: <20260428220858.2076469-3-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428220858.2076469-1-justin.chen@broadcom.com>
References: <20260428220858.2076469-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 8A24A48C79E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-282096-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

We currently more or less restart all the HW on resume. Since we also
stop the PHY, it takes a while for the PHY link to be re-negotiated on
resume. Instead of doing a full restart, we keep the HW state and the
PHY link, that way we can resume network traffic with a much smaller
delay.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  | 48 +++++++++++++------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index aff0a6d84126..bab2a4f82e4e 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -923,7 +923,7 @@ static void bcmasp_phy_hw_unprepare(struct bcmasp_intf *intf)
 		bcmasp_rgmii_mode_en_set(intf, false);
 }
 
-static void bcmasp_netif_deinit(struct net_device *dev)
+static void bcmasp_netif_deinit(struct net_device *dev, bool stop_phy)
 {
 	struct bcmasp_intf *intf = netdev_priv(dev);
 	u32 reg, timeout = 1000;
@@ -946,7 +946,8 @@ static void bcmasp_netif_deinit(struct net_device *dev)
 
 	umac_enable_set(intf, UMC_CMD_TX_EN, 0);
 
-	phy_stop(dev->phydev);
+	if (stop_phy)
+		phy_stop(dev->phydev);
 
 	umac_enable_set(intf, UMC_CMD_RX_EN, 0);
 
@@ -974,7 +975,7 @@ static int bcmasp_stop(struct net_device *dev)
 	/* Stop tx from updating HW */
 	netif_tx_disable(dev);
 
-	bcmasp_netif_deinit(dev);
+	bcmasp_netif_deinit(dev, true);
 
 	bcmasp_reclaim_free_buffers(intf);
 
@@ -1383,15 +1384,20 @@ int bcmasp_interface_suspend(struct bcmasp_intf *intf)
 {
 	struct device *kdev = &intf->parent->pdev->dev;
 	struct net_device *dev = intf->ndev;
+	bool wake;
 
 	if (!netif_running(dev))
 		return 0;
 
 	netif_device_detach(dev);
 
-	bcmasp_netif_deinit(dev);
+	wake = device_may_wakeup(kdev) && intf->wolopts;
 
-	if (!intf->wolopts) {
+	bcmasp_netif_deinit(dev, !wake);
+
+	if (wake) {
+		bcmasp_suspend_to_wol(intf);
+	} else {
 		bcmasp_phy_hw_unprepare(intf);
 
 		/* If Wake-on-LAN is disabled, we can safely
@@ -1400,9 +1406,6 @@ int bcmasp_interface_suspend(struct bcmasp_intf *intf)
 		bcmasp_core_clock_set_intf(intf, false);
 	}
 
-	if (device_may_wakeup(kdev) && intf->wolopts)
-		bcmasp_suspend_to_wol(intf);
-
 	clk_disable_unprepare(intf->parent->clk);
 
 	return 0;
@@ -1426,8 +1429,11 @@ static void bcmasp_resume_from_wol(struct bcmasp_intf *intf)
 
 int bcmasp_interface_resume(struct bcmasp_intf *intf)
 {
+	struct device *kdev = &intf->parent->pdev->dev;
 	struct net_device *dev = intf->ndev;
+	bool wake;
 	int ret;
+	u32 reg;
 
 	if (!netif_running(dev))
 		return 0;
@@ -1436,17 +1442,31 @@ int bcmasp_interface_resume(struct bcmasp_intf *intf)
 	if (ret)
 		return ret;
 
-	bcmasp_core_clock_set_intf(intf, true);
-
-	bcmasp_resume_from_wol(intf);
+	wake = device_may_wakeup(kdev) && intf->wolopts;
 
-	bcmasp_phy_hw_prepare(intf);
+	bcmasp_core_clock_set_intf(intf, true);
 
-	umac_reset_and_init(intf, dev->dev_addr);
+	/* The interface might be HW reset in some suspend modes, so we may
+	 * need to restore the UNIMAC/PHY if that is the case.
+	 */
+	reg = umac_rl(intf, UMC_CMD);
+	if (wake && (reg & UMC_CMD_RX_EN)) {
+		umac_enable_set(intf, UMC_CMD_TX_EN, 1);
+		bcmasp_resume_from_wol(intf);
+	} else {
+		bcmasp_phy_hw_prepare(intf);
+		umac_reset_and_init(intf, dev->dev_addr);
+	}
 
 	bcmasp_netif_init(dev);
 
-	phy_start(dev->phydev);
+	/* If HW was reset, we need to force a link re-negotiation */
+	if (wake && !(reg & UMC_CMD_RX_EN)) {
+		phy_restart_aneg(dev->phydev);
+		phy_trigger_machine(dev->phydev);
+	} else if (!wake) {
+		phy_start(dev->phydev);
+	}
 
 	netif_device_attach(dev);
 
-- 
2.34.1


