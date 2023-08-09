Return-Path: <netdev+bounces-25738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A583775566
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 10:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7432281AF7
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 08:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534EC14267;
	Wed,  9 Aug 2023 08:29:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DB6883E
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 08:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468EDC433CB;
	Wed,  9 Aug 2023 08:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691569787;
	bh=1aEnwy11dk3pN/SydIOG65hSjDquKCZDp+SiD8zbnQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RmaUhPSUKQ505bvwgyWxUt7krxnhU+eD5Hr9TGUA/nkD6JObPUHM4RCvD3SM2nXDg
	 3AHXEs3B5W1pJHx3/P/O3XDtHS9C+g9JyDW/ZoTeoujG8FVSPMwvE5AUqSJsrIW2vp
	 srwewucZnsaYklzUcPYsZNiWqu84l4cpALmDPmxj1bh3uFNTO//MWHEUsTvyRzj1Qk
	 mQi11NlFFYd4EpYg2ZblJhra9lztLBUs/lT/9nFy4GPUdtfcQmNyZWxMGCXc87PwGE
	 qBcqZn4MFk/KjELdRFZJDeH1tfAf/TiFH5xhzLqTWb+RU8j/m3TKVLzL9rIvWmxxtc
	 Z0LKiYsQ8zJ1w==
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


