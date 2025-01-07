Return-Path: <netdev+bounces-156056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BA8A04C32
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 23:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC9B188654E
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6D91AAA1D;
	Tue,  7 Jan 2025 22:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gx3FMrdJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82271A3035
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 22:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736288822; cv=none; b=XZhiaYPBxLiUvOxWeE7zfuFI3fOmu5SLoHdLPFXNXBtvmZWWIohKA8AeGI37v/l+0Du9JwGRKMkb19v/IxDJtMXkyTJXHHKYhXWaNFpj/pFRk9C4WsIa29OCqanfA+yXUQLJyGVopMLsxfcbzznozIANWbaO0NVBHyZZSH9eaYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736288822; c=relaxed/simple;
	bh=/BuvRwLGk+7by7QeOu7n+QgJ5Sk03TO9WCsGbgTs3sE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jHXwJfD+6o5WvM5xaeL35BI6hshOViNtg+mSqf5q8jH9l3k6FctngCkEYdxJzcYaw9aEEigC8/FZiHoPrIXGyJA29kTWkYSjj7rtagL1aSIWPGAuSJaaAUv2Bj8jxUmIlJxb23wTleEv/Pwnz+1oSf3yZ7g46h9gv4RZaU8yySg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gx3FMrdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A57C4CED6;
	Tue,  7 Jan 2025 22:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736288822;
	bh=/BuvRwLGk+7by7QeOu7n+QgJ5Sk03TO9WCsGbgTs3sE=;
	h=From:Date:Subject:To:Cc:From;
	b=Gx3FMrdJH+xaen2jSRnu523A40ZOBBFaj896IwBv1PeosUm+eiUCx+K3Qz9CAisX0
	 Bj4ohheTiHZDQHZelhKF3ZFTfVQUyYiLiard4x5QdylW2YZA0cpwJe64TMf7CsHbrT
	 NHCF7nrJPJUwOhDoS/YVdeTw/bb9DlM95aKGSfyH0cy7Kdmjz55No3Im9bCSKcgyaX
	 Y/lcRZglFjbLyiC3LS06AtM0KOyhUxQKrH+ZWpx5E/sdOEj3SRTJ/I+K8o3m75Kzsn
	 wKRft5pBwfhGEIrJXrFR4f73QwnxJ6eSUrfjYV8k4mFQpH3nB0hKLi2DpvYPim5dj/
	 ADsdcP6QPwokg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 07 Jan 2025 23:26:28 +0100
Subject: [PATCH net-next] net: airoha: Fix channel configuration for ETS
 Qdisc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-airoha-ets-fix-chan-v1-1-97f66ed3a068@kernel.org>
X-B4-Tracking: v=1; b=H4sIABOqfWcC/x2MSwqAMAwFryJZG6ifVvAq4qLUaLNRaUSE0rsbX
 Q5v3mQQSkwCY5Uh0c3Cx67Q1BWE6PeNkBdlaE1rTWMG9JyO6JEuwZUf/CSkzobgw+AW14M+z0S
 6/dVpLuUFNrlCSGUAAAA=
X-Change-ID: 20250107-airoha-ets-fix-chan-e35ccac76d64
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Mark Lee <Mark-MC.Lee@mediatek.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Limit ETS QoS channel to AIROHA_NUM_QOS_CHANNELS in
airoha_tc_setup_qdisc_ets() in order to align the configured channel to
the value set in airoha_dev_select_queue().

Fixes: 20bf7d07c956 ("net: airoha: Add sched ETS offload support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index b9f1c42f0a40ca268506b4595dfa1902a15be26c..a30c417d66f2f9b0958fe1dd3829fb9ac530a34c 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -2840,11 +2840,14 @@ static int airoha_qdma_get_tx_ets_stats(struct airoha_gdm_port *port,
 static int airoha_tc_setup_qdisc_ets(struct airoha_gdm_port *port,
 				     struct tc_ets_qopt_offload *opt)
 {
-	int channel = TC_H_MAJ(opt->handle) >> 16;
+	int channel;
 
 	if (opt->parent == TC_H_ROOT)
 		return -EINVAL;
 
+	channel = TC_H_MAJ(opt->handle) >> 16;
+	channel = channel % AIROHA_NUM_QOS_CHANNELS;
+
 	switch (opt->command) {
 	case TC_ETS_REPLACE:
 		return airoha_qdma_set_tx_ets_sched(port, channel, opt);

---
base-commit: a1942da8a38717ddd9b4c132f59e1657c85c1432
change-id: 20250107-airoha-ets-fix-chan-e35ccac76d64

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


