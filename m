Return-Path: <netdev+bounces-227312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B131BAC306
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 11:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0441886A00
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 09:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D2F2F49E0;
	Tue, 30 Sep 2025 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Mh2MCzVl"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1D586323;
	Tue, 30 Sep 2025 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759223621; cv=none; b=ggVutB2SHweObuVni8QVcfnFeZFxP0PSnjld59ZPtPF9gKs7w57U/LcxfvMexuAajV79kJxN21he/YfohFiPb+MOVVY1/Hm0ykelNZcBA3F4wVkDmKTjx5jXtKPebo8tueMwlZKguP72cPQPPzMBTo8pXYPXSOVTghUs40L8vUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759223621; c=relaxed/simple;
	bh=NN+fb9rKpSA4avJKgQugSE3d42y1taClRO2GdeIvn1M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IHDfbkbzOMxMk+BCT0wHyUigcb0WwP2eEWzQxJOvTRN4IKp7l4KLo0dw3/jSE9avy+EOSAMtdyPy//xU9d4QWxtTD4oIBouqUzHz/yF8N+u9e9URPuHS7dOT9Kts9sGRxXWsxYVD5/Gks/sLNnZ8dZJPRyeeloy2A29WkDt8UMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Mh2MCzVl; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2EB82C02461;
	Tue, 30 Sep 2025 09:13:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CD8ED606E4;
	Tue, 30 Sep 2025 09:13:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 71DF4102F17B1;
	Tue, 30 Sep 2025 11:13:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759223611; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=l3vyZUYrRuAL1PVDLkE6rONUtsTXIL9lBFx0fhy6A7g=;
	b=Mh2MCzVlKeIm5FBehjHAJhRNQ0Vv7Hwf9AkJmB9+TsPTna0iUbcumDWwyWCz7tUhYTrSVn
	qjSnKH/b7w5wjClD1vShxhGOtrRpgObInO5zo2wy/mQmd+YvkVu674gFlYmp6kOEYMSq2g
	W56KO6DqfXeW3smJaBUVtBzhzUyhnSMEwGXhbsElnIzhYLO7V4j58TaykEGcPfGJmcCJnV
	VQir4muuplXesS/bCmhhGzS1vAgyH12A3+Yq50rtvaUivKxBQ0JauGXfDZK04PE8n4lym1
	r+hLo7I6dnZ2/cL51f2tFalUzT607p+ej4g6LdU1t2cMFT78wTGKniVwxUT88Q==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next 0/3] Preserve PSE PD692x0 configuration across
 reboots
Date: Tue, 30 Sep 2025 11:12:59 +0200
Message-Id: <20250930-feature_pd692x0_reboot_keep_conf-v1-0-620dce7ee8a2@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABuf22gC/x3NwQoCIRRG4VcZ7jrBkcm4vUqE2MxvXQIVtRCGe
 fek5bc5Z6eKIqh0nXYq+EqVFAfm00Try8cnlGzDZLQ5azasAnz7FLi8WTZdu4JHSs29gezWFIO
 y7JntYi8LzzQyuSBI/y9uFNFURG90P44fAXB0B3wAAAA=
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, kernel@pengutronix.de, 
 Dent Project <dentproject@linuxfoundation.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-Last-TLS-Session-Version: TLSv1.3

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Previously, the driver would always reconfigure the PSE hardware on
probe, causing a port matrix reflash that resulted in temporary power
loss to all connected devices. This change maintains power continuity
by preserving existing configuration when the PSE has been previously
initialized.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (3):
      net: pse-pd: pd692x0: Replace __free macro with explicit kfree calls
      net: pse-pd: pd692x0: Separate configuration parsing from hardware setup
      net: pse-pd: pd692x0: Preserve PSE configuration across reboots

 drivers/net/pse-pd/pd692x0.c | 155 +++++++++++++++++++++++++++++++------------
 1 file changed, 112 insertions(+), 43 deletions(-)
---
base-commit: cebc5f8eed2c9ad0e048d6a68c3fac92a6020509
change-id: 20250929-feature_pd692x0_reboot_keep_conf-69a996467491

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


