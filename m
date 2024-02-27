Return-Path: <netdev+bounces-75476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D4B86A164
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 22:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C9AAB2E08B
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 21:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48BA14EFE6;
	Tue, 27 Feb 2024 21:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IMYM2yJb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7C114EFE4
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 21:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067676; cv=none; b=uvWFwPlB3tqW8FaagX7O/3GhlYtMkJWEsKeEtEenx8dkTsbX463ZVqgTOt5ALLlw3xI/6P5K0I7TMYq5lPtp+8o3si1PF89ZvSy+4v0vHByjvxO7TTFL69z42RvOW98NFtNA3yIniFb854Ms/34TGRtmcRQ/sO0OUv0uPtAIpfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067676; c=relaxed/simple;
	bh=XEm0LSxKZQNuaJGYQoVT7GmounxnAlbK3X52bF6EhDg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=l2T8MmWuaTeaptP4zdeHiNZScdgDJ980VRftAl3Gv4AaGTrRoahxoZaB0Zib0tARnlUTMN8C4cooydxGPVDz/6vskRGpHLYcD4xCDonczfeXeZ3pAl0/VueWLOgj9AHEDdijD2SI+Mgy8sYzcAGeI84e9CGM6+VLY8G827QUtBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IMYM2yJb; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608ac8c5781so82410677b3.3
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 13:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709067674; x=1709672474; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YaGnpfEfc1JmYv4H4rSxHy3xidTiqEsm7Sib6URYsBw=;
        b=IMYM2yJbbmzmN973UGeEAHkfsFxZKeuYjxHEwlFPnxPo9MdnVfZ0hwVseP1CeCCIcM
         nvVqWc9yzXxZDIgSJrQGaHzGuS9gHA2l7EXhzQfA3Do91/yj7ZWi2ws/bVDaw/Fd+26x
         sGM5l6wAMUB82dso/6kz1g315qWeeNA7skQ1XLEz49gjw4PKWxWuN7089wuuNbc6dRMA
         2IdBVfHzHjmzn9dQUphjX7uKwY87KSUEL6qSRoaR5c2zehLoLImwgLSYTjk7tQyfkULs
         ezRjIF+lxMPdewhYNbHWwRibqExVFRHjIQJ07dgVbnrSxgrAuq08xOAWVJtdJansylS4
         5m3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709067674; x=1709672474;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YaGnpfEfc1JmYv4H4rSxHy3xidTiqEsm7Sib6URYsBw=;
        b=vFfSDRkmd93te9zemzG7iDCMJmhZKnopuqBXs92Q71NVMvFzxoKKJWvpPHg1Ab7luK
         sC8JPcRlsy7HMCOYFkxpr73Z9+eaXwocYIL8xpTzwOk7or8q7CfMwcO35PM0gbVOnWQD
         QOmZbfO60+6pBZIDNmubTVhbv2ain28rqXBtdsDnL/H9X6XIqLd3Ru0S/q+7x13E5Rvy
         DaRu+EPJCcA4wrDXxutNjNoSLdM7LawMki/jQtskN9YSi3ks0jFn1A2KaGgKjuekbK+4
         wLImV3FQEU7apTy6p3vZ3o3bdWE5tGsF4uLiaVW89DVvSYIDHxVEccrTabiOHJQMGSwP
         KXSQ==
X-Gm-Message-State: AOJu0YxELqQ4yFJ2Fu3yzKU7OZp217QzLaY30PiJAH0KpIoxXpnJMzmz
	klFyzQTANdae3i6JCA1fCTfKqz7ifVjpT0sMl4FJ6DNzTnFQ0v1yfAvIRODb18lTOiCFtiMJLwc
	3whNKahnp+Q==
X-Google-Smtp-Source: AGHT+IErhYwSXSGVdyFqgABB6knNxdJzCK8U3RLFwQweLk/q4PUOlb4/QPT0D1SPetQ9rAWrRW5bVz+ZX/GFDA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a0d:d5ca:0:b0:609:38d1:2ad9 with SMTP id
 x193-20020a0dd5ca000000b0060938d12ad9mr172114ywd.4.1709067674150; Tue, 27 Feb
 2024 13:01:14 -0800 (PST)
Date: Tue, 27 Feb 2024 21:01:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227210105.3815474-1-edumazet@google.com>
Subject: [PATCH net-next] net: call skb_defer_free_flush() from __napi_busy_loop()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"

skb_defer_free_flush() is currently called from net_rx_action()
and napi_threaded_poll().

We should also call it from __napi_busy_loop() otherwise
there is the risk the percpu queue can grow until an IPI
is forced from skb_attempt_defer_free() adding a latency spike.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Samiullah Khawaja <skhawaja@google.com>
Cc: Stanislav Fomichev <sdf@google.com>
---
 net/core/dev.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 275fd5259a4a92d0bd2e145d66a716248b6c2804..053fac78305c7322b894ceb07a925f7e64ed70aa 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6173,6 +6173,27 @@ struct napi_struct *napi_by_id(unsigned int napi_id)
 	return NULL;
 }
 
+static void skb_defer_free_flush(struct softnet_data *sd)
+{
+	struct sk_buff *skb, *next;
+
+	/* Paired with WRITE_ONCE() in skb_attempt_defer_free() */
+	if (!READ_ONCE(sd->defer_list))
+		return;
+
+	spin_lock(&sd->defer_lock);
+	skb = sd->defer_list;
+	sd->defer_list = NULL;
+	sd->defer_count = 0;
+	spin_unlock(&sd->defer_lock);
+
+	while (skb != NULL) {
+		next = skb->next;
+		napi_consume_skb(skb, 1);
+		skb = next;
+	}
+}
+
 #if defined(CONFIG_NET_RX_BUSY_POLL)
 
 static void __busy_poll_stop(struct napi_struct *napi, bool skip_schedule)
@@ -6297,6 +6318,7 @@ static void __napi_busy_loop(unsigned int napi_id,
 		if (work > 0)
 			__NET_ADD_STATS(dev_net(napi->dev),
 					LINUX_MIB_BUSYPOLLRXPACKETS, work);
+		skb_defer_free_flush(this_cpu_ptr(&softnet_data));
 		local_bh_enable();
 
 		if (!loop_end || loop_end(loop_end_arg, start_time))
@@ -6726,27 +6748,6 @@ static int napi_thread_wait(struct napi_struct *napi)
 	return -1;
 }
 
-static void skb_defer_free_flush(struct softnet_data *sd)
-{
-	struct sk_buff *skb, *next;
-
-	/* Paired with WRITE_ONCE() in skb_attempt_defer_free() */
-	if (!READ_ONCE(sd->defer_list))
-		return;
-
-	spin_lock(&sd->defer_lock);
-	skb = sd->defer_list;
-	sd->defer_list = NULL;
-	sd->defer_count = 0;
-	spin_unlock(&sd->defer_lock);
-
-	while (skb != NULL) {
-		next = skb->next;
-		napi_consume_skb(skb, 1);
-		skb = next;
-	}
-}
-
 static int napi_threaded_poll(void *data)
 {
 	struct napi_struct *napi = data;
-- 
2.44.0.rc1.240.g4c46232300-goog


