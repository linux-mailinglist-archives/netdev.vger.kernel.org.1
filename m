Return-Path: <netdev+bounces-127858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64E6976E4A
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32FD71C23889
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 15:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE061B78FC;
	Thu, 12 Sep 2024 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="GDS4tjt3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C091A2567
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726156719; cv=none; b=lhj7Lqi6BKvE+PXCI4pZ/vdEPvKB+Nn+kYHnGwINptaDCcUg4w2G3Zg4NQKbE3IDS0dTVFtpCUZRcOgkdRDJ1oI9xMhpMSm2No2zSc5BL70WpF4uIf4Ej32AgowEt6+zcWW+u0f3tYQ4J1fRAQrh8/FASapELy4OaRSPQM3gVa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726156719; c=relaxed/simple;
	bh=U9dUmOOuXwqX5mq5q+c61lnytJLwV7sVtmKS0yIcsSw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J4iaKROZUEwPBykQgh0LXcpk8n5V6MxtYUnlGpNFhuqK87K3uoeXszgRFtSt2ghlNmM+XOsWWzkvHvCUR3+VUJuaGcNk8/NlGDxDHF1t/hyjKHUFO1GgwzqdO8aPKR+QuiEfyeRQtOqujgHZ+hfh+fqydx/ZGMwDx6lv3ZBMc+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=GDS4tjt3; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e040388737so592335b6e.3
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726156717; x=1726761517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QYJCNJBfM3mnUo54efKbh8cT5QtGE+6/2LtRTMxqLoo=;
        b=GDS4tjt3M3sXn+ItjcSGcbN78M+3NQnT2/GqI0d4l3MIQJthhVBdkGU3aZXYCYXSxi
         BFSNFYJj3IzEYivyCDukdcWGiTM2t2KanXMrlhCp7avbOnN1f0iajVmQYO+CWzwcD2yt
         HbhY5OaAYqlNHs3Q7KEo7EB4CPVuwj8nWWlZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726156717; x=1726761517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QYJCNJBfM3mnUo54efKbh8cT5QtGE+6/2LtRTMxqLoo=;
        b=C4GcW6YgJ2B8i1WlhmvpTws/kZcAHqA9G70A/spheBapybzhJbyCYFXZAefXaftFr9
         MkBJrl+ZqS4GWZ9hYR7n2dv3HG9okeepgVbLBkJiNoqm0fNa10UhlcJ1Z6ElOD7BE3AH
         Z5DWv4iirkC9I8fxUxPS6327x9Ab1u7++BqKCyo5w1101qIcmiiVePPUT3uaB1ZPlRP1
         MfTxEJZgTHh8+h5URY0Ih871FdIxOPKYWDoVdM1n0+R4FYJR+/Siinb9WHTK7MBtfX4r
         3GFU1lNzBtwtuo+2I4r8Sbpi9ToF8wpMt7lDAXFUOJOfZyCVJf5JDNsTzJ+phJZEJ4fp
         Bn4A==
X-Gm-Message-State: AOJu0YxnBymBFvMGnGWN1i6ENpCXEgG/QfSA9LYTdOBM2FgqTRAKUfRd
	WbFL96XlaeVTyoMWyupqa01qaee39X4eu2gjRukjmeZpNAec1UHm4m3JBYbXbuiD2bauUOX9CM2
	dRqyg76t9nlviEeoapYFb4RSI62+C+79sbN0JlpgTd67HBYkPdwxV3DmHqHn/O4nBxpLkmX7OSP
	KE/RzssoZ1LRz05c18Sevh1YZDrfzL0V3COVVCDg==
X-Google-Smtp-Source: AGHT+IG3uy2cnoFLcKM6BA2VUcWTFVL1Y4Nki9RUdsjOWsRn+gcYCkgHPFUU6mCU9sbh30OTyZ5Mtw==
X-Received: by 2002:a05:6870:7b47:b0:277:d7f1:db53 with SMTP id 586e51a60fabf-27c3f2c3db5mr2514880fac.17.1726156716474;
        Thu, 12 Sep 2024 08:58:36 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbb527csm1913939a12.27.2024.09.12.08.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 08:58:35 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] tg3: Link IRQs to NAPI instances
Date: Thu, 12 Sep 2024 15:58:30 +0000
Message-Id: <20240912155830.14688-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link IRQs to NAPI instances with netif_napi_set_irq. This information
can be queried with the netdev-genl API.

Compare the output of /proc/interrupts for my tg3 device with the output of
netdev-genl after applying this patch:

$ cat /proc/interrupts | grep eth0 | cut -f1 --delimiter=':'
 331
 332
 333
 334
 335

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
			 --dump napi-get --json='{"ifindex": 2}'

[{'id': 149, 'ifindex': 2, 'irq': 335},
 {'id': 148, 'ifindex': 2, 'irq': 334},
 {'id': 147, 'ifindex': 2, 'irq': 333},
 {'id': 146, 'ifindex': 2, 'irq': 332},
 {'id': 145, 'ifindex': 2, 'irq': 331}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 378815917741..c187b13ab3e6 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -7393,6 +7393,14 @@ static int tg3_poll(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
+static void tg3_napi_set_irq(struct tg3 *tp)
+{
+	int i;
+
+	for (i = 0; i < tp->irq_cnt; i++)
+		netif_napi_set_irq(&tp->napi[i].napi, tp->napi[i].irq_vec);
+}
+
 static void tg3_napi_disable(struct tg3 *tp)
 {
 	int i;
@@ -11652,7 +11660,7 @@ static int tg3_start(struct tg3 *tp, bool reset_phy, bool test_irq,
 		goto out_ints_fini;
 
 	tg3_napi_init(tp);
-
+	tg3_napi_set_irq(tp);
 	tg3_napi_enable(tp);
 
 	for (i = 0; i < tp->irq_cnt; i++) {
-- 
2.25.1


