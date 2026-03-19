Return-Path: <netdev+bounces-269238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELCFKGxJu2kliQIAu9opvQ
	(envelope-from <netdev+bounces-269238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:55:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A968C2C43C1
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A571A3006098
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D969253340;
	Thu, 19 Mar 2026 00:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNBM+6hc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAC621B192
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 00:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773881703; cv=none; b=bW/Z8ixrNfcVMkBs2zxfYNMOjFJV7B8wO589w7oez1VVvzB2p8/iKEvGFCwd1YcAwzM3hqjxlPOqZSfKhp+17mDPmzsESdUYM17a8RgBSiZ2heKKlUWM5POE14U5Q62Ufm3P14foltQqqm2ZGfwwO6/W0Y2KzZ8EEak7PNpVvsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773881703; c=relaxed/simple;
	bh=sExwXgMTZunZe2MKWt6bZpV4yZ18mELdStapDHpe4+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=spE/nQbeK2MxrmcgWDM4f3GE+rUqChywQUXKz1mKYOfh02T5MdvqM3mckkjDiW4xymEoaGEwIo+2Ht+Ml9MKweroVRV2v3zwDZqMEZ1ZL/CLGuGi1ozn7UIRGXO732GupC73XFGxWNqBLlHcN4XqTtR7p7IA7iZ5t0hh5TpziBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNBM+6hc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A9EC19421;
	Thu, 19 Mar 2026 00:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773881703;
	bh=sExwXgMTZunZe2MKWt6bZpV4yZ18mELdStapDHpe4+8=;
	h=From:To:Cc:Subject:Date:From;
	b=fNBM+6hcIx3TRzP1SjmBjU74qUfdqcWUjGg6bmAWKaR7iXqUW+n1qmMp/hsMQjIKm
	 +MWhHYzjxnkGiAIHqRkCYer1xLJpwDzqalZylkbjSu0KHzejYoFlRfzE+UUNAvNwuK
	 DpJFJQAJ59VkONOZ7UU6MwKnLnWFGJgrRjpdmOPBPJBSFpwodK4mpCQNhhXGN6zMjM
	 Tv9TezKEMiYLnMSVwjNt3CVX2J0GSy1Cwj4d2tRIYSpcK5339sGd8z+Q3/lBksAubO
	 155NFLtLiBnb2WqI2IomUJDlNfHdBCx+XgtDxwu35ejo7MNIkCK5yxlbvWpiVMCDeA
	 9aABcA+X1DFVw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next V2] net/mlx5e: Allow set_rx_mode on uplink representor
Date: Wed, 18 Mar 2026 17:54:56 -0700
Message-ID: <20260319005456.82745-1-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269238-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[saeed@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.972];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A968C2C43C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Saeed Mahameed <saeedm@nvidia.com>

set_rx_mode handler was skipped on uplink representor, since uplink
relies on FDB to forward all traffic to it by default, which works
perfectly on a single PF per physical port configuration, as explicit
mac request isn't required, but In case of multi-host and DPU
environments, uplink can only use own mac address, as set_rx_mode
wasn't honored in uplink rep.

Since MPFs (Multi PF switch) requires PFs to request explicit mac
forwarding, this patch enables set_rx_mode on uplink representor to
allow PF mac programming into MPFs table in switchdev mode, allowing
use-cases such as arbitrary mac address forwarding via linux bridge.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 - Improve title and commit message -- Kuba.
   v[1]: https://lore.kernel.org/netdev/20260310104841.1862380-1-tariqt@nvidia.com/

 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c   | 10 ++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |  3 ---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c  |  2 ++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
index 9352e2183312..d7556d611155 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -823,8 +823,14 @@ static void mlx5e_destroy_promisc_table(struct mlx5e_flow_steering *fs)
 void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
 			       struct net_device *netdev)
 {
+	struct mlx5e_priv *priv = netdev_priv(netdev);
 	struct mlx5e_l2_table *ea = &fs->l2;
 
+	if (mlx5e_is_uplink_rep(priv)) {
+		mlx5e_handle_netdev_addr(fs, netdev);
+		goto update_vport_context;
+	}
+
 	bool rx_mode_enable  = fs->state_destroy;
 	bool promisc_enabled   = rx_mode_enable && (netdev->flags & IFF_PROMISC);
 	bool allmulti_enabled  = rx_mode_enable && (netdev->flags & IFF_ALLMULTI);
@@ -864,6 +870,7 @@ void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
 	ea->allmulti_enabled  = allmulti_enabled;
 	ea->broadcast_enabled = broadcast_enabled;
 
+update_vport_context:
 	mlx5e_vport_context_update(fs, netdev);
 }
 
@@ -984,6 +991,9 @@ static int mlx5e_add_l2_flow_rule(struct mlx5e_flow_steering *fs,
 	u8 *mc_dmac;
 	u8 *mv_dmac;
 
+	if (!ft)
+		return -EINVAL;
+
 	spec = kvzalloc_obj(*spec);
 	if (!spec)
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index f7009da94f0b..3eebdf402129 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4102,9 +4102,6 @@ mlx5e_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats)
 
 static void mlx5e_nic_set_rx_mode(struct mlx5e_priv *priv)
 {
-	if (mlx5e_is_uplink_rep(priv))
-		return; /* no rx mode for uplink rep */
-
 	queue_work(priv->wq, &priv->set_rx_mode_work);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 1db4ecb2356f..8992f0f7a870 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -1369,6 +1369,8 @@ static void mlx5e_uplink_rep_disable(struct mlx5e_priv *priv)
 	netdev_unlock(priv->netdev);
 	rtnl_unlock();
 
+	/* clean-up uplink's mpfs mac table */
+	queue_work(priv->wq, &priv->set_rx_mode_work);
 	mlx5e_rep_bridge_cleanup(priv);
 	mlx5e_dcbnl_delete_app(priv);
 	mlx5_notifier_unregister(mdev, &priv->events_nb);
-- 
2.43.0


