Return-Path: <netdev+bounces-202227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4A3AECCA1
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 14:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58DA918910C0
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 12:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D48214A94;
	Sun, 29 Jun 2025 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="fuioOJEB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DC62AD1C;
	Sun, 29 Jun 2025 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751201222; cv=none; b=rMd/zwQc0iTZbrCtBANDbOWcY4TN3aBNEZwwZZ6oxRind2mhKOMOrKKFGY3BMdwHWve/uoAVDrHby1NOdivwm2Ws29ERK7eKT4lHySG4jL29iv+rFyqm0/OWsikHMEetb0AOAMPYXq+8WB5S67+2L2gojc3jHOZET8Tg8xRteIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751201222; c=relaxed/simple;
	bh=Ip7hnQPOpGF9wXLlvKTRbOv0ZV/zi9h56UqKTQhsm9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGOQEp4Y3JGzGlQDmrnww+Vdc75+D/CQR0VRvm4L+fyKqpMMsSQZckWJ4/QbI+wAk7HVpGbiInrKa4AZqDI3pG0SpzsgGrTwFZUfNNyHm05IL956Idw3U+Ff3LTdDiaG+oLm/SM+iFK+3dc/st4a2ZzXrY7LyHeo4vT43ksQ1lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=fuioOJEB; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id VrHvu4ESL84Z8VrI6uRtOD; Sun, 29 Jun 2025 14:37:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1751200671;
	bh=U2KNLOTVqBb7xYxBtu5LEwvC5LnUw+sbt8wZBMJoIcA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=fuioOJEBsQCPcmq+MwQ6AEShAuXOPl3NcGoVlDv4s7ImHWrmTjLrLSPc1ZXF2yDu3
	 9sajVftQDEdNAik8Y3k0BXIVD82Cnk55/2QaSQ71KtX2ejwFzMd4AB4Sp8LxgA/Uqp
	 a3IgLUVyTEaYj7kLxo0tUuTv4N8ZazjpqFrjQ1IOIKeGx6Ch5O6UuIYSwXx/0+XLkf
	 7SJj2MgiYxSqRFXCxYNO7p54KztMJ/S3sJsU9U3tAXvBaYYVJ2Qw8ORrUE83nQRcKS
	 EGBRLexSqCGsQ58h32S9cxnXbX3I41ovT2gNj9ron0zEhfe44ir5MSLNorKICf58Yv
	 HU1F7dEs5GXOw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 29 Jun 2025 14:37:51 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/2] net: dsa: mv88e6xxx: Use kcalloc()
Date: Sun, 29 Jun 2025 14:35:50 +0200
Message-ID: <2f4fca4ff84950da71e007c9169f18a0272476f3.1751200453.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <46040062161dda211580002f950a6d60433243dc.1751200453.git.christophe.jaillet@wanadoo.fr>
References: <46040062161dda211580002f950a6d60433243dc.1751200453.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kcalloc() instead of hand writing it. This is less verbose.

Also move the initialization of 'count' to save some LoC.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  18652	   5920	     64	  24636	   603c	drivers/net/dsa/mv88e6xxx/devlink.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  18498	   5920	     64	  24482	   5fa2	drivers/net/dsa/mv88e6xxx/devlink.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/net/dsa/mv88e6xxx/devlink.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/devlink.c b/drivers/net/dsa/mv88e6xxx/devlink.c
index aec652e33fc1..da69e0b85879 100644
--- a/drivers/net/dsa/mv88e6xxx/devlink.c
+++ b/drivers/net/dsa/mv88e6xxx/devlink.c
@@ -376,19 +376,14 @@ static int mv88e6xxx_region_atu_snapshot(struct devlink *dl,
 	struct dsa_switch *ds = dsa_devlink_to_ds(dl);
 	struct mv88e6xxx_devlink_atu_entry *table;
 	struct mv88e6xxx_chip *chip = ds->priv;
-	int fid = -1, err = 0, count;
+	int fid = -1, err = 0, count = 0;
 
-	table = kmalloc_array(mv88e6xxx_num_databases(chip),
-			      sizeof(struct mv88e6xxx_devlink_atu_entry),
-			      GFP_KERNEL);
+	table = kcalloc(mv88e6xxx_num_databases(chip),
+			sizeof(struct mv88e6xxx_devlink_atu_entry),
+			GFP_KERNEL);
 	if (!table)
 		return -ENOMEM;
 
-	memset(table, 0, mv88e6xxx_num_databases(chip) *
-	       sizeof(struct mv88e6xxx_devlink_atu_entry));
-
-	count = 0;
-
 	mv88e6xxx_reg_lock(chip);
 
 	while (1) {
-- 
2.50.0


