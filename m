Return-Path: <netdev+bounces-261641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI1gOdPmoGnDnwQAu9opvQ
	(envelope-from <netdev+bounces-261641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:35:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AADD1B1403
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91A7C30B825C
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 00:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6305425B311;
	Fri, 27 Feb 2026 00:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fenMoisd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A111B425C
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 00:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772152464; cv=none; b=Il3Yzwl51zR4olHEUWbqo0xNu5ZIlBrdQEkJjps2M9QLnc6UmbRpCDyFLOtEBoaNOtC5OTAxlPn6vWVftG74ItyXkEB+qpybuxowuVU+a0wev5DmjqOjYWa11+yVMzXIgDWqhmdySbFTBL93oA9Y8mAEb1h30vxI/er5FsR78bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772152464; c=relaxed/simple;
	bh=Tl1DUbzj2D6+ov5SZhXxdWxDOWwdxk9yqTv2bgl3vdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkMO/I7U9iCQyR1w29a3YwXDIAtwsiaXLL8gIXqcCzmnuB/SUkvTfCz+3qTpSitC7XJc16M2GmJXlh1oRAT4mYODnlx1zYDaBTcjAZaHqBa8yxoGfK/p2XGRwlmTgUcjp7OEj9l4tve+N3vqZ3bw/VxWPxEhYSqbnGPBOqe0VTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fenMoisd; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82746ed8cb1so498188b3a.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 16:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772152462; x=1772757262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzRkRbcVXy8YX35iFm3cdXSJ7hIcR1jCcHzwRyHNf2E=;
        b=fenMoisd+uOeJegkhXGT4DH5P0IF99bHLL0FQUA7oqbRQhyrkPNyS9fBSzTA3ePGJQ
         XEaJvekvxQgcDzlLU896+rR4zcpVrh5iglLCnpYZko16pOdDW/hE4wbNZrRrHLBD4+u1
         vtZe2xNyVpY4lRcbzxDgkoyklAiplb9V0w2LTOSLBUHZlczKx/PuPvRARxLZ7Ei8+zyZ
         CR4bgVYOPR1iqMRh+PSAPs0K+8WcNytqOh6itwKXC7gIco2q5tdlM4bc3Qg30eWKwqTe
         BVcXHmSPJ6+RtJ1oqBo0+WwipLfFyXiF6g3CrwJBW8Z4n7usVnnvxIeEedkz8k+lfdG9
         Xu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772152462; x=1772757262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HzRkRbcVXy8YX35iFm3cdXSJ7hIcR1jCcHzwRyHNf2E=;
        b=oN+d631AiVNDPXCwHfvksccSlFNW9ibMV3Vt7iV3w+WP+JxGyndbDvaOok8HXdy0CD
         t9KrddlIJW2owVbKxRD+KE4dZY1PKS6YYdDyUGCnU0HwFS4iYwqdqqmzyZ8nXKhLupt+
         M+f8fqXbmzshbwYaxh1LWRvgCbgAsIp1Tl61xuhjcDhmzUt2KIh7EpRv9s4t2GWsHF5P
         vSO9vpC0e8txzvVboyaUR0Zgn+jcoGm8hzsATHteETMY31u4dApyy03TEjVxKJNVKwUa
         uH5u4+tnJesCh3loErxPf75mzS7USdtqzXa8EKv7oB+2h6be9wNOun1N1rU6wfQRvozC
         8aoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPx5UhY7irJ/kZedwQ5hqBWqBXLceboQJnf+rORrDCHoZO+oeFdZxxp4Wwi+qCxo80wJnyK+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw28LsxTR07VaRdb608d2Nv743oEAYJggIplNmnQkmTJzStxM1/
	NWg9Nqi2duH85TKOC9Q5OQ+jfa4cgnT5zXll0KdzOcKVXtq7jnwUFOHN
X-Gm-Gg: ATEYQzzPCzVWpDye3E6V4JFSN38qGNPgcHuxYlMQKTFeOO4NaDwVM9AEnER2aOUAfZ9
	ehH6iWK5R2W2gBU9st2OAkfPIkJh+C888wflkzKwK3NIDJ8il1r9433Un7GkM50jkfoHRBOr01c
	LaGh+wVOzGUYtIVhnbJGi62jpBGSEVgAfTPxy7rychFbm1HLn8GZtxgqhsab7Ihlk850IYoVuo+
	A4ra9YF+PzhgGHGaJPsNYUZhY9aUJDUi5jSHjqMnUiCbw1darn/CaEc82gVlrWnaRsmX1zp2p8/
	46bcrsyd90l+XO6u5o5nWNZgoKUbjOIxta7UqkdJ6oHhU3gMVmXL5A7NKYC0J2JKm4r3E/l23Xh
	1YmW/wSEdBb6V+amDf/5YoCEe5c3bwaDAp7JROtAiCek0QeJFbEKyp2Yyn1nPtNFmQzT82UJlv9
	OX20DEh++XL00Vf2m6P2GDdQ==
X-Received: by 2002:a05:6a00:9290:b0:827:3310:fb18 with SMTP id d2e1a72fcca58-8274da13ecamr832145b3a.51.1772152462511;
        Thu, 26 Feb 2026 16:34:22 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d4e10csm3631262b3a.1.2026.02.26.16.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 16:34:22 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Joel Stanley <joel@jms.id.au>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Longbin Li <looong.bin@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v3 2/2] net: ethernet: litex: use device pointer to simplify code.
Date: Fri, 27 Feb 2026 08:33:48 +0800
Message-ID: <20260227003351.752934-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227003351.752934-1-inochiama@gmail.com>
References: <20260227003351.752934-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,antmicro.com,gmail.com,jms.id.au];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,lunn.ch:server fail];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261641-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lunn.ch];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4AADD1B1403
X-Rspamd-Action: no action

As there is already a device pointer in the probe function, replace
all "&pdev->dev" pattern with this predefined device pointer.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/litex/litex_liteeth.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/litex/litex_liteeth.c b/drivers/net/ethernet/litex/litex_liteeth.c
index 67ad1058c2ab..108d0a0db206 100644
--- a/drivers/net/ethernet/litex/litex_liteeth.c
+++ b/drivers/net/ethernet/litex/litex_liteeth.c
@@ -238,7 +238,7 @@ static int liteeth_probe(struct platform_device *pdev)
 	struct liteeth *priv;
 	int irq, err;

-	netdev = devm_alloc_etherdev(&pdev->dev, sizeof(*priv));
+	netdev = devm_alloc_etherdev(dev, sizeof(*priv));
 	if (!netdev)
 		return -ENOMEM;

@@ -247,9 +247,9 @@ static int liteeth_probe(struct platform_device *pdev)

 	priv = netdev_priv(netdev);
 	priv->netdev = netdev;
-	priv->dev = &pdev->dev;
+	priv->dev = dev;

-	netdev->tstats = devm_netdev_alloc_pcpu_stats(&pdev->dev,
+	netdev->tstats = devm_netdev_alloc_pcpu_stats(dev,
 						      struct pcpu_sw_netstats);
 	if (!netdev->tstats)
 		return -ENOMEM;
@@ -277,7 +277,7 @@ static int liteeth_probe(struct platform_device *pdev)
 	priv->tx_base = buf_base + priv->num_rx_slots * priv->slot_size;
 	priv->tx_slot = 0;

-	err = of_get_ethdev_address(pdev->dev.of_node, netdev);
+	err = of_get_ethdev_address(dev->of_node, netdev);
 	if (err)
 		eth_hw_addr_random(netdev);

@@ -285,7 +285,7 @@ static int liteeth_probe(struct platform_device *pdev)

 	err = devm_register_netdev(dev, netdev);
 	if (err) {
-		dev_err(&pdev->dev, "Failed to register netdev %d\n", err);
+		dev_err(dev, "Failed to register netdev %d\n", err);
 		return err;
 	}

--
2.53.0


