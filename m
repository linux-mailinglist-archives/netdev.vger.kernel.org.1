Return-Path: <netdev+bounces-260141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKI/MRSUnGnRJQQAu9opvQ
	(envelope-from <netdev+bounces-260141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:53:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C3817B210
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22B2730731A8
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4B033858B;
	Mon, 23 Feb 2026 17:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMB4XFGm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1044E3385B9
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868971; cv=none; b=ghVDZBikDupbNrCv2JZJNsSYEu4UQQcVCws+58qsyTef2VS7y+AZO5VdcuHHzRs19vX7CsFfSKh/6N+8dsM9LvwcEprottm97M5R6Tnh9jOw1C+j2mRFisSiK/h0gUYof47y/gLW5/nulcuboEYD5jdJ+h5mwSZJuz/ejt0fKrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868971; c=relaxed/simple;
	bh=ZkOTi2UUvTtbnAOZSpBwiWZla3um6seugso4ttd7oSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atDStjB4ldujDh9V9kxTaB7iFAQC7JcSQ+MPzBj441W8K7nP+E1WCVFJlif7J4sJfehI4dsT3fAVierzFhfAM7GbvO9AMdC2D6oWp03EJV9aD81J/xmcgCqTEw+yOsg3doa6SWfb4IO9b/qYNYKS3fWtpz31/ztw8JMif+u40ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMB4XFGm; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso39620365e9.2
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 09:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771868968; x=1772473768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSKor1MPqoEHmxj5MNkLKFipMl2iUePtq6WNng5lCV4=;
        b=GMB4XFGmBGlHbyVPcQ5acC5hEMlOYl4JmH5m8taT5cMUHM8KUYg1UpgMOjWZqoFTe7
         S4X3Tgt07VT98csrPZAT3y+nkT7QP7iiUgrYnsFYMInoBWTz945hZwtVAIDrBBdu/Ij/
         h821uBclE9EaoVY6IjR4buZlE9Y2l+Gu4ykyzbAA54SvhEdpi3WA6dSpUTAswR8XvbL/
         i//42z+AMukKKBPNCHXMkdJ8TkUp2YNi2B6jYpJg5bVFRMZawSlOjnkaMr+cTZ5y0nxY
         VNMvJS/mIz1B7XLyVbmH+zKoQazyoTkNHiHIYf/dP7Wxj/3miN1o0qFHpYtqUg+7OwyI
         DcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771868968; x=1772473768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KSKor1MPqoEHmxj5MNkLKFipMl2iUePtq6WNng5lCV4=;
        b=wtKQvpnoy6PTwm4aahKGb2uyeltu8zm2zQDT1u/wKdXqoaZZuMK9XOHO41YMH0FTWj
         Jyy8txSkjEj7+hjBlIz+55x20qksLcX194vaSQCKyiqpU/OkbqQZpf8fwMRMwST9nIsO
         11b0EgScJ2mvGO4gkAnSmjVZygB/mf0j3Gxnmn/EnsBtDN41o/gqndRXJrl4UN/6aEMG
         QkziLvUhSvMpfx+JzydERB6rNhLgPg/hIJZliU+OXMoK8mCiSTz85XAodd/8J3ksCS1F
         XvgRYiTt/jN8D5T4htTnbOCan2rWuQGMomLmKbSDipncHPch0PdhHTmD61XCvlzq9OMB
         pNpQ==
X-Gm-Message-State: AOJu0Yw0+Hd8/oXZMOgQYjLPjpzxZDUNXWTs4Wbcde8yJLHkOQo6dhm5
	e8rhawIdQ7Fdy0tulFm/xSS9uUpZe8CYHS/o2NL9Ak1N1TDSD4ur9go6bEThHovS
X-Gm-Gg: AZuq6aLT4Ax7gtsOtWmGaQPhHaeTwzhkTH+VG8NFZFTjhkbDlFxmmQoW5i2aShg8FDV
	V6jQxwB0z6fkpreWQqz99azej6UkxQmgxb2YtSL6X9I4ihLYj2hUDYR07HMoPBwht3+ec/WDgug
	Xi7FCzfnKcp+NO++yFWmCl6BUidA8BqP6MISl3AnZeWrL7JnC1HvMi8Oy6FlHMjx2cR8K6nKRCb
	0KiN+2TkrcvqE79cQmPpfUtE6KFF/MFllKrwn9OQhx3TAkicFiOzPD+KrRTzeNJ2CqVtm/l341A
	tGfbMV7kGsNEuOe9XCJ0McyhGYjYVPWnEzk4A5lmo+vGe4grHxZaovYsV8E5UOwMi0iqFwbSCAy
	Lox6oQp1pv3cstYmXJ1dyN/TU3sdN9c6iSf+NcRajWZw3ku7pMbwci8YkY+Vz7IiDH6eehHDtRl
	rCImuMw96VMQ+Vo3wkFZWr
X-Received: by 2002:a05:600c:3553:b0:480:53ce:45d3 with SMTP id 5b1f17b1804b1-483a962e3edmr172663145e9.18.1771868967846;
        Mon, 23 Feb 2026 09:49:27 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:74::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b8196087sm6111085e9.1.2026.02.23.09.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:49:27 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	alok.a.tiwari@oracle.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	dg573847474@gmail.com,
	donald.hunter@gmail.com,
	edumazet@google.com,
	gal@nvidia.com,
	horms@kernel.org,
	idosch@nvidia.com,
	jacob.e.keller@intel.com,
	kernel-team@meta.com,
	kory.maincent@bootlin.com,
	kuba@kernel.org,
	lee@trager.us,
	leon@kernel.org,
	mbloch@nvidia.com,
	mike.marciniszyn@gmail.com,
	mohsin.bashr@gmail.com,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	vadim.fedorenko@linux.dev
Subject: [RFC net-next V3 4/5] eth: fbnic: Fetch TX pause storm stats
Date: Mon, 23 Feb 2026 09:49:13 -0800
Message-ID: <20260223174914.74461-5-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223174914.74461-1-mohsin.bashr@gmail.com>
References: <20260223174914.74461-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260141-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,oracle.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,pengutronix.de,redhat.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67C3817B210
X-Rspamd-Action: no action

With pause storm protection in place, track the occurrence of pause
storm events. Since there is a one-to-one mapping between pause storm
interrupts and events, use the interrupt count to track this metric.

./ethtool -I -a eth0
Pause parameters for eth0:
Autonegotiate:	off
RX:		off
TX:		on
Statistics:
  tx_pause_frames: 759657
  rx_pause_frames: 0
  tx_pause_storm_events: 219

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h      |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c  |  3 +++
 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c      | 15 +++++++++++++++
 4 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index e68c56237b61..72eb22a52572 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -627,6 +627,7 @@ enum {
 	FBNIC_RXB_ENQUEUE_INDICES	= 4
 };
 
+#define FBNIC_RXB_INTR_PS_COUNT(n)	(0x080e9 + (n))	/* 0x203a4 + 4*n */
 #define FBNIC_RXB_DRBO_FRM_CNT_SRC(n)	(0x080f9 + (n))	/* 0x203e4 + 4*n */
 #define FBNIC_RXB_DRBO_BYTE_CNT_SRC_L(n) \
 					(0x080fd + (n))	/* 0x203f4 + 4*n */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index ade9e667640f..70c995b8d1bd 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1754,6 +1754,7 @@ fbnic_get_pause_stats(struct net_device *netdev,
 	struct fbnic_net *fbn = netdev_priv(netdev);
 	struct fbnic_mac_stats *mac_stats;
 	struct fbnic_dev *fbd = fbn->fbd;
+	u64 tx_ps_events;
 
 	mac_stats = &fbd->hw_stats.mac;
 
@@ -1761,6 +1762,8 @@ fbnic_get_pause_stats(struct net_device *netdev,
 
 	pause_stats->tx_pause_frames = mac_stats->pause.tx_pause_frames.value;
 	pause_stats->rx_pause_frames = mac_stats->pause.rx_pause_frames.value;
+	tx_ps_events = mac_stats->pause.tx_pause_storm_events.value;
+	pause_stats->tx_pause_storm_events = tx_ps_events;
 }
 
 static void
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
index aa3f429a9aed..caea4be46762 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
@@ -54,6 +54,7 @@ struct fbnic_rmon_stats {
 struct fbnic_pause_stats {
 	struct fbnic_stat_counter tx_pause_frames;
 	struct fbnic_stat_counter rx_pause_frames;
+	struct fbnic_stat_counter tx_pause_storm_events;
 };
 
 struct fbnic_eth_mac_stats {
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 805107ba3b10..53b7a938b4c2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -418,6 +418,18 @@ static void __fbnic_mac_stat_rd64(struct fbnic_dev *fbd, bool reset, u32 reg,
 	stat->reported = true;
 }
 
+static void fbnic_mac_stat_rd32(struct fbnic_dev *fbd, bool reset, u32 reg,
+				struct fbnic_stat_counter *stat)
+{
+	u32 new_reg_value;
+
+	new_reg_value = rd32(fbd, reg);
+	if (!reset)
+		stat->value += new_reg_value - stat->u.old_reg_value_32;
+	stat->u.old_reg_value_32 = new_reg_value;
+	stat->reported = true;
+}
+
 #define fbnic_mac_stat_rd64(fbd, reset, __stat, __CSR) \
 	__fbnic_mac_stat_rd64(fbd, reset, FBNIC_##__CSR##_L, &(__stat))
 
@@ -812,6 +824,9 @@ fbnic_mac_get_pause_stats(struct fbnic_dev *fbd, bool reset,
 			    MAC_STAT_TX_XOFF_STB);
 	fbnic_mac_stat_rd64(fbd, reset, pause_stats->rx_pause_frames,
 			    MAC_STAT_RX_XOFF_STB);
+	fbnic_mac_stat_rd32(fbd, reset,
+			    FBNIC_RXB_INTR_PS_COUNT(FBNIC_RXB_INTF_NET),
+			    &pause_stats->tx_pause_storm_events);
 }
 
 static void
-- 
2.47.3


