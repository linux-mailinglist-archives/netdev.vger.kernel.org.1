Return-Path: <netdev+bounces-269309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBAhBUSQu2lmlgIAu9opvQ
	(envelope-from <netdev+bounces-269309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:57:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0F82C6678
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9090231CBA5A
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 05:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FEE399011;
	Thu, 19 Mar 2026 05:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NxQEEq4a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE9439A05F
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 05:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773899581; cv=none; b=o3paMxJQ3ne5AnpACMhWnlAApVaa91aM4Y3U/d8z3SrcnpK2WJ0qld/0Rw6xRZRjfaC6eqDAyPee1Z6WDNeb7Pzn9IEUBe/jYP1PL94TGUxMOaQRWtvcQLUcXwsvQazLQvYwUFu0M1NDRIQPMx7+tT9U64ErFNXKb5rAx2rBc9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773899581; c=relaxed/simple;
	bh=uNBl9Psxva5SJPexCKlx/63Rr8yoHyHROPl3twU89Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYxyS4QToVnZy7KIJJS7C58bEPvN5+ZeKZ5eSL6OxFqeevpNrfzg0L40MLzXpJQhNXXguQRP5H/qXjfLq0fnZJ2mitwfgfmcVDkucmvW7rre7N85i/Csif+7gxiB5meP2l6MEKbPEEwLXhtZXZ+oc9y5Ivlu4OgXhA9QXvh6opU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NxQEEq4a; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-79a46ebe2beso2159577b3.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 22:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773899578; x=1774504378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kebxp6wh4nYYGznvwFFSyNwKbOSUnFEmSaJutA9Bji8=;
        b=RhNj5w9FwOZ6xiF3YZGMlgKHA0LNEuD/5U3/ATmDrV8rPaNlEEkFWxvPHO8DVEU6Zg
         uG89j/Dl+jcjgdKdZKDFDwD4/1LSEMxouEmuPeABGvD90vfHdQRhxwDAts6Tbg+U64uI
         dv4S4utQQcVvycobcJ9WvFV0dyPGuO8QwgYJjwPbyAx8krZ2Jg8cpHA9wbK1bO608xBM
         QhT9LBBxz4COaMzJHEYU8Ku+nrzKMBBZbnWqOtoaGuZch6ZZiP2Dyyz3sQSMB+wtazqB
         NPSWUVfL6Hx5j8+xlCF4MEFaOT1o7APDnQ7I5LhGHPYQg0q1eH/a2k9/GzX7Wgn1aj7V
         /d4w==
X-Gm-Message-State: AOJu0YyjsElJd7urcIPzPI/076fsGRf0d0GlOTvRlUMAsHY4VS5ULejD
	d2QlVzEBbDaes4+5WCUF2s651WJWyaNcpU7/zFrUyV45xHFsJK4uV1uXuxRclxE/Kzkc3lLKQFr
	EOh7hGNYYzIEXbTFesgrlQRb6U5XjOb+JP6XpJCmlJJJO+uPvPcnyOcPOCfDvjZnJkPMwGL4xBD
	26kLglQHwItcCRpnV10DCI2WrbtBPBMz84HI9I3K+uftta1LUoQAFekCga0bb/zCmkBkQvr7LQM
	q2f43oyjw==
X-Gm-Gg: ATEYQzzG91Pik397zY9Ma54c8oBptbYyhs9n76s1gMXhz3ipjwl674KtrXAahQXtMr4
	8JpUWrOobLw0R3CmbWGy+XDX3f8V9jPpXlcgctOAFLABPt6jv2FwmeJLZsYmjReWVGx9IcR4IdD
	JbTLrfmabsoiad2aM0K+G+mXpKKYEHX09BsXm1ldow0+I4HAuReB7HXPe8FfDdyYuo1eiUclDD2
	eVqlYd1+3xt27CFfE+GVhgnHv7yoT5rlzcaB+Y2xKcE2wC5IeZ6Ewp80OQg+0jCvISjjCIpKDFq
	VKQIEuZUS/lIB/QcZfhvsCFeJ+aTKQ/nQpPT1/4ihRDYEGp1GGrfV9irFqa3jpXoPf0BZtRNduc
	BXod9fYe2C/UqspyMfAWOSsXEqhvDZcoqxA2u8uZdB/Onht0RSm0ph2PwP6JjkFV8peGLQFUT2+
	V6jzZPYZC4miBMxWeAkcJmXjtvFklK6jCOFZBHNl+Ng/OtKMLjjfLTA1U=
X-Received: by 2002:a05:690c:387:b0:79a:7cae:f11a with SMTP id 00721157ae682-79a7caef406mr36439277b3.18.1773899578471;
        Wed, 18 Mar 2026 22:52:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-79a71385706sm4286577b3.6.2026.03.18.22.52.58
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2026 22:52:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-794d80fea59so4460067b3.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 22:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773899578; x=1774504378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kebxp6wh4nYYGznvwFFSyNwKbOSUnFEmSaJutA9Bji8=;
        b=NxQEEq4aa7HpC+t3A1hKxltp30Sx8N46DqSQgLhOeTW95oGuH4q0d2CVmnY+35UJN0
         782mnWgw7DNYN+b42NmgjTaSPxk8HkVJue0Cj2NbovEv7aj4unY3oOQJmNvSW+Rw9Kgk
         O8gAhj3ExzyS+I1+OPNZv3rWwuOifaxAu057Q=
X-Received: by 2002:a05:690c:45c1:b0:79a:5508:5831 with SMTP id 00721157ae682-79a7190cc29mr65815047b3.20.1773899577870;
        Wed, 18 Mar 2026 22:52:57 -0700 (PDT)
X-Received: by 2002:a05:690c:45c1:b0:79a:5508:5831 with SMTP id 00721157ae682-79a7190cc29mr65814857b3.20.1773899577410;
        Wed, 18 Mar 2026 22:52:57 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e91a1cd32sm2918980d50.2.2026.03.18.22.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 22:52:57 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
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
	rajashekar.hudumula@broadcom.com,
	ajit.khaparde@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net-next v8 07/10] bng_en: periodically fetch and accumulate hardware statistics
Date: Thu, 19 Mar 2026 11:21:21 +0530
Message-ID: <20260319055124.1350670-8-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260319055124.1350670-1-vikas.gupta@broadcom.com>
References: <20260319055124.1350670-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269309-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.967];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8B0F82C6678
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>

Use the timer to schedule periodic stats collection via
the workqueue when the link is up. Fetch fresh counters from
hardware via DMA and accumulate them into 64-bit software
shadows, handling wrap-around for counters narrower than
64 bits.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 90 +++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  1 +
 2 files changed, 91 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 9f62b5f19a2e..93f0149bd775 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -313,9 +313,93 @@ static void bnge_timer(struct timer_list *t)
 		}
 	}
 
+	if (BNGE_LINK_IS_UP(bd) && bn->stats_coal_ticks)
+		bnge_queue_sp_work(bn, BNGE_PERIODIC_STATS_SP_EVENT);
+
 	mod_timer(&bn->timer, jiffies + bn->current_interval);
 }
 
+static void bnge_add_one_ctr(u64 hw, u64 *sw, u64 mask)
+{
+	u64 sw_tmp, sw_val;
+
+	hw &= mask;
+	sw_val = READ_ONCE(*sw);
+	sw_tmp = (sw_val & ~mask) | hw;
+	if (hw < (sw_val & mask))
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
+	struct bnge_stats_mem *ring0_stats = NULL;
+	int i;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr;
+		struct bnge_stats_mem *stats;
+
+		nqr = &bnapi->nq_ring;
+		stats = &nqr->stats;
+
+		if (!ring0_stats)
+			ring0_stats = &bn->bnapi[0]->nq_ring.stats;
+
+		__bnge_accumulate_stats(stats->hw_stats, stats->sw_stats,
+					ring0_stats->hw_masks,
+					ring0_stats->len / 8);
+	}
+
+	if (bn->flags & BNGE_FLAG_PORT_STATS) {
+		struct bnge_stats_mem *stats = &bn->port_stats;
+		__le64 *hw_stats = stats->hw_stats;
+		u64 *sw_stats = stats->sw_stats;
+		u64 *masks = stats->hw_masks;
+		u16 cnt;
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
+
+	if (bn->flags & BNGE_FLAG_PORT_STATS_EXT) {
+		bnge_accumulate_stats(&bn->rx_port_stats_ext);
+		bnge_accumulate_stats(&bn->tx_port_stats_ext);
+	}
+}
+
 static void bnge_sp_task(struct work_struct *work)
 {
 	struct bnge_net *bn = container_of(work, struct bnge_net, sp_task);
@@ -327,6 +411,12 @@ static void bnge_sp_task(struct work_struct *work)
 		return;
 	}
 
+	if (test_and_clear_bit(BNGE_PERIODIC_STATS_SP_EVENT, &bn->sp_event)) {
+		bnge_hwrm_port_qstats(bd, 0);
+		bnge_hwrm_port_qstats_ext(bd, 0);
+		bnge_accumulate_all_stats(bd);
+	}
+
 	if (test_and_clear_bit(BNGE_UPDATE_PHY_SP_EVENT, &bn->sp_event)) {
 		int rc;
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 74b08d492c53..548c5a77e76a 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -276,6 +276,7 @@ enum bnge_sp_event {
 	BNGE_LINK_SPEED_CHNG_SP_EVENT,
 	BNGE_LINK_CFG_CHANGE_SP_EVENT,
 	BNGE_UPDATE_PHY_SP_EVENT,
+	BNGE_PERIODIC_STATS_SP_EVENT,
 };
 
 struct bnge_net {
-- 
2.47.1


