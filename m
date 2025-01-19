Return-Path: <netdev+bounces-159607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB68A15FED
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 03:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E8D1886C73
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C56383A5;
	Sun, 19 Jan 2025 02:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIkQ27bZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBA42BB13
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 02:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737252323; cv=none; b=LNQO4W4UBMSM06zzIrVjCsGxhKmlQRva5W3bZgREQ4kpTGp+wg6PrQXGdNl4J7kRm1T6axpojxhK4ZTLKm6cSk2JoHnBd+2sb6cog+vNfl4LO0musEO1DayDcaKr8E5g6gYJCgwYPyaGWdc4jmAbk0ZSbZS8S4TvOnsrhR9LxFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737252323; c=relaxed/simple;
	bh=8mWEmpWCBlvUXujYpypa47nfhD+KnSA+79aLBtQdwuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0JtlAv15vxFA1L3P3m780DzKwJObsEo4jSeQyezkdKbINH9ywIc5byOnsqjv1Tj7IPBfXcc4CbV+nU+d2h2dv1FsgG8OKBJ+JY/eRe10P+rSruMa6eb0qsTD0gtI4NGIFY9CV4/zv3ftZ0w7W9s88xezPJAortOyYWaMWFBNmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIkQ27bZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E02C4CEE2;
	Sun, 19 Jan 2025 02:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737252322;
	bh=8mWEmpWCBlvUXujYpypa47nfhD+KnSA+79aLBtQdwuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RIkQ27bZO9fWuRw6Ys8W4SC6C/4zIenphJKjoSN/fhkfGu/OwpzDB61rfRP9pR17u
	 FzDbvf/BISNqjlRtM7PpMV2WaO12No9hR/zareKgT8gJsGFbaQymPyMffDwUaVlnxy
	 3LjhDLNqc+9JVj7ANWFmRkA2Nuk85WC6wYwd2+tW6vATalVT/fOgoew7WQ9OQdd3Vs
	 H6D+j0DGh5pTqczPnxtWelwPUKW0PEu0sOuEwfMTtokNkIPtI1fgm61V7vu2CFZEhs
	 p6GwcGBEieABVv7p+ightyKozm3OXXd05VDxriJnMkwVax9lWexPzur+3NSKlQi5Z1
	 j0/JFKTh6zUgA==
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
Subject: [PATCH net-next v2 4/7] eth: bnxt: apply hds_thrs settings correctly
Date: Sat, 18 Jan 2025 18:05:14 -0800
Message-ID: <20250119020518.1962249-5-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119020518.1962249-1-kuba@kernel.org>
References: <20250119020518.1962249-1-kuba@kernel.org>
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


