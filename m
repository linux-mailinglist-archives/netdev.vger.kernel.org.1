Return-Path: <netdev+bounces-168420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE731A3EF9E
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6911656F8
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF476202F65;
	Fri, 21 Feb 2025 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RWpNzL91"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5D61DE896
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128874; cv=none; b=c1s5sOY2O0qmqE2/KGkY/KwEy9Ht/8pN4dvLDEIHUa/J/ipFigeHhGPUt+TqOrw+3qqk7FovtzpBYFOLFx0fh0sFGIJclazwOxy42/ytEZhL8kDkZ4Ya8rz9S9TmqGs776iEWgjYp1HJ2PxKmog7LZlEmUJBnMoMwjE+xPRKXlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128874; c=relaxed/simple;
	bh=ZoewP+I7MPJSYwRR1gmRB8PDPc9ZAqkchO++ck4YW7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b0J5HC7cXAz4thDRZRDwl319UME03GkH27wolp7OhuW2SPi+DgNhV5J2JHLy7K43BMt0VwaDWsuo7+meGDDtTMUrqOgjwr78a2sKmyNYGwiZbeMN/g5SkXLqsHFCnhfPDuWXVunw6q3p+ZpW+BVgP5vwijK3sM3DAhQoEcOZFpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RWpNzL91; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740128860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wprGiDaMDqnJuc56NWAkjn4Xo990TLMpiIEvRYQHvNA=;
	b=RWpNzL91fOV76E4FT0Qg1C1hW03gGljtkq+1rcl4o1rRdp8vAwk2Q3E5EhojRW8NAMhROb
	B4mqaqvylpwrNmXriJqprBcMf3Kg690gJS8tS8Dt/IwPPFWgibki9ZwbfcZjPFL5ccqWZe
	cROndeaTRWEenWJIUJbVqOww26KKyLo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Itamar Gozlan <igozlan@nvidia.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Saeed Mahameed <saeed@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH net-next] net/mlx5: Use secs_to_jiffies() instead of msecs_to_jiffies()
Date: Fri, 21 Feb 2025 09:53:22 +0100
Message-ID: <20250221085350.198024-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use secs_to_jiffies() and simplify the code.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Resend with "net-next" in the title as suggested by Jacob and Saeed.
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 3dbd4efa21a2..19dce1ba512d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -220,7 +220,7 @@ static int hws_bwc_queue_poll(struct mlx5hws_context *ctx,
 			      bool drain)
 {
 	unsigned long timeout = jiffies +
-				msecs_to_jiffies(MLX5HWS_BWC_POLLING_TIMEOUT * MSEC_PER_SEC);
+				secs_to_jiffies(MLX5HWS_BWC_POLLING_TIMEOUT);
 	struct mlx5hws_flow_op_result comp[MLX5HWS_BWC_MATCHER_REHASH_BURST_TH];
 	u16 burst_th = hws_bwc_get_burst_th(ctx, queue_id);
 	bool got_comp = *pending_rules >= burst_th;
-- 
2.48.1


