Return-Path: <netdev+bounces-235007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73033C2B236
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 11:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 077F84EDBB2
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 10:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707612FFDEA;
	Mon,  3 Nov 2025 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jNN+kD56"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BCA2FF14E;
	Mon,  3 Nov 2025 10:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166978; cv=none; b=sMdm0XBWZvhShFhIZehcl6SQTC83qn6vbwzJR6rUF9W6RVRgYLPaHemukHiOYkSYEI8pvxZhvTrVls57DMAVp3LnXQ64I7BVu/mVyMEUSSCErfMlQpYb7tJbAHxxRjOc7StL9v3oaXx12f2Y3oc8vLOB9mbE8pkRWtikFRjk9ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166978; c=relaxed/simple;
	bh=J7wDn04FRpbcBM5wwqDkQRBHY+0yUqHM54VV1rP0Tr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BzZKQ8xsWO8c5CvqDKaERyryXSobqrRNyNHXN8nOEr+cYKEL1wONp1ieOm5qhqDVuEPXYYxmxaOUw0YZEF+f86v4M/UHTTlcGHFr80VS+m/QOIHSBl5Sc30iXfrknl+iF4/SJXwowGcPpcx29c6HX6pqUDzX+ECQOsK+LAuIS7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jNN+kD56; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 756E34E414BF;
	Mon,  3 Nov 2025 10:49:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 49EE360628;
	Mon,  3 Nov 2025 10:49:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 36E2410B50057;
	Mon,  3 Nov 2025 11:49:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762166973; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=DyJ9tqsoh38Bn05Ar1FcUNEL8tbSjuGx45/Aag3loLI=;
	b=jNN+kD56Yue4K7UymDl+K+B78uA5KpqztHgAgZiAGhFnLRUvgeTUkWa4ea1dqgdVCI2iYD
	W+3r2o/KhCqdGi+b09OM1mBO6qJUNWwKZsfDC0hEGpWHq0P5rseOYK6JeLcZsJeno9YjZI
	D1M4UDaPLgMdmF8rvVcIr4maDpKBHz3cKEvqaiclsodvb0xuzO9pX+R02TytkAVjcqvcQe
	zSL+EylbzBtKv9pCVER0/v4vH9ElL6eMPV3YaCK1cExzMMgeoiTegL8iHbiosLOiLXqQqJ
	yP95wCumOAKKOEkkyjquqzHxL6ooHjgceKvmehay2aq+i2XrvtmyV5kavIexWQ==
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
Subject: [PATCH net-next v2 0/4] net: altera-tse: Cleanup init sequence
Date: Mon,  3 Nov 2025 11:49:23 +0100
Message-ID: <20251103104928.58461-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi, this is a V2 for Altera TSE cleanup to make sure everything is
properly intialized before registering the netdev.

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

V2:
 - Add Andrew's review tags
 - Change patch 2, to get rid of priv->revision and print the core
   revision at probe time instead of doing it in .ndo_open()

V1: https://lore.kernel.org/netdev/20251030102418.114518-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (4):
  net: altera-tse: Set platform drvdata before registering netdev
  net: altera-tse: Warn on bad revision at probe time
  net: altera-tse: Don't use netdev name for the PCS mdio bus
  net: altera-tse: Init PCS and phylink before registering netdev

 drivers/net/ethernet/altera/altera_tse.h      |  3 --
 drivers/net/ethernet/altera/altera_tse_main.c | 47 +++++++++----------
 2 files changed, 23 insertions(+), 27 deletions(-)

-- 
2.49.0


