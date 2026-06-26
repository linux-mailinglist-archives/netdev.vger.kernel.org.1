Return-Path: <netdev+bounces-302278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j1b4IcICP2qlOAkAu9opvQ
	(envelope-from <netdev+bounces-302278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 00:52:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E706D076A
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 00:52:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RMajR2uP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302278-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302278-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1EAB302E7A4
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 22:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E2139D6C8;
	Fri, 26 Jun 2026 22:52:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92E8330659
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 22:52:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782514355; cv=none; b=j9Rb3repEk5X8KvzYJyNSkgsTI5J6zXuFxUQ1+IZSoblrj/pyePbsL91jwfuKeNCtn02PDiwRcSqHAL4mHJ2yXT+xp1/wqGfPGTCn2e51+c/DBDT0UFpVYUTi4j4w/12RjCUkEralWa0Z2VHG9bnRvmWJIAUAqaIRILmOZO8X94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782514355; c=relaxed/simple;
	bh=SwOPJqpg4b6qLai1Os6dv/e6e2ZIKWpVZgpCjMbs5k4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uuLZHJPTwc5UU3RqIqRLTr3I+9jNDF3gltxoPw9d5ncwNW67J1o+iYIwFZ8P5NnWN+QobMi9MI8Whd1VS+Z62vDltWuDEdjegPAHXdrnTrR2KYHIje32gBYlG28XzgUV36wjVfQ8I6G2OmmpSMWA0IEj+APqtHeQ5XLQyh5pz7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMajR2uP; arc=none smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-845b965c1c4so840322b3a.3
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 15:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782514352; x=1783119152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WcxVtojs1bzoEtQJKG5MqOp3NObqU50nISOInJcEpNA=;
        b=RMajR2uPVVKx+FDbhADutccRzPyHpIaKpSuLj679zn8tV3ZeL3F7CltOFSir0Uf4rP
         y7WOlpi+dHMtMt34XNjrLBuUU8xjwGX3U+o17+NCuUhjUwk0ncsDtGfCGoh6iAJtutVn
         6WgSqNmFhOBNt4z3zb63mi3vMctMnWhpNU249qZk6g0N2iPUxNxlwQrORpk28e8KO+qh
         c/f/AzlTFSO9Ep/inHfgwRki9tRbnZC+E2dQYYsDf6ctZ1LfW+WZVBwd1eMQEOdEuqHY
         dhgGkmxurt8rLqnIauTacXGEKV6Y+rcbpcJNDIYfSZD3TQQsWPu4oMJ9XBznuFBATGnO
         WNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782514352; x=1783119152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcxVtojs1bzoEtQJKG5MqOp3NObqU50nISOInJcEpNA=;
        b=Mv7e2iEEM+FWIs/0Nrr0vKbhuXxzsNrmWtZAoLWlRneTjlBULBXdA+RJM5GRkRHJOj
         tJ+ZHd+fQGuT2PFMUrGrYvimsMyKt8n9Jeu2zYLQu9NsllYHhJNxdDPM2X8cGXkCrtf+
         SMa88l6zRXBoTUhEidTnPC2m7rxLWcWKsm4+1Dc2BcwYouaqYGBOec5CIw9BanhInpbU
         MjtcKq1n80LRv3jfN8xFfhiEWu7Quqpe/DDDcNOa81FNguEdt74UwhBr5MCEfgTmuPGs
         i/HHpL9sGiL01C2iFkUnBMKv0db0hZYhyeefBgQFpXdvPVwSikHhETx2/XiTuAfIz03I
         c9Lw==
X-Gm-Message-State: AOJu0YzjriRL8H4y03BRhLRyciZMpizpdWRXy2vKXOdIMffBgCFN6cRR
	+O2axf/07/ZtHe0jt9pnRYRlz/uNUXG+8bkKGj39hhnFo1MIR3jEGKsMd11mrQ==
X-Gm-Gg: AfdE7ckNbtye2N3U7umgmEXjw+CS8M/ZiW2Oq0SMBsLyuKKjCFOryrNhCPa+eJo12RD
	RvjK0yQYdfZhEOGJ24rgma05BIZpt7e8l2h2ZNvJTn8mYb+Vs/cIWf/iPryA+5hsce1BenHLoZw
	EU3rfkJ2IYpMSoaMO69fTa+ud1MlqXlB/FL/LKJwyvd0Mv2RcXi+9sLRH9rq/D48GftA+rGBEt+
	V6rpNQkgDHpyWbBpMuu1fPOe+Wcat0qi9XqRpFIq8Bs7smVmnUDDj6rrFyKZa0ao1efsffsnyaV
	4NVLSrM6MdU40FVCqxGuMtYFh1FBp+loh43Z8BpkFjYdUfK0YpE2usazBQktKkmUQia8ZCmWRzZ
	v6WN/vOm5sAjcS8FIvShgfNgZgkLyuzD/l6+cpFVacTGPep6ynaiL44ZH5+bSEYv8bNjLVEf3LC
	sK3y/5+5i3gdZT7j/HuXlGAITnTw+DojRPWbQBkGgxiljPw0zPRKIG8BosebxALhhp7InwvQdsy
	2pYwvUGcw==
X-Received: by 2002:a05:6a00:288d:b0:845:a24d:9b65 with SMTP id d2e1a72fcca58-845d1fcaa8emr1886069b3a.14.1782514351859;
        Fri, 26 Jun 2026 15:52:31 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:5b5d::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a3ec0ec9sm7427385b3a.0.2026.06.26.15.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 15:52:30 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Fleming <afleming@freescale.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: gianfar: dispose irq mappings on probe failure and device removal
Date: Fri, 26 Jun 2026 15:52:28 -0700
Message-ID: <20260626225228.427392-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:claudiu.manoil@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:afleming@freescale.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302278-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03E706D076A

irq_of_parse_and_map() creates irqdomain mappings that should be
balanced with irq_dispose_mapping(). The driver never called
irq_dispose_mapping(), leaking mappings on probe failure and
device removal.

Fix by adding irq_dispose_mapping() in free_gfar_dev() and
expanding its loop from priv->num_grps to MAXGROUPS so the
error path also catches partially-initialized groups. All
irqinfo pointers are pre-initialized to NULL in gfar_of_init(),
making the NULL-guarded walk in free_gfar_dev() safe for every
scenario.

gfar_parse_group() itself is left as a simple parse function
with no resource management; cleanup is centralized in the
caller's error path.

Assisted-by: opencode:big-pickle
Fixes: b31a1d8b4151 ("gianfar: Convert gianfar to an of_platform_driver")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 3271de5844f8..89215e1ddc2d 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -469,10 +469,13 @@ static void free_gfar_dev(struct gfar_private *priv)
 {
 	int i, j;
 
-	for (i = 0; i < priv->num_grps; i++)
+	for (i = 0; i < MAXGROUPS; i++)
 		for (j = 0; j < GFAR_NUM_IRQS; j++) {
-			kfree(priv->gfargrp[i].irqinfo[j]);
-			priv->gfargrp[i].irqinfo[j] = NULL;
+			if (priv->gfargrp[i].irqinfo[j]) {
+				irq_dispose_mapping(priv->gfargrp[i].irqinfo[j]->irq);
+				kfree(priv->gfargrp[i].irqinfo[j]);
+				priv->gfargrp[i].irqinfo[j] = NULL;
+			}
 		}
 
 	free_netdev(priv->ndev);
@@ -616,7 +619,7 @@ static phy_interface_t gfar_get_interface(struct net_device *dev)
 static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 {
 	const char *model;
-	int err = 0, i;
+	int err = 0, i, j;
 	phy_interface_t interface;
 	struct net_device *dev = NULL;
 	struct gfar_private *priv = NULL;
@@ -702,8 +705,11 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 	priv->rx_list.count = 0;
 	mutex_init(&priv->rx_queue_access);
 
-	for (i = 0; i < MAXGROUPS; i++)
+	for (i = 0; i < MAXGROUPS; i++) {
 		priv->gfargrp[i].regs = NULL;
+		for (j = 0; j < GFAR_NUM_IRQS; j++)
+			priv->gfargrp[i].irqinfo[j] = NULL;
+	}
 
 	/* Parse and initialize group specific information */
 	if (priv->mode == MQ_MG_MODE) {
-- 
2.54.0


