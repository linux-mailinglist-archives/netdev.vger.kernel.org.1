Return-Path: <netdev+bounces-210086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DB5B12189
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 18:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1EF717D4D0
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 16:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186D12EF655;
	Fri, 25 Jul 2025 16:13:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F982EF293
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460016; cv=none; b=Yjpa78zBVR7+iNV295BbGSsIMJfbcdEM9y2giJ5PeTxdDwUGnTfzaRC9bZbgzgUttiLYWSD6ScJXamH2uJeMFT9JieaBgul29ctPJrZRHtxbmhcKUMZFPUs51h9Vf4T3aWsFWFw56b2oP/5h6HgSKWfUJZVJF65qgcXPOI05IVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460016; c=relaxed/simple;
	bh=+kbmtsIuZY26IkBiZef+ObRMDY1Nz9fHzjXF8NN2QTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekNuiAbgy2dmr3XkBNLmZjSAAMZYkD45oiktsjmw+6zEM3hozivj2xITZVkrmsaOSGdkmyYhyc/Y64ScrNsFJGG2H91u0tRNUKUSaNqsttfyI4ax3neDPPztRajmoAtSHOzzHbevveE31wPcsn26yQ38L479qaD0U2ZxVgniTEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL36-0006VJ-OX
	for netdev@vger.kernel.org; Fri, 25 Jul 2025 18:13:32 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL35-00AFVK-2X
	for netdev@vger.kernel.org;
	Fri, 25 Jul 2025 18:13:31 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 69BA544983E
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 16:13:31 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id BE5E9449806;
	Fri, 25 Jul 2025 16:13:29 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b7432f01;
	Fri, 25 Jul 2025 16:13:28 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Khaled Elnaggar <khaledelnaggarlinux@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 01/27] can: janz-ican3: use sysfs_emit() in fwinfo_show()
Date: Fri, 25 Jul 2025 18:05:11 +0200
Message-ID: <20250725161327.4165174-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725161327.4165174-1-mkl@pengutronix.de>
References: <20250725161327.4165174-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>

As recommended in Documentation/filesystems/sysfs.rst, show() callbacks
should use sysfs_emit() or sysfs_emit_at() to format values returned to
userspace. Replace scnprintf() with sysfs_emit() in fwinfo_show().

Signed-off-by: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
Link: https://patch.msgid.link/20250712133609.331904-1-khaledelnaggarlinux@gmail.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/janz-ican3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 60c7b83b4539..bfa5cbe88017 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1867,7 +1867,7 @@ static ssize_t fwinfo_show(struct device *dev,
 {
 	struct ican3_dev *mod = netdev_priv(to_net_dev(dev));
 
-	return scnprintf(buf, PAGE_SIZE, "%s\n", mod->fwinfo);
+	return sysfs_emit(buf, "%s\n", mod->fwinfo);
 }
 
 static DEVICE_ATTR_RW(termination);

base-commit: 06baf9bfa6ca8db7d5f32e12e27d1dc1b7cb3a8a
-- 
2.47.2



