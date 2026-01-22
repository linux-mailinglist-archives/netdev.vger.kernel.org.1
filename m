Return-Path: <netdev+bounces-252466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AUvBhpicmnfjQAAu9opvQ
	(envelope-from <netdev+bounces-252466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:44:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 845006B96C
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 745C9311C287
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABA93D5F3C;
	Thu, 22 Jan 2026 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFHr91kU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3315320CA7
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101496; cv=none; b=seYxC5/Nya80hmYAnOi0ueqDzb8hqj0F6qOZq0ZThAS0nbes55LSDDe/xSE1A0xb/YyWkRvZ25rfZ0SM8/iTmSVGMr5577nWEg3Tih/6saJROTBHjbUfvMjsouDFVSE9ZlbYXqNIHA0AgzZsYdYzXRpH5gW/nA0mu/Tm+CaBxNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101496; c=relaxed/simple;
	bh=ZSIt5K2QVBjFlexKCHulTBbdjtVBQtnj9xX2vLzZ3fs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hskrsDspFXQKMNbm5QZ/0l7eisqCiXFYEP1JiiqXXHTp9Xk+jpqIpMfkylxFUGIqdQg5+OJk27/WQLcm/hViDX0gyM3GGxcZImPdS8uu8ZS5/Fyn0G8FH3j2LBX1vn1/CSsafNn5bXg1gJBQq11yGvIIkHhJIQ+sLmQV+5jDliw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFHr91kU; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-81f47610542so715903b3a.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 09:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769101487; x=1769706287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kGcbnpURpKElDduIyavGnVliQJdwBmRCfzXVX+YJb8Y=;
        b=TFHr91kUncWz5x9fIx21Scf9pKpKNumMauiGfghUHbGd2q3thTdxMTiR8WZdPHk6xf
         E67ITbCghg/QRIoUpmSHQy9cksMlNqWmff5vzj7gcjIZftoGVk6JqLaPHpb+D0cG7hEa
         Z6aZDALB4J/26YPSobay9ivQuGoNfyDxHk2gpt1/SeEnX9zk8oRIW9/Q8vJhhOlHDW3/
         wRjUFGPZtd+GCvLM/yugvWjcUWI1xwJDJRL80apbEBCmqhQ2eevd7ps7PlwgSsWLJDyy
         yym+FT6TFINRaTtFUwF82siiZTFsEiGFEuuMl24ATtMXC7qguwHKbm4O9n5x+Ia5PxVQ
         DACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769101487; x=1769706287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGcbnpURpKElDduIyavGnVliQJdwBmRCfzXVX+YJb8Y=;
        b=SHe9ZT3CIUp79L3+hw1FvTN7CMQdeqjn4Ek3tB9kZe30TuhYsWhx9/9epf0Mdyr/GN
         0xApJzyUVizNGDD6qLvbOIIeRofjbdV3fQTvEEDED6Gv3jty5BDJwJJ6jNRc5toPm4d2
         G9B//lgVBuiHIsCEASsKY8cs1Di775rhbh6EYb0telNzbnb/WHsZ4TEzUuV5DMtKJxbc
         Z0nzYA885v0hDxsf+ket97NzYOFWU3yutrY3YqBUvZxB3zLE0f16wWku53zzpBlUSH3U
         xwSb6cx2Y63M1WdXwiud2k51PtNDw8pjGkIo9aAu1T/j2NCJ/U42S7oWdPNJs/IlMuOd
         BW1A==
X-Forwarded-Encrypted: i=1; AJvYcCVja0rsYLKqc2khyS/uRzyCdWJj17OzBLje4oRRCWDWgIIKtOPWZzBsV83+dmiWf9WNZ8lMCbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPG/iCoi2WnCkgmai7BNXeAi8inIBcu0NoaDhqID3qs09PU+37
	CbfHeQH5jVCGdBDIb/sA8xBkHnE0+O6leH7hINQ5lGXCOBdrJbqr/Ew=
X-Gm-Gg: AZuq6aKRW0nA+uGT8YX3ePeEv3AebZ5Blf9iVm+eFW4vp3nlDiYgMxoKUxfippB/I5+
	wYK1fdhQKH8oJjv/XZf3RlvqdbqsmNsGtZzwSw5S8GTbF+iuidhVbRmp3xXNoXh6bn88lOEq8LV
	NwOb7Ta4wBV0IyKq6lhnYfOHpnY0b7oB9vbGSgbrQxRbv3yFNnMpl6mSRqNHC1v/obnz6KGg9WZ
	qV2NdXJN5vbQKYrvp02tWnHe1VuwwX2hy2mzPfjYZm8yNPGWYTZZPnQ10txKZuzCS/EY6iHOjQk
	cqAxi0SomG9w5os7KfuxayKtXrt2YqkiUgDrJ+mLiTOsNu1mqvw+rBRXUg+YP5Ralt9PJxhp+uv
	H/28D3mjohkM6lTXraWIxnsS8Ox9fXCMqXFNxMKPKLvb+fzuaRHlgyZkMxAcGbt25oXHz58zyBB
	6romuItOpG0rjLHQg=
X-Received: by 2002:a05:6a00:a88c:b0:81f:9f14:ecc8 with SMTP id d2e1a72fcca58-82317d23a23mr17551b3a.27.1769101487148;
        Thu, 22 Jan 2026 09:04:47 -0800 (PST)
Received: from DESKTOP-BKIPFGN ([38.76.140.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1277966sm18546162b3a.31.2026.01.22.09.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 09:04:46 -0800 (PST)
From: Kery Qi <qikeyu2017@gmail.com>
To: chandrashekar.devegowda@intel.com,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	ricardo.martinez@linux.intel.com,
	johannes@sipsolutions.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kery Qi <qikeyu2017@gmail.com>
Subject: [PATCH] net: wwan: t7xx: fix potential skb->frags overflow in RX path v2
Date: Fri, 23 Jan 2026 01:04:01 +0800
Message-ID: <20260122170401.1986-2-qikeyu2017@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,mediatek.com,sipsolutions.net,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-252466-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[intel.com,oss.qualcomm.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qikeyu2017@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 845006B96C
X-Rspamd-Action: no action

When receiving data in the DPMAIF RX path,
the t7xx_dpmaif_set_frag_to_skb() function adds
page fragments to an skb without checking if the number of
fragments has exceeded MAX_SKB_FRAGS. This could lead to a buffer overflow
in skb_shinfo(skb)->frags[] array, corrupting adjacent memory and
potentially causing kernel crashes or other undefined behavior.

This issue was identified through static code analysis by comparing with a
similar vulnerability fixed in the mt76 driver commit b102f0c522cf ("mt76:
fix array overflow on receiving too many fragments for a packet").

The vulnerability could be triggered if the modem firmware sends packets
with excessive fragments. While under normal protocol conditions (MTU 3080
bytes, BAT buffer 3584 bytes),
a single packet should not require additional
fragments, the kernel should not blindly trust firmware behavior.
Malicious, buggy, or compromised firmware could potentially craft packets
with more fragments than the kernel expects.

Fix this by adding a bounds check before calling skb_add_rx_frag() to
ensure nr_frags does not exceed MAX_SKB_FRAGS.

The check must be performed before unmapping to avoid a page leak
and double DMA unmap during device teardown.

Fixes: d642b012df70a ("net: wwan: t7xx: Add data path interface")
Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
---
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
index b76bea6ab2d7..5af90ca6e063 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
@@ -395,6 +395,7 @@ static int t7xx_dpmaif_set_frag_to_skb(const struct dpmaif_rx_queue *rxq,
 				       struct sk_buff *skb)
 {
 	unsigned long long data_bus_addr, data_base_addr;
+	struct skb_shared_info *shinfo = skb_shinfo(skb);
 	struct device *dev = rxq->dpmaif_ctrl->dev;
 	struct dpmaif_bat_page *page_info;
 	unsigned int data_len;
@@ -402,18 +403,22 @@ static int t7xx_dpmaif_set_frag_to_skb(const struct dpmaif_rx_queue *rxq,
 
 	page_info = rxq->bat_frag->bat_skb;
 	page_info += t7xx_normal_pit_bid(pkt_info);
-	dma_unmap_page(dev, page_info->data_bus_addr, page_info->data_len, DMA_FROM_DEVICE);
 
 	if (!page_info->page)
 		return -EINVAL;
 
+	if (shinfo->nr_frags >= MAX_SKB_FRAGS)
+		return -EINVAL;
+
+	dma_unmap_page(dev, page_info->data_bus_addr, page_info->data_len, DMA_FROM_DEVICE);
+
 	data_bus_addr = le32_to_cpu(pkt_info->pd.data_addr_h);
 	data_bus_addr = (data_bus_addr << 32) + le32_to_cpu(pkt_info->pd.data_addr_l);
 	data_base_addr = page_info->data_bus_addr;
 	data_offset = data_bus_addr - data_base_addr;
 	data_offset += page_info->offset;
 	data_len = FIELD_GET(PD_PIT_DATA_LEN, le32_to_cpu(pkt_info->header));
-	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page_info->page,
+	skb_add_rx_frag(skb, shinfo->nr_frags, page_info->page,
 			data_offset, data_len, page_info->data_len);
 
 	page_info->page = NULL;
-- 
2.34.1


