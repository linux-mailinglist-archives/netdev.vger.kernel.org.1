Return-Path: <netdev+bounces-41163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5847CA04E
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5FF82816F1
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 07:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37A7168C8;
	Mon, 16 Oct 2023 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnhyCJkl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31E715ACA
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 07:15:39 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B377E5;
	Mon, 16 Oct 2023 00:15:38 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso722564966b.2;
        Mon, 16 Oct 2023 00:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697440537; x=1698045337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owZcEmAsFdnN8HKDvbp9Goa51e2ivCQAo3bw3SJCz0I=;
        b=fnhyCJklTryQU4A5dJoAxjSSoioIgt0Aot737rHCdxxdZpE5vTpDPmOewgKtkJoALJ
         IPwckp7DMElsWKa3F66gNpgwOVpCCjxOZTgd4B+5zQ2NGw9E2eR8qj7/FMkh9i5vyN3Y
         8YBJQDvpRGZ+TfOm/X3bbzfnS5J9hJasbVD721XGiDIKNv9gAMhho97g509ZhotmTw1R
         WuIPX3jPPjEXVzVkoyYmFFYfPQy8nM7BZFNTNb9WNoXLLxLGsUdLLZiFZPtEsc1xubY0
         O2w0VWygZfCmzxiECqI3ptxV1f2xabA8a04e3QEZHQ/qUJkImlC7M3rTa8nwTkcFLysm
         t9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697440537; x=1698045337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owZcEmAsFdnN8HKDvbp9Goa51e2ivCQAo3bw3SJCz0I=;
        b=pzMR2Anconvl5kwYmTi8RPAxRFLWFbWHQtVmHiG/71fBHWr4n1RU7556/WJ3SpR7KD
         E61WpmMmZ04qGgcQT8lXip9ApNthLyiopZhv9Scaf4l6XU9AjfWiSRMqwTPXTWbh0442
         DK/CKa/g7nhqbTg4WfF+FH1gUXz7Uqx56fi2k1bM8Z/9grVI3JbnPRqAp5S/o7ZscG+u
         MuOfOMzCFPdM9BayU3Q+b3BpCetGONwpXXdXODah/A1HxQKuIAHaYL40ODoA7njJyMfh
         aTwqPKDM6VhgnQy5PDmFzvtC1baFrWGk37Ul97r6HQFtdFpXglkSXbhnW+e+8LXuMiJA
         zCwA==
X-Gm-Message-State: AOJu0YwueAGrRhnnIs8AAx5mh2yGNtTIzlHS/F5onrzgcnhp7tUnYHBP
	54Pla8aiUi0dWHOl2OhtxOMDFfUXYvo=
X-Google-Smtp-Source: AGHT+IG5Qn3LiKhL9xFhIaXfF9feMh2Mcf+f4abuSs5DsL9HORwkWWMopSfSn73tW0vGG17ONj13GA==
X-Received: by 2002:a17:906:3051:b0:9a5:7759:19c0 with SMTP id d17-20020a170906305100b009a5775919c0mr28221306ejd.64.1697440536997;
        Mon, 16 Oct 2023 00:15:36 -0700 (PDT)
Received: from tp.home.arpa (host-79-55-64-40.retail.telecomitalia.it. [79.55.64.40])
        by smtp.gmail.com with ESMTPSA id jl25-20020a17090775d900b00992e265495csm3419471ejc.212.2023.10.16.00.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 00:15:36 -0700 (PDT)
From: Beniamino Galvani <b.galvani@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 5/7] geneve: add dsfield helper function
Date: Mon, 16 Oct 2023 09:15:24 +0200
Message-Id: <20231016071526.2958108-6-b.galvani@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231016071526.2958108-1-b.galvani@gmail.com>
References: <20231016071526.2958108-1-b.galvani@gmail.com>
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

Add a helper function to compute the tos/dsfield. In this way, we can
factor out some duplicate code. Also, the helper will be called from
more places in the next commit.

Suggested-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 drivers/net/geneve.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 78f9d588f712..572c3e36b209 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -784,6 +784,22 @@ static int geneve_build_skb(struct dst_entry *dst, struct sk_buff *skb,
 	return err;
 }
 
+static u8 geneve_get_dsfield(struct sk_buff *skb, struct net_device *dev,
+			     const struct ip_tunnel_info *info,
+			     bool *use_cache)
+{
+	struct geneve_dev *geneve = netdev_priv(dev);
+	u8 dsfield;
+
+	dsfield = info->key.tos;
+	if (dsfield == 1 && !geneve->cfg.collect_md) {
+		dsfield = ip_tunnel_get_dsfield(ip_hdr(skb), skb);
+		*use_cache = false;
+	}
+
+	return dsfield;
+}
+
 static struct rtable *geneve_get_v4_rt(struct sk_buff *skb,
 				       struct net_device *dev,
 				       struct geneve_sock *gs4,
@@ -810,11 +826,7 @@ static struct rtable *geneve_get_v4_rt(struct sk_buff *skb,
 	fl4->fl4_sport = sport;
 	fl4->flowi4_flags = info->key.flow_flags;
 
-	tos = info->key.tos;
-	if ((tos == 1) && !geneve->cfg.collect_md) {
-		tos = ip_tunnel_get_dsfield(ip_hdr(skb), skb);
-		use_cache = false;
-	}
+	tos = geneve_get_dsfield(skb, dev, info, &use_cache);
 	fl4->flowi4_tos = RT_TOS(tos);
 	if (full_tos)
 		*full_tos = tos;
@@ -865,12 +877,7 @@ static struct dst_entry *geneve_get_v6_dst(struct sk_buff *skb,
 	fl6->fl6_dport = dport;
 	fl6->fl6_sport = sport;
 
-	prio = info->key.tos;
-	if ((prio == 1) && !geneve->cfg.collect_md) {
-		prio = ip_tunnel_get_dsfield(ip_hdr(skb), skb);
-		use_cache = false;
-	}
-
+	prio = geneve_get_dsfield(skb, dev, info, &use_cache);
 	fl6->flowlabel = ip6_make_flowinfo(prio, info->key.label);
 	dst_cache = (struct dst_cache *)&info->dst_cache;
 	if (use_cache) {
-- 
2.40.1


