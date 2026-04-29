Return-Path: <netdev+bounces-282226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9t4SLmt88WnohAEAu9opvQ
	(envelope-from <netdev+bounces-282226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 05:35:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4B148EADE
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 05:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9802303BB08
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2753890F0;
	Wed, 29 Apr 2026 03:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d25M/Qx9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871A5388E6F
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 03:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777433695; cv=none; b=XODfcGLp5IVisJ6Kt+dFOjE/FUdeAOvn/gi9Iw15m0/foechgXBNK1fM67ASWC6lJfAKCVXvgLsXVMi7oPRtTzJKWhMzgtdHkwKmXU3aQUbG4e1vfS4ZUeilxP0iM+zLkUos2ex510jasZEl0+sp4+hSMLUS1EpMxKl/tTlMsxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777433695; c=relaxed/simple;
	bh=JIwkDKUEYsWpb/54OV85fk68Ds+wXKQ4rnbe2Q7eY2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p2K5WyyCs/6ZlkYyrwKUFCfTBKk6vnVkxx849bD8hAnRTrPlfANQx2dWd78H6YCmr4hgdn0JDDtN5HrrA7CtMBA+pcUYz/ARKrvgZjj94BugpPbguTNirR1gqthAMh9oopLHCvVMDxzlA79Fv/j8AQVib+AsIAYPocaE/0RiDPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d25M/Qx9; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35da01fc0baso7632266a91.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 20:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777433692; x=1778038492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3g9FrMLlGHRvfkrznYnVah7AN8jAhSnFp4GMEptSQDo=;
        b=d25M/Qx9Xk21rAr4eAyp/IZNtADrLCUTXWoSZuS1T0BgrHG/mthb8nfz0NlImiq6eo
         6rdybEfhGnkObm/a/Z39yGDUe9L8Dh5u1qW38bwWjjRXy2zHBUG0luA/YY5KvDVeZIRA
         vfZaPTT/zEMs2mm8TZ0LLZh/jW6nsD4hb2e1149FMe5+07W/XklpZi9gwRkwPQVbWNU2
         fQhhYT+MDkThLh9PnxMj9lAtVzPvi3Uxos51DC4f8htIoKMOGHJUKhIOl7+y7HnMKVYn
         uGr0KWqv5wUvCPJYJlsTH8yVe+73eHr2p16s1QlSqMef7k4/WYB7jJFOvFk5gZwe2txG
         0jyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777433692; x=1778038492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3g9FrMLlGHRvfkrznYnVah7AN8jAhSnFp4GMEptSQDo=;
        b=jktFWJkH7UbFZDbtndF0fmwbRPK+6lRfhLZ5FLSRyi+3ecUjWMdkYUoWn0YyxRmA0N
         aTy2Tg7JIh0nKk/NBDbROz/VzMX9iLtdYvpgyZGCIC+WIiyaxYzH7XErEjGk2pxiYVan
         wwBRxJOw4d+/2NxggBF3eTmEZdrMNkabGQy0YswbhXlG+RJ5omhQt317BR84YaTHkq1s
         em2c6gvlTCfo6Y31B45Qx25cQghGIVoGa3zgFQXwYfRCZfrBMAcaFdqmmof2GKDY4gvr
         CJpLWsuQ4uFNzMDkuMTOALiwLptTBoXpBbpj/U6OEzYtPKDuO9a31Hdfc52YsUZkqsXo
         pz8Q==
X-Gm-Message-State: AOJu0YyO8I17fpu1Z+LSeAH5qk9oSM0Rl8I7Be48VdxyFqqZUf9zWbq5
	LT+DCc6wQF2swIAzGzgaFdhS9U0uFPLNfBx7Zjw9BNVoBlnoieCbNz2e0n52eL+p
X-Gm-Gg: AeBDiesMvGYHRVc1Wj9VXsHvDg5/iFDyX4nhW+CydIXyF/IoEJxM+vff2OcLu+BD+MQ
	EKU2FF6fEt5fI84+WjtDk6JuRImP3mBk26Yjnb00FDWwGvyx2ypNBJRREvatIXYG1h4Ewwx50ME
	5KoyhlSwsvHv1uIsr4gyyJB1OJRPOaONYPKqTNn7d1l0TT5yWkR881hIF+qZx/UsBsv+hZ6o/RF
	H0qdabOGN5DN8C6gtAriIeVfHY7PcVHhrCPTXUUIf5r+tODmI6cfRNbUe2uYAFS7p5b+ioFOEos
	uD36HIVZsXe5tX9Gvgi2299K1BRwzOr3hVrIlLenvEP83xns1sEOaII8eIgtkw61dS92hla/N95
	egTwwX3NgV9RM6GedRXGjHHMF8Ftm5B4jdn9fVrpZg/NenjK9UF7qTAZWFquQ6p4KzEbLA/9Y9M
	1iqGjAcGbFLQmFmEY4WvDi7D3Qa+UfEvPr8Fno6QFdC6gI/ew6pabF8hFt9T5nFwbc4PhLqFz4j
	13YISOTK2SVKNAKAsqc1l1byg==
X-Received: by 2002:a17:90b:39cb:b0:364:6f27:43ea with SMTP id 98e67ed59e1d1-3649205a569mr6457195a91.21.1777433692320;
        Tue, 28 Apr 2026 20:34:52 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd65065e1sm524839a12.22.2026.04.28.20.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 20:34:51 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM ASP 2.0 ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next] net: bcmasp: handle EPROBE_DEFER for MAC retrieval
Date: Tue, 28 Apr 2026 20:34:34 -0700
Message-ID: <20260429033434.367366-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0E4B148EADE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282226-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

of_get_ethdev_address can return EPROBE_DEFER when using nvmem. To
handle this, encode the error with ERR_PTR for minimal changes. Adjust
the only place using bcmasp_interface_create.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: use goto after of_get_mac_address probe deferral
 drivers/net/ethernet/broadcom/asp2/bcmasp.c      | 6 +++---
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 6 ++++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 972474893a6b..e9b11b956344 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1333,10 +1333,10 @@ static int bcmasp_probe(struct platform_device *pdev)
 	i = 0;
 	for_each_available_child_of_node_scoped(ports_node, intf_node) {
 		intf = bcmasp_interface_create(priv, intf_node, i);
-		if (!intf) {
-			dev_err(dev, "Cannot create eth interface %d\n", i);
+		if (IS_ERR(intf)) {
 			of_node_put(ports_node);
-			ret = -EINVAL;
+			ret = dev_err_probe(dev, PTR_ERR(intf), "Cannot create eth interface %d\n",
+					    i);
 			goto err_cleanup;
 		}
 		list_add_tail(&intf->list, &priv->intfs);
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index ec63f50a849e..4c34bf16bb76 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -1254,7 +1254,7 @@ struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
 	struct device *dev = &priv->pdev->dev;
 	struct bcmasp_intf *intf;
 	struct net_device *ndev;
-	int ch, port, ret;
+	int ch, port, ret = -EINVAL;

 	if (of_property_read_u32(ndev_dn, "reg", &port)) {
 		dev_warn(dev, "%s: invalid port number\n", ndev_dn->name);
@@ -1314,6 +1314,8 @@ struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
 	}

 	ret = of_get_ethdev_address(ndev_dn, ndev);
+	if (ret == -EPROBE_DEFER)
+		goto err_deregister_fixed_link;
 	if (ret) {
 		netdev_warn(ndev, "using random Ethernet MAC\n");
 		eth_hw_addr_random(ndev);
@@ -1340,7 +1342,7 @@ struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
 err_free_netdev:
 	free_netdev(ndev);
 err:
-	return NULL;
+	return ERR_PTR(ret);
 }

 void bcmasp_interface_destroy(struct bcmasp_intf *intf)
--
2.54.0


