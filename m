Return-Path: <netdev+bounces-117611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B8C94E8CA
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 10:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609EA1F22489
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 08:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79B516B3B7;
	Mon, 12 Aug 2024 08:43:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A4316B39A;
	Mon, 12 Aug 2024 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723452233; cv=none; b=bNFg45n0V5A8n/XSboAOnGqT/K2NvXfX7//BJTd5LfiqdNEIg+Kh1nGMytLGEWFYs2Z9Qa6ti4KZclt/jZoypu9Pitxc6PAiGQxod2XFc1Vk/JbxmtVapc90e/IX/LqhV+6wIXIugUABnDZ3N6IIxTZ6wMRorHfD09I8uEeGmI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723452233; c=relaxed/simple;
	bh=ANv8AQEsfkvQj/u7AkhLBUOvAjn+a+00KnO6aHlPegU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EfftNwmO81NI066ej9qqUMfA2XeAXBJwAr8Rue7qIwkVWe5R2rhdSZMIHXeZj5f2VzlEiBPqqJSfJen8vSg3p2izRrMkWrMW0z0agYtlQwB1HJMsZlrA23gVot1VSXt6ZwyWoWA1xQpULKABAOk2LHoRvhkbpp99ZQygX/N6l40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (217.23.186.16) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 12 Aug
 2024 11:43:32 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Breno Leitao <leitao@debian.org>
CC: Roman Smirnov <r.smirnov@omp.ru>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Karina Yankevich <k.yankevich@omp.ru>, Sergey
 Shtylyov <s.shtylyov@omp.ru>, <lvc-project@linuxtesting.org>
Subject: [PATCH] drivers: net: bsd_comp: fix integer overflow in bsd_decompress()
Date: Mon, 12 Aug 2024 11:43:11 +0300
Message-ID: <20240812084312.14127-1-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 08/12/2024 08:23:14
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 186990 [Aug 12 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 217.23.186.16 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 217.23.186.16
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/12/2024 08:27:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 8/12/2024 4:43:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

The result of a bit shift has type int. If ibuf is greater than or
equal to 128, a sign switch will occur. After that, the higher 32
bits in accm will be set to 1.

Cast the result of the expression to unsigned long.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
---
 drivers/net/ppp/bsd_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ppp/bsd_comp.c b/drivers/net/ppp/bsd_comp.c
index 55954594e157..078fe8c9bee8 100644
--- a/drivers/net/ppp/bsd_comp.c
+++ b/drivers/net/ppp/bsd_comp.c
@@ -918,7 +918,7 @@ static int bsd_decompress (void *state, unsigned char *ibuf, int isize,
 	 */
 
 	bitno -= 8;
-	accm  |= *ibuf++ << bitno;
+	accm  |= (unsigned long)(*ibuf++) << bitno;
 	if (tgtbitno < bitno)
 	  {
 	    continue;
-- 
2.43.0


