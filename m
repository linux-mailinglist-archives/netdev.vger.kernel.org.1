Return-Path: <netdev+bounces-147444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EABBA9D98D2
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 14:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A2A1621E8
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 13:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA3F1CEAC7;
	Tue, 26 Nov 2024 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="bzI+GCY3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp052.goneo.de (smtp052.goneo.de [85.220.129.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E646193408
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732628886; cv=none; b=ZYJI0PzqNyVGrDAV6LBDuB5DRDWVI0K+juw21aUF0SmNSpLkxj00PvLnIZpOnmCCf02W0nDRzlzBmIkGdeE2wjEENuXmeSQe+VS6/wzPr2IPQWswRMdTkjz4QGmmEiT1wvxMRveE1GeiqWD6EFj1o0p40guPUTV7w8Jb1BVBy3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732628886; c=relaxed/simple;
	bh=U2gEeF/Eef1wijrrVMYlOOEm1KVO7MFELCQ5jF2AZ0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b62+JrQNAo1Peg0LY2TbnMsyZsiT4Aq9I59lu0nyfMnUbK/kHCNjwIjkktIrcMHrcZa75FLC67WaAE99np5vAUuhXBwP2HBrwvFn3e0YDCr4plM7LaToaV5lVonJURoihEl5TNdfHG5DXb59ddUj/gxgjWkyjsR9wKR+cTBJfX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=bzI+GCY3; arc=none smtp.client-ip=85.220.129.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Received: from hub2.goneo.de (hub2.goneo.de [IPv6:2001:1640:5::8:53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp5.goneo.de (Postfix) with ESMTPS id B116D240E80;
	Tue, 26 Nov 2024 14:47:59 +0100 (CET)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id 1AFAD240726;
	Tue, 26 Nov 2024 14:47:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1732628878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ae4Ixg/X5mnmSF5slWB6IWMBf8Qx6HK9tQoWDogvzuI=;
	b=bzI+GCY39H5swAYFixeysj/fq6cJwlp0lW8klbC4s9CkLzqAod/riHWBN3fJcd84HapDrn
	5rHQhaTm6fOY9j360fa1UX8Jz/PkilnI8SY7tEQQhn5njsd26ON+v2KGxrEH8u3YVHJ5Y7
	pltbFFfXPv3z34NVf1ek6CM28mkFNUinmzfflJBr1XBttf7bT3a/YLhHiLIq3bEplyJABj
	nCY1GveGzY1qQtnKIvaazBRi1AyHPh0pUaSuVj9nlU73TWjO9A1CgqZd2+9+hF0sxkPaH2
	SIZK9IT+T8SlCAg903HyUHMjiWulP76hwxqrdBHQK6elo5kzNideo+JUtneMZw==
Received: from Til-Notebook.hs-nordhausen.de (unknown [195.37.89.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id 5352B24062D;
	Tue, 26 Nov 2024 14:47:57 +0100 (CET)
From: Til Kaiser <mail@tk154.de>
To: nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org
Cc: netdev@vger.kernel.org,
	Til Kaiser <mail@tk154.de>
Subject: [PATCH net] mediathek: mtk_eth_soc: fix netdev inside xdp_rxq_info
Date: Tue, 26 Nov 2024 14:41:54 +0100
Message-ID: <20241126134707.253572-2-mail@tk154.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241126134707.253572-1-mail@tk154.de>
References: <20241126134707.253572-1-mail@tk154.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 3a60f5
X-Rspamd-UID: b386e7

Currently, the network device isn't set inside the xdp_rxq_info
of the mtk_rx_ring, which means that an XDP program attached to
the Mediathek ethernet driver cannot retrieve the index of the
interface that received the package since it's always 0 inside
the xdp_md struct.

This patch sets the network device pointer inside the
xdp_rxq_info struct, which is later used to initialize
the xdp_buff struct via xdp_init_buff.

This was tested using the following eBPF/XDP program attached
to a network interface of the mtk_eth_soc driver. As said before,
ingress_ifindex always had a value of zero. After applying the
patch, ingress_ifindex holds the correct interface index.

	#include <linux/bpf.h>
	#include <bpf/bpf_helpers.h>

	SEC("pass")
	int pass_func(struct xdp_md *xdp) {
    		bpf_printk("ingress_ifindex: %u",
			xdp->ingress_ifindex);

		return XDP_PASS;
	}

	char _license[] SEC("license") = "GPL";

Signed-off-by: Til Kaiser <mail@tk154.de>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 53485142938c..9c6d4477e536 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2069,6 +2069,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 
 		netdev = eth->netdev[mac];
 		ppe_idx = eth->mac[mac]->ppe_idx;
+		ring->xdp_q.dev = netdev;
 
 		if (unlikely(test_bit(MTK_RESETTING, &eth->state)))
 			goto release_desc;
-- 
2.47.1


