Return-Path: <netdev+bounces-291455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ON5jHPiyFGozPgcAu9opvQ
	(envelope-from <netdev+bounces-291455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 22:37:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D93865CE97F
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 22:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A535A301AF6E
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82319221FC6;
	Mon, 25 May 2026 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XFI4aXvz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1247326B764
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741406; cv=none; b=a/qOtK0TFoIPZKxvXzcShJglTs36GX7NYwEjkTr39B8Eqqy0nB2QxRpLiMLPljXwpUl209tmWgx+UvkSsHn6Uf00TZhHv6i3evBhnohC/Tz5q492AKJBgFy5fxZN6W8qX5VSwigwEeQR3ObXdNJkxmzbhILzmE100QJSQmywTUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741406; c=relaxed/simple;
	bh=S/7f/4lLI1yx9DjoJjzbhWh7NU9cRgAZKFx9X35ajPY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OnbfH8xogXVAjTr/BsY7HviDfPlqaysvsz03yVd2nRnXS1Eav/rwAimLsdoyJpe3NJos59+J/B8coiYkG6B05U+tkCX/RxMGzJrB3K2/37/M6BgQFEEn16Yd/9ypnJWFbB616ipl4u0YdjwpUrvROJZkmoTrr1XnN4KlLsOP93w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XFI4aXvz; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-516d1a8a6c8so28425471cf.2
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 13:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779741404; x=1780346204; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c+5bjCNG+m99Wa5Y3Z9UVTI0tHsz1+fdgadzgclby2U=;
        b=XFI4aXvzBXyZ1FpenYYuN3i/GUubVYVXRoZLFg3VN5MYo1OgInAzfPnDie0aOFx/Uo
         izaauf3PPU9bJ1iDD58zkuVwa+jbX5YmBS0GcKPu2klrH+1ctJxpF6UAEihEm1GXO2AX
         Y5nZTGidN0+rEC3ZJlRv4rScQ9xhDiy33O4hD/ZePltZyykK0JQzMCIjTpymQ1ORWe56
         pc3W/5r7q/MPS+JaMfuL4oHgFPXdmjKT1JfT9zdPW0rPMm+QEQkPwyqEHtfoAEdojpO8
         x3wnMfumoJy5erSQSB/o6w8fUIYKTXS+vD5iLw7aND0CIPKjpa0jpJ1e9tsRop5/Brj2
         Su1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779741404; x=1780346204;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c+5bjCNG+m99Wa5Y3Z9UVTI0tHsz1+fdgadzgclby2U=;
        b=HfM/me44yhN+GoOSI7xQ2UmGT8GOrHTaUWJrrZHh6AmMm1G5iumiqJS45RyTqe3p7L
         Y7NdvvsEMb/ixWMTFSjFnrwG3VD22GDzA1cZbjsBX8tLu8Obhp+og+0DzY6rBPxPWgZ8
         DxGEEG6Uu0K11VPWG4/zILlJ3qCu2CiednRlYW3no8B2J+wYh5sPpUIMK0UZTSybFVZY
         6iSqdLyAvrWo6Cp+JQPQDwT6RhM9tTgHWGlyMMxIHIIRQKfTMD3NLes+D9VPd33XiZfl
         NN+3wQw+1iAiV8J0fmptyQfK8W0+ARtdzaolRbHyuRflq2KbPoIW146YYiCyvk6Chfrl
         7ZqA==
X-Forwarded-Encrypted: i=1; AFNElJ9sufj1pxZ5hHxJ+M3UecAfK/L8lCwK7YphLRFg8yrJ8Ta58C8mORQMzCbSOWGHvX8rpTmHDzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFXgNGyAbIdiFZqL71A1G1ZE8jH6RZ1g7JlgwJ8Uk3HakemFMT
	FNwDKht5gqsFBfWG4qEetdhHhPQgOg3zHeWy2lSRkR1jJUVVcL3xwyYvkIzIJDHlV7DM1NkGGL/
	1bURVVeEUHG6Yaw==
X-Received: from qtqh18.prod.google.com ([2002:ac8:5492:0:b0:514:c2a9:fcc])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:995:b0:50f:b1e6:a8f6 with SMTP id d75a77b69052e-516d444e163mr233607991cf.26.1779741403771;
 Mon, 25 May 2026 13:36:43 -0700 (PDT)
Date: Mon, 25 May 2026 20:36:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525203642.2389723-1-edumazet@google.com>
Subject: [PATCH net] vxlan: do not reuse cached ip_hdr() value after skb_tunnel_check_pmtu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Stefano Brivio <sbrivio@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291455-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.964];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D93865CE97F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

skb_tunnel_check_pmtu() can change skb->head.

Reusing old_iph afer skb_tunnel_check_pmtu() can cause an UAF.

Use instead ip_hdr(skb) as done in drivers/net/bareudp.c
and drivers/net/geneve.c.

Found by Sashiko.

Fixes: 4cb47a8644cc ("tunnels: PMTU discovery support for directly bridged IP packets")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Stefano Brivio <sbrivio@redhat.com>
---
 drivers/net/vxlan/vxlan_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index e88798497503b53cbaf5bffad72cf3e1cc956410..b5b1253ac08ba46933249b06f19d1fe5a2ffd114 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2531,7 +2531,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			goto out_unlock;
 		}
 
-		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
+		tos = ip_tunnel_ecn_encap(tos, ip_hdr(skb), skb);
 		ttl = ttl ? : ip4_dst_hoplimit(&rt->dst);
 		err = vxlan_build_skb(skb, ndst, sizeof(struct iphdr),
 				      vni, md, flags, udp_sum);
@@ -2605,7 +2605,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			goto out_unlock;
 		}
 
-		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
+		tos = ip_tunnel_ecn_encap(tos, ip_hdr(skb), skb);
 		ttl = ttl ? : ip6_dst_hoplimit(ndst);
 		skb_scrub_packet(skb, xnet);
 		err = vxlan_build_skb(skb, ndst, sizeof(struct ipv6hdr),
-- 
2.54.0.746.g67dd491aae-goog


