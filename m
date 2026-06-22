Return-Path: <netdev+bounces-300941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RiKZMs6bOGrPeQcAu9opvQ
	(envelope-from <netdev+bounces-300941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 04:19:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3856AC0AC
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 04:19:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NICeIIvu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300941-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300941-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BB3A300AB39
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 02:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B875130B508;
	Mon, 22 Jun 2026 02:19:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D704243964
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 02:19:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782094794; cv=none; b=QkR+rEPQ9cmV7GPi1N0zsLMIhYu38Z4JYFrU28bQJCSba0ICmF7E7eLCw0QQw0aZNWtm6ccpkxABz1bqeJP5wl0oLdVmdBhp9kVbQD0Q8U5eD8Cw03mSkWy29O/z4BAwlgVKD5bf6V48n0zrAV+VUHHx3QSu4V77WfO1L1LvvB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782094794; c=relaxed/simple;
	bh=RNKVa59Qn4Eyw+QDmSFP8k4Ho5HLCcH8s6ogTgazp08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7vOSOxbNTwGV9lgr6mcPOnjkh5YHm8GBktJxk7ojMDzzp7IW1LQBwsUUr8m+kk59EXvJdpFDlB+esscBNc4uYv5gfz++qqmnFZbsANwScbd5nsrpSIWPwaRRTzs4qBRGKTL5BlVrv+661gCrQVbz8iP1f02878LZYpCmeBxkj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NICeIIvu; arc=none smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8453bcf7276so2061909b3a.2
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 19:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782094793; x=1782699593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=29xapzBjyR6XHNY57KVovLYepGDk91b9qO2OwIQ4sGc=;
        b=NICeIIvue0maX7m2jZOsRW4XfTf/D3yhNKYKNZ/pr9gb1NMNMPz53EjC1Ia7/99xls
         wdMP7OBPh4IWxCBwbu76If5a0DbnUsDaFf/c2QZzp6W5SW+PylBcE66SygO8E6dSpt9p
         mCkuq2w1PWMwIwKEe/df4lh4iRSR8OOKbtCF6Zk8cH4bM7eGVhzdNOcR+nJ+ieQOny3M
         GzyVg4eT8dbflmdC2mlbDksv3e4aafDzpcuTQdV7TI+EaOL++1N0hzTFuM/QoEWJoSkC
         EhaX53yCMU8yoMK24HYi5x9wajHllMivalKnO3OChAJJ/I4Vt+DRy1t41u2BqngLEOyu
         jfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782094793; x=1782699593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29xapzBjyR6XHNY57KVovLYepGDk91b9qO2OwIQ4sGc=;
        b=NgHnn4qtco8TO+U9SoOID2ZsNWwTTlNCL0/5nR5/y/1F3LnBuv3D58wke96rx7JfQr
         IomZDf4hR3FQHfZbOUEu64/UzdUObMlhOQczjNP4k0IwTtbHaWPsogDMNwmRsC7cK5tv
         Bqz5HFtvhfOKi8Zm7HuxanXdqVVc+U5nt8QntRXRIL+wS0D28vBSkzXybhwM8KY7+B5I
         ZVcxX/T3/Oh9vDwt3+Gg0wqUzcKyujTFtvL5SlH9+/+s52O0XMXGVHjI2wZI+4xen9I9
         jQWfeGHJwbiTd3s9KmycIr/iZaicvzTQ6QrMMG09rlIWxvfn5Ptby+Yv8ZlfvJzxwAyq
         plUw==
X-Gm-Message-State: AOJu0Yw0gPVGZKJ1COyiaR+SpxwuVi2wo2PPWC/hLs3x7GTb4IpkgB+s
	tl5UTyZp4D62IX2qEvYbAFf9p77BDi0of5RKRGPleopDhVB3RmWD0whCURGTPg==
X-Gm-Gg: AfdE7clcGrGg6wZIRB3uD9i2jYlQPEousnoH4O23tCj1jFr5JgJWNaUxuFRzNHp1OQZ
	8JQptQN8sEc9DOeVBg2jrXCZaj4hL6WVW56ZlxPI+tgNTedIkx5pgPaYmCCCQuUMPUAqPBUXmIG
	RBQsN6BJiSIV2W6sgdx+A4+5Sg5Qigww8UeEXmQ7fIdAi4lwKRPCV/nuN60GOA7Qg6YX3ImM7MO
	WE3utkKorJSqQmn44XrEdi1TkXTng1RZu83VZCaybIMasKbNLXfdWUQjYLc3sew6kcwYQVexlzh
	OzkWlGRuKwv0eYgUXYW15EXZnrIpMO7Tdf1NHPtm/kf/G/wdI+gUxAc7wFWdLwx/wkZVt4yyqty
	5gdiLzl9Z4rQA8L9shNeIgY3ukobDXTAazf8qQeFL7UCfAZ1Fdi4nWdaRxSqFLmQREbiblX34Mj
	01J2Jy9q0M3WcqssvcTURywljl5mqXT1eNYz797zpi3hOLM8663I8FSQ/PCHvrIDlUZ6Zlk6lxH
	4sQB9CabC5z36HByrthUY7kvq+afaytgO0=
X-Received: by 2002:a05:6a00:f89:b0:842:5a8d:302c with SMTP id d2e1a72fcca58-845508efe8amr13815339b3a.38.1782094792815;
        Sun, 21 Jun 2026 19:19:52 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:af13:6f5d:b398:9987])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564da30b5sm6158194b3a.25.2026.06.21.19.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 19:19:52 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sandeep Gopalpet <Sandeep.Kumar@freescale.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] gianfar: fix memory leak in gfar_parse_group error paths
Date: Sun, 21 Jun 2026 19:19:34 -0700
Message-ID: <20260622021934.1415455-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:claudiu.manoil@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Sandeep.Kumar@freescale.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300941-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 1E3856AC0AC

In gfar_parse_group, if any allocation in the irqinfo[] loop fails,
or if of_iomap fails, or if the IRQ parsing fails, the already-
allocated irqinfo[] entries and mapped regs are not freed.  The
caller's free_gfar_dev cannot clean them up because priv->num_grps
is only incremented after a successful return.

Fix by adding an err_out label that frees all successfully allocated
irqinfo entries and unmaps regs if mapped.  Track the number of
allocated entries with 'allocated' and propagate the correct error
code.

Fixes: 46ceb60ca80fa ("gianfar: Add Multiple group Support")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 3271de5844f84..12ebb207be0be 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -502,17 +502,19 @@ static int gfar_parse_group(struct device_node *np,
 			    struct gfar_private *priv, const char *model)
 {
 	struct gfar_priv_grp *grp = &priv->gfargrp[priv->num_grps];
-	int i;
+	int err = -ENOMEM;
+	int i, allocated = 0;
 
 	for (i = 0; i < GFAR_NUM_IRQS; i++) {
 		grp->irqinfo[i] = kzalloc_obj(struct gfar_irqinfo);
 		if (!grp->irqinfo[i])
-			return -ENOMEM;
+			goto err_out;
+		allocated++;
 	}
 
 	grp->regs = of_iomap(np, 0);
 	if (!grp->regs)
-		return -ENOMEM;
+		goto err_out;
 
 	gfar_irq(grp, TX)->irq = irq_of_parse_and_map(np, 0);
 
@@ -522,8 +524,10 @@ static int gfar_parse_group(struct device_node *np,
 		gfar_irq(grp, ER)->irq = irq_of_parse_and_map(np, 2);
 		if (!gfar_irq(grp, TX)->irq ||
 		    !gfar_irq(grp, RX)->irq ||
-		    !gfar_irq(grp, ER)->irq)
-			return -EINVAL;
+		    !gfar_irq(grp, ER)->irq) {
+			err = -EINVAL;
+			goto err_out;
+		}
 	}
 
 	grp->priv = priv;
@@ -567,6 +571,13 @@ static int gfar_parse_group(struct device_node *np,
 	priv->num_grps++;
 
 	return 0;
+
+err_out:
+	for (i = 0; i < allocated; i++)
+		kfree(grp->irqinfo[i]);
+	if (grp->regs)
+		iounmap(grp->regs);
+	return err;
 }
 
 /* Reads the controller's registers to determine what interface
-- 
2.54.0


