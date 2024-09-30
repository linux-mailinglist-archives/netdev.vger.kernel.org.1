Return-Path: <netdev+bounces-130360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9120A98A296
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 14:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1B37B211FF
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 12:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651A118E755;
	Mon, 30 Sep 2024 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FY50tfti"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DED118BBBC
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699663; cv=none; b=RtB5MMZYZI51rCJmWUgYYYziOslGoYRIrpOWboe6F0KrXSJxoFYpMoAvm3+GN458/QcnIu0CDvBgp6v098ZTIsk+24msClsgAkrCookmS9ZwV19xeXqwzy/+1a+tkpbBn3kCIXeS92nY7DRho8N7Pp70u8iSUyqdkFBjkBWafR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699663; c=relaxed/simple;
	bh=qTB9g6Mdenjq1zRKKss5v3af9DwJHerHGR2vXvjGRHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G5yeTxmuywu9qyWSsGJh0qVciHyDage7bdPJ2NUFlaNZKfZd4ZTcxfmY+MD48Xr325QyxiOJf+xeVEJQ8mluaBndoSRGP8EkMzU3FpqNR7QDfRHQqdkdbLBnv0iPHOZjWI8PXOheD6/DnZPC5wx/Jj4rgwyR3tVLFLMsF5e+BEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FY50tfti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41ECDC4CEC7;
	Mon, 30 Sep 2024 12:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727699662;
	bh=qTB9g6Mdenjq1zRKKss5v3af9DwJHerHGR2vXvjGRHs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FY50tftipJWwI6IGb+PAARkL12B7fochTa2vApQ4msqXoVsKecvwGWQj7sf9jDe15
	 SWZFf7SRc0ySXu4332vsKX9Cu1+jG4J+M8u5m0iCnba/J/ax2jPzsTegKVi2sB/nRd
	 qZDcRtAO1TXh2/TWFkhI71zilIdqJYKwy3Lcwq5Gja/T2PKoHsj28k/qdk+al6OLoh
	 Qw9Gfc+exWLprRRLeegDzqUD1lHJEvvlMeIKV1i9/S1ijiCHKsnixQnk8OX198xEt+
	 FOhfB7uyMRuYR5+SIfW6CqtQBEnbj9jSlE+TcFzz7UHIjTRt6rQwaSaYTlTJIsgFzF
	 rIZWku+q33AkA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 30 Sep 2024 14:33:49 +0200
Subject: [PATCH net-next 2/2] net: airoha: fix PSE memory configuration in
 airoha_fe_pse_ports_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-airoha-eth-pse-fix-v1-2-f41f2f35abb9@kernel.org>
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

Align PSE memory configuration to vendor SDK. In particular, increase
initial value of PSE reserved memory in airoha_fe_pse_ports_init()
routine by the value used for the second Packet Processor Engine (PPE2)
and do not overwrite the default value.

commit 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
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


