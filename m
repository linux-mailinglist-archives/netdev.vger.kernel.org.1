Return-Path: <netdev+bounces-21631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83232764137
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4E71C2141E
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F6F198A6;
	Wed, 26 Jul 2023 21:32:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69BE18057
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AEDC43391;
	Wed, 26 Jul 2023 21:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690407132;
	bh=e+NFzb/vGwyizi28fk2u1oGZ2xB+dm+cEO+r1x7fHDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJevch76t8P8brrHorNjC34pHJw7Fslxiav9OKLiMbKWdcI7P2rpXVIw/qwcBuXZH
	 zCQfGC+AsbxHOKrO8wBGZEA9kz7IL3Mmdas0uaWoqd+RTJ1qpMD6n1PZg268430dW9
	 xqa3z3JrspNCKCraqCfJ80iZPV1c40Rge+zQK8QeMaFZBLiAxYS3Ffk3vjh3GqPGOz
	 d23P/mHvJd8/RqptXg+Cf6NMAg227/Ho1Nwqvk2I/XFZ0UYvxCuFV6jQ0JylHGBRr/
	 2OzovZBYBmsAxadB04CTcsjGgxCwaKjHSapdq0lg2q2IdWZdWmNLUdsDkOt2FfGUQb
	 IRGu+GxP7h+Rg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Yuanjun Gong <ruc_gongyuanjun@163.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net 04/15] net/mlx5e: fix return value check in mlx5e_ipsec_remove_trailer()
Date: Wed, 26 Jul 2023 14:31:55 -0700
Message-ID: <20230726213206.47022-5-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726213206.47022-1-saeed@kernel.org>
References: <20230726213206.47022-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuanjun Gong <ruc_gongyuanjun@163.com>

mlx5e_ipsec_remove_trailer() should return an error code if function
pskb_trim() returns an unexpected value.

Fixes: 2ac9cfe78223 ("net/mlx5e: IPSec, Add Innova IPSec offload TX data path")
Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
index eab5bc718771..8d995e304869 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
@@ -58,7 +58,9 @@ static int mlx5e_ipsec_remove_trailer(struct sk_buff *skb, struct xfrm_state *x)
 
 	trailer_len = alen + plen + 2;
 
-	pskb_trim(skb, skb->len - trailer_len);
+	ret = pskb_trim(skb, skb->len - trailer_len);
+	if (unlikely(ret))
+		return ret;
 	if (skb->protocol == htons(ETH_P_IP)) {
 		ipv4hdr->tot_len = htons(ntohs(ipv4hdr->tot_len) - trailer_len);
 		ip_send_check(ipv4hdr);
-- 
2.41.0


