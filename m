Return-Path: <netdev+bounces-278705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DF9JjBM32mFRQAAu9opvQ
	(envelope-from <netdev+bounces-278705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:28:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52857401F5F
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD6B030C8489
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E493CF020;
	Wed, 15 Apr 2026 08:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVGWEQsW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DCB3CF02D
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241655; cv=none; b=q1k7r+SdD6dmhjSGv2D4eD1CCh7bXrLWBO3n2c9g4bYXeq6ksDy9QFpaRZ7Yc5RybFUFzF7WaMwV/0r84b3paQQlfREfqgbCif3DKVm54ummUCE9ZLkC5x0RXl2TA4Y/9pBQlJPWsaFVUZsDo545m06rfoCdYA21eu6CTrNjDh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241655; c=relaxed/simple;
	bh=w3ecYzeaYIX144bVqfj87tUxIv4KDadRulXpFJ/Fy+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=my15g4aouAda4aRRYgvDeU/f4qe8VKQz6XUitJMHmBbwPlKNORvCgInAP5GQlnxIGJV9kvQniRGLa1NyQoC1/Zd3oVHvlhyIgaQG0Dto1JFUGcCrDgBeMQ21wc1nywqN8HkxPU/0BRUfaZL/zRmrytJPFRkr9vWlf7PTH8u0LSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVGWEQsW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b299b3c739so28005775ad.3
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 01:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241654; x=1776846454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HPTqFxSpqPQ2VPcQ/yN5CAn5MjWpzRzTPnq/lPxxAM=;
        b=SVGWEQsWW8PCfLBa3t+5vAwDgtq09Ia9s0y7qw8d5hAp8d1NbzP0cbObFlXTzpGMOF
         9DRhWeInJWLIlCIw1vMaM7n3Dhl2R5dRKK4dLFxoao84b9K9vlcokKt5TJGfmf8QzTVT
         8xuwUS6LRuVMRTUX6Eip7QRqT04bwYkRKzN7mBlMYe8GmK1xbfklmv2TtE/cS2gDmwpZ
         O8+tDDWnT3mF5617Cd9F060F8FTzAggKCmph18XsW7OQXdLH6HEcr6mWPHYUV9WInx/B
         MqfTx8xY2dL+ow/cSHXF7bEQZB6QZ0cKHwUCq2SnZjhrIyEOdWaQCHv/f8/S5voE3IDl
         12pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241654; x=1776846454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2HPTqFxSpqPQ2VPcQ/yN5CAn5MjWpzRzTPnq/lPxxAM=;
        b=NmlI8doTS3E9wRPOabr5qsAZj6Z+dq7UWOSvrStYh/Xx1cQaqXkkQCRILJVzJ2hPKI
         aIC2GGFols9hmGrukjXUd+znEuOFlr0mpz7mjgF9530gi+/DR7XNCOXIUJOkpOcgTVp7
         mbu5981I+fX6SLFRbQuDWBdIx6wHFDEwajuRRvOCcbMSbIKj9ReFF0u/DRS7Gn/yAZVo
         j/0+8aUVe6BAqoNaLYG/ehsVoJDCRm76umwfFAnBs90zJp2TNh34mmFa50MZggFOr9wl
         FBa/s9YkHZNUPqW+SXDXhDWhs2U9tfHjrdNOBIJO5QBal6P0gy7Wrvx3vsj4RFcYSqbs
         ZaHg==
X-Forwarded-Encrypted: i=1; AFNElJ97qrwWafPde8fAXffljszFY9yLn6EuaOZv2qQ/li4WquPTePbvlNraMJoCCfyIy9l6XzRSB/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMUfgWYHshcsMIed83jF3+HW1Tn48Dod8zIBcFim2o3zyZ7FvS
	skya43tIZe76UgXG7mPQsjvW7nKhhLrCk9U27nL6zDQas0W6CPYHD3N0
X-Gm-Gg: AeBDiese0Zq6vkS1ow+OmQbPxn322f5luifX0jWdD3FEyk/7e96ysdAgRC2QPh3bSpy
	iJZmRNvd/LdXpU0+7Hi30LtnG4pNm71h530e9WAhpMwzi6SpiNiqcpcwtnYUyxQTk/RtXi9FjvU
	JpC1C8wtCKifRWsr6wyCnU9ETnnLr0FQv02hK23lu2/ry7hYA09JxiBzyn5dIOm7f/Hz4MRSWR/
	fQ/SPEqWtoNERhW39Dc8ffETRT8zzX02846H2EeLyybEMM9LNnlxPDzK48agvm+82cK6S3BHr+4
	T8RSRMPOsGy2imG9OkGhHQb3myxxF39KiUgI4laeCMwsLhLehmOQdSpTTH1UcexAohnw7r7XLgG
	MApxOZ8PtQVgn3nz4s9cqDNXiNF8RehmNaLwPAzxloUGXz/5qEy8bQtFarRlHIHEvYtoFvlzbih
	Soy9QkByQZ24nlkD+O8mMC92RiQpncBxA3xr4TsOmzfwJwS7pFvz6MXt7Z5WT79oVsM8mYSFnRB
	Ka1NADi
X-Received: by 2002:a17:903:2785:b0:2b2:45b7:306e with SMTP id d9443c01a7336-2b2d593683cmr144363155ad.3.1776241653713;
        Wed, 15 Apr 2026 01:27:33 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:27:32 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH RFC net-next v4 05/14] xsk: add direct xmit in batch function
Date: Wed, 15 Apr 2026 16:26:45 +0800
Message-Id: <20260415082654.21026-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260415082654.21026-1-kerneljasonxing@gmail.com>
References: <20260415082654.21026-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278705-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 52857401F5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

Add batch xmit logic.

Only grabbing the lock and disable bottom half once and sent all
the aggregated packets in one loop. Via skb->list, the already built
skbs can be handled one by one.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |  1 +
 net/core/dev.c         | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 2151aab8f0a1..0609e3b04279 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -141,6 +141,7 @@ struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			      struct sk_buff *allocated_skb,
 			      struct xdp_desc *desc);
 int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb_pkts, u32 nb_descs, int *err);
+int xsk_direct_xmit_batch(struct xdp_sock *xs, struct net_device *dev);
 
 /**
  *  xsk_tx_metadata_to_compl - Save enough relevant metadata information
diff --git a/net/core/dev.c b/net/core/dev.c
index 4519f0e59beb..e33a2406d8ca 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -163,6 +163,7 @@
 #include <net/page_pool/memory_provider.h>
 #include <net/rps.h>
 #include <linux/phy_link_topology.h>
+#include <net/xdp_sock.h>
 
 #include "dev.h"
 #include "devmem.h"
@@ -4893,6 +4894,46 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 }
 EXPORT_SYMBOL(__dev_queue_xmit);
 
+int xsk_direct_xmit_batch(struct xdp_sock *xs, struct net_device *dev)
+{
+	u16 queue_id = xs->queue_id;
+	struct netdev_queue *txq = netdev_get_tx_queue(dev, queue_id);
+	struct sk_buff_head *send_queue = &xs->batch.send_queue;
+	int ret = NETDEV_TX_BUSY;
+	struct sk_buff *skb;
+
+	local_bh_disable();
+	HARD_TX_LOCK(dev, txq, smp_processor_id());
+	while ((skb = __skb_dequeue(send_queue)) != NULL) {
+		struct sk_buff *orig_skb = skb;
+		bool again = false;
+
+		skb = validate_xmit_skb_list(skb, dev, &again);
+		if (skb != orig_skb) {
+			dev_core_stats_tx_dropped_inc(dev);
+			kfree_skb_list(skb);
+			ret = NET_XMIT_DROP;
+			break;
+		}
+
+		if (netif_xmit_frozen_or_drv_stopped(txq)) {
+			__skb_queue_head(send_queue, skb);
+			break;
+		}
+		skb_set_queue_mapping(skb, queue_id);
+		ret = netdev_start_xmit(skb, dev, txq, false);
+		if (ret != NETDEV_TX_OK) {
+			if (ret == NETDEV_TX_BUSY)
+				__skb_queue_head(send_queue, skb);
+			break;
+		}
+	}
+	HARD_TX_UNLOCK(dev, txq);
+	local_bh_enable();
+
+	return ret;
+}
+
 int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
 {
 	struct net_device *dev = skb->dev;
-- 
2.41.3


