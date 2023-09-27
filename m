Return-Path: <netdev+bounces-36385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BD37AF71B
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 02:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C7BD22824DD
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 00:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A27B629;
	Wed, 27 Sep 2023 00:13:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0526B10EB
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 00:13:31 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EB7558D
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 17:13:30 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c3cbfa40d6so89228405ad.1
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 17:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695773610; x=1696378410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TofRGtMhRPGgNgEwxNU34TFDCu+gzuDMLfb+dtqCXjQ=;
        b=Svh66JX2lC3Y79KsBJWXVL+2V6elZ8gb6zN3i8q6ncAeSY3d22JSdrUcC5rVPDPeIl
         jSR7x7S3WneDyM/dG0lAIr7ZChjWn8IUKpjAKxAr9wTbPhkB3zbpEUT277K46dZJKJPn
         z3XKXlv4A1wwFCy4a22XRDjgQWjvxn8u8aQ3Vx6cBSIevn+tQ2NTdzFC1p7ek/7Yi7Wq
         adY1/1nJ+VQv/iOrLoSkzBnQlsVXeZPnhwqN7lpcVeaJ70HekVpUoSILwLPJY+BdZpzM
         8nXedAjXUbErXYnQBHahV/NQ0AtiMx76eDSioFEEbBNS/YUrJa7i4WP+DIjJ4uS5DYCU
         tsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695773610; x=1696378410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TofRGtMhRPGgNgEwxNU34TFDCu+gzuDMLfb+dtqCXjQ=;
        b=pEPK8XJq8vmS83ec6hpL67sSK7+awSo+9d3v+CpNjey/3vHwEIFakZp8Er+zb1gkki
         TWJvVtrPKxt1gFQLotfnGrPK6++ukdw908sYdJfBiXqSKeB9lgCF7wJveY05BEV4cBJu
         4qL3FQhMUBvjafIDCbAF+/9u4EdjgdevkmvIHRxvMt/bNL5ZhykQXheCuxl0kYYN1LhI
         ytIZU2Y7Pa5EPV+uJ0+litMB8xnAdf1BtOZuufmJm+4UawUWdGYHokRrBP4mVKc7TVcC
         t/vHoJkyqPuXV8h9IIiptfKdxOrpcHli7Qx8goW38arbY5mZMelng50J1l/AIr3eSkaD
         wKTQ==
X-Gm-Message-State: AOJu0Yzf6pq/3kgyATy/ZMaaNDtHP+nwhZvHLIWfp3Cke4NAEoHMB6UM
	rcks+6MLK+nX/elemYCD1b0q3uKjCLE=
X-Google-Smtp-Source: AGHT+IFe+bxcLw9zxVvgyqKXSHnAy+bFRf2KFsXmH/SxtFIR/KsLXcxpyIpTdqZfJrcK7IUcTzhdvw==
X-Received: by 2002:a17:903:1cf:b0:1c4:375c:110a with SMTP id e15-20020a17090301cf00b001c4375c110amr475177plh.19.1695773610188;
        Tue, 26 Sep 2023 17:13:30 -0700 (PDT)
Received: from wheely.local0.net ([203.63.110.121])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902c3c100b001bc18e579aesm5623333plj.101.2023.09.26.17.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 17:13:29 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: netdev@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	dev@openvswitch.org,
	Pravin B Shelar <pshelar@ovn.org>
Subject: [RFC PATCH 4/7] net: openvswitch: ovs_vport_receive reduce stack usage
Date: Wed, 27 Sep 2023 10:13:05 +1000
Message-Id: <20230927001308.749910-5-npiggin@gmail.com>
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

Dynamically allocating the sw_flow_key reduces stack usage of
ovs_vport_receive from 544 bytes to 64 bytes at the cost of
another GFP_ATOMIC allocation in the receive path.

XXX: is this a problem with memory reserves if ovs is in a
memory reclaim path, or since we have a skb allocated, is it
okay to use some GFP_ATOMIC reserves?

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 net/openvswitch/vport.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
index 972ae01a70f7..ddba3e00832b 100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -494,9 +494,13 @@ u32 ovs_vport_find_upcall_portid(const struct vport *vport,
 int ovs_vport_receive(struct vport *vport, struct sk_buff *skb,
 		      const struct ip_tunnel_info *tun_info)
 {
-	struct sw_flow_key key;
+	struct sw_flow_key *key;
 	int error;
 
+	key = kmalloc(sizeof(*key), GFP_ATOMIC);
+	if (!key)
+		return -ENOMEM;
+
 	OVS_CB(skb)->input_vport = vport;
 	OVS_CB(skb)->mru = 0;
 	OVS_CB(skb)->cutlen = 0;
@@ -510,12 +514,16 @@ int ovs_vport_receive(struct vport *vport, struct sk_buff *skb,
 	}
 
 	/* Extract flow from 'skb' into 'key'. */
-	error = ovs_flow_key_extract(tun_info, skb, &key);
+	error = ovs_flow_key_extract(tun_info, skb, key);
 	if (unlikely(error)) {
 		kfree_skb(skb);
+		kfree(key);
 		return error;
 	}
-	ovs_dp_process_packet(skb, &key);
+	ovs_dp_process_packet(skb, key);
+
+	kfree(key);
+
 	return 0;
 }
 
-- 
2.40.1


