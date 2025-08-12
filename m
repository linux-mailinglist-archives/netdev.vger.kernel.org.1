Return-Path: <netdev+bounces-212819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692A5B22145
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 718337B651B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 08:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA722EAB82;
	Tue, 12 Aug 2025 08:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lX8PpZHP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZnmkILdK"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5BF2E9729;
	Tue, 12 Aug 2025 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987481; cv=none; b=k3ao5i7Ov9s1QC2slEY6T61izprR1Ih0/JU73ye5Yt1tz7hJxR49xzyCoE7BEZbFGdhVtnTa+txNa8WFrPPUmceFrpghqsbClmsONM0yM7S1FJ7ZTnIgIwbzQNgpkXv5yBl2zxfFL9hhDoQs179JEzq7yhHcSh66U+tKico4uBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987481; c=relaxed/simple;
	bh=KyWvc+fSymgKCL0GRQPWtgUM4Zj1mcZAccRcc1bmEbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fFUGBWmnebntLbBLoPWYi+6oWdgTSvTpVJOzO3nj30iqJceRp8m0lZaDkj+ue99ICvj8DfbA7O9D7L24PDSCn+LzQiYYWrnzzhYMSHOMwDBGo0JcM87w9fCWvEiKMYWXCszmieSlSJR1vK9FbvmtOPF2iLgwIzNgqqvR2j1qfGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=lX8PpZHP; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ZnmkILdK; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4c1PqB03t9z9tN0;
	Tue, 12 Aug 2025 10:31:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1754987478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+owiGaKJShsteiVbcTBTUc/hirR4YHzq/zN3nuByxA=;
	b=lX8PpZHP5zfeKWhSVKjObDpMH9j1h1ha0bG72TgSfceqb4j5xfa8JxdM//QvJ9ZmQmWddk
	/IN6gIB1S+tIqczrvl2w8gSFaydee6G5B3BfBO8MhfmgdwuS7ttOaV86Fr/RREMC/UYQoi
	sNqMUKaAwcFOjHn23B+4/6R95nAAjkfvxQB9nIxTLkX4EwgTYC3K4E5hpysxmHKJax+erR
	6qwIhTKZzVW0CQWbN8px1dQamWfVtPx7cQLtUbVA8SZaBCIK7qdW1EMcr2hy7Fyn2XJbV6
	6NEaJ0Mi9jbBWL5iWvZ8F7VB6q6UW8/8RlZq1zYJTeDf+nbSLBbZCUAeYRrRaQ==
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1754987476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+owiGaKJShsteiVbcTBTUc/hirR4YHzq/zN3nuByxA=;
	b=ZnmkILdKGuEIIy8J7PSxfbWteqZUULNhlel6a4N2kSrsQ2Mbbc+ll3pvCP4g+4xAio70qN
	N+3tlKZiONpH5plBBQIDnlFFKKyxImiXYykibRrb1otzGhD4Xua5ajut25yXD2jJT+mUJE
	M0PSCHdffUsarLbdy3zdW2QdO9tylsnxIgu+4gdCoHDbETc69bmQco+dJEL90sEoAgfPiX
	COJz7rsz9kUyr8/tzdi6FFwfTDdEKpOnrCbYff1nw6LWJlKmNGYnhxk+iuA/YSuiowlXW/
	7aFRFq6EPM7QjZzov9LXq+rdKwYMNdEGAtmg7GJ4wV9wIdCFjgpf+Kl1+P4w9A==
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
	Lukasz Majewski <lukasz.majewski@mailbox.org>
Subject: [net-next RESEND v17 12/12] ARM: mxs_defconfig: Enable CONFIG_FEC_MTIP_L2SW to support MTIP L2 switch
Date: Tue, 12 Aug 2025 10:29:39 +0200
Message-Id: <20250812082939.541733-13-lukasz.majewski@mailbox.org>
In-Reply-To: <20250812082939.541733-1-lukasz.majewski@mailbox.org>
References: <20250812082939.541733-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 37480c92e5da9a3fcad
X-MBO-RS-META: k1moa7pj74k133tsd59foiihhk366wks

This patch enables support for More Than IP L2 switch available on some
imx28[7] devices.

Moreover, it also enables CONFIG_SWITCHDEV and CONFIG_BRIDGE required
by this driver for correct operation.

Signed-off-by: Lukasz Majewski <lukasz.majewski@mailbox.org>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
---
Changes for v4:
- New patch

Changes for v5:
- Apply this patch on top of patch, which updates mxs_defconfig to
  v6.15-rc1
- Add more verbose commit message with explanation why SWITCHDEV and
  BRIDGE must be enabled as well

Changes for v6 - v17:
- None
---
 arch/arm/configs/mxs_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index b1a31cb914c8..ef4556222274 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -34,6 +34,8 @@ CONFIG_IP_PNP_DHCP=y
 CONFIG_SYN_COOKIES=y
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
+CONFIG_BRIDGE=y
+CONFIG_NET_SWITCHDEV=y
 CONFIG_CAN=m
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
@@ -52,6 +54,7 @@ CONFIG_EEPROM_AT24=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
+CONFIG_FEC_MTIP_L2SW=y
 CONFIG_ENC28J60=y
 CONFIG_ICPLUS_PHY=y
 CONFIG_MICREL_PHY=y
-- 
2.39.5


