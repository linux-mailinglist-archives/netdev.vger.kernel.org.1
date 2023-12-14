Return-Path: <netdev+bounces-57159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED75181248E
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F0D1F21A11
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 01:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761CD80D;
	Thu, 14 Dec 2023 01:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYV3bUd8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDB04A0F
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 01:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253C2C433C8;
	Thu, 14 Dec 2023 01:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702517119;
	bh=LVflAZx/WIK3zMfWL57IZA9kE+jQlWYFiquhbLO9sWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BYV3bUd88m0uilfD0Q354Ufpe3dizOTmjjjQ3wev/LrRB1THfdtP5D8Dz/PbjxXJK
	 gGM17qDKw8uj5X9jsEDb/Tdo2LxY852WBYysdthaY2cIG9fjolPbdbD7SbWHpayevz
	 1QOxNNIMxDkibqIeZfwUerHjgy/YIYvKouMnGTK1EZr3wYJNGQIlRPsmEkrgpJ96eE
	 H+My500j5SnBrL3Yh6z9qiVypDFYiR8lYFbtIe9Ce1ALnwYVgqCQDmdhMu1MlRVomB
	 QcfYXP7I+b4cZP1Hey2PloQyw2l9oyeUdPdu9twMzIM9bL72EiFtwx89Xpx9DLPKDB
	 99hdaUK6k2TGQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Feras Daoud <ferasda@nvidia.com>
Subject: [net 10/15] net/mlx5: Fix fw tracer first block check
Date: Wed, 13 Dec 2023 17:25:00 -0800
Message-ID: <20231214012505.42666-11-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214012505.42666-1-saeed@kernel.org>
References: <20231214012505.42666-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Moshe Shemesh <moshe@nvidia.com>

While handling new traces, to verify it is not the first block being
written, last_timestamp is checked. But instead of checking it is non
zero it is verified to be zero. Fix to verify last_timestamp is not
zero.

Fixes: c71ad41ccb0c ("net/mlx5: FW tracer, events handling")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Feras Daoud <ferasda@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
index 76d27d2ee40c..080e7eab52c7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
@@ -718,7 +718,7 @@ static void mlx5_fw_tracer_handle_traces(struct work_struct *work)
 
 	while (block_timestamp > tracer->last_timestamp) {
 		/* Check block override if it's not the first block */
-		if (!tracer->last_timestamp) {
+		if (tracer->last_timestamp) {
 			u64 *ts_event;
 			/* To avoid block override be the HW in case of buffer
 			 * wraparound, the time stamp of the previous block
-- 
2.43.0


