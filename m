Return-Path: <netdev+bounces-304888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YbYtJ1dZS2pTPwEAu9opvQ
	(envelope-from <netdev+bounces-304888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 09:29:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4CB70D8A9
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 09:29:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ABkjuis1;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304888-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304888-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C93B13277A79
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 07:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A793F44E8;
	Mon,  6 Jul 2026 06:56:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395DC4C955D
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 06:56:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783320980; cv=none; b=RLvv/2aMdCpCfEPb2YpV0tuWj8DL8QSL2jKRduuDMdImBNqPQVHwIQqaFV7NnGEVMlyISG33ep/qB+Dx0fm35PD94XozYhQG3tov9bTA21msGvX+8ao0LK7RoGRenL1Fm4QDazOJOFfF2m+zLxU6H/z500b92AMYFMXG9GHHA48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783320980; c=relaxed/simple;
	bh=yzeS2+tgX/KTEQ362glkjxTC0H71KwhM4gTtu3L5FpI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UHpJjkK3xb5SCgGIY+btWphnuQJMYg9z9OZJhDa/814/SxeNQwWv6DIHd2iEPMoNE19/TRcMuc02/4S4jnNbrk+K0713UIcGGNzRQy/aVy1XdRZ0+eZrRn9Pzs91xj//ZUJGllnaiUPZisqDWZyXiWeSvDShFq5+BL2MRrtTwqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABkjuis1; arc=none smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-847921eed4aso3732493b3a.3
        for <netdev@vger.kernel.org>; Sun, 05 Jul 2026 23:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783320971; x=1783925771; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K+iH0oScX6vUoO3wK//wIGjcdPMvMKHF3g6QanG2LHo=;
        b=ABkjuis19XR+m5LnfSTHjkD2CW49WAb9dxH9uHApGZLWj3/zrhFZmITm8CV06TSrWJ
         RzW+1ITc+CweP7G1PPYnckLBrMr8EoJkqew71eg+WKo40Yum7KTfkByNoAhHYD9AYhce
         q269JXiDza4GadxIABnqe5tqHQoJVSSJ46Lq54wmX/FoFE+Bt3/ZRK/oFBvSH1OVP2RQ
         su/4qNYAsd6UyyicRRgghsW1Us6EQy063l7YP9xaGzv0i35UYt+01wbdhOBSUWDL0TmK
         q99zx94rD0kW7g+JhQ+dr5JpLd4ECBvafbSBO/H52EmMCRpZVstk2SjMZvUi/xAdP4o2
         mCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783320971; x=1783925771;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K+iH0oScX6vUoO3wK//wIGjcdPMvMKHF3g6QanG2LHo=;
        b=siBOBx1Jsb8mLv8ym0VyVP7RCi6S+dwCRH1bQL2Gwnp2ZPxsF1s/OZfF//3FrpTLas
         JBQIav7he56AgdmFj5+GEXIOnhFQOO2U68Z6QoyPBYxKrd//I3RJoJiuLA821pZBb1sI
         kEeO3Dc4JJqOfUvPSQblCrV5Ft44I3iGCTCg/v7CEPAGfTGp6OVTEDpTjDTwzZy1TOyk
         tFYY82pTDAe2rWpDbMBokNlZ5oBRt71xOd/6h/VAFfGqZrjH/TWZd2mzwyRC4JN4AF+5
         5bxzrDIXkq8/1JLsJpQ9aH7kUs5uZ3vBH4PCTu+vLJ7jZUtewmMRlEmJuXUlZYKy4g/o
         kXFw==
X-Gm-Message-State: AOJu0YxH6IyFjL3OAQtvK5JexfV/DuwoyF7N6Y8BBfEu5pO2taPrdOyh
	P4CEJrlxS64eAiWQuGxGFaUq6ZVAc84fDY1dwbUajAK4I55bXEHw0ygGPmjHyl7v
X-Gm-Gg: AfdE7cn2ck2Foi2gRNc8FKWLD3HWjOBWlAMB6DMkf1IQwXKL9WGWmjZi8xW2OieqWim
	eSmITjUWu6vrSPAVdhzTiS+8j+tEuPwzw3/jQlqHb60RC3Lh+lM0zLheGlUkhMO+uwP+W45Uezl
	8rx+xXQnJ+zxoBFdatol3Kwu7o/JUF12ZA3GjoRW8g/H3iUWSwQ6ZatfIPQrZejRjGHoNVxg9C+
	FhwCWqnIPCtCV8DNKNMB54G7coUmmu8CLzSN12HT+0xdQgdnGcZdBaxIj5/HAyXrOfSQiQaYsAy
	KuNAiCoedVSHs0k2Rcw16VKu9Dz1JL71azUF7Wfs4ZNS8EH2I0rp9Zjrl8QXE8a5locEGNYuXez
	rlYBNGDAIy/a/1cPgWwjHYEiCrDXyPIGeQsLDSskMgZhsShFM+Rxl5F57dWnmRq+B3wDhunum3f
	kswQjWrg==
X-Received: by 2002:a05:6a00:4612:b0:847:84a2:cda7 with SMTP id d2e1a72fcca58-847f6d5a847mr9033848b3a.12.1783320970734;
        Sun, 05 Jul 2026 23:56:10 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d7a915sm3181753b3a.44.2026.07.05.23.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 23:56:10 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH net] net: airoha: fix HTB class modification offload
Date: Mon, 6 Jul 2026 14:18:58 +0800
Message-ID: <178332096675.2250671.599544331813347302@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304888-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D4CB70D8A9

HTB core does not populate parent_classid for TC_HTB_NODE_MODIFY.
Airoha currently checks parent_classid against TC_HTB_CLASSID_ROOT
in a helper shared by both TC_HTB_LEAF_ALLOC_QUEUE and
TC_HTB_NODE_MODIFY. Since the modify path leaves parent_classid as
zero, the check always fails and changing parameters of an already
offloaded HTB class is rejected with -EINVAL.

Move the root-parent check into the allocation path and validate
modify requests using the per-netdev QoS channel bitmap, consistent
with the delete and query paths.

Fixes: ef1ca9271313 ("net: airoha: Add sched HTB offload support")
Signed-off-by: Wayen Yan <win847@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 32 +++++++++++++++++-------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 59001fd4b6f7..8e4e79c1e4c2 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2766,18 +2766,13 @@ static int airoha_qdma_set_tx_rate_limit(struct net_device *netdev,
 	return 0;
 }
 
-static int airoha_tc_htb_modify_queue(struct net_device *dev,
-				      struct tc_htb_qopt_offload *opt)
+static int airoha_tc_htb_set_rate(struct net_device *dev,
+				  struct tc_htb_qopt_offload *opt,
+				  u32 channel)
 {
-	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
 	u32 rate = div_u64(opt->rate, 1000) << 3; /* kbps */
 	int err;
 
-	if (opt->parent_classid != TC_HTB_CLASSID_ROOT) {
-		NL_SET_ERR_MSG_MOD(opt->extack, "invalid parent classid");
-		return -EINVAL;
-	}
-
 	err = airoha_qdma_set_tx_rate_limit(dev, channel, rate, opt->quantum);
 	if (err)
 		NL_SET_ERR_MSG_MOD(opt->extack,
@@ -2786,6 +2781,20 @@ static int airoha_tc_htb_modify_queue(struct net_device *dev,
 	return err;
 }
 
+static int airoha_tc_htb_modify_queue(struct net_device *netdev,
+				      struct tc_htb_qopt_offload *opt)
+{
+	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+
+	if (!test_bit(channel, dev->qos_sq_bmap)) {
+		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
+		return -EINVAL;
+	}
+
+	return airoha_tc_htb_set_rate(netdev, opt, channel);
+}
+
 static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
 					  struct tc_htb_qopt_offload *opt)
 {
@@ -2794,6 +2803,11 @@ static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_qdma *qdma = dev->qdma;
 
+	if (opt->parent_classid != TC_HTB_CLASSID_ROOT) {
+		NL_SET_ERR_MSG_MOD(opt->extack, "invalid parent classid");
+		return -EINVAL;
+	}
+
 	/* Here we need to check the requested QDMA channel is not already
 	 * in use by another net_device running on the same QDMA block.
 	 */
@@ -2803,7 +2817,7 @@ static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,
 		return -EBUSY;
 	}
 
-	err = airoha_tc_htb_modify_queue(netdev, opt);
+	err = airoha_tc_htb_set_rate(netdev, opt, channel);
 	if (err)
 		goto error;
 
-- 
2.51.0



