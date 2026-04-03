Return-Path: <netdev+bounces-275244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE1bC8c70GmP4wYAu9opvQ
	(envelope-from <netdev+bounces-275244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:14:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7DD398AF6
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B8493006003
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 22:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0AA365A08;
	Fri,  3 Apr 2026 22:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GnUJLjUv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A02318BA7
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 22:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775254462; cv=none; b=VZ3QVrrNv8C5LPmbleF9STBQfdtdfSUq7Cx4PLFbSldqV2Ul3Avp7uB9G29aM2X3sfYjIvW7f6FKXsjZPtm3kCAp+mVFXqOZDsgbmrMC5cC5UJIOn7SauwDHQVM2Azq+dRUD90qHKaE8z/Wu2qqtah4bQLr6CVxi1FhpKgcykv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775254462; c=relaxed/simple;
	bh=nmV6msrUx9m7oOhmhZaQpF43fOMVkiCx7GrxW85JwlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XkfsySkKZY9wy1HAQq9qzvLj6PwkyhSQeoUA6m2Qctpdc4CoG1z5X88RpISliN8zUqQkl7SCrVB/LeFo8B52BGRuIEyW4ERRbKe+FvcQ4RbkYlrnUp43wZ8SdHPAaFUVLT8InWBpnWgPD/Ku0EPp7F9EjYzdG8crU9Y3EVCR1Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GnUJLjUv; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d8b2703f37so2038140a34.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 15:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1775254458; x=1775859258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xeA5q5NaKviAUB/Rh0ShaAd+yc9E7hrUbcSVBjta+xk=;
        b=GnUJLjUve9pHn2bc8hrLbzYwxq7yChZttxaxt2nxqT0sG/maoD7I6dOYcTKpmmdAzh
         SfO9Cbat6H2Yx6VyN2LIz/aTEdDfER2Q92/5BZUleQ4HbE6ihz/p2+OaGUcO8lT4NN9k
         Aq5Ce5tyMeZIoIsDdWB+z7z+gw/Pyid5Sr1FWZhAp5jZOR0m9qgkiKQN/Hk5dkYY0JLX
         1F9fDVZrA3TxrInUN9DX1M1HRgMGy77mQUfZf3aTUzT4pjLIRUW7uFvTVgVHJNVHecGy
         A48yPP57B2Q7SBx3hwynokXkD242e7UcKkgSGqt9D0RMdebZRpklgW4fjG5f+pW/D+Nw
         oIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775254458; x=1775859258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xeA5q5NaKviAUB/Rh0ShaAd+yc9E7hrUbcSVBjta+xk=;
        b=iOnOw66QNsYW68+hcPalhazBVM7bMxhEODUOSck4XRPbxk1mNSwtU+B71t5Lp37Z23
         U9j1/OYWffc7VK5OlGVV3e6DHTQW10LPNVxNGHCLwsNzMCTKZJ7oMBOCTmYyOzfaQXbl
         bUeNyCrS0h+5BCNmy07WxrLj5V/9X9zXlp74rLkIOT2K1p1MQn7zslvINFwlW+K0ew8J
         LYJDvdnQTNYfYdhnRIzlf9jvNwQkKzy3NM9uibrfzVAYrJeTnmcq7tvvb5fHSECDTZce
         8Fbll9j3UR9AQw3Og/D918eemJ/s+GlyJV7MkJrerJtz+8bpOsTOT/uJ+l+8XQB1MD3K
         qCcg==
X-Forwarded-Encrypted: i=1; AJvYcCVxe8NDbahZGxmsKTlxF1gkE9roFRsYoUiFrBt0IFO5ERzaYL7srpQEAIWsI0w7WSQAGIIhWbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcOmLuxv4J1B3jM7PvTG4kcoQvz7aeD7Mpuxlm0zou/c76ml8j
	SGOmHmhiuE/s34Zbfvqw9YNSy/IlNwxElDrE43tonu0CqLSxScBlxVvM0/FG3tgQ+fk=
X-Gm-Gg: ATEYQzymZnXh90pP2ZO2sBekYzcJcz4Qbc1vB/kznaJsz75SC2lzjXtdwpK7wQA1wE/
	0r7PYqvKv3OtF+BCF5qCtziOkdpHKaQvWhj/q/JDiwfisW6qYxlJXB1Xd/0YegTeQXbE2H/6sAj
	en7HwpLBL8m1zRd52fECbCQTRKoalbXZEYo6Q8FeNqIWfp04PZvLxR9g7Zrr2q3p0u5gtYu4TR+
	lOWE5z8PqHdEFxdkgHp+lES8w9zzZ24UCx1fTBOTbVLSBLPcZaZ4uaKdTLzl0eWZerYg7hO/+Tq
	lUaWT25is+jekIYTXZ+JsXNyeTjXgV1DsoDpnD47Ol60AKGVvJxwid+KtIxBUQjV0L4I+xxrloK
	3XNol00cq5y6BKR6l4LzxecG7S73kFPaBS4sjwclc2NksBKD0HfvTAyD+j1kWGnOMwohpHiaUeg
	kEJpRafchsAc1Lt0EtrwPn
X-Received: by 2002:a05:6830:7009:b0:7db:a184:2b35 with SMTP id 46e09a7af769-7dbb6f69373mr2834608a34.8.1775254458034;
        Fri, 03 Apr 2026 15:14:18 -0700 (PDT)
Received: from 20HS2G4.. ([2a09:bac6:bd09:15e1::22e:38])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dba736cb4asm4819032a34.23.2026.04.03.15.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 15:14:17 -0700 (PDT)
From: Chris J Arges <carges@cloudflare.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>
Cc: kernel-team@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: Add net_cookie to Dead loop messages
Date: Fri,  3 Apr 2026 17:13:39 -0500
Message-ID: <20260403221352.186383-1-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275244-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B7DD398AF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Network devices can have the same name within different network namespaces.
To help distinguish these devices, add the net_cookie value which can be
used to identify the netns.

Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
 net/core/dev.c            | 4 ++--
 net/ipv4/ip_tunnel_core.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 831129f2a69b..a9718fe9d12c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4875,8 +4875,8 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 			 * unfortunately
 			 */
 recursion_alert:
-			net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
-					     dev->name);
+			net_crit_ratelimited("Dead loop on virtual device %s (net %llu), fix it urgently!\n",
+					     dev->name, dev_net(dev)->net_cookie);
 			rc = -ENETDOWN;
 		}
 	}
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 5683c328990f..a41bcf7ddc06 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -60,8 +60,8 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 
 	if (unlikely(dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT)) {
 		if (dev) {
-			net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
-					     dev->name);
+			net_crit_ratelimited("Dead loop on virtual device %s (net %llu), fix it urgently!\n",
+					     dev->name, dev_net(dev)->net_cookie);
 			DEV_STATS_INC(dev, tx_errors);
 		}
 		ip_rt_put(rt);
-- 
2.43.0


