Return-Path: <netdev+bounces-18136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E51D75574E
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 23:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4752813A7
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 21:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541009468;
	Sun, 16 Jul 2023 21:09:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488EF9448
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 21:09:29 +0000 (UTC)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD41EE66
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 14:09:25 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-765a311a7a9so163072485a.0
        for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 14:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689541765; x=1692133765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJdCDWy+3IsOfWdTY7Qj7EfbVCNKkYlBmO3jJ1zSzAQ=;
        b=eFJ4Xherv/q+ftqonqCFRHLdyti1PJCHitGELE2HvtmnCowjLhjqIE4CM+rxwPFcsm
         Y+3vsIJtFf61Z9LAeXtt8EV75KVO2hy8saZWWGiYBsQtmKG15BDJ3mLpY+F4iZeTYieR
         Q+kj4J9XfakxnwPTEwlIwv0BTUUfV7fV6mWsyDnnoBbaxWnxtI73qlBaqyhqXHcPwuVx
         h0OqlThXjAAyKXpYn3HaQd6qdfReMAoKo4LZieMeSY83B93FzK2WomFq5qAFNTRMhbwD
         KbkE+beMD9lVcJUVDR6q8lH4ajw0oJ+TnqixzvKP/LXeGjPwfzlfrvCzzsazXVrI1WFm
         HBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689541765; x=1692133765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJdCDWy+3IsOfWdTY7Qj7EfbVCNKkYlBmO3jJ1zSzAQ=;
        b=GlLv6bKOCTTeGa3nYOrT8URLTBX/9APZAaDebCxZmjRKn1ImjiEGfFrRze4KV7IwJU
         izV1yi8WJrlYHgPxXrHdxHTzLV6+8wcHXSYqedxrzH6QjEyndCd1jQYE5Cp1FGrqegFH
         HnbrENaysvNofODptRtOI+LBhNlAombg3XSiJqjyGbDmpQJzd9peJJjon8OHCqbqNSDI
         PXzimxXi09dwO96xyvKTK54dhdPE5HkUpZsF+fAb7RRr9hhEB2vZWz4UrUYGkVxO4z7h
         BwfvJ5nGqnXvHOqNdPnGNwnZG9vUF8loZKaDzDWM/oWzHr5RrMaDG+2bQ3sauo/5T7Kl
         SXpg==
X-Gm-Message-State: ABy/qLacDrmCGkaN7Jqvu32keHjOAxb0Pdat+p0inHAnZhKesBQw34Qb
	aierIFiAJxNLkhe/AL4cbDDtCad7F4n5Mg==
X-Google-Smtp-Source: APBJJlGuAp8hsY7ilScAvAcktyRYNCV6381Vamf4rRIxIg0jTb02zYap/UG8MF0ELG8somcfFh9q4Q==
X-Received: by 2002:a05:620a:17a7:b0:767:ea44:daf9 with SMTP id ay39-20020a05620a17a700b00767ea44daf9mr9893133qkb.31.1689541764728;
        Sun, 16 Jul 2023 14:09:24 -0700 (PDT)
Received: from wsfd-netdev15.ntdv.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g5-20020a0cdf05000000b0062635bd22aesm4654745qvl.109.2023.07.16.14.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 14:09:24 -0700 (PDT)
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
Subject: [PATCH net-next 3/3] openvswitch: set IPS_CONFIRMED in tmpl status only when commit is set in conntrack
Date: Sun, 16 Jul 2023 17:09:19 -0400
Message-Id: <cf477f4a26579e752465a5951c1d28ba109346e3.1689541664.git.lucien.xin@gmail.com>
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

By not setting IPS_CONFIRMED in tmpl that allows the exp not to be removed
from the hashtable when lookup, we can simplify the exp processing code a
lot in openvswitch conntrack.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/openvswitch/conntrack.c | 78 +++++--------------------------------
 1 file changed, 10 insertions(+), 68 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 331730fd3580..fa955e892210 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -455,45 +455,6 @@ static int ovs_ct_handle_fragments(struct net *net, struct sw_flow_key *key,
 	return 0;
 }
 
-static struct nf_conntrack_expect *
-ovs_ct_expect_find(struct net *net, const struct nf_conntrack_zone *zone,
-		   u16 proto, const struct sk_buff *skb)
-{
-	struct nf_conntrack_tuple tuple;
-	struct nf_conntrack_expect *exp;
-
-	if (!nf_ct_get_tuplepr(skb, skb_network_offset(skb), proto, net, &tuple))
-		return NULL;
-
-	exp = __nf_ct_expect_find(net, zone, &tuple);
-	if (exp) {
-		struct nf_conntrack_tuple_hash *h;
-
-		/* Delete existing conntrack entry, if it clashes with the
-		 * expectation.  This can happen since conntrack ALGs do not
-		 * check for clashes between (new) expectations and existing
-		 * conntrack entries.  nf_conntrack_in() will check the
-		 * expectations only if a conntrack entry can not be found,
-		 * which can lead to OVS finding the expectation (here) in the
-		 * init direction, but which will not be removed by the
-		 * nf_conntrack_in() call, if a matching conntrack entry is
-		 * found instead.  In this case all init direction packets
-		 * would be reported as new related packets, while reply
-		 * direction packets would be reported as un-related
-		 * established packets.
-		 */
-		h = nf_conntrack_find_get(net, zone, &tuple);
-		if (h) {
-			struct nf_conn *ct = nf_ct_tuplehash_to_ctrack(h);
-
-			nf_ct_delete(ct, 0, 0);
-			nf_ct_put(ct);
-		}
-	}
-
-	return exp;
-}
-
 /* This replicates logic from nf_conntrack_core.c that is not exported. */
 static enum ip_conntrack_info
 ovs_ct_get_info(const struct nf_conntrack_tuple_hash *h)
@@ -852,36 +813,16 @@ static int ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 			 const struct ovs_conntrack_info *info,
 			 struct sk_buff *skb)
 {
-	struct nf_conntrack_expect *exp;
-
-	/* If we pass an expected packet through nf_conntrack_in() the
-	 * expectation is typically removed, but the packet could still be
-	 * lost in upcall processing.  To prevent this from happening we
-	 * perform an explicit expectation lookup.  Expected connections are
-	 * always new, and will be passed through conntrack only when they are
-	 * committed, as it is OK to remove the expectation at that time.
-	 */
-	exp = ovs_ct_expect_find(net, &info->zone, info->family, skb);
-	if (exp) {
-		u8 state;
-
-		/* NOTE: New connections are NATted and Helped only when
-		 * committed, so we are not calling into NAT here.
-		 */
-		state = OVS_CS_F_TRACKED | OVS_CS_F_NEW | OVS_CS_F_RELATED;
-		__ovs_ct_update_key(key, state, &info->zone, exp->master);
-	} else {
-		struct nf_conn *ct;
-		int err;
+	struct nf_conn *ct;
+	int err;
 
-		err = __ovs_ct_lookup(net, key, info, skb);
-		if (err)
-			return err;
+	err = __ovs_ct_lookup(net, key, info, skb);
+	if (err)
+		return err;
 
-		ct = (struct nf_conn *)skb_nfct(skb);
-		if (ct)
-			nf_ct_deliver_cached_events(ct);
-	}
+	ct = (struct nf_conn *)skb_nfct(skb);
+	if (ct)
+		nf_ct_deliver_cached_events(ct);
 
 	return 0;
 }
@@ -1460,7 +1401,8 @@ int ovs_ct_copy_action(struct net *net, const struct nlattr *attr,
 	if (err)
 		goto err_free_ct;
 
-	__set_bit(IPS_CONFIRMED_BIT, &ct_info.ct->status);
+	if (ct_info.commit)
+		__set_bit(IPS_CONFIRMED_BIT, &ct_info.ct->status);
 	return 0;
 err_free_ct:
 	__ovs_ct_free_action(&ct_info);
-- 
2.39.1


