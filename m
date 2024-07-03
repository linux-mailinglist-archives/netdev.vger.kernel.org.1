Return-Path: <netdev+bounces-108806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD2E925AAE
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C014029B4C1
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 10:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C4118755D;
	Wed,  3 Jul 2024 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="skZCax/8"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F47174EF3;
	Wed,  3 Jul 2024 10:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003647; cv=none; b=MgVNomdLrr/G3NI566Qubxbd318ZrTi4KKvuxJqfLZqPLOfnhoXx6IbTO3TNFjZXEgoW9l+nSVI8+T76N8u3sGMT+pbEAo6kLu4QBmamgbgoM6fKRuaap0Fn835Ei8yKrKs2JI4iPFJi3YSGHvXa+dmsXBIMD4idH/I9VhOLU2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003647; c=relaxed/simple;
	bh=kSTfCLkKS0s5aJ70wGt0YwUjY86b+vK6VqyeeEV310Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNvtooBfXD7imM0AxsgRIWTAOFAKEWFuUbc2reWl++QjKVOP8wtDXeIudOs4ow2nZ6o328oE/vAPiKo+O1QXadrxdd5rMnphG0mGXaA85ojAH6x/bBYYb+Vo2xdlBuVYpeJUvbmqwP6x4twkI2T2aPAb1b+bwuSwZSbFRXcu9kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=skZCax/8; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720003635;
	bh=kSTfCLkKS0s5aJ70wGt0YwUjY86b+vK6VqyeeEV310Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=skZCax/8MyWUOKFs4I8GsmfdKoEuGp+SobzYDAKcx8D3n8vVPjJUgswd+wSG9kP/q
	 WAGowO4ouSghYosLtR0gFM7xQDCfin6ONkIuxarCtTM8Pxm25klyJQrXyyYX4l9VrH
	 pI5PdX58cKGNpG00REwt0DgWiaKL8mhHeLnCrgoYQM5SUFD6AfEECB8gtJSHYBhjPQ
	 vROeCpb2wQaZlpoOnc1KSnV2sOKd7QdMAgyUyvToorSE2OXNIPoDf9WGGmSU53xCLv
	 5z/nQDzS9ohEWcLoaBMcqhlaNIn0vKGEB9dKp/YkffhC2Y/v3N+obsI588gj3bGF8N
	 qR8dMXg4DcF3g==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 35CA56007C;
	Wed,  3 Jul 2024 10:46:59 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 7D4B42046FC; Wed, 03 Jul 2024 10:46:32 +0000 (UTC)
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
Subject: [PATCH net-next 8/9] flow_dissector: cleanup FLOW_DISSECTOR_KEY_ENC_FLAGS
Date: Wed,  3 Jul 2024 10:45:57 +0000
Message-ID: <20240703104600.455125-9-ast@fiberby.net>
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

Now that TCA_FLOWER_KEY_ENC_FLAGS is unused, as it's
former data is stored behind TCA_FLOWER_KEY_ENC_CONTROL,
then remove the last bits of FLOW_DISSECTOR_KEY_ENC_FLAGS.

FLOW_DISSECTOR_KEY_ENC_FLAGS is unreleased, and have been
in net-next since 2024-06-04.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 include/net/flow_dissector.h |  9 ---------
 include/net/ip_tunnels.h     | 12 ------------
 net/core/flow_dissector.c    | 16 +---------------
 net/sched/cls_flower.c       |  3 ---
 4 files changed, 1 insertion(+), 39 deletions(-)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index f560e2c8d0e7..17a8a8634751 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -338,14 +338,6 @@ struct flow_dissector_key_cfm {
 #define FLOW_DIS_CFM_MDL_MASK GENMASK(7, 5)
 #define FLOW_DIS_CFM_MDL_MAX 7
 
-/**
- * struct flow_dissector_key_enc_flags: tunnel metadata control flags
- * @flags: tunnel control flags
- */
-struct flow_dissector_key_enc_flags {
-	u32 flags;
-};
-
 enum flow_dissector_key_id {
 	FLOW_DISSECTOR_KEY_CONTROL, /* struct flow_dissector_key_control */
 	FLOW_DISSECTOR_KEY_BASIC, /* struct flow_dissector_key_basic */
@@ -380,7 +372,6 @@ enum flow_dissector_key_id {
 	FLOW_DISSECTOR_KEY_L2TPV3, /* struct flow_dissector_key_l2tpv3 */
 	FLOW_DISSECTOR_KEY_CFM, /* struct flow_dissector_key_cfm */
 	FLOW_DISSECTOR_KEY_IPSEC, /* struct flow_dissector_key_ipsec */
-	FLOW_DISSECTOR_KEY_ENC_FLAGS, /* struct flow_dissector_key_enc_flags */
 
 	FLOW_DISSECTOR_KEY_MAX,
 };
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 3877315cf8b8..1db2417b8ff5 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -247,18 +247,6 @@ static inline bool ip_tunnel_is_options_present(const unsigned long *flags)
 	return ip_tunnel_flags_intersect(flags, present);
 }
 
-static inline void ip_tunnel_set_encflags_present(unsigned long *flags)
-{
-	IP_TUNNEL_DECLARE_FLAGS(present) = { };
-
-	__set_bit(IP_TUNNEL_CSUM_BIT, present);
-	__set_bit(IP_TUNNEL_DONT_FRAGMENT_BIT, present);
-	__set_bit(IP_TUNNEL_OAM_BIT, present);
-	__set_bit(IP_TUNNEL_CRIT_OPT_BIT, present);
-
-	ip_tunnel_flags_or(flags, flags, present);
-}
-
 static inline bool ip_tunnel_flags_is_be16_compat(const unsigned long *flags)
 {
 	IP_TUNNEL_DECLARE_FLAGS(supp) = { };
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index a0263a4c5489..1a9ca129fddd 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -385,9 +385,7 @@ skb_flow_dissect_tunnel_info(const struct sk_buff *skb,
 	    !dissector_uses_key(flow_dissector,
 				FLOW_DISSECTOR_KEY_ENC_IP) &&
 	    !dissector_uses_key(flow_dissector,
-				FLOW_DISSECTOR_KEY_ENC_OPTS) &&
-	    !dissector_uses_key(flow_dissector,
-				FLOW_DISSECTOR_KEY_ENC_FLAGS))
+				FLOW_DISSECTOR_KEY_ENC_OPTS))
 		return;
 
 	info = skb_tunnel_info(skb);
@@ -489,18 +487,6 @@ skb_flow_dissect_tunnel_info(const struct sk_buff *skb,
 				    IP_TUNNEL_GENEVE_OPT_BIT);
 		enc_opt->dst_opt_type = val < __IP_TUNNEL_FLAG_NUM ? val : 0;
 	}
-
-	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_ENC_FLAGS)) {
-		struct flow_dissector_key_enc_flags *enc_flags;
-		IP_TUNNEL_DECLARE_FLAGS(flags) = {};
-
-		enc_flags = skb_flow_dissector_target(flow_dissector,
-						      FLOW_DISSECTOR_KEY_ENC_FLAGS,
-						      target_container);
-		ip_tunnel_set_encflags_present(flags);
-		ip_tunnel_flags_and(flags, flags, info->key.tun_flags);
-		enc_flags->flags = bitmap_read(flags, IP_TUNNEL_CSUM_BIT, 32);
-	}
 }
 EXPORT_SYMBOL(skb_flow_dissect_tunnel_info);
 
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index e2239ab01355..897d6b683cc6 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -85,7 +85,6 @@ struct fl_flow_key {
 	struct flow_dissector_key_l2tpv3 l2tpv3;
 	struct flow_dissector_key_ipsec ipsec;
 	struct flow_dissector_key_cfm cfm;
-	struct flow_dissector_key_enc_flags enc_flags;
 } __aligned(BITS_PER_LONG / 8); /* Ensure that we can do comparisons as longs. */
 
 struct fl_flow_mask_range {
@@ -2223,8 +2222,6 @@ static void fl_init_dissector(struct flow_dissector *dissector,
 			     FLOW_DISSECTOR_KEY_IPSEC, ipsec);
 	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
 			     FLOW_DISSECTOR_KEY_CFM, cfm);
-	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
-			     FLOW_DISSECTOR_KEY_ENC_FLAGS, enc_flags);
 
 	skb_flow_dissector_init(dissector, keys, cnt);
 }
-- 
2.45.2


