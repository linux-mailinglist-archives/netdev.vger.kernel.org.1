Return-Path: <netdev+bounces-32956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 587D579ABFA
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 00:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D6828148C
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 22:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5C28C1D;
	Mon, 11 Sep 2023 22:05:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB6B23D9
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 22:05:56 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59AA13ADF
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 15:05:14 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-58cd9d9dbf5so68520157b3.0
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 15:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1694469529; x=1695074329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxvY65blzl7yOJ12jhRUnG33IHcZrwJ6B7wIwHp0ocg=;
        b=2eAcHZwN92N7ok6KnD9SWMFzn9TMS24h/krY85x31f27VxByXx+Ek1RGG7I1wDr9cB
         CCerUFFj33f9rap3fc+ME/Q28wOmvGO4bkBjg5Bxs9eN+XrGpuiP90HuVEIs0cT0CIPA
         AklvI/oLvXwjhTgyIYoq9sNqDWmlmWIpBiSvAarv5b1GA8Nu8iPOWEQQVCJjzgIJ88Yr
         6CHnek+MkU4Rg5M+UqR/qk0utRrw7D8Qc9pcK+01HSm+lnj+XimcL0x65NKS/qxxngcu
         hjV1stasyr6cTXeq6SVoGu36Z3N2ms7VZ8brolwUcv14VwCTcbVh9v4SQJ+c6xgv08Ij
         XsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694469529; x=1695074329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxvY65blzl7yOJ12jhRUnG33IHcZrwJ6B7wIwHp0ocg=;
        b=xP38ApCxtYldHWhk5VRQhJdI3yul7kI7vxQlMeG2qxJBSQoBUxouvErboQdJa24V0Q
         jM+muBM+gT7woDYlGfWtc8djV6EdUp4Hg8i3kR2/58J372Ca31mrK12F+ZqIXiNggm3O
         s4ciwclwDZp5td8bQsmAcviJYsdOaZi489X0WaLB47sOHDZNaoAAdFoi4NxJPv35L6c5
         l4tOSdKcO1M2DEU0hDv881R3xlyNxP/gTw2TnBi2ITruJeCdl2Sq5iEUHt/zjOz47b2Q
         YfR8prP87l23JquMn0VLOTbRp3u//6QH2HkyOHG7/KiJhExb4kmYyfLOLnuAkKmuKDkC
         BInA==
X-Gm-Message-State: AOJu0YyrAf5bcpeV5ohZcPOzdLc3D/S9C1KC9mx9w95abqx3KbhFDouC
	8rGdzOAoXpi9HdgGTWJHdBdDJtAIJ+GIJay5wmg=
X-Google-Smtp-Source: AGHT+IHy4lEtLffrKZvG1XzYpNxB7jmMxfx4Ikos50YLSoHGXUgDTGdB9CSOkpOliLatS9TYy3edRg==
X-Received: by 2002:a05:6870:95a8:b0:1c5:dcd:5d64 with SMTP id k40-20020a05687095a800b001c50dcd5d64mr444750oao.7.1694469060341;
        Mon, 11 Sep 2023 14:51:00 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:accd:6e1c:69ae:3f11])
        by smtp.gmail.com with ESMTPSA id 3-20020a4a0603000000b0057635c1a4f2sm3776869ooj.25.2023.09.11.14.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 14:51:00 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	victor@mojatatu.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v3 4/4] net/sched: cls_route: make netlink errors meaningful
Date: Mon, 11 Sep 2023 18:50:16 -0300
Message-Id: <20230911215016.1096644-5-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230911215016.1096644-1-pctammela@mojatatu.com>
References: <20230911215016.1096644-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use netlink extended ack and parsing policies to return more meaningful
errors instead of the relying solely on errnos.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/cls_route.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index 1e20bbd687f1..484d8185b6b8 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -375,9 +375,9 @@ static int route4_delete(struct tcf_proto *tp, void *arg, bool *last,
 
 static const struct nla_policy route4_policy[TCA_ROUTE4_MAX + 1] = {
 	[TCA_ROUTE4_CLASSID]	= { .type = NLA_U32 },
-	[TCA_ROUTE4_TO]		= { .type = NLA_U32 },
-	[TCA_ROUTE4_FROM]	= { .type = NLA_U32 },
-	[TCA_ROUTE4_IIF]	= { .type = NLA_U32 },
+	[TCA_ROUTE4_TO]		= NLA_POLICY_MAX(NLA_U32, 0xFF),
+	[TCA_ROUTE4_FROM]	= NLA_POLICY_MAX(NLA_U32, 0xFF),
+	[TCA_ROUTE4_IIF]	= NLA_POLICY_MAX(NLA_U32, 0x7FFF),
 };
 
 static int route4_set_parms(struct net *net, struct tcf_proto *tp,
@@ -397,33 +397,37 @@ static int route4_set_parms(struct net *net, struct tcf_proto *tp,
 		return err;
 
 	if (tb[TCA_ROUTE4_TO]) {
-		if (new && handle & 0x8000)
+		if (new && handle & 0x8000) {
+			NL_SET_ERR_MSG(extack, "Invalid handle");
 			return -EINVAL;
+		}
 		to = nla_get_u32(tb[TCA_ROUTE4_TO]);
-		if (to > 0xFF)
-			return -EINVAL;
 		nhandle = to;
 	}
 
+	if (tb[TCA_ROUTE4_FROM] && tb[TCA_ROUTE4_IIF]) {
+		NL_SET_ERR_MSG_ATTR(extack, tb[TCA_ROUTE4_FROM],
+				    "'from' and 'fromif' are mutually exclusive");
+		return -EINVAL;
+	}
+
 	if (tb[TCA_ROUTE4_FROM]) {
-		if (tb[TCA_ROUTE4_IIF])
-			return -EINVAL;
 		id = nla_get_u32(tb[TCA_ROUTE4_FROM]);
-		if (id > 0xFF)
-			return -EINVAL;
 		nhandle |= id << 16;
 	} else if (tb[TCA_ROUTE4_IIF]) {
 		id = nla_get_u32(tb[TCA_ROUTE4_IIF]);
-		if (id > 0x7FFF)
-			return -EINVAL;
 		nhandle |= (id | 0x8000) << 16;
 	} else
 		nhandle |= 0xFFFF << 16;
 
 	if (handle && new) {
 		nhandle |= handle & 0x7F00;
-		if (nhandle != handle)
+		if (nhandle != handle) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Handle mismatch constructed: %x (expected: %x)",
+					   handle, nhandle);
 			return -EINVAL;
+		}
 	}
 
 	if (!nhandle) {
@@ -478,7 +482,6 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
 	struct route4_filter __rcu **fp;
 	struct route4_filter *fold, *f1, *pfp, *f = NULL;
 	struct route4_bucket *b;
-	struct nlattr *opt = tca[TCA_OPTIONS];
 	struct nlattr *tb[TCA_ROUTE4_MAX + 1];
 	unsigned int h, th;
 	int err;
@@ -489,10 +492,12 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
 		return -EINVAL;
 	}
 
-	if (opt == NULL)
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tca, TCA_OPTIONS)) {
+		NL_SET_ERR_MSG_MOD(extack, "Missing options");
 		return -EINVAL;
+	}
 
-	err = nla_parse_nested_deprecated(tb, TCA_ROUTE4_MAX, opt,
+	err = nla_parse_nested_deprecated(tb, TCA_ROUTE4_MAX, tca[TCA_OPTIONS],
 					  route4_policy, NULL);
 	if (err < 0)
 		return err;
-- 
2.39.2


