Return-Path: <netdev+bounces-40006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C24C37C561B
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD6428230E
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 14:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFBA200D0;
	Wed, 11 Oct 2023 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628A2200C1
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 14:01:42 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C36E90;
	Wed, 11 Oct 2023 07:01:37 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vtx5zOd_1697032891;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0Vtx5zOd_1697032891)
          by smtp.aliyun-inc.com;
          Wed, 11 Oct 2023 22:01:32 +0800
Date: Wed, 11 Oct 2023 22:01:31 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Albert Huang <huangjie.albert@bytedance.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] net/smc: fix smc clc failed issue when netdevice
 not in init_net
Message-ID: <20231011140131.GL92403@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20231011074851.95280-1-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011074851.95280-1-huangjie.albert@bytedance.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 03:48:51PM +0800, Albert Huang wrote:
>If the netdevice is within a container and communicates externally
>through network technologies such as VxLAN, we won't be able to find
>routing information in the init_net namespace. To address this issue,
>we need to add a struct net parameter to the smc_ib_find_route function.
>This allow us to locate the routing information within the corresponding
>net namespace, ensuring the correct completion of the SMC CLC interaction.
>
>Fixes: e5c4744cfb59 ("net/smc: add SMC-Rv2 connection establishment")
>Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

>---
> net/smc/af_smc.c | 3 ++-
> net/smc/smc_ib.c | 7 ++++---
> net/smc/smc_ib.h | 2 +-
> 3 files changed, 7 insertions(+), 5 deletions(-)
>
>diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>index bacdd971615e..7a874da90c7f 100644
>--- a/net/smc/af_smc.c
>+++ b/net/smc/af_smc.c
>@@ -1201,6 +1201,7 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
> 		(struct smc_clc_msg_accept_confirm_v2 *)aclc;
> 	struct smc_clc_first_contact_ext *fce =
> 		smc_get_clc_first_contact_ext(clc_v2, false);
>+	struct net *net = sock_net(&smc->sk);
> 	int rc;
> 
> 	if (!ini->first_contact_peer || aclc->hdr.version == SMC_V1)
>@@ -1210,7 +1211,7 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
> 		memcpy(ini->smcrv2.nexthop_mac, &aclc->r0.lcl.mac, ETH_ALEN);
> 		ini->smcrv2.uses_gateway = false;
> 	} else {
>-		if (smc_ib_find_route(smc->clcsock->sk->sk_rcv_saddr,
>+		if (smc_ib_find_route(net, smc->clcsock->sk->sk_rcv_saddr,
> 				      smc_ib_gid_to_ipv4(aclc->r0.lcl.gid),
> 				      ini->smcrv2.nexthop_mac,
> 				      &ini->smcrv2.uses_gateway))
>diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
>index 9b66d6aeeb1a..89981dbe46c9 100644
>--- a/net/smc/smc_ib.c
>+++ b/net/smc/smc_ib.c
>@@ -193,7 +193,7 @@ bool smc_ib_port_active(struct smc_ib_device *smcibdev, u8 ibport)
> 	return smcibdev->pattr[ibport - 1].state == IB_PORT_ACTIVE;
> }
> 
>-int smc_ib_find_route(__be32 saddr, __be32 daddr,
>+int smc_ib_find_route(struct net *net, __be32 saddr, __be32 daddr,
> 		      u8 nexthop_mac[], u8 *uses_gateway)
> {
> 	struct neighbour *neigh = NULL;
>@@ -205,7 +205,7 @@ int smc_ib_find_route(__be32 saddr, __be32 daddr,
> 
> 	if (daddr == cpu_to_be32(INADDR_NONE))
> 		goto out;
>-	rt = ip_route_output_flow(&init_net, &fl4, NULL);
>+	rt = ip_route_output_flow(net, &fl4, NULL);
> 	if (IS_ERR(rt))
> 		goto out;
> 	if (rt->rt_uses_gateway && rt->rt_gw_family != AF_INET)
>@@ -235,6 +235,7 @@ static int smc_ib_determine_gid_rcu(const struct net_device *ndev,
> 	if (smcrv2 && attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP &&
> 	    smc_ib_gid_to_ipv4((u8 *)&attr->gid) != cpu_to_be32(INADDR_NONE)) {
> 		struct in_device *in_dev = __in_dev_get_rcu(ndev);
>+		struct net *net = dev_net(ndev);
> 		const struct in_ifaddr *ifa;
> 		bool subnet_match = false;
> 
>@@ -248,7 +249,7 @@ static int smc_ib_determine_gid_rcu(const struct net_device *ndev,
> 		}
> 		if (!subnet_match)
> 			goto out;
>-		if (smcrv2->daddr && smc_ib_find_route(smcrv2->saddr,
>+		if (smcrv2->daddr && smc_ib_find_route(net, smcrv2->saddr,
> 						       smcrv2->daddr,
> 						       smcrv2->nexthop_mac,
> 						       &smcrv2->uses_gateway))
>diff --git a/net/smc/smc_ib.h b/net/smc/smc_ib.h
>index 4df5f8c8a0a1..ef8ac2b7546d 100644
>--- a/net/smc/smc_ib.h
>+++ b/net/smc/smc_ib.h
>@@ -112,7 +112,7 @@ void smc_ib_sync_sg_for_device(struct smc_link *lnk,
> int smc_ib_determine_gid(struct smc_ib_device *smcibdev, u8 ibport,
> 			 unsigned short vlan_id, u8 gid[], u8 *sgid_index,
> 			 struct smc_init_info_smcrv2 *smcrv2);
>-int smc_ib_find_route(__be32 saddr, __be32 daddr,
>+int smc_ib_find_route(struct net *net, __be32 saddr, __be32 daddr,
> 		      u8 nexthop_mac[], u8 *uses_gateway);
> bool smc_ib_is_valid_local_systemid(void);
> int smcr_nl_get_device(struct sk_buff *skb, struct netlink_callback *cb);
>-- 
>2.20.1

