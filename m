Return-Path: <netdev+bounces-301809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ow1cKN98PGqHoggAu9opvQ
	(envelope-from <netdev+bounces-301809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 02:57:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D346C20B8
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 02:57:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=TMKQPufu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301809-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301809-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C741303D2D5
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 00:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47EF3655F4;
	Thu, 25 Jun 2026 00:56:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29F478C9C;
	Thu, 25 Jun 2026 00:56:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782349019; cv=none; b=D9d3KqcNSkphpyyy/+lmv6rw5aA4BuUHJ38IuY5lNGgak+yVlObZgRnc+hhcYq3GISRaWiBQjhPiHtT8zRko9OEHMEpZjVih/U5iDdGZRYE2L18nAPyXjOpj2YCMrU9Xce4iuiJuHCg+dRBy0nL2qWqoof9ay1fZHhJPiwYmH8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782349019; c=relaxed/simple;
	bh=7K02DprJ9tJPpR8aibqdbZ8sAslcgrATq2u3Pz3XlHM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DMMUBwR3wfRXuAt4q/Gy0HshIHk+qGrmmUELcH6czckgWN18AA8qPZ6v5vxxQUgmi5ZkllwqXyrDKedDnhVZUvDumYGMKLHOQykmYl4QPYPGsiCau27UHdA8sJTU/jaem8+qNW8gcJufB6EBTxwFHmd+7ruznoOL3QctEFQSmgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TMKQPufu; arc=none smtp.client-ip=117.135.210.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=rV
	5vzQ5XbKtyVgCIUG+QczXlxPo8maUhhfbSTCuAo60=; b=TMKQPufu+BnFaJx8v6
	Njq9cHfUDzwbmr/CMb4whZFVnih1puSmmpGebjbaczNmDMP28qzcZCtxEz1QWUPV
	AuxDAG0w6DsbTyOizgAPU5qt2ywedRfSNeIc+vWqAj5fSaKdgtsmykivUCcSVIqu
	Obc8FY5Y4J5LWcMYA/JtS2kT8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnFs6gfDxq87JJFw--.13468S2;
	Thu, 25 Jun 2026 08:56:01 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: madalin.bucur@nxp.com,
	sean.anderson@linux.dev,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH net-next] fsl/fman: make enable() return void
Date: Thu, 25 Jun 2026 08:56:00 +0800
Message-Id: <20260625005600.3400023-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnFs6gfDxq87JJFw--.13468S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw48Gry8GF48XFy7Zry7ZFb_yoW8GrWfpF
	WrCryUCF45Ja4Ykr97JF4vyryYya1xtryv9F97K39YvwnIvr1jgFs7JrW8Zr4aqFZ7GF13
	trWIyFW7GFs8AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR_pnPUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7QHwX2o8fKGUTQAA3R
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301809-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:madalin.bucur@nxp.com,m:sean.anderson@linux.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:haoxiang_li2024@163.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[haoxiang_li2024@163.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haoxiang_li2024@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0D346C20B8

The enable() helper always returns 0 and has no failure path.
Make it return void and update the only caller accordingly.

Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/net/ethernet/freescale/fman/fman.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index 013273a2de32..aa35373413d4 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -924,7 +924,7 @@ static void hwp_init(struct fman_hwp_regs __iomem *hwp_rg)
 	iowrite32be(HWP_RPIMAC_PEN, &hwp_rg->fmprrpimac);
 }
 
-static int enable(struct fman *fman, struct fman_cfg *cfg)
+static void enable(struct fman *fman, struct fman_cfg *cfg)
 {
 	u32 cfg_reg = 0;
 
@@ -941,8 +941,6 @@ static int enable(struct fman *fman, struct fman_cfg *cfg)
 	iowrite32be(BMI_INIT_START, &fman->bmi_regs->fmbm_init);
 	iowrite32be(cfg_reg | QMI_CFG_ENQ_EN | QMI_CFG_DEQ_EN,
 		    &fman->qmi_regs->fmqm_gc);
-
-	return 0;
 }
 
 static int set_exception(struct fman *fman,
@@ -1998,9 +1996,7 @@ static int fman_init(struct fman *fman)
 	if (!fman->keygen)
 		return -EINVAL;
 
-	err = enable(fman, cfg);
-	if (err != 0)
-		return err;
+	enable(fman, cfg);
 
 	enable_time_stamp(fman);
 
-- 
2.25.1


