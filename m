Return-Path: <netdev+bounces-70753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E78085040B
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 11:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF32B281349
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 10:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCC2364C7;
	Sat, 10 Feb 2024 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UveCnvEH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6986D364BD
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707562425; cv=none; b=iJ6TLHBDx7jRKaFUPkcF9n2NuyNepWqQhWvp6pZxkcDUtgtb1Zh+lSW55Bu69dzc9rqrb5nJpRz+HtzFfVD0ue5b6g0AmjUESg2N1wtlkAwjLpfiA9+dhAvQZ+pybqnJOEM3V9j3PkoGLjNBn798Lz6T5OMoWiTV0yt03oQrTZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707562425; c=relaxed/simple;
	bh=ZNR0Ya2GtQ55/jW9CFZk6ueuv1ZGLDunwSJubLSmEUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OBBNJxa602EmJng1NvYCt2HgHU4Sb6vxSvq72rvXA7OgZt1lQ/XG1LN+AM3oaKvoX2qXaNUtpJ+gKIN51t2hM7aVeRgIDgecrPE8Zzi/KdrekhkbVp+elTKLdwQEqoT029s2QClRdwCeBdUCD+NqAyf49H3lq7Je3ntMLoQ6tII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=UveCnvEH; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id YkzGrWWZFCB5QYkzGrUBap; Sat, 10 Feb 2024 11:53:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1707562416;
	bh=7QYgDN3BJUEnPT+SJRI8j4ug6VUW8Hkqd9k+/x2jDfQ=;
	h=From:To:Cc:Subject:Date;
	b=UveCnvEHrvJuAAmeSuiaUhwqL3TLTowduXR5o9CGK3lhSCyJF+uEzXZgaNP3nfSWw
	 8yTxdu8msgcHsVkmmtZfscQHT6SVI2QUJEQOCv8o24MDL/up9c8pZCqvT0ZiArXL1S
	 tf9VC1ooyex07pt8kLEbxGSIDqv0UOxeIl1wEyywldPXmCP6Z+5sYRqrS/tgLHnkIQ
	 ILJBl7d/07JlGnFZugaxOySNwljPdC07VNS3raJ/81DFeMlpoumlobh0haMvkBtItp
	 oEdcNSer7Kwd4oW4uv2Mm4iE8YuxPQs7No8OXVl3y3uKRbNKNYznQLuIeWtVh95sHL
	 dEA60srFFusVA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 10 Feb 2024 11:53:36 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Eli Cohen <eli@mellanox.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next] net/mlx5: Use kasprintf()
Date: Sat, 10 Feb 2024 11:53:13 +0100
Message-ID: <9bb8d927ec172df227f84694dfa5769623f48c89.1707562340.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kasprintf() instead of open-coding it.
This saves some lines of code, avoid a hard-coded magic number and is more
robust.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
If you consider it as a bug fix, should 'name' overflow because of the
hard-coded limit, then:
Fixes: ac6ea6e81a80 ("net/mlx5_core: Use private health thread for each device")
---
 drivers/net/ethernet/mellanox/mlx5/core/health.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index 8ff6dc9bc803..3f775da15afc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -856,12 +856,11 @@ int mlx5_health_init(struct mlx5_core_dev *dev)
 	mlx5_reporter_vnic_create(dev);
 
 	health = &dev->priv.health;
-	name = kmalloc(64, GFP_KERNEL);
+	name = kasprintf(GFP_KERNEL,
+			 "mlx5_health%s", dev_name(dev->device));
 	if (!name)
 		goto out_err;
 
-	strcpy(name, "mlx5_health");
-	strcat(name, dev_name(dev->device));
 	health->wq = create_singlethread_workqueue(name);
 	kfree(name);
 	if (!health->wq)
-- 
2.43.0


