Return-Path: <netdev+bounces-247045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E64CF3BB0
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 14:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0079430C5234
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 13:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D381F5617;
	Mon,  5 Jan 2026 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTtp/+uk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE2E1DC9B5
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767618387; cv=none; b=GwCDA84ni53Zxap8QCugmnJBSv0iJGUoxlFt9KntHjlsknA4RiKNKZO+Q0B8YH+EKSTgqfHGAOCKixXe7qv7H0exw848f4EckRQw3OVnjByK/2Ui9S+5qsXySNLk3UgCaDP5tvX1ZLBgcL0No1uTlIR+u06TipxzwCCG6hdS04c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767618387; c=relaxed/simple;
	bh=xqwkrhDPX9VUQAP8pCblwBHB+XqTPJYCfg5HSZkBpvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VhtCgrhpNsz3O0T2FhIzQ/EczdTKQJwsbwhH7NUfYuZoSm4AvGol94RvSpx2dsoIxAX7An0hujwPeGzMAmGGBBMO0eSWXfsJ0nJ5XpOW12Ip6ytflznrc3qCmuEoZ3MR1STFH7jLtOcNLvWEbTix0vSincKgeJF5V90kZRgzEW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTtp/+uk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29efd139227so184665095ad.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 05:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767618385; x=1768223185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CrVouaSHTHvbzMm3C++Sc0NBpLBf0RPE14kza4yhpbA=;
        b=JTtp/+ukgceqZ1HyXOmRgDb3Wc5K5132wA6/QOwHi9qQflan6U7uJ8MeWz3WCNUOHi
         lhYpl6MNo/uv4IpP06AGIrvudtagwbCHgxuPwWxY33qSVZb7TNdKBSQEyEc3Wkym0btm
         W1T2ZBdKDDsxDtOFXXY/fB+pELzQD3ql+LStBxS3yN0dV0aU+KBAf3MhcrcN/G8hAIOp
         Mzu6dziqWMtz09dIm9WHYggOQmE1Y96tNqCGi0we2x22eAlRVLpjJJvzkKQBpEp/G4CQ
         8Ax7msJTVZ8ImX7zROi9/yYwQHEmy/KwybLiXQtJzHy7cwA5SkzhUUPxLMhYMQO+/xyF
         lFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767618385; x=1768223185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrVouaSHTHvbzMm3C++Sc0NBpLBf0RPE14kza4yhpbA=;
        b=emZvemxijM2kZhsSAYSXqOoiev0nmGNq7NyYetXSACawleYGOHpVYiL55FncmKAN/j
         7Oca/IYWE6pH2jGAoBbR47wKXNpIyOXPoe3S93Pu+iPdsNRLuoSkAZubHM/rR+A5k1vC
         u93cYhIHOqR/nKaGN8cdGsLbqMEZkgIIUqmcWU3GSwImyo/soBEpNZvM3WTPAsB++orh
         FnYLPnPMFPf0LazRfMDE8eNl0DCgc/eUsKcJRB4JH2j/sPF4AfSWS2B6Uqk9wF8r5zti
         Xw1TobRZks5wx/cjIQVGMcuWyFGvAvIfDb0vFE+pdmuNLKh9XibeXbWr2ItYaVflgPZr
         ru1Q==
X-Gm-Message-State: AOJu0YzszOjR1gwc7I6zt1YfHeICeYCIfrqgT2mTm4YzarneKPixCup/
	i0MC8OKkFn85KNoHKXQTYOnTMGVaMjmsUX52gSoyn97trUR7ouvygcKg
X-Gm-Gg: AY/fxX5Bxyey1E7XVhqLt0fiapeI+CfMDbfQUn6T3DTq+pVlPd09q+/M2Tn8X01jMQ9
	UceWOVs+TlcHoycy4TeLEdBIOzm4j/Q/ngDekjxAqhTByeJbeP6yPJWt3bw8r55JMxldxswP3vY
	S/5FCENYPfoNMaeX4jyVx1YTC9ySzVbXxYNxAR75UATS26DJsh/Vj6YQbTMLU7REKSqsNZyRgJr
	JpmVMZJtA2zpw50E/DrjCMYYhizox/5ONY3DZ1xj/AiuCfVZBvfR90OMGgtcJ5nIJeCzLEocm/P
	sJOV29B6DZEIAv1j2oF9Ob7Uw0jgMQisuxIWqXJDj4HrOudp9U0SA6dzMP8bFHfwZT+F5RbJkfS
	4Uv2frcTiIDZf/Ay8Cg3zwJBBzQh36FBGsldqN5zBcS0Ik9j7d33ICho/Txe+IUzh/07P1tlUOT
	EdqC7/mfxW
X-Google-Smtp-Source: AGHT+IGeh7uE/eLUURJ6fn209BgBHdAtqIZG3AqpUS+K3MUFQCjOsM5uBI3x6ImMFR5rdjb0qq1f2w==
X-Received: by 2002:a17:902:f78d:b0:2a0:e223:f6e6 with SMTP id d9443c01a7336-2a2f2830b0amr418839505ad.46.1767618385276;
        Mon, 05 Jan 2026 05:06:25 -0800 (PST)
Received: from mythos-cloud ([61.82.116.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d3e1sm445801785ad.76.2026.01.05.05.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 05:06:24 -0800 (PST)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>
Subject: [PATCH net-next v2] net: dlink: replace printk() with netdev_{info,dbg}() in rio_probe1()
Date: Mon,  5 Jan 2026 22:05:53 +0900
Message-ID: <20260105130552.8721-2-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace rio_probe1() printk(KERN_INFO) messages with netdev_{info,dbg}().

Keep one netdev_info() line for device identification; move the rest to
netdev_dbg() to avoid spamming the kernel log.

Log rx_timeout on a separate line since netdev_*() prefixes each
message and the multi-line formatting looks broken otherwise.

No functional change intended.

Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
---
Changelog:
v2:
- Keep one netdev_inf() line; switch the rest to netdev_dbg()
v1: https://lore.kernel.org/netdev/20260104111849.10790-2-yyyynoom@gmail.com/
---
 drivers/net/ethernet/dlink/dl2k.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 846d58c769ea..69bfb8265d57 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -279,18 +279,15 @@ rio_probe1 (struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	card_idx++;
 
-	printk (KERN_INFO "%s: %s, %pM, IRQ %d\n",
-		dev->name, np->name, dev->dev_addr, irq);
+	netdev_info(dev, "%s, %pM, IRQ %d", np->name, dev->dev_addr, irq);
 	if (tx_coalesce > 1)
-		printk(KERN_INFO "tx_coalesce:\t%d packets\n",
-				tx_coalesce);
-	if (np->coalesce)
-		printk(KERN_INFO
-		       "rx_coalesce:\t%d packets\n"
-		       "rx_timeout: \t%d ns\n",
-				np->rx_coalesce, np->rx_timeout*640);
+		netdev_dbg(dev, "tx_coalesce:\t%d packets", tx_coalesce);
+	if (np->coalesce) {
+		netdev_dbg(dev, "rx_coalesce:\t%d packets", np->rx_coalesce);
+		netdev_dbg(dev, "rx_timeout: \t%d ns", np->rx_timeout * 640);
+	}
 	if (np->vlan)
-		printk(KERN_INFO "vlan(id):\t%d\n", np->vlan);
+		netdev_dbg(dev, "vlan(id):\t%d", np->vlan);
 	return 0;
 
 err_out_unmap_rx:
-- 
2.52.0


