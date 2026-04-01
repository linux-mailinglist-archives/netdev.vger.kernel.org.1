Return-Path: <netdev+bounces-273796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENu+BSppzGlXSwYAu9opvQ
	(envelope-from <netdev+bounces-273796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 02:39:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC8E3732C3
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 02:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9268C302D160
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 00:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9927D1E376C;
	Wed,  1 Apr 2026 00:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Yiv7PoGG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303771A680C
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 00:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775003932; cv=none; b=U4xzpMkbfOqZL3JAmZT1nJY28tyCkfgcS8p+NnZz27njs/y1+JRSXYJB7DX59R3SgKiofuZrI8M8CjrrWR3nSe/XgC2yin797Y+fyNisYIWe4AT/I57wq0EsO1QQn4OjumRBIp+pS8yPZZHKa6oN16Q9RaT6z9BmPdaRuhkRJaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775003932; c=relaxed/simple;
	bh=/VIdnwA1rFPmMjFbFNDc0b6zbIJIlIRpPot0XhXLrzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ulV1Qf4BOJbIp457NlqR2diTRvUHCJwIKlIra5V+XvhBhkjV2GYfRViskNtifJxifreTqq4/LL3g1fISN7CovkJ4GMBwbUNOHu8Hk1LxgWetiHoPAjCdGDd/9q9RMjvNQh/7p054Ug7lf8zvFPNDLFt8ehltu/gZER96Jo7BDwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Yiv7PoGG; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-64e87a81639so9696658d50.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 17:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775003930; x=1775608730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGzURbeb7kfWQrJI6B8LRZmFPEfffxSDLiDprZPr0hE=;
        b=W2AbiFZWtx4fBugxxGHMpDxctd/8SvkqPN2XZkn1SXSAUeMzqIhywcYN/0ejXmgVrx
         7WvORnDU9deD5GBCv7gcVt9WopSSayKzIu5qd7awUHydbtHzpDHc7oQmfrlHlPFABKzU
         31rXYEu4ztJ6GGCGkHmhtSDqccY1RGGzat1RjQm8gGkzZVPAu6y09sBKFX4usnVvPNkh
         6Z/7/Qvu6J0cI6pNL88ezmF9eR6qqOjwzzLD5WOg1NdDLNrTqUWR7gqhmZ7VtwSTid+g
         z91TC3QoofD3JQZcxhfwPqvYeRpTtKRpfHO7sB+oe2qy5jzqvaG019S/2a0y+3pGyJ+G
         JsiQ==
X-Gm-Message-State: AOJu0Yw7gbkfaqDEJHAUIaOLs93TqO3X2vPatZ8A13vu9xa/faO13Jhh
	uEKrklf79QtH4gFSCtnduMNUPHhqky4iiaYdXx6Ookeb99jflPWk1ZINcX2dAMMl/D5xI3IYRpu
	aQYkf4ADaJoniH5Nc3ydp4nGJFZ5lXsWbv+I8NkvE4zkY8cyHsVHcYQdR2NFgMPXsvmDUnIi2Ja
	Xgm5E0OqXwsbU9cE5lfMyPP5EDQSwtEeCQvmezp3kueWmvAf/VDSwaTocqJC+6ekeX5GxNJBik5
	Pwa2z+tXg==
X-Gm-Gg: ATEYQzxX7b/2p3tfWAaWpGLACSCBa8vHSV0Oj4nVzWi674TkDuILDL0dxgn5EuBfteu
	KTLiPxcTWgnrclHxMozp7I4L8cWLTDCm066CRHUV0MQj9izoi+IGfwvH+ddj5p4MdFdWPjdg5XP
	hXEaWqROKT+v/dkYgvbwsFS6YnncGhZfT1djAkkYw22Ul500SJZ4/MJHNn0Wo4CAgZHlFNjcsKG
	vrgZ/pzbw+Wzx6FKdPOKUXUJwSgsXLxz+/u6KJ4Ivg6wGZ+EKH48GF9EoKRCNnPpDzCcpHP7K0E
	rCSFANXZz6M9Na2ZCRAzzekrppf0Am4R8J8p/ZyUFgqE5/z8VbJyT1H4p9d+9acZF+lTI7hGxe6
	AX66bF+n9z4VYS9r1rT3h7iUfx6VOkL7fdmI1XguUkw5GNkVcSjDnxTpkHrL6HWsXQJ5JvBeQKI
	AE9ORR5GKw6PUPDPDUui7JCxQCUOfy9WJ/Mg3hgB+MlvcgesQmSZKEUUnXCg==
X-Received: by 2002:a05:690e:b8d:b0:650:324f:c352 with SMTP id 956f58d0204a3-650324fc472mr320733d50.37.1775003930211;
        Tue, 31 Mar 2026 17:38:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-65031252cc8sm40297d50.27.2026.03.31.17.38.49
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2026 17:38:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-12737f276a2so7317288c88.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 17:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775003928; x=1775608728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGzURbeb7kfWQrJI6B8LRZmFPEfffxSDLiDprZPr0hE=;
        b=Yiv7PoGG1EO4HfzQ63Chx7shIKDFSzecsGJOlCKLaoT9nKAWFszzxQxNr5uMCbHdpz
         OV4DHE82EslcVsmLS1BcSVIXHEVcRho/1pXqpUgpyW8CjMHcDvjfvy2VYVrvuPopzDfF
         q78HjJjYAinbbQPiSJIu0n98+O2UaGcfyGOJU=
X-Received: by 2002:a05:7022:384b:b0:119:e56b:98b9 with SMTP id a92af1059eb24-12be6594496mr1010368c88.32.1775003928035;
        Tue, 31 Mar 2026 17:38:48 -0700 (PDT)
X-Received: by 2002:a05:7022:384b:b0:119:e56b:98b9 with SMTP id a92af1059eb24-12be6594496mr1010344c88.32.1775003927314;
        Tue, 31 Mar 2026 17:38:47 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aba581027sm17663190c88.4.2026.03.31.17.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 17:38:47 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	bcm-kernel-feedback-list@broadcom.com,
	florian.fainelli@broadcom.com,
	opendmb@gmail.com,
	nb@tipi-net.de,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net v2 3/4] net: bcmgenet: fix racing timeout handler
Date: Tue, 31 Mar 2026 17:38:39 -0700
Message-Id: <20260401003840.3112454-4-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401003840.3112454-1-justin.chen@broadcom.com>
References: <20260401003840.3112454-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,lunn.ch,broadcom.com,gmail.com,tipi-net.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273796-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EAC8E3732C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The bcmgenet_timeout handler tries to take down all tx queues when
a single queue times out. This is over zealous and causes many race
conditions with queues that are still chugging along. Instead lets
only restart the timed out queue.

Fixes: 13ea657806cf ("net: bcmgenet: improve TX timeout")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Tested-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 22 ++++++++-----------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index e89126a0c20e..54f71b1e85fc 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3477,27 +3477,23 @@ static void bcmgenet_dump_tx_queue(struct bcmgenet_tx_ring *ring)
 static void bcmgenet_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
-	u32 int1_enable = 0;
-	unsigned int q;
+	struct bcmgenet_tx_ring *ring = &priv->tx_rings[txqueue];
+	struct netdev_queue *txq = netdev_get_tx_queue(dev, txqueue);
 
 	netif_dbg(priv, tx_err, dev, "bcmgenet_timeout\n");
 
-	for (q = 0; q <= priv->hw_params->tx_queues; q++)
-		bcmgenet_dump_tx_queue(&priv->tx_rings[q]);
-
-	bcmgenet_tx_reclaim_all(dev);
+	bcmgenet_dump_tx_queue(ring);
 
-	for (q = 0; q <= priv->hw_params->tx_queues; q++)
-		int1_enable |= (1 << q);
+	bcmgenet_tx_reclaim(dev, ring, true);
 
-	/* Re-enable TX interrupts if disabled */
-	bcmgenet_intrl2_1_writel(priv, int1_enable, INTRL2_CPU_MASK_CLEAR);
+	/* Re-enable the TX interrupt for this ring */
+	bcmgenet_intrl2_1_writel(priv, 1 << txqueue, INTRL2_CPU_MASK_CLEAR);
 
-	netif_trans_update(dev);
+	txq_trans_cond_update(txq);
 
-	BCMGENET_STATS64_INC((&priv->tx_rings[txqueue].stats64), errors);
+	BCMGENET_STATS64_INC((&ring->stats64), errors);
 
-	netif_tx_wake_all_queues(dev);
+	netif_tx_wake_queue(txq);
 }
 
 #define MAX_MDF_FILTER	17
-- 
2.34.1


