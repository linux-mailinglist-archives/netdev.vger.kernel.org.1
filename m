Return-Path: <netdev+bounces-257679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGaFLCeQhmlwOwQAu9opvQ
	(envelope-from <netdev+bounces-257679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 02:06:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB84610468C
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 02:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4175D305EC2D
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 01:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2009B23E358;
	Sat,  7 Feb 2026 01:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtDr9vkH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68BD23C8A0
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 01:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770426349; cv=none; b=KVlf2iSC3tRW4j7rWwCaOtszhhNEW5sEEd6JR6KWZOAYbyXR2dZ738fvqn4A59Dpd4AywEs8CSTSKHr0+OdCY2yFWoufXboI9s49IgpB43xvK60C8XBT26nKtHYdQ6F2bj8q5AR3d6Phk8K7/B3LAaLZ02GqRxVZVWU1DMfb6fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770426349; c=relaxed/simple;
	bh=bcCx6HvBn0+chH2BkVmgtrY08qINfxUdLSUwj8yhhhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2YW9hS8aEFs6jfVx/jBQvxd2Dxdw3o2tc4O1QgrNpVlGGhAriAKSZnibKozBKmLkPa01lOkTMEuGcbpY/pXwUgixkk18aCiB1cewbMWQWqpE6iScNsZTCwSib3UmghPoefLU48CsaI8C2ltIMxIkE9pPDK6ncsGNvABGjC1J1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtDr9vkH; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43624d7256bso1621213f8f.1
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 17:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770426346; x=1771031146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6SIRr3fzUj0Hk1tRyParUBPPpIXg889DTrd52bS/88=;
        b=RtDr9vkHduqjyu2vfUGnB92UTSgwg9hbx6gTrU7te0cxbuFnkzFRTAFrntzP4OCKlz
         GacROgmu5unFIwYq+NVNxUhp59pxAnkI8tr4T/gnslBjqX/FGAhrHiPqRnFRW22aiRDB
         PQi6FuvLMIk52P5b+6tbmEVzYscBJlCFK6Wb8a3u9TtWosEnfOmfx8VI+vgEhTJsicxN
         lqnGj2UaF5fXIz14GD8H7wNFNKnmApZZwzgv0e8gFSkFtmmbupM1cSrxMucq5WmRWLht
         3CgdvDuVlYhr0H38E2ViO7ehvktanMUi/eHH3pc91pAvfkzzKoCT5EYmcCiJKn8tasVF
         1ATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770426346; x=1771031146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A6SIRr3fzUj0Hk1tRyParUBPPpIXg889DTrd52bS/88=;
        b=vQ3WwBrSI5n29lN6N6MLx3yDP27daaV15uGt9qI1ifo9Bi4Kj6qsbHBOQ6inWk35oq
         sWovYjFg4Ugd5ywRdWzQM3E8Y7Yaed5aZYxkWg1PDn7qrJ8xn8WI6lv/8GekpA1WGeqy
         SRfxblzaC35+y2q4MdLwureHpbNqMwWlMALY+dqIJx9bTq4g+Z7eceSZDOBqJorruAXW
         285UabL0o2jlDph96jjdXIcqGG48XGe3V2jb6VhzQ2Og9edU4T49eNNX26rw1RlMqyuK
         6u6Rf7ZhhiuKAqz9da4uQXCO/z/OhWdUgZN5LHY3+waFEko2oFDiDxbYJpswdmu2Qmdc
         XAQQ==
X-Gm-Message-State: AOJu0YxVybLCEApjJMtZ9rM09p5+ogkA0wBsSSPfOeqtxsr2Mio+H9eO
	P13WQvWaw2jMCr9uy3RQABO+BSVVjyN41+wB6HSQ/UoTWLX03UqkGd0MZpsS61cb
X-Gm-Gg: AZuq6aJidFzMx6VAfyqf1kmMunnZNyJ+i3swormM8kOzi9nhcXVjj443/x7B8Qmfwbe
	kQRnXeP2ghbeHkW9YJCYxfYznWXMAt+jIEC2+dyvzH8D445MS8BsvP1Y2iV8Abwss6ICOJ2LTkL
	5SpW9EtQiY3Vgf+ILpDaZlxGKXtVVbV3SNyszvM4HGhr+tbn3nRtK3+THfWJlxgtS08YMrSKOHL
	Vi+wYngJrcE1xzA/IKOelr6MSIxHaA/O9rtjBNmXXD8VYOJ6j3T92EBknACd/yi8LpMkW99P8lR
	CzM/nRm3JDPXM28AyksGii/e2Yf0g4YcyLYks//OPQgCC+kUnHe4yWEcMo3EobKo9ijRwkpFdiV
	+xYT+c6w/Ten6+AJFx1qaEPgXg9LtxKiZQiXzAzIX1SYKWr1zQ19KrYb0FFBYH6eiwK6jg2UvWg
	7dODBhwFVi
X-Received: by 2002:a05:6000:2411:b0:436:1946:c186 with SMTP id ffacd0b85a97d-4362933cb20mr6948634f8f.10.1770426346312;
        Fri, 06 Feb 2026 17:05:46 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:5f::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436297450b4sm9990741f8f.34.2026.02.06.17.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 17:05:45 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
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
	linux-rdma@vger.kernel.org,
	linux@armlinux.org.uk,
	mbloch@nvidia.com,
	mohsin.bashr@gmail.com,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next V2 4/5] eth: fbnic: Fetch TX pause storm stats
Date: Fri,  6 Feb 2026 17:05:24 -0800
Message-ID: <20260207010525.3808842-5-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260207010525.3808842-1-mohsin.bashr@gmail.com>
References: <20260207010525.3808842-1-mohsin.bashr@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257679-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,vger.kernel.org,armlinux.org.uk,pengutronix.de,redhat.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB84610468C
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
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
index dc57519ebbe5..15d3162ab186 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1751,6 +1751,7 @@ fbnic_get_pause_stats(struct net_device *netdev,
 	struct fbnic_net *fbn = netdev_priv(netdev);
 	struct fbnic_mac_stats *mac_stats;
 	struct fbnic_dev *fbd = fbn->fbd;
+	u64 tx_ps_events;
 
 	mac_stats = &fbd->hw_stats.mac;
 
@@ -1758,6 +1759,8 @@ fbnic_get_pause_stats(struct net_device *netdev,
 
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
index be834983e981..8e6b589c25b8 100644
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


