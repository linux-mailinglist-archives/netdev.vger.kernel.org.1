Return-Path: <netdev+bounces-299595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ob/dBN1XMGqWRwUAu9opvQ
	(envelope-from <netdev+bounces-299595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:51:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3C3689970
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:51:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LHiU+i0v;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299595-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299595-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C4C83010BDE
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AAB3B531A;
	Mon, 15 Jun 2026 19:51:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84363B4EAA
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 19:51:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553074; cv=none; b=PkIiJejUs0gi1mC8UQQUO/KkAW2EoxJEEvaf5oBEA+caHqhvzemFe7yDT6dVeTVcV5jYbHTv743GCSLRBGeMIi9l7cQM4sNqdYE80VoK8YUGKhgZuZVtmdXX9qIZB5qxMa0CCAY0seXVG1XyhuDD96s6h8gm8uqyenPgWxiZIdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553074; c=relaxed/simple;
	bh=uOByGr4vblK9B20Aq+PsLQex9gmyDLYAbOyz1m5A/po=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WdWoRAZFnG5ArBRARvKiTpdkySumF4d6TVJJlQSXF1lq1/qk3ILfjTCmNWQGuZXyo2NPq6BkjbJin2HbKtWQ181q/0i5i/R8xXc7OqoEwki0mq23SanujYBgLfTM6bmMICsQU09+2Ocp01zvskwJ5/S+ZW8mY+C+GU8PBLDy5T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHiU+i0v; arc=none smtp.client-ip=209.85.214.175
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c0aa420401so27783505ad.3
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 12:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781553072; x=1782157872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbfwy+N51pnPP3dCRs58iA2OlGOjosl6R8dDok6B7Dc=;
        b=LHiU+i0vkUWSFh2FCqJXLW65/zd59RiY2l5K8/acrNrXOIwnq/ETwwEhkqsbPhchel
         1eUFfRcWSHqYShNTMd+2l8T5BeQWgX8CS3E3vz0BZd2cKQpklUbtvRu6Xyvd2gnhv3Bk
         5GfdJ1JZMq8FKckq4azZ6mh6z/Rim1kXxS8zIlIRyk1op6N6hqGpPGnVumbvgpJ8aYfo
         OTp2HnbxkS/bqKrY/1mR9Jp3KGtC71+TixzxhkCStuOhd7xIpw8kjqarHPykC0qZxk5t
         keV8SKkeaTj+E6LlsLMkXd7ax+B6D8plTGSgibduoUSOSBk76wxA4RNS7CLpRj5weL5v
         UMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781553072; x=1782157872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zbfwy+N51pnPP3dCRs58iA2OlGOjosl6R8dDok6B7Dc=;
        b=SxI8ZTDDnodmMcS71117rtXRdwX8wT6jnLUHheSB9r22wR6VcWKt/eo0fOCZQ4ORXI
         +d2tMoQONPm2LiVxDHkGpSEgs+Qgb+AbW7YxDUeAjzaiO39hQ8pb3ToXuSiterbz4VKg
         EctxhgHHn2+jjJbGYhHUGOMzYo9VVagUyUG3CBCnun1afSlRg+IefFimr8ufVbySHU1V
         v0FPnSPG39ysUfilviZ2b23bACtCFSCPowt3Ql8y3y1JvbfTZDCEJd9Z67iIscJJKk0q
         pJYGG4AnIgyciot0YQjxhx1oRasj7a52DQsCdLiAkZyyziLY1tpzTp4XzTj+GzuF8v1f
         F90w==
X-Forwarded-Encrypted: i=1; AFNElJ+SFKi7U1mglOh+iRw8eWo2al01AK3yUfvesl49Yc8w2bGvKoWHkgM3/KgXtQk9yRGDm9MZ/IU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT6b2gwEKGV0p2HitXIhUW21FFUQwJDUArXLdc1/LH/Mj8VrFV
	OmY2XyVJY7LWXXOl3uk4ApnoEKj11hLYBZ//F8lDKXiWfY9/zLhpFYt4
X-Gm-Gg: Acq92OFD0A5NduoH36Y19aQmBGcXd3OCC9wjkv5dEfUmSmMBCrj8lru5sUc9onU1UbW
	Nb62L8xiyxl3vpYketh9Vpx97vLs0EU0/Spi7mYSuFK3oh9noqBmr5Mu09Fi8BFZE6GXO+oegsB
	5jIjU+TDa/sv5jyyZrG8G3XiaQmby9Rsp+GpsgXFh0PrwQ3QC/de306VIIFMYsGHsnyN6JwHGgk
	VO/idqgWofz/qVCzQKM2fGbG/ymTCv+i/sMJo/1ViB5nSzufcEWJkIW8VMEAULOp0b878mu5atw
	6A+z0yzEz3HbsJJ2eH26JTJrK9UR9xsJYkoINR0rjGC9APSZTBx8fmKLqPsbq7Z+K2lbBqtFOco
	Izbhk2Ahx+wuwByoITTS6MkoS7LKcdvK1ZDld3vDHmxpS72qasvbxjub9n1QsJzqK4wSXmH/G7v
	wQpuxQ1KXTgNGp0bWTB7NFL2JMwQuLxc/KyCFo13t3TxpGl15SxnWOx0u6p8IAFPemWcVadB2V
X-Received: by 2002:a17:903:944:b0:2c4:608:167c with SMTP id d9443c01a7336-2c410cd152emr164854215ad.6.1781553072069;
        Mon, 15 Jun 2026 12:51:12 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f2e5644sm113307285ad.4.2026.06.15.12.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 12:51:11 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: Wells Lu <wellslutw@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH net v2 1/2] net: ethernet: sunplus: spl2sw: fix phy_node refcount leak in remove
Date: Tue, 16 Jun 2026 01:20:31 +0530
Message-Id: <f3bdd4c91f3e2269b4e256075f9dc70808b1b8e9.1781552725.git.shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1781552725.git.shitalkumar.gandhi@cambiumnetworks.com>
References: <cover.1781552725.git.shitalkumar.gandhi@cambiumnetworks.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:wellslutw@gmail.com,m:andrew@lunn.ch,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shitalkumar.gandhi@cambiumnetworks.com,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299595-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[shitalgandhi45@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cambiumnetworks.com:mid,cambiumnetworks.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC3C3689970

mac->phy_node is acquired via of_parse_phandle() in spl2sw_probe() and
stored in the mac private data, transferring ownership of the
device_node reference to mac. On driver removal, spl2sw_phy_remove()
disconnects the PHY but never drops that reference, so each
probe-then-remove cycle leaks one of_node refcount per port permanently.

Drop the reference after phy_disconnect(). While at it, remove the
redundant inner "if (ndev)" check; comm->ndev[i] was just verified
non-NULL on the line above.

Compile-tested only; no SP7021 hardware available.

Fixes: fd3040b9394c ("net: ethernet: Add driver for Sunplus SP7021")
Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
---
 drivers/net/ethernet/sunplus/spl2sw_phy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sunplus/spl2sw_phy.c b/drivers/net/ethernet/sunplus/spl2sw_phy.c
index 6f899e48f51d..a4889c52e00e 100644
--- a/drivers/net/ethernet/sunplus/spl2sw_phy.c
+++ b/drivers/net/ethernet/sunplus/spl2sw_phy.c
@@ -79,12 +79,14 @@ int spl2sw_phy_connect(struct spl2sw_common *comm)
 void spl2sw_phy_remove(struct spl2sw_common *comm)
 {
 	struct net_device *ndev;
+	struct spl2sw_mac *mac;
 	int i;
 
 	for (i = 0; i < MAX_NETDEV_NUM; i++)
 		if (comm->ndev[i]) {
 			ndev = comm->ndev[i];
-			if (ndev)
-				phy_disconnect(ndev->phydev);
+			mac = netdev_priv(ndev);
+			phy_disconnect(ndev->phydev);
+			of_node_put(mac->phy_node);
 		}
 }
-- 
2.25.1


