Return-Path: <netdev+bounces-246384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4595CEA87B
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 20:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0C6E3002848
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 19:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB4E2749D2;
	Tue, 30 Dec 2025 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="x1HgDMk4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DDE261B91
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 19:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767122299; cv=none; b=NRZA49rhrETM29dEhm11Bz6GDLgNbup5l752VJ/ywDy8ZDziuomDSZQrhQjNwY+QQOorrB60mhV9vLlBxDzj4abB9habvIYL6LYsV96OKwJfosLEeAJhXA8R+xaSzUhLU5BXOoYCbLwf9xuCX49hbVXX7rwe1m3rcaVuYlxmfuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767122299; c=relaxed/simple;
	bh=+/qYVGHS9whREl9wMfE/Im3VfFq6fcB6Vf7VUhKTaVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tbcGQFeUIv/PDb+kTpd6krwxbBfzECVxUsCt2VwOq1H+gBIS5D49og/TrdWE8vt19K1cd5Y6OGeK7HBvShpVdQmaRVvfOqggzAZGs8b4clfu9Rk2z1N9ujeKOFhnECPcJX1uS841SkZCFu6T5yz9gIseG1RC+FB/44WPGDbXxRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=x1HgDMk4; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88a367a1dbbso162991076d6.0
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 11:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1767122297; x=1767727097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VM8NU8RSIpNM+NAIMAH/BxvA1IJjsQyJhFywNUYlvYw=;
        b=x1HgDMk4ssEqRfmZQcKUi/zCLvG4y5KlGvZd7TzQq1+bFiAA45qlsL8kp3S7Or5ucS
         95GR/bEnfb03NE4+unBI2LWgMVaerZxVZTnPlRPQqxJbLeT+B9Hze5EYqJApKVp/53q6
         DxbTgnhlDHIlAcOSIdIdZa5pVX0zsn3friT+FpA5zewRS9hRWKhK43vATosm17PaXbXJ
         01qZB91JYlDGpHuL1DbCJ7DxjJV9PmXLKUFtJMeBnno3xDyFw3VV9tq/TmLaz5odPm31
         AXFAqYQNZ3xTN+bV0dUz+WQtThqIuaP6LITs81TuAEyiEeWvqhP2sZuh4ZGb41C4Wk+E
         RbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767122297; x=1767727097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VM8NU8RSIpNM+NAIMAH/BxvA1IJjsQyJhFywNUYlvYw=;
        b=MA0w71+YdUZhp6I7m1eRGbekw4WzhKiicdh4WshFoFcuwD9uNogWPikvHODgVOdQTA
         ZVV3b6cduUGDLciZzFckgqahMknKeopdEg4B98w3xRDuoTifG9hlGH6vjdhFELDWN+wW
         MXPouTP4ztXzd57TaIVPy4yn48vW6bXId8wKYUYhbYPElF+XZUmFu0+cskNt0c7s8Z8n
         zo6EW56MNhy40FCpllhzfp5Uc4hQp0nsU96RRPw6/SRKDNkor0nhMP6jCNN6/ubVClbQ
         vQQqdpTyJBYYaTGbVq8rHjbqKghUi0253THonqgibzN7O2mxwW6Bp5UqFuj2rb3VpI4/
         ikdg==
X-Gm-Message-State: AOJu0YxgI2m/yry+oylATqbBjb1wGqPNhxSsXKt/KFq1qXpjCzm6y2Xv
	DskBvQ5CcTQk7qszQMOFnFW37I2GqHfbA+qXSFFiNz/MAU5o9IGA1EA2dSwHnVjZXQ==
X-Gm-Gg: AY/fxX43CV50MJvq+ulMQUcpzoi6p0SWqC28SqpikrM5z8oaCbtSSz+mLD8wYgt7IOI
	0U0DN1NACa4iz/YLn7IuNfOVxMV+lmsOnx6dMUg1w+FH/rajvc5pmWqi7seKMDOc+NW4jksKySA
	VJvMXY+nt1Mm36O+AUJmwhFxfhTSXmHShten0AR87yXdC2lWR9bhEzZgThIHSK2ng2K7d7Re+bO
	U7WSO+5mpSTccDsOTQsHq7KQENtKXFvXtAMLwKny6wNAV10vadqxjsezPqDUcWUlHuwBNGRgvMl
	SjovO+nxtlhaPsYeU1iSMhh3CgK/1NnxXs1OYUWF42fwgxT1L0orYNRkOcVPva0nUGTeuehgUXD
	fFr6e7VX6O38dxmEewx/6cX3MDFl3w4zFKtlKiQ5ognDIh0vph4g4V39ATI4mvcQXAMt4XSIyH4
	NAiMIuC4CmxESCSlr0R7Ws7BeLUOL6dYESoCG/6+FOcsI7niVruKkiE79QZvJunlORlBHN36e/
X-Google-Smtp-Source: AGHT+IGiC1dIFyCwBPy9CVnUzumHuT6UcgGL2JyTN4OPzrLqsQHc5UnLOK/DQ9anSPNGyGpYH2dOYw==
X-Received: by 2002:a05:622a:1a96:b0:4f3:4cd3:164c with SMTP id d75a77b69052e-4f4abcd2a94mr501219851cf.21.1767122296728;
        Tue, 30 Dec 2025 11:18:16 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1621w-grc-18-70-50-89-69.dsl.bell.ca. [70.50.89.69])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac62f973sm256121391cf.18.2025.12.30.11.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 11:18:15 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 1/2] net/sched: act_mirred: Fix leak when redirecting to self on egress
Date: Tue, 30 Dec 2025 14:18:13 -0500
Message-Id: <20251230191814.213789-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whenever a mirred redirect to self on egress happens, mirred allocates a
new skb (skb_to_send). The loop to self check was done after that
allocation, but was not freeing the newly allocated skb, causing a leak.

Fix this by moving the if-statement to before the allocation of the new
skb.

The issue was found by running the accompanying tdc test in 2/2
with config kmemleak enabled.
After a few minutes the kmemleak thread ran and reported the leak coming from
mirred.

Fixes: 1d856251a009 ("net/sched: act_mirred: fix loop detection")
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_mirred.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 91c96cc625bd..c9653b76a4cf 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -266,6 +266,17 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 		goto err_cant_do;
 	}
 
+	want_ingress = tcf_mirred_act_wants_ingress(m_eaction);
+
+	if (dev == skb->dev && want_ingress == at_ingress) {
+		pr_notice_once("tc mirred: Loop (%s:%s --> %s:%s)\n",
+			       netdev_name(skb->dev),
+			       at_ingress ? "ingress" : "egress",
+			       netdev_name(dev),
+			       want_ingress ? "ingress" : "egress");
+		goto err_cant_do;
+	}
+
 	/* we could easily avoid the clone only if called by ingress and clsact;
 	 * since we can't easily detect the clsact caller, skip clone only for
 	 * ingress - that covers the TC S/W datapath.
@@ -279,17 +290,6 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 			goto err_cant_do;
 	}
 
-	want_ingress = tcf_mirred_act_wants_ingress(m_eaction);
-
-	if (dev == skb->dev && want_ingress == at_ingress) {
-		pr_notice_once("tc mirred: Loop (%s:%s --> %s:%s)\n",
-			       netdev_name(skb->dev),
-			       at_ingress ? "ingress" : "egress",
-			       netdev_name(dev),
-			       want_ingress ? "ingress" : "egress");
-		goto err_cant_do;
-	}
-
 	/* All mirred/redirected skbs should clear previous ct info */
 	nf_reset_ct(skb_to_send);
 	if (want_ingress && !at_ingress) /* drop dst for egress -> ingress */
-- 
2.52.0


