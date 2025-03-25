Return-Path: <netdev+bounces-177335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B24A8A6FA94
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314A43BA98A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E072256C86;
	Tue, 25 Mar 2025 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="hE9L4sZc"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5039254845;
	Tue, 25 Mar 2025 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903901; cv=none; b=SVtqpCrFtwV08NR/2/DNLeLpyfnseWaAk45hsJNqKpUR6XbxLJ9ufWA1R/B7WkKcxVM+8Sws80AyS3kMhSdYJQUeb18/Gnk2zc0YLuwebmhOfN8JoJ4sZA8EV+9D6z0c8c5eghdttPoLCLz8rYN7FS0M53uO+KfJhnbLJtCGhOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903901; c=relaxed/simple;
	bh=hKKHVnJAJWrf9Blr24e0dDIpt5a0WT1rLCETEy1eAd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iv59C+gqnxTv7MFwPiz1vZ5hv+PW2bWlSqpF6vBmFTJj4qsPKhDxq17G573MlfCV7pidpbO2umIfZO7O49wHUFpfP4dnywDeK67MlZrXqG5aB8116Z3MMCBIlwnD6Io3sKmZ81v2ELIDK7V/Rd/oifBXqItMAK6ScoFwaZb6ABw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=hE9L4sZc; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 97F9D102EBA43;
	Tue, 25 Mar 2025 12:58:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742903897; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Nb+uumKIAlcQT03N8XP/zmijiZ83zsuKYhUq6ru23a8=;
	b=hE9L4sZcZzz9FzHmEBdosqshpQdnTj6W+zRWPlaT00yc64jvRwPQ/olH5eIdJ8kR6wUrcC
	LWNxVQGxsOs2ba95HFP2LKKWf9vcYHbYp6IWi8HTOw6eKAlpsySTTQaV000hiPzZMdiskr
	jVyKTtAIuU8JfmsZL5Jf46JJ0y7aRXuSdxhniMd+3mI6DmDRb9AH8UdmZwXToI4b10wsPp
	wbp4bU1ejZmpw7pG1l/Pb+n1iR9M8XPm+Cin3OTPj9gbE3i4ugBN3UU2AmFpLZhZwE2qCt
	J7i3VWbs308Sl3qPCSXdJcIA0sJjCYmYZmcj8THMaTbnC8K1UHduDCQKWBfucA==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	davem@davemloft.net,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 1/5] MAINTAINERS: Add myself as the MTIP L2 switch maintainer (IMX SoCs: imx287)
Date: Tue, 25 Mar 2025 12:57:32 +0100
Message-Id: <20250325115736.1732721-2-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325115736.1732721-1-lukma@denx.de>
References: <20250325115736.1732721-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add myself as a maintainer for this particular network driver.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5959513a7359..255edd825fa1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9270,6 +9270,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/i2c-mpc.yaml
 F:	drivers/i2c/busses/i2c-mpc.c
 
+FREESCALE MTIP ETHERNET SWITCH DRIVER
+M:	Lukasz Majewski <lukma@denx.de>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/fec,mtip-switch.yaml
+F:	drivers/net/ethernet/freescale/mtipsw/*
+
 FREESCALE QORIQ DPAA ETHERNET DRIVER
 M:	Madalin Bucur <madalin.bucur@nxp.com>
 L:	netdev@vger.kernel.org
-- 
2.39.5


