Return-Path: <netdev+bounces-130359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F5298A295
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 14:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2F11C229F0
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 12:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AA018E361;
	Mon, 30 Sep 2024 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyfpVD7i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5D018E357
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699660; cv=none; b=Z9w8ep+MhdBqRGKiWvuDcM/FsVMHPSgU7IoywmM5s14LUuEQXedWaNL4z/viALte+1WRHStFwSH+2TDQKf4Pa5kWO07jydDryiGcq75TbxVLvwcdTbVf93K/a5WyMI2BGtRN1gjqn/MaGZe9G/Ag1pJe3q2n5Azc64ujkybDvs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699660; c=relaxed/simple;
	bh=Z/4YAYam6JnULP3t1IK5jI6tEWcPLOHTYHfr4Vko5D8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nJY2mHrhmR97b5sfT3uoupRcWSJDIJZSQub0zqSupDKSd+bjZpUs9pLHv9J8nrKuuKebCpvLCxcr801qDF0iE2WWcSEbCUFrAJudD2HnUogjQ0zWzN5AEebrBHpDWJp27WR0H3jiumWchzQcp3STlgRgSnlCAVLsqW7NOCu9F/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyfpVD7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC11FC4CEC7;
	Mon, 30 Sep 2024 12:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727699660;
	bh=Z/4YAYam6JnULP3t1IK5jI6tEWcPLOHTYHfr4Vko5D8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GyfpVD7ieTL/0P/lAUCh6H8l6dIZfCYFefix1Vw/fkB2v0GkvRdaVpYMY4MZA6/EM
	 7zf9P8nTL9cqZfdea7b2zecl9v2q3x/WykpCJYyJYwkSn2C4ZTKlG5QiPBjIN9bBA/
	 3YJrGFvfI5PV+LH9egc0Lhsk4jwiBnRma+jUAVff/kUz9+nkq9BFMXvxNedAup2pGE
	 TYpquaOyALB6lgtTrP4PGgZc4aySyz+UWcLtZnRgM+OkmDCiKGfBnqXzyWgdMHU3RP
	 gxB2gRgXH19loPhp3QvRPBKMyixV5XraWQR/LpOACGNJbMRhb/K+lb24XOcaimHYzZ
	 XaKmVpCJmGPiw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 30 Sep 2024 14:33:48 +0200
Subject: [PATCH net-next 1/2] net: airoha: read default PSE reserved pages
 value before updating
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-airoha-eth-pse-fix-v1-1-f41f2f35abb9@kernel.org>
References: <20240930-airoha-eth-pse-fix-v1-0-f41f2f35abb9@kernel.org>
In-Reply-To: <20240930-airoha-eth-pse-fix-v1-0-f41f2f35abb9@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
 Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, upstream@airoha.com
X-Mailer: b4 0.14.1

Store the default value for the number of PSE reserved pages in orig_val
at the beginning of airoha_fe_set_pse_oq_rsv routine, before updating it
with airoha_fe_set_pse_queue_rsv_pages().
Introduce airoha_fe_get_pse_all_rsv utility routine.

commit 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 930f180688e5..480540526bdb 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -1116,17 +1116,23 @@ static void airoha_fe_set_pse_queue_rsv_pages(struct airoha_eth *eth,
 		      PSE_CFG_WR_EN_MASK | PSE_CFG_OQRSV_SEL_MASK);
 }
 
+static u32 airoha_fe_get_pse_all_rsv(struct airoha_eth *eth)
+{
+	u32 val = airoha_fe_rr(eth, REG_FE_PSE_BUF_SET);
+
+	return FIELD_GET(PSE_ALLRSV_MASK, val);
+}
+
 static int airoha_fe_set_pse_oq_rsv(struct airoha_eth *eth,
 				    u32 port, u32 queue, u32 val)
 {
-	u32 orig_val, tmp, all_rsv, fq_limit;
+	u32 orig_val = airoha_fe_get_pse_queue_rsv_pages(eth, port, queue);
+	u32 tmp, all_rsv, fq_limit;
 
 	airoha_fe_set_pse_queue_rsv_pages(eth, port, queue, val);
 
 	/* modify all rsv */
-	orig_val = airoha_fe_get_pse_queue_rsv_pages(eth, port, queue);
-	tmp = airoha_fe_rr(eth, REG_FE_PSE_BUF_SET);
-	all_rsv = FIELD_GET(PSE_ALLRSV_MASK, tmp);
+	all_rsv = airoha_fe_get_pse_all_rsv(eth);
 	all_rsv += (val - orig_val);
 	airoha_fe_rmw(eth, REG_FE_PSE_BUF_SET, PSE_ALLRSV_MASK,
 		      FIELD_PREP(PSE_ALLRSV_MASK, all_rsv));

-- 
2.46.2


