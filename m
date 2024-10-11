Return-Path: <netdev+bounces-134690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B071399AD36
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 21:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1FDA1C20A44
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 19:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B9A1E766C;
	Fri, 11 Oct 2024 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UB4PgeA4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5171E5738;
	Fri, 11 Oct 2024 19:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676596; cv=none; b=Eqmr14sNnRYbLiImIuM0QZ+DugZwCyQ3iezzGhDg8sFU/VuiGHAg08dqevNfVx//QIQLqXcK+Pn7NPN5+1SNw3BVn2tEDDrx7m/jgi9rFPQOT2BqN+0b0OkI09YXK3jJMQ/tTaWE6sowi1sgQ0Tua8mQuU0Kl6ZGN0vcj0WNbWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676596; c=relaxed/simple;
	bh=ZFLwNIwVctzCdMWUmYqjFWKxhWyGXaQSvfsB3UlKlms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8d39DAb1szu1q+GALR7hHPzm6WRPjU/sdH2fW59mCTXZru0hW3e95q1NoS5CdHbTKd7uEwIRrOPu+A6+P8UgLIFe7L0Cy4UxyU78YnWMzuFvlZ3jEpv03HF62dcKpSVYDSOQC1rNVSSPHXaSwUoHjIN0LRL9NuUM4B43AoT7Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UB4PgeA4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e427e29c7so514799b3a.3;
        Fri, 11 Oct 2024 12:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728676594; x=1729281394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2WAmEDR6gKCLxTUFCfK9dcDmpMYacx8M4fUpcsQvz4=;
        b=UB4PgeA4jSgZJ4+xcKszMpUybEiPToMd6lBejRmVfNUiwaRA5T8x9GoRiXbB0AZlpp
         YI5FJJdaBIp3WmQzrmWzOr65xVRJ+hqWywvwGGNx8DD1XvuTfqXoB6GwuaKK0wXPD03l
         LRz/THSWRTY+RXAERcVbxabAOaA8QnJmayqHTxXuMbXp2BboYaFrEakKXEuR4MdkSTUp
         YQhCM/azALN8WZe6Jd55JAJ5QfbNKMP92pTnIJBL1V+tS6/PP6hwJSc1cIDuRJSsfbyq
         gf4Bf3y5AcgUBZ+QfV9ydZklJ1zvdPNObHeQ3XiIb21v7sNkPfvhil7IiuRy8ZqvVTPO
         YX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728676594; x=1729281394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2WAmEDR6gKCLxTUFCfK9dcDmpMYacx8M4fUpcsQvz4=;
        b=MUATfSmJvsYpCJtkSmqeNXq7HM1viaUsw2baJdXWnCgZIx0S7FqRRVERoE/f0k6zHy
         Jy8P2uVpLgT7onF1BQyual04T4kiOu57898MEmC86+YH6WIN8a37/eW51BqVC1tkQUDk
         zPuN6wK1uqqnDFyJmyM0iAKSeiiRVLMNhv3ZPmLHHul7WrsEnuHjFSj/ad4Z0Au8Y+zh
         QPrRExUKzzUSSxWPcCL8t+t36oFpLXgY/Sr/IG2DJbTzvS2b3uzRm4wiW5Q0zLKZ16aC
         qs5q/ym5BE23cqLm4t1/rrwVzTSvTPaIsmymJkYeWSCAKGGzRn1l8e9lPL6QL21jF20v
         58qA==
X-Forwarded-Encrypted: i=1; AJvYcCUW1gR+T5EaVq+uWQPmU2i3ZHGCBsO1oAZ7+W3VF/skBY0+zkPakaJ00QnJtlpv1wcQq+jxG9iTiYwFArQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygKLav0oSo8bAyvuAOxPrbz2sNLwsagLVnoEnu9v2mhLKwkZxf
	kjPHIIokq56hektuyxvJEkgsIKjGYJlx4f9hpic75Xni3jdsoCWjSFKuwvYy
X-Google-Smtp-Source: AGHT+IGKtuXO8HpH3Q29vbeuin2SpoxWZ4wtdof68DM7RwFmhSHYfQUt48LOGAT07h7L3J9hI4SBjw==
X-Received: by 2002:a05:6a20:c88d:b0:1d7:11af:6a with SMTP id adf61e73a8af0-1d8c9690587mr896919637.37.1728676594083;
        Fri, 11 Oct 2024 12:56:34 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea44907ea9sm2846025a12.40.2024.10.11.12.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:56:33 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shannon Nelson <shannon.nelson@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Breno Leitao <leitao@debian.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv6 net-next 6/7] net: ibm: emac: generate random MAC if not found
Date: Fri, 11 Oct 2024 12:56:21 -0700
Message-ID: <20241011195622.6349-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241011195622.6349-1-rosenp@gmail.com>
References: <20241011195622.6349-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On this Cisco MX60W, u-boot sets the local-mac-address property.
Unfortunately by default, the MAC is wrong and is actually located on a
UBI partition. Which means nvmem needs to be used to grab it.

In the case where that fails, EMAC fails to initialize instead of
generating a random MAC as many other drivers do.

Match behavior with other drivers to have a working ethernet interface.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index b9ccaae61c48..faa483790b29 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -2937,9 +2937,12 @@ static int emac_init_config(struct emac_instance *dev)
 
 	/* Read MAC-address */
 	err = of_get_ethdev_address(np, dev->ndev);
-	if (err)
-		return dev_err_probe(&dev->ofdev->dev, err,
-				     "Can't get valid [local-]mac-address from OF !\n");
+	if (err == -EPROBE_DEFER)
+		return err;
+	if (err) {
+		dev_warn(&dev->ofdev->dev, "Can't get valid mac-address. Generating random.");
+		eth_hw_addr_random(dev->ndev);
+	}
 
 	/* IAHT and GAHT filter parameterization */
 	if (emac_has_feature(dev, EMAC_FTR_EMAC4SYNC)) {
-- 
2.47.0


