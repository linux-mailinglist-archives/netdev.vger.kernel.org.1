Return-Path: <netdev+bounces-117694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 205D194ED47
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9011F235EF
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5770717B4EC;
	Mon, 12 Aug 2024 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="M5GmTR0v"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCFB148837
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466657; cv=none; b=l/+/nGpRW5jtktWRG6y5DKI98dZJcF8N0SNP0IBgNrz39xZkMSqji4vX59E2X9PcfvgY5ker8ks+hV4o3y6Bya1Fde7FI1u4IRV6NX3JArxleIH616R9ZZYpry8gMOmR1by0wQM8hqTYp/TYDuibdjVoBcpEfY3zvSumCwTaW1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466657; c=relaxed/simple;
	bh=cu991Go2/S4VnFCxzCXyKU3kRcrxH3UCEFVL+GnLMZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P9/DRC1TbectSuV6aKJ5e3I/ew1lPGuH5806FlqtVl20PGcVzOWmiWZTYwfa3hrCWZUNS1d17UUfjMGZtqi0pU7a5rFLh84O2889c+yClZSyhInDQ0tLxYUyt7d9FBWlK2TxdLfZDchDLm1AnImkF0yCKMPWoQHPlepTxroIZ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=M5GmTR0v; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id DD3A99C468F;
	Mon, 12 Aug 2024 08:44:07 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id P9DzNjXXJQy8; Mon, 12 Aug 2024 08:44:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 24A909C5D1A;
	Mon, 12 Aug 2024 08:44:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 24A909C5D1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1723466645; bh=7f6Dia8/XvJF6XOH6vLOLeJGddTFc+uF7NbZNXO+4ok=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=M5GmTR0vxSPK09y0U/LMbgBelJd31uQ6P2rfN0+8T92GnVdGXRD4x3XB46S+pLlcK
	 EXzb0A5IZvvk02498h0gCaFW3qB5jMUPdqFNEL5SR5y5WdoG2zBNs5YrES+8yrUSiG
	 pavWYP/j86QqVTamJlUifQPrViF8mstt2bphsfY1NXTY0n7xZMfUYi619RsFTJ06vW
	 rrWa0Ifd9AZXCmU7tWTtDxjFFYSe6NlBHpnEQrL4Qa7NajlI8xzL1voDspKSO0AcsS
	 3Tn0BYym6A9vnRiiPxF9IHDN6eINQKSmXC3XvdjlujsCPst76GJ3yUnuU9usDyZzzm
	 1wQwUHslO2/ZQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id eZD4aSxToYLs; Mon, 12 Aug 2024 08:44:05 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id A16619C468F;
	Mon, 12 Aug 2024 08:44:02 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	kuba@kernel.org,
	Tristram.Ha@microchip.com,
	Arun.Ramadoss@microchip.com,
	horms@kernel.org,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [PATCH net-next] net: dsa: microchip: ksz9477: unwrap URL in comment
Date: Mon, 12 Aug 2024 12:43:47 +0000
Message-Id: <20240812124346.597702-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Keep the URL in a single line for easier copy-pasting.

Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/microchip/ksz9477.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microc=
hip/ksz9477.c
index 1e2293aa00dc..755de092b2c2 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -439,8 +439,7 @@ static int ksz9477_half_duplex_monitor(struct ksz_dev=
ice *dev, int port,
 	 * half-duplex mode. The switch might not be able to communicate anymor=
e
 	 * in these states. If you see this message, please read the
 	 * errata-sheet for more information:
-	 * https://ww1.microchip.com/downloads/aemDocuments/documents
-	 * /UNG/ProductDocuments/Errata/KSZ9477S-Errata-DS80000754.pdf
+	 * https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Produ=
ctDocuments/Errata/KSZ9477S-Errata-DS80000754.pdf
 	 * To workaround this issue, half-duplex mode should be avoided.
 	 * A software reset could be implemented to recover from this state.
 	 */
--=20
2.34.1


