Return-Path: <netdev+bounces-121676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F33695DFF1
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 22:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B24BFB21694
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 20:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BA1745F4;
	Sat, 24 Aug 2024 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QF+tEEhc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD1A4DA13;
	Sat, 24 Aug 2024 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724529773; cv=none; b=ThulHKg5wYbcr5RBD9LKEXqUpKn/2ipxZjMA7BuuiTax4gbbdoKTI8PgV3/N4vn5NGON6qdly7vrSYr2ngctOkS3qVJ0BMei+dgf7d23EHTrw8MkeBcO9OoXCxUL9cAt3Rd+j+7+CAwtF0mKncMNxbhinUzdzulyYXQkcQnNdDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724529773; c=relaxed/simple;
	bh=Yb/aknxzkcGFnXnDyaQeJAkhv5g+rQ9iebHa9Pr/TvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=epNT6KD4JO3R3Z4vjipFuJmTEVStDIa4NSgtkr8wnqnvGBEqI/Ex6Fniq0UF1X95/TSdSx9hkDRsZm7nwiVBP8x/THsqU6x0W5W8HLjUo3XDLieqxYQO5BlhtcDdYmmZOvHL5U3zoMcFR8MD7o456ppfULITIrV2Ji4CbuaCjGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QF+tEEhc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2020ac89cabso28074285ad.1;
        Sat, 24 Aug 2024 13:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724529772; x=1725134572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wWaSNIYv0/Qncj1N0nTJpdHfaRe5YgQOIToIzG2hUto=;
        b=QF+tEEhcc9rD6CazX8nnmCJfd+gqd2aJfGD5foWeIHUMkKIdiwW9LoS+vyEHOfKjn0
         Fa94JigMWL9yzmaWzjt8aCP57o8EIdVXIogwlqWV4DzsuWlID3j9a4I19F7Y1IOPT3xw
         p+x6sbul/QyHWokGypQSzBGy2x8sLXL+w2FLklCmmf0YuJz+Gn9a5RoibL3CG15jr0fs
         dOG4Vg9BYZjC7p9MDJYajKvKrGnVDullYmUfpOm6wXtBrOKBnoHDjgGl5UlVecgvftYx
         bQKikQwRUk0UPqupVo66Zk5r3laxApC1FN4ojqT1Is/xjSmpSTUQcVEy1MPaqi13wJrG
         k17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724529772; x=1725134572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWaSNIYv0/Qncj1N0nTJpdHfaRe5YgQOIToIzG2hUto=;
        b=VUrstOoO4XwBU+ykyLuMxLbmEOvo0jbIGYnHpoTxqOnk5pSDA5wknkZkvYQNWYx8Yr
         5SVDD5ubPBBevxSk9IXEvVnbjCRodcpQY8+4XEb7kasRRD5/i1ziH2/rbmba15PkYoeN
         Ga/FF2/FYRfeeRDroxbAPfNKjWmAOqWkXErmAcTSEqbkYDvCFYd4AYZVbbH4PL1527jp
         5JSp3W9ua6lep1XGYMHochRC3zzmJDPRMvKiegIajzQ3zckEYDCfnWNDpuC/OcqYCTG7
         UH/ZRFodt8+ct7l1EOPbLbN2IcvrrCNb19libyX1AqO+e/RBn4YEY5ioB0hvPtASkS4f
         Tfvw==
X-Forwarded-Encrypted: i=1; AJvYcCXPdgkHI8s+3niKHHBw/zjL1gaMLlHdIOgJ2jfY08cz23Qh7erSL3/eSD4Bh7Lovpdr8yKpvo84lAttATs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuerYrN86oq96XGNrGab9aI20GekHlV1tdpjX5qNaxEYTXslgr
	ErDPvzSLeAlRLveivl3F8sMFF6MM16g16fv47UEcLogtkt0lAGgl/H3jFUUW
X-Google-Smtp-Source: AGHT+IFp0nyVMbNrRs7eXAdwgv6nXc1XniAli0ua1DZo6JgdeQKE7Be5TeoI91MyfLvLxHvwQR40pA==
X-Received: by 2002:a05:6a20:9c93:b0:1c8:fdc7:8813 with SMTP id adf61e73a8af0-1cc89dbac1bmr6966305637.23.1724529771496;
        Sat, 24 Aug 2024 13:02:51 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385567912sm45633665ad.33.2024.08.24.13.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 13:02:51 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: [PATCH net-next] net: ag71xx: support probe defferal for getting MAC address
Date: Sat, 24 Aug 2024 13:02:37 -0700
Message-ID: <20240824200249.137209-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, of_get_ethdev_address() return is checked for any return error
code which means that trying to get the MAC from NVMEM cells that is backed
by MTD will fail if it was not probed before ag71xx.

So, lets check the return error code for EPROBE_DEFER and defer the ag71xx
probe in that case until the underlying NVMEM device is live.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index d81aa0ccd572..5ef76f3d3f1a 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1897,6 +1897,8 @@ static int ag71xx_probe(struct platform_device *pdev)
 	ag->stop_desc->next = (u32)ag->stop_desc_dma;
 
 	err = of_get_ethdev_address(np, ndev);
+	if (err == -EPROBE_DEFER)
+		return err;
 	if (err) {
 		netif_err(ag, probe, ndev, "invalid MAC address, using random address\n");
 		eth_hw_addr_random(ndev);
-- 
2.46.0


