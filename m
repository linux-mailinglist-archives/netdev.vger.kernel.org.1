Return-Path: <netdev+bounces-172665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E8BA55A98
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1F6171806
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DC428040D;
	Thu,  6 Mar 2025 23:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b="JKz/tWxO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B4627FE85
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 23:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741302258; cv=none; b=kzzB51ZStTDb6zzTZsg4KiIJQhK21iPQjbe1fFdXQKcZV6VpuLqkbqBvQLSqXBQbpkXnQW0BeTNjiWLlPXkFni4tfeoMsb7FaMytwCzZkh+jQX5UAer1L0K64nOKa98JfrS5uZRnd15svqlC5wQnzWNtBqqJ4bSLaN44D5TaypQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741302258; c=relaxed/simple;
	bh=SzQBH+aJ7uQP95syJXM9qrZRtDlY6w6Q12Y1VuqlJb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eODryBbQbfX/xwT0vaLQxD7z5ZXrK4DOXwRliObjzhGUiStIocFb0Y1DPXS4AaKC4KM9AewyMhAIEio4I/uzMpFRJOX1B02N5drMEED3/a5zTOzgvoQbGAy6Vc9I/8Bqt3bIv+5tKBy1sBw67EiIFtNx2G/cKkwTYUdip1sLDts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net; spf=pass smtp.mailfrom=enfabrica.net; dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b=JKz/tWxO; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enfabrica.net
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6dd049b5428so11999686d6.2
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 15:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1741302255; x=1741907055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbiaBeimFuoiyQMyCyzRbpsj0biLaKIOphHeUsu9H70=;
        b=JKz/tWxOxui6zhHIyqPu6buPu67w+cf+AjBmH4hH2Wro8QhH+i88tOtgPMuLE3/c98
         +FEbqIySg5/3oAS2ga2fdVyqyTINUDN8dhNd++JydyJfllk67q/SP9uR5vqhNrl7kaVd
         NtvWF52iywvNRVVsNr1zDFbQBS7BjCDLnepkFtfM51gESox3Ia0098Yw3tuXTb3u76Qc
         ibKgoxJT9+foIFyGSv3yR0hubQxX9C82YVTKQ2G8MnwkjTf1QkdMPQLBnoUkOxl8xjfh
         ufT5k5xSkHuLjTBCwVDyBJd128hxBvYA8Wlp3uIuT8T5lUXq2n76YJfpFsxiHR1rlYJH
         HdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741302255; x=1741907055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbiaBeimFuoiyQMyCyzRbpsj0biLaKIOphHeUsu9H70=;
        b=Hk8gwxrCpkI8AOFGAvNsD5yWU2BNEBivVMyXODFar9jTKUNp0SEGP6FJZeyJmi8qUD
         GIdgXzjV16NAc3JiK9L2FWzuLOFpL9vJwo43C4aZ3/8WtPEj6tf/Vqd2IYgwmGStmNNm
         3HIl+gphqHE/eV8yjcF5SxjetrxePlUbvkeUrKMtJfX/csGkx4trN0JfXE+q9y/AZo3u
         8JaiNt1Ae+X2jkqrH4ivPf8+bRno01WIwXBblf3guyeECIoEO6cr33nc05Me64L+wV4Z
         E34GGP/9ZZz29/Kfa2L71/nkVrV0d7ur86xWtIE0QJcT5bNi7Y0KxrDnsQjbaAdV/yit
         Gw1w==
X-Gm-Message-State: AOJu0YyyYlOxIHsfOIokf3LNq9+3ru0cq8KpoTuLtfzYELAf6/jEVsvr
	olgojbRAq5RleJAkcKQy4146DDipZrOCojZ88ENgWhVerHDUe87rpiOBY6JPw/NswlGx2aD58za
	R8AuJewIwLrqZWFXAq71OZeQ7bh152FJlQe1czt/h/YYObS8KGFe4y71QIWNAm0r7cBZAmVDNg3
	c9ZZKJWmDnZkjVtYDFj8ho+nXf6B3N/yJ31tyo7gEmA6Q=
X-Gm-Gg: ASbGnctMvMFzdJpuerCz39kX2faYQhyiEdCwxZLxG75X7gaVeD78mJqzgp+tqjeU+Lu
	egykakqMziuTWc6fBrj+VwdOcCp4AxmFDeTKZKIxl9RCpQ1qHob6ZQI62i7d/Ztb0Yp0cGhg5mr
	U97oQnXVAfXHQzJyE47Jx3sEI45iwtvSg3CeQQ9hNO3AJi7qZ/82NNFRUEIBQ8JTfTbH8vqZ3rF
	C4V9F3TZTm/ykhHgbO/SCZNzgW+iEszpIsfBENI+nJDGsGKjjK385bU73XWKohwT9lIyu/FoykB
	yAd9klwCxhz76qZWtO48CmMCP1YG2V+7uP65eFnZXvSUZJCahQqt84s+xfiWVmJYpEKf
X-Google-Smtp-Source: AGHT+IFO4ljE3Jnq8tK8vQH0OpdIT3/hzxnbcFQQ4i0RMAXe96e1At61yaCm/Ax7yEb66ZweInmCRQ==
X-Received: by 2002:a05:6214:528a:b0:6e8:feb2:bad9 with SMTP id 6a1803df08f44-6e900670d1cmr11171096d6.30.1741302254847;
        Thu, 06 Mar 2025 15:04:14 -0800 (PST)
Received: from debil.. (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac256654fa6sm14971966b.93.2025.03.06.15.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 15:04:14 -0800 (PST)
From: Nikolay Aleksandrov <nikolay@enfabrica.net>
To: netdev@vger.kernel.org
Cc: shrijeet@enfabrica.net,
	alex.badea@keysight.com,
	eric.davis@broadcom.com,
	rip.sohan@amd.com,
	dsahern@kernel.org,
	bmt@zurich.ibm.com,
	roland@enfabrica.net,
	nikolay@enfabrica.net,
	winston.liu@keysight.com,
	dan.mihailescu@keysight.com,
	kheib@redhat.com,
	parth.v.parikh@keysight.com,
	davem@redhat.com,
	ian.ziemba@hpe.com,
	andrew.tauferner@cornelisnetworks.com,
	welch@hpe.com,
	rakhahari.bhunia@keysight.com,
	kingshuk.mandal@keysight.com,
	linux-rdma@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC PATCH 09/13] drivers: ultraeth: add support for coalescing ack
Date: Fri,  7 Mar 2025 01:01:59 +0200
Message-ID: <20250306230203.1550314-10-nikolay@enfabrica.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306230203.1550314-1-nikolay@enfabrica.net>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds Rx support for coalescing ack based on the PDS spec. It
is controlled by two per-FEP variables that can be set when the FEP
requests to be associated to a job:
- ack_gen_trigger: number of bytes that will trigger an ACK
- ack_gen_min_pkt_add: minimum number of bytes to add on each packet

The default values are ack_gen_trigger = 16KB and ack_gen_min_pkt_add = 1KB
as per the spec.

Signed-off-by: Nikolay Aleksandrov <nikolay@enfabrica.net>
Signed-off-by: Alex Badea <alex.badea@keysight.com>
---
 drivers/ultraeth/uet_pdc.c     | 119 ++++++++++++++++++++++++---------
 drivers/ultraeth/uet_pds.c     |  18 +++--
 include/net/ultraeth/uet_job.h |   2 +
 include/net/ultraeth/uet_pdc.h |   7 +-
 include/uapi/linux/ultraeth.h  |   2 +
 5 files changed, 111 insertions(+), 37 deletions(-)

diff --git a/drivers/ultraeth/uet_pdc.c b/drivers/ultraeth/uet_pdc.c
index dc79305cc3b5..55b893ac5479 100644
--- a/drivers/ultraeth/uet_pdc.c
+++ b/drivers/ultraeth/uet_pdc.c
@@ -19,9 +19,9 @@ static void uet_pdc_xmit(struct uet_pdc *pdc, struct sk_buff *skb)
 	dev_queue_xmit(skb);
 }
 
-static void uet_pdc_mpr_advance_tx(struct uet_pdc *pdc, u32 bits)
+static void __uet_pdc_mpr_advance_tx(struct uet_pdc *pdc, u32 bits)
 {
-	if (!test_bit(0, pdc->tx_bitmap) || !test_bit(0, pdc->ack_bitmap))
+	if (WARN_ON_ONCE(bits >= UET_PDC_MPR))
 		return;
 
 	bitmap_shift_right(pdc->tx_bitmap, pdc->tx_bitmap, bits, UET_PDC_MPR);
@@ -31,6 +31,15 @@ static void uet_pdc_mpr_advance_tx(struct uet_pdc *pdc, u32 bits)
 		   pdc->tx_base_psn);
 }
 
+static void uet_pdc_mpr_advance_tx(struct uet_pdc *pdc, u32 cack_psn)
+{
+	/* cumulative ack, clear all prior and including cack_psn */
+	if (cack_psn > pdc->tx_base_psn)
+		__uet_pdc_mpr_advance_tx(pdc, cack_psn - pdc->tx_base_psn);
+	else if (test_bit(0, pdc->tx_bitmap) && test_bit(0, pdc->ack_bitmap))
+		__uet_pdc_mpr_advance_tx(pdc, 1);
+}
+
 static void uet_pdc_rtx_skb(struct uet_pdc *pdc, struct sk_buff *skb, ktime_t ts)
 {
 	struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);
@@ -227,7 +236,8 @@ static bool uet_pdc_id_get(struct uet_pdc *pdc)
 
 struct uet_pdc *uet_pdc_create(struct uet_pds *pds, u32 rx_base_psn, u8 state,
 			       u16 dpdcid, u16 pid_on_fep, u8 mode,
-			       u8 tos, __be16 dport,
+			       u8 tos, __be16 dport, u32 ack_gen_trigger,
+			       u32 ack_gen_min_pkt_add,
 			       const struct uet_pdc_key *key, bool is_inbound)
 {
 	struct uet_pdc *pdc, *pdc_ins = ERR_PTR(-ENOMEM);
@@ -254,6 +264,8 @@ struct uet_pdc *uet_pdc_create(struct uet_pds *pds, u32 rx_base_psn, u8 state,
 	pdc->pds = pds;
 	pdc->mode = mode;
 	pdc->is_initiator = !is_inbound;
+	pdc->ack_gen_trigger = ack_gen_trigger;
+	pdc->ack_gen_min_pkt_add = ack_gen_min_pkt_add;
 	pdc->rtx_queue = RB_ROOT;
 	if (!uet_pdc_id_get(pdc))
 		goto err_id_get;
@@ -541,11 +553,25 @@ int uet_pdc_rx_ack(struct uet_pdc *pdc, struct sk_buff *skb,
 	/* either using ROD mode or in SYN_SENT state */
 	if (pdc->tx_busy)
 		pdc->tx_busy = false;
-	/* we can advance only if the oldest pkt got acked */
-	if (!psn_bit)
-		uet_pdc_mpr_advance_tx(pdc, 1);
 	ecn_marked = !!(uet_prologue_flags(&ack->prologue) & UET_PDS_ACK_FLAG_M);
-	uet_pdc_ack_psn(pdc, skb, ack_psn, ecn_marked);
+	/* we can advance only if the oldest pkt got acked or we got
+	 * a cumulative ack clearing >= 1 older packets
+	 */
+	if (!psn_bit || cack_psn > pdc->tx_base_psn) {
+		if (cack_psn >= pdc->tx_base_psn) {
+			u32 i;
+
+			for (i = 0; i <= cack_psn - pdc->tx_base_psn; i++)
+				uet_pdc_ack_psn(pdc, skb, cack_psn - i,
+						ecn_marked);
+		}
+
+		uet_pdc_mpr_advance_tx(pdc, cack_psn);
+	}
+
+	/* minor optimization, this can happen only if they are != */
+	if (cack_psn != ack_psn)
+		uet_pdc_ack_psn(pdc, skb, ack_psn, ecn_marked);
 
 	ret = 0;
 	switch (pdc->state) {
@@ -584,13 +610,39 @@ int uet_pdc_rx_ack(struct uet_pdc *pdc, struct sk_buff *skb,
 
 static void uet_pdc_mpr_advance_rx(struct uet_pdc *pdc)
 {
-	if (!test_bit(0, pdc->rx_bitmap))
+	unsigned long fzb = find_first_zero_bit(pdc->rx_bitmap, UET_PDC_MPR);
+	u32 old_psn = pdc->rx_base_psn;
+
+	if (fzb == 0)
 		return;
 
-	bitmap_shift_right(pdc->rx_bitmap, pdc->rx_bitmap, 1, UET_PDC_MPR);
-	pdc->rx_base_psn++;
-	netdev_dbg(pds_netdev(pdc->pds), "%s: advancing rx to %u\n",
-		   __func__, pdc->rx_base_psn);
+	bitmap_shift_right(pdc->rx_bitmap, pdc->rx_bitmap, fzb, UET_PDC_MPR);
+	pdc->rx_base_psn += fzb;
+	netdev_dbg(pds_netdev(pdc->pds), "%s: advancing rx from %u to %u (%lu)\n",
+		   __func__, old_psn, pdc->rx_base_psn, fzb);
+}
+
+static void uet_pdc_rx_req_handle_ack(struct uet_pdc *pdc, unsigned int len,
+				      __be16 msg_id, u8 req_flags, u32 req_psn,
+				      u8 ack_flags, bool first_ack)
+{
+	pdc->ack_gen_count += max(pdc->ack_gen_min_pkt_add, len);
+	if (first_ack ||
+	    (req_flags & (UET_PDS_REQ_FLAG_AR | UET_PDS_REQ_FLAG_RETX)) ||
+	    pdc->ack_gen_count >= pdc->ack_gen_trigger) {
+		/* first advance so if the current psn == rx_base_psn
+		 * we will clear it with the cumulative ack
+		 */
+		uet_pdc_mpr_advance_rx(pdc);
+		pdc->ack_gen_count = 0;
+		/* req_psn is inside the cumulative ack range, so
+		 * it is covered by it
+		 */
+		if (unlikely(req_psn < pdc->rx_base_psn))
+			req_psn = pdc->rx_base_psn;
+		uet_pdc_send_ses_ack(pdc, UET_SES_RSP_RC_NULL, msg_id, req_psn,
+				     ack_flags, false);
+	}
 }
 
 int uet_pdc_rx_req(struct uet_pdc *pdc, struct sk_buff *skb,
@@ -601,7 +653,9 @@ int uet_pdc_rx_req(struct uet_pdc *pdc, struct sk_buff *skb,
 	u8 req_flags = uet_prologue_flags(&req->prologue), ack_flags = 0;
 	u32 req_psn = be32_to_cpu(req->psn);
 	const char *drop_reason = "tx_busy";
-	unsigned long psn_bit;
+	__be16 msg_id = ses_req->msg_id;
+	unsigned int len = skb->len;
+	bool first_ack = false;
 	enum mpr_pos psn_pos;
 	int ret = -EINVAL;
 
@@ -648,22 +702,31 @@ int uet_pdc_rx_req(struct uet_pdc *pdc, struct sk_buff *skb,
 		break;
 	}
 
-	psn_bit = req_psn - pdc->rx_base_psn;
-	if (!psn_bit_valid(psn_bit)) {
-		drop_reason = "req psn bit is invalid";
-		goto err_dbg;
-	}
-	if (test_and_set_bit(psn_bit, pdc->rx_bitmap)) {
-		drop_reason = "req psn bit is already set in rx_bitmap";
-		goto err_dbg;
-	}
-
-	ret = 0;
 	switch (pdc->state) {
 	case UET_PDC_EP_STATE_SYN_SENT:
 		/* error */
 		break;
+	case UET_PDC_EP_STATE_NEW_ESTABLISHED:
+		/* special state when a connection is new, we need to
+		 * send first ack immediately
+		 */
+		pdc->state = UET_PDC_EP_STATE_ESTABLISHED;
+		first_ack = true;
+		fallthrough;
 	case UET_PDC_EP_STATE_ESTABLISHED:
+		if (!first_ack) {
+			unsigned long psn_bit = req_psn - pdc->rx_base_psn - 1;
+
+			if (!psn_bit_valid(psn_bit)) {
+				drop_reason = "req psn bit is invalid";
+				goto err_dbg;
+			}
+			if (test_and_set_bit(psn_bit, pdc->rx_bitmap)) {
+				drop_reason = "req psn bit is already set in rx_bitmap";
+				goto err_dbg;
+			}
+		}
+
 		/* Rx request and do an upcall, potentially return an ack */
 		ret = uet_job_fep_queue_skb(pds_context(pdc->pds),
 					    uet_ses_req_job_id(ses_req), skb,
@@ -678,12 +741,8 @@ int uet_pdc_rx_req(struct uet_pdc *pdc, struct sk_buff *skb,
 	}
 
 	if (ret >= 0)
-		uet_pdc_send_ses_ack(pdc, UET_SES_RSP_RC_NULL, ses_req->msg_id,
-				     req_psn, ack_flags, false);
-	/* TODO: NAK */
-
-	if (!psn_bit)
-		uet_pdc_mpr_advance_rx(pdc);
+		uet_pdc_rx_req_handle_ack(pdc, len, msg_id, req_flags,
+					  req_psn, ack_flags, first_ack);
 
 out:
 	spin_unlock(&pdc->lock);
diff --git a/drivers/ultraeth/uet_pds.c b/drivers/ultraeth/uet_pds.c
index 7efb634de85f..52122998079d 100644
--- a/drivers/ultraeth/uet_pds.c
+++ b/drivers/ultraeth/uet_pds.c
@@ -166,7 +166,8 @@ static int uet_pds_rx_ack(struct uet_pds *pds, struct sk_buff *skb,
 
 static struct uet_pdc *uet_pds_new_pdc_rx(struct uet_pds *pds,
 					  struct sk_buff *skb,
-					  __be16 dport,
+					  __be16 dport, u32 ack_gen_trigger,
+					  u32 ack_gen_min_pkt_add,
 					  struct uet_pdc_key *key,
 					  u8 mode, u8 state)
 {
@@ -176,7 +177,8 @@ static struct uet_pdc *uet_pds_new_pdc_rx(struct uet_pds *pds,
 	return uet_pdc_create(pds, be32_to_cpu(req->psn), state,
 			      be16_to_cpu(req->spdcid),
 			      uet_ses_req_pid_on_fep(ses_req),
-			      mode, 0, dport, key, true);
+			      mode, 0, dport, ack_gen_trigger,
+			      ack_gen_min_pkt_add, key, true);
 }
 
 static int uet_pds_rx_req(struct uet_pds *pds, struct sk_buff *skb,
@@ -215,7 +217,8 @@ static int uet_pds_rx_req(struct uet_pds *pds, struct sk_buff *skb,
 		if (fep->addr.in_address.ip != local_fep_addr)
 			return -ENOENT;
 
-		pdc = uet_pds_new_pdc_rx(pds, skb, dport, &key,
+		pdc = uet_pds_new_pdc_rx(pds, skb, dport, fep->ack_gen_trigger,
+					 fep->ack_gen_min_pkt_add, &key,
 					 UET_PDC_MODE_RUD,
 					 UET_PDC_EP_STATE_NEW_ESTABLISHED);
 		if (IS_ERR(pdc))
@@ -293,7 +296,8 @@ int uet_pds_rx(struct uet_pds *pds, struct sk_buff *skb, __be32 local_fep_addr,
 
 static struct uet_pdc *uet_pds_new_pdc_tx(struct uet_pds *pds,
 					  struct sk_buff *skb,
-					  __be16 dport,
+					  __be16 dport, u32 ack_gen_trigger,
+					  u32 ack_gen_min_pkt_add,
 					  struct uet_pdc_key *key,
 					  u8 mode, u8 state)
 {
@@ -301,7 +305,8 @@ static struct uet_pdc *uet_pds_new_pdc_tx(struct uet_pds *pds,
 
 	return uet_pdc_create(pds, 0, state, 0,
 			      uet_ses_req_pid_on_fep(ses_req),
-			      mode, 0, dport, key, false);
+			      mode, 0, dport, ack_gen_trigger,
+			      ack_gen_min_pkt_add, key, false);
 }
 
 int uet_pds_tx(struct uet_pds *pds, struct sk_buff *skb, __be32 local_fep_addr,
@@ -336,7 +341,8 @@ int uet_pds_tx(struct uet_pds *pds, struct sk_buff *skb, __be32 local_fep_addr,
 		if (!fep)
 			return -ECONNREFUSED;
 
-		pdc = uet_pds_new_pdc_tx(pds, skb, dport, &key,
+		pdc = uet_pds_new_pdc_tx(pds, skb, dport, fep->ack_gen_trigger,
+					 fep->ack_gen_min_pkt_add, &key,
 					 UET_PDC_MODE_RUD,
 					 UET_PDC_EP_STATE_CLOSED);
 		if (IS_ERR(pdc))
diff --git a/include/net/ultraeth/uet_job.h b/include/net/ultraeth/uet_job.h
index fac1f0752a78..555706a21e96 100644
--- a/include/net/ultraeth/uet_job.h
+++ b/include/net/ultraeth/uet_job.h
@@ -21,6 +21,8 @@ struct uet_fep {
 	struct uet_context *context;
 	struct sk_buff_head rxq;
 	struct fep_address addr;
+	u32 ack_gen_trigger;
+	u32 ack_gen_min_pkt_add;
 	u32 job_id;
 };
 
diff --git a/include/net/ultraeth/uet_pdc.h b/include/net/ultraeth/uet_pdc.h
index 261afc57ffe1..8a87fc0bc869 100644
--- a/include/net/ultraeth/uet_pdc.h
+++ b/include/net/ultraeth/uet_pdc.h
@@ -94,6 +94,10 @@ struct uet_pdc {
 	u32 rx_base_psn;
 	u32 tx_base_psn;
 
+	u32 ack_gen_trigger;
+	u32 ack_gen_min_pkt_add;
+	u32 ack_gen_count;
+
 	struct rb_root rtx_queue;
 
 	struct hlist_node gc_node;
@@ -102,7 +106,8 @@ struct uet_pdc {
 
 struct uet_pdc *uet_pdc_create(struct uet_pds *pds, u32 rx_base_psn, u8 state,
 			       u16 dpdcid, u16 pid_on_fep, u8 mode,
-			       u8 tos, __be16 dport,
+			       u8 tos, __be16 dport, u32 ack_gen_trigger,
+			       u32 ack_gen_min_pkt_add,
 			       const struct uet_pdc_key *key, bool is_inbound);
 void uet_pdc_destroy(struct uet_pdc *pdc);
 void uet_pdc_free(struct uet_pdc *pdc);
diff --git a/include/uapi/linux/ultraeth.h b/include/uapi/linux/ultraeth.h
index 6f3ee5ac8cf4..cc39bf970e08 100644
--- a/include/uapi/linux/ultraeth.h
+++ b/include/uapi/linux/ultraeth.h
@@ -8,6 +8,8 @@
 
 #define UET_DEFAULT_PORT 5432
 #define UET_SVC_MAX_LEN 64
+#define UET_DEFAULT_ACK_GEN_TRIGGER (1 << 14)
+#define UET_DEFAULT_ACK_GEN_MIN_PKT_ADD (1 << 10)
 
 /* types used for prologue's type field */
 enum {
-- 
2.48.1


