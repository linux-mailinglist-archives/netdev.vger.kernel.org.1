Return-Path: <netdev+bounces-250370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA10D29751
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 01:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A13630A36F1
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 00:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BC630E844;
	Fri, 16 Jan 2026 00:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AhfzsMIq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C90F30FC09
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 00:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768524658; cv=none; b=WGEarZWrvHDVnd/Zp5Bc0+DPJsDsEWmsWjf/fKqmJkQRuBVNS+6MmOwmiEBLNCmgfmvAWyiPw6OcvmsFk+7HmsfjmO3Jn4kJRJGuxR8xPDDhoeXhUmDlah2FEO4TI3jBVw8zsKFdi3tFjcer2Go82f8R0nFbbwYShrmJO2a3k/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768524658; c=relaxed/simple;
	bh=B68hiSoceJbcqhNRzfhRMhhxS2RswzXuTBa7G6mFQh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hv+bcoCg2MQ6w6tXhIHF25khl+LulPxLEN4ZASDti6Zwxe2cTkPDnj/6yTpoJE74nb2mf6eMz3g15AmavboUZa7pLnjTPM6zV+s4piR8voxo/VVUo9rQdbVrNg3bJ0ZgmdeLC4RioWzk2Lqh527ovi3hcUQNRYIwvZs+3CIBfOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AhfzsMIq; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a0a95200e8so9955445ad.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 16:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768524646; x=1769129446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QHSl7KjNCmlL34Leswa6T4gMldUPRkc0V/lVqvwLlhY=;
        b=CZfGe0OqxMgReSSl/GeJFaKTRg+ia1NjgW/LgJpKwBxzKKjJMLU4ltercM2gyzDzfW
         cVYtK9bXFSlnrsnWVvtHH4nncW95EaBMMpiDF4shFqRGNMz32Pnnd66IWxcENZHV0TWD
         nI4J7TF59DkjyHz/qC2ySNncI6MPdGyKsz1u8kAGIqo69rt7AQ7xu1sNwX9xU9+mBXhh
         T7t5tIVFnr9hUeUUUgNSC0ikQxws090f5krcEDnZ0LruWO82Gmlsg30LlPdSWDeqglvc
         3rck8fZPq+GyLe4ZRbf0dwHxhZpKIEtthhOfOI4kHzimNjhxfwyniiv45aHRsro9rc2/
         XdnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVatA1x+/rE+rm9heXOKwnMG1aBx5EuXM6nTgzePpFjxI6wPZKkhKUYMk3aPNUFTIqQk8Mj3NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOhhUvt7uf2rj+lrG5nLTNZA3ZaEJLZL6D8ESBJgz2JRaBiXV2
	do5BOvFjg3e0gwUu07JS627/oLxG76YrCtrZMdqCyVvGARRzPGKF3O11PkV9PsMUHtoeZaXE978
	IkNN2sQ/jNlqhhGmBoA7lU3R0W+5tBlkQOjIRGxHMd8HKRK86NiYl7L0MMh0izrXnIeIJP9W+p2
	I4HTdW2RICgfdCbyrz2vJ1WEOEwykbDwYS1ped3wln0Osk519u+r+W6MUp8YdNVA0DNp1aFQa1g
	GaKBINXww==
X-Gm-Gg: AY/fxX5hBedIzbVjHx9Cd3XPkb7US5nEhPFEvQriqbM5Ohz+oVNNvNkCd44j6cqR1xE
	StST+tlxhoUV6pDljssnAfMp3j4qVfUte2katFnrPIfsQ/2urbwpTjCyckOAd8lk54QeW73TBlB
	29B9h74dshTsid/+OiNUJ5/4bCpAeWJgMZV/EwfuGwtNPvEUUr8lgLmU5+296hj9yvq/BMZgKHc
	+p19g74zcrqBnNcZla+hyyMFFGsDdyKz8WiPMN1P1LmmBgPpFkkvM9dy3sQ1Tji78mMONRskdYU
	ahTfd2hTGY28pLYRs5xoHUHQljPyWWNrn1cxA8UMj5bdwlf+16jh8wo8vWCtoRwkxBCxwY/HwSf
	jZxlc6iuHSS0ClXkmt3tjyLaCNi44u+r6gnHnWzuvc5qrnEaH6ZHFRn23Y6SpcbIY41ewcRg01g
	+PUK0qZ5Aa9xpnS8N2IR/eh+eIsfGQ2toLeJ6L80dAwFWiOQ==
X-Received: by 2002:a17:902:e949:b0:295:86a1:5008 with SMTP id d9443c01a7336-2a7175a5db7mr12112005ad.38.1768524646439;
        Thu, 15 Jan 2026 16:50:46 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a719399a02sm1132905ad.50.2026.01.15.16.50.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jan 2026 16:50:46 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-122008d48e5so2757184c88.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 16:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768524645; x=1769129445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHSl7KjNCmlL34Leswa6T4gMldUPRkc0V/lVqvwLlhY=;
        b=AhfzsMIqwUsgBws6T0ln5cnR3rZP+2SRB8OmsIynkWP7Ystt8rwrFv7iaUicWlFzv+
         +nycr1kCpeOF1LyjR88l19BhQWmBDguTXm0RwhVUsLA8QuF10j0eFiIAkdcCgJagrdyf
         /NOrUCcZdaUJKaOfo4qpEMyALJ5NpI0OBu8NI=
X-Forwarded-Encrypted: i=1; AJvYcCXcBsvuNDIv0ku9RdOuJzk0LDrUaUfjcBDixsjYUduaQo665poocMDA8Ff//n6Jac3SiEJO4xQ=@vger.kernel.org
X-Received: by 2002:a05:7022:4388:b0:123:34c2:55ff with SMTP id a92af1059eb24-1244a72ec3dmr1640216c88.20.1768524644968;
        Thu, 15 Jan 2026 16:50:44 -0800 (PST)
X-Received: by 2002:a05:7022:4388:b0:123:34c2:55ff with SMTP id a92af1059eb24-1244a72ec3dmr1640197c88.20.1768524644472;
        Thu, 15 Jan 2026 16:50:44 -0800 (PST)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac6c2besm1162305c88.5.2026.01.15.16.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 16:50:44 -0800 (PST)
From: justin.chen@broadcom.com
To: florian.fainelli@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next 3/3] net: bcmasp: streamline early exit and fix leak
Date: Thu, 15 Jan 2026 16:50:37 -0800
Message-Id: <20260116005037.540490-4-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116005037.540490-1-justin.chen@broadcom.com>
References: <20260116005037.540490-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Justin Chen <justin.chen@broadcom.com>

Fix an early exit cleanup leak by unregistering of_phy_fixed_link()

Streamline the bcmasp_probe early exit. As support for other
functionality is added(i.e. ptp), it is easier to keep track of early
exit cleanup when it is all in one place.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c   | 27 ++++++++++---------
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  |  5 +++-
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 36df7d1a9be3..aa6d8606849f 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1317,6 +1317,8 @@ static int bcmasp_probe(struct platform_device *pdev)
 
 	bcmasp_core_init_filters(priv);
 
+	bcmasp_init_wol(priv);
+
 	ports_node = of_find_node_by_name(dev->of_node, "ethernet-ports");
 	if (!ports_node) {
 		dev_warn(dev, "No ports found\n");
@@ -1328,16 +1330,14 @@ static int bcmasp_probe(struct platform_device *pdev)
 		intf = bcmasp_interface_create(priv, intf_node, i);
 		if (!intf) {
 			dev_err(dev, "Cannot create eth interface %d\n", i);
-			bcmasp_remove_intfs(priv);
-			ret = -ENOMEM;
-			goto of_put_exit;
+			of_node_put(ports_node);
+			ret = -EINVAL;
+			goto err_cleanup;
 		}
 		list_add_tail(&intf->list, &priv->intfs);
 		i++;
 	}
-
-	/* Check and enable WoL */
-	bcmasp_init_wol(priv);
+	of_node_put(ports_node);
 
 	/* Drop the clock reference count now and let ndo_open()/ndo_close()
 	 * manage it for us from now on.
@@ -1352,19 +1352,20 @@ static int bcmasp_probe(struct platform_device *pdev)
 	list_for_each_entry(intf, &priv->intfs, list) {
 		ret = register_netdev(intf->ndev);
 		if (ret) {
-			netdev_err(intf->ndev,
-				   "failed to register net_device: %d\n", ret);
-			bcmasp_wol_irq_destroy(priv);
-			bcmasp_remove_intfs(priv);
-			goto of_put_exit;
+			dev_err(dev, "failed to register net_device: %d\n", ret);
+			goto err_cleanup;
 		}
 		count++;
 	}
 
 	dev_info(dev, "Initialized %d port(s)\n", count);
 
-of_put_exit:
-	of_node_put(ports_node);
+	return ret;
+
+err_cleanup:
+	bcmasp_wol_irq_destroy(priv);
+	bcmasp_remove_intfs(priv);
+
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index 6cddd3280cb8..f3b8d94f4791 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -1228,7 +1228,7 @@ struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
 		netdev_err(intf->ndev, "invalid PHY mode: %s for port %d\n",
 			   phy_modes(intf->phy_interface), intf->port);
 		ret = -EINVAL;
-		goto err_free_netdev;
+		goto err_unregister_fixed_link;
 	}
 
 	ret = of_get_ethdev_address(ndev_dn, ndev);
@@ -1252,6 +1252,9 @@ struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
 
 	return intf;
 
+err_unregister_fixed_link:
+	if (of_phy_is_fixed_link(ndev_dn))
+		of_phy_deregister_fixed_link(ndev_dn);
 err_free_netdev:
 	free_netdev(ndev);
 err:
-- 
2.34.1


