Return-Path: <netdev+bounces-116764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA6894B9F8
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E801C21D33
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4EE18A6AB;
	Thu,  8 Aug 2024 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ds9Tm3aq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0979148832;
	Thu,  8 Aug 2024 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723110470; cv=none; b=NO3cMRQO+Y8Etw1eOtqwRlGvGpb+i3CSLjcGZp0BTAs/iyShLJmtUfkbV9YwE2KB7Tfr6Rrkm/jHxtqTE7rRePKd9g+Tszu+DF1fwao+tN60DQAs2hH5OpCQFDCsIbzfnD+JpY7OvbVlDz6EBLvxNnCaLllG0/phxrPeNEvF1Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723110470; c=relaxed/simple;
	bh=TXubFA9EPG3koYRbq3Z+pWro6cSdZQFPedoTNgHKsIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aSjDw0wrM/9QLGjNstsjgFE4kR9xncXuUShheSOUQmCcv/INx4J11cgovMptieqn/tmWQjh9v325vMjQVKvd2D6X8ZRfE0+Humdb+oVx03s93dj0SBDPlQgnyGF/0Tg1ldVlbMIfC+q1MQTIIQXeada6N17LNDF/p1cWiddUNXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ds9Tm3aq; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5b7b6a30454so939949a12.2;
        Thu, 08 Aug 2024 02:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723110467; x=1723715267; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tPSBgbm3jpAmX4JgIT8jji/q0J8YfDHNM8+2dXWfMBo=;
        b=ds9Tm3aqOEH+gYbzO1snBL1Pr4WIwdWHQeH5S4l3HoHHNcywxacXytVdrI4BVEoQYp
         HGUOoGYWNWgTSpiUMd+868/+Q4YDG0Uyz5o47rER+Ln8db4gjsc74vsXRGgEuVULF5Qv
         n3cWE+Ujor8LHmO8AxfFSAOb3xXQ8Aybkd2SRt2joP/LlyldJOqiATneczlBis8No/In
         +TXuRaVKzSY+CEdyWaUUNrmHpLvOBtM8uz4x82uf3nynp5atfjypy+7eeIzZn1R9ozqW
         N1L4P6AkKAFKcBJhUFBClWFqqa0VJ/Icll8+bYLgP7Z11TE5AdZn3MmbaSbEatvFdEl2
         02zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723110467; x=1723715267;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPSBgbm3jpAmX4JgIT8jji/q0J8YfDHNM8+2dXWfMBo=;
        b=Ww5wgKWMpEXv2sOcP8aq3wrlsL7KvJknHbpYysRo3nNaPzj7QaB4boPUucPSVax/ZL
         zOxZ64wPO4BpxuibuFUei2uU5iA3cgHld/EVun8DU77S0En4NnpMXePtqDxijSb+6aaO
         2w6nY3ZKaODUqbjjdvsxXAv/R8WymRLrgE2fcxVkTCUGFcynRmaSRksXgBgxJU1w+WHI
         Ycs6g3RzUE9kB364BtG9QTXHhQ5OA3Zwx1Y7y7h8nr+8AY1gD/JNvMbr15LHhxdQZ2lW
         +BT2Mgb19r/vABNEdk1CV+v7/QBFMgDp8hPZKU3JfjKsW9wN6iEw5PtE9b33maFDgH+H
         pqYA==
X-Forwarded-Encrypted: i=1; AJvYcCU7MtKglz0SzRxsCTZmokolL1OKj5xL0kkq1iNgIsA0z9mIAk1U4XEd+BNRg/RPa8EVjX/ZRgXLaU1BbmvZBpJzGlOXCttqDVnHwX1k
X-Gm-Message-State: AOJu0Yy+Mx+ZmE47W8CUA6I2MrckaVCnKmlbqO2hhBxjHBDg0SbunVgL
	Lgai8UlOWrYpwmnflcnDSJ1MWiFuTdtq5vxS9tB0ebqhdhdP4AAV
X-Google-Smtp-Source: AGHT+IHJ9qCIWqICViUaDjMTrf3IgsfZw481zf8zrQfOdOLnwDbXLWS1jPwgLO9xzSbAqc31LXnz3g==
X-Received: by 2002:a05:6402:11ca:b0:59e:b95d:e744 with SMTP id 4fb4d7f45d1cf-5bbb2338646mr960094a12.29.1723110466760;
        Thu, 08 Aug 2024 02:47:46 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c41916sm459647a12.41.2024.08.08.02.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 02:47:46 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 08 Aug 2024 11:47:32 +0200
Subject: [PATCH PARTIAL RESEND 1/2] net: mvpp2: use port_count to remove
 ports
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-mvpp2_child_nodes-v1-1-19f854dd669d@gmail.com>
References: <20240808-mvpp2_child_nodes-v1-0-19f854dd669d@gmail.com>
In-Reply-To: <20240808-mvpp2_child_nodes-v1-0-19f854dd669d@gmail.com>
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723110464; l=2455;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=TXubFA9EPG3koYRbq3Z+pWro6cSdZQFPedoTNgHKsIQ=;
 b=2Zlje7KpP+mHRn3eS9C5Q0Y8JbUw/sP0f4j6nPz+7TDmxoOh+JwZMJeYRzOjPWz81Kul9sSkX
 mA95T5VwW0aCb4kA7Ew/76nv72BEm2iUK51IDM1Y38G7NB0VK5N3Yfp
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

As discussed in [1], there is no need to iterate over child nodes to
remove the list of ports. Instead, a loop up to `port_count` ports can
be used, and is in fact more reliable in case the child node
availability changes.

The suggested approach removes the need for the `fwnode` and
`port_fwnode` variables in mvpp2_remove() as well.

Link: https://lore.kernel.org/all/ZqdRgDkK1PzoI2Pf@shell.armlinux.org.uk/ [1]
Suggested-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 0d62a33afa80..0b5b2425de12 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -7655,12 +7655,8 @@ static int mvpp2_probe(struct platform_device *pdev)
 err_port_probe:
 	fwnode_handle_put(port_fwnode);
 
-	i = 0;
-	fwnode_for_each_available_child_node(fwnode, port_fwnode) {
-		if (priv->port_list[i])
-			mvpp2_port_remove(priv->port_list[i]);
-		i++;
-	}
+	for (i = 0; i < priv->port_count; i++)
+		mvpp2_port_remove(priv->port_list[i]);
 err_axi_clk:
 	clk_disable_unprepare(priv->axi_clk);
 err_mg_core_clk:
@@ -7677,18 +7673,13 @@ static int mvpp2_probe(struct platform_device *pdev)
 static void mvpp2_remove(struct platform_device *pdev)
 {
 	struct mvpp2 *priv = platform_get_drvdata(pdev);
-	struct fwnode_handle *fwnode = pdev->dev.fwnode;
-	int i = 0, poolnum = MVPP2_BM_POOLS_NUM;
-	struct fwnode_handle *port_fwnode;
+	int i, poolnum = MVPP2_BM_POOLS_NUM;
 
 	mvpp2_dbgfs_cleanup(priv);
 
-	fwnode_for_each_available_child_node(fwnode, port_fwnode) {
-		if (priv->port_list[i]) {
-			mutex_destroy(&priv->port_list[i]->gather_stats_lock);
-			mvpp2_port_remove(priv->port_list[i]);
-		}
-		i++;
+	for (i = 0; i < priv->port_count; i++) {
+		mutex_destroy(&priv->port_list[i]->gather_stats_lock);
+		mvpp2_port_remove(priv->port_list[i]);
 	}
 
 	destroy_workqueue(priv->stats_queue);
@@ -7711,7 +7702,7 @@ static void mvpp2_remove(struct platform_device *pdev)
 				  aggr_txq->descs_dma);
 	}
 
-	if (is_acpi_node(port_fwnode))
+	if (!dev_of_node(&pdev->dev))
 		return;
 
 	clk_disable_unprepare(priv->axi_clk);

-- 
2.43.0


