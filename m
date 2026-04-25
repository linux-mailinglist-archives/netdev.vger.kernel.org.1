Return-Path: <netdev+bounces-281092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id M+LkFvca7GkJUgAAu9opvQ
	(envelope-from <netdev+bounces-281092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 03:37:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D20E464736
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 03:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10497300E720
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 01:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2C620E6E2;
	Sat, 25 Apr 2026 01:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9OEdDq+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216A41F03D9
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 01:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777081074; cv=none; b=e7Qew6yGsbH2/ePI0oNr3tKzSQ39E3FNaX5ZFEQv1gtGYKDyk0nw8lBkG5lq9+zkCDUlWOLnRzfukHrnA2PF6doxEHcf3NLpYu196E+FQhHOG4MvhIIZwWPqu6DSOXbWSKEmi03tle4uiDCbE/0xfNul9YNcNBhlbbOCStvpIVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777081074; c=relaxed/simple;
	bh=9OmU/2gfzjKgD7nd2TDsC3LPOSB3XfwuhnKxFr1hJmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MSLvtUPmfP0B9SdoIbdYGUljfJ1Pe+f9dg7xYS2K/7A3M5om9YH/u7FlTzMi+jMTNBemt1zvrqA8Lm3yzbeA7OYEYY8vnEJaYNOsKH8eog1FchZyvQ1cpEq+OVQnNm5HHkN7StrqiZv9qlf7lEYtxelB726vjIBoJkVQhROEDu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s9OEdDq+; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35d90833cacso5431947a91.2
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 18:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777081072; x=1777685872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CmZzLLJEqyNx+LYpuh9fgC1wzeSSJG9uNkzqlGLsj7g=;
        b=s9OEdDq+ZmCRaoaLLpJhb7nH/t4kmEhARH0ByaZZuvqVcqje9tR5Br3z0scGiSqBlr
         YmD3Evyqgo99vW3FW//dv5iodFCu5Zjr92t/uwkYH/HlsBNMVlly0Xbll0OneXQ/HC8h
         nO/RfwatrHrh2VXzwKMd6RL6Cij3sGmXiSFZS+4cnHMED3FyvPH0VrOluUl3SWMj2jYX
         +sNMoeLsc06Q6BNeYitKUqSMIgRu/Kf5cJgl/bssXoab42OIAPiRzZ2hhot3t2dJ5U3n
         0OWsWk6gfgcCRiLDJxXlhWl94Lu9PS5bDtyt3HPGyZvFyb9QTZMX5JFYwMb0jnfES4FU
         pWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777081072; x=1777685872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmZzLLJEqyNx+LYpuh9fgC1wzeSSJG9uNkzqlGLsj7g=;
        b=m2t/6WTNSGXiy0aoDkBv7LXBozHlnVfc4flSGK36vB7cReX+GG7IUVFoVpr7t8MmPb
         QLFifZrSkL6xwcn2Nduhc1vJKkUZ4E4ubMHA6nh/3+TBjvnUur75ZSZIMEb3BeF2UIYc
         ikGNWKH7JlDgBvi3o/DAi99ocWr3CbvA3CEzYIx4fz2zCRdUWpFSWxtp99uLYlRoFX7C
         N+D1m8vvRiFNv1z7M5mPcEpXeCCip/dCYocS14VUigRFzcAlWoIjxgYPP97/o5B/tbEE
         GrHIcv+vzGNHAXmvCY5AlerhcQaHfUDKHw5j/4SqF4G5K9JH5ycdDggr3RNJyCk/oBt3
         ecuw==
X-Gm-Message-State: AOJu0YybM3jduJBpKOQ3GQ+4I087qT+gaGBp6X1JCtfgIjwR/SeK5CQD
	8ZGcnQUaObeapfhsvgCreH6bi50W95RQEHf0lXmm4LcLN0a5E84bHj3LEKQcxQ==
X-Gm-Gg: AeBDiet+OifYGpEd7sog8yqhSksSPeoi6mdPYF8J0NUwqn+UYETYL8QG0/GXzQ/VNDs
	R9fF7UuO84Y8gZ9fGvOLVpOLjoa6gNuCk2884rouUbSsX83eSlntw02H6PohA2fg8aJ83tn63EA
	k02N3XYeTRJ5vIOGzzlY3+OxgQijH68bzieA42iY8IRTy/G3Jm9etSiM5NFYRukh3+D86rxKDH6
	YRxIHI15Wfzgo4gmfAmn1eo1qAHMq9etXmY0DIrtyyf+ru9v1Xhs1EA9YUOsI/pj2+JVRHSgjUq
	ojC0gt84CvjIGReoqTlKtWA3oGOHs7o7RlsCv6vEjfn+n9gIIzAaQ4FTWTXs1CPuJPC3aEC2xRN
	ipkhfbW6HwJIJFhz1+eM39Oui/5UHToAPQgN/Q9skv/92QAfDv7umMapdD+2H0Te8AfKF8f6/L6
	4+QSAZn5uqlDzkjQZ0QoScVHqf2dN3gSeD8JRWzo0vr6pcWfAzjV4xUT8VXrTRPECb6Jt+Io3oL
	1AzqLmwKbGJDtM3XlvwQDY+Tm5Xfb2g0rJo
X-Received: by 2002:a17:90b:5890:b0:35e:5723:85e3 with SMTP id 98e67ed59e1d1-361403f12ddmr35564432a91.9.1777081072129;
        Fri, 24 Apr 2026 18:37:52 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797701b1a3sm18999441a12.19.2026.04.24.18.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 18:37:51 -0700 (PDT)
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
Subject: [PATCH net-next] net: bcmasp: handle EPROBE_DEFER for MAC retrieval
Date: Fri, 24 Apr 2026 18:37:34 -0700
Message-ID: <20260425013734.436147-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8D20E464736
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281092-lists,netdev=lfdr.de];
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
 drivers/net/ethernet/broadcom/asp2/bcmasp.c      | 4 ++--
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 972474893a6b..31a9560c4aee 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1333,10 +1333,10 @@ static int bcmasp_probe(struct platform_device *pdev)
 	i = 0;
 	for_each_available_child_of_node_scoped(ports_node, intf_node) {
 		intf = bcmasp_interface_create(priv, intf_node, i);
-		if (!intf) {
+		if (IS_ERR(intf)) {
 			dev_err(dev, "Cannot create eth interface %d\n", i);
 			of_node_put(ports_node);
-			ret = -EINVAL;
+			ret = PTR_ERR(intf);
 			goto err_cleanup;
 		}
 		list_add_tail(&intf->list, &priv->intfs);
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index ec63f50a849e..caf0e408e2f7 100644
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
+		return ERR_PTR(-EPROBE_DEFER);
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


