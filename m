Return-Path: <netdev+bounces-232361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DC0C049E7
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5CA7A356515
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 07:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9848629BD89;
	Fri, 24 Oct 2025 07:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y6h9b4sg"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F0E29A9C8;
	Fri, 24 Oct 2025 07:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289663; cv=none; b=groJx7mAn8J4kG6kdmqAPGwNdaRHahSo5M03hdHF8GcjmLWOr3ZOSvNYeKD2+LrrIVeeIo6uxGTyQ80bFNXh3OOG1U4JXr8oqsozSs49XNbz1FbFYyzE5ySHPA/rWA5tvCZ80FoClD9C0XWMMfg6jd+DLd90hzSIvbSgOH36J3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289663; c=relaxed/simple;
	bh=nySlFopoPA/LXcFAgNjjMYtmlOdrKyDQehmtLFGrI3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Shh1XoxGC+nrhtpLhRZIhWlIh6HFQaCz4Eh+YxnHIKkFbUGpx4RZFFDh2mz6lfeNjgG8EXuYsS8y5l/Hc4nnh7cU6eNvU0/jlFPae4ZMi0/sut2dsIcbi7Ed+RK1PHS+cdXIJjWFtWewRvFmFE5LPXD/R7c9rk5h1RWfukNene0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y6h9b4sg; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8B1881A1639;
	Fri, 24 Oct 2025 07:07:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 47E5160703;
	Fri, 24 Oct 2025 07:07:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 04012102F247E;
	Fri, 24 Oct 2025 09:07:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761289657; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=u7DpE+oTDsmY9vOfVzLTFJGa7kcYvBVKQHh8iIY9BgE=;
	b=Y6h9b4sgm0ErZAY1zT16Ddploj6AH9IjTzMSk1AmziZtMqj5HUH0GMq/IYTmjFZc1ZmRSY
	ja31HDlO4852i38mcagx27mP/GEFv/0Yk8d1MXR8lk703cMWR4Gscwngc39zroGx/l2gQs
	Jsi5FcL5hosjtr8sF9yOU4UR/loVx4y+Ln4Clj3wwktxdVDPABEVuao2e/Hyy3yiJF8Oz8
	7YxQNSmbjK7uD6J2WHdjeX0jxsH9JG3HVUNfPWdE7XmBwB6rrJf+O3BmVLgHOiYnwwaF1q
	WMqQmNDla5fBXh0KoUfo0Eilb49R41MtqzzIVKpI24kxXPrp2jGJ29HNVsDmbw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net: stmmac: Add support for coarse timestamping
Date: Fri, 24 Oct 2025 09:07:16 +0200
Message-ID: <20251024070720.71174-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello everyone,

This is V2 for coarse timetamping support in stmmac. This version uses a
dedicated devlink param "ts_coarse" to control this mode.

This doesn't conflict with Russell's cleanup of hwif.

Maxime

[1] : https://lore.kernel.org/netdev/20200514102808.31163-1-olivier.dautricourt@orolia.com/

Changes in V2:
 - Use devlink intead of tsconfig
 - Rebase on top of Russell's rework of has_xxx flags

V1: https://lore.kernel.org/netdev/20251015102725.1297985-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (2):
  net: stmmac: Move subsecond increment configuration in dedicated
    helper
  net: stmmac: Add a devlink attribute to control timestamping mode

 Documentation/networking/devlink/index.rst    |   1 +
 Documentation/networking/devlink/stmmac.rst   |  31 ++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   3 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 163 +++++++++++++++---
 5 files changed, 176 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/networking/devlink/stmmac.rst

-- 
2.49.0


