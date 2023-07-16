Return-Path: <netdev+bounces-18134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8818175574C
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 23:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3D21C20986
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 21:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7873C944B;
	Sun, 16 Jul 2023 21:09:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE939448
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 21:09:25 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18D3E5A
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 14:09:23 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6355e774d0aso19542136d6.1
        for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 14:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689541762; x=1692133762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BVBcAhIogjUc/p9bMbLAsRRz8KRA/ydghEtJQf8BD0=;
        b=QquoHKapeeE+Y+bdJe3DhWCj1/X5r9Nj1HyEgRWit6M9/lkNjUzcWuUp4MQk4So3Pz
         M0ESDLA8OMqxrCG6gkJA+YQeeUZUYTaimAhigywnRQI6tWnlOctH4AIY4SaTgVq6ZME/
         XOoJTohcf7pcLp48lE3tHCHdpyWvkKZ7HEAnnI5j3JBX14tqIsdYYEFA3YE48A4fR5JD
         pTWAKQ7WZQv9u0OUaaaeCxnbQUUqTnhmieQ8Av/P/59CStPAmPaR/13THJjyYBYedasL
         bMFYhDUFFqiJAmWmzzumLts6SryPMabYFmRKUKed2s2JHsMNr/IxQg8fP7B446uq/yNa
         pZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689541762; x=1692133762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BVBcAhIogjUc/p9bMbLAsRRz8KRA/ydghEtJQf8BD0=;
        b=Uo/p1JEWBwMcIrPY+SGfgJfXTaXJJ2O+bsNWUH7uESxMDAXVfInJ/YUldSvvsh8H3b
         Jwv6jhAAxMBafs+6WeKXTMr0oWz4w8YHxSx0wLBU62Vq4VOASBW7W+rDuaFi8Sg6XNPT
         X4ZIVuB5/JzmM6AngItEoyRgdQPNpKbw2jRdenS6F4rsaDKr5cnjH808vmdOvo9DtAg1
         qRIkX+pAQ/R3lXzTzuRQOCRPCm0HUjzkI7vrt4qC5jVz5lmBP1ybQ3nwAyjuzMxD9zIe
         jFnWgMdboKzLonSfQWm+OZK82QGflatSO7/qgnMyGxojX3chWZDIUXiG08Vi8Il29E2N
         Xeow==
X-Gm-Message-State: ABy/qLZ0VMfmft5nxlhzv6j+zbOZNcaf+HjOEkOrhmCgchM4CfI6WKf3
	DAk/sIHVfMHqaO/yeRL2W1OZW5PjMar4hQ==
X-Google-Smtp-Source: APBJJlH6zlJUrk04wSon7/Zwz2WkDqEo6tvpik9A+ghc1fArDEqXLNQ4BCy1inDBeNk3REkByQiTJw==
X-Received: by 2002:a0c:cc08:0:b0:626:3a5a:f8dc with SMTP id r8-20020a0ccc08000000b006263a5af8dcmr9054626qvk.57.1689541762500;
        Sun, 16 Jul 2023 14:09:22 -0700 (PDT)
Received: from wsfd-netdev15.ntdv.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g5-20020a0cdf05000000b0062635bd22aesm4654745qvl.109.2023.07.16.14.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 14:09:22 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	dev@openvswitch.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Aaron Conole <aconole@redhat.com>
Subject: [PATCH net-next 1/3] netfilter: allow exp not to be removed in nf_ct_find_expectation
Date: Sun, 16 Jul 2023 17:09:17 -0400
Message-Id: <74bd67f806666fd9a3975ae441c308128409ea32.1689541664.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1689541664.git.lucien.xin@gmail.com>
References: <cover.1689541664.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently nf_conntrack_in() calling nf_ct_find_expectation() will
remove the exp from the hash table. However, in some scenario, we
expect the exp not to be removed when the created ct will not be
confirmed, like in OVS and TC conntrack in the following patches.

This patch allows exp not to be removed by setting IPS_CONFIRMED
in the status of the tmpl.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 include/net/netfilter/nf_conntrack_expect.h | 2 +-
 net/netfilter/nf_conntrack_core.c           | 2 +-
 net/netfilter/nf_conntrack_expect.c         | 4 ++--
 net/netfilter/nft_ct.c                      | 2 ++
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack_expect.h b/include/net/netfilter/nf_conntrack_expect.h
index cf0d81be5a96..165e7a03b8e9 100644
--- a/include/net/netfilter/nf_conntrack_expect.h
+++ b/include/net/netfilter/nf_conntrack_expect.h
@@ -100,7 +100,7 @@ nf_ct_expect_find_get(struct net *net,
 struct nf_conntrack_expect *
 nf_ct_find_expectation(struct net *net,
 		       const struct nf_conntrack_zone *zone,
-		       const struct nf_conntrack_tuple *tuple);
+		       const struct nf_conntrack_tuple *tuple, bool unlink);
 
 void nf_ct_unlink_expect_report(struct nf_conntrack_expect *exp,
 				u32 portid, int report);
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 992393102d5f..9f6f2e643575 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -1756,7 +1756,7 @@ init_conntrack(struct net *net, struct nf_conn *tmpl,
 	cnet = nf_ct_pernet(net);
 	if (cnet->expect_count) {
 		spin_lock_bh(&nf_conntrack_expect_lock);
-		exp = nf_ct_find_expectation(net, zone, tuple);
+		exp = nf_ct_find_expectation(net, zone, tuple, !tmpl || nf_ct_is_confirmed(tmpl));
 		if (exp) {
 			/* Welcome, Mr. Bond.  We've been expecting you... */
 			__set_bit(IPS_EXPECTED_BIT, &ct->status);
diff --git a/net/netfilter/nf_conntrack_expect.c b/net/netfilter/nf_conntrack_expect.c
index 96948e98ec53..81ca348915c9 100644
--- a/net/netfilter/nf_conntrack_expect.c
+++ b/net/netfilter/nf_conntrack_expect.c
@@ -171,7 +171,7 @@ EXPORT_SYMBOL_GPL(nf_ct_expect_find_get);
 struct nf_conntrack_expect *
 nf_ct_find_expectation(struct net *net,
 		       const struct nf_conntrack_zone *zone,
-		       const struct nf_conntrack_tuple *tuple)
+		       const struct nf_conntrack_tuple *tuple, bool unlink)
 {
 	struct nf_conntrack_net *cnet = nf_ct_pernet(net);
 	struct nf_conntrack_expect *i, *exp = NULL;
@@ -211,7 +211,7 @@ nf_ct_find_expectation(struct net *net,
 		     !refcount_inc_not_zero(&exp->master->ct_general.use)))
 		return NULL;
 
-	if (exp->flags & NF_CT_EXPECT_PERMANENT) {
+	if (exp->flags & NF_CT_EXPECT_PERMANENT || !unlink) {
 		refcount_inc(&exp->use);
 		return exp;
 	} else if (del_timer(&exp->timeout)) {
diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index 38958e067aa8..e87fd4314c68 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -262,6 +262,7 @@ static void nft_ct_set_zone_eval(const struct nft_expr *expr,
 			regs->verdict.code = NF_DROP;
 			return;
 		}
+		__set_bit(IPS_CONFIRMED_BIT, &ct->status);
 	}
 
 	nf_ct_set(skb, ct, IP_CT_NEW);
@@ -368,6 +369,7 @@ static bool nft_ct_tmpl_alloc_pcpu(void)
 			return false;
 		}
 
+		__set_bit(IPS_CONFIRMED_BIT, &tmp->status);
 		per_cpu(nft_ct_pcpu_template, cpu) = tmp;
 	}
 
-- 
2.39.1


