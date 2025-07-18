Return-Path: <netdev+bounces-208255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 646CDB0AB76
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 23:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB3B1C43658
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 21:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B5E13AD3F;
	Fri, 18 Jul 2025 21:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LSDA1gWD"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485166FB9;
	Fri, 18 Jul 2025 21:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752874224; cv=none; b=FFcTYma0YkAnUlbLPUc3kATZBLB8lR1gnFMmFXjhq/Q4Bwpv3v/M+u7cqprBBLHli9iJamhP/cAPXPk+AQkYl5tm/RNaiQCTbS0EYP2k4XF2J/Vg0bei46IzXLYyRGvw5rENqdzbS+u/fakH3GSczYtB0M4z1sf2Ie+pwagkWE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752874224; c=relaxed/simple;
	bh=mqWabgWm8Cy32bd1/YW4dX3KfS7ZP3kyX7IQfeJKs+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U58FYznPg38DzYGLbqkbvw//DIduUbAj11mknlcb5xAvjU07epvk180sG/GINI8gCKmyLZCgPLVi428fopOycTTX9a8er5TFNyt+QdSNDA2p/IkVG8LrNCErjVeWNugsx2qsS+mNU4+yLE0yLh+eFtCcnlLZuUIGjvsx9UBvpZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LSDA1gWD; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id CF208C0047DD;
	Fri, 18 Jul 2025 14:22:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com CF208C0047DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1752873769;
	bh=mqWabgWm8Cy32bd1/YW4dX3KfS7ZP3kyX7IQfeJKs+g=;
	h=From:To:Cc:Subject:Date:From;
	b=LSDA1gWDekNQrvuwoK1ZM3BXVvroaaMdjCDn8ZrQgveC9AU5FgbHYajNafWUKiZM8
	 opLTI57rNmmYJ+UQ/Cf2gWbFuhTcoKxJl4NU31nuGRbkVVQ3ycMtbvnk6mVE3Kn1cw
	 WfS6cCF0YWrDG1XD8UJ32XByz47Pt+DaAXxixTm8=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 9DE9E18000530;
	Fri, 18 Jul 2025 14:22:44 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Justin Chen <justin.chen@broadcom.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: bcmasp: Restore programming of TX map vector register
Date: Fri, 18 Jul 2025 14:22:42 -0700
Message-Id: <20250718212242.3447751-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On ASP versions v2.x we need to program the TX map vector register to
properly exercise end-to-end flow control, otherwise the TX engine can
either lock-up, or cause the hardware calculated checksum to be
wrong/corrupted when multiple back to back packets are being submitted
for transmission. This register defaults to 0, which means no flow
control being applied.

Fixes: e9f31435ee7d ("net: bcmasp: Add support for asp-v3.0")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index 0d61b8580d72..f832562bd7a3 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -818,6 +818,9 @@ static void bcmasp_init_tx(struct bcmasp_intf *intf)
 	/* Tx SPB */
 	tx_spb_ctrl_wl(intf, ((intf->channel + 8) << TX_SPB_CTRL_XF_BID_SHIFT),
 		       TX_SPB_CTRL_XF_CTRL2);
+
+	if (intf->parent->tx_chan_offset)
+		tx_pause_ctrl_wl(intf, (1 << (intf->channel + 8)), TX_PAUSE_MAP_VECTOR);
 	tx_spb_top_wl(intf, 0x1e, TX_SPB_TOP_BLKOUT);
 
 	tx_spb_dma_wq(intf, intf->tx_spb_dma_addr, TX_SPB_DMA_READ);
-- 
2.34.1


