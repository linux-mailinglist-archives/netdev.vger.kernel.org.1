Return-Path: <netdev+bounces-36382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 913757AF718
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 02:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A14BA28259B
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 00:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB86197;
	Wed, 27 Sep 2023 00:13:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2926110F6
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 00:13:25 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BAD4ED8
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 17:13:22 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-690f7d73a3aso8931442b3a.0
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 17:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695773602; x=1696378402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSgYiRCYt1363lggyuUkHxtIxmN4dJJNRSQ3gemLbtA=;
        b=QnQFG7vdSu4aeZdl7zctvXcolJDaxe2FAIZPgE42tsX5uELjO9WsHnsZSuX4sHa6vJ
         ylRSB+OrbfPTccKs+RL9vuGNrToR5sPSaEqdxxHstAEZ1py6ctIV6wgvtcAQl4U4LrG1
         YK3IdZR3YNP47REXV+IKBEBt7LmVNUGeJqURJIh71wz1ocbCweumNdfdHSgZbwaEQKc8
         9UqvrNk0cpyOR22hH69vnwoyZuVLY0rSfzHA908mbVF+bqXYsGfFo94s3TWOq0KP1vvP
         VQZm5WtBMae1mrLgS3BmfVIhOJzrJFwGUswy1n9Mb2AGxYmIOlqqVRxCmP6KwsANIhaN
         DWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695773602; x=1696378402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSgYiRCYt1363lggyuUkHxtIxmN4dJJNRSQ3gemLbtA=;
        b=axA4PKNDPRA5XMKhBpdZqdbSEOc/OBI3fRdVp12JMo+6JGCdg6ZBc+t+dJww2oAX6Y
         Z3YC3236XTD7883BtjonQegOwmc3rQT/tW2c6BLMSFpLRp+qZ0eI9oZh9MA/EdV7vb97
         wVFv+RwExC/aa7mh2af6ZKYXoLBv+h9HjtUklYylzh/CqiENPkJ9BVrrB3fJ3hIjWJkb
         QBO9NFeeRsyadTbECeQS/wbhVjfsFFU6UA9ob+4mUfXskcSqU81ZGi5cNHf/gNsk1W2v
         F5E3oGTuTPDgF0t/AiiNtwdsmheAyutu9YA32wC1ZVq0AYkLbcJauzQsZtQMq5lSi8SY
         RkGg==
X-Gm-Message-State: AOJu0YxMObnBaTOSPeQrB9/rU8+JswJ/FWw6GvdP+hqcjYULfdOR1ck0
	lXRgVO7rU+GTG4udLfeyAVdtF9Svecc=
X-Google-Smtp-Source: AGHT+IFQbQagGC2q3NPQzim2PrBBKTyGczkssRa1QpxvaSX8KbD7D9aMIrdtVfI+7RpKyyurPY1ZkQ==
X-Received: by 2002:a05:6a21:3d84:b0:157:eb32:e739 with SMTP id bj4-20020a056a213d8400b00157eb32e739mr387666pzc.32.1695773601907;
        Tue, 26 Sep 2023 17:13:21 -0700 (PDT)
Received: from wheely.local0.net ([203.63.110.121])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902c3c100b001bc18e579aesm5623333plj.101.2023.09.26.17.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 17:13:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: netdev@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	dev@openvswitch.org,
	Pravin B Shelar <pshelar@ovn.org>
Subject: [RFC PATCH 1/7] net: openvswitch: Move NSH buffer out of do_execute_actions
Date: Wed, 27 Sep 2023 10:13:02 +1000
Message-Id: <20230927001308.749910-2-npiggin@gmail.com>
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

This takes do_execute_actions stack use from 544 bytes to 288
bytes. execute_push_nsh uses 336 bytes, but it is a leaf call not
involved in recursion.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 net/openvswitch/actions.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index fd66014d8a76..8933caa92794 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -1286,6 +1286,21 @@ static int execute_dec_ttl(struct sk_buff *skb, struct sw_flow_key *key)
 	return 0;
 }
 
+static noinline_for_stack int execute_push_nsh(struct sk_buff *skb,
+					       struct sw_flow_key *key,
+					       const struct nlattr *attr)
+{
+	u8 buffer[NSH_HDR_MAX_LEN];
+	struct nshhdr *nh = (struct nshhdr *)buffer;
+	int err;
+
+	err = nsh_hdr_from_nlattr(attr, nh, NSH_HDR_MAX_LEN);
+	if (likely(!err))
+		err = push_nsh(skb, key, nh);
+
+	return err;
+}
+
 /* Execute a list of actions against 'skb'. */
 static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 			      struct sw_flow_key *key,
@@ -1439,17 +1454,9 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 			err = pop_eth(skb, key);
 			break;
 
-		case OVS_ACTION_ATTR_PUSH_NSH: {
-			u8 buffer[NSH_HDR_MAX_LEN];
-			struct nshhdr *nh = (struct nshhdr *)buffer;
-
-			err = nsh_hdr_from_nlattr(nla_data(a), nh,
-						  NSH_HDR_MAX_LEN);
-			if (unlikely(err))
-				break;
-			err = push_nsh(skb, key, nh);
+		case OVS_ACTION_ATTR_PUSH_NSH:
+			err = execute_push_nsh(skb, key, nla_data(a));
 			break;
-		}
 
 		case OVS_ACTION_ATTR_POP_NSH:
 			err = pop_nsh(skb, key);
-- 
2.40.1


