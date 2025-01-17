Return-Path: <netdev+bounces-159449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C95A15856
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 20:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C621C16955A
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F531AAA29;
	Fri, 17 Jan 2025 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itf6+13r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EF91AAA0D
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737143300; cv=none; b=AKUMr3LVKRZQ76khm/gTkWb8gx+g0+j/h60rJ2ERuhowTWzxrj2dYlauiUgm/QjZXK1EYt7p24UlLJF6oOjZ2SsF3i6wGzqo3XPeBxGCZkSvUYZRbkM06tBz7HT5r+nEK7hBbXOWjf/OzJHe0yphyt37KgEP/U+KSdYK2ywgTEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737143300; c=relaxed/simple;
	bh=8mWEmpWCBlvUXujYpypa47nfhD+KnSA+79aLBtQdwuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RO2Sf4IFwzkmmWldcDY8EUCB2OPxZHs0y6lslbBJ4BflIM8GERUR9QLImPV1WxKzEsydxYZcdwFomeTm0GYohU1D5mYfH8p9AFjRLQojIFyo6Nu2SUSICFgIQ625PWra0ryhjIMDaAn74FiJjO+xKlNVHyN8iUjJh0NI/yRMyOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itf6+13r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF26C4CEDF;
	Fri, 17 Jan 2025 19:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737143300;
	bh=8mWEmpWCBlvUXujYpypa47nfhD+KnSA+79aLBtQdwuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=itf6+13rTbEduZ/G+HFTUn80XTGjnDtLyTRo+c5gRUp4pHq60kpkq+ASCpULoNX5D
	 qV4VNJwkm9bT7l4+hapCTFuBFbSauHUPjf3R5FqI7dYyqDnwW3q4cshZvqXcxLPUf+
	 zGh5JnBfSOE8Chxd4AkS7iEi1T+f/BCzOO/vp15I8e57LafsFwESsXHbGRnTk8x+Hx
	 buCJ4OG1X7VDY5/Mm9sjH/RRa3PSFnZqi3mPsmEXZSCb/11BxMtwVjMM0FpwMjFZa2
	 7Y+DKv1EPFdm7ivVeY3Uql8bc5nqjPYgcI5xHdJAi9PZQbWP6fy1vek1uaPOL9TiA3
	 3pj4LIF48fIZA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ap420073@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/6] eth: bnxt: apply hds_thrs settings correctly
Date: Fri, 17 Jan 2025 11:48:12 -0800
Message-ID: <20250117194815.1514410-4-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250117194815.1514410-1-kuba@kernel.org>
References: <20250117194815.1514410-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the pending config for hds_thrs. Core will only update the "current"
one after we return success. Without this change 2 reconfigs would be
required for the setting to reach the device.

Fixes: 6b43673a25c3 ("bnxt_en: add support for hds-thresh ethtool command")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0998b20578b4..2eeed4c11b64 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6585,7 +6585,7 @@ static void bnxt_hwrm_update_rss_hash_cfg(struct bnxt *bp)
 
 static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 {
-	u16 hds_thresh = (u16)bp->dev->cfg->hds_thresh;
+	u16 hds_thresh = (u16)bp->dev->cfg_pending->hds_thresh;
 	struct hwrm_vnic_plcmodes_cfg_input *req;
 	int rc;
 
-- 
2.48.1


