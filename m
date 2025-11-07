Return-Path: <netdev+bounces-236807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EB1C40495
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 15:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57B104F0009
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 14:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1812F39D6;
	Fri,  7 Nov 2025 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="JsJOYrVi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1453527C842
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525190; cv=none; b=czOiSM7kiXEywRIuwUDoD4tSeJ0XlIij8yCJ1+zWyLKUk3mEanLTY2N/y+PXttZ0k27C93iL1ayWwYDNw2sppiQBqnItqVVcyk7DamMVI3GdhLW5WAQoB4H5mbdvill1Am6LlNO4wRoEEXe4kjlQwJO/5rSU/m9PC3INclFh8qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525190; c=relaxed/simple;
	bh=G+GK50091GF8zGY4pW7Yj4+0UiXOAijvF2+COuJTEIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gch8uHZszUK0Rej/UHLxnj5gsHW7QwUCC01rb9wZb1CpkWswhpi40iGHk8h7aqylihEHAN8+PXbsfckTh1azgX7ZK8iQC/XRHzfBf2gOdwCI94yFMoaO4Gdl7n2eEZVSWWtM2Mx7Z25erbIR802m39LL020NllTmR4xhLV48OTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=JsJOYrVi; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso1406573a12.0
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 06:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1762525186; x=1763129986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RndfiI2tvXOM+1ZP6efdxoHZT1tlHUVs/LDHnVUxmno=;
        b=JsJOYrVi+O5hlOYCxiKYE0j/AAhfw1oLixuQpyuILl2e8DeGA0g2Id25fkO65IzILH
         +ysf4Ib84x42WBiztXhRe3TBdp2nuInRxHXu/zQIFOZ4LxGv5esfljUIvz0r/BsoMFtH
         tSgWareDOPEjesV/9TqEEGSBHXSOstQEKCKwvq2XDTm0mBHtmmiIwApPxrP8e+nLVtGE
         mZo+3Wi04c0l9Txt0sXBYArl1ROfGnI9hZStc2Ln6md2gx+znXm/qBWKGAXBsHtQqY2l
         51XYHMvP8kHtRk7uo6oNikqFKKOpLTASu/lVht5LA06zdFENdqctNGm69xR5yAvy7stj
         xARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525186; x=1763129986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RndfiI2tvXOM+1ZP6efdxoHZT1tlHUVs/LDHnVUxmno=;
        b=enZ7SoBEa/b7O9tAFza7sN/thsUOxub4GDAV7FyrWXajhdS4eqs7yTqOlmXhS76jsr
         Qnd5t46FPYjm9yccqpRAK7o0iFmuv30sb98JaDgD5hd3HpKLe1w8tjhY5JyACo0UIIHd
         r4JH/MB3HYB038t7SUCRujSa2xkrGjZa4gD1aHlRUKfnDpNhVS0CtZ/SgOcj2MiaH79T
         Y8TPi+BCMhQFo0aYcyNvwfQnlxh34bIQx9tXA5atsr4Pl+iQLUBtoyxKKD3j6wyw4VIy
         73huJqbpJwMoLf9j6cdjprAP2ex04bB72uYjMtKd9e3A8qazBVS4bqqVxFxZDHZfjKrA
         2sUw==
X-Forwarded-Encrypted: i=1; AJvYcCUOzmaGj2WYXPsuM4y3f824qpE6EHIimEl0dKYo4Y6rra0Yb6/AW5NU4ENAAeI8ot37Jy6zO4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAIDTju96qpxkdFusz2FDxeFcKDk0gcaYao2039I76W4Yuy417
	yPMm3bpakKe0QIHRN+WusmspXNQEGZyZtUkSYQo3ztlxeeL/SwwTnjQEtUR/93B2xwI=
X-Gm-Gg: ASbGncuY2aO1zpcoqNoSKZikLNqqjwe20AXGSfBkWpwupdQVhgl7yT8zssNYS9c8Oiw
	AIu3JDWJXeq/YMEjdsBtdnRouY6qkU2GEfJ04XN0Exei8C/ZexhcPD7YiviiDctHDF4JKLnD+UP
	72Jmf7a5tLZKZrxMN8PvMdGMN93tF/sthU6y3ydIr+GjWhaMian8Y2t6Hi4Bp188QNWdsoKgXJR
	aDTpcVJepoX0WB1MPdp4B9hdB85L2Lg6Lk3MhuHw7rvGwpoB6hWcu9gP+85L9H/2gpE2y3Pw8CO
	HEPjTRURkY7yEJ5OjW9UMV1tQEmfA9Zbh7p5RMjuQpS4jPCa4anu7K5ZguJtiT564hqyuX8OTGl
	74ZbnKwaXLIcjj3lmmBEeSRw0P6VsVwGRg+KK3x+UWNiQylg0bXM/sBpf3+g5XcULQIUYJ3wAc+
	VWsef1++i4q7q9Th7m8G32DhslsCVsN8EPgQcn3g==
X-Google-Smtp-Source: AGHT+IHvcVjtU3i+l/XfslQjy66bL0j3tv+P0XVI6VzvvCI0MjbHHb2f1vtJQa8ltGMFapgBfUjvYw==
X-Received: by 2002:a05:6402:21cb:b0:640:7f9c:e90c with SMTP id 4fb4d7f45d1cf-6413f06de7emr3189084a12.27.1762525186212;
        Fri, 07 Nov 2025 06:19:46 -0800 (PST)
Received: from fedora (cpe-94-253-164-190.zg.cable.xnet.hr. [94.253.164.190])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6411f7139bdsm4245121a12.4.2025.11.07.06.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:19:45 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net-next] net: sparx5/lan969x: populate netdev of_node
Date: Fri,  7 Nov 2025 15:18:59 +0100
Message-ID: <20251107141936.1085679-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Populate of_node for the port netdevs, to make the individual ports
of_nodes available in sysfs.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
index 1d34af78166a..284596f1da04 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
@@ -300,7 +300,11 @@ int sparx5_register_netdevs(struct sparx5 *sparx5)
 
 	for (portno = 0; portno < sparx5->data->consts->n_ports; portno++)
 		if (sparx5->ports[portno]) {
-			err = register_netdev(sparx5->ports[portno]->ndev);
+			struct net_device *port_ndev = sparx5->ports[portno]->ndev;
+
+			port_ndev->dev.of_node = sparx5->ports[portno]->of_node;
+
+			err = register_netdev(port_ndev);
 			if (err) {
 				dev_err(sparx5->dev,
 					"port: %02u: netdev registration failed\n",
-- 
2.51.1


