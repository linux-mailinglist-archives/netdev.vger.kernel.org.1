Return-Path: <netdev+bounces-181914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD1EA86E02
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 17:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6DB616777C
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 15:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F06193402;
	Sat, 12 Apr 2025 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dqg9yM7h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E63718E3F;
	Sat, 12 Apr 2025 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744473009; cv=none; b=HtGzlWdtN/3iTk2a4UkqH/fJ7Zd5XtNHnrAvNmKdiUj0/JCvaI3M0KVkDJc9UnxrQVC0Or6XQ9gGmftaeg2M9vIEHLjIdqe/G4y3NBAT006T8LltSHX6Pb8VilyiKR9KRFl6fjGkZyZdAweSbJqDefhrm+2JdUmPCzMd0e/xXQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744473009; c=relaxed/simple;
	bh=khl++lgzyDmxLxZyYpPyevPlGEvdB/5Y/xk5sQE5LF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LWNJ/yyiE/260llYJXX2EpDHKpIIyZaNLkd4CBxuCUdZoKOISsKOBEZzMkD15o9Dyd1PZBFeJUHwNoEgA0u8yI+mHt1k/avd0ERU6ev7SDoiEOKu0Zgl4aTb1Lkc38bg0Gp6zE2/0J6G2HgNL38t6pdUfEimIT7I/9u91+qbBks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dqg9yM7h; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-226185948ffso32662335ad.0;
        Sat, 12 Apr 2025 08:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744473007; x=1745077807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yvLakejU+EHM6ubcv+pTGic7/jCzSqnHXu7AP1oYfpM=;
        b=Dqg9yM7hMppOcuwnPpXhxQaET9kGuidMDLp/tIj//tqe+QS+0tYFwc4AzSxKbF+e2r
         vHvZfwG2tArctjuR3wtQ2VKst625MYneeJpi3pMvAM0cyoH5gPUsf2f0IWuAmHOMSYgB
         5umK6mv50zteRrP+gBOEgqXE8WMjuntjyEB24HYg1ddGuWde0TqCPpAqo6keX2Uk/ypf
         A5UJnwoSzqwX3soIFZEkmXWwwYfiASGsDze6ZMsC0JS0IWpWmTRmiixFxsXBc9cCDviC
         2p1qHOmrNEhHWtHCzuZAntRGlRVwJtAIEoaoJ+2JaOt0luMG7lk4wB0ePcMFudo3c9zd
         eXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744473007; x=1745077807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yvLakejU+EHM6ubcv+pTGic7/jCzSqnHXu7AP1oYfpM=;
        b=wWS12AQJyc6ETY5eOFzqQsmnWOfCh0LZ+7VbG8jS1KSz/SAg9h7H0DVARyMqkISo+S
         x1SZIrybNAz1pPYYNKR34tHxbNi0pmv68U11uBMcZ7Ri4u2raP94euiJXBe5I0XIuJ+x
         EnaIPGBrt2uWpbLV/wucXF/28HC5WD/bO6CE89e/IUe6u0E7eWUTk2kBZMZRALBGGhnq
         FaA9CK71082OlGBjGJw5TFJYTp5F/wTz2Dl6TaydPqJlRxOa4c27yr0vDVcWTbCxepeP
         PSaqHL2CC3ilAQG4CfE9rnGhm1hOCz+48PoVbcY+moio/fJQeZSGzPuBes7rrArNKdE5
         ZIbA==
X-Forwarded-Encrypted: i=1; AJvYcCVhJpViXFcWByf+F27md1An5qPYaQh/38JS6HuO0Efq5alu0l9sKqg7qAExU/022uq2OEBJmiSJ@vger.kernel.org, AJvYcCW4+F10iSFmMHK/uYgiYpGv+NPhWc/BAmyJtVzHFJMsW6ho6tCef3fGeU9uNcu95p/MKKQ2uFgG6P5EkrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSSeS0gqrZCndTX13GdNm/gmhyfzf9TTovIGxVdfbZSZM0XBIL
	pVxicNKVZHIZ7AJKqHrXGiFZZFCfPsfyFIwRoszvrH8z31TQR25+xt4z2g==
X-Gm-Gg: ASbGncvDB9guPoPlnYKcFZjYw4VIiim2+t50X+tzVQjkQZyOEyI0PZynqqjvU0759XI
	zBZZQ1ZMc/CAPK+Dzh3qXmSmiksY3jZySFDM5jv5JSi0vwzZbcnCIfxQxcCj9q5gUl+EhVlQAL3
	5agCNZ++JBd+ppNJc4U+omDHDent9kYwiyLtfGG671gAMnwXre21Axo7dnS6num6CMGX7bi6XBg
	KfSUzYwW1OB4TAJKaESXnWWX6q/FSz1jwJvm1e1xtsxIfrTHMeo0Ws4Z3iVo+Liw+ITC6rjrFL3
	eD9FCoLSUGKjqdQn1+QUhILeLyouObNql2dq6N8NmIEqLybqxZoV0cKq
X-Google-Smtp-Source: AGHT+IHSWJuHJwnhDT1o/e3ieyd/vRmTtnmhVS/y4JQQi6s8i8CTOj12wgmQ4rVo4RX8rmm5CoCUDg==
X-Received: by 2002:a17:902:ec92:b0:223:62f5:fd44 with SMTP id d9443c01a7336-22bea4f20bemr88684355ad.40.1744473007401;
        Sat, 12 Apr 2025 08:50:07 -0700 (PDT)
Received: from localhost.localdomain ([49.37.219.212])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73bd2334468sm3521817b3a.169.2025.04.12.08.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 08:50:06 -0700 (PDT)
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: jiawenwu@trustnetic.com
Cc: Abdun Nihaal <abdun.nihaal@gmail.com>,
	Markus.Elfring@web.de,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	saikrishnag@marvell.com,
	przemyslaw.kitszel@intel.com,
	ecree.xilinx@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net] net: ngbe: fix memory leak in ngbe_probe() error path
Date: Sat, 12 Apr 2025 21:19:24 +0530
Message-ID: <20250412154927.25908-1-abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ngbe_sw_init() is called, memory is allocated for wx->rss_key
in wx_init_rss_key(). However, in ngbe_probe() function, the subsequent
error paths after ngbe_sw_init() don't free the rss_key. Fix that by
freeing it in error path along with wx->mac_table.

Also change the label to which execution jumps when ngbe_sw_init()
fails, because otherwise, it could lead to a double free for rss_key,
when the mac_table allocation fails in wx_sw_init().

Fixes: 02338c484ab6 ("net: ngbe: Initialize sw info and register netdev")
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
v1 -> v2:
- Add fixes tag, as suggested by Markus and Jakub.
- Also set the branch target as net instead of net-next as it is a fix

v1 link: https://lore.kernel.org/all/20250409053804.47855-1-abdun.nihaal@gmail.com

 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index a6159214ec0a..91b3055a5a9f 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -625,7 +625,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 	/* setup the private structure */
 	err = ngbe_sw_init(wx);
 	if (err)
-		goto err_free_mac_table;
+		goto err_pci_release_regions;
 
 	/* check if flash load is done after hw power up */
 	err = wx_check_flash_load(wx, NGBE_SPI_ILDR_STATUS_PERST);
@@ -719,6 +719,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 err_clear_interrupt_scheme:
 	wx_clear_interrupt_scheme(wx);
 err_free_mac_table:
+	kfree(wx->rss_key);
 	kfree(wx->mac_table);
 err_pci_release_regions:
 	pci_release_selected_regions(pdev,
-- 
2.47.2


