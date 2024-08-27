Return-Path: <netdev+bounces-122192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE0B9604E2
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 10:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00CA6B22A8B
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 08:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CCE194AEF;
	Tue, 27 Aug 2024 08:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="pJHCghFu"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23265154BEB;
	Tue, 27 Aug 2024 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748588; cv=none; b=aQG3EEEgn270hwhwmaYw4/2F1DJ861qxsdd1GJuri+8sRqcHa1qYnWV1f6b/YyBsAsWTWbu1wIdiIFSFtc/VgV+2x4zwop92pNvQeuj9xuTFgviD+uynm+GUxiIUNqGoqnWrGJWgwZSdnPZasqBex6dRJUQqjag2yRM0qJgFwgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748588; c=relaxed/simple;
	bh=dE2gW+ZO/qZX9un6jBi2F+LLchhhBJ9EScI+EevRd60=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FT/yy2sjr45jDGowQKwk19zUrIfy8GzMZysif1TE6MNYcmntRoNsHiURHpgdXAo5ThBlltZIrRe+O1jZSJU1/4rjyHnSF+97jKTYFs6iIBw6Dp5Fec6rObotiXujSZ2PSNh+KEYmcR8bynRAJuNX0N7zMwIgS83SbmksYuhESPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=pJHCghFu; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id A72B9100004;
	Tue, 27 Aug 2024 11:49:25 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1724748565; bh=KVDFtO5L3fmErLMzsYM/k3v21g8RGEWN+I4MRuuiPiI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=pJHCghFutblbDZMWMjatluBcV214htrhRKAYdnmFRc1sZgEXeQ8vI5Z1vaR8H3iqW
	 n/5LDrxii2cY0BzrZfJJ+d6illJOShNZND3V8cOX1GrCAOmRpHtmOnnUHV6nX+zUNy
	 cSgyv0+3kpxY0m9zVGKniTnY13RJYgAB1ahIHkaBHNRtnecDnI5fn/NLbkInYFf+Fs
	 xPLNAXVDRE4Oa0lQ5ZMSsquQpLoBbURFU2MfAdY2bYHIc+3CS/f0XuWaCn48fZI8E1
	 PCr45aN9IZxfLqpX3nyYqsbhY56TtwNiYiNQ5rbkmxNfKn1a/HBCgy0wCtJiXbwGMZ
	 DxGBKIm5CUfOw==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue, 27 Aug 2024 11:48:51 +0300 (MSK)
Received: from Comp.ta.t-argos.ru (172.17.44.124) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Aug
 2024 11:48:31 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Samuel Ortiz <sameo@linux.intel.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Krzysztof Kozlowski
	<krzk@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH v2] nfc: pn533: Add poll mod list filling check
Date: Tue, 27 Aug 2024 11:48:22 +0300
Message-ID: <20240827084822.18785-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240702093924.12092-1-amishin@t-argos.ru>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187354 [Aug 27 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 27 0.3.27 71302da218a62dcd84ac43314e19b5cc6b38e0b6, {Tracking_from_domain_doesnt_match_to}, t-argos.ru:7.1.1;127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/08/27 07:21:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/08/27 08:02:00 #26443905
X-KSMG-AntiVirus-Status: Clean, skipped

In case of im_protocols value is 1 and tm_protocols value is 0 this
combination successfully passes the check
'if (!im_protocols && !tm_protocols)' in the nfc_start_poll().
But then after pn533_poll_create_mod_list() call in pn533_start_poll()
poll mod list will remain empty and dev->poll_mod_count will remain 0
which lead to division by zero.

Normally no im protocol has value 1 in the mask, so this combination is
not expected by driver. But these protocol values actually come from
userspace via Netlink interface (NFC_CMD_START_POLL operation). So a
broken or malicious program may pass a message containing a "bad"
combination of protocol parameter values so that dev->poll_mod_count
is not incremented inside pn533_poll_create_mod_list(), thus leading
to division by zero.
Call trace looks like:
nfc_genl_start_poll()
  nfc_start_poll()
    ->start_poll()
    pn533_start_poll()

Add poll mod list filling check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: dfccd0f58044 ("NFC: pn533: Add some polling entropy")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
v2: Update comment message for a more detailed description of the problem

 drivers/nfc/pn533/pn533.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index b19c39dcfbd9..e2bc67300a91 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -1723,6 +1723,11 @@ static int pn533_start_poll(struct nfc_dev *nfc_dev,
 	}
 
 	pn533_poll_create_mod_list(dev, im_protocols, tm_protocols);
+	if (!dev->poll_mod_count) {
+		nfc_err(dev->dev,
+			"Poll mod list is empty\n");
+		return -EINVAL;
+	}
 
 	/* Do not always start polling from the same modulation */
 	get_random_bytes(&rand_mod, sizeof(rand_mod));
-- 
2.30.2


