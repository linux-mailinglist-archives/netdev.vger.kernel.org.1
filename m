Return-Path: <netdev+bounces-35734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43A27AAD4C
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 10:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 626FF28181E
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 08:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5B6168DB;
	Fri, 22 Sep 2023 08:59:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BF19CA43
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 08:59:17 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156FD99
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 01:59:16 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c5dd017b30so11528925ad.0
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 01:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695373155; x=1695977955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dzmBYOC+iwFysYemk8kdLeE2Dt2aHmz4Un9SzH6Y5Wg=;
        b=lyjSFPQxZerMNiYrZXuVliZlWmFh5LIAThvgjhB3iNeC2Mt94o5pZiJQOqlMqRn1bs
         ySPwySrva3vkCafEMyxVcC9fFZlQdIgG20ESS5iy3XTsM6TPRgT8lbC3CDv8aH7zeBft
         iClF+8PEJbi3B69yQ9yWNzvzXlT6D+URoPD/MrmMm1KvavKZaiaSsy3Op9TTAzjBqaXo
         dePXMsATFG25vtsCXTUxgR35tlqa7jHhkxc+9ggrabEdfNvP1U82OaoMh28hB/GZMMth
         Fv077mS2yvRl6I/d3/nbZF1HdQ1lH+ks67H4HOXlN1CNLZjnefldRModOTbDxXPZczKV
         QkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695373155; x=1695977955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzmBYOC+iwFysYemk8kdLeE2Dt2aHmz4Un9SzH6Y5Wg=;
        b=KgDGP4va1MN6gZfR5mKFIw+Cb72P0U70TZdpOhLF6kgFwXC1d2bTSr/hDnaHuVLsDi
         psxDApvaDB2hl3s8xS1MkuY2HYOcv6kCR29BI2Gm2Ofs+nuvsr4viVshJEqq6MfDnQcG
         ni5NEydmIJbWBjKloQFFeMRTKPelhx1oNaxe6x7bMBqsG5KbCdY2Zypla73aqyR5lm+2
         VKcTLBWreHTodiwCAS9rwA0HkLI9hG/+17MofHwclyFjgkeea8g213I3dQa9OuPfSpPI
         P21LC3Swtnq/BEZ9nv2AxEI5EEN5ckTzc0Kl/HkIC8MehTeUoK3P9rL56Ma834vjRcTt
         UUkQ==
X-Gm-Message-State: AOJu0YyhdLahLEtbkVdnChsM9i3tN9cB008ZzIxwaMSrofoBgbjjTrSe
	212MW1MnNFAkOys3mJMIM4AuVA==
X-Google-Smtp-Source: AGHT+IFHn6zFsbxC6Px/kYrE/VewG99QOyuNc/L9KNbSJ1RnItq0VSO1sfkNnq46uUNUq9YCJ713gA==
X-Received: by 2002:a17:902:e84e:b0:1bf:193a:70b6 with SMTP id t14-20020a170902e84e00b001bf193a70b6mr3278217plg.5.1695373155445;
        Fri, 22 Sep 2023 01:59:15 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([240e:6b1:c0:120::2:d])
        by smtp.gmail.com with ESMTPSA id l19-20020a170902d35300b001bf5e24b2a8sm2927604plk.174.2023.09.22.01.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 01:59:14 -0700 (PDT)
From: Albert Huang <huangjie.albert@bytedance.com>
To: Karsten Graul <kgraul@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>
Cc: Albert Huang <huangjie.albert@bytedance.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/smc: add support for netdevice in containers.
Date: Fri, 22 Sep 2023 16:58:57 +0800
Message-Id: <20230922085858.94747-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If the netdevice is within a container and communicates externally
through network technologies like VXLAN, we won't be able to find
routing information in the init_net namespace. To address this issue,
we need to add a struct net parameter to the smc_ib_find_route function.
This allow us to locate the routing information within the corresponding
net namespace, ensuring the correct completion of the SMC CLC interaction.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 net/smc/af_smc.c | 3 ++-
 net/smc/smc_ib.c | 7 ++++---
 net/smc/smc_ib.h | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index bacdd971615e..7a874da90c7f 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1201,6 +1201,7 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
 		(struct smc_clc_msg_accept_confirm_v2 *)aclc;
 	struct smc_clc_first_contact_ext *fce =
 		smc_get_clc_first_contact_ext(clc_v2, false);
+	struct net *net = sock_net(&smc->sk);
 	int rc;
 
 	if (!ini->first_contact_peer || aclc->hdr.version == SMC_V1)
@@ -1210,7 +1211,7 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
 		memcpy(ini->smcrv2.nexthop_mac, &aclc->r0.lcl.mac, ETH_ALEN);
 		ini->smcrv2.uses_gateway = false;
 	} else {
-		if (smc_ib_find_route(smc->clcsock->sk->sk_rcv_saddr,
+		if (smc_ib_find_route(net, smc->clcsock->sk->sk_rcv_saddr,
 				      smc_ib_gid_to_ipv4(aclc->r0.lcl.gid),
 				      ini->smcrv2.nexthop_mac,
 				      &ini->smcrv2.uses_gateway))
diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 9b66d6aeeb1a..89981dbe46c9 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -193,7 +193,7 @@ bool smc_ib_port_active(struct smc_ib_device *smcibdev, u8 ibport)
 	return smcibdev->pattr[ibport - 1].state == IB_PORT_ACTIVE;
 }
 
-int smc_ib_find_route(__be32 saddr, __be32 daddr,
+int smc_ib_find_route(struct net *net, __be32 saddr, __be32 daddr,
 		      u8 nexthop_mac[], u8 *uses_gateway)
 {
 	struct neighbour *neigh = NULL;
@@ -205,7 +205,7 @@ int smc_ib_find_route(__be32 saddr, __be32 daddr,
 
 	if (daddr == cpu_to_be32(INADDR_NONE))
 		goto out;
-	rt = ip_route_output_flow(&init_net, &fl4, NULL);
+	rt = ip_route_output_flow(net, &fl4, NULL);
 	if (IS_ERR(rt))
 		goto out;
 	if (rt->rt_uses_gateway && rt->rt_gw_family != AF_INET)
@@ -235,6 +235,7 @@ static int smc_ib_determine_gid_rcu(const struct net_device *ndev,
 	if (smcrv2 && attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP &&
 	    smc_ib_gid_to_ipv4((u8 *)&attr->gid) != cpu_to_be32(INADDR_NONE)) {
 		struct in_device *in_dev = __in_dev_get_rcu(ndev);
+		struct net *net = dev_net(ndev);
 		const struct in_ifaddr *ifa;
 		bool subnet_match = false;
 
@@ -248,7 +249,7 @@ static int smc_ib_determine_gid_rcu(const struct net_device *ndev,
 		}
 		if (!subnet_match)
 			goto out;
-		if (smcrv2->daddr && smc_ib_find_route(smcrv2->saddr,
+		if (smcrv2->daddr && smc_ib_find_route(net, smcrv2->saddr,
 						       smcrv2->daddr,
 						       smcrv2->nexthop_mac,
 						       &smcrv2->uses_gateway))
diff --git a/net/smc/smc_ib.h b/net/smc/smc_ib.h
index 4df5f8c8a0a1..ef8ac2b7546d 100644
--- a/net/smc/smc_ib.h
+++ b/net/smc/smc_ib.h
@@ -112,7 +112,7 @@ void smc_ib_sync_sg_for_device(struct smc_link *lnk,
 int smc_ib_determine_gid(struct smc_ib_device *smcibdev, u8 ibport,
 			 unsigned short vlan_id, u8 gid[], u8 *sgid_index,
 			 struct smc_init_info_smcrv2 *smcrv2);
-int smc_ib_find_route(__be32 saddr, __be32 daddr,
+int smc_ib_find_route(struct net *net, __be32 saddr, __be32 daddr,
 		      u8 nexthop_mac[], u8 *uses_gateway);
 bool smc_ib_is_valid_local_systemid(void);
 int smcr_nl_get_device(struct sk_buff *skb, struct netlink_callback *cb);
-- 
2.37.1 (Apple Git-137.1)


