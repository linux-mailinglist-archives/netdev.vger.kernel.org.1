Return-Path: <netdev+bounces-18926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB1275918B
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F350C280C69
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F23111BD;
	Wed, 19 Jul 2023 09:27:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDD811C8E
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 09:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56E8C433C7;
	Wed, 19 Jul 2023 09:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689758833;
	bh=6AUzRCLriIH0XtCY01yuj/EF++iv7MFr0dLo9A/gPnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WcVFyUp7gQXt8V+xMlAEAQOnPdRITzrD7+CpzpqH4GpjHCi6LxrcWl6oNQxtstIaz
	 POcx0yQQRH+hSr2HMGgsM9zhdraK6xcoUAFXpfoNMJsL6nJLcR3Glq893R5pVmLu41
	 JftdfBwXBsFNBVuILidvMkPboJiGBZ8UnAGpxPc1kvT8HAa7U/tCC9rdJf6CMcb7lP
	 uqTpmIpO11VrV50ihvdb80bCXer9VNV229/Xmxsx54V+uBnAX7Z04ZIREo/SmD776E
	 8LeQSk91MtZeP9vpN2F1e7uWIvi7M9gCPsgaO2TkHwAdEWaXGl1qKntOB7r93jQv4e
	 MUPmuYgdyHsRg==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Simon Horman <simon.horman@corigine.com>,
	Ilia Lin <quic_ilial@quicinc.com>
Subject: [PATCH net-next 3/4] net/mlx5e: Support IPsec NAT-T functionality
Date: Wed, 19 Jul 2023 12:26:55 +0300
Message-ID: <d6b7d8aa12f5c89a0abb2e22bc05cd8daee7cc21.1689757619.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689757619.git.leon@kernel.org>
References: <cover.1689757619.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Extend mlx5 IPsec packet offload to support UDP encapsulation
of IPsec ESP packets.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 27 +++++++-
 .../mellanox/mlx5/core/en_accel/ipsec.h       | 11 +++-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 61 ++++++++++++++-----
 3 files changed, 81 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 891d39b4bfd4..658b7d8d50c7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -354,6 +354,12 @@ void mlx5e_ipsec_build_accel_xfrm_attrs(struct mlx5e_ipsec_sa_entry *sa_entry,
 
 	mlx5e_ipsec_init_limits(sa_entry, attrs);
 	mlx5e_ipsec_init_macs(sa_entry, attrs);
+
+	if (x->encap) {
+		attrs->encap = true;
+		attrs->sport = x->encap->encap_sport;
+		attrs->dport = x->encap->encap_dport;
+	}
 }
 
 static int mlx5e_xfrm_validate_state(struct mlx5_core_dev *mdev,
@@ -387,8 +393,25 @@ static int mlx5e_xfrm_validate_state(struct mlx5_core_dev *mdev,
 		return -EINVAL;
 	}
 	if (x->encap) {
-		NL_SET_ERR_MSG_MOD(extack, "Encapsulated xfrm state may not be offloaded");
-		return -EINVAL;
+		if (!(mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_ESPINUDP)) {
+			NL_SET_ERR_MSG_MOD(extack, "Encapsulation is not supported");
+			return -EINVAL;
+		}
+
+		if (x->encap->encap_type != UDP_ENCAP_ESPINUDP) {
+			NL_SET_ERR_MSG_MOD(extack, "Encapsulation other than UDP is not supported");
+			return -EINVAL;
+		}
+
+		if (x->xso.type != XFRM_DEV_OFFLOAD_PACKET) {
+			NL_SET_ERR_MSG_MOD(extack, "Encapsulation is supported in packet offload mode only");
+			return -EINVAL;
+		}
+
+		if (x->props.mode != XFRM_MODE_TRANSPORT) {
+			NL_SET_ERR_MSG_MOD(extack, "Encapsulation is supported in transport mode only");
+			return -EINVAL;
+		}
 	}
 	if (!x->aead) {
 		NL_SET_ERR_MSG_MOD(extack, "Cannot offload xfrm states without aead");
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index b382b0cad7f6..7a7047263618 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -94,13 +94,20 @@ struct mlx5_accel_esp_xfrm_attrs {
 	u8 dir : 2;
 	u8 type : 2;
 	u8 drop : 1;
+	u8 encap : 1;
 	u8 family;
 	struct mlx5_replay_esn replay_esn;
 	u32 authsize;
 	u32 reqid;
 	struct mlx5_ipsec_lft lft;
-	u8 smac[ETH_ALEN];
-	u8 dmac[ETH_ALEN];
+	union {
+		u8 smac[ETH_ALEN];
+		__be16 sport;
+	};
+	union {
+		u8 dmac[ETH_ALEN];
+		__be16 dport;
+	};
 };
 
 enum mlx5_ipsec_cap {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index dbe87bf89c0d..47baf983147f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -951,37 +951,70 @@ setup_pkt_tunnel_reformat(struct mlx5_core_dev *mdev,
 	return -EINVAL;
 }
 
+static int get_reformat_type(struct mlx5_accel_esp_xfrm_attrs *attrs)
+{
+	switch (attrs->dir) {
+	case XFRM_DEV_OFFLOAD_IN:
+		if (attrs->encap)
+			return MLX5_REFORMAT_TYPE_DEL_ESP_TRANSPORT_OVER_UDP;
+		return MLX5_REFORMAT_TYPE_DEL_ESP_TRANSPORT;
+	case XFRM_DEV_OFFLOAD_OUT:
+		if (attrs->family == AF_INET) {
+			if (attrs->encap)
+				return MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_OVER_UDPV4;
+			return MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_OVER_IPV4;
+		}
+
+		if (attrs->encap)
+			return MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_OVER_UDPV6;
+		return MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_OVER_IPV6;
+	default:
+		WARN_ON(true);
+	}
+
+	return -EINVAL;
+}
+
 static int
 setup_pkt_transport_reformat(struct mlx5_accel_esp_xfrm_attrs *attrs,
 			     struct mlx5_pkt_reformat_params *reformat_params)
 {
-	u8 *reformatbf;
+	struct udphdr *udphdr;
+	char *reformatbf;
+	size_t bfflen;
 	__be32 spi;
+	void *hdr;
+
+	reformat_params->type = get_reformat_type(attrs);
+	if (reformat_params->type < 0)
+		return reformat_params->type;
 
 	switch (attrs->dir) {
 	case XFRM_DEV_OFFLOAD_IN:
-		reformat_params->type = MLX5_REFORMAT_TYPE_DEL_ESP_TRANSPORT;
 		break;
 	case XFRM_DEV_OFFLOAD_OUT:
-		if (attrs->family == AF_INET)
-			reformat_params->type =
-				MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_OVER_IPV4;
-		else
-			reformat_params->type =
-				MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_OVER_IPV6;
-
-		reformatbf = kzalloc(MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_SIZE,
-				     GFP_KERNEL);
+		bfflen = MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_SIZE;
+		if (attrs->encap)
+			bfflen += sizeof(*udphdr);
+
+		reformatbf = kzalloc(bfflen, GFP_KERNEL);
 		if (!reformatbf)
 			return -ENOMEM;
 
+		hdr = reformatbf;
+		if (attrs->encap) {
+			udphdr = (struct udphdr *)reformatbf;
+			udphdr->source = attrs->sport;
+			udphdr->dest = attrs->dport;
+			hdr += sizeof(*udphdr);
+		}
+
 		/* convert to network format */
 		spi = htonl(attrs->spi);
-		memcpy(reformatbf, &spi, sizeof(spi));
+		memcpy(hdr, &spi, sizeof(spi));
 
 		reformat_params->param_0 = attrs->authsize;
-		reformat_params->size =
-			MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_SIZE;
+		reformat_params->size = bfflen;
 		reformat_params->data = reformatbf;
 		break;
 	default:
-- 
2.41.0


