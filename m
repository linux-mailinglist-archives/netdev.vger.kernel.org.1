Return-Path: <netdev+bounces-281195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAl4BqWE7ml1uwAAu9opvQ
	(envelope-from <netdev+bounces-281195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 23:33:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B1146B3F3
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 23:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 987FD300B103
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 21:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA4F2FBE1F;
	Sun, 26 Apr 2026 21:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfDH3olQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A6D4315F
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777239201; cv=none; b=KM6YdRWxon04LWVT6bcAqahRRBCJInoWvFJoyErxHWU7LKD579XR8YTrb0z3TJzfKZhKq9SUqjhW4MLscU6dXFlUu80LwORbahwDQceEZWrHPQbkIs5jltNKeZ3Uq4dKtV/y5TxmzLb6+mg0/L1wLhDAO83YoQqIFWtTQH3XpGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777239201; c=relaxed/simple;
	bh=fhO6yFmLqlnWt1ANWbPIEM6tBQGfY4tMH6NF9WdaNJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DU4OaWpz5MFq7PJ1pAi1jh1DmRyc47E4jb+y+o8dSWqKhtaCeWbjgfNCJViMU5iYcpEqsBwLo7Gt3wA5switLiljRqDMxEpTYl6etf8V+iO1NVgWkHK5leeR2Kyw0YeNJRYOp3D7SsqFPcCN8xWBaC1CZV6YROavo+tefBu04Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfDH3olQ; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-651c7ddf514so8350391d50.1
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 14:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777239199; x=1777843999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=riLfd2X778N1hCyuOcb+oo3Ssiio1BD6MiO0jYwDdBM=;
        b=GfDH3olQl7CLDou4xnBm4v7P+1syXKQJd/KQH07heaSOLaM3th+PL7JCeLafrtQ+lp
         kN64Ms84wyiP9KegQfy4dNY8guQRro8AePbv4AMFkjPhOuU7ehwmuEVYqa1NgE3kqCBO
         QgYRHZ3agROWUQYL2tgpgcb3s8sYk8teeehfFe+YPsmpCAGwtxkcADCqYplMjKwUvZYR
         WUEodEjilSyg6j+teS0rR0elv/w7jvc348Rzf43ivw/3+TO+RPGxluWZQ4LXIEs6c9Ur
         KPloD1kVT/0Pml1TiUNP7jK8fuvF70DOqDJ3Ad5OMkAuEu4vKBLqEuNp/AXa52r65rxi
         lGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777239199; x=1777843999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riLfd2X778N1hCyuOcb+oo3Ssiio1BD6MiO0jYwDdBM=;
        b=KEZZwn6KNDe6J/djzrC4bc+k17gH9HbitghSxjEClv3Fwxw8qrJlbD8XzSPJEEtM7x
         JH77jEPVhGJb5NRji/1ucu/GFAeDqoF4ig8jW/XYU6wz0GC+xpkLE9FTR7CYL2l4ptRm
         81muXtkVZ7HbCbOd/LXZnSGIUWsnBxKtpn3hb/s+pklEXlzCiNx320R+JIBaTZbPbWIV
         JLwVKSD+io9itGdJEJL+iZHzMory3Pz0AeHHsDlx+EZFIGYhLiPJI3V1DttrLm6XGe8Z
         zSzXxB3wPJGlVCoXoKt/pm21E+A1T3UvPZ7qQHaYgVe+/fNNXxpv4g6avTz+HxVQUrl9
         xITw==
X-Gm-Message-State: AOJu0YyIWHmSxITtcafYiGVMDrhb5IpeTh0klhI10YZxZO266R/2SQng
	AIhw0LX1HEMl+8Gj6LCZL8+gpKPdxFGkXlWcJ51IhTu8Omev+IKqfuCDnepxwiC2nOoy8wZD
X-Gm-Gg: AeBDievT71tJ7c7Bse4MZ1Af/agA7bHRqSs+0V3oDsr6Evh+FKdDnsBZw0M+CPkJ1PE
	X2Z5qg64PMOsyK6gbCGyXsgjS8WtvHRrGr0Ug7A/10NyI3L7Z8E9X3WRTXx/oDOtdmQTqwe8EIm
	0m0ARiQuAY0s9633u2IT0xtI5aZPbw018lqGJh+RPc8L2nfdtSqh7rUNkQ6+7N/EFmSqq53RrsB
	khDmMs2QSsbSZ7LySVu+sI7VUo5EkE6bSMrPaY6ZQQixhUCydceTwgNGtomeZAJxHlP4kbXkBZW
	/QR5Q7fYeHbFBcg3SyDOlFSCm2tcIrftO3yzwHx35O0zoRj/vOGOlygW+z+UVszEZLAKIYj/yhC
	nbDm1wr/2ocdyhikAWBcpooEzV3Uv4fEyGzFQhCR5Joh5jgePpDC1NqhqSIBPVd9XAXvUIVubvk
	La9Y4ZFf581FZbSJdtPncybXqIKhIamlCHL/VUhsN/cgqPMQF2XlII8B5ormkA03ARCXDWa887D
	w==
X-Received: by 2002:a05:690e:dc8:b0:651:8ba3:8785 with SMTP id 956f58d0204a3-65310b2023dmr34507162d50.60.1777239199435;
        Sun, 26 Apr 2026 14:33:19 -0700 (PDT)
Received: from localhost ([2600:1700:3420:b5d0::d])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-654439d1cb0sm7362633d50.9.2026.04.26.14.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:33:19 -0700 (PDT)
From: kernelcoredev <sonionwhat@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kernelcoredev <sonionwhat@gmail.com>
Subject: [PATCH] net: nixge: fix skb leak and missing bail on DMA mapping error
Date: Sun, 26 Apr 2026 17:33:16 -0400
Message-ID: <20260426213316.6164-1-sonionwhat@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 57B1146B3F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281195-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[sonionwhat@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

When dma_mapping_error() fires during RX buffer refill in nixge_recv(),
the skb allocated by netdev_alloc_skb_ip_align() is never freed, and
execution continues writing a corrupt physical address into the hardware
descriptor ring.

Fix by freeing the skb with dev_kfree_skb() and returning early.

Fixes: 492caffa8a1a ("net: ethernet: nixge: Add support for National Instruments XGE netdev")

Signed-off-by: kernelcoredev <sonionwhat@gmail.com>
---
 drivers/net/ethernet/ni/nixge.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 230d5ff99..b64e2f355 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -645,8 +645,9 @@ static int nixge_recv(struct net_device *ndev, int budget)
 					  NIXGE_MAX_JUMBO_FRAME_SIZE,
 					  DMA_FROM_DEVICE);
 		if (dma_mapping_error(ndev->dev.parent, cur_phys)) {
-			/* FIXME: bail out and clean up */
-			netdev_err(ndev, "Failed to map ...\n");
+			netdev_err(ndev, "Failed to map RX buffer\n");
+			dev_kfree_skb(new_skb);
+			return packets;
 		}
 		nixge_hw_dma_bd_set_phys(cur_p, cur_phys);
 		cur_p->cntrl = NIXGE_MAX_JUMBO_FRAME_SIZE;
-- 
2.53.0


