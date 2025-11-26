Return-Path: <netdev+bounces-242028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CABDFC8BB7B
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 129054EBFC5
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26DD346A1E;
	Wed, 26 Nov 2025 19:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MwFzhtE/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E6C346A04
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186660; cv=none; b=JDEjDEsO1dJZnaju5N3eHFMW+JnSniK3g8R2bLKnYg49VDpdwOHmISgxVkZBC0RPHMpyrGgKPCebZzf0oLnxlBFJpi1rgNGdlqBbaAGKDcDN/gpopVhzvJNe4tL4HaJpBVZ9zL6tAP8jT1xQyz7RrhOSZlvaZkVvpI+cllig9FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186660; c=relaxed/simple;
	bh=mOMNgsdaJGLje42JWqQX6EDqvamZOoQqsVrpT5JU02Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8++qxHMeIbs2I/aVoffpcqC/81jC/LIyhWPTK+vm6/5mJh8WU/QPG+otRs5QIPHc65znlFo8QDX8tQZdGF0tcW38dUknWRksR6ioRzTRZitgpQAbPe0bsaDlTnmtEE8iOBHuqikaM8X5hEkA3qvrjRW8GkSXXo/uaeQyzS57HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MwFzhtE/; arc=none smtp.client-ip=209.85.217.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-5dfa9c01c54so72944137.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:50:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186658; x=1764791458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5S4fHoRERV2MSCcvgLtmo8rkmlmMx1nGkGx6XewVPE=;
        b=vWxwN+rJDGErnICLl/azNwOV0Lv2LpmjKriJHzH6MUZVzRDlu91KJsDDY+IFMj0zDR
         DE/y604XRAIMWDiphxF1ZGZ7oXZwTzlWyQbgF+lXFJifUqApPAgMHCzathF2a5Us7TcK
         MBCn60P9oFC1+P8SgWep7l0BQo+dg1RmqJvYdGj3FAZ+5mrbSF3ZYzgpPDo9bcvLNHZp
         Vl6Qf/QaNLJx4IqmSQvkd1cx6Nd0ZgzhSiiLmdemXamlg25W1shNKcOvXwBZUDPG7zAe
         /leSJrQQs62/VTxsClOn+zYzJn57V/XyE3dI4AQvWdwwhsYUOn0E8hSOoAPp6EPdjK8P
         6N6A==
X-Gm-Message-State: AOJu0Yyp8hCtDGPQrmEiIfa1c449urHlaxGg8ayabYgPFaGliy9UvoaE
	fun4tl2U7IgIYRQeEtIaKZjKnVWVlIxPiqV4VEqomuhxYmEp4Jfmdpf9dUpVgK1vDqDzS1oqBds
	ktDJFjtoaGmOZmxRQby2Fo0xgOvV5Tcws9DPBS5JiQRWK0SuSv2ChZvfwAP1HhYxRwmtU/pHsRh
	YF6pJl/H6w8KQdbXDKQeE7M9YgG+pAkzdu8dj7FEGPKz6qmSjdF2kKc5IcM1Szvj+rNigvhTAz7
	uMrd3RMLniH5yuN+lZt
X-Gm-Gg: ASbGncsVNytLMTOl5xxMbM8+gvXYAj6jDg8YNhrTQfFQ641rFygoJ0HuvIoSTLu6nbK
	hL0KWj75xzwyIsfTSCKn0tL2YCCkCQV68FKblklosXMXlxWI4gk4WQgtLUGE+e70GKy6AfiWb2V
	g5jkaHtlKSh3JqwU+UTCu8+1kM1ZvXc9IXJk4tQKU6CkChrrIap3eUpOhrta5S+sWxpdJqGkOCB
	tM/JqvuYdutUN+a7SVY/m+h7uZpQkyScxMjfFx7QThwv4B0pC3TJTmmG9P1rwadtGYdXxZS2jub
	qqTPmxFY5OCnYXRLdi/H6LRhL35OqKwkh8MNSpzoz7sk4sXLA7cTNm41FHJURT6n4+FyzF+hjSJ
	FeeG4Eo7uAQbd9pQZIUgVY8i1o+p2ieLP2AGte7SfLteyh8b7j6oi1rTvhmmf0TpQqe/zlvojlI
	4Gd2qgD/tABuKc39kjKzO374Lwu36T2Wcm8UBBTBaz73pgkAgK8cshjA==
X-Google-Smtp-Source: AGHT+IH1AX1DL5DJSXjumgQjs/YOkaMP7Hy8vncLbLSxJLaBJSvgBiq7+7lqOXt4fdrxCkPImOMO7QamVRQP
X-Received: by 2002:a05:6102:5805:b0:5dd:c3ec:b66 with SMTP id ada2fe7eead31-5e2243dc73fmr3133850137.30.1764186658028;
        Wed, 26 Nov 2025 11:50:58 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-93c564168c4sm868597241.7.2025.11.26.11.50.57
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Nov 2025 11:50:58 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29557f43d56so1233155ad.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764186656; x=1764791456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5S4fHoRERV2MSCcvgLtmo8rkmlmMx1nGkGx6XewVPE=;
        b=MwFzhtE/VriYPuHpEZa6jVOQAF9NjGgw/LgMP4GKlnA3isBG04z3FVfyHQlelBWC3Z
         SAMrWuvlvA2+ziKqBY8UlRqUWRSSkPXid3hC7TlMjInqDY7OeK0TayIvrYTVRvgGLEAe
         ORToP9iIcZlhdckWKRX0Nvx8WdsHOsdqVRk00=
X-Received: by 2002:a17:902:d58c:b0:294:fcae:826 with SMTP id d9443c01a7336-29bab2fa50bmr91295865ad.59.1764186656359;
        Wed, 26 Nov 2025 11:50:56 -0800 (PST)
X-Received: by 2002:a17:902:d58c:b0:294:fcae:826 with SMTP id d9443c01a7336-29bab2fa50bmr91295605ad.59.1764186655972;
        Wed, 26 Nov 2025 11:50:55 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25e638sm206782375ad.58.2025.11.26.11.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 11:50:55 -0800 (PST)
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
Subject: [v3, net-next 12/12] bng_en: Query firmware for statistics and accumulate
Date: Thu, 27 Nov 2025 01:19:31 +0530
Message-ID: <20251126194931.455830-13-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251126194931.455830-1-bhargava.marreddy@broadcom.com>
References: <20251126194931.455830-1-bhargava.marreddy@broadcom.com>
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
index 824374c1d9c..262713260a4 100644
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


