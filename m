Return-Path: <netdev+bounces-138063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DCC9ABB95
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 04:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B271C22835
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 02:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3C38615A;
	Wed, 23 Oct 2024 02:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqdvGl1W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253FF8289A
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 02:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729650745; cv=none; b=DibB2o1qwf9inws31zpQS0/GhcoMaC/Vbj31dLd/obaXh97CgZP8CsRlGN9RBop11kQbSowJV3Pq1f0eFSocx07N6iralFaXa3mEQLkETnw7nTns3ZnHByYdKJQxlTe6KciFU/0mZs/+t++yRXw+Fw8RKsEoFU/He1cyGiisgKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729650745; c=relaxed/simple;
	bh=msjLdmI7eZv6iOp/4R6FDEdaIwsy+STZb5PQIgx6BqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LX6dE2eHa4gZSjsTikNSxJCF5I+g2zAPgFDeYLvnDSZovEVJqStRITFUNz5othNOZUWvJ1bqeRStuyLXqVKR7vCM11KbmJdTwOc0wefjSwoEQtQW9h1V5oeJvyv8Jo7AgFmVBoAC7+TYQlZicufOIrqUQcGH2RbAe0rOSrcBuIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqdvGl1W; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7d916b6a73aso4011029a12.1
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 19:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729650743; x=1730255543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAI1ERJNMU7DRNqtWoqCKDb9xZyhLsX5eDa0lA+o94s=;
        b=CqdvGl1Wm06jEeuLd4jJRYPotugEPgHezCUU4UO85lOhi3ePvklnMeTQ3YTg52OUaA
         SsuN9Wd7NDknshU/q9xp/EOyyydeUButN8WMDmV3PdK6asva59JsBfl8pLAC9BfKdRfh
         qzbzaurGDzhJdQwPnZMa+lBnT/0GyGKWAL/WHUUX5YcqkZoAq2rH8lDbSpqSlfufr8q/
         H82vqbtQ98Hddyq4PLaLDAwTak8IE0HITCpCju01wsMEM9gwFyoYw5uYGYf4PdZALR5w
         e6w38XsnT67d72vBH7eMnGWrXbObB2klIL5xTp2CnOarLZnFrukUyIOQY+02YNESOutB
         2N6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729650743; x=1730255543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAI1ERJNMU7DRNqtWoqCKDb9xZyhLsX5eDa0lA+o94s=;
        b=rJcH/OX2Uda4sSRRXOvCBy/1mem2mOUrpmpo8u4I5M7YEQbAREo3n5DRKu12oX1hLG
         rPyLo5a/vzTd3Tr8gx90te7CsFX24GGlB1MpIFO6KfpzRpzpjKs6rM+zfRP8xLHAnLql
         oRay0Hq+EH/EzIFwjUJH+XO/yL9yKjG7N0zFwIVRSedyWcb1fkm5nmLIb4kHu/YSWXSe
         +Gs7O24kP3N5+eWcg+b4hTZCzfubdBo/4+OCA2aSAEjX5FzWvdPjUsUSAxL360cbXdhl
         h9I+VQvrwT9pi7gf1pNSNQwSd1FEw1bu0gTTAvggMZhkpelEo1QwenD8zBj+SwRcngeH
         pxAQ==
X-Gm-Message-State: AOJu0YwhrGzIDJwcEoE+SkTz0Nh/hWJ2unX/rcu8coLeeWfEPL6Dh+eO
	SABuwpyjLr8g4io95czaGPZGni6cIU9K4jQ0A2lRhVVGjra/E/Pa9FqcEqHD2yg=
X-Google-Smtp-Source: AGHT+IGgDUxT06z/1wez874znvjqRL3hC/Z4QWu68IJiSKAbMKm97o/LowxynpbSRGB128obd7poAg==
X-Received: by 2002:a05:6a21:3511:b0:1d8:a4f7:67ae with SMTP id adf61e73a8af0-1d978b243d0mr1243739637.17.1729650743029;
        Tue, 22 Oct 2024 19:32:23 -0700 (PDT)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaea9386e5sm4972284a12.0.2024.10.22.19.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 19:32:21 -0700 (PDT)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 3/5] net: ip_tunnel: Build flow in underlay net namespace
Date: Wed, 23 Oct 2024 10:31:44 +0800
Message-ID: <20241023023146.372653-4-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241023023146.372653-1-shaw.leon@gmail.com>
References: <20241023023146.372653-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Build IPv4 flow in underlay net namespace, where encapsulated packets
are routed.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/ipv4/ip_tunnel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index d591c73e2c0e..09ee39e7b617 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -294,7 +294,7 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
 
 		ip_tunnel_init_flow(&fl4, iph->protocol, iph->daddr,
 				    iph->saddr, tunnel->parms.o_key,
-				    iph->tos & INET_DSCP_MASK, dev_net(dev),
+				    iph->tos & INET_DSCP_MASK, tunnel->net,
 				    tunnel->parms.link, tunnel->fwmark, 0, 0);
 		rt = ip_route_output_key(tunnel->net, &fl4);
 
@@ -611,7 +611,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	}
 	ip_tunnel_init_flow(&fl4, proto, key->u.ipv4.dst, key->u.ipv4.src,
 			    tunnel_id_to_key32(key->tun_id),
-			    tos & INET_DSCP_MASK, dev_net(dev), 0, skb->mark,
+			    tos & INET_DSCP_MASK, tunnel->net, 0, skb->mark,
 			    skb_get_hash(skb), key->flow_flags);
 
 	if (!tunnel_hlen)
@@ -774,7 +774,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	ip_tunnel_init_flow(&fl4, protocol, dst, tnl_params->saddr,
 			    tunnel->parms.o_key, tos & INET_DSCP_MASK,
-			    dev_net(dev), READ_ONCE(tunnel->parms.link),
+			    tunnel->net, READ_ONCE(tunnel->parms.link),
 			    tunnel->fwmark, skb_get_hash(skb), 0);
 
 	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)
-- 
2.47.0


