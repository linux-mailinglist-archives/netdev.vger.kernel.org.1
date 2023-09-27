Return-Path: <netdev+bounces-36384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D947AF71A
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 02:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 80F37281DA8
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 00:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DC9197;
	Wed, 27 Sep 2023 00:13:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717D1136C
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 00:13:29 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047B05589
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 17:13:28 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c5bbb205e3so89694695ad.0
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 17:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695773607; x=1696378407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KW3aFuL8O8dR3kRbqmT+ARsollJPUDKAYpQ+DwVRtxs=;
        b=AlgOt5BPxwfwJhC5aIkUaAVlF0zB5bp3c+e6S3hVdKxDa1CYQQsbyLi9CSC/yvOAU+
         LRUTD+s0rjiZeAe3P0D2yvX/5SGKZzo8pDCG6PcckqQ8ZGHaus1IRgrdx/zb7o3lvZFX
         wwILplbSeitX0SM5+tcj3RGtPq/HQAVV06NIN9KeedTyFIVhUqgyLqroVWyruNIDCPSD
         sEQXwPDnA+bMl4Wifvf4Gs2VBYFr/aQH9TQbPdrWgvE1JVv9KoDSUN87qDqOh9iKCbqi
         i1itkxpUWs51xi4tf+MOf+p9iLLez/kHu9pwsnqJS3KdfAnd/fvfX1t8ETdnMN8sacNo
         73qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695773607; x=1696378407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KW3aFuL8O8dR3kRbqmT+ARsollJPUDKAYpQ+DwVRtxs=;
        b=Xh9qXpQQZylmwBfcIh68ZQJGdCKYYthAYlnvDqEu7qQRiud5DT8cxKBfLrTrZ53SdT
         yJDYRrTulYA5GezRjex3KTVS/itd+af9BoruYzoMl4aZALPb5YlW0q5WdNVc0SyBf2LQ
         aBR5Uhggmjlp3nnVLB05CTZxATnBgD0qHJV9qacplReiVShOvkmGuWVsiUSoXDaRw7oV
         S8oCDeZ7Tm8vKIIkShGV+jM26odFo+ymexOQIdGSHxKz+jSSk5gdLwpqnW2tWmrB/lIr
         CM5Tcxau21AwYQZt8TqQ+AOcLevwjdAqTjG3PJFTYsWgt1CbzxmF0N/9fTBxSasU4XIH
         311Q==
X-Gm-Message-State: AOJu0Yx2GTQ89CpeZAqtqXc15bKelH+n6q+CaC4BpAU92/YPmpPkikb3
	trGMfLwMWwj2YS38RWBUdALy0IDFOAc=
X-Google-Smtp-Source: AGHT+IEc29fSkECPHqhAoHPkyRUqk1O24wtvTXfIHqWiidvz3VYa7JYnOcmMr96iXFM6aoEHZdlnvA==
X-Received: by 2002:a17:903:25d2:b0:1c3:2532:ac71 with SMTP id jc18-20020a17090325d200b001c32532ac71mr348256plb.31.1695773607227;
        Tue, 26 Sep 2023 17:13:27 -0700 (PDT)
Received: from wheely.local0.net ([203.63.110.121])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902c3c100b001bc18e579aesm5623333plj.101.2023.09.26.17.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 17:13:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: netdev@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	dev@openvswitch.org,
	Pravin B Shelar <pshelar@ovn.org>
Subject: [RFC PATCH 3/7] net: openvswitch: uninline action execution
Date: Wed, 27 Sep 2023 10:13:04 +1000
Message-Id: <20230927001308.749910-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927001308.749910-1-npiggin@gmail.com>
References: <20230927001308.749910-1-npiggin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

A function tends to use as much stack as the maximum of any control
flow path. Compilers can "shrink wrap" to special-case stack allocation,
but that only works well for exclusive paths. The switch statement in
the loop in do_execute_actions uses as much stack as the maximum of its
cases, and so inlining large actions increases overall stack uage. This
is particularly bad because the actions that cause recursion are not the
largest stack users.

Uninline action execution functions, which reduces the stack usage of
do_execute_actions from 288 bytes to 112 bytes.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 net/openvswitch/actions.c | 69 +++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 31 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index af177701a606..b4d4150c5e69 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -913,8 +913,9 @@ static void ovs_fragment(struct net *net, struct vport *vport,
 	ovs_kfree_skb_reason(skb, reason);
 }
 
-static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
-		      struct sw_flow_key *key)
+static noinline_for_stack void do_output(struct datapath *dp,
+					 struct sk_buff *skb, int out_port,
+					 struct sw_flow_key *key)
 {
 	struct vport *vport = ovs_vport_rcu(dp, out_port);
 
@@ -944,10 +945,11 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
 	}
 }
 
-static int output_userspace(struct datapath *dp, struct sk_buff *skb,
-			    struct sw_flow_key *key, const struct nlattr *attr,
-			    const struct nlattr *actions, int actions_len,
-			    uint32_t cutlen)
+static noinline_for_stack
+int output_userspace(struct datapath *dp, struct sk_buff *skb,
+		     struct sw_flow_key *key, const struct nlattr *attr,
+		     const struct nlattr *actions, int actions_len,
+		     uint32_t cutlen)
 {
 	struct dp_upcall_info upcall;
 	const struct nlattr *a;
@@ -1022,9 +1024,9 @@ static int dec_ttl_exception_handler(struct datapath *dp, struct sk_buff *skb,
  * Otherwise, sample() should keep 'skb' intact regardless what
  * actions are executed within sample().
  */
-static int sample(struct datapath *dp, struct sk_buff *skb,
-		  struct sw_flow_key *key, const struct nlattr *attr,
-		  bool last)
+static noinline_for_stack int sample(struct datapath *dp, struct sk_buff *skb,
+				     struct sw_flow_key *key,
+				     const struct nlattr *attr, bool last)
 {
 	struct nlattr *actions;
 	struct nlattr *sample_arg;
@@ -1053,9 +1055,10 @@ static int sample(struct datapath *dp, struct sk_buff *skb,
  * Otherwise, clone() should keep 'skb' intact regardless what
  * actions are executed within clone().
  */
-static int clone(struct datapath *dp, struct sk_buff *skb,
-		 struct sw_flow_key *key, const struct nlattr *attr,
-		 bool last)
+static noinline_for_stack int clone(struct datapath *dp,
+				    struct sk_buff *skb,
+				    struct sw_flow_key *key,
+				    const struct nlattr *attr, bool last)
 {
 	struct nlattr *actions;
 	struct nlattr *clone_arg;
@@ -1071,8 +1074,9 @@ static int clone(struct datapath *dp, struct sk_buff *skb,
 			     !dont_clone_flow_key);
 }
 
-static void execute_hash(struct sk_buff *skb, struct sw_flow_key *key,
-			 const struct nlattr *attr)
+static noinline_for_stack void execute_hash(struct sk_buff *skb,
+					    struct sw_flow_key *key,
+					    const struct nlattr *attr)
 {
 	struct ovs_action_hash *hash_act = nla_data(attr);
 	u32 hash = 0;
@@ -1094,9 +1098,9 @@ static void execute_hash(struct sk_buff *skb, struct sw_flow_key *key,
 	key->ovs_flow_hash = hash;
 }
 
-static int execute_set_action(struct sk_buff *skb,
-			      struct sw_flow_key *flow_key,
-			      const struct nlattr *a)
+static noinline_for_stack int execute_set_action(struct sk_buff *skb,
+						 struct sw_flow_key *flow_key,
+						 const struct nlattr *a)
 {
 	/* Only tunnel set execution is supported without a mask. */
 	if (nla_type(a) == OVS_KEY_ATTR_TUNNEL_INFO) {
@@ -1114,9 +1118,9 @@ static int execute_set_action(struct sk_buff *skb,
 /* Mask is at the midpoint of the data. */
 #define get_mask(a, type) ((const type)nla_data(a) + 1)
 
-static int execute_masked_set_action(struct sk_buff *skb,
-				     struct sw_flow_key *flow_key,
-				     const struct nlattr *a)
+static noinline_for_stack
+int execute_masked_set_action(struct sk_buff *skb, struct sw_flow_key *flow_key,
+			      const struct nlattr *a)
 {
 	int err = 0;
 
@@ -1189,9 +1193,9 @@ static int execute_masked_set_action(struct sk_buff *skb,
 	return err;
 }
 
-static int execute_recirc(struct datapath *dp, struct sk_buff *skb,
-			  struct sw_flow_key *key,
-			  const struct nlattr *a, bool last)
+static noinline_for_stack
+int execute_recirc(struct datapath *dp, struct sk_buff *skb,
+		   struct sw_flow_key *key, const struct nlattr *a, bool last)
 {
 	u32 recirc_id;
 
@@ -1208,9 +1212,10 @@ static int execute_recirc(struct datapath *dp, struct sk_buff *skb,
 	return clone_execute(dp, skb, key, recirc_id, NULL, 0, last, true);
 }
 
-static int execute_check_pkt_len(struct datapath *dp, struct sk_buff *skb,
-				 struct sw_flow_key *key,
-				 const struct nlattr *attr, bool last)
+static noinline_for_stack
+int execute_check_pkt_len(struct datapath *dp, struct sk_buff *skb,
+			  struct sw_flow_key *key, const struct nlattr *attr,
+			  bool last)
 {
 	struct ovs_skb_cb *ovs_cb = OVS_CB(skb);
 	const struct nlattr *actions, *cpl_arg;
@@ -1247,7 +1252,8 @@ static int execute_check_pkt_len(struct datapath *dp, struct sk_buff *skb,
 			     nla_len(actions), last, clone_flow_key);
 }
 
-static int execute_dec_ttl(struct sk_buff *skb, struct sw_flow_key *key)
+static noinline_for_stack int execute_dec_ttl(struct sk_buff *skb,
+					      struct sw_flow_key *key)
 {
 	int err;
 
@@ -1526,10 +1532,11 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
  * The execution may be deferred in case the actions can not be executed
  * immediately.
  */
-static int clone_execute(struct datapath *dp, struct sk_buff *skb,
-			 struct sw_flow_key *key, u32 recirc_id,
-			 const struct nlattr *actions, int len,
-			 bool last, bool clone_flow_key)
+static noinline_for_stack
+int clone_execute(struct datapath *dp, struct sk_buff *skb,
+		  struct sw_flow_key *key, u32 recirc_id,
+		  const struct nlattr *actions, int len, bool last,
+		  bool clone_flow_key)
 {
 	struct deferred_action *da;
 	struct sw_flow_key *clone;
-- 
2.40.1


