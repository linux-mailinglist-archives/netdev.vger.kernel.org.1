Return-Path: <netdev+bounces-36386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2247AF71C
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 02:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id AA24B2816FA
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 00:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC3A7E5;
	Wed, 27 Sep 2023 00:13:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A87610E1
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 00:13:37 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4FD59C3
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 17:13:36 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c61bde0b4bso46040165ad.3
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 17:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695773615; x=1696378415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXhL3o0sTOUKMqNKkJ+0Y25UfdzGjQwWOfR7lPB6ykE=;
        b=X+tOjVq2yqSYiqRQNHTSSc+w+5eMGIOgS3sU+tQXtR2rUPAxjkFiqxiRKxD5ruhEvT
         zWD+HQAnYRR1JJv15gChQ7cFyO4ZnCvTMoIR7wTOaHh7zL3nMCoPiX2qCDZECIG55vnV
         naa25cu4TWqiemGnSXkp6wOootJfHXwSphbsOJIWz193tbwe0EAtPAn7Wsh6VAgx/fIh
         CdmcFNg0kBMYQ6XJKJQOPHh6mVWVq+UKpmIF0tB1zFd/Yfqn744dISd1xvKFuAFaN7NP
         aGTesQ66BwE4jUxdVCuwqqwgR6DBjdj+tEBVkyZ8A3eqBG/tElUF2agDVrnXtl3yXPHV
         auQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695773615; x=1696378415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXhL3o0sTOUKMqNKkJ+0Y25UfdzGjQwWOfR7lPB6ykE=;
        b=SWH+DoH0yqLHvoc2Yk52v9NHIURFCyKRo2zqCSzVjtUPqctbpdOZSYR3vYqAUwYBwm
         Hpej3B/dI6IBgtCtBlF4rK6mtalPz/8ynOjXPpfQz16nHij/KstfTuevypSQuSTG2cIw
         gAm5FyYpxBjobepXxLn/12jLe3grGhpJE1nEY/Rmo55Imsf/61/1tN5r7uHZu5+gzmKf
         HTrDU+LclF1C2qpvUiObYbrTPjuBqDPkpd/QckhP25G/41q+Q5vqD8AWIxSewaR04XuB
         cKKawmFMUXWiIW+wmqiCjGUvwuVAJlvJ4wNLIG+1N2OQ8jKq0i2n+JX9xvpuulf/Z9l/
         0B0A==
X-Gm-Message-State: AOJu0YzsNfmpHKOSkGReIfq6qlnDOal0S4F/kwVPsw7qcEq5YGGtMG31
	Ind1iNr4Ly9g5M7tKBgaiZ/dSzXFyPU=
X-Google-Smtp-Source: AGHT+IGrbto64urSayF3SYkkaSV9eGasHRuQTs5RFbPzkux1/G/0+LDvyHErja0wYLLHdOkObCgSzw==
X-Received: by 2002:a17:902:ecc6:b0:1b8:b285:ec96 with SMTP id a6-20020a170902ecc600b001b8b285ec96mr380536plh.23.1695773615462;
        Tue, 26 Sep 2023 17:13:35 -0700 (PDT)
Received: from wheely.local0.net ([203.63.110.121])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902c3c100b001bc18e579aesm5623333plj.101.2023.09.26.17.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 17:13:35 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: netdev@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	dev@openvswitch.org,
	Pravin B Shelar <pshelar@ovn.org>
Subject: [RFC PATCH 6/7] net: openvswitch: Reduce ovs_fragment stack usage
Date: Wed, 27 Sep 2023 10:13:07 +1000
Message-Id: <20230927001308.749910-7-npiggin@gmail.com>
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

Allocate the dst route dynamically rather than on stack, reducing
ovs_fragment stack usage from 400 to 160 bytes, at a cost of a
GFP_ATOMIC allocation.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 net/openvswitch/actions.c | 33 ++++++++++++++++++++++++---------
 net/openvswitch/drop.h    |  1 +
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 12ad998b70e2..a6e10f59838f 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -868,38 +868,53 @@ void ovs_fragment(struct net *net, struct vport *vport, struct sk_buff *skb,
 	}
 
 	if (key->eth.type == htons(ETH_P_IP)) {
-		struct rtable ovs_rt = { 0 };
+		struct rtable *ovs_rt;
 		unsigned long orig_dst;
 
+		ovs_rt = kzalloc(sizeof(*ovs_rt), GFP_ATOMIC);
+		if (!ovs_rt) {
+			OVS_NLERR(1, "No memory to fragment");
+			reason = OVS_DROP_NOMEM;
+			goto err;
+		}
+
 		prepare_frag(vport, skb, orig_network_offset,
 			     ovs_key_mac_proto(key));
-		dst_init(&ovs_rt.dst, &ovs_dst_ops, NULL, 1,
+		dst_init(&ovs_rt->dst, &ovs_dst_ops, NULL, 1,
 			 DST_OBSOLETE_NONE, DST_NOCOUNT);
-		ovs_rt.dst.dev = vport->dev;
+		ovs_rt->dst.dev = vport->dev;
 
 		orig_dst = skb->_skb_refdst;
-		skb_dst_set_noref(skb, &ovs_rt.dst);
+		skb_dst_set_noref(skb, &ovs_rt->dst);
 		IPCB(skb)->frag_max_size = mru;
 
 		ip_do_fragment(net, skb->sk, skb, ovs_vport_output);
 		refdst_drop(orig_dst);
+		kfree(ovs_rt);
 	} else if (key->eth.type == htons(ETH_P_IPV6)) {
 		unsigned long orig_dst;
-		struct rt6_info ovs_rt;
+		struct rt6_info *ovs_rt;
+
+		ovs_rt = kzalloc(sizeof(*ovs_rt), GFP_ATOMIC);
+		if (!ovs_rt) {
+			OVS_NLERR(1, "No memory to fragment");
+			reason = OVS_DROP_NOMEM;
+			goto err;
+		}
 
 		prepare_frag(vport, skb, orig_network_offset,
 			     ovs_key_mac_proto(key));
-		memset(&ovs_rt, 0, sizeof(ovs_rt));
-		dst_init(&ovs_rt.dst, &ovs_dst_ops, NULL, 1,
+		dst_init(&ovs_rt->dst, &ovs_dst_ops, NULL, 1,
 			 DST_OBSOLETE_NONE, DST_NOCOUNT);
-		ovs_rt.dst.dev = vport->dev;
+		ovs_rt->dst.dev = vport->dev;
 
 		orig_dst = skb->_skb_refdst;
-		skb_dst_set_noref(skb, &ovs_rt.dst);
+		skb_dst_set_noref(skb, &ovs_rt->dst);
 		IP6CB(skb)->frag_max_size = mru;
 
 		ipv6_stub->ipv6_fragment(net, skb->sk, skb, ovs_vport_output);
 		refdst_drop(orig_dst);
+		kfree(ovs_rt);
 	} else {
 		WARN_ONCE(1, "Failed fragment ->%s: eth=%04x, MRU=%d, MTU=%d.",
 			  ovs_vport_name(vport), ntohs(key->eth.type), mru,
diff --git a/net/openvswitch/drop.h b/net/openvswitch/drop.h
index cedf9b7b5796..0bf156867a69 100644
--- a/net/openvswitch/drop.h
+++ b/net/openvswitch/drop.h
@@ -20,6 +20,7 @@
 	R(OVS_DROP_FRAG_INVALID_PROTO)		\
 	R(OVS_DROP_CONNTRACK)			\
 	R(OVS_DROP_IP_TTL)			\
+	R(OVS_DROP_NOMEM)			\
 	/* deliberate comment for trailing \ */
 
 enum ovs_drop_reason {
-- 
2.40.1


