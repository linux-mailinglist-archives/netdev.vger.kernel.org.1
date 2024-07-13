Return-Path: <netdev+bounces-111192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B671A930344
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 04:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3B91C2091A
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 02:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED3945945;
	Sat, 13 Jul 2024 02:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="PYaW3XJs"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5C2200A0;
	Sat, 13 Jul 2024 02:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720837167; cv=none; b=R4RHlqdpWjSTy74IUTud0iBYh5QGxyjmWO0eh3amhLDYOMyV1gwth1S+T5qmxgrICHrPpw/HaL1T0wVlaFXmJAO3RCCY9C9dlxR6RLP/TjYbxmT0PLrbTfXq0p2h9/0W5vJYV1esL0x4t7Am5DDqCDEfaEcc6iVaMEBDibLvDXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720837167; c=relaxed/simple;
	bh=O/4yTlUweswsflt5/H5wpVd5rOKApvpNad6DRvqa+nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZYFacuOzo9tzoArW42SwscHXxy72m5PXpCUum+6HR0cTvP49B0PouSoOGGqmxjv8fK7qsR1RkDJcseI7+l19HNQeI2FsC+xKn2XFYBpSk/Cty7pBVBiSVMvrEM4KEkbTBAEN4jOwoW/cblP+GRv53sgsCKS0QOzCwB3nENEZbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=PYaW3XJs; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720837159;
	bh=O/4yTlUweswsflt5/H5wpVd5rOKApvpNad6DRvqa+nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PYaW3XJsDkpq/XKl0UAwUTv12GxqsWxSRQxrMVmIXb/+/ZQht3VA2/9rz3aL2Wrse
	 jXmM0DyxjvGGV0t9LK1ZsIAiHt4yyNhqRzDxo4YSfmPKsFmdlwrgStAOOzpZTcPlQK
	 1CvJ6d6eLqOUtSV/wcXC0WO4so9RG3WWjMnd9JVA8YyugX5aXIeTmXn2zynBknol5A
	 g7JEjsvJJRUM+MN3CyL7N7z93+Vzvgk/c5kp6LvNadvV7ChLNgDrdEKDNDnCcCX14z
	 n/6jLZGpBYXlxZ3e3bWkRUKmNd2M8s6SVx9O63ykVyD5zmgr0zudNBOOc27UnGlRAg
	 tqsjZoIZ7qWTw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id C825F600A5;
	Sat, 13 Jul 2024 02:19:19 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id A9B69204CC9; Sat, 13 Jul 2024 02:19:12 +0000 (UTC)
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
	Donald Hunter <donald.hunter@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 11/13] flow_dissector: cleanup FLOW_DISSECTOR_KEY_ENC_FLAGS
Date: Sat, 13 Jul 2024 02:19:08 +0000
Message-ID: <20240713021911.1631517-12-ast@fiberby.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240713021911.1631517-1-ast@fiberby.net>
References: <20240713021911.1631517-1-ast@fiberby.net>
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
Tested-by: Davide Caratti <dcaratti@redhat.com>
Reviewed-by: Davide Caratti <dcaratti@redhat.com>
---
 include/net/flow_dissector.h |  9 ---------
 include/net/ip_tunnels.h     | 12 ------------
 net/core/flow_dissector.c    | 16 +---------------
 net/sched/cls_flower.c       |  3 ---
 4 files changed, 1 insertion(+), 39 deletions(-)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index 460ea65b9e592..ced79dc8e8560 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -342,14 +342,6 @@ struct flow_dissector_key_cfm {
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
@@ -384,7 +376,6 @@ enum flow_dissector_key_id {
 	FLOW_DISSECTOR_KEY_L2TPV3, /* struct flow_dissector_key_l2tpv3 */
 	FLOW_DISSECTOR_KEY_CFM, /* struct flow_dissector_key_cfm */
 	FLOW_DISSECTOR_KEY_IPSEC, /* struct flow_dissector_key_ipsec */
-	FLOW_DISSECTOR_KEY_ENC_FLAGS, /* struct flow_dissector_key_enc_flags */
 
 	FLOW_DISSECTOR_KEY_MAX,
 };
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 3877315cf8b8c..1db2417b8ff52 100644
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
index a0263a4c5489e..1a9ca129fddde 100644
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
index e2239ab013555..897d6b683cc6f 100644
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


