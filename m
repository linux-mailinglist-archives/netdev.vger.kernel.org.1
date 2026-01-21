Return-Path: <netdev+bounces-251816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGsfFwCecGlyYgAAu9opvQ
	(envelope-from <netdev+bounces-251816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:36:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DAC547E5
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 767C154B706
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0018B478E42;
	Wed, 21 Jan 2026 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmrKtvPP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7FE477E24
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987182; cv=none; b=pVeUFdnD9ko+02/P1COHA+zqg4R0sot5spxEqWkaLp2R4EC0y1TK3zkKptjgD2IsgEnNuY1j97aHVoTTU4/7B6NkKD1UGCBtkuswfhwi1BG/7bseU4gg6iT91lKA3GMMr+eTIWZlVHcQAtBtHnLTaTUGKZjHHNkF8F3+6H7mdFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987182; c=relaxed/simple;
	bh=4IOfkFMFIGvsvpaqgBlaUzsYYethKFQA2Xe7ZO8rkXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G7sQV353ZoqpA3dJslePkc53ssieTxEApl36jS+1BCE9raUOZ0vO3qFF50Fd091jsDrfCWxVkCW668xy7a7q2satfHDSLERaoBzrSG7/bsk4n0uuUqjrA7nEo/+yM2qkhZZ/uL9yCZ0kGwvq9PT2AhWoGbMw0F9NLoFlQiuVSMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmrKtvPP; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c05d66dbab2so4076030a12.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768987180; x=1769591980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hba5N0XT4kz2okXqzmo7xWvP0YP9wd2FNtkfwLzHXNI=;
        b=EmrKtvPPfve8mAikAT+CeLBPxMjQ20aAKVyL7zgmX1Kqaf8ThnW0JD3VZmdr8ow6PV
         2WYqziMcTtU7AwUM0XTdPLXB1tJe0hUbA28l+TBZmZK8UbiPW9YvX3jF0V0s19zVp99X
         5AKssEhJSmw1kVHz+MBnKxmfQ50kj869FE5KRpbPNbRkEds+h4LCauAe28cNZGuQOTX8
         Hk44GgAk++7FXfYlzJgFSneuyzkPxBc2jqVm9w6NCmVXBhUt6pq/eGs6ZPcYuz4QFTN8
         V6nFvguIfy0CZP9JdhPJ7kLFU2JyV/IH4/LzSwr71sWcbGOQmWKEivcZR59Mik00u5jn
         zdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768987180; x=1769591980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hba5N0XT4kz2okXqzmo7xWvP0YP9wd2FNtkfwLzHXNI=;
        b=UjDwhe4Rco3NRl/sKFBgZxBMARkFh5A5hTfOUsNDZ8msjMEm/44/VixZg9hhIUwjDs
         isP1JenL7rDtGA0BtXb2qD9N6MydCzBMYmEBSZcknm8/y+Oxqr3n7o1RXuZVP8riUTxz
         o3yNhuIZHdldgwIoQ0taHdJwM7EPcBFAmKapNwPgrPm+alvacHo0h71wKeGWpjPtB7wn
         cj+Rr92mxaJKWDjIeC487a80alI8DfnD0vBEFuIb+dGLv1MiJdsiy124rykA9vOXck91
         V5hjsF3X3IWi4DSrNRdUeU4ip5m7aGoJ8BToAR72SJpktP6qHD+1/Fhuv022P5Tm1sSm
         iliw==
X-Forwarded-Encrypted: i=1; AJvYcCXdAlpiRbBfNopiXt7rmjDkqfUFK79rzqV+SjpCtSBE2KmHcyBFoN3ojm6QUT8cuzZrKDaZ4X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlDrCdGaSCRbn0uMgiTaOHMr3ADBOtEJzYpXhyv3MTDcyysBWy
	vRvnx7uWvmMtqVZxm++b75uI8RmDzIUR9nDYuRxXLBHbXHW4kVWDTIQ=
X-Gm-Gg: AZuq6aJWgUWEGABORutD537ZuExpzjeEjM0pyh3D+UUZ238QIwR3ReIymIOLtV+o6hs
	rz/0phxupnzQFrpjWJhZBiFC2eE+4InxGXIwsaCGHJivxWiOGhkMbuW+viW2oJeBoc/8ZazsQrX
	ZtJMtLGZdW7Pn40GPsmcEtmw+9/wXT4XNYZOPWIlUU+NWedTfiKshVhV6FReyo+tGA5/R9vWnxO
	QWwckxc7/7Eb7PLL00dss7uP804Is5wMko8b1w0JR03SyXiDHaugWcfKVxOpURmZCA7zADV9alW
	eSd4Gj9FRmT4UFVfPnj8aYWbpAuSVeES5yow8i/yGdmtbWm4Ybr5usFoRyLz6n2Tnp7MWBkzF9K
	cXbZ58FlDe7sjgGiSr/O9GyAcmTzrdT6PGNuczsN6Ywo01gXFDzQTnblktKGJJ0IBR85n2+LkpC
	1jDbJCTGLN0AJK+4k=
X-Received: by 2002:a05:6a21:6088:b0:366:14b0:1a30 with SMTP id adf61e73a8af0-38e45e6ade8mr3970675637.62.1768987179757;
        Wed, 21 Jan 2026 01:19:39 -0800 (PST)
Received: from DESKTOP-BKIPFGN ([38.76.140.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf37a7b0sm11594603a12.33.2026.01.21.01.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:19:39 -0800 (PST)
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
Subject: [PATCH] net: wwan: t7xx: fix potential skb->frags overflow in RX path
Date: Wed, 21 Jan 2026 17:18:54 +0800
Message-ID: <20260121091853.1758-2-qikeyu2017@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-251816-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.intel.com,mediatek.com,sipsolutions.net,vger.kernel.org,gmail.com];
	FREEMAIL_TO(0.00)[intel.com,oss.qualcomm.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[qikeyu2017@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 03DAC547E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Fix this by adding a bounds check before calling skb_add_rx_frag()
to ensure nr_frags does not exceed MAX_SKB_FRAGS.

Fixes: d642b012df70a ("net: wwan: t7xx: Add data path interface")
Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
---
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
index b76bea6ab2d7..b041e6f48732 100644
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
@@ -407,13 +408,16 @@ static int t7xx_dpmaif_set_frag_to_skb(const struct dpmaif_rx_queue *rxq,
 	if (!page_info->page)
 		return -EINVAL;
 
+	if (shinfo->nr_frags >= MAX_SKB_FRAGS)
+		return -EINVAL;
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


