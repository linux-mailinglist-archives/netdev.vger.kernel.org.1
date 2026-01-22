Return-Path: <netdev+bounces-252507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIAZEed4cmlSlQAAu9opvQ
	(envelope-from <netdev+bounces-252507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:22:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E3D6CF75
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A5C3301324E
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A613915AB;
	Thu, 22 Jan 2026 19:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQdVvVgS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E3733A6ED
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769109730; cv=none; b=NUta7z4sAWUEqmaNBMUsvH81pHvfilj5u27fVEZo4yeqSgh+A8RHMoSzBHmJz1bVlcb0O+5rKAMZ233EFl9HJ2wg/TtqUVL2Ci6KRC7PrbN1D1RQiQakeSFA6IiItTj+v7rrwUttcKeS/kNdZTCsE4hvMwhBWUrf+BiNyQTa1LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769109730; c=relaxed/simple;
	bh=4c97E3l1fDx5rP31BJdStxGgz1jks7S0fHhu8URAe6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvUpBjEGnWYMCM/OYk1UU8q5L4jnHnI715DTnZUtL6qCBiuhMOtr8viPXO1+ofBeGlOKGf9SkEuq4ELyMdElbfZ8WC8+Vnsi241cyw6GpxHY02M64rdNX2682LtEKHXkIusbRBQgXHtx+3yrqFkY4LhrLIP66J+/ngenRq/Pu6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQdVvVgS; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4359249bbacso1634263f8f.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769109723; x=1769714523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5h0Bl07+wUVkPYukWTkRgRpTRDTreTtiujhSkbJvfK8=;
        b=PQdVvVgSUXcBam3xwYDq4CcabPPGHyVNrkNm+B2CpSQrRVqxL2apIhEKN2ukKYKBkK
         yHCBDjSy1jIZPJ62BBjsJCb6HhqqF4xQq1zbCv/UEqIVin9BYFqinIF6bRFpZOOgnqFW
         d5xzOk8Pg8nOGPFPeTVR+RhWHfdbcrcetdNnmHeslSpVZmFDky7vB/pKteCx0CP+P79o
         1aaT5Zw76yVk6ecE+LVZ54FTfHc7KARaWGoRJOzbUik0T3Qec8t793TB3ZWCsjWe7U4Z
         zCYggndXqVc6Gh7u0RiV+J/fxhG9S0ANzNMlOFpemrTOSWq5TsesXPd9TioR6Vj2syoc
         UHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769109723; x=1769714523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5h0Bl07+wUVkPYukWTkRgRpTRDTreTtiujhSkbJvfK8=;
        b=jqKmLM5HTCSYsSDQgRfE9GCk1RqKegkwP7Nb3QxdQ0FzmKmQ4Fm1rZMTUQ4UliCh8f
         cgtYaezoX47DogwVceL1/HbLA+8AwFgHcPVuMsN18FnHZNCKcYV1oWb43mtXPsHX33Ig
         jKa7/t0RyID829JAvvgPVr7GgeR91WH3QxbXN1r/GyFCnpfBpojEy3zEDmjHFVLQs18c
         P1QR44AIgKAHsfVZPhd7QJUKxfhUvB4TPlGoYYJiJkB8FTs4RCWTeHlsSUZpBcZPH8wt
         I9Td7tyXLCbgYepgW4UU2xkisieuQdejbnsoFHfKJEHsd2x0mcsVUF02oUHFz1vOGAcB
         4yhg==
X-Gm-Message-State: AOJu0YyTRzf+uM+zCJ763D/7pmIoiAG3gU3mMPOgxZrfLWYuxdHwfnJK
	rgvcuJB21j3nudTNt66itCLEny6SCmWbj8hZSQh5qnSKQT34V8MFSgkhcg6IrzDt
X-Gm-Gg: AZuq6aKA8X4FcMovFIpKxp5/lIVyisp5F5AbA86cwCeD2g6V3UiMt2EJCIPTLShawNZ
	UUFGx5QWEktw81maOcs9GEdlLGUfZqFoUcHUCU3SEw8UwmEjhhx7jzVl7xB8g5rpP2ggUQPO7QR
	SiQSQ9fSYP/eh2LsRFmm5FsMPzsuk0VuAFV2VY3m4rEQ1w8Udz4y48jXSbO4rCNsNUNMxX2zML1
	p4jBRN08Jt5DHkEzy6aaw35N4Ly44mlh2Qjc7XBzEnIUdsB7KNy82TKP2aWFFNjuLGzQrfYx3nG
	51wYUHY+UpZEHHeCOXoxlltrJ9t4eZ9/mGHP0gkshFfmBF7YyWSrbyxrgpJaWoY51PFSALywz7E
	n+X4s33Fl6nwU+APnwU4/CL1YvHk9akJUNYwOXGljEayUST4at7phJu8hX70ii/65VH19f0MHdX
	arIAKqKbs=
X-Received: by 2002:a05:6000:2c07:b0:435:9a18:5a29 with SMTP id ffacd0b85a97d-435a5f6df34mr7592341f8f.11.1769109723304;
        Thu, 22 Jan 2026 11:22:03 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:9::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c02cf6sm860246f8f.7.2026.01.22.11.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 11:22:02 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	alok.a.tiwari@oracle.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	chuck.lever@oracle.com,
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
	mohsin.bashr@gmail.com,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next 1/3] net: ethtool: Track pause storm events
Date: Thu, 22 Jan 2026 11:21:56 -0800
Message-ID: <20260122192158.428882-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260122192158.428882-1-mohsin.bashr@gmail.com>
References: <20260122192158.428882-1-mohsin.bashr@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252507-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,oracle.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,pengutronix.de,redhat.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86E3D6CF75
X-Rspamd-Action: no action

With TX pause enabled, if a device is unable to pass packets up to the
stack (e.g., CPU is hanged), the device can cause pause storm. Given
that devices can have native support to protect the neighbor from such
flooding, such events need some tracking. This support is to track TX
pause storm events for better observability.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 Documentation/netlink/specs/ethtool.yaml       | 13 +++++++++++++
 include/linux/ethtool.h                        |  2 ++
 include/uapi/linux/ethtool_netlink_generated.h |  1 +
 net/ethtool/pause.c                            |  4 +++-
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 0a2d2343f79a..4707063af3b4 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -879,6 +879,19 @@ attribute-sets:
       -
         name: rx-frames
         type: u64
+      -
+        name: tx-pause-storm-events
+        type: u64
+        doc: >-
+            TX pause storm event count. Increments each time device
+            detects that its pause assertion condition has been true
+            for too long for normal operation. As a result, the device
+            has temporarily disabled its own Pause TX function to
+            protect the network from itself.
+            This counter should never increment under normal overload
+            conditions; it indicates catastrophic failure like an OS
+            crash. The rate of incrementing is implementation specific.
+
   -
     name: pause
     attr-cnt-name: __ethtool-a-pause-cnt
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 798abec67a1b..83c375840835 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -512,12 +512,14 @@ struct ethtool_eth_ctrl_stats {
  *
  *	Equivalent to `30.3.4.3 aPAUSEMACCtrlFramesReceived`
  *	from the standard.
+ * @tx_pause_storm_events: TX pause storm event count (see ethtool.yaml).
  */
 struct ethtool_pause_stats {
 	enum ethtool_mac_stats_src src;
 	struct_group(stats,
 		u64 tx_pause_frames;
 		u64 rx_pause_frames;
+		u64 tx_pause_storm_events;
 	);
 };
 
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 556a0c834df5..114b83017297 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -381,6 +381,7 @@ enum {
 	ETHTOOL_A_PAUSE_STAT_PAD,
 	ETHTOOL_A_PAUSE_STAT_TX_FRAMES,
 	ETHTOOL_A_PAUSE_STAT_RX_FRAMES,
+	ETHTOOL_A_PAUSE_STAT_TX_PAUSE_STORM_EVENTS,
 
 	__ETHTOOL_A_PAUSE_STAT_CNT,
 	ETHTOOL_A_PAUSE_STAT_MAX = (__ETHTOOL_A_PAUSE_STAT_CNT - 1)
diff --git a/net/ethtool/pause.c b/net/ethtool/pause.c
index 0f9af1e66548..5d28f642764c 100644
--- a/net/ethtool/pause.c
+++ b/net/ethtool/pause.c
@@ -130,7 +130,9 @@ static int pause_put_stats(struct sk_buff *skb,
 	if (ethtool_put_stat(skb, pause_stats->tx_pause_frames,
 			     ETHTOOL_A_PAUSE_STAT_TX_FRAMES, pad) ||
 	    ethtool_put_stat(skb, pause_stats->rx_pause_frames,
-			     ETHTOOL_A_PAUSE_STAT_RX_FRAMES, pad))
+			     ETHTOOL_A_PAUSE_STAT_RX_FRAMES, pad) ||
+	    ethtool_put_stat(skb, pause_stats->tx_pause_storm_events,
+			     ETHTOOL_A_PAUSE_STAT_TX_PAUSE_STORM_EVENTS, pad))
 		goto err_cancel;
 
 	nla_nest_end(skb, nest);
-- 
2.47.3


