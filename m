Return-Path: <netdev+bounces-184075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E84A931BE
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 08:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4337319E2D29
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 06:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D5526982B;
	Fri, 18 Apr 2025 06:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="du4o32Vb"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E820A268FCD;
	Fri, 18 Apr 2025 06:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744956478; cv=none; b=gIAqB9oC9bZdqFyAk7K+RRvnbXP1/+64l/Q4cFxMtNDy5jWSOPfsJ34ijcPvZPlDS7UIHJN71lrR3dC6tdHyLeju5RbG7hDKHPkUs4oYuWmg2Wx2Uo04s+ke9yge+d/y8PNW3FFKXuv8ktOsZ0rdUYX9cKhXOw2cz1qaLY4qZoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744956478; c=relaxed/simple;
	bh=qKFZ4aYtvbYFwfW1KyHLDbosU0eq6byz2CVLD3yZy6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lCoSmCIDKVpBXGgZvXApldjrDV0ZMSLKz5P0f2mvG+ZE0th6iWvalB+NmXg9xlct1s0kgNUrO1YL1xgUMOE4b+Xlaz/t7iAQLvWF3aVOYKvrhmRgiFLmnknNQ9+fk7m8M4cwFOM9sYWbfPbqehwLoc85WmzMUdzb/YFq+NSwFes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=du4o32Vb; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51D23102933A6;
	Fri, 18 Apr 2025 08:07:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744956471; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=GJBeU/rnFZPjbhJxcQ6V2MkB/H8xOWywLoSrGR8U0x4=;
	b=du4o32VbQcfzuFrgKrCkupQ/Oaalh2xlIM4LSIM6yTC+MyPD/Ms4X7dKpFCRZKlXoCspiP
	bdYN7zfutFReylcrlieiTObQj90odwIj/li5AfOjsXfhKYXwZ8PKHlD5rl+E7EjJAdq6tf
	dqmPvVYXTxdwZ8iKcyHZP7r5v4OSQ4n1DkKhnPN8/rupf5dTA/qxoHb+JUna3i3lFAt2OP
	VyAeG5WKZHrVdMKUtJz7yqRJgZc8O3EzHaLKPszxFda5WZsifGTA7AWRIJKn+rupGmGhwM
	boflQlI1irbxY8ihrnRJM3qtevelbw5+9RSNpbh1IQfx6BhY0KA+rm0tZp9DJQ==
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukma@denx.de>
Subject: [net-next v6 5/7] ARM: mxs_defconfig: Enable CONFIG_NFS_FSCACHE
Date: Fri, 18 Apr 2025 08:07:14 +0200
Message-Id: <20250418060716.3498031-6-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250418060716.3498031-1-lukma@denx.de>
References: <20250418060716.3498031-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

It is not possible to enable by user the CONFIG_NETFS_SUPPORT anymore and
hence it depends on CONFIG_NFS_FSCACHE being enabled.

This patch fixes potential performance regression for NFS on the mxs
devices.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Suggested-by: Stefan Wahren <wahrenst@gmx.net>
---
Changes for v6:
- New patch
---
 arch/arm/configs/mxs_defconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index c76d66135abb..22f7639f61fe 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -138,8 +138,6 @@ CONFIG_PWM_MXS=y
 CONFIG_NVMEM_MXS_OCOTP=y
 CONFIG_EXT4_FS=y
 # CONFIG_DNOTIFY is not set
-CONFIG_NETFS_SUPPORT=m
-CONFIG_FSCACHE=y
 CONFIG_FSCACHE_STATS=y
 CONFIG_CACHEFILES=m
 CONFIG_VFAT_FS=y
@@ -155,6 +153,7 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
+CONFIG_NFS_FSCACHE=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
-- 
2.39.5


