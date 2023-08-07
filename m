Return-Path: <netdev+bounces-24832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3BC771E95
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 12:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074732807B0
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 10:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30FDD2E0;
	Mon,  7 Aug 2023 10:44:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2116FD2E1
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 10:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E761AC43395;
	Mon,  7 Aug 2023 10:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691405074;
	bh=1aEnwy11dk3pN/SydIOG65hSjDquKCZDp+SiD8zbnQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n926ZF5dwb3rRENnmVWYSi43D4XT/5Yf6SIDumkXXJZJwT1skSZKCBwBwn6SG3WU3
	 kwfiXMXDshE4VyjGFIOrGJXh/eNN1IjkhvbIfkNZDq2bAwlp8wb8P2jRuJJuMFP8Js
	 eanbfvLDdtGiWFDxWA64lcw7hubtCnOpE3sOaL5Wtlgx/6BGvK1Z1X76/9QTU+KYeP
	 slLU+La6nJ08mifpI/vrt+OmYFUGQFRZYfFOGXwFtdmT42iqnp5GdjxwSWtS3OfbxK
	 W6Z0REcYoAiS64C7j/hrtNCTd6EI20FJ77YL5/KKtni7Mi/y0lOISls0ZeMLVV695U
	 TRqG1cjJfzQtA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>,
	Mark Zhang <markzhang@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Raed Salem <raeds@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next 01/14] macsec: add functions to get MACsec real netdevice and check offload
Date: Mon,  7 Aug 2023 13:44:10 +0300
Message-ID: <8ff59de0c55cc6de2ae20a98ee3e70f7aa5a5953.1691403485.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691403485.git.leon@kernel.org>
References: <cover.1691403485.git.leon@kernel.org>
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


