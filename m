Return-Path: <netdev+bounces-102761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBCA9047D7
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 01:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA84CB230CC
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 23:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD5E156F34;
	Tue, 11 Jun 2024 23:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="rXVGP64Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2CC156885;
	Tue, 11 Jun 2024 23:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718150068; cv=none; b=FjPvbDNkmxCsoWcmB7TGLM5wvk8OG714wrHFaGIcZiNQMSr1oYnW0fhPjGwcT1ON8k2zo7F0H3xWfx6nxNMOFeGbiEKLS0Zug4hR4WSBC04X1/ESiG8Myc6Rqes8cts4aoG2Esd7U7JSyWbNWr2ufv120xTCN/1CRCkcF5avOO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718150068; c=relaxed/simple;
	bh=XL16U9LwuxFtzlKPJGSc5NxjViV134aXxN0bG9vZ01g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VmDgc6XLa/WmD5VfB26mrpkasc0c/j9j1VImhKfMXbRjkakC2burzCmVjZPjATXd6oXBIKWqC54imjvl5Sz8m6YgixOxBp76t/g6opOjXvW8GME8+WmvfCiQBs1Yuj3TndZyuNKSS4mspVXLg5r+DS3FAhhCSjMvmmluTPL1bRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=rXVGP64Y; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1718150057;
	bh=XL16U9LwuxFtzlKPJGSc5NxjViV134aXxN0bG9vZ01g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rXVGP64YRcBjM6yL6clQE67D96IsebYaI4wvCuZDgKc3KvJWnMNf3dcw5fVQbHwgt
	 r8NOdnQNPnzRnaIxXP/UyVSyG+jyAzOQBK/F3egy0CHHABbeRRTHrWUdFx+u9MJ9LT
	 tAyrm5m+PkdGELuMxDIZmVGhOqFWBz1Py/S3XBRFTR96hZ3CKQao1B4qKfOGyXxhpJ
	 dbb4Xrkj7AEwaYkkW6o8cAKIRW9CQyuvwGE16BTDT1XjGvGdwyooEa9igSI7iNuLDp
	 VuULM+FA/hty1tbfn+PHeWvVNh2TyNrEh/gYwAs91ZgXCOmbs1cTBO1cRHJL/jR5Hb
	 qZyS4qbCgN52w==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 99F2B6007E;
	Tue, 11 Jun 2024 23:54:10 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 9F43B20314C; Tue, 11 Jun 2024 23:54:00 +0000 (UTC)
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
Subject: [RFC PATCH net-next 8/9] flow_dissector: cleanup FLOW_DISSECTOR_KEY_ENC_FLAGS
Date: Tue, 11 Jun 2024 23:53:41 +0000
Message-ID: <20240611235355.177667-9-ast@fiberby.net>
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
index 1f0fddb29a0d8..58717bcaf8496 100644
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
index 5a530d4fb02c6..9a6a08ec77139 100644
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
index 6e9bd4cecab66..5fac97dbbd606 100644
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
index 80e5467b8eaee..4e8ae4240922e 100644
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
2.45.1


