Return-Path: <netdev+bounces-36388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6A17AF71E
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 02:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 781D01C20839
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 00:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAC810E5;
	Wed, 27 Sep 2023 00:13:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0030C110A
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 00:13:39 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20865FC1
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 17:13:38 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c451541f23so77831445ad.2
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 17:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695773618; x=1696378418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ6L0X0czBnGtOrBDWDBQdqRNYqy/TkiSVt0wMO8NXw=;
        b=ET4oGermqhIo4C1ls9lvWovEmSdxyF6sYjS5xVvZXUFG1UsfHPw4N9bj2krWWVPrT5
         ZcHtYqcQibw/uhVOUY5wB7ClmtloQDZvpJx+gl5wl7wB/DWx49DsruOsKWLE742Z4dih
         qv8C8X2gPFdjP9JHDQxubA0Wd3PCimtp8qhEWeO6bMKDmOr9W355XObw/EkIvA4u40V8
         OROy6USTim+rvqb5F1LomztdegkgHtn0mJjRZjK60TyevZu16u5vOlA3EBmGyIhN7iyB
         kav0tF4fdYg2tT9crf8K20ZnL2nV+yK22PKexGTiabmCgVI01RrX979yslIAxLCJNGnt
         iWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695773618; x=1696378418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZ6L0X0czBnGtOrBDWDBQdqRNYqy/TkiSVt0wMO8NXw=;
        b=B5jBNjuHfrerB8PhDC6QUhBujLyWnBrAr3TdfwNihbbF3GsMT1qadHEZnzOyvuaFeL
         sy5QWAfSTH0e9Ej/pMp8p9nuA7kDTKN1ekyE0gc8sv7IDCidm9QF8OvnAk9qWIStWtz9
         8vo595R3oK9/TqXAWskCR7tsZ0N6LDNKIAQq0kSLt2wD8MrV4Nl6c87BT5GayQ1/dqz+
         58vp2SxGumVKeYjmncbqNQirq1wHH7HrCnHMMScXyvDn6s3+1kcrE/QjjvfCvbEaceR9
         zGrACOE79Dfj5eReU6gM3+LPuc2QCDp1AFLwrLvRzefnPZ07q6WX986Mo54wEn4tPfXd
         hPKg==
X-Gm-Message-State: AOJu0YxwZ32xP255hne47jWCvopanCA9jKLU5rGthNLX1Pkbe9HlgIoR
	enh9JWilc0Cn/aQjBxpLSaYBUuyFob0=
X-Google-Smtp-Source: AGHT+IECpPlomNoCjzfWu/layqAjaj6hGyUlXsjsnZdFGo5uJDGiH7wDs7DKGEghAaSoK9cssUy8rg==
X-Received: by 2002:a17:902:9f87:b0:1c1:eb8b:79a6 with SMTP id g7-20020a1709029f8700b001c1eb8b79a6mr276379plq.24.1695773618165;
        Tue, 26 Sep 2023 17:13:38 -0700 (PDT)
Received: from wheely.local0.net ([203.63.110.121])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902c3c100b001bc18e579aesm5623333plj.101.2023.09.26.17.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 17:13:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: netdev@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	dev@openvswitch.org,
	Pravin B Shelar <pshelar@ovn.org>
Subject: [RFC PATCH 7/7] net: openvswitch: Reduce stack usage in ovs_dp_process_packet
Date: Wed, 27 Sep 2023 10:13:08 +1000
Message-Id: <20230927001308.749910-8-npiggin@gmail.com>
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

The upcall in ovs_dp_process_packet uses a lot of stack and is not
involved in the recursive call. Move it into an out of line function,
reducing stack overhead from 144 to 96 bytes.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 net/openvswitch/datapath.c | 55 +++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 11c69415c605..bdbbdd556c4a 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -242,6 +242,37 @@ void ovs_dp_detach_port(struct vport *p)
 	ovs_vport_del(p);
 }
 
+static noinline_for_stack
+void do_packet_upcall(struct sk_buff *skb, struct sw_flow_key *key,
+		      const struct vport *p, struct datapath *dp)
+{
+	struct dp_upcall_info upcall;
+	int error;
+
+	memset(&upcall, 0, sizeof(upcall));
+	upcall.cmd = OVS_PACKET_CMD_MISS;
+
+	if (dp->user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU)
+		upcall.portid =
+		    ovs_dp_get_upcall_portid(dp, smp_processor_id());
+	else
+		upcall.portid = ovs_vport_find_upcall_portid(p, skb);
+
+	upcall.mru = OVS_CB(skb)->mru;
+	error = ovs_dp_upcall(dp, skb, key, &upcall, 0);
+	switch (error) {
+	case 0:
+	case -EAGAIN:
+	case -ERESTARTSYS:
+	case -EINTR:
+		consume_skb(skb);
+		break;
+	default:
+		kfree_skb(skb);
+		break;
+	}
+}
+
 /* Must be called with rcu_read_lock. */
 void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
 {
@@ -261,30 +292,6 @@ void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
 	flow = ovs_flow_tbl_lookup_stats(&dp->table, key, skb_get_hash(skb),
 					 &n_mask_hit, &n_cache_hit);
 	if (unlikely(!flow)) {
-		struct dp_upcall_info upcall;
-
-		memset(&upcall, 0, sizeof(upcall));
-		upcall.cmd = OVS_PACKET_CMD_MISS;
-
-		if (dp->user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU)
-			upcall.portid =
-			    ovs_dp_get_upcall_portid(dp, smp_processor_id());
-		else
-			upcall.portid = ovs_vport_find_upcall_portid(p, skb);
-
-		upcall.mru = OVS_CB(skb)->mru;
-		error = ovs_dp_upcall(dp, skb, key, &upcall, 0);
-		switch (error) {
-		case 0:
-		case -EAGAIN:
-		case -ERESTARTSYS:
-		case -EINTR:
-			consume_skb(skb);
-			break;
-		default:
-			kfree_skb(skb);
-			break;
-		}
 		stats_counter = &stats->n_missed;
 		goto out;
 	}
-- 
2.40.1


