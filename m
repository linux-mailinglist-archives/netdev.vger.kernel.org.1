Return-Path: <netdev+bounces-35195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 641657A7898
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 12:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF211C20ABF
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 10:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2128015AC4;
	Wed, 20 Sep 2023 10:07:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E4F15AC3
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDCEC433C7;
	Wed, 20 Sep 2023 10:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695204478;
	bh=W9mskMLw14fbfxM2rYmwWGjNyVKja6spum3kDsRFlgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uWPtFpm8bvWxErLdXXvlstAnwm9jJr3Z/pjrsTG990N1K2PtTvshtVM161MtN0DOi
	 gTx7frnR1k0R8h3mCDZOf24qcpGsrvAH6PGlo/7LvsCP+32NPNSu+d6oZcrwN9eZca
	 2T9KW6GVOKBhGX/dFpiFFqexNZRTM0fnAPURnNPzbUmELDpjxyCZuy3YeeviJ1wb0S
	 GZZn01gB3CsRwWAw55By3SF5NxDBf7q6NKe4dlR1CwFN5WT1mnBDtuR2qbLlmTo7dL
	 WKWsdsdlj376Fsb92bsdA+MW/9wo0lL5DqbZ7LXgoeF6QQwKv2UiPuwn9Yx8+HyCnt
	 109QlKyPhd6sQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Or Har-Toov <ohartoov@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	Mark Zhang <markzhang@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH rdma-next 2/6] IB/mlx5: Expose XDR speed through MAD
Date: Wed, 20 Sep 2023 13:07:41 +0300
Message-ID: <d30bdec2a66a8a2edd1d84ee61453c58cf346b43.1695204156.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695204156.git.leon@kernel.org>
References: <cover.1695204156.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Or Har-Toov <ohartoov@nvidia.com>

Under MAD query port, Report NDR speed when NDR is supported in the port
capability mask.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mad.c | 13 +++++++++++++
 include/rdma/ib_mad.h            |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/mad.c b/drivers/infiniband/hw/mlx5/mad.c
index 8102ef113b7e..0c3c4e64812c 100644
--- a/drivers/infiniband/hw/mlx5/mad.c
+++ b/drivers/infiniband/hw/mlx5/mad.c
@@ -619,6 +619,19 @@ int mlx5_query_mad_ifc_port(struct ib_device *ibdev, u32 port,
 		}
 	}
 
+	/* Check if extended speeds 2 (XDR/...) are supported */
+	if (props->port_cap_flags & IB_PORT_CAP_MASK2_SUP &&
+	    props->port_cap_flags2 & IB_PORT_EXTENDED_SPEEDS2_SUP) {
+		ext_active_speed = (out_mad->data[56] >> 4) & 0x6;
+
+		switch (ext_active_speed) {
+		case 2:
+			if (props->port_cap_flags2 & IB_PORT_LINK_SPEED_XDR_SUP)
+				props->active_speed = IB_SPEED_XDR;
+			break;
+		}
+	}
+
 	/* If reported active speed is QDR, check if is FDR-10 */
 	if (props->active_speed == 4) {
 		if (dev->port_caps[port - 1].ext_port_cap &
diff --git a/include/rdma/ib_mad.h b/include/rdma/ib_mad.h
index 2e3843b761e8..3f1b58d8b4bf 100644
--- a/include/rdma/ib_mad.h
+++ b/include/rdma/ib_mad.h
@@ -277,6 +277,8 @@ enum ib_port_capability_mask2_bits {
 	IB_PORT_LINK_WIDTH_2X_SUP		= 1 << 4,
 	IB_PORT_LINK_SPEED_HDR_SUP		= 1 << 5,
 	IB_PORT_LINK_SPEED_NDR_SUP		= 1 << 10,
+	IB_PORT_EXTENDED_SPEEDS2_SUP            = 1 << 11,
+	IB_PORT_LINK_SPEED_XDR_SUP              = 1 << 12,
 };
 
 #define OPA_CLASS_PORT_INFO_PR_SUPPORT BIT(26)
-- 
2.41.0


