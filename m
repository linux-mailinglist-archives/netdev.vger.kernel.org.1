Return-Path: <netdev+bounces-93344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D9C8BB3D5
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 21:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B481C22F37
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 19:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34711158869;
	Fri,  3 May 2024 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O3r+ItbR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBDC158A10
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 19:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764068; cv=none; b=Cbk9F2PEx1X3ia1bfezOxbtDgyeNEsIZ4OEfbjiFMroBNRmGWQq+APO0iSv+q3k2UmIwWOUQNUA03eSMCkmQCtrbV/lFBlP2UOjtJBe/si6MqN43XuQFW1ZoeEEmf3NLDzaj1SnwSGJtfj7DZlhjXcBOTGblMDihFR2GZqRsv0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764068; c=relaxed/simple;
	bh=NAIlCGY6YaLW17JzJEy1hmCIs/+aQu+Gt8kyA29RDkA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g98dgpJvWB3DsBPWsz9PLWT16XUiF5cuVpFZMPHRkKYYnV9TZVy121Nie6lmrFC01PAH1dMkcOWgnJfKPognNPAvkMIqMBS4JguL/dTamWT3AAliMmulZ2F+gyEhWAYfKO1aH3i1BRiduIXT4Dyb6l2t4LicIJTZ5RgLWA/zky8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O3r+ItbR; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61e0c1f7169so28509127b3.0
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 12:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714764065; x=1715368865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=21xYpUHnHCZNtdsOBFrFzM+JEG0/NS8mk3/29aTeq6k=;
        b=O3r+ItbRN0ykAos9yLsewbi64mFlz2DzzqioL8mL2VL6TK8lw99d0dnG0wsdWf3u6g
         XvSs+dTB+Zvhz3MRYxc5Bs8fS6YV0zKNTTJoA84eDAy2QkfsnLsRwXZsDaOn3TBpcX54
         FdFnvDAJ2PAMI7EMID4cAYAmubgLM9iW30t91ZvvHQI3OJMUolbel+o0eKAbKtWqBsm8
         UbngfrgfwnqQRa3vonyuc8IDu8QrXu15e5ZZXK/hcBgbn+D4fU8xtTT8lEVMNEsUarru
         4BWJZv0dr/kgx+BeBNXrHd1GBaeg6MedQ1vhL+ck5lSEh/3/F51PQ5793ktAkB/e3Koi
         cmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764065; x=1715368865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21xYpUHnHCZNtdsOBFrFzM+JEG0/NS8mk3/29aTeq6k=;
        b=nOp1Ou4mub92Yc3nEPBDd9yZo8gWOKB1isE5dh1lRkCsrPCaK3X9qhWEiJE3CwxAA1
         TOYCw7FCFJVjM0eaqfDwFE37GoWe8cE3T3x14nHB+B0BlgmlP5NMNXifyo0RZMU3WevA
         hvnQ0rRJg2gG+5h+X9TMy9fZ2A2ZCoY1gZVz1KCOcVMtOJNxQkgtc23Gq/DL1rjBmm1a
         vntqmeNt/idnwc34Yz0jUTxJHWhtIw0L4Qx1rql3G9agkwUsiBFFpxffKpE91ryRFa5g
         QqHmNX3ZkAvQWmW7dQcZrUNVcxZzUtKySujN3bVgBAHg5QElRDWrZwoNTbBCS2sFgFpB
         a3Dw==
X-Gm-Message-State: AOJu0YzdptRCRHK4FX214s6QKkLkra1XEo+SRW8oL9sk9Z86dWeb9PnE
	xTd0jtkcbiYuZrYNnbfB6TCAflqreFQTrV/UdpUPmc0I5w5Fjw8M15d3T+7QYHmySg6BT8/vVJd
	UJ85W2HTVUw==
X-Google-Smtp-Source: AGHT+IEENznFlC3n49lGHdlZ/ddyEZ5HEQUh3DsC4igGU+M2Mgv5cg8g2jRInQwctoHUiWd+NT5UfnnEenRTEQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:9110:0:b0:618:2ad1:a46f with SMTP id
 i16-20020a819110000000b006182ad1a46fmr1718363ywg.2.1714764065748; Fri, 03 May
 2024 12:21:05 -0700 (PDT)
Date: Fri,  3 May 2024 19:20:54 +0000
In-Reply-To: <20240503192059.3884225-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240503192059.3884225-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240503192059.3884225-4-edumazet@google.com>
Subject: [PATCH net-next 3/8] rtnetlink: do not depend on RTNL for IFLA_TXQLEN output
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

rtnl_fill_ifinfo() can read dev->tx_queue_len locklessly,
granted we add corresponding READ_ONCE()/WRITE_ONCE() annotations.

Add missing READ_ONCE(dev->tx_queue_len) in teql_enqueue()

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c       | 4 ++--
 net/core/rtnetlink.c | 2 +-
 net/sched/sch_api.c  | 2 +-
 net/sched/sch_teql.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index e02d2363347e2e403ccb2a59d44d35cee9a1b367..9c8c2ab2d76c3587d9114bc86a395341e1fd4d2b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8959,7 +8959,7 @@ int dev_change_tx_queue_len(struct net_device *dev, unsigned long new_len)
 		return -ERANGE;
 
 	if (new_len != orig_len) {
-		dev->tx_queue_len = new_len;
+		WRITE_ONCE(dev->tx_queue_len, new_len);
 		res = call_netdevice_notifiers(NETDEV_CHANGE_TX_QUEUE_LEN, dev);
 		res = notifier_to_errno(res);
 		if (res)
@@ -8973,7 +8973,7 @@ int dev_change_tx_queue_len(struct net_device *dev, unsigned long new_len)
 
 err_rollback:
 	netdev_err(dev, "refused to change device tx_queue_len\n");
-	dev->tx_queue_len = orig_len;
+	WRITE_ONCE(dev->tx_queue_len, orig_len);
 	return res;
 }
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index a92e3b533d8d2ed1a52a40e02eb994c3070ede38..77d14528bdefc8b655f5da37ed88d0b937f35a61 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1837,7 +1837,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 	if (nla_put_string(skb, IFLA_IFNAME, devname))
 		goto nla_put_failure;
 
-	if (nla_put_u32(skb, IFLA_TXQLEN, dev->tx_queue_len) ||
+	if (nla_put_u32(skb, IFLA_TXQLEN, READ_ONCE(dev->tx_queue_len)) ||
 	    nla_put_u8(skb, IFLA_OPERSTATE,
 		       netif_running(dev) ? dev->operstate : IF_OPER_DOWN) ||
 	    nla_put_u8(skb, IFLA_LINKMODE, dev->link_mode) ||
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 6292d6d73b720fef6766d08ed01d8b93a99f97b6..74afc210527d237cca3b48166be5918f802eb326 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1334,7 +1334,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 	 * before again attaching a qdisc.
 	 */
 	if ((dev->priv_flags & IFF_NO_QUEUE) && (dev->tx_queue_len == 0)) {
-		dev->tx_queue_len = DEFAULT_TX_QUEUE_LEN;
+		WRITE_ONCE(dev->tx_queue_len, DEFAULT_TX_QUEUE_LEN);
 		netdev_info(dev, "Caught tx_queue_len zero misconfig\n");
 	}
 
diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 59304611dc0050e525de5f45b2a3b8628b684ff3..29850d0f073308290ac1a479bc98315034990663 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -78,7 +78,7 @@ teql_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 	struct net_device *dev = qdisc_dev(sch);
 	struct teql_sched_data *q = qdisc_priv(sch);
 
-	if (q->q.qlen < dev->tx_queue_len) {
+	if (q->q.qlen < READ_ONCE(dev->tx_queue_len)) {
 		__skb_queue_tail(&q->q, skb);
 		return NET_XMIT_SUCCESS;
 	}
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


