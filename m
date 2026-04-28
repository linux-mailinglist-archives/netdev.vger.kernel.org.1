Return-Path: <netdev+bounces-282107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOVAFz818WltegEAu9opvQ
	(envelope-from <netdev+bounces-282107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:31:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A6C48C9EA
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2115830131AF
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 22:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8336037FF4B;
	Tue, 28 Apr 2026 22:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZNjp57y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3957D37B030
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 22:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415479; cv=none; b=AkxNV8I7xg2hyZnohjHS9qPEfgnrC1Iv4nA5GgkA0r8OkEEkkJ8UI2BnhQA8kaw8B7ielKt0SJPNAIuwJZgYBybSnlyF2/T2UF0N1JU/8IrC8IWLZG13IqjYQXeEfSghsub+7lyvrUHVm0slI0dortrAuqhQJU96JZIr20Yv1Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415479; c=relaxed/simple;
	bh=Afdookp9zil2VtHeQbBPiJ6JrqKRSbgNe+scVywFeJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uvfrHmf9fLOd2InPqXH+3JbiJSC/JCGuw0cyh/dd+qu5REsqnIEf0daRMgIlrJWPIbmy5EfvpabFaFt/gJ74e/kTnR3tDbqk1oHkiZ4NkhbLoe5BNOC1Y+fD9t9yYt1hmuY/QcZhN0ftP630gnAFEkVlqdYSG2BIubBDUh9uAyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rZNjp57y; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8acb3dab8dfso74717136d6.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777415477; x=1778020277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YY6FTulJBSPvlfGVmGfJuioC6VTkKeDBKn6rrD6zw1I=;
        b=rZNjp57yscktkgFUy8xNu/U7g1meWA8gFU8DzFfaVrNEh/UFhCeaCV8AeP/8O4DT2A
         HK61ZAij8FWUGANsd2LGZNd/sOzH5dGmlP+QxkwDzFCsvkzGpj3pUTrckAZis4ZBLVD/
         e7jjwctama7txqzIU/eKIwr+xGSxR7VDbdGVap25H64Gnh/v1p0OndP0yjp3B7EwN+8g
         WTf6+U7vWD65Er5ps3pBzA8aLcgqr+FZdpTl+abemAjcoMAASNSKjk9Fjyi/R1yYR8Ii
         bSbI5IJU1eXz9T3p8JjYf65jSNTK/l5KCjZ0Aw/hXjVs3WpSiugkzQyabNEbd7IE7a4o
         zeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777415477; x=1778020277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YY6FTulJBSPvlfGVmGfJuioC6VTkKeDBKn6rrD6zw1I=;
        b=kI8dL1JjXddBImGRC6Rh/yXWKDDWcI1tvQ4vj9ggGuRjYVnmlFYgV1dKWCQZodpcH4
         3g0pVD8j/1JBueMnHdxz+f0aqgFFmZDyJdv3vWEP5FmUYvgM3h/YvWgtaxRsj3/GQYd8
         m+M0hf5v/EKOXyajeAKdi+0/xPLLaxegH96wdC+WV08ZXLyxDAAo5ZpxomD6Uvs4E1oM
         rNGGMLAXOLMP+cecRpMOvFTzvZ0KN92irmxNs/OKSsB4F3F2h/LznTMIQ/QWlgszJLfu
         S4fOBdIEfvhFP2y352L6zVqIU7GZbjLIdgsP9+LkOUQ6hwwyt5FedNv0+FffTsnHkFx5
         CGbA==
X-Gm-Message-State: AOJu0Yz0J2Yi71rYAg1WJcI8ye2MPytIifVbiXziZFb1qkK+jvI0vXUy
	nGApO/G2ztoyto2iGPSr8gbriUBHLQVZ46cPlh3cSr3rofzLC7PKcLY7FFc0Ag==
X-Gm-Gg: AeBDievbz6hMKgpILreAjMJOghINT2ByP85TJqCQJG26BNflqQt7WBJFD01lH5MFN29
	7XKcWoTfkdaznH8j2fI1Va5+mDDpNG7POnJuwaob38UK3IGtseR7jxJEbUVqy1lI9AsO1e5P3uC
	Dd+l8uBAJ8MowRhunCC8NgGP2V8k/RzIJd3N77/o4bKawz3aytQFJYLheVMSN/hfatb4/ZAcW0L
	uxpVSkxtZI7uw+5idx83E4//ILX9AqXfq1CkjJSxuhKZTCkK087rMx/3yrQGxHR4OV6l0i0HcpF
	PSCHzF71T+sjA9NpC24eMovAqnflXiCiXy6jp2wAVG+rN6LsqOB8QL4MXNV3mmiEydORmfW3d8V
	Da4Rm3gNCpwvLeC2adRkVP1sJ4BUtQxYh/z+4JbcAtJZQw/wpmRhqz2S8KrHvRoN5MjG6+rEdbu
	USSy6Gm+ua5JtH/2nr1/jB4w0NLSb09KpMGG2HrueN+ffyUoKoAwmw7LaZSaRFETdiF71M/Lj5G
	aWxq3rJafOC9fGTy6xSTVmJHnAl2fu9qNpm
X-Received: by 2002:a05:6214:8119:b0:89f:97cc:b8d2 with SMTP id 6a1803df08f44-8b3edd30efcmr21727386d6.17.1777415476801;
        Tue, 28 Apr 2026 15:31:16 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3ef81f156sm2874916d6.37.2026.04.28.15.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:31:16 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: gianfar: use alloc_ethdev_mqs
Date: Tue, 28 Apr 2026 15:30:58 -0700
Message-ID: <20260428223058.113013-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 57A6C48C9EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282107-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From looking at git history, mqs was introduced after mq and after this
code was written. Having said that, mqs can be used as there is already
an RX queue variable in place. Not only that, mqs already sets the
num_xx_queues members. No need to open code this.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 3271de5844f8..7b47c7c49c08 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -669,7 +669,7 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 		return -EINVAL;
 	}
 
-	*pdev = alloc_etherdev_mq(sizeof(*priv), num_tx_qs);
+	*pdev = alloc_etherdev_mqs(sizeof(*priv), num_tx_qs, num_rx_qs);
 	dev = *pdev;
 	if (NULL == dev)
 		return -ENOMEM;
@@ -679,10 +679,6 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 
 	priv->mode = mode;
 
-	priv->num_tx_queues = num_tx_qs;
-	netif_set_real_num_rx_queues(dev, num_rx_qs);
-	priv->num_rx_queues = num_rx_qs;
-
 	err = gfar_alloc_tx_queues(priv);
 	if (err)
 		goto tx_alloc_failed;
-- 
2.54.0


