Return-Path: <netdev+bounces-210741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821D9B149FF
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 10:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABEB13A6CA0
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 08:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF4B27C152;
	Tue, 29 Jul 2025 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhdgjGPv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1482AF1C;
	Tue, 29 Jul 2025 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753777301; cv=none; b=U6jdqcFxcfrKI0ctPWVvwfHT2sANdgaZkPG49UvNfOdHHmYsxpE7HZ0GNuvN7hG6GMgdrhFGaCWsrT8LzQuXuPdF9ZzRVhnRc2YyOUhYbj24VFxHUQhtYrNOLCpIslmqPyY3lP0s9Ieq7AHLSFXcJiJxrimNTcnPXW/gamZRUIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753777301; c=relaxed/simple;
	bh=3MadP4h48DIdERsGiQK9qL9UflRCokl2zYAzYujjKO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OZ/hLSWok3ZplfuJTUP07ImfjiISRTGG2QrWbW9lz/y+cBjOlOxS1Nv+giV2toAXgoljgBVG6tAPxKkoMflyjkJn4FBsLqmbH6wOndzzS+tSRgz/5r+kZXzNOKOOr+3/8Vf8levTruzgcbV0iAjLLEcpyJUDxdCTbjoZg1c81hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhdgjGPv; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b78315ff04so1843616f8f.0;
        Tue, 29 Jul 2025 01:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753777298; x=1754382098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tT0dGPVL2JwzDZcMhwQgYP1Gkj3ongsGTyx+y3Z3CrE=;
        b=EhdgjGPvE5u6i088g2OPrnRSfuAlPv5/5qzVGzrcy9N7BqY+e51xNG3B/SUtneYc29
         Xrw8y3juyYtZ59d5iQr63WpHne4Iutj7bPWr1z1k4PgjAGrujB/YWTPO7HTh0GfjRMku
         4EkJBQPZDgmISraaSnuBwqFkqAGv0IBrdoh67/ua167E/60+GbDpEd8ETjw/9zs+SX3s
         y0HEvHkwATCfgX7YhfboCMsFJ7xpXjSdbHht4Z0n9bk6GpOrJrvyiF6bqDzz3cQyahC9
         nupl3ocHkveLKeYQWzFwxcbXy617qTVusUaHhvyy2DmemIIfxsioMXzZvoTd+RFacinF
         rfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753777298; x=1754382098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tT0dGPVL2JwzDZcMhwQgYP1Gkj3ongsGTyx+y3Z3CrE=;
        b=XIkFZE0ivHl7TERU6E/QuwDi1FhfZx0sRKc2Crxd9U6OmJ0uXzh/WodjYKJq+ixGi2
         RvcprdyLAfp7mgB54mrAcwZpTJDNbKvEHho68XQMtEfglu9J6o/sRkbjPS4PhZNY5nz0
         CDUMGda4cWaVtjI1gzRNXubZ+3uemki06zB9JDXvErVZRNZ5/BPD2qAmxpyZQFg/B8o3
         aktQCBHDV0T/9T5EAjokkrGMY+x8jimTRv/84J8QrruIrkf0rlSZGvLR/gHkFhe5n7Jn
         eJ+69ZTtXxiCUNnq+DgBbuZ3MaXTaVgoT7h0PA00FGW7MR3Dr6Fi5MWkY0Hi01/xxf4F
         GOZA==
X-Forwarded-Encrypted: i=1; AJvYcCVLrRXybHzp/Os4xHxq4cKYzBX+dCXjAgsLav6OU5jeqpofR/u4nUjZXH3Ftsx8JeiobvEUnKY5bVCJMKI=@vger.kernel.org, AJvYcCXbXrYIr5cQFBXMT1wjXaaJlaTcb5FjlfJQ4XVDGD+Q7iVQsGvxdtCn8HPxAHOmHqDc8QXOJYHw@vger.kernel.org
X-Gm-Message-State: AOJu0YwxjfMiohdofm9Qdv2PV++lTrpL6vNyeXOcoZKt2pQOjmyE2vk9
	zkAdgHLPEMVntxNkz2A46+1qTu/597v+HpyWcTmbKXUdPArpX6syrnyl
X-Gm-Gg: ASbGncsFHid0nn47tlLivm1qxk19ewC/Ey2bYKFWfU0jiIjDkbC8Rd3XZXt0SY1x8Kn
	Nw/AVfg3d6evIBsNTXjXRv2k9mAqLUsUCA4x2TvFXTFI8ijLvs5J7jAHRJtyze6xgS/WSSTWWLu
	O7ErIwpcvDGjxPLOO8cF6bL3fELw9AInScSSMRa1bdnlWg6GFPvHWcHjM+WTFJmwpgbjki3VPHK
	UMoayXR8+ce/NIGPWWyTdv/77hUt35e00neHcKVYKTQIGDjixTclTE8K4mfTYIzeHXjZeR8KSW/
	/O/KtU6mM2afjJrXbXIYRsTdBN7VmKKvMSQO/qjblbRai1fumjOWYqlFQsbWmjK0opZBl3sQkJN
	sD2vQfhUbUf7jUaGY8qHnccpwMVX86xnluHGs3Da7gHLCBuhVGWvERXvmAnqLt4rS5ih82tpWGU
	Anhw==
X-Google-Smtp-Source: AGHT+IE3SfkwZGuKiUVH9aKbgdBfmo7svBjLqSORlG/pClNgCFm7LSnPOXcJJ8FgGS2H6kv2vQVYvQ==
X-Received: by 2002:a05:6000:2411:b0:3a4:bfda:1e9 with SMTP id ffacd0b85a97d-3b77678ba22mr11791862f8f.46.1753777297639;
        Tue, 29 Jul 2025 01:21:37 -0700 (PDT)
Received: from Ansuel-XPS24 (host-80-181-255-224.pool80181.interbusiness.it. [80.181.255.224])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b778eb27f8sm11472037f8f.16.2025.07.29.01.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 01:21:36 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next RFC PATCH] net: phylink: add .pcs_link_down PCS OP
Date: Tue, 29 Jul 2025 10:21:23 +0200
Message-ID: <20250729082126.2261-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Permit for PCS driver to define specific operation to torn down the link
between the MAC and the PCS.

This might be needed for some PCS that reset counter or require special
reset to correctly work if the link needs to be restored later.

On phylink_link_down() call, the additional phylink_pcs_link_down() will
be called before .mac_link_down to torn down the link.

PCS driver will need to define .pcs_link_down to make use of this.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 8 ++++++++
 include/linux/phylink.h   | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index c7f867b361dd..6605ee3670fb 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -927,6 +927,12 @@ static void phylink_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 		pcs->ops->pcs_link_up(pcs, neg_mode, interface, speed, duplex);
 }
 
+static void phylink_pcs_link_down(struct phylink_pcs *pcs)
+{
+	if (pcs && pcs->ops->pcs_link_down)
+		pcs->ops->pcs_link_down(pcs);
+}
+
 static void phylink_pcs_disable_eee(struct phylink_pcs *pcs)
 {
 	if (pcs && pcs->ops->pcs_disable_eee)
@@ -1566,6 +1572,8 @@ static void phylink_link_down(struct phylink *pl)
 
 	phylink_deactivate_lpi(pl);
 
+	phylink_pcs_link_down(pl->pcs);
+
 	pl->mac_ops->mac_link_down(pl->config, pl->act_link_an_mode,
 				   pl->cur_interface);
 	phylink_info(pl, "Link is Down\n");
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 30659b615fca..73172c398dd6 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -484,6 +484,7 @@ struct phylink_pcs {
  * @pcs_an_restart: restart 802.3z BaseX autonegotiation.
  * @pcs_link_up: program the PCS for the resolved link configuration
  *               (where necessary).
+ * @pcs_link_down: torn down link between MAC and PCS.
  * @pcs_disable_eee: optional notification to PCS that EEE has been disabled
  *		     at the MAC.
  * @pcs_enable_eee: optional notification to PCS that EEE will be enabled at
@@ -511,6 +512,7 @@ struct phylink_pcs_ops {
 	void (*pcs_an_restart)(struct phylink_pcs *pcs);
 	void (*pcs_link_up)(struct phylink_pcs *pcs, unsigned int neg_mode,
 			    phy_interface_t interface, int speed, int duplex);
+	void (*pcs_link_down)(struct phylink_pcs *pcs);
 	void (*pcs_disable_eee)(struct phylink_pcs *pcs);
 	void (*pcs_enable_eee)(struct phylink_pcs *pcs);
 	int (*pcs_pre_init)(struct phylink_pcs *pcs);
-- 
2.50.0


