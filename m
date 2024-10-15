Return-Path: <netdev+bounces-135602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ED499E533
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723C81C23A5E
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30C21E571A;
	Tue, 15 Oct 2024 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="murZkFD/"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76B51E32AF;
	Tue, 15 Oct 2024 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990595; cv=none; b=gzrPbViXOEXxdf76RKpsnWXlDerkSqgswVczWVGxXCoaRk3Jl1nxX9PCx9ZOPH+XG0z3FGVUiBWalIhUthTcu7uQZfMhOThnHbwWysuQzCJ4jk0rqr5M5rjoBeAI9Tf33Xz73ke9N4VpAzEy4qr4AFo6mGVABBGvgA6F4htqKvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990595; c=relaxed/simple;
	bh=u/ZF658jnh35jb/jImoWHb8+tweptTkbxHIN0BLRg/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o6uKuf+hLkY4pRwux6KAas/Cr6c4lSdorwE7UjqpS6t0f4G75x8OE4riHrBnxA5xyfcVtyowL3MMgKfuKD0R6HR6tJuzHoZTcOGVZFPCdhON/FRzl6iq5XfHaYE+b+wOwKlfKrwi4wmWgZ3spcWzbPr/7uPXC0SN4sJtPKRWUl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=murZkFD/; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=00J3RVPq4/h4Gn9zjAJgxg9MqOXs2BDYFaepZNulNug=; b=murZkFD/6e9FjDuEIp5PZR/1bR
	LzkxMjmNagb5GYM9dLk9SPNm82n01g+KRK4q1pS/kxvZtPVk6yOcwEi11P8OhLOpqvt7eINvvQITQ
	k3/q7lK4AqPOn78czVrT/yEXLrfQZPESdR/piJAnS3FouSWuV2BccVYUtUouh8Cz5leM=;
Received: from p54ae9bfc.dip0.t-ipconnect.de ([84.174.155.252] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1t0fQr-0096bC-0o;
	Tue, 15 Oct 2024 13:09:41 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next 1/4] net: ethernet: mtk_eth_soc: compile out netsys v2+ code on mt7621
Date: Tue, 15 Oct 2024 13:09:35 +0200
Message-ID: <20241015110940.63702-1-nbd@nbd.name>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid some branches in the hot path on low-end devices with limited CPU power,
and reduce code size

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 0d5225f1d3ee..654897141869 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -1324,16 +1324,22 @@ extern const struct of_device_id of_mtk_match[];
 
 static inline bool mtk_is_netsys_v1(struct mtk_eth *eth)
 {
+	if (IS_ENABLED(CONFIG_SOC_MT7621))
+		return true;
 	return eth->soc->version == 1;
 }
 
 static inline bool mtk_is_netsys_v2_or_greater(struct mtk_eth *eth)
 {
+	if (IS_ENABLED(CONFIG_SOC_MT7621))
+		return false;
 	return eth->soc->version > 1;
 }
 
 static inline bool mtk_is_netsys_v3_or_greater(struct mtk_eth *eth)
 {
+	if (IS_ENABLED(CONFIG_SOC_MT7621))
+		return false;
 	return eth->soc->version > 2;
 }
 
-- 
2.47.0


