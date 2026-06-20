Return-Path: <netdev+bounces-300847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3y+uNEEIN2rhIAcAu9opvQ
	(envelope-from <netdev+bounces-300847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 23:38:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF376A9C33
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 23:38:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=oGTB73hC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300847-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300847-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C316130059BB
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 21:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828243921C6;
	Sat, 20 Jun 2026 21:38:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56897248F57
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 21:38:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781991485; cv=none; b=SZY/KVSH+gjaykzz4VNAfUCEJun9r8aHv19FhlGhYGnkwp099kWznzCSlg5y3OQJK49DTGYY4+pDyl7+DZ+6agX5po+/5tgeWgxWfwOp7Zad3s7o22qABPFYcCOcVm41KlN5WykI0YTrMXVXw3ninwGxQGVHrqIl2Ozfe45DJdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781991485; c=relaxed/simple;
	bh=ZEJ92BXzs7uxFvZ8o+bk+yvRtMFQ80qmq1Smsi3caog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j6vrrlGOQFHu6IiPS9E5iRxRhwuT1lhSafhbIzoBHVBPaniGSyx9iP+LZrOjn8TY+r2Pi+a8iJ9qAnxHvQ3nbVoSLBHf15lRsAGmGjmvqCV49I2IFHdiNPM5vJ4lIRpXeSZ2E/lADzr0+73Yxs/0Dboiu90q05gnFV3hs0+3EW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oGTB73hC; arc=none smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-464192ab2e1so1917736f8f.0
        for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 14:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781991482; x=1782596282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kyy19G3UAGpqNpZJRFtz4WPWcaaqaP4tOOJJnrBVNEo=;
        b=oGTB73hCBI+aKbmNhcNbDN1rb//FBS5ylOmcoCekAH4r7Y7tCe1MDtDGwCSkOviot2
         ZGPB7KVzU3avkexN+WsVTNAxrle9TSRc+jeBraiSgJcw5ViwObsxrgGyQpWEm9sYTEiI
         rOhdnKTwV4GJWFR3ToAUpg+vwg40SNDF26cE7/oXlQreosRMeWiubQ1qSP3SDMvg2kFJ
         UP7piEUg7cPmhEG8ZFLD/oI91soqxjwRXRBcHC9or4dDTUYHoW50+m2Ue7vEDR1K1jjx
         +dcM0PwSh7P9/kjQFCc1y8bRFXlrGL19Q2G6biHG8c8caKtiY14UhUhpDQqNsbMkBPLn
         k+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781991482; x=1782596282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyy19G3UAGpqNpZJRFtz4WPWcaaqaP4tOOJJnrBVNEo=;
        b=C+BFkInI1kNjetbvqb9IhXz1p9sM06ijw7CrqQhgzfCBrAEn/ULG2iI557E8q4dRvw
         lZSk2QdVbo7+2ytV2JVoD1txZwbZp6NsR01WOVBP9DQRsJbZ5XbQrHgSQS2zT/T5mrnC
         xrI0IciYCGfV2/1SxM5JwpQMuCeNemGg19hzKox8GUIddiiS9eqKTyRaGh2xFuRh9oxU
         6xlYIGq1ij/rybZ6RjOrpWCnZVCh23IlbHtZ5nDFlkZy6CI4aSJsxkj1xajSv8IgklOU
         DXIF8Jc9uMjD+3Y1Cx3reeUr8ai5RmA/FoVyS1lk2gFDAvq+jSkEqVCiGJAcDkvEE462
         OwDA==
X-Forwarded-Encrypted: i=1; AHgh+Rqhkif8e+BzkJwE3R1J9Z9AWQamrGE/Ln7U6NpoqxqgNeF4baH4nR36wcLe9J1jY1Dz1H3yX0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAvE+Bn8sXe8XL3HoOPdl6sI165SlpWp4PDzYS3sHuSbHkjvi7
	ZWATJDgILM/0bs8BaEVPNWPBNZEQt4GnUxvRVhMx+XzojAwoUKuxXxU6
X-Gm-Gg: AfdE7ckVMG5rkGefthDAsaTBm/cm9fCm7qZRnl1+/6CuF5vtST8TFbUR+RZ8GSrci98
	H9PBEgRFcdEBBPNllgGou7nLymFZMmaU+o8SQjSKEkEtCSSaaqor12Z3P9wh8PSWd0cJkhTppy5
	/SWtSUjCwiEO86imAuF73DvCu40v7B1oIJIWt1OB7OYbpzpSv9fGtpTjEOJhv8VQo7mG1Q9vdXT
	LsvIwm2Sv2tFgK+A9ECBLojuF6sWZCDE1SQDPDJ2msv+DVtYtGMn6aoVkS/XocZpIB8T7qYMXne
	YpLsa/55l9GppPgQVgEbmgpTQnYlTgvd2wr6nbc0hvqWsEvrthFnEQLXs9eV3Qer+bz6c0JshgI
	kxzGJ1HkjKk7nM5oi9b2pykFWHQoxrq7SdmRhyV7qraM5GHcwhyJgfuC0ecwjx/uLscBUUsSlDY
	+JFJZGsJyNDYvS0WXDQ9jzm4Bi1Jmd2THhu2WYs+Zpk+FxC3Ts+oiw/SjHC0HDcfxqxf1xigAm
X-Received: by 2002:a05:6000:2b01:b0:45e:e1a4:c4c3 with SMTP id ffacd0b85a97d-4650043b85amr9392338f8f.15.1781991481496;
        Sat, 20 Jun 2026 14:38:01 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c698dsm12128189f8f.16.2026.06.20.14.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 14:38:01 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	m-malladi@ti.com,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net] net: ti: icssg-prueth: fix XDP_TX from the AF_XDP zero-copy RX path
Date: Sat, 20 Jun 2026 22:37:56 +0100
Message-ID: <20260620213756.87499-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300847-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,ti.com,gmail.com,fomichev.me,iogearbox.net,vger.kernel.org,lists.infradead.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:danishanwar@ti.com,m:rogerq@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:m-malladi@ti.com,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:ast@kernel.org,m:daniel@iogearbox.net,m:bpf@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:devnexen@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5FF376A9C33

On XDP_TX from the zero-copy RX path, emac_run_xdp() converts the xsk
buffer via xdp_convert_zc_to_xdp_frame(), which clones the data into a
fresh MEM_TYPE_PAGE_ORDER0 page that is not DMA mapped. Transmitting it
as PRUETH_TX_BUFF_TYPE_XDP_TX derives the DMA address with
page_pool_get_dma_addr(), reading an uninitialized page->dma_addr, so
the device DMAs from a bogus address (corrupt TX, or an IOMMU fault).

Pick the TX buffer type from the frame's memory type: keep
PRUETH_TX_BUFF_TYPE_XDP_TX for page_pool frames and use
PRUETH_TX_BUFF_TYPE_XDP_NDO for the cloned zero-copy frame. The
completion path already unmaps PRUETH_SWDATA_XDPF buffers.

Fixes: 7a64bb388df3 ("net: ti: icssg-prueth: Add AF_XDP zero copy for RX")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 82ddef9c17d5..302e700ea17d 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -804,6 +804,7 @@ EXPORT_SYMBOL_GPL(emac_xmit_xdp_frame);
  */
 static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp, u32 *len)
 {
+	enum prueth_tx_buff_type tx_buff_type;
 	struct net_device *ndev = emac->ndev;
 	struct netdev_queue *netif_txq;
 	int cpu = smp_processor_id();
@@ -826,11 +827,21 @@ static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp, u32 *len
 			goto drop;
 		}
 
+		/* In AF_XDP zero-copy mode xdp_convert_buff_to_frame()
+		 * clones the xsk buffer into a fresh MEM_TYPE_PAGE_ORDER0
+		 * page that is not DMA mapped. Such a frame must be mapped
+		 * via the NDO path; only a page pool-backed frame already
+		 * carries a usable page_pool DMA address.
+		 */
+		tx_buff_type = xdpf->mem_type == MEM_TYPE_PAGE_POOL ?
+				PRUETH_TX_BUFF_TYPE_XDP_TX :
+				PRUETH_TX_BUFF_TYPE_XDP_NDO;
+
 		q_idx = cpu % emac->tx_ch_num;
 		netif_txq = netdev_get_tx_queue(ndev, q_idx);
 		__netif_tx_lock(netif_txq, cpu);
 		result = emac_xmit_xdp_frame(emac, xdpf, q_idx,
-					     PRUETH_TX_BUFF_TYPE_XDP_TX);
+					     tx_buff_type);
 		__netif_tx_unlock(netif_txq);
 		if (result == ICSSG_XDP_CONSUMED) {
 			ndev->stats.tx_dropped++;
-- 
2.53.0


