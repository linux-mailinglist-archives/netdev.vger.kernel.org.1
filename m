Return-Path: <netdev+bounces-234337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD614C1F823
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A5F534DDED
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEAC350D7F;
	Thu, 30 Oct 2025 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S21umYqA"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC36F33B955
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819869; cv=none; b=FTS7Jyw7npt1nDOotO78OJNt1/o96eYIBURncO3OEMSPvD2nknSBR8MCo/wvxtaHDo59aJs4yu17gMZLc+EuJO/4BrEC4Dn6MrGffB6HGSifLGOWR02dY8LVVflrGsevT4nvJwEDcXyfTj/HGmqROEbTfEDedzJAo1GMtgKUp68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819869; c=relaxed/simple;
	bh=OFh3fZEUD1SVfUw9nvkO/V7lCvvDQ2UdEyrKIHxkccI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bUusJ4KSKxw65931gOd0wU8Joi5g8zzox8vCs6azVaxeVr+ywjjhsHUFgT7OxvnpNV/ixCxFDYASktfTFPPz8crSA7R1pXEaCjoHnVQvuBsnzJ7Kz2TYYB3Uwx1L1hwQ+aHgOWhbUiklk6vI4AxmeWSuLEQdQrAY16hIeEDua0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=S21umYqA; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F1A6F1A1777;
	Thu, 30 Oct 2025 10:24:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C6AB36068C;
	Thu, 30 Oct 2025 10:24:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 944B711808821;
	Thu, 30 Oct 2025 11:24:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761819864; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=zdVtCVfiDUJY2QRSa6ubd540pBgj+UbwTkasKdXjGc8=;
	b=S21umYqAgjNff5fVFSM/v0k2+VI/p7qqt8SqvBrP5KdXmvpQGUEwmAtuPBbsu5r+Sq0a1e
	3cxNaDteFBBQPzfDirBNcPSRuBZuZYv7CQ6EqAKkvN97YulSQqvBEnCS/JNH1eeY49Qm1h
	GNvP6azosIBNgJUi/IIUwwuBD248G9koy3EIJ9jp1ohGjVuZqDTZlNUvm8El+VL2la6I7n
	66wCdKhH5D7SS6oATjBhyWUeQf/QkYdFVld/tr4n82dCx+4TZe38i2X9UkMB4EuChDVm4I
	/Y+BnL3kfrnTY++CJQjAdDyVSq9thL1Uo+Jjzd5eYABIPe5ztSVjr9s6IX2G/A==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/4] net: altera-tse: Cleanup init sequence
Date: Thu, 30 Oct 2025 11:24:13 +0100
Message-ID: <20251030102418.114518-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

When Altera TSE was converted to phylink, the PCS and phylink creation
were added after register_netdev(), which is wrong as this may race
with .ndo_open() once the netdev is registered.

This series makes so that we register the netdev once all resources are
cleanly initialised, that includes PCS and phylink creation as well as a
few other operations such as reading the IP version.

No errors were found in the wild, so this series doesn't target net, but
given that we fix some racy-ness, a point could be made to send that to
net.

This series doesn't introduce functional changes, however the internal
mii_bus for PCS configuration is renamed.

Maxime Chevallier (4):
  net: altera-tse: Set platform drvdata before registering netdev
  net: altera-tse: Read core revision before registering netdev
  net: altera-tse: Don't use netdev name for the PCS mdio bus
  net: altera-tse: Init PCS and phylink before registering netdev

 drivers/net/ethernet/altera/altera_tse_main.c | 37 +++++++++----------
 1 file changed, 18 insertions(+), 19 deletions(-)

-- 
2.49.0


