Return-Path: <netdev+bounces-141668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279F59BBF26
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 22:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E166528236B
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 21:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7230A1F76A7;
	Mon,  4 Nov 2024 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPyam8BE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2D81F7543;
	Mon,  4 Nov 2024 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754094; cv=none; b=NJsct78oPNfgNPLVDYE+wMMO5uDhzc7ByTQ7zQwNmhZ7GihLF/YceHoZjI6M1gkcHfvTkSNIwuowPnRzM5GWhd/+hd1EwRkggUGZ3Pop4DDtLqfwBxeiv7tseaD+IKZ2cSgpRuLGN9JPSS4Edbya92QAmwobvmWbOsTEqcErFSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754094; c=relaxed/simple;
	bh=xHTXt0VJADoQNRT5MVeOmPWjvQOJQeJgXqLgKIr11Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NakaNT6TIXnAIclwQoeseTyvAHBd1FL5czuVihYKCtMh3Gn4tmUua22s5pnxClj+WSHmzFQ5bGEyJFQw9aEWw6g+EotRjiNrRBIUMzXxYZhqOWmSOJDRjYn0CpZepiTR7XLyxUNi95fb23cNjkKPEowHjb3Qc0Qo/ZswPMbWDhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPyam8BE; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e5a62031aso3799973b3a.1;
        Mon, 04 Nov 2024 13:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730754092; x=1731358892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ip9/C2ewikw3KgUEbRX7k49RSpJtURcwU9L3ZheHKjQ=;
        b=HPyam8BEyuqY9vIPJYB1c0f9cxO009zOalO7+LWO/PydPPEN0E+9NZeqWq64sYqErA
         VybHMVYtwScIBUv1wvou6kq3nESPuOkY3OltZWLTULlRbkK9HLBqKqEvtEJb0jC5H/vW
         b4kJxfmUJrC+34gUFhBmLQssTWEMzo0Qg+t6GTiXjpkVFMJeL2R4rhZTXkekLmK056S1
         uStiWXfjz66mARhKi8x2nIMkCAPYeoy44Hqgl8IxqtC+AzmFZuDlIOTqHZZlTzXzB34f
         tsSLMgECjIeSUY4/XAEYNoN4BpsV8YgyjVC35XckwiotIuvcL1Cpiz/DY4j1FaCcsvgd
         T+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730754092; x=1731358892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ip9/C2ewikw3KgUEbRX7k49RSpJtURcwU9L3ZheHKjQ=;
        b=Qf9g4TOtSAQ8e0bhrHJ8DwoOGN6T0FMkotrkrm+zSSF02UcJxOaaBkN4DgHRRE7MxW
         eOaGVvOVdHM4YHBlgBh/LM+dOb/m+PL2JUaDdhaWrjPSB+fNzPPdSV56yyoGQqcWvG7h
         9DcN8bY7JWbjxLBXVwxGqlWgoxO6IUKIheqX/xoASZII4xBhcA/WiXJpBeCxUJ5s134h
         gQmGU5QTBX3wLkmiIImKiejy2GnRExEVHeKzCk7+CQh+GErOdk6MY00VqUgNgtTahmpf
         VAScwSYMNuaRahiO+TY/i3P4BtWM/28AslECNyJZeej/n06teZ+uLXIgIFZzIuJaw3O8
         oDAg==
X-Forwarded-Encrypted: i=1; AJvYcCX+ZboGyUDkXfMCtgAqwErmxtK69fo62osqbAUlrUiDSOgj15A6aZIgprjmLBJA9+ncxIS/b0956U/z1hE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyttoGOv/76jVjegO0NQejuUACh/y3v2qWe/xEEmIJ3SXLPp1AI
	jt6TmVsTcLXEoLgrN4dzbJ81OqmmGa1g2T52zbo+o1amOdZE0NqV3oMN2wzV
X-Google-Smtp-Source: AGHT+IEnbdG1Ii06AUcv2+s6OlAYE4thaNj7TjcIIQC8s8ZBO9ULIesDRtW5uiZzRUj/PuB2sXQt1g==
X-Received: by 2002:a05:6a00:1814:b0:71e:3b51:e850 with SMTP id d2e1a72fcca58-720c98a3d3amr19246643b3a.2.1730754091800;
        Mon, 04 Nov 2024 13:01:31 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b8971sm8307755b3a.12.2024.11.04.13.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:01:31 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	maxime.chevallier@bootlin.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/4] net: ucc_geth: use devm for kmemdup
Date: Mon,  4 Nov 2024 13:01:24 -0800
Message-ID: <20241104210127.307420-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104210127.307420-1-rosenp@gmail.com>
References: <20241104210127.307420-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoids manual frees for it. Funny enough the free in _remove should be
the last thing done.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index a7dd0a2ead86..4bf5ff5642e7 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3594,22 +3594,23 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 	if ((ucc_num < 0) || (ucc_num > 7))
 		return -ENODEV;
 
-	ug_info = kmemdup(&ugeth_primary_info, sizeof(*ug_info), GFP_KERNEL);
-	if (ug_info == NULL)
+	ug_info = devm_kmemdup(&ofdev->dev, &ugeth_primary_info,
+			       sizeof(*ug_info), GFP_KERNEL);
+	if (!ug_info)
 		return -ENOMEM;
 
 	ug_info->uf_info.ucc_num = ucc_num;
 
 	err = ucc_geth_parse_clock(np, "rx", &ug_info->uf_info.rx_clock);
 	if (err)
-		goto err_free_info;
+		return err;
 	err = ucc_geth_parse_clock(np, "tx", &ug_info->uf_info.tx_clock);
 	if (err)
-		goto err_free_info;
+		return err;
 
 	err = of_address_to_resource(np, 0, &res);
 	if (err)
-		goto err_free_info;
+		return err;
 
 	ug_info->uf_info.regs = res.start;
 	ug_info->uf_info.irq = irq_of_parse_and_map(np, 0);
@@ -3622,7 +3623,7 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 		 */
 		err = of_phy_register_fixed_link(np);
 		if (err)
-			goto err_free_info;
+			return err;
 		ug_info->phy_node = of_node_get(np);
 	}
 
@@ -3751,9 +3752,6 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 		of_phy_deregister_fixed_link(np);
 	of_node_put(ug_info->tbi_node);
 	of_node_put(ug_info->phy_node);
-err_free_info:
-	kfree(ug_info);
-
 	return err;
 }
 
@@ -3769,7 +3767,6 @@ static void ucc_geth_remove(struct platform_device* ofdev)
 		of_phy_deregister_fixed_link(np);
 	of_node_put(ugeth->ug_info->tbi_node);
 	of_node_put(ugeth->ug_info->phy_node);
-	kfree(ugeth->ug_info);
 	free_netdev(dev);
 }
 
-- 
2.47.0


