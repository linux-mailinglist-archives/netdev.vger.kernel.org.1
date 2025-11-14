Return-Path: <netdev+bounces-238765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 53512C5F238
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 20:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 322B135B8C0
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 19:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF55034D920;
	Fri, 14 Nov 2025 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T3QOT7TA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22FA31D723
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763150085; cv=none; b=UUXDkfdcMt825wtGwCViu5ca9JNtcK1Mcw0mFOp6QXdN6CX4bXnSu2sQjall4KTd3bnFmHsrpB0e+AtjwgmvNVpMxgxTJWLRzulJzwofBn2Egp1Pj6Ud0wvudVXAQFkt4cQBgJZBmZB8IZPo+N9bHn1R4ASu5C8ZWAOTjxHyRjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763150085; c=relaxed/simple;
	bh=SMmxb//ePUD3hFrfAsPMLLG0BwdXmv2Mg0jkVsYrPVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZ05HOFcnZOIw28WwDIZBXcid9F0WCw1+6KCEFh9YdCN3KHuX1tfJTxzg/62XOB52GZvBT4t/huGpw3DoK798u++E2BVc9UEwdbbQuraxyJ3vUdw97NIdp+2UdAwGf1zrgkVg8HyqjhHVhMsisjLqTEZu3J1NBEXKUMCaIz/JQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T3QOT7TA; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-bbbc58451a3so1437556a12.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 11:54:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763150083; x=1763754883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJeHjbo0rkg1+MXurwHM1VKiMZc+qaqYqidGa0aqX60=;
        b=jhPyhNjxjMSGWFiWybctHx4WB14ZXhfiHS9gF2XWfgqIIQIOZ9He6mx6FrhND5CfQ0
         UXxin9MbgT3xvQ4u4tmGi306ZPV1CXzHQ5llS88MujhZXj6H3bEdc6sBNPxAuf4FNMps
         l2D+M9PjjEz39TnTAudlXZigL36ZI+VAh+ET/iTp6TwmdRPd6ckQZ+OAcaBmECgpJMfB
         kbmxymxxnSiq0bImVDHzAkgpCRPvXKxxMfNrHQD3LsvdLIH1fw3KJmuBtI0EyB1YyLf8
         +gmO0mMADb0W8oq4aR1Mn7Q61/AKT0NZtJJxQqqCK3UL4WDGHiNkHfbs7U312wYGoKYL
         eoDQ==
X-Gm-Message-State: AOJu0Yw5xV0Z1talOkLy2bMANc7TUjIAUrMTNfvVe38Qi0RTIIZ3bG+2
	YI6v7+rhLzVfmYsg38Wh+xrDicvD5exj/i4KGccEsSw8l1Ip3OZGOeuxn0KFoWfhpzwSunMlxgZ
	E9G2P0Ru9sMSESO1yyPQAxxW3KAKi7pFPSUw/NG2JryCqIZ1/WqvjwdUKKDGXUKh1ZcEEBh3IwA
	pUReO/rZoFtQzdVc0LuFQO1fODBYgWIjL8xi71aBQeWslIdRF48TGBUtFkY3cV6y1an1d+YuCcB
	LmA20ANAXFpgUxD0g==
X-Gm-Gg: ASbGncvhQDxtXH/t7H42esxn1Mc7/u1IqhFUPgNfiFJeG/qA6Co8kIoyQmPDgVBjbQi
	qQLvG5vq4JUAa/R+gfSXTk6pBC3sQdMnbDQsljPDx18rmbDHv2Ip4rRCTdEERPqeHPJVDP3tsxZ
	28jp+ef2d7VQYar15W9ly6fijSxR5XaLPzTL1nQtWAAGUuO0N626T9QuuEiOaxiEbwS4hJnoHyK
	qFdyEvG2jdNkUpzHtRuBwsa0x60Sr8KNVQIr6UmyXfcrVVDcYmjJ12sZkWrYFQv6QlQn1TIx647
	YWXZK8H3Fo8Ww/5CBIakNjbyUy3jH+l/W+30C9ph9nsfKMu5z2JuBUiQlUEBupw7YvEL81UY6X5
	aDB6W5N67soyZ8Hu842+p7TwXP87fFkadKJlUWHZuhkTLvatetcsDSLQ4OmyxUbqT20H9RqHMmC
	Hn2iieZNn6zO2CoqnweQeqBjzFJ9fHmI4q+XrU+90+VOI=
X-Google-Smtp-Source: AGHT+IHM0goRHb6hCpqm3XFvRgZjf3O6LsGJNaC94zOVXro3uWQUFKlXcIVv5DI7n3o2YErxixAQMYPc1+cE
X-Received: by 2002:a05:7300:bc1a:b0:2a4:3593:6466 with SMTP id 5a478bee46e88-2a4abb1cf05mr2435511eec.22.1763150083135;
        Fri, 14 Nov 2025 11:54:43 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2a49daf833fsm400241eec.3.2025.11.14.11.54.42
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Nov 2025 11:54:43 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-295fbc7d4abso25311995ad.1
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 11:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763150081; x=1763754881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJeHjbo0rkg1+MXurwHM1VKiMZc+qaqYqidGa0aqX60=;
        b=T3QOT7TA4iDP3fyAvLX6GMtLWt3qwzM89whTDtF5FcoLUjed62xixIIhW8d7cph8e9
         9+FbpO5k+xLehC2JW4MB7fqfycoGnc64mmBnr66a7fpG0nI51P5xgUpSJ9rkWZPZse1z
         ZCjzsEwArI50iLgwa4LmSe3zgGBoaRHIMmtlE=
X-Received: by 2002:a17:903:18c:b0:297:df8f:b056 with SMTP id d9443c01a7336-2986a6ba482mr61214845ad.11.1763150081378;
        Fri, 14 Nov 2025 11:54:41 -0800 (PST)
X-Received: by 2002:a17:903:18c:b0:297:df8f:b056 with SMTP id d9443c01a7336-2986a6ba482mr61214535ad.11.1763150080968;
        Fri, 14 Nov 2025 11:54:40 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ea5f9fa4sm3108113a91.0.2025.11.14.11.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:54:40 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v2, net-next 12/12] bng_en: Query firmware for statistics and accumulate
Date: Sat, 15 Nov 2025 01:23:00 +0530
Message-ID: <20251114195312.22863-13-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114195312.22863-1-bhargava.marreddy@broadcom.com>
References: <20251114195312.22863-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Use the per-PF workqueue and timer infrastructure to asynchronously fetch
statistics from firmware and accumulate them in the PF context. With this
patch, ethtool -S exposes all hardware stats.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 872c8b6a9be..dbca011db33 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -253,6 +253,17 @@ static int bnge_alloc_ring_stats(struct bnge_net *bn)
 	return rc;
 }
 
+static void __bnge_queue_sp_work(struct bnge_dev *bd)
+{
+	queue_work(bd->bnge_pf_wq, &bd->sp_task);
+}
+
+static void bnge_queue_sp_work(struct bnge_dev *bd, unsigned int event)
+{
+	set_bit(event, &bd->sp_event);
+	__bnge_queue_sp_work(bd);
+}
+
 void bnge_timer(struct timer_list *t)
 {
 	struct bnge_dev *bd = timer_container_of(bd, t, timer);
@@ -265,16 +276,100 @@ void bnge_timer(struct timer_list *t)
 	if (atomic_read(&bn->intr_sem) != 0)
 		goto bnge_restart_timer;
 
+	if (BNGE_LINK_IS_UP(bd) && bn->stats_coal_ticks)
+		bnge_queue_sp_work(bd, BNGE_PERIODIC_STATS_SP_EVENT);
+
 bnge_restart_timer:
 	mod_timer(&bd->timer, jiffies + bd->current_interval);
 }
 
+static void bnge_add_one_ctr(u64 hw, u64 *sw, u64 mask)
+{
+	u64 sw_tmp;
+
+	hw &= mask;
+	sw_tmp = (*sw & ~mask) | hw;
+	if (hw < (*sw & mask))
+		sw_tmp += mask + 1;
+	WRITE_ONCE(*sw, sw_tmp);
+}
+
+static void __bnge_accumulate_stats(__le64 *hw_stats, u64 *sw_stats, u64 *masks,
+				    int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		u64 hw = le64_to_cpu(READ_ONCE(hw_stats[i]));
+
+		if (masks[i] == -1ULL)
+			sw_stats[i] = hw;
+		else
+			bnge_add_one_ctr(hw, &sw_stats[i], masks[i]);
+	}
+}
+
+static void bnge_accumulate_stats(struct bnge_stats_mem *stats)
+{
+	if (!stats->hw_stats)
+		return;
+
+	__bnge_accumulate_stats(stats->hw_stats, stats->sw_stats,
+				stats->hw_masks, stats->len / 8);
+}
+
+static void bnge_accumulate_all_stats(struct bnge_dev *bd)
+{
+	struct bnge_net *bn = netdev_priv(bd->netdev);
+	struct bnge_stats_mem *ring0_stats;
+	int i;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr;
+		struct bnge_stats_mem *stats;
+
+		nqr = &bnapi->nq_ring;
+		stats = &nqr->stats;
+		if (!i)
+			ring0_stats = stats;
+		__bnge_accumulate_stats(stats->hw_stats, stats->sw_stats,
+					ring0_stats->hw_masks,
+					ring0_stats->len / 8);
+	}
+	if (bn->flags & BNGE_FLAG_PORT_STATS) {
+		struct bnge_stats_mem *stats = &bn->port_stats;
+		__le64 *hw_stats = stats->hw_stats;
+		u64 *sw_stats = stats->sw_stats;
+		u64 *masks = stats->hw_masks;
+		int cnt;
+
+		cnt = sizeof(struct rx_port_stats) / 8;
+		__bnge_accumulate_stats(hw_stats, sw_stats, masks, cnt);
+
+		hw_stats += BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+		sw_stats += BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+		masks += BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+		cnt = sizeof(struct tx_port_stats) / 8;
+		__bnge_accumulate_stats(hw_stats, sw_stats, masks, cnt);
+	}
+	if (bn->flags & BNGE_FLAG_PORT_STATS_EXT) {
+		bnge_accumulate_stats(&bn->rx_port_stats_ext);
+		bnge_accumulate_stats(&bn->tx_port_stats_ext);
+	}
+}
+
 void bnge_sp_task(struct work_struct *work)
 {
 	struct bnge_dev *bd = container_of(work, struct bnge_dev, sp_task);
 
 	set_bit(BNGE_STATE_IN_SP_TASK, &bd->state);
 	smp_mb__after_atomic();
+	if (test_and_clear_bit(BNGE_PERIODIC_STATS_SP_EVENT, &bd->sp_event)) {
+		bnge_hwrm_port_qstats(bd, 0);
+		bnge_hwrm_port_qstats_ext(bd, 0);
+		bnge_accumulate_all_stats(bd);
+	}
 
 	smp_mb__before_atomic();
 	clear_bit(BNGE_STATE_IN_SP_TASK, &bd->state);
-- 
2.47.3


