Return-Path: <netdev+bounces-109494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC8E9289C3
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9441F22217
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC0B14D2B9;
	Fri,  5 Jul 2024 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Dbf5BDT4"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B0E149DF7;
	Fri,  5 Jul 2024 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186456; cv=none; b=D341q6dkNF6hyggOs36ynNTfbGR7wMONCVYEYW4qNsyKoiOg583tv1eep4MLcRPyounAI8zETc5rhjHq5upLzhcmqmPspU1lp98a6gDie+0latWeVAH6cw9B1QZk07pKG9hu/OwxKWLnSq6dsXqfbR7cmLQC6zrHD/04AeGytSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186456; c=relaxed/simple;
	bh=dVWPlq9stmnPkyoqz1bgNjgDVefAda05VgvkOzC0S+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IcWnLyWmcgEwyOh0psN6u3ut88ouJmSiPvTS21nt+P/vt1rTqpjx4Sd9Hek9aLEPhWd9f26cj+Rs4hX0HcyrcG/dUF1mR5wNeXujPI+/5AnLjb1Y/V76zBdAu2t57ZOk/MxlJWYazdFg582ZHPX69lJjnl1RJmU2UZN/rqzcIeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Dbf5BDT4; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720186451;
	bh=dVWPlq9stmnPkyoqz1bgNjgDVefAda05VgvkOzC0S+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dbf5BDT4Ff87Fr7eu3yi3fJjykhBw0wxQ+92r5wlcTzYZ3n5r+9U2ASYgJ2bMIMEJ
	 Uy+7sHBvDtsxQLgkJjwCCYYRmlS04aRJ4D/WKOLBi4inMgroDofwRbIWRgbNMEcjQO
	 7dNu6mVrZKs3hcOdoaRIetUmYUcjQH2/wIsbNxLE5DR7K4sXeL7dZ111C7+v988XaQ
	 qoR/hhQBpPyoj9Fr3tcBseBoykTZ6gEzvp5vZSU1hfIsebTDUqVuO8isVYScPylwz3
	 UfkOfPod/Qw5fhQaxC21ZxRzRoTvMjPZYk0z3Cw5Ho8Gj1MHVnC7gFH5EK1QiB6T+c
	 PbYgGPiVcAu2w==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 141A36008D;
	Fri,  5 Jul 2024 13:34:11 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 6A845204966; Fri, 05 Jul 2024 13:33:51 +0000 (UTC)
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
Subject: [PATCH net-next v2 09/10] flow_dissector: cleanup FLOW_DISSECTOR_KEY_ENC_FLAGS
Date: Fri,  5 Jul 2024 13:33:45 +0000
Message-ID: <20240705133348.728901-10-ast@fiberby.net>
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

Now that TCA_FLOWER_KEY_ENC_FLAGS is unused, as it's
former data is stored behind TCA_FLOWER_KEY_ENC_CONTROL,
then remove the last bits of FLOW_DISSECTOR_KEY_ENC_FLAGS.

FLOW_DISSECTOR_KEY_ENC_FLAGS is unreleased, and have been
in net-next since 2024-06-04.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Tested-by: Davide Caratti <dcaratti@redhat.com>
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


