Return-Path: <netdev+bounces-267006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lnIlOGOSsmnONgAAu9opvQ
	(envelope-from <netdev+bounces-267006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:16:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A80B2703C7
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29D543145A3D
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1083E3C141A;
	Thu, 12 Mar 2026 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uTy1jOSg"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1683C0628;
	Thu, 12 Mar 2026 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310333; cv=none; b=UIJWjn0wNs7i7xPzyxZtGk81NwDpr+DcMNliwkhnjrhShxiR+zTuA5QBEfFSOdI6mKWzWQ5+FVkDLp6yydrah48WdU4ciT8/r5gDdiFuEg0qkaHPG/NSpJIu7QG2o1pQh2p4xtf3M3pN/wb4oTr0EzNWZRyRMKxGcrDOKL3DgYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310333; c=relaxed/simple;
	bh=0JNH+vV9m6Q+pG8VsJX1wdlMdhhBGkOHek4F0EB6bdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jjAqqgUmT7cTAsYSMeDqpRVmj/1KMHzMZk/yorJaOWRVPIulJ2WJvfBGv6LohsLFB91puLyptm9D6JxrbhOwXziav9ZQRjw4Vwx6QUNi1YFyX9itWqey5xNGTggKLB5Xx4NKRmErt4dyIN/ebk7qOnCcBFsJB7BwMoRRDFliG3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uTy1jOSg; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 19E0C1A2DEB;
	Thu, 12 Mar 2026 10:12:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DF6365FDEB;
	Thu, 12 Mar 2026 10:12:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3782310369C61;
	Thu, 12 Mar 2026 11:12:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773310327; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZScxyatlTWwp4VNBkqTha4B6duYhO6GHXUx9ibpGkcE=;
	b=uTy1jOSgn+W8bTv2Bu4HIkJ8axtG/wxKhMn+PbT6zK+r5oqzCkIgeV0QZcW/LQGyWkDjIC
	21cUmsPqAuliL36gz5dC82ca7VnYBtrVVlmCYMFT9c+OGPOzrVTACPxsT/Jsp79ELcW9ZL
	yDHOVpcBarPpgEcakALDfZgunbdvLRP/lvbcGrwswLN2uzGPCP0LewYtKmyi3mzm6oqtYa
	uQ+JpyQUuK7PfkpMx+RFci2j2NzaSgbgR0ci0gGlLRxhydcEChudsq5l6rvSM2BHdZhO6x
	BF/fUQAiyBZ0xoCx4Z+5LKINSwkONA2qgogKbav9QeWb1pIqGRpxAWSKWSdxFw==
From: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
To: theo.lebrun@bootlin.com
Cc: Ryan.Wanner@microchip.com,
	Valentina.FernandezAlanis@microchip.com,
	abin.joseph@amd.com,
	alex@ghiti.fr,
	andrew+netdev@lunn.ch,
	aou@eecs.berkeley.edu,
	claudiu.beznea@tuxon.dev,
	conor+dt@kernel.org,
	conor.dooley@microchip.com,
	conor@kernel.org,
	daire.mcnamara@microchip.com,
	dave.stevenson@raspberrypi.com,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	edumazet@google.com,
	gregory.clement@bootlin.com,
	krzk+dt@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org,
	nicolas.ferre@microchip.com,
	pabeni@redhat.com,
	palmer@dabbelt.com,
	pjw@kernel.org,
	richardcochran@gmail.com,
	robh@kernel.org,
	samuel.holland@sifive.com,
	sean.anderson@linux.dev,
	thomas.petazzoni@bootlin.com,
	vineeth.karumanchi@amd.com
Subject: [PATCH 2/3] net: macb: set MACB_CAPS_USRIO_DISABLED if no usrio config is provided
Date: Thu, 12 Mar 2026 11:11:37 +0100
Message-ID: <20260312101138.465482-2-theo.lebrun@bootlin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312101138.465482-1-theo.lebrun@bootlin.com>
References: <DH0PZN0WJZC5.26KLH464PMMTP@bootlin.com>
 <20260312101138.465482-1-theo.lebrun@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,amd.com,ghiti.fr,lunn.ch,eecs.berkeley.edu,tuxon.dev,kernel.org,raspberrypi.com,davemloft.net,vger.kernel.org,google.com,bootlin.com,lists.infradead.org,redhat.com,dabbelt.com,gmail.com,sifive.com,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267006-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A80B2703C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bp->usrio is copied directly from dt_conf->usrio in macb_probe().

If dt_conf->usrio is NULL, we do not want to land in USRIO write
codepaths which dereference bp->usrio. Inherit automatically
MACB_CAPS_USRIO_DISABLED to avoid those.

This means a macb_config that wants to disable usrio can simply drop
its .usrio field, rather than add the disabled capability explicitly.

Nit: drop the dt_conf NULL check because the pointer is always valid.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ecab7fdc962d..972499aa4191 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4470,8 +4470,10 @@ static void macb_configure_caps(struct macb *bp,
 {
 	u32 dcfg;
 
-	if (dt_conf)
-		bp->caps = dt_conf->caps;
+	bp->caps = dt_conf->caps;
+
+	if (!dt_conf->usrio)
+		bp->caps |= MACB_CAPS_USRIO_DISABLED;
 
 	if (hw_is_gem(bp->regs, bp->native_io)) {
 		bp->caps |= MACB_CAPS_MACB_IS_GEM;
-- 
2.53.0


