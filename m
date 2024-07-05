Return-Path: <netdev+bounces-109497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 678629289CC
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F971F21BCA
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2614158A06;
	Fri,  5 Jul 2024 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="OOVzPrVz"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0240C15532C;
	Fri,  5 Jul 2024 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186459; cv=none; b=NLSPZQxiZLc8qMlcrguufec15vCnfe3qkczMySKn/4gahLQqtC+6nOXO+uEltH3QvKtkQujk1YOl4q6Vw+k6+tZBLrGXKSFSFfPlYVDOPBNN09L37hwoCgskHA/OUtDhAYjoh+Asj0eR+k6/vDd2xUBRHctdcWbKIFvAw5GSWeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186459; c=relaxed/simple;
	bh=n9VSnbuZA6+5txFLRZ658BvO8DVWQTXs5yrhCIrUC1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OR1x2pDJJgADCghP4EgOqu+KpqGY53P/sUJDFs8DXkkasKgkHfd4o0KhmjEqHC0vgcSVgRTdq9fgNypfHb9mSrhV2wq0Opg58J83UoGknTSKAA7L3dYbnal04T0QhHSkk7wuvvsIXyA9aREOffF1mvJodDNWFRkJvP/J+99hO34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=OOVzPrVz; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720186451;
	bh=n9VSnbuZA6+5txFLRZ658BvO8DVWQTXs5yrhCIrUC1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OOVzPrVzMCJMRerv4tUHsRVR+wwzYRIG8kFmDXcspNMUtT+py8tMfuaZCf1weTNCI
	 7GYGKdFfnNuSxv7gLEycX3kFIhjbgqKaDVhQLKrlSjDdipsBehgUV8YUlZDYMZw3w4
	 ehp30BWsTe0PKwb9G/UzqpPZpg/US4xjQaSn4t3PnIg0BFUr2nXGf8J2HzGv4WuoSw
	 4chXRJBBYzZD7eQ2Vgq8xeQHaljh11z76hDHojOxIGGBDanIAq8uTqJrqZrC+O0ruy
	 F91xS7nKiwWhcvkJ4pomgNRBzFZ430O8Aih1WBhwkJCQJtf5KNCRrg92IAcpBUF6v/
	 s8kQCM0Vo/M0A==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 053C56008C;
	Fri,  5 Jul 2024 13:34:11 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id ACEE620484E; Fri, 05 Jul 2024 13:33:50 +0000 (UTC)
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
Subject: [PATCH net-next v2 05/10] flow_dissector: prepare for encapsulated control flags
Date: Fri,  5 Jul 2024 13:33:41 +0000
Message-ID: <20240705133348.728901-6-ast@fiberby.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705133348.728901-1-ast@fiberby.net>
References: <20240705133348.728901-1-ast@fiberby.net>
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
Tested-by: Davide Caratti <dcaratti@redhat.com>
---
 net/core/flow_dissector.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index e64a263798070..1614c6708ea7c 100644
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


