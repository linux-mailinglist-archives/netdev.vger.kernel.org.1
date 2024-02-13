Return-Path: <netdev+bounces-71177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C34B852901
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90E128431A
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 06:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D6D14284;
	Tue, 13 Feb 2024 06:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w3W8OMgo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FA814287
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805975; cv=none; b=On1gViUwQxj0JIJo8UxtpnPJdWEwcdObiW4Mcz3I7U18FSMorSfuGHSp9LgRmw1IsUQaMnCCk9JHCQgnojwfQgmBog2aKVB8HNv7ZGoZh1LSW4hkYnfFwBsC39GR9lTvoa1S7wIPpZUHW9JE+Jt/jeg6Kx7KRcQppnsV0AwEBFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805975; c=relaxed/simple;
	bh=2QdaKw6HNYgE90+Lcuxa1iCBKePEDBnvblv2L3k5W4s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XYWqjbm35uMqBRzXlT7vLzwb6B1SlerOGI3OP+L9bK0lwm+r4kTxpxq0XbigS7w/7aPKzBuLCKt77uJ5sptBGTKMTIGtBv9ujjMnwTs29T+BtfbrBiMqMi/JJlMSk/kisE9c04WNuDBRvxq0+y1FZQ+Wp+e7bF7nMz93YCGFU/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w3W8OMgo; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-603c0e020a6so49835397b3.0
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 22:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707805973; x=1708410773; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l76Myz5QVY8zfVBScuI9w2fWj5vlY//uceSC7wdESko=;
        b=w3W8OMgoKX8HqG0+9d7SM+30NNZlpes/regFnbbZ4GKG0IUEeHADgkrQXa6/V2PUIG
         eSfuQEotwZozukU7MCufVe6o1PPxbSW/FIJWBIoDQOC1z9YgJH5ID2aF75RfzAruo7wb
         w/P4JP1RrRZSe4zmTyjbcAkZb8KjJAE5IVlzuXgaFX89i77OGMh009Zuan2gnktALTRz
         aNwDTUj4BLZclyL+9Rw+ODZUhyPFogTbLXmlNB++YnUI03VBhdWCcc5DY2StGFtRPQIF
         4Ety7leqJWr2RPj/fgIrHGu2NsrqCw7vtyT6Fpq+FuvVX4LyPjy3nO5eMHN0bw4hCzUn
         /2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707805973; x=1708410773;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l76Myz5QVY8zfVBScuI9w2fWj5vlY//uceSC7wdESko=;
        b=nCpDomiVaw0pSxpxis9gfyF6rA+3+QnEH5EIX4kEToUmswco8+LvmM/KC5LZMJxLQj
         k5ZQJOkOeWmlXV/TvaeYoA+iz0IoTnZ46xRlbuwwyPAniOltLrSg6lEIkw5Wu+1lk+5P
         wCRiPVtRIS21zoQhZX7SsXcS0zJz1DfvvuYqOXNaORWbz9yKA40BjXuukWZkjRmIBaHx
         2dxTaHRK6WXUV6IhbhYiuJvwDoR6XHFCL2673jCOwmHhjN8vhHZF/R39OUfXeF406zef
         uZjNOvpVK7nMrsIEbX6D/xRAojKwbcuApzSWAwnGwFnNkE6Rjwi+8XUfmje2nLXvfQZl
         by6g==
X-Gm-Message-State: AOJu0YzqvsDnd2ApLoV6gaGFSg/aCYZMU9kEFVvVTtekYLd7R2KF47GL
	5sn+oliSyaPpbqXv084dyO/HLtVWEP5TNUi9Ef5mjk+0dCByYsSQMe8fe0ZC3uPPT3FhVnBAWZC
	J4Nuv9IqL4A==
X-Google-Smtp-Source: AGHT+IGIraJny/46HjgQAj46JaU4+CLyIjkxpimHVMLbIw7QQe2qGSeQw213Z41rHVdRvlCRtp+sH2NDLo+tKw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1887:b0:dc6:c94e:fb85 with SMTP
 id cj7-20020a056902188700b00dc6c94efb85mr327517ybb.2.1707805973233; Mon, 12
 Feb 2024 22:32:53 -0800 (PST)
Date: Tue, 13 Feb 2024 06:32:34 +0000
In-Reply-To: <20240213063245.3605305-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213063245.3605305-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213063245.3605305-3-edumazet@google.com>
Subject: [PATCH v4 net-next 02/13] ip_tunnel: annotate data-races around t->parms.link
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


