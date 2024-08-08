Return-Path: <netdev+bounces-116765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB1494B9FA
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4EC1C21C85
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A775B18A6C7;
	Thu,  8 Aug 2024 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oky6FGF7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D421E189F55;
	Thu,  8 Aug 2024 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723110471; cv=none; b=b8G9Cj2VBxN3F66ASR42EdbU/7vMyVFwTj+FvOnTEqlg51y78tqufLGTCJLgtYLyEx3ImkklUFNFMCZ2GvB/OY7OSLYmFCvDb38ogK2TJryf0q3symLmncfymZp8VPhtPCTAxMt5Vd7JDoWn+jjI3S4BDVhYKd3F4sspaXn8pYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723110471; c=relaxed/simple;
	bh=Gs9fUy9yW4JBBaoGjjHZoItLt9sngv838Y8XASfxmd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cHU/r9Nmu49w0tmtzl0hhWbA6ykycjb/urHXBReVCk1jCWMBLmk9JmBXYJoji7NxniwW4ZB+7XOg79smtDlPcPjdxRe//bhB3ilhUf7McraEFMLrGMiieFeLX3oTg4kp1V2OQXq1Br4eIxycmQcym/dlJ3tmspBklcC7Ysp5auY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oky6FGF7; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so959316a12.3;
        Thu, 08 Aug 2024 02:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723110468; x=1723715268; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ni7itzdtEe2jfSTKg6OGqBXNu0xuqssIDqqXlEDVBsA=;
        b=Oky6FGF7Oy2ZV7kOj6TIseMQILtoTmgrOY8Awdqh495MMvOdBuBLX0qwKJ6+XDkEPz
         uCKxCW0rnJuHINIuA3nvMI+IhjEbHZ6CsQThQg3Td/npSHxL6bINWPnJOyrJxIebHknl
         7sZQWPMXD/d7+t0GtgDAPZdKo9xdnqwVa46jzIkX2eDhc8umPJQQU+2cDL1sae/7FdOq
         RpgnGn7l14srdNV3580C5y2ByzP1SZamPf+mn/hpHnXZOAC1l8Iterd//UQq1VDglEsy
         7QTibXCfHhTzxW9vOmq76YAF6CebIh2zCjwnnPEj8rymVAq+29lto+meVaTuCFZBsl1T
         CK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723110468; x=1723715268;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ni7itzdtEe2jfSTKg6OGqBXNu0xuqssIDqqXlEDVBsA=;
        b=HhmCfhLNnRUihtPNH3OwK5goqJolIsicoKgs9IU+LcXmi0nNA8bgWYw9VWB9CCv2gr
         H6R/ECGyRzxRAWcrh1S2QhO+giyCVQ/KEn9zrb0TpZbD+Ch1JkZKfWZWQ421/MZEY9bH
         CAyTbxJs1UIVYRYEtiHhzC0ehWr5VNm10U4c76xdfweL1FUO3su/lcp/ZPtJRioxxYdP
         xshJikVT8ZlndltLM1ctLlbbWMMylIynaFcuThSaTFWhril6D4PkRvEV0HqCnznut45C
         SJvQoqfLyzucNT25SUvtjKpXhV8Cdzsfb7b6tLuwSbRGGsrYR8c5iODurQNOaUM5ZvQY
         kRdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0uG85jCL+HwnEcmbqPLjdJINdGn+wQDWTiH4mIsSWS/XCjS3oaHuswIqe6325JM12W4RWdTe9ki6OeVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRECqWhZYkWcT662z5n5PhbVJV2JRUKLSuAUSfxDq7u57F7DGK
	PcLsskIZTS0rXwmcKiIQxRBKEWq01fjqLJKV70RosjKR5ap6pg/m
X-Google-Smtp-Source: AGHT+IFOH/uTQt4mXnndo+NuXuB3+J1bgP8cYIXZruZYsMexbnS0X9sS59QSrIJ+nUMzim820CEFSQ==
X-Received: by 2002:a05:6402:5cd:b0:5b9:e0cf:61af with SMTP id 4fb4d7f45d1cf-5bbb235134fmr813295a12.35.1723110467802;
        Thu, 08 Aug 2024 02:47:47 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c41916sm459647a12.41.2024.08.08.02.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 02:47:47 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 08 Aug 2024 11:47:33 +0200
Subject: [PATCH PARTIAL RESEND 2/2] net: mvpp2: use
 device_for_each_child_node() to access device child nodes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-mvpp2_child_nodes-v1-2-19f854dd669d@gmail.com>
References: <20240808-mvpp2_child_nodes-v1-0-19f854dd669d@gmail.com>
In-Reply-To: <20240808-mvpp2_child_nodes-v1-0-19f854dd669d@gmail.com>
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723110464; l=2385;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=Gs9fUy9yW4JBBaoGjjHZoItLt9sngv838Y8XASfxmd0=;
 b=4gdzIl8AEAQVToxG0OFr48rbFgqiCoGD4u4FVsKA/YbjatVrVgPkaAa+L/PVpmL1ORtjNGONx
 QTIKZpnDM3pAGMxwNUviC26amZwwUr0pp/n6RxTyliON74PJeQb3US3
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The iterated nodes are direct children of the device node, and the
`device_for_each_child_node()` macro accounts for child node
availability.

`fwnode_for_each_available_child_node()` is meant to access the child
nodes of an fwnode, and therefore not direct child nodes of the device
node.

The child nodes within mvpp2_probe are not accessed outside the loops,
and the scoped version of the macro can be used to automatically
decrement the refcount on early exits.

Use `device_for_each_child_node()` and its scoped variant to indicate
device's direct child nodes.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 0b5b2425de12..216cc7b860d6 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -7417,8 +7417,6 @@ static int mvpp2_get_sram(struct platform_device *pdev,
 
 static int mvpp2_probe(struct platform_device *pdev)
 {
-	struct fwnode_handle *fwnode = pdev->dev.fwnode;
-	struct fwnode_handle *port_fwnode;
 	struct mvpp2 *priv;
 	struct resource *res;
 	void __iomem *base;
@@ -7591,7 +7589,7 @@ static int mvpp2_probe(struct platform_device *pdev)
 	}
 
 	/* Map DTS-active ports. Should be done before FIFO mvpp2_init */
-	fwnode_for_each_available_child_node(fwnode, port_fwnode) {
+	device_for_each_child_node_scoped(&pdev->dev, port_fwnode) {
 		if (!fwnode_property_read_u32(port_fwnode, "port-id", &i))
 			priv->port_map |= BIT(i);
 	}
@@ -7614,7 +7612,7 @@ static int mvpp2_probe(struct platform_device *pdev)
 		goto err_axi_clk;
 
 	/* Initialize ports */
-	fwnode_for_each_available_child_node(fwnode, port_fwnode) {
+	device_for_each_child_node_scoped(&pdev->dev, port_fwnode) {
 		err = mvpp2_port_probe(pdev, port_fwnode, priv);
 		if (err < 0)
 			goto err_port_probe;
@@ -7653,8 +7651,6 @@ static int mvpp2_probe(struct platform_device *pdev)
 	return 0;
 
 err_port_probe:
-	fwnode_handle_put(port_fwnode);
-
 	for (i = 0; i < priv->port_count; i++)
 		mvpp2_port_remove(priv->port_list[i]);
 err_axi_clk:

-- 
2.43.0


