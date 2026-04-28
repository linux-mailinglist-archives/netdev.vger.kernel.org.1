Return-Path: <netdev+bounces-281581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA13Eu4Q8GmANwEAu9opvQ
	(envelope-from <netdev+bounces-281581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:44:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A39F247C83A
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 077D930330B7
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C432D877A;
	Tue, 28 Apr 2026 01:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKUichJ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542522D839C
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 01:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777340629; cv=none; b=qK630fv00MVOyr08HGpCz1TpAcdhDwBN5PNpV+T8Z0bl2SYEV163TwmI1V0lbCVfyzSt+DXRRvbtNWkgMDMpM3viAXhlLm+F9viaP29G2XI3ByLfGMBLaUiI6PksP5/nFqJ64fVSZnrg59bV/GY0/i04lYnmqjm5u8LZBT1B8y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777340629; c=relaxed/simple;
	bh=CKXcttVAKTLWfc/d7LCcMNBW+m1sEh7gangdV+IOaUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UdNt6VrxQZMx8XM7u1vCt5UFfLJXDQS5olelxbuVPAhr1tmdaXHVeKgh2ph4hkv236aSJlgu524F1aFwH4SxqLbNKiDm8ZM9c3gTkTdt2vRwRocB7hDFKqeT+hGyYSOqq5wwavbqkAIoWezC4PaDh7JjJn1skE9XAMdJmuE1GPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKUichJ7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b7adb38d65so45538575ad.2
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 18:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777340627; x=1777945427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4lnDRz4vDSxZH5/9mkvW+QxHdHkEwKhYpgnzlKg+vYA=;
        b=ZKUichJ7uFgQ40fRlfnd2KEqO0c8gblagXS88o+4BIuD7ENCdQzada6XhZ7Ypsa4EY
         04dipPBhKWl6UoGKJ6q7fxUKPTgfBsRlVxxZW1pwlqRNq5OKgSuIy4DFa7xVcu4IslUa
         8r0TQQOuGwnPXg/lTnr9kTpxwaFFifNtxwjP/snoIjmEJnKcTj6Am2XP5BzQT++YJ5Tb
         EFgfL8fQSGYbkuZoFQ+8UWs6JYxqry94sL9S6SxEk4rQoaNtBZzzpIk2BbXkrMVuu4fO
         GoZx5tOf7Q71n8q2LEW7axRePm7+gCYmXPQYakyepqhPZH43mrAA22Rhv6bV2jIu6svN
         eE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777340627; x=1777945427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lnDRz4vDSxZH5/9mkvW+QxHdHkEwKhYpgnzlKg+vYA=;
        b=Vyp8BCLE0Nbww8ijqegIARzeKsGPTd5N/sjvFm24Huee6gogu1MydQBaGMvYBs+WK2
         KAv5kzypoohfTQie6xdy8tlxJpmq4TRk/iZAcmG0q4JQuRXjemt7CIRnydWgYxW9uoiA
         ZQLqaxRl5cKD2ZZemUyHTBnfoAfcTTO6uknCzcbpxJQZMrTbP7AYeScQJ7vDD94OeHwy
         TqnlvgjhdxHFLu9b0EuPUfD3/Xex0uP7+Aayg712bnc4uzF4cpzrRwHTiJri99rAlgZp
         FLn/yKiz7/aAsLoEaF0gf9beh63YjZ/4gff/mC6NkdxcuKmMz2GQ0gAZv9Bn6qgfsmVY
         zsaQ==
X-Gm-Message-State: AOJu0Yx3bjYYHBjPOUH1wMcQ9CYZASEIkOSSoQ9uZsGjNOsur/GGRQPP
	44VI5r/krcAPjPwX0edZ6DCU4GvcRmB01E3obeTSyOHs5pcY2E9xq9JWUjS40bbj
X-Gm-Gg: AeBDietue/Kq2MccspvyB75PURIsovcS6Rdx1nmH/62OzAYAP58AnlMcbPIWk1ZL4+c
	1U82Nv5C1A82/AUMPRGVKLrOcxUF33VaCoY2uUgjRyaaeXb8CPFOQu3VK9Ft1xEKQ8Qsm59o7jI
	blqIfFrfAWHwd/f6v7OqTUmry5kElmRhm/h7oTmD3vEilH/wTuCVrHbNH6kbxZl/fwiYwRTn5s0
	1RMX/5Rk19p1XHRwFKVP4iAVJQJ/XLa54n+HNWLHRy72dNJlbHp3cHsj9lp8ujJkLst+EDMG86b
	KfBs0Qp6guXC4yL0dIDw5mYh6XYuS6ah694aCHTmXpFT2IzPlZU5hp4iyUaS+mglBFXnuFe93ZW
	YspRHAFqpV22yjykQqM4SQWkKDc2uH2dBCRLBWAkQIQot/GDH8jclDtrb1cAXipYnyTyuUuOgch
	q7Fec+sXYSLmosDoXgY1zs6km0Ro8FW3lyMwKFWOhukCcd3ahkXNrN6po0IYccFb7n7Rz8SXM9Q
	ubl6ggMfp4+HxLOKTq7/2MpSrIhA6PNkZy9
X-Received: by 2002:a17:903:388f:b0:2b2:4a9a:b168 with SMTP id d9443c01a7336-2b97c3febaamr9189575ad.11.1777340627263;
        Mon, 27 Apr 2026 18:43:47 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97aaaf144sm7890965ad.29.2026.04.27.18.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 18:43:46 -0700 (PDT)
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
Date: Mon, 27 Apr 2026 18:43:29 -0700
Message-ID: <20260428014329.779779-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A39F247C83A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281581-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

of_get_ethdev_address can return EPROBE_DEFER when using nvmem. To
handle this, encode the error with ERR_PTR for minimal changes. Adjust
the only place using bcmasp_interface_create.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: use dev_err_probe.
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


