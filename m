Return-Path: <netdev+bounces-260139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL5NF3WUnGnRJQQAu9opvQ
	(envelope-from <netdev+bounces-260139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:55:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D13F917B26F
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47747312692B
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029EB3370FE;
	Mon, 23 Feb 2026 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MF5pWFRT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F82337BB3
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868963; cv=none; b=cKmATHoQZ/wDUTgz2X8UHaGXTZuon4giMy4ckAfVtZ4wKDWRN3/2AUiASrBgHQBbgAz+xtQwwjig3S8cIdF43/RA5iN9RJP305TMgAMJbf0x8hNSW1REebzQOyTxebvgzP+vLgwf3zRD1N+R2rJLWODgQybxjUe4lfGMk2TGDuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868963; c=relaxed/simple;
	bh=jtAGi9DQaWzXLODVOTCgm+wmpbk44RLYuX+NUnR+7wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUj/LpumpFasUkYqrwUIf8VMX9m39BpvBd/9YBKBkQBvfmulw9CjAR+GUtXlLG2puaFt2sxkJog8EnDc2QNut4e2UX5z9bAJBA9z5Jsby7n9w9XLfvCA5P/R3Wu4iJaOPuHcElrFy2X1qr4UHtGjDMmSUxWDjwNDjC1qnpGigQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MF5pWFRT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4806bf39419so42060005e9.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 09:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771868960; x=1772473760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mREFoc1kc5FzpHOc1QSZ9MufAhMpT9v5zNSRC90OfQ=;
        b=MF5pWFRTd+rdUvWenV2r//8k3bp5jRUuhGipVFzsNoDufTr1Js4c7fLIMxfGkQvUwR
         GLXoaoyn6K62yN+4gWCuk5SyuNTbE9vHBvMl6O0diT5OcreaE/9NENE7fN0WGE9AoS/G
         c8Lv/Y85JdEUCe0D0st8yVz0tMAoMeMFAb1jWViPYtHa8ebgr7bZ+mehjPDuOZVBcU71
         63/jQHsuJ37w8xQe4AQw8i13ZqasdEy8QwGHhYzj7lQpIipXzDMHfs2gNzllsXviYmtF
         AQemuKpBLo8jYoW2LHWqxip+5hJFMuBNbRai+Nq66AyXV2mWOgYKQ4UWdw2dYJIlmTHL
         SPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771868960; x=1772473760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6mREFoc1kc5FzpHOc1QSZ9MufAhMpT9v5zNSRC90OfQ=;
        b=Y8S+5Qrv8IL2GGX4dJuZxL3iUkfanOsOx8hgpyQ4IVpTsazMLoHza4hGWf7Ur6fsEy
         I5HPhO21ArXw/c7RcCnqMUbM4IBRCOLQfoOOHiZbe+l79dhl1Dpe0B40ddQA8zCmajy2
         HKheGXJ4DDELU69p7IPIMzofXllPuQW6vPMBppNue80Svs+MmNIWa5S3wQ/N6siK0rDd
         NGOtooiuep/eCjxNLFx/tEMz4O4joGH+2tDPVRTXR7vXyBABe4pK9EH8vpsVDcBSn/ic
         q+wTa0BswNzdjfUX4SGTa6dqh2J9YVk2IWoUdzldaksO+zYUdRGjXK/cKYwRWa+xf7DB
         bfsw==
X-Gm-Message-State: AOJu0Yzro8TqxfNnZGNxHhBJHlu3Mqyjo9DmGrmnt7rSx13IRPNjQmqk
	qwuQl1i3ZvRd7P+yY3qLGduJMLKpxXwfS1s58kQJeNYjeJunT9Fb8i1p7/UwsFX8
X-Gm-Gg: AZuq6aLSMchsuyVds4+SVD390KV0zMqnb50AWJuWr6SiZoFHRld658s1TAOIlZu7jQ+
	cq1s1s3OY1GVhW7J6qB3+W+5wvMV06KsmoF8SkQfs3qiHaeWpMZc3zEJpBPO7Na0yeBdXd7Or5F
	GHNUfiiE27y1O8kculAQjLMzRpwmhhn5q8LntG/HovwmNJiraFHdnvbp11rhf80VNEeke5wjW+c
	wVWX+XxTzzx5I2XZ7uFUv3yUZXpNA8g2qFJfVraBrajl2hwQ6QqK4PYbaoVSwyiQB+9nrOsy9hM
	MCbyHEAlTcA62itScDsb3gC7ByYII8DA/NVfwSdvSI13V7ni2bdXdKGV+EOP65Pbjmy+3pi78ep
	iRCejDrtOwlLi3Bx7oxhB++6Mpg/0z7yijKwIirvdv1SWLNz9mwEHKP7+jKFnBbEfk25gAqjuTj
	ixBMy6X4DOd3K3sU0+LolF
X-Received: by 2002:a05:600c:6a82:b0:477:991c:a17c with SMTP id 5b1f17b1804b1-4839fe97558mr177423955e9.6.1771868960391;
        Mon, 23 Feb 2026 09:49:20 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:75::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9fb2sm21626408f8f.1.2026.02.23.09.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:49:19 -0800 (PST)
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
Subject: [RFC net-next V3 1/5] net: ethtool: Track pause storm events
Date: Mon, 23 Feb 2026 09:49:10 -0800
Message-ID: <20260223174914.74461-2-mohsin.bashr@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260139-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: D13F917B26F
X-Rspamd-Action: no action

With TX pause enabled, if a device is unable to pass packets up to the
stack (e.g., CPU is hanged), the device can cause pause storm. Given
that devices can have native support to protect the neighbor from such
flooding, such events need some tracking. This support is to track TX
pause storm events for better observability.

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
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


