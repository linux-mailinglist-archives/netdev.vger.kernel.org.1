Return-Path: <netdev+bounces-157553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895FFA0AB71
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 19:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BD4E7A0F60
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 18:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D3A1BD9CB;
	Sun, 12 Jan 2025 18:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDAXRM3U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D1122083
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736706809; cv=none; b=iDpALUHH+A9imEuvik4dXLo07dwQWBS+WtpCaQow7kAzzMKbQFjhqYi/hOl6W6GnQT27buvGhHd0z1djsdLO6+KqH7cfoSiWAWi/twaP53Hw3Sw46g4vfR5XdF5xGGaEWWa4pIvtDhB63TPGMOHGrcFYbFrCQy5BCNmgNmHzIOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736706809; c=relaxed/simple;
	bh=4WQQaCak4TJuaVWaDAMb3yACSDF7AlTUwq82HMM4tQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uiEEl4vvTjvKIW5rE12M97qWM2RhJ6bl0+PhkkClGyPMbAhZJzqUFQLFGwpWq0DeBMSiRcraChDVrd81rPHyT8/gahuclbFUmSjAEgV/CRbHPo5RSTSN0Xwo1Cbf9fLUlxaYWvBg3R/mU5vKw/FVAdYxCOSOCevn3U28ivxV4Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDAXRM3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA33C4CEDF;
	Sun, 12 Jan 2025 18:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736706807;
	bh=4WQQaCak4TJuaVWaDAMb3yACSDF7AlTUwq82HMM4tQo=;
	h=From:Date:Subject:To:Cc:From;
	b=vDAXRM3US9kpZLqIDfuJztnFopiRf/XL2Z4SjUeicqPbmPgFeZXBiEFWAmR+1dqgz
	 ol7fQN0lR0fA1RIByTY04bp+PH1doZpW/Sh5xeURJco7kvHWizz7dmdkbDMiKEFcqG
	 pwuDNoLMFMTbGJDNThywbLMPW3NLy0Fy0emoLF5LQZv5YeiLBejN4YSRuLBxoy0EbN
	 UeEgJkebg1bWdFTc+pkLhoe489MFibL2m7f3g4g8rfQ0bgcoP92X9C4idZIGI8l0wk
	 T5PxrL3TGDn8YFwUOjf7vAHro5PaKb/eaN9K4tY+qnHyL8zxfGHg5O4bWQY9FuyB3n
	 DBCngiY45Iv3A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 12 Jan 2025 19:32:45 +0100
Subject: [PATCH net-next] net: airoha: Enforce ETS Qdisc priomap
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250112-airoha_ets_priomap-v1-1-fb616de159ba@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMwKhGcC/x3MMQqAMAxA0atIZgs2WBGvIiJBU82gLamIULy7x
 fEN/2dIrMIJhiqD8i1Jwllg6wqWnc6NjazFgA26xlo0JBp2mvlKc1QJB0WDzmHXUtuT91DCqOz
 l+afj9L4fh7NURWQAAAA=
X-Change-ID: 20250112-airoha_ets_priomap-255264a48aff
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Davide Caratti <dcaratti@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

EN7581 SoC supports fixed QoS band priority where WRR queues have lowest
priorities with respect to SP ones.
E.g: WRR0, WRR1, .., WRRm, SP0, SP1, .., SPn

Enforce ETS Qdisc priomap according to the hw capabilities.

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index a30c417d66f2f9b0958fe1dd3829fb9ac530a34c..415d784de741c991fa521243783860dee1ed0bfa 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -2793,7 +2793,7 @@ static int airoha_qdma_set_tx_ets_sched(struct airoha_gdm_port *port,
 	struct tc_ets_qopt_offload_replace_params *p = &opt->replace_params;
 	enum tx_sched_mode mode = TC_SCH_SP;
 	u16 w[AIROHA_NUM_QOS_QUEUES] = {};
-	int i, nstrict = 0;
+	int i, nstrict = 0, nwrr, qidx;
 
 	if (p->bands > AIROHA_NUM_QOS_QUEUES)
 		return -EINVAL;
@@ -2807,7 +2807,20 @@ static int airoha_qdma_set_tx_ets_sched(struct airoha_gdm_port *port,
 	if (nstrict == AIROHA_NUM_QOS_QUEUES - 1)
 		return -EINVAL;
 
-	for (i = 0; i < p->bands - nstrict; i++)
+	/* EN7581 SoC supports fixed QoS band priority where WRR queues have
+	 * lowest priorities with respect to SP ones.
+	 * e.g: WRR0, WRR1, .., WRRm, SP0, SP1, .., SPn
+	 */
+	nwrr = p->bands - nstrict;
+	qidx = nstrict && nwrr ? nstrict : 0;
+	for (i = 1; i <= p->bands; i++) {
+		if (p->priomap[i % AIROHA_NUM_QOS_QUEUES] != qidx)
+			return -EINVAL;
+
+		qidx = i == nwrr ? 0 : qidx + 1;
+	}
+
+	for (i = 0; i < nwrr; i++)
 		w[i] = p->weights[nstrict + i];
 
 	if (!nstrict)

---
base-commit: 7d0da8f862340c5f42f0062b8560b8d0971a6ac4
change-id: 20250112-airoha_ets_priomap-255264a48aff

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


