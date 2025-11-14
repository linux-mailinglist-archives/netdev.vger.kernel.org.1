Return-Path: <netdev+bounces-238714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF47C5E21A
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 17:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF1A42488C
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAFF31B83B;
	Fri, 14 Nov 2025 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="KlFJoQtC"
X-Original-To: netdev@vger.kernel.org
Received: from mx12.kaspersky-labs.com (mx12.kaspersky-labs.com [91.103.66.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A8B315777;
	Fri, 14 Nov 2025 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.103.66.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763135783; cv=none; b=iW+coIV/Hl9Dt1aG82oOzbVu0dkNJWBa/wZEErABNW1jLjBXGSWonpmGm9zQcCcueFSYPTOuWn/7gqPGNr6i4+JfqFSHM5PW7tE2CNWx/+d6pNA8H3g019Ml20s3zQVMd+hQ3x4p8cAosQ1w5eJOiTvmnWPh0ZbDmXYYFMeiQ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763135783; c=relaxed/simple;
	bh=GTe7rjQArXm9Jvhr/1+AaZMCTV37ChVrtVknGqvvavo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Geg+mzuCHxyU9pDd16Hr5mtUQotiDLzNcxijm+uW9xIVlRyI6tXRAYpIJ7umBxXD2CJLrNEkPQR7SpnPWmtCff/vu+7Z6bEuw4eEmI9Axke2PoXebdgNeX7Op0SH+2tFq+ius2C6Jyf2sSnml8w9XAvpCNa2iLZsUie/s94DrA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=KlFJoQtC; arc=none smtp.client-ip=91.103.66.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1763135780;
	bh=y4SDX/1GdpbWKhuMsarQXHUPLRNPCdexVegUqbW62Vs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=KlFJoQtC22dpCNQqqa7/IWbq3YawzGIKtcf9PX40ZxKVhveuUlpevQjVEcPbjg4y3
	 pxaj5BSxRrAiDGGBc28OoUo2M8Zsi+eSxBHFQ8iGv0siYFOFmmxla1GwQxG8GVOjBr
	 nEzvCM6mK4iVdRTn982gzKLv9CbuTw4L3voo3/f1tQi7P5EyUMhoCHO021NkZrH9hL
	 ziWnVInYJHWehL5TzMu2yfyuWXcMJacq2tSwiIkNOx5QkZFIuKb8xybyexN9jU+L0o
	 9E48oZ5JzxxQEBk/6mZOn6nL9ZWPMoslpu2f13b2CDVrboVrwccLMc1B0dlI8il9C6
	 elAU9ELmU5I5g==
Received: from relay12.kaspersky-labs.com (localhost [127.0.0.1])
	by relay12.kaspersky-labs.com (Postfix) with ESMTP id 0BBBB5A5483;
	Fri, 14 Nov 2025 18:56:20 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub12.kaspersky-labs.com (Postfix) with ESMTPS id 080615A49C8;
	Fri, 14 Nov 2025 18:56:19 +0300 (MSK)
Received: from zhigulin-p.avp.ru (10.16.104.190) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 14 Nov
 2025 18:55:19 +0300
From: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
CC: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Michal Simek
	<michal.simek@amd.com>, Esben Haabendal <esben@geanix.com>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH net] net: xilinx: ll_temac: handle of_address_to_resource() failure in MDIO setup
Date: Fri, 14 Nov 2025 18:55:18 +0300
Message-ID: <20251114155519.3524628-1-Pavel.Zhigulin@kaspersky.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV4.avp.ru (10.64.57.54) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/14/2025 15:35:04
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 198111 [Nov 14 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: Pavel.Zhigulin@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 76 0.3.76
 6aad6e32ec76b30ee13ccddeafeaa4d1732eef15
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: kaspersky.com:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;zhigulin-p.avp.ru:7.1.1,5.0.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/14/2025 15:36:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/14/2025 2:08:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/11/14 12:42:00 #27925085
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

temac_mdio_setup() ignores potential errors from
of_address_to_resource() call and continues with
an uninitialized resource.

Add return value check for of_address_to_resource()
call in temac_mdio_setup().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 8425c41d1ef7 ("net: ll_temac: Extend support to non-device-tree platforms")
Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
---
 drivers/net/ethernet/xilinx/ll_temac_mdio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_mdio.c b/drivers/net/ethernet/xilinx/ll_temac_mdio.c
index 07a9fb49eda1..ab23dc233768 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_mdio.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_mdio.c
@@ -98,7 +98,9 @@ int temac_mdio_setup(struct temac_local *lp, struct platform_device *pdev)
 		return -ENOMEM;

 	if (np) {
-		of_address_to_resource(np, 0, &res);
+		rc = of_address_to_resource(np, 0, &res);
+		if (rc)
+			return rc;
 		snprintf(bus->id, MII_BUS_ID_SIZE, "%.8llx",
 			 (unsigned long long)res.start);
 	} else if (pdata) {
--
2.43.0


