Return-Path: <netdev+bounces-126381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89FA970F91
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4FB81C221B6
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 07:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EA71AF4EF;
	Mon,  9 Sep 2024 07:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHjQuzHc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E55C1AF4DC;
	Mon,  9 Sep 2024 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866600; cv=none; b=Wt9/Vq5RiaSvSTGxb9lbnzHIno1BonBbP+PBVuQ3Sl2eroGa5aUoOKQTXuxJguUEUZiqtzj0VcMN8PiBXsJCc9qZFg85/BAJxdCK1+ngcP1wUJVtnql5NbdnzYLs6nSWA315S6PUiRtnYXJnrAF97DK6S8a483YTgd//xaYVyA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866600; c=relaxed/simple;
	bh=SyJTKVXW1KbX4FQYavgYyEaHhVURcihCQwW1NIvrKDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JayVRTavTE5V+2mmlTZoMeaneMar+3JxzLvJN1fc/Etcu8GPsRUG8PiLZaWiGq2f/zWoZOsV/Y8L+A2rKYR3+op/apBMNERki80AlOmThSUNeA0K54kYoOMsM/2xDE5gYyGRrpKjFGxifcbJLwqfG2j0LNc2bZGRq1WHbu/XJQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHjQuzHc; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-710da656c0bso978604a34.0;
        Mon, 09 Sep 2024 00:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725866597; x=1726471397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ac8M5GlxYy/WpcMspugo7rQDDvKUcBeSWvAozWoN7Vo=;
        b=hHjQuzHc3yMGGLMgODt0kM7qS2qVqM3vl4fu0BYugblEUKOGHTpwQS289fmVBV4Abo
         7WYURklZaVMAzz673fXZnSc/hvfgKu3qqMjGo0ZuOKOE1Y0EnORYlWnUw77HPncvL0Uw
         4WOdSrmlPqEmUBcQM0H06mEzapJSoENn6YKtXKuMao/I5FYPep7p45Eji5aJfB/y0p4x
         4TXVmolg5uGcF6/qtQjmVYdbpa/Ub1+aZBFgqjxPBhd3KuvW0+Zof2nf/rTSoAKfnEvM
         JAng/2gGLZ1a4DgSpuAmP9iTj4ozZQKSOAhCO9XTMNsczOHsFfHbRke4xOTqwpdTRc4k
         AGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725866597; x=1726471397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ac8M5GlxYy/WpcMspugo7rQDDvKUcBeSWvAozWoN7Vo=;
        b=oSwxZ8i4YOaVZ0BoHaODmhH9lh/3O30L7nV5HZKuxmPXx0DVp06E209kK6d58UspTj
         ioJjgjAB8p/r4S+grxN0j6zCbm4j0Q8v8TuH1N1oblGQMwxcWDvGWN2sqUO26mEf1vjb
         AaU6gAzSSaiBiVqRnoInCh6RFi83qcSAyO24cabsFaQNGr9uJiDU2C+LMAGjzQOAOZaN
         KUK7fzbYBGQ+e4p0vRlnEkUPNE2c/fysiu0tRJJpvzJMPvhYdh4QdbU6eCS9N2b/rudC
         kSC41EP7pmq4SrAiMJl+cXPcw0IIX/nxurMC01rUWdBWru0uqs+ETck3gP3+VMnwOoOr
         L+9A==
X-Forwarded-Encrypted: i=1; AJvYcCVJabzKQ412/DBZt6Ng9IVryPnbOgOJyoEZzTEpmvmIxamrgOvlBO3OQYvqwCPgxt1Ln1YVSGVb@vger.kernel.org, AJvYcCVZJV5uAI9yxzf5h71iuYxwLrimxZhEZgwHxmvJMoHZKmsusDerviW05RBSyUepxkR/c4dJbu+lUx1UocU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjOP4mMA08ZD4a9ToSxukl3rSRnNpPf2NuNfTv3w3xTkexdQkv
	JG+v/daZyolZKZCHP7Szuq7XSic7cU4ecg0SUbTSs9tkHirXDb0R
X-Google-Smtp-Source: AGHT+IEueFXOSqvHA5zJkZzocHizwoT4vYWdG6ztnHB94ljH2R8e7b1n4d0DtLxG4lwNO0oPh6j7Hg==
X-Received: by 2002:a05:6830:348f:b0:710:b797:6b0b with SMTP id 46e09a7af769-710d5b9875emr9447169a34.17.1725866597647;
        Mon, 09 Sep 2024 00:23:17 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58965bdsm2962094b3a.29.2024.09.09.00.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:23:17 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org,
	aleksander.lobakin@intel.com,
	horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 03/12] net: tunnel: add skb_vlan_inet_prepare_reason() helper
Date: Mon,  9 Sep 2024 15:16:43 +0800
Message-Id: <20240909071652.3349294-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
References: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the function skb_vlan_inet_prepare_reason() and make
skb_vlan_inet_prepare an inline call to it. The drop reasons of it just
come from pskb_may_pull_reason.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- fix some format problems,  as Alexander advised
---
 include/net/ip_tunnels.h | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 7fc2f7bf837a..d00d8835e789 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -465,13 +465,14 @@ static inline bool pskb_inet_may_pull(struct sk_buff *skb)
 	return pskb_inet_may_pull_reason(skb) == SKB_NOT_DROPPED_YET;
 }
 
-/* Variant of pskb_inet_may_pull().
+/* Variant of pskb_inet_may_pull_reason().
  */
-static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
-					 bool inner_proto_inherit)
+static inline enum skb_drop_reason
+skb_vlan_inet_prepare_reason(struct sk_buff *skb, bool inner_proto_inherit)
 {
 	int nhlen = 0, maclen = inner_proto_inherit ? 0 : ETH_HLEN;
 	__be16 type = skb->protocol;
+	enum skb_drop_reason reason;
 
 	/* Essentially this is skb_protocol(skb, true)
 	 * And we get MAC len.
@@ -492,11 +493,20 @@ static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
 	/* For ETH_P_IPV6/ETH_P_IP we make sure to pull
 	 * a base network header in skb->head.
 	 */
-	if (!pskb_may_pull(skb, maclen + nhlen))
-		return false;
+	reason = pskb_may_pull_reason(skb, maclen + nhlen);
+	if (reason)
+		return reason;
 
 	skb_set_network_header(skb, maclen);
-	return true;
+
+	return SKB_NOT_DROPPED_YET;
+}
+
+static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
+					 bool inner_proto_inherit)
+{
+	return skb_vlan_inet_prepare_reason(skb, inner_proto_inherit) ==
+	       SKB_NOT_DROPPED_YET;
 }
 
 static inline int ip_encap_hlen(struct ip_tunnel_encap *e)
-- 
2.39.2


