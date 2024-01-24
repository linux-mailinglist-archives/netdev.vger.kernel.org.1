Return-Path: <netdev+bounces-65360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6238083A3EE
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17CD41F2CF3D
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 08:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CBE17571;
	Wed, 24 Jan 2024 08:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgoE5ARn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F08917589
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 08:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084346; cv=none; b=mj7PlFYRehwVurS0uFASpBgib1tvB5J6iWUaD+Xy3rMPK1urpWP5uHK7JH+oGl7+81IacyFN8HS88JmAwuftFNyUkcMkuJ/Cji4Llzo7CZ+1AfBtJhW60PVefC0RCmnPpSw5SFP4710yGfCU0RbxkcZlmFWRise/PH8yOzc8RZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084346; c=relaxed/simple;
	bh=KLeF6Ff/3eFjKTN5iyOtyNgVUuqo8zcjymMJ4X8MiAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXXXyDsAo9+9WEiiahiQjyWr99BnBeSqLEfjB8kAsW60ohUzBKU0WWOnxFsHnFLHxVgjeTtu/1GDNwOBxgcrlUgX6ep1Jg5EzYG/g1cR6+WMH6E2MURJE2fFIOeRFpjRr48a5nQA7jcnEbPHkxsiLxuq0qL+0sn3lh4uLQuN/wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgoE5ARn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373C6C433F1;
	Wed, 24 Jan 2024 08:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706084346;
	bh=KLeF6Ff/3eFjKTN5iyOtyNgVUuqo8zcjymMJ4X8MiAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JgoE5ARn4g8sN5jUaAANVm+NieCSzDblIUqCjxuKOrafwzhE2NDuf5rzXY3GeEVdr
	 sD/EcOqZ4lg6jjVnm1DbLfnAkQvZDScB82W4YbtVbkDp0U9mXb9XORTx954U8BM3+N
	 tY9pZ85eshbhCuKa3vU1hqy2iXSAV+BLeeceaYHf0/rfwLYBkZn1S8v8Y8ndkkwNFR
	 1DAio9kXGPVrrY2Wz+ZTdXHISPCT4HWKb73D95tU6hlGuheIdBBj/aFcocqXDFNCur
	 Nw7kn1NLQ8kaf+Z+T1qBCEhsYpryaItQ2KkbhVNy7lbtRpOF//LD/GtthManQCsLU6
	 kJ6mlElnKMsSg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [net 03/14] net/mlx5e: Fix operation precedence bug in port timestamping napi_poll context
Date: Wed, 24 Jan 2024 00:18:44 -0800
Message-ID: <20240124081855.115410-4-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124081855.115410-1-saeed@kernel.org>
References: <20240124081855.115410-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Indirection (*) is of lower precedence than postfix increment (++). Logic
in napi_poll context would cause an out-of-bound read by first increment
the pointer address by byte address space and then dereference the value.
Rather, the intended logic was to dereference first and then increment the
underlying value.

Fixes: 92214be5979c ("net/mlx5e: Update doorbell for port timestamping CQ before the software counter")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index c206cc0a8483..078f56a3cbb2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -213,7 +213,7 @@ static void mlx5e_ptp_handle_ts_cqe(struct mlx5e_ptpsq *ptpsq,
 	mlx5e_ptpsq_mark_ts_cqes_undelivered(ptpsq, hwtstamp);
 out:
 	napi_consume_skb(skb, budget);
-	md_buff[*md_buff_sz++] = metadata_id;
+	md_buff[(*md_buff_sz)++] = metadata_id;
 	if (unlikely(mlx5e_ptp_metadata_map_unhealthy(&ptpsq->metadata_map)) &&
 	    !test_and_set_bit(MLX5E_SQ_STATE_RECOVERING, &sq->state))
 		queue_work(ptpsq->txqsq.priv->wq, &ptpsq->report_unhealthy_work);
-- 
2.43.0


