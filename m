Return-Path: <netdev+bounces-248806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4978CD0EE58
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 13:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 967243007D91
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 12:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5873E33C19E;
	Sun, 11 Jan 2026 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvQR+HyS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C45514F70
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768135305; cv=none; b=UXRQHoVOwPwtlzDDo2E+W0VVD0fe8v3v9+Y6FuobwLd4Eivw07oZa1z86yOzZ/gz+6Z3m60nbQNaAq5oJsYus1hBUtVzcr3XK3OJ51/UFfMLORTIq2wf6PfaKNHXPOQ3gpKPzpsOhH48U2EUbQ0cIlHO5V+nxHe4M7FIL5mwi+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768135305; c=relaxed/simple;
	bh=yfORz574U/QdIY8zj986fSTrqwSzgTLkdI+7BLEd3Tw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ociJNXc2QeD7WNsOgsWdvKk1V4PA/IeWj1INa3acAe96ffHgehm+PmNCsrK9uEninpp4CLognEhrujrwcMLpyeV9LG1PLMwzNZ0aw/+Sty0doM6hwc79jMvFzp3bRBjyM7gp3X0Mb3vdw04ly/T0TUwQyb4Bj2uRp/h5V4nt3CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvQR+HyS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47774d3536dso38131625e9.0
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 04:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768135302; x=1768740102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UmzAhmHenjrYT+JoOzv/QCUdsbgbHQ35PpsPjgj4X/E=;
        b=SvQR+HySACwgoaApMFd2e2QTHuXDZQegClMba/WP5Csa6aVFsJe/pgKzCArp5avHoB
         hGVt7EUIzpFgU23SZzAfB5GQZyZk3PBnYg24ryGGCKdBe+QzWZfv7jhPbNt73+D5Q+4y
         NYFVlYRBncNwvipOOuQKxuU+TRjEx/sVsfXvs52GLkrNmzhT1uFj0g+5skOmbiJq/qzX
         LhfK969EQxDyUJAo2QR9PbkC6oJrZQ/jelr/xv7oj1UdDRv7Bw7i54vPbnx2dDxziVgf
         Yx7q+SB2x51qS5rXxWKAB+NNC4i9uze+BlxA56PZLTNUSlIOzntDEvC6wzL4Fri1WOby
         W7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768135302; x=1768740102;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmzAhmHenjrYT+JoOzv/QCUdsbgbHQ35PpsPjgj4X/E=;
        b=mGGUuXxriQ+T+kLFT1pnbvXOWjLZ1k6kjcwMpLUJRYq+eJIpewWNBwFVmNTBeH+JL9
         ckXhcrdHf13f15u+cXmxdHD+5Nfii6ux1LZfGLcJzv9va+AkH347/Y0APgKOAmRsb+YG
         WSLWuYTlfbhs1RmmB52pvO6qIuwYAFdX5hQ34B9W9rUc/vrN5AbeMQEz2eSJ1q0W9T+F
         xmByp9FdnppU/SbnsMeq7gXn+JikbxSULl1wKrBne0NKWZsM2A233bgyU7X6U43OEaVa
         r8N3PnMgHMzuBvYFyveU/mFU3YgtUKi68OhH+gMLnTot+9krrk3r6+0z1gSiDgofqTie
         CBww==
X-Gm-Message-State: AOJu0Yw+UMyV3ZLNLMJq6FsPLFhiB/67h0DGPS35hIrSBooK5di/LMt6
	J/Uk5EtsnR93fv+SZCE/2kba1Ukx3VKPc+iNx0+XGPzg4nsWU2wtZOCR
X-Gm-Gg: AY/fxX63rIelGrYdka1tZz295fhCjptaQaowmu8SmWSFhPSAMfYbpxpZEk3aluuvIza
	D1Pthr+Sqr7zG0OUYAYNa4BoYdgSzrG4Qx9aNkVuN/YHbDvIY4djOCxst+23v6ONtxt+5JNGWED
	AbNTMou8CEEOAnkzyi5+E5yy5dkNwcpDRWFSwXLTHBUcybkAhaeF8ENFqdVv+Xvdxv9QukT/vTl
	zPTjCkvtxw7e7MKz515+kEQMGpTcUXYL06jx2FtDO29E7rKHd5e+gbPTLzk4cHGXU2acXrL02c0
	BhTfb0W9f3lPp8SRjUETK0d3mh5MNDwddArlIuYxut0rVliKjl9CfdIfpTIU/gVCgPxy5Gze7zV
	JR5SaeF1+05ZnbWeAHjJnQ2eC9dS9HAwlcV+zNl7iYgA2MzC8iX6FI6GpnbXRWZhFlo8pPIzujC
	zXj5ENO8i4eUeLJEkp/wv0noY2zho/EEC5oNJOFeeF+jPiY/B5UXSVyiihbWG3cpR8WkU2WnZDg
	JSuqD/o2OwYEG2Y4ppTEO4Yq5uIA+Y+11gYFC4b84x3nq8xXIUaobTT5eg1WKqu
X-Google-Smtp-Source: AGHT+IEJnv3UqFROfzTdiGk+Yia+03GyTCwkQV27SNGxc+20v7PiTTKfDMNR/uM8sxXDAst37Ralmg==
X-Received: by 2002:a05:600c:3ba9:b0:477:9d88:2da6 with SMTP id 5b1f17b1804b1-47d847d0f30mr197917505e9.0.1768135301644;
        Sun, 11 Jan 2026 04:41:41 -0800 (PST)
Received: from ?IPV6:2003:ea:8f47:8300:6996:b28c:496c:1292? (p200300ea8f4783006996b28c496c1292.dip0.t-ipconnect.de. [2003:ea:8f47:8300:6996:b28c:496c:1292])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ecf6a5466sm18242265e9.11.2026.01.11.04.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 04:41:41 -0800 (PST)
Message-ID: <8610d30c-eac7-4100-9008-d3b6cee6a5cd@gmail.com>
Date: Sun, 11 Jan 2026 13:41:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 1/2] net: phy: fixed_phy: replace list of fixed
 PHYs with static array
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <110f676d-727c-4575-abe4-e383f98fc38f@gmail.com>
Content-Language: en-US
In-Reply-To: <110f676d-727c-4575-abe4-e383f98fc38f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Due to max 32 PHY addresses being available per mii bus, using a list
can't support more fixed PHY's. And there's no known use case for as
much as 32 fixed PHY's on a system. 8 should be plenty of fixed PHY's,
so use an array of that size instead of a list. This allows to
significantly reduce the code size and complexity.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/fixed_phy.c | 69 +++++++++----------------------------
 1 file changed, 17 insertions(+), 52 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index 50684271f81..7d6078d1570 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -10,7 +10,6 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/list.h>
 #include <linux/mii.h>
 #include <linux/phy.h>
 #include <linux/phy_fixed.h>
@@ -22,27 +21,24 @@
 
 #include "swphy.h"
 
+/* The DSA loop driver may allocate 4 fixed PHY's, and 4 additional
+ * fixed PHY's for a system should be sufficient.
+ */
+#define NUM_FP	8
+
 struct fixed_phy {
-	int addr;
 	struct phy_device *phydev;
 	struct fixed_phy_status status;
 	int (*link_update)(struct net_device *, struct fixed_phy_status *);
-	struct list_head node;
 };
 
+static struct fixed_phy fmb_fixed_phys[NUM_FP];
 static struct mii_bus *fmb_mii_bus;
-static LIST_HEAD(fmb_phys);
+static DEFINE_IDA(phy_fixed_ida);
 
 static struct fixed_phy *fixed_phy_find(int addr)
 {
-	struct fixed_phy *fp;
-
-	list_for_each_entry(fp, &fmb_phys, node) {
-		if (fp->addr == addr)
-			return fp;
-	}
-
-	return NULL;
+	return ida_exists(&phy_fixed_ida, addr) ? fmb_fixed_phys + addr : NULL;
 }
 
 int fixed_phy_change_carrier(struct net_device *dev, bool new_carrier)
@@ -108,31 +104,6 @@ int fixed_phy_set_link_update(struct phy_device *phydev,
 }
 EXPORT_SYMBOL_GPL(fixed_phy_set_link_update);
 
-static int __fixed_phy_add(int phy_addr,
-			   const struct fixed_phy_status *status)
-{
-	struct fixed_phy *fp;
-	int ret;
-
-	ret = swphy_validate_state(status);
-	if (ret < 0)
-		return ret;
-
-	fp = kzalloc(sizeof(*fp), GFP_KERNEL);
-	if (!fp)
-		return -ENOMEM;
-
-	fp->addr = phy_addr;
-	fp->status = *status;
-	fp->status.link = true;
-
-	list_add_tail(&fp->node, &fmb_phys);
-
-	return 0;
-}
-
-static DEFINE_IDA(phy_fixed_ida);
-
 static void fixed_phy_del(int phy_addr)
 {
 	struct fixed_phy *fp;
@@ -141,8 +112,7 @@ static void fixed_phy_del(int phy_addr)
 	if (!fp)
 		return;
 
-	list_del(&fp->node);
-	kfree(fp);
+	memset(fp, 0, sizeof(*fp));
 	ida_free(&phy_fixed_ida, phy_addr);
 }
 
@@ -153,19 +123,20 @@ struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
 	int phy_addr;
 	int ret;
 
+	ret = swphy_validate_state(status);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
 	if (!fmb_mii_bus || fmb_mii_bus->state != MDIOBUS_REGISTERED)
 		return ERR_PTR(-EPROBE_DEFER);
 
-	/* Get the next available PHY address, up to PHY_MAX_ADDR */
-	phy_addr = ida_alloc_max(&phy_fixed_ida, PHY_MAX_ADDR - 1, GFP_KERNEL);
+	/* Get the next available PHY address, up to NUM_FP */
+	phy_addr = ida_alloc_max(&phy_fixed_ida, NUM_FP - 1, GFP_KERNEL);
 	if (phy_addr < 0)
 		return ERR_PTR(phy_addr);
 
-	ret = __fixed_phy_add(phy_addr, status);
-	if (ret < 0) {
-		ida_free(&phy_fixed_ida, phy_addr);
-		return ERR_PTR(ret);
-	}
+	fmb_fixed_phys[phy_addr].status = *status;
+	fmb_fixed_phys[phy_addr].status.link = true;
 
 	phy = get_phy_device(fmb_mii_bus, phy_addr, false);
 	if (IS_ERR(phy)) {
@@ -237,15 +208,9 @@ module_init(fixed_mdio_bus_init);
 
 static void __exit fixed_mdio_bus_exit(void)
 {
-	struct fixed_phy *fp, *tmp;
-
 	mdiobus_unregister(fmb_mii_bus);
 	mdiobus_free(fmb_mii_bus);
 
-	list_for_each_entry_safe(fp, tmp, &fmb_phys, node) {
-		list_del(&fp->node);
-		kfree(fp);
-	}
 	ida_destroy(&phy_fixed_ida);
 }
 module_exit(fixed_mdio_bus_exit);
-- 
2.52.0



