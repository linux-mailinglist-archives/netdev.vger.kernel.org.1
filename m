Return-Path: <netdev+bounces-220406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A515B45D74
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 18:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42C655C4824
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 16:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE122F7ABC;
	Fri,  5 Sep 2025 16:07:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7B02FB0B2
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088423; cv=none; b=U4PTFukOdjTNJBJtis38nu9WFZQMJs7v63Ib1NkhPbSfMPFjaQns9geUhwS54fGSl3JwciqHQI+Wruuuq+wK00116WA+e5R8l7VaY++Ut46KDL4zqNzhJDD8Z7gB2dwdY10XSPO7fh7iAt0YTDWyYZ6AGtpCc0GrT2xuHYbDY5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088423; c=relaxed/simple;
	bh=ZdTJ67Llrt0QzzhVrxWx0egci0wVkOnw/HkiZu35X2s=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=kmTNd6+iPqQLiWApUR++koZP/kCjCB5pg8eeogWqJkY6lZBgaShfMSSS6hepfepSU+Ia+VUq9oZ+yyQXzjoWeoqEgQbid4uA/hJHmMmzdGZo2aXVAYvCoDjhvVCMsaf2XiN151lDHINC0po47NL+UwNBcjYl2WI/343667wdyYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.137.226) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 5 Sep
 2025 19:06:50 +0300
Message-ID: <58116e65-1bca-4d87-b165-78989e1aa195@omp.ru>
Date: Fri, 5 Sep 2025 19:06:50 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	<netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>
CC: <linux-arm-kernel@lists.infradead.org>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH net] net: stmmac: prevent division by 0 in
 stmmac_init_tstamp_counter()
Organization: Open Mobile Platform
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/05/2025 15:43:06
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 196074 [Sep 05 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 66 0.3.66
 fc5dda3b6b70d34b3701db39319eece2aeb510fb
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.137.226
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/05/2025 15:46:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/5/2025 1:33:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

In stmmac_init_tstamp_counter(), the sec_inc variable is initialized to 0,
and if stmmac_config_sub_second_increment() fails to set it to some non-0
value, the following div_u64() call would cause a kernel oops (because of
the divide error exception).  Let's check sec_inc for 0 before dividing by
it and just return -EINVAL if so...

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Fixes: df103170854e ("net: stmmac: Avoid sometimes uninitialized Clang warnings")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
The patch is against the master branch of Linus Torvalds' linux.git repo.

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
===================================================================
--- linux.orig/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ linux/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -817,6 +817,8 @@ int stmmac_init_tstamp_counter(struct st
 	stmmac_config_sub_second_increment(priv, priv->ptpaddr,
 					   priv->plat->clk_ptp_rate,
 					   xmac, &sec_inc);
+	if (!sec_inc)
+		return -EINVAL;
 	temp = div_u64(1000000000ULL, sec_inc);
 
 	/* Store sub second increment for later use */

