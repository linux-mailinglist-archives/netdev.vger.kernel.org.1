Return-Path: <netdev+bounces-281160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLjHGM8c7mkpqwAAu9opvQ
	(envelope-from <netdev+bounces-281160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 16:10:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A79ED46A415
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 16:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 199C8300461F
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 14:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF1F364929;
	Sun, 26 Apr 2026 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6YsqON7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623163644CF
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777212618; cv=none; b=bldBI7P06Oo3WpokCtmN5vTZXkZU65HBjlqC7Eovp6PG9Lz2V+TGryzTqxRLR3wLhPJvyA2vPREubIjPTFhK8Ch1RXwiBkwO5tkocfLI9ZjMl1evFy5JFXScXZEqEtyklhre0f8vbFcHZNhDJHBSO6X/n+wRlg1E2T648Okosx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777212618; c=relaxed/simple;
	bh=pZATHnnsi/PcoNlN/zQOIDomcBhLXK/ASAe01WsB91U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I8ivsSy502yXFGizyZDPfazur8VVPfYnwRRclpsJjT1o1MQzXGeujMKtGLP1Dotz9DfH8Kfh4GZoc4g2S1+t9Q5PeXcNJWqWaT51pn80RgIfVlUqFPyZJDEoddODAkI4b4ckWD/DSd6bddL/NEeGja/lTDmZxVdKoiXnGI3WJDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6YsqON7; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c7971d0d97dso5598387a12.1
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777212617; x=1777817417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RaThGd+v2TGPi1+fMlzT08aS25ssAeSOk78kcucU7cM=;
        b=B6YsqON7BFyPBFv8ZJaSJD20S6Vip1/HQnLENR+tlqLz5vt0pS1lVVLjrMpPTpAve7
         e+JP72uDamzLObo+FtZKz81jYvbUPSa2v3IuDvK6KxGmTApu3x707GSg654cQIAu9zLl
         NXBZWA/mljUeqUNql2CagZWqgOLj9z9i23QDj1cyJ+msfxyMSKlaNPXuMn1oEUk1K+H0
         QSj5a+dNZX672KBpR/nr32k7yY1npP5fOQl3A2cFcVua7i/MoIuMB2lQzZbUCm8amc5k
         7H3IJhyyFP4Ifzonh29lfx3sLLuoPC1qnW+5H1+e9ycw+k6crqFZW33cawugDrHWQWHo
         WijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777212617; x=1777817417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaThGd+v2TGPi1+fMlzT08aS25ssAeSOk78kcucU7cM=;
        b=k2XL7i56cPY4feu1MsgrDRXp75MUK82w5OrMjQkc4NELVDWIB+kf6AA7lQn81zShsr
         NwSoDJOAGY5Z+3fR7NpK+mY58rDbQ+UhIrRT6hpViEvRFP1BB010Wij16WilXgNhEVnT
         GvzFrCBtQIK+e0XO8jxSkuhUHl6eLycu5wmnwiUAF4QzZBbp38A2NsqbjUp4QqTkULRn
         wlwrkbj5dzwLs02iTzjl5wTUgelaCqO2BA/FdjFgQDRcAbZaTG3FAJYy0ZFLTgzrWYhv
         cqwLWyIwW2+85OL7FxkiEDcSAgva9rlNWGqNsRx7ww21ae8h4ebLFdhOND8CfunzsPK5
         194g==
X-Gm-Message-State: AOJu0YzFVV3bhYRbC1Rojsm3PRnM6bp/vN5R0TuTVUM3edUewvJz7TVl
	QJKneStIrhHe95FqK5Urtx7lRe5pIDhk7tfSed8bJRZIPQyL83Xv5/Q=
X-Gm-Gg: AeBDietFcqsWoU2Eq7XZq8k7YHrGe3W1kW5Z+Gb9ozplguXSbO2e/ymOEkqWZOj39z5
	ov5HYVtPrpaKAoskXkchXK8y3E8w43EoOZnWgaJSGM6p99JVz4cmZ1r3QVbK5+hNvpPjk+4kboR
	LJ0Ckehkqt1KKC6Hn1WUi8ABwe83v7eXfTbBSJjy/5OLGkQx4Gimycrg4WQQOaZaFy7IEpn/rA7
	KC+xvz42WjkTb5aut5feSr+CqJkCL2R0mC2IZVdVaD4Im5iug7D+QV/QW8k5xWa06VBMPOOwnWV
	2Yjfc7/yybmblU1MYYZu14woItgQNKH3wzoEu/NA1k3eXBI4MwTQG2vDUYatMoealXiw0w8tZae
	uS6kpt3DUkoPJu0IV4BrM35Som4q9Fq68tG7kH/iFkmf+aDFaITevCbCaSp2Zr/+Fm9MeQB94an
	hDWjfQlhIvsJBzGtN2cw4TcLbbnlkM5guLHaHe6BBKiMWeD7XFaTCzEhaP7vqEU9EKI9btOK4AE
	GxVT9yeWIuAqWZObBYvowkEriJbEZugRw6ubQguaiMdzwE=
X-Received: by 2002:a05:6a21:32a8:b0:39b:ba95:b127 with SMTP id adf61e73a8af0-3a3250ce2e9mr16902037637.4.1777212616718;
        Sun, 26 Apr 2026 07:10:16 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f0811fsm21900810a12.0.2026.04.26.07.10.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Apr 2026 07:10:16 -0700 (PDT)
From: "=?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?=" <mhun512@gmail.com>
X-Google-Original-From: =?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?= <pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
To: Hartley Sweeten <hsweeten@visionengravers.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ijae Kim <ae878000@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>
Subject: [PATCH DRAFT] net: cirrus: ep93xx: fix probe error unwind
Date: Sun, 26 Apr 2026 23:10:06 +0900
Message-ID: <20260426141010.19049-1-pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A79ED46A415
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-281160-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[visionengravers.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]

From: Myeonghun Pak <mhun512@gmail.com>

ep93xx_eth_probe() uses ep93xx_eth_remove() as common error unwind
after setting driver data. When register_netdev() fails, this calls
unregister_netdev() for a net_device that was never registered. The
net core treats that as a driver bug and emits WARN_ON(1).

The shared remove path also fails to unmap the register mapping on
earlier allocation and resource-reservation failures, because
ep->base_addr is only assigned after request_mem_region() succeeds.

Unwind probe failures directly and publish driver data only after the
netdev is registered. This keeps .remove() for successful probes only,
releases the memory region on late failures, frees the net_device, and
unmaps the registers.

Fixes: 1d22e05df818 ("[PATCH] Cirrus Logic ep93xx ethernet driver")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
diff --git a/drivers/net/ethernet/cirrus/ep93xx_eth.c b/drivers/net/ethernet/cirrus/ep93xx_eth.c
index a4972457ed..4e98b76ec7 100644
--- a/drivers/net/ethernet/cirrus/ep93xx_eth.c
+++ b/drivers/net/ethernet/cirrus/ep93xx_eth.c
@@ -800,7 +800,7 @@ static int ep93xx_eth_probe(struct platform_device *pdev)
 	dev = alloc_etherdev(sizeof(struct ep93xx_priv));
 	if (dev == NULL) {
 		err = -ENOMEM;
-		goto err_out;
+		goto err_iounmap;
 	}
 
 	memcpy_fromio(addr, base_addr + 0x50, ETH_ALEN);
@@ -814,14 +814,12 @@ static int ep93xx_eth_probe(struct platform_device *pdev)
 	SET_NETDEV_DEV(dev, &pdev->dev);
 	netif_napi_add(dev, &ep->napi, ep93xx_poll);
 
-	platform_set_drvdata(pdev, dev);
-
 	ep->res = request_mem_region(mem->start, resource_size(mem),
 				     dev_name(&pdev->dev));
 	if (ep->res == NULL) {
 		dev_err(&pdev->dev, "Could not reserve memory region\n");
 		err = -ENOMEM;
-		goto err_out;
+		goto err_free_netdev;
 	}
 
 	ep->base_addr = base_addr;
@@ -841,16 +839,22 @@ static int ep93xx_eth_probe(struct platform_device *pdev)
 	err = register_netdev(dev);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to register netdev\n");
-		goto err_out;
+		goto err_release_mem;
 	}
 
+	platform_set_drvdata(pdev, dev);
+
 	printk(KERN_INFO "%s: ep93xx on-chip ethernet, IRQ %d, %pM\n",
 			dev->name, ep->irq, dev->dev_addr);
 
 	return 0;
 
-err_out:
-	ep93xx_eth_remove(pdev);
+err_release_mem:
+	release_mem_region(mem->start, resource_size(mem));
+err_free_netdev:
+	free_netdev(dev);
+err_iounmap:
+	iounmap(base_addr);
 	return err;
 }
 

