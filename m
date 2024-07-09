Return-Path: <netdev+bounces-110368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA5F92C1D4
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8F01F239A7
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1F71C2DCA;
	Tue,  9 Jul 2024 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Q1v6X9qc"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6241C095F;
	Tue,  9 Jul 2024 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543126; cv=none; b=Ltb1PcjD8ND+MtFjwl/KFKCAHDXxZs6ObSfWebR0Y+/j/BrCzxnoxeBfEZsOfJPj0XllTjkj+whq1dVs3gZ8n2lyeP4ONllemvUaXvpnQ4069jae6qjQwVEDg65YSh1ZhAeCbyP2oWEvrE1PDMdVvHttkHazhJOvWOadLg5IB/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543126; c=relaxed/simple;
	bh=n9VSnbuZA6+5txFLRZ658BvO8DVWQTXs5yrhCIrUC1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObqxhXoXap2TJXo5sdfe+nT9IhEM47WtW8yMtdOxJFrth/muA4ENUr6+8QSIZ1fRPc60Hm/QA5oYNCp/1wWu+GVKfsnIw+wR3OySrkBLlSh8U4zXZatEwYiXQiFc+pf3GCctBzUUxP3GCRcsTwXYgZ6Kie0DEfWBq/z7J9lbbCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Q1v6X9qc; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720543113;
	bh=n9VSnbuZA6+5txFLRZ658BvO8DVWQTXs5yrhCIrUC1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q1v6X9qc6AtFRuJntGkWRe/25qMNetaDw32YUXj6Ap0F3fkE1+EM1Yu+yvilP7z3Q
	 KFmO9uLMx1tNYiR+w746L9+RuzwVKxnhab9QuLlUreKivHa/0ezJ6rUwKhbxKEzPQS
	 a0+Gw1+jtzJGytUZ10icC1l3Xr9tav6viS17NsVhmRFeVI8xKOhlMmFGLI1oSm0FQQ
	 o5YMi+leO8m78KDJ8dJh+n93PMWSFMGPgvm7e+z0moUrb0PNABfoO32InXkhNsFeze
	 xA/giGSXwDA3YzavY0554lvrywM1Xsjk1CLITUf/D2Izwzdfb2C9Vm91rdZQzQgvY6
	 FwHgkJfmKub8g==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 55FA76007C;
	Tue,  9 Jul 2024 16:38:31 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id BEC33204966; Tue, 09 Jul 2024 16:38:26 +0000 (UTC)
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
Subject: [PATCH net-next v3 05/10] flow_dissector: prepare for encapsulated control flags
Date: Tue,  9 Jul 2024 16:38:19 +0000
Message-ID: <20240709163825.1210046-6-ast@fiberby.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709163825.1210046-1-ast@fiberby.net>
References: <20240709163825.1210046-1-ast@fiberby.net>
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


