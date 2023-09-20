Return-Path: <netdev+bounces-35198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BB27A789E
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 12:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5988E281C8B
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 10:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF9615AE8;
	Wed, 20 Sep 2023 10:08:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1B415AC3
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3B8C433C7;
	Wed, 20 Sep 2023 10:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695204491;
	bh=EQUlJG44rV9id9Ip0kx1re+czxiANtcpuKWCnMLeOqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/CisvHYBZ98ttIfqJuA2H76sDpjlyu1M+lJf2dta+bFc7nG2+e0vY+DTZJcXgLjY
	 Vn7YWpPlJYKxaaXtVw8XkIn2voCys0kbzZCFkEY7z/L2J7t2gNLIkGHmqDKvG5JmOP
	 BSTDBOF9AQjYN18VrJz/J+wlaTYtbpkfsvaGURIvE6Qltd61f0NWiIcTnNiiiyxQqh
	 TVdbrD0+sCJR3xpxE0liaZxAJQKv0lEfO77GjXQF8IWmjvnU/DDIQhufIahaDEQKC9
	 48j2nQGchRl9jZ/xv2iIqX/eO3CgfW6Jv2tPXWBqALssn3/xgoZHIRfMSpy3M5ESLs
	 3vyNKt6xnnSZA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	Mark Zhang <markzhang@nvidia.com>,
	netdev@vger.kernel.org,
	Or Har-Toov <ohartoov@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH rdma-next 5/6] IB/mlx5: Adjust mlx5 rate mapping to support 800Gb
Date: Wed, 20 Sep 2023 13:07:44 +0300
Message-ID: <301c803d8486b0df8aefad3fb3cc10dc58671985.1695204156.git.leon@kernel.org>
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

From: Patrisious Haddad <phaddad@nvidia.com>

Adjust mlx5 function which maps the speed rate from IB spec values
to internal driver values to be able to handle speeds up to 800Gb.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 9261df5328a4..c047c5d66737 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3438,7 +3438,7 @@ static int ib_rate_to_mlx5(struct mlx5_ib_dev *dev, u8 rate)
 	if (rate == IB_RATE_PORT_CURRENT)
 		return 0;
 
-	if (rate < IB_RATE_2_5_GBPS || rate > IB_RATE_600_GBPS)
+	if (rate < IB_RATE_2_5_GBPS || rate > IB_RATE_800_GBPS)
 		return -EINVAL;
 
 	stat_rate_support = MLX5_CAP_GEN(dev->mdev, stat_rate_support);
-- 
2.41.0


