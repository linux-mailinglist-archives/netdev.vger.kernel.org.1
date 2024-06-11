Return-Path: <netdev+bounces-102760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBB29047D4
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 01:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63911F23B07
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 23:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4BD156C52;
	Tue, 11 Jun 2024 23:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="c36arCXm"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4BC156238;
	Tue, 11 Jun 2024 23:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718150067; cv=none; b=RkJwP1n3PTaVTD79rYk/1ilpQI1ii9NBkc2/a3U2nbRultqaKemguvw3+YTFo9w9RvwSt9CoA89Uv2rr/apPjLjjRN54HmQBBXUW/6JFG26SCMsMQN3o9/hocLdJSsH3wKUwHlp/dVDy4Qs04rlX5NwdK2tOnV8x2iudXvTV9No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718150067; c=relaxed/simple;
	bh=hHIlmnwV2uoFflSw91rJfSS30wlcgJ7OWfJvy5pCPkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVX4rHZkOrxoiGFxdqwC6OEk+lrru4GG0hUbRGLGJq6xKQRfYt6iP3JlVmKkOTP3bwPvxNdTbxYuGW8EtzpVpTwYmCeMkYbbooUqUSJIT0jt8njZzaryeYRNW8XBXKJfKsEIyfEsmx7stEqKrccrLDOwcSTtcxZO758fybszK6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=c36arCXm; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1718150057;
	bh=hHIlmnwV2uoFflSw91rJfSS30wlcgJ7OWfJvy5pCPkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c36arCXman8NFNXDByQYdsfOQzJTTkkymSywHCnkPYLiBLaIeeIi43dKIRqb4lPh4
	 HHS0Rzx6m07HPoyEV4K/LwHxBL2J3zEfirSL61UuRtoeuAAS0ItqrombGOdftUuoK1
	 SdcbrupqMgfO2Xnrq1PiDo38SXMSrfWWSns2eM+BmYfLRRyK+TW7gki/5xAKlIk8C6
	 +ftiQY6sjszY9vHgfUwWVwqQTWZFGD8hShhn1Wv9osx0nKnpzESgQ4UwdqDyyHvnrP
	 5TdfHw7LP0FF/bEXYct36UbfHbBV9EQ7uHQh5pincXtfAQ8RhImm4nV6l9Zd8LEEKI
	 iqJYDxKcXlb8A==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 955B36007C;
	Tue, 11 Jun 2024 23:54:10 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 79437202F2C; Tue, 11 Jun 2024 23:54:00 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Davide Caratti <dcaratti@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 4/9] flow_dissector: prepare for encapsulated control flags
Date: Tue, 11 Jun 2024 23:53:37 +0000
Message-ID: <20240611235355.177667-5-ast@fiberby.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611235355.177667-1-ast@fiberby.net>
References: <20240611235355.177667-1-ast@fiberby.net>
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
index 59fe46077b3ca..86a11a01445ad 100644
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
2.45.1


