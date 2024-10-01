Return-Path: <netdev+bounces-130795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EA798B902
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3633E1C227BE
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA421A072D;
	Tue,  1 Oct 2024 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUmujJXM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5B11A071F
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777455; cv=none; b=Ld7jpQf1mUeQEUCnHwcA6KP2ywRZ/+nFhwC/V3MkAeAxJXUjkeRU6AYg7lAQTbZ+YUe17DNRnMD1BpvOfdJfPQQQoLhkLa/CLjdfj7ykZNyrZvC8rX8R+aWo0LYGe/hsjuPsM6GV/1T+iZWqBqZohTCdA2e2OMzr9pBRBC9CtW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777455; c=relaxed/simple;
	bh=Qijv8E/hOs+a3AnRI/m40p7E3/8S4ymdY4/ldhCHa44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M987TiBRwfANnaHePlKpU4vPrsPiI/DTQHgLFWzIMSgA8+6UCnyu4IdO3JvIBUEuzoTr89e4otE7oP+oscpKkBN61AIwkWP2oWHpT5T8BE5GupcZTG+c3CASD4NoO83DpWmuvoZ1MZhoW9BomtQJ7tAiD72BPJaSj2f5FFxtbOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUmujJXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C617C4CEC6;
	Tue,  1 Oct 2024 10:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727777454;
	bh=Qijv8E/hOs+a3AnRI/m40p7E3/8S4ymdY4/ldhCHa44=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MUmujJXMG2Y7ZAaZZ2sMqHCVvZoOPKwYrxxUzF+3SjslGf3ytWz9QPP+f3LDxBgSs
	 j7DDD8yzSoLA+MJBEbHsC7kGIeHeYUAePMTln493NdWOU5W7rtQRLGlEBu6u+fJ5X7
	 plLkD82of0RwHi6hlJOlc7KWSWFGOCaNnOqOHNfj5c9BbdGOBlhMhH93BdjUM72+4o
	 HXe6HGOBuD0i/ztzmNe7gnKJFQ1Q8VDhEIQnetlJntcouUfCWwVTLZiTMoTOtTUNni
	 WVvIe+o9I5MBsL5TapYUL5OKEHxsyx8Pi3svswLu1opB48Ly0OF63ceRKIWvIoXz2I
	 QXPqP70JRt9QQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 01 Oct 2024 12:10:25 +0200
Subject: [PATCH net-next v2 2/2] net: airoha: fix PSE memory configuration
 in airoha_fe_pse_ports_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-airoha-eth-pse-fix-v2-2-9a56cdffd074@kernel.org>
References: <20241001-airoha-eth-pse-fix-v2-0-9a56cdffd074@kernel.org>
In-Reply-To: <20241001-airoha-eth-pse-fix-v2-0-9a56cdffd074@kernel.org>
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

Align PSE memory configuration to vendor SDK. In particular, increase
initial value of PSE reserved memory in airoha_fe_pse_ports_init()
routine by the value used for the second Packet Processor Engine (PPE2)
and do not overwrite the default value.

Introduced by commit 23020f049327 ("net: airoha: Introduce ethernet support
for EN7581 SoC")

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 480540526bdb..2e01abc70c17 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -1172,11 +1172,13 @@ static void airoha_fe_pse_ports_init(struct airoha_eth *eth)
 		[FE_PSE_PORT_GDM4] = 2,
 		[FE_PSE_PORT_CDM5] = 2,
 	};
+	u32 all_rsv;
 	int q;
 
+	all_rsv = airoha_fe_get_pse_all_rsv(eth);
 	/* hw misses PPE2 oq rsv */
-	airoha_fe_set(eth, REG_FE_PSE_BUF_SET,
-		      PSE_RSV_PAGES * pse_port_num_queues[FE_PSE_PORT_PPE2]);
+	all_rsv += PSE_RSV_PAGES * pse_port_num_queues[FE_PSE_PORT_PPE2];
+	airoha_fe_set(eth, REG_FE_PSE_BUF_SET, all_rsv);
 
 	/* CMD1 */
 	for (q = 0; q < pse_port_num_queues[FE_PSE_PORT_CDM1]; q++)

-- 
2.46.2


