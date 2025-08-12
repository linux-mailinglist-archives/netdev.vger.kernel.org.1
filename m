Return-Path: <netdev+bounces-212817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 453CEB22163
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67DF15660D5
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 08:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BD62E9EDD;
	Tue, 12 Aug 2025 08:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BbH1iinE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XJ9A13Pf"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB9D2E92CA;
	Tue, 12 Aug 2025 08:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987470; cv=none; b=hxeVTmFv4xHVajq1NR/YArHNJD7hz1mlaP9Ee7Uds2IbUGJtOi/bXhqZma6BrSWfHiS3+GGkRYdUidAnlku/GjMCnaaLoYeRwzCCUayVVJAxCX/+R+zDeHx2y1oZt63F146UhBoh6TKRjrzuA0/rr2rto086hBRQim4imNVGc68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987470; c=relaxed/simple;
	bh=OmjtpOzmf7xfk1E6tdLkEzPF3FnjRUtbrbGAsxyE4N4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d26XUvNSvrnFN27jFG82edzaJxKJYYrgG+p8DUpdKQJvjz4w4aqcx+rAZ9FMYMne3PMVd6czw9QxHJzM9DcUHYovTQcg3Eb9P6gDYtMp2tWRgb1j4MWCuh3hXM+NgXXwH/f1/a9PIty1/f6zaYr0BKQZlCHkkZfgdje3RuPR6Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=BbH1iinE; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=XJ9A13Pf; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4c1Ppz4hryz9tDY;
	Tue, 12 Aug 2025 10:31:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1754987467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XHPsuZZlOyATVEvk2vMY5ObbVx7RJbKpvlPjvIf5Ms8=;
	b=BbH1iinEFqnVnTFyEZa+ecYrrzw6RQS/Z8vCygUeAHsWiezws+DxXWnwFsCScnejigYD72
	FgPZer5uinadNymJYghha8ds9qHWhxvN7pi57v6HbP9sMUQR8/fI9ZiOA9cJnwhNRnbsFQ
	P4DhYOeBzRP28O0OwbIt1tUj6NtnryOCjvLht81TB7m6EIXnGSWYg8NXkiSFNjMfy7THhm
	gtmdMGyAOeDVBC4Ak42ibFXMxjAy7sa7Me08HfSmdVQAUQyu+32IXYcgIVhKpnUh3w2raV
	XustKpbsZnOKgFjZ6S3iS+wZew7PZTvEpW/HoeMbdzCPnnJIsD4u1I4d9B/8eA==
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1754987465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XHPsuZZlOyATVEvk2vMY5ObbVx7RJbKpvlPjvIf5Ms8=;
	b=XJ9A13PflgVzn1PN/3nobIhw3oClDzh2sAmdnn91fOaVBiqd0GkI4EaJ1p8kcmQUevArpT
	1PBLgCt4hOoFpEoWCAjgRBwKB2s7jJ84t0wcMFePqlRgcagPv/lFc6IRPLYD7SfjkKxFNy
	gIxV6+E7pNx3orA7XN+Vigz0audas+KFP9dFdj5KC7qezu2E52aZ/oWAoMIDN3ievM5X0K
	PbDTzU3utkmaJqlHHJEdLzCVpy2ohXKevUt8yyNtJeaf9yE1xP3lPJWGgIxt4BRx1aRMrD
	fVV15QzT+RlzXmz4kZcvmCjAUxawBceGjNNgtBiWWaDk3/PLZSojRWHtUTb5nQ==
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
Subject: [net-next RESEND v17 10/12] ARM: mxs_defconfig: Enable CONFIG_NFS_FSCACHE
Date: Tue, 12 Aug 2025 10:29:37 +0200
Message-Id: <20250812082939.541733-11-lukasz.majewski@mailbox.org>
In-Reply-To: <20250812082939.541733-1-lukasz.majewski@mailbox.org>
References: <20250812082939.541733-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qtw4rcqq449cz7xfffpgj5xi3syjwwof
X-MBO-RS-ID: cf14aea7960e9222afb

It is not possible to enable by user the CONFIG_NETFS_SUPPORT anymore and
hence it depends on CONFIG_NFS_FSCACHE being enabled.

This patch fixes potential performance regression for NFS on the mxs
devices.

Signed-off-by: Lukasz Majewski <lukasz.majewski@mailbox.org>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Suggested-by: Stefan Wahren <wahrenst@gmx.net>

---
Changes for v6:
- New patch

Changes for v7 - v17:
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


