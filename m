Return-Path: <netdev+bounces-266907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yO7rIJRDsmlFKgAAu9opvQ
	(envelope-from <netdev+bounces-266907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 05:39:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBEE26D2A6
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 05:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C09B2302E79C
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 04:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B3639768D;
	Thu, 12 Mar 2026 04:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="slUP6dUA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB521390212
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 04:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773290352; cv=none; b=omSrEjJP7D3rr2wNK5gIrJQOkzARiXBwKV/o5UqYK26wbbTi36697qQvF4f3vCBEhg65Z8l38Lg0E8MZFWgS7HdUqjNhuHfeKUqMsc1u9wNx6qD5yr5MWr5LjvL1S5hNHdLCdf66+WwqpqocKFkNfrO7C/6xf1c+JZFAmGT8elA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773290352; c=relaxed/simple;
	bh=oCUv8q7huA3exBAbjpQZPGiBUqYI6T7mVwL+1x81zqQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KNCCVLEFa45L4evF0GeM30ZlhIZ8ZMoJX60nqfdySpYHFM8NTeJCgcicPzumm8y4hMuQEuM4glBDyxzIwuUQsCgoCbksFAjSB2tPtoTw/P3efxjnnJGOxyoucbfpaFD8dWpnJTDVa2zwqN8sXmJZ5sLOLyX+Y5v1ejH3HRO8uJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=slUP6dUA; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-64ad741539aso52523d50.2
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 21:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773290350; x=1773895150; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IobzJSsX+4Xefy6GeCaJ6J7XE7x13y+Me1LbT+9S6gI=;
        b=slUP6dUAbBZtWE6NFmvZrEYmWBX4DiIh+g/Uu2aTFzq/B0StBtUPYHZy+DzZDMDYtc
         oHUwpvY95XqvllmvgmIKJKMwcsYiahbrqGZo10n94QYkRwmWQ/UoD6VCsqaeQTJ+//qX
         FDyVJSF20QIGl41d1YljwfhJ3usPAlVrxq3WltYvy/1rBGAiszeccpFn9TE8FZn7Zp+G
         OvWLhKc7MYYCGRGfj5bwwaYzXYmwHASXLVSdMfzZsk9/gnlLXqabGOKStQtaM9C1klRs
         zXaHIRCNJUJb96e7T8TlcjdoQ7oUn+OkZv1xh+IbzXUQOVTB39ZcE+QtACEtF1xT2fSe
         cocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773290350; x=1773895150;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IobzJSsX+4Xefy6GeCaJ6J7XE7x13y+Me1LbT+9S6gI=;
        b=xO2sP3r3D+miaE3HwWJZkOy6392ShfRj16kyOP4qByBigPQq4dU7DUHLUh/JBvHyKs
         mC24VpmSi65+SfSKrbT8V6EoQMPgljEGEpiLfQZTfowrLaFb1xTu5m/TgHAVbyX/KQMX
         3IenBIyDLKulC+QKmKgTu8r567fSJkAGfI+6Y9aBlMhFZdVmsYcFtuyFl+oIG0jLlYHt
         S4ZHXlHZ3FgpjTw+y0SAhWVE5npiMJj/lr0n/Dd3Y2lvPL42gDuu1Vzkit6l49K2gVhK
         cGL58QjZ269zXw+UpCoYF1sDGNLlB7QbT3Q1KXlQIoKG3o56pD3jr0eoOL0CnRZbpVta
         /PVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoCOUgaTzFgs2KgdGYvdn1u8dlw3RzP25S3O14T9kU+2G2yF/UxFc4A1S9DIKC5GyE0Yya+Ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmZZhtb7iQ7iFxLlsX3Es8PoBb598cQjVBPRNEnZzdMPucZ/TC
	SyrmfJFW8xGyX39c33pNVwBspRjmxJ7jLuXWhrdm1ShSZipNUgzalnJADQjmXyGDshJgMcRpUgm
	HX75Ab5FjdJRWOQ==
X-Received: from yxab1-n2.prod.google.com ([2002:a05:690e:1581:20b0:64c:9a48:c953])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:e0f:b0:63f:a103:5d2d with SMTP id 956f58d0204a3-64d6574e39bmr3713321d50.37.1773290349651;
 Wed, 11 Mar 2026 21:39:09 -0700 (PDT)
Date: Thu, 12 Mar 2026 04:39:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260312043908.2790803-1-edumazet@google.com>
Subject: [PATCH v2 net] net: prevent NULL deref in ip[6]tunnel_xmit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Weiming Shi <bestswngs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266907-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDBEE26D2A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Blamed commit missed that both functions can be called with dev == NULL.

Also add unlikely() hints for these conditions that only fuzzers can hit.

Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
Signed-off-by: Eric Dumazet <edumazet@google.com>
CC: Weiming Shi <bestswngs@gmail.com>
---

I am sending v2 without the usual ~24 hours delay, hoping to catch our PR today.

v2: avoid DEV_STATS_INC(NULL, tx_errors) as well.
    add unlikely() hints.

 include/net/ip6_tunnel.h  | 10 ++++++----
 net/ipv4/ip_tunnel_core.c | 10 ++++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/net/ip6_tunnel.h b/include/net/ip6_tunnel.h
index 1253cbb4b0a45f1c62999be21931ca31b596697f..359b595f1df93663b3e32c006d936427e8c8b20c 100644
--- a/include/net/ip6_tunnel.h
+++ b/include/net/ip6_tunnel.h
@@ -156,10 +156,12 @@ static inline void ip6tunnel_xmit(struct sock *sk, struct sk_buff *skb,
 {
 	int pkt_len, err;
 
-	if (dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT) {
-		net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
-				     dev->name);
-		DEV_STATS_INC(dev, tx_errors);
+	if (unlikely(dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT)) {
+		if (dev) {
+			net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
+					     dev->name);
+			DEV_STATS_INC(dev, tx_errors);
+		}
 		kfree_skb(skb);
 		return;
 	}
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index b1b6bf949f65ab7a09ba201d48aa204d913f146d..5683c328990f49df2954af9d890b5f24150caeb2 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -58,10 +58,12 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 	struct iphdr *iph;
 	int err;
 
-	if (dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT) {
-		net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
-				     dev->name);
-		DEV_STATS_INC(dev, tx_errors);
+	if (unlikely(dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT)) {
+		if (dev) {
+			net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
+					     dev->name);
+			DEV_STATS_INC(dev, tx_errors);
+		}
 		ip_rt_put(rt);
 		kfree_skb(skb);
 		return;
-- 
2.53.0.473.g4a7958ca14-goog


