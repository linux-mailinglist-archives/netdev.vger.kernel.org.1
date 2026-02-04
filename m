Return-Path: <netdev+bounces-256525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDQFCSuygmn/YAMAu9opvQ
	(envelope-from <netdev+bounces-256525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 03:42:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C30E0F23
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 03:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4985831052F9
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 02:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205F52D6E73;
	Wed,  4 Feb 2026 02:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUMGEi3p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC7D2D541B
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 02:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770172922; cv=none; b=oG5ERxUPru4YDRGGvNbpxKK/YJZGzwnMUhCQvy5Qs0e8a93LNq9IpBoB8Ie/11ra4wFNlnF0E/B72zoEQTj3+i1Avaiu0T9vLB0w5wat2N9N/b65973Xwd462UD9u2pPbkgtrBDKf9hwcyhupC+/sNVAHqgEB0Njtzv0Le/LVzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770172922; c=relaxed/simple;
	bh=8FMeXYP8feJkjvsRu8kgeiN2GD7FvDkaVul3+ocLFcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mhA5h4pJbTjR97P6qDVB9kQ+ZUDGt/7D5DMRmasST2pTEBFgd50ki8GyZlu4oHnT4l/kHU6yx1g1rHzGPRw0n1tS5DTSwL5RWm0Z9swRXduZmjFT9TNXtt0ofkVfMezQdEVBJfnx2sDfY3gHEfytw5I5RMYe83fgtpuBOjR2IAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUMGEi3p; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c6a7638f42so932844385a.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 18:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770172920; x=1770777720; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dI7IIiO85FcTRdRp86tMxgokqV9W8c5vvXSN0QM4iYA=;
        b=iUMGEi3pMb2pbrgSHV7H7h0091hgq0Jf7TdzBakL6YtwJMGmhDGPlIhJ1Bm/enflJb
         diawetpG6t1W3lLodc0C+VYiqboOhlJY0cV0VM/sAkn9dYZmJ/R/VV/SVZJxob3QtOgl
         pQJHiAktkSD3GM3/0h6ZMZfr34jSUwC/JUmQ0TFuYOl8hWvmj4iny6yZx0A7iavDcNMQ
         7zC/wSJhyVULC5kO+JfwPfzZ1/JbkLTW/N0vSdrVBSfeSVaS+HdIqpHUsWoLht/4c7zk
         qExOD8uiFzYqQa/Bs0H3TdKu4YX5B+gmNHALCFPWQTkNwSD1+wjhjOQciXcsWKWqTjHx
         gn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770172920; x=1770777720;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dI7IIiO85FcTRdRp86tMxgokqV9W8c5vvXSN0QM4iYA=;
        b=Lz8sAQfj3W4stygWNHvarwl8IZe8YQfYNw/kXfmwW218Rld9h7uzxR468o2Ic/KRWX
         D1H2oEYqzJ7E3vztydluPxyJnRPzvAqv6JaI/QytpBd7HXITPlnMAi8zFAtNlWaeQbVp
         817Valo+DmUudrpEm2HhCCTXhTAUIWQS2NHMQwQLkQBO2tnadx4MZv8mPn3Kegn2IJmM
         QqVaJAdclxf2gEGhq0kqaAn1eyOQE9Luyg0wnzMiDdpkzolfv0eyDEtt5OypwhonSKyX
         kS3s0tjwh/hQBHqrxcbeSAeL1jhr/KdWcKalFzC6zE2tAOB8tlQOE25RmNIXJR38SqHM
         GN7w==
X-Gm-Message-State: AOJu0YwFx0Cn2r6EADJ8aS1kzMx4ZZVGFo/WwAiuktf36uf5pf9jim91
	ulZnKc3hA42ajXA9+tdzrn/CYqRFE3vdxzV6hnIw/Nnj/Pmz/SRDG4gS
X-Gm-Gg: AZuq6aJHF2VsngrA7iC1efvRdE8+fY4nFYyyLYcEF9hB06i55Q50VfTrmAq8RlUjndJ
	O4thNROIyFWzzGXtbcaAVPtrvr6MPWRZKOM5suODLznw98/VYABgNEBd0ioVM+WddilZ85YpTYW
	XjqA9K0UciC5XY/Zuk06ucZkqwQYnOWEl0usk96+MvIiYqPCQQBGqaUOzrZxgRGBIxrXj0V5F5r
	3xl5X8sWZ0eF3rUuC/uubFjCTh0hXi2DbtBYLNPdkAA2w6AFTwio/bnUWo8gGq1k2JWI97kJmXM
	BD/98Hi3vwiKGQnkyjSj3OT32A/ae7sjzbZE/oXYgSpf8ituxfg1uoWazVJwLgvJo3khsWlZ6HM
	+78JZCfq09G9V1BG+XYGZTXQYc1OiTGdafmjujsQKdFZZQM5V6M4ybf+m7kuLF7dv1YIeyWJxBu
	MOHWN4qjwaphM07bcysi1T
X-Received: by 2002:a05:620a:17a5:b0:8b5:e783:933a with SMTP id af79cd13be357-8ca2f9f8d65mr194626685a.77.1770172919390;
        Tue, 03 Feb 2026 18:41:59 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fd40f9asm94762485a.41.2026.02.03.18.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 18:41:59 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Date: Wed, 04 Feb 2026 10:41:11 +0800
Subject: [PATCH net-next 2/2] net: ti: icssg-prueth: Use system default
 workqueue in ndo_set_rx_mode callback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-icssg-prueth-workqueue-v1-2-9a892f4b293d@gmail.com>
References: <20260204-icssg-prueth-workqueue-v1-0-9a892f4b293d@gmail.com>
In-Reply-To: <20260204-icssg-prueth-workqueue-v1-0-9a892f4b293d@gmail.com>
To: netdev@vger.kernel.org
Cc: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Meghana Malladi <m-malladi@ti.com>, Jacob Keller <jacob.e.keller@intel.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Himanshu Mittal <h-mittal1@ti.com>, Simon Horman <horms@kernel.org>, 
 Byungchul Park <byungchul@sk.com>, 
 Markus Elfring <elfring@users.sourceforge.net>, 
 Kevin Hao <haokexin@gmail.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256525-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ti.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,intel.com,linux.dev,sk.com,users.sourceforge.net,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78C30E0F23
X-Rspamd-Action: no action

Currently, the actual processing of ndo_set_rx_mode is executed in a work.
However, there is no need to create a dedicated workqueue for such a
simple use case. To simplify the code, switch to using the system default
workqueue instead.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c |  1 -
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 13 ++++---------
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  1 -
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 090aa74d3ce7257ae52158b2ff9a2a1239bfcfc8..0cf9dfe0fa362b4ff986b6815952f95b79cb476d 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -1720,7 +1720,6 @@ void prueth_netdev_exit(struct prueth *prueth,
 	netif_napi_del(&emac->napi_rx);
 
 	pruss_release_mem_region(prueth->pruss, &emac->dram);
-	destroy_workqueue(emac->cmd_wq);
 	free_netdev(emac->ndev);
 	prueth->emac[mac] = NULL;
 }
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index f65041662173c1968f7e70dc4a3d897523f24095..0939994c932f5322eebbaa1b2fe43e20d3dca5ae 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1099,7 +1099,7 @@ static void emac_ndo_set_rx_mode(struct net_device *ndev)
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
 
-	queue_work(emac->cmd_wq, &emac->rx_mode_work);
+	schedule_work(&emac->rx_mode_work);
 }
 
 static netdev_features_t emac_ndo_fix_features(struct net_device *ndev,
@@ -1451,11 +1451,6 @@ static int prueth_netdev_init(struct prueth *prueth,
 	emac->port_id = port;
 	emac->xdp_prog = NULL;
 	emac->ndev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
-	emac->cmd_wq = create_singlethread_workqueue("icssg_cmd_wq");
-	if (!emac->cmd_wq) {
-		ret = -ENOMEM;
-		goto free_ndev;
-	}
 	INIT_WORK(&emac->rx_mode_work, emac_ndo_set_rx_mode_work);
 
 	INIT_DELAYED_WORK(&emac->stats_work, icssg_stats_work_handler);
@@ -1467,7 +1462,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 	if (ret) {
 		dev_err(prueth->dev, "unable to get DRAM: %d\n", ret);
 		ret = -ENOMEM;
-		goto free_wq;
+		goto free_ndev;
 	}
 
 	emac->tx_ch_num = 1;
@@ -1566,8 +1561,6 @@ static int prueth_netdev_init(struct prueth *prueth,
 
 free:
 	pruss_release_mem_region(prueth->pruss, &emac->dram);
-free_wq:
-	destroy_workqueue(emac->cmd_wq);
 free_ndev:
 	emac->ndev = NULL;
 	prueth->emac[mac] = NULL;
@@ -2236,6 +2229,7 @@ static int prueth_probe(struct platform_device *pdev)
 			prueth->emac[i]->ndev->phydev = NULL;
 		}
 		unregister_netdev(prueth->registered_netdevs[i]);
+		disable_work_sync(&prueth->emac[i]->rx_mode_work);
 	}
 
 netdev_exit:
@@ -2295,6 +2289,7 @@ static void prueth_remove(struct platform_device *pdev)
 		phy_disconnect(prueth->emac[i]->ndev->phydev);
 		prueth->emac[i]->ndev->phydev = NULL;
 		unregister_netdev(prueth->registered_netdevs[i]);
+		disable_work_sync(&prueth->emac[i]->rx_mode_work);
 	}
 
 	for (i = 0; i < PRUETH_NUM_MACS; i++) {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 10eadd35665045a98a0c0a639606b7c2691195de..3d94fa5a7ac10992d35fdb63458f8cb6eb3a5a22 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -236,7 +236,6 @@ struct prueth_emac {
 	/* Mutex to serialize access to firmware command interface */
 	struct mutex cmd_lock;
 	struct work_struct rx_mode_work;
-	struct workqueue_struct	*cmd_wq;
 
 	struct pruss_mem_region dram;
 

-- 
2.52.0


