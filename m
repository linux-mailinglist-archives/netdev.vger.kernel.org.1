Return-Path: <netdev+bounces-70633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F078C84FDAA
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 21:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56F23B29531
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 20:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC32C6125;
	Fri,  9 Feb 2024 20:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zcl97idd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E06139
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 20:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510900; cv=none; b=qJw2chgjALyCjZ3iYuwJbkdWx2O1PSuqLpjjeMfsmHObG6I2jkfNQRVJlBeaGJ0GHR0tfDP4lG5LboKLXB6TKWSpXpRVmZxA0tp9vmlSp5LI/JtSeJOnllOSFIpaqnWGjej43hsNziAy4OfHsni5kAebjaKydXjRI1cBPVGMZac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510900; c=relaxed/simple;
	bh=2QdaKw6HNYgE90+Lcuxa1iCBKePEDBnvblv2L3k5W4s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PYtuYTMpP9JS+C9xY5oGiuWbEeuUXEn4b2R44u1/ooSPHOwy/97dtteiJvG1JSO8u0Sj9K2liMYE/wLjOy0m4XbNJ2zZotZv5S9/jEiHlDODV+DNZldurVEtrJ+wSaarG66Vl+ZrV62xo/vth0jOeayQOuLZ6lAF9MRNtc/GBaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zcl97idd; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc748365ba9so2128103276.2
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 12:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707510898; x=1708115698; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l76Myz5QVY8zfVBScuI9w2fWj5vlY//uceSC7wdESko=;
        b=Zcl97iddyesYiRVtd+mJcJcv2bA2jozDfzaB3tm0eg+hEomwmVvgwEKWp+IWMiZjXU
         0IIz6eHlbgHUfEU6BX0HF0RbW1jDNBGwaY88O5oWFOR/u2/6yVbYOBbhYnkbcXIhTVN6
         9w9ljAJkhZSVIX1zmqitTjvcXxCKzHHYpByjQG7ASxQDdW1C+j2hVNlLtwL41bgGBqVR
         ME8z02FbY2oBr3rQtq6WB/fnwjt5fgc8Jzf3oLf9fCjB+BGbWcBSkiOwOa1l7MgJ0gN5
         cUwsqiK2TNftZbg5+1QgFh2JucneOlKAROk019pljhoSWbjp3m4eW2RZCK3j6g3DTcpx
         IQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510898; x=1708115698;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l76Myz5QVY8zfVBScuI9w2fWj5vlY//uceSC7wdESko=;
        b=I6gC7Jt7IT/nNaZDlZYrLantixl/OdxZ+daI19LI2+K1ZHnCDRKSin2GRvs/Cv9ui+
         aRDx1TOQrk2aTLb2JdYDJ962rtFxtF3jbGjyLPxIrwX/p7szrue2E4v1jr1h4n9z1Ci3
         wnZWEvycCyVojIL2iYPttKD0GXHG6MdxiJwnuiSJfBjB0X9uZwkobCOwugAC9cyezKfL
         wMiibNlqYGiXwr7oDqnNDfrQaThA3tagmxzI6tdZK5nU+hxzO1Wf+61P1mjWwe8vxACo
         i1Pt8JcbobRTuFO1V70O2bK8C9GqPt/IDqAtxi4IYtSum6eCTPsrcf7ZsvvljhWT70rL
         9GyQ==
X-Gm-Message-State: AOJu0Yyo3s2OqmOIbUiVJT2lIh1fdGGXV5AM6hQTQsuVkTIhcX9Dcvpp
	1W63bMPhQfG6j7tA7dG9EJFynZvWgUixNPcTXKkBjgfBr+JRlC1zGUYO/ihtFBDIlA1WjeUdW7L
	16gvU2v1Yng==
X-Google-Smtp-Source: AGHT+IECMVMPg0jHOny2/0rUmajxLCcETUMxDOjir4Lz9T5fTISoYyVGbqzWT76sIDFxeW5EIPafLDxnsW+9Ow==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1547:b0:dbe:32b0:9250 with SMTP
 id r7-20020a056902154700b00dbe32b09250mr9156ybu.0.1707510898420; Fri, 09 Feb
 2024 12:34:58 -0800 (PST)
Date: Fri,  9 Feb 2024 20:34:17 +0000
In-Reply-To: <20240209203428.307351-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209203428.307351-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209203428.307351-3-edumazet@google.com>
Subject: [PATCH v3 net-next 02/13] ip_tunnel: annotate data-races around t->parms.link
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

t->parms.link is read locklessly, annotate these reads
and opposite writes accordingly.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_tunnel.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 00da0b80320fb514bca58de7cd13894ab49a2ca6..248eb2d9829b31f89b7700460e317bf88bf325d9 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -102,10 +102,9 @@ struct ip_tunnel *ip_tunnel_lookup(struct ip_tunnel_net *itn,
 		if (!ip_tunnel_key_match(&t->parms, flags, key))
 			continue;
 
-		if (t->parms.link == link)
+		if (READ_ONCE(t->parms.link) == link)
 			return t;
-		else
-			cand = t;
+		cand = t;
 	}
 
 	hlist_for_each_entry_rcu(t, head, hash_node) {
@@ -117,9 +116,9 @@ struct ip_tunnel *ip_tunnel_lookup(struct ip_tunnel_net *itn,
 		if (!ip_tunnel_key_match(&t->parms, flags, key))
 			continue;
 
-		if (t->parms.link == link)
+		if (READ_ONCE(t->parms.link) == link)
 			return t;
-		else if (!cand)
+		if (!cand)
 			cand = t;
 	}
 
@@ -137,9 +136,9 @@ struct ip_tunnel *ip_tunnel_lookup(struct ip_tunnel_net *itn,
 		if (!ip_tunnel_key_match(&t->parms, flags, key))
 			continue;
 
-		if (t->parms.link == link)
+		if (READ_ONCE(t->parms.link) == link)
 			return t;
-		else if (!cand)
+		if (!cand)
 			cand = t;
 	}
 
@@ -150,9 +149,9 @@ struct ip_tunnel *ip_tunnel_lookup(struct ip_tunnel_net *itn,
 		    !(t->dev->flags & IFF_UP))
 			continue;
 
-		if (t->parms.link == link)
+		if (READ_ONCE(t->parms.link) == link)
 			return t;
-		else if (!cand)
+		if (!cand)
 			cand = t;
 	}
 
@@ -221,7 +220,7 @@ static struct ip_tunnel *ip_tunnel_find(struct ip_tunnel_net *itn,
 	hlist_for_each_entry_rcu(t, head, hash_node) {
 		if (local == t->parms.iph.saddr &&
 		    remote == t->parms.iph.daddr &&
-		    link == t->parms.link &&
+		    link == READ_ONCE(t->parms.link) &&
 		    type == t->dev->type &&
 		    ip_tunnel_key_match(&t->parms, flags, key))
 			break;
@@ -747,7 +746,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	ip_tunnel_init_flow(&fl4, protocol, dst, tnl_params->saddr,
 			    tunnel->parms.o_key, RT_TOS(tos),
-			    dev_net(dev), tunnel->parms.link,
+			    dev_net(dev), READ_ONCE(tunnel->parms.link),
 			    tunnel->fwmark, skb_get_hash(skb), 0);
 
 	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)
@@ -867,7 +866,7 @@ static void ip_tunnel_update(struct ip_tunnel_net *itn,
 	if (t->parms.link != p->link || t->fwmark != fwmark) {
 		int mtu;
 
-		t->parms.link = p->link;
+		WRITE_ONCE(t->parms.link, p->link);
 		t->fwmark = fwmark;
 		mtu = ip_tunnel_bind_dev(dev);
 		if (set_mtu)
@@ -1057,9 +1056,9 @@ EXPORT_SYMBOL(ip_tunnel_get_link_net);
 
 int ip_tunnel_get_iflink(const struct net_device *dev)
 {
-	struct ip_tunnel *tunnel = netdev_priv(dev);
+	const struct ip_tunnel *tunnel = netdev_priv(dev);
 
-	return tunnel->parms.link;
+	return READ_ONCE(tunnel->parms.link);
 }
 EXPORT_SYMBOL(ip_tunnel_get_iflink);
 
-- 
2.43.0.687.g38aa6559b0-goog


