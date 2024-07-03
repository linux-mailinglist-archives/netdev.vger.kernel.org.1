Return-Path: <netdev+bounces-108804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B597925A4E
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 12:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D621F21F11
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 10:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBD9187540;
	Wed,  3 Jul 2024 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Xj/n5YFd"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5817216DEAC;
	Wed,  3 Jul 2024 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003647; cv=none; b=dHn7ZeSqPNkR/FBU0fgmTDfzEcoPaRAUGx0TD1vStHgCsE4ewrXSEA47D3m6zdjzzDwBaRzuUqcvT2Gs1bHPzql/va9k63NauTeBlvAmatp1Yv0yFhO05rqhYQazZDx1OTRzbAHClUD7pQXgUay/UbBJ8kh0p/mxmY0t5aOxeOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003647; c=relaxed/simple;
	bh=x3/P101kTrWBP0mOd7ouZ5Zzmzv0mY5UEzLYFmlbEnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwu6zdKmz1r2nDYPfruUVEmmkk5mxA0EL2WVmtFziIOTFj6Bl/nyIuwsrwzNkUwocKrg5FDlvnEVVawPvDwHx2DQtFB5vR9aJHhpMj1X4deEex7adFvYSwH8TMfOh/7UtYMU1JmE62nP1RAsmgPbs1T4faDloC0P5BLpoTfAen0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Xj/n5YFd; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720003636;
	bh=x3/P101kTrWBP0mOd7ouZ5Zzmzv0mY5UEzLYFmlbEnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xj/n5YFdGB5eR0vDvR5mfOgRtsri8MNKOV1Mpsx16jTM4t43r0fQErkUOWcb9Sw2J
	 1r1BqO4lvXh8nXKw9WJWy9bRumRS4YT+szTrxD7c7jd4dq09XE9NDcgNieboFuv/sK
	 Aah/MH6A1pCrgDKE6WS0h1Lyg8lphf/tHOE3SkCy4U80HfmpNCfbEMB6dKx0ahAPc/
	 2cmIjbU4eCcElZy0wiSQlzN8GEyiC/uytEEthEz1p6pMO8pJONmz4R2lJ4G3iSPlKM
	 6Lafd2uYnIk1rNd363oOcbIsBOufQhxcIg3+JmH7Sznuwlgp4NECcZE8f0tO9Qyxa8
	 qw1NgTzxEHBSg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 2A1D96008B;
	Wed,  3 Jul 2024 10:47:16 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 61F4F204519; Wed, 03 Jul 2024 10:46:25 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Davide Caratti <dcaratti@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Florian Westphal <fw@strlen.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/9] flow_dissector: prepare for encapsulated control flags
Date: Wed,  3 Jul 2024 10:45:53 +0000
Message-ID: <20240703104600.455125-5-ast@fiberby.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703104600.455125-1-ast@fiberby.net>
References: <20240703104600.455125-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rename skb_flow_dissect_set_enc_addr_type() to
skb_flow_dissect_set_enc_control(), and make it set both
addr_type and flags in FLOW_DISSECTOR_KEY_ENC_CONTROL.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 net/core/flow_dissector.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index e64a26379807..1614c6708ea7 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -299,9 +299,10 @@ void skb_flow_dissect_meta(const struct sk_buff *skb,
 EXPORT_SYMBOL(skb_flow_dissect_meta);
 
 static void
-skb_flow_dissect_set_enc_addr_type(enum flow_dissector_key_id type,
-				   struct flow_dissector *flow_dissector,
-				   void *target_container)
+skb_flow_dissect_set_enc_control(enum flow_dissector_key_id type,
+				 u32 ctrl_flags,
+				 struct flow_dissector *flow_dissector,
+				 void *target_container)
 {
 	struct flow_dissector_key_control *ctrl;
 
@@ -312,6 +313,7 @@ skb_flow_dissect_set_enc_addr_type(enum flow_dissector_key_id type,
 					 FLOW_DISSECTOR_KEY_ENC_CONTROL,
 					 target_container);
 	ctrl->addr_type = type;
+	ctrl->flags = ctrl_flags;
 }
 
 void
@@ -367,6 +369,7 @@ skb_flow_dissect_tunnel_info(const struct sk_buff *skb,
 {
 	struct ip_tunnel_info *info;
 	struct ip_tunnel_key *key;
+	u32 ctrl_flags = 0;
 
 	/* A quick check to see if there might be something to do. */
 	if (!dissector_uses_key(flow_dissector,
@@ -395,9 +398,9 @@ skb_flow_dissect_tunnel_info(const struct sk_buff *skb,
 
 	switch (ip_tunnel_info_af(info)) {
 	case AF_INET:
-		skb_flow_dissect_set_enc_addr_type(FLOW_DISSECTOR_KEY_IPV4_ADDRS,
-						   flow_dissector,
-						   target_container);
+		skb_flow_dissect_set_enc_control(FLOW_DISSECTOR_KEY_IPV4_ADDRS,
+						 ctrl_flags, flow_dissector,
+						 target_container);
 		if (dissector_uses_key(flow_dissector,
 				       FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS)) {
 			struct flow_dissector_key_ipv4_addrs *ipv4;
@@ -410,9 +413,9 @@ skb_flow_dissect_tunnel_info(const struct sk_buff *skb,
 		}
 		break;
 	case AF_INET6:
-		skb_flow_dissect_set_enc_addr_type(FLOW_DISSECTOR_KEY_IPV6_ADDRS,
-						   flow_dissector,
-						   target_container);
+		skb_flow_dissect_set_enc_control(FLOW_DISSECTOR_KEY_IPV6_ADDRS,
+						 ctrl_flags, flow_dissector,
+						 target_container);
 		if (dissector_uses_key(flow_dissector,
 				       FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS)) {
 			struct flow_dissector_key_ipv6_addrs *ipv6;
-- 
2.45.2


