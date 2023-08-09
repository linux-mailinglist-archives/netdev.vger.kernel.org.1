Return-Path: <netdev+bounces-25737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B18775565
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 10:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BEB1281832
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 08:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3BA13FE1;
	Wed,  9 Aug 2023 08:29:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BCC79E4
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 08:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A92C433B7;
	Wed,  9 Aug 2023 08:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691569786;
	bh=1aEnwy11dk3pN/SydIOG65hSjDquKCZDp+SiD8zbnQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fTGfzcbsaLtciM9Tw4gBdWTRZlGh29jnrZGyHxqySGN23K8HaomV8MTjJLRV13Oj7
	 nUsFjHucemRwhr94dhm/Z7aigBsIEauJea0qYjYeWleaLJ41gFeyn1UaBiaLJz6vya
	 9csQWW6GwYPFUxfU+Chw2waHJhh7f9z601FdoDW8x3gtzI8zJNdszONmBz7eJ7sOJY
	 +AkNJy0mCdLI9fPsCde6uR3XiBqoTeA9MhOE45/gXZdKWF+7opTBYN4tSdKBizwbMA
	 7cIo5BP+qP1oKQa/3ZZ6CGpWmMLB1J8VVnLreojR0GGJbCrHZqQ2iSiiVa5TNUlAt2
	 eEJHhRquL/K5A==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>,
	Mark Zhang <markzhang@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Raed Salem <raeds@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next v1 01/14] macsec: add functions to get macsec real netdevice and check offload
Date: Wed,  9 Aug 2023 11:29:13 +0300
Message-ID: <7f63bb57a0e0d3792e8bd180ad0168d7ffc89b56.1691569414.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691569414.git.leon@kernel.org>
References: <cover.1691569414.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Given a macsec net_device add two functions to return the real net_device
for that device, and check if that macsec device is offloaded or not.

This is needed for auxiliary drivers that implement MACsec offload, but
have flows which are triggered over the macsec net_device, this allows
the drivers in such cases to verify if the device is offloaded or not,
and to access the real device of that macsec device, which would
belong to the driver, and would be needed for the offload procedure.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Raed Salem <raeds@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/macsec.c | 15 +++++++++++++++
 include/net/macsec.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 984dfa5d6c11..ffc421d2de16 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -4240,6 +4240,21 @@ static struct net *macsec_get_link_net(const struct net_device *dev)
 	return dev_net(macsec_priv(dev)->real_dev);
 }
 
+struct net_device *macsec_get_real_dev(const struct net_device *dev)
+{
+	return macsec_priv(dev)->real_dev;
+}
+EXPORT_SYMBOL_GPL(macsec_get_real_dev);
+
+bool macsec_netdev_is_offloaded(struct net_device *dev)
+{
+	if (!dev)
+		return false;
+
+	return macsec_is_offloaded(macsec_priv(dev));
+}
+EXPORT_SYMBOL_GPL(macsec_netdev_is_offloaded);
+
 static size_t macsec_get_size(const struct net_device *dev)
 {
 	return  nla_total_size_64bit(8) + /* IFLA_MACSEC_SCI */
diff --git a/include/net/macsec.h b/include/net/macsec.h
index 441ed8fd4b5f..75a6f4863c83 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -312,6 +312,8 @@ static inline bool macsec_send_sci(const struct macsec_secy *secy)
 	return tx_sc->send_sci ||
 		(secy->n_rx_sc > 1 && !tx_sc->end_station && !tx_sc->scb);
 }
+struct net_device *macsec_get_real_dev(const struct net_device *dev);
+bool macsec_netdev_is_offloaded(struct net_device *dev);
 
 static inline void *macsec_netdev_priv(const struct net_device *dev)
 {
-- 
2.41.0


