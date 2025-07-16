Return-Path: <netdev+bounces-207606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7ACB07FF2
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 23:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D456E4E5D92
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 21:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4C92F6F8E;
	Wed, 16 Jul 2025 21:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="D6Z7KwQF"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E9E2F5C2E;
	Wed, 16 Jul 2025 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752702503; cv=none; b=Por4WzaN+WS4oradt+rPGCAVT13c0aRvUJkytNH55yS/bn74Aa+MnC7yvDCzcZBvB/w+ND04DAJTBteRytZrX0n2aWJ3B1M86ZWlnUon90L6eiYAWksObG1AlCtY3JQZDI6VqBiSl4kOXPkkSV80CrZYN1RBi+ay9GEew5v9qws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752702503; c=relaxed/simple;
	bh=IBspAwbpXx9DCq58ylri9qiCAyU3HNRXfcAf5Vwpt0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VD7Zc+WoaF0jIwzgW9T1aQk87FdyfcXIcPiOBgxjNo379llganv+oA+N49OJILVrNhifZf/5YMQrfKPxzgeXam89s8p4AF/Zznvdb5YWy9CcCVvWBk/4pe+YZuUlGn/lvWYT3fG1b+7GzQZfE2UeXqmQ8Xjx8L/hz74pkcAFrR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=D6Z7KwQF; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 72AF310397286;
	Wed, 16 Jul 2025 23:48:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1752702499; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=prizobI3jmRWRive59+ukp6XqMZlaQqzwDa5BzvDWsU=;
	b=D6Z7KwQFM7wJY1FgOcNG+qoH0GrcU1I1O081gYRBjXZ9O1+L+JyGSIWG2xLhFGESeUIWCy
	uXIAG/iNWNlCcUbTjmGs1tO63M8d0YBNrhBp2sU9uSbxDpw9dPHHYNrRKKTidZcvUGanHY
	gi8z47WYdWdmKA8SpDJQzxtQ3VnU0ItKSfhrlwho/K7zaKAV7dfKsuh6qZrdV49UFUlO5x
	8D2BKhq8KzdZ9SrEVowmRXClRvanGA7UQobRt0cwqBKCRJhkHbfTC0tzjseNFzFaxdP2Ka
	8KMlM/5LnDmqJseIrNU6cHI0FaqHr+n/L/N3TF2LIhGCOcsCpoFO40f0ePpTAQ==
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
Subject: [net-next v15 10/12] ARM: mxs_defconfig: Enable CONFIG_NFS_FSCACHE
Date: Wed, 16 Jul 2025 23:47:29 +0200
Message-Id: <20250716214731.3384273-11-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250716214731.3384273-1-lukma@denx.de>
References: <20250716214731.3384273-1-lukma@denx.de>
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
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Suggested-by: Stefan Wahren <wahrenst@gmx.net>

---
Changes for v6:
- New patch

Changes for v7:
- None

Changes for v8:
- None

Changes for v9:
- None

Changes for v10:
- None

Changes for v11:
- None

Changes for v12:
- None

Changes for v13:
- None

Changes for v14:
- None

Changes for v15:
- None
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


