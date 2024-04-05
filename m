Return-Path: <netdev+bounces-85347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86C589A55D
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 22:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F2C1B215DE
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 20:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFAD173347;
	Fri,  5 Apr 2024 20:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDhjcy0X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E804E173336
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 20:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347508; cv=none; b=K+YGYpHm3ZRdtG62SfV8sibG4Sa2eNucMas7QZRFSWp2PXcD3U0laVlIs5a1ipbPJ8CXeaPCzPI4/fopq2ywHkvLm1TKwFCn77aLwLCmrGRGQqSqVfbvfRB67nL6xxcGf87IeTiHzj/ekrY8e84po0tjn6TGF7khih8pg27lK0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347508; c=relaxed/simple;
	bh=CTHv9XBWxH9/zGjZYqX0ViaAT74Pl3WYAECNn6NfIrI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FVWbxqkflAB1ALVpT5cR7c52IMgn35Lh/bL+5ACPHAsv3YeOCZ0BRBkzQx3RqS2zgRKdHZZsGM+uWDKPqSZ51zuESqHlbcDxVhiba3NmgOoe+ANWw/jGJpvkR4XtdRlDVU6a9sFBZxyzuD4s+CNhWOAwRes5JR813wBbw3m++68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JDhjcy0X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712347505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=0Z3x+3QCUpG2aUOXynaXR/lCuJiY7FGNxLxlmlL9v8U=;
	b=JDhjcy0XrKU8aakGWdfCuL7Hb6QgaFul/hW+x/Q20F0WfdhOEb0QQWMywMAuR0sTdHMWHd
	Nj0FYp8k5Qz2CRchV0zNXpX0UvUDIwugk8tunnlsXy0B2HC5BU/akqFVUGsAVDyiviCF+3
	ssBe3j2lUpOAvlmXtqOFh9x4xYuUJKk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-FnM6NbzwPEaIk9F4miQ2oA-1; Fri, 05 Apr 2024 16:05:04 -0400
X-MC-Unique: FnM6NbzwPEaIk9F4miQ2oA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4140bf38378so18421985e9.1
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 13:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712347503; x=1712952303;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Z3x+3QCUpG2aUOXynaXR/lCuJiY7FGNxLxlmlL9v8U=;
        b=nFNbZ30wX8FRIZ1GUjyDFU3Ovv8uonfBWZZrMiAs7I1paNEZ6boTQ5j5bJ8Zl9lYK/
         NYHRwSUOaY7Wf42ESZyQWBYjlg5wsUM5duUwMOcQ4YcvhBjPfetDDW1/KBgQ9n9Ku9il
         QX4aiXzXD7RpcCoijY+aNMfvm9ZhSmbgV0VuFesjaZLldOQbkTf7yIPvZXe6stqLAn4O
         MOXWrt/psByMRT4xsJ5qE4efabdxSG5Aqs9EULSD70x3Hjb3DudG7actJBqG6yyZc2yI
         BRuwQkGKCRwOaogmHzH9ro/EUEh/GhtQZMU3pTJYuzAXAU1ryjYWGTTitnx14kvbjOnz
         eNbg==
X-Gm-Message-State: AOJu0YxM3Swvo19iXMhq/V1lZoApqvDgy28NvAJisFxFNoWF8aIgo2MT
	T7A4CD0zjjg9txrXb6TklmjDEbZEWmzy63/8kRaoEn6RWFtLVwN3gBtoXaztjLkyY6GzINUm1DB
	KGSZ4z4rPnsShLPB+9sH5FDEEB4hDZQRRf4CRyN7bZWgGOGNl/eHhhQ==
X-Received: by 2002:a5d:640f:0:b0:343:6c5b:5886 with SMTP id z15-20020a5d640f000000b003436c5b5886mr2250385wru.46.1712347503105;
        Fri, 05 Apr 2024 13:05:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH40UmI3MG/hKMf1GK6ohzrUG8vdg++10wMsVry4iao6eRlya0ciwLgW28ciV3qOsNhCY6pCA==
X-Received: by 2002:a5d:640f:0:b0:343:6c5b:5886 with SMTP id z15-20020a5d640f000000b003436c5b5886mr2250369wru.46.1712347502701;
        Fri, 05 Apr 2024 13:05:02 -0700 (PDT)
Received: from debian (2a01cb058d23d60096e8548f6dee6238.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:96e8:548f:6dee:6238])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d4c4f000000b0034403ee44b1sm461664wrt.14.2024.04.05.13.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 13:05:02 -0700 (PDT)
Date: Fri, 5 Apr 2024 22:05:00 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Mustafa Ismail <mustafa.ismail@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Michal Kalderon <mkalderon@marvell.com>,
	Ariel Elior <aelior@marvell.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next] ipv4: Set scope explicitly in ip_route_output().
Message-ID: <1f3c874fb825cdc030f729d2e48e6f45f3e3527f.1712347466.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add a "scope" parameter to ip_route_output() so that callers don't have
to override the tos parameter with the RTO_ONLINK flag if they want a
local scope.

This will allow converting flowi4_tos to dscp_t in the future, thus
allowing static analysers to flag invalid interactions between
"tos" (the DSCP bits) and ECN.

Only three users ask for local scope (bonding, arp and atm). The others
continue to use RT_SCOPE_UNIVERSE. While there, add a comment to warn
users about the limitations of ip_route_output().

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 drivers/infiniband/hw/irdma/cm.c        | 3 ++-
 drivers/infiniband/hw/qedr/qedr_iw_cm.c | 3 ++-
 drivers/net/bonding/bond_main.c         | 4 ++--
 drivers/net/ethernet/broadcom/cnic.c    | 3 ++-
 include/net/route.h                     | 9 ++++++++-
 net/atm/clip.c                          | 2 +-
 net/bridge/br_netfilter_hooks.c         | 3 ++-
 net/ipv4/arp.c                          | 9 ++++++---
 net/ipv4/igmp.c                         | 3 ++-
 net/mpls/af_mpls.c                      | 2 +-
 10 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index 1ee7a4e0d8d8..36bb7e5ce638 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -1985,7 +1985,8 @@ static int irdma_addr_resolve_neigh(struct irdma_device *iwdev, u32 src_ip,
 	__be32 dst_ipaddr = htonl(dst_ip);
 	__be32 src_ipaddr = htonl(src_ip);
 
-	rt = ip_route_output(&init_net, dst_ipaddr, src_ipaddr, 0, 0);
+	rt = ip_route_output(&init_net, dst_ipaddr, src_ipaddr, 0, 0,
+			     RT_SCOPE_UNIVERSE);
 	if (IS_ERR(rt)) {
 		ibdev_dbg(&iwdev->ibdev, "CM: ip_route_output fail\n");
 		return -EINVAL;
diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
index a51fc6854984..259303b9907c 100644
--- a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
+++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
@@ -447,7 +447,8 @@ qedr_addr4_resolve(struct qedr_dev *dev,
 	struct rtable *rt = NULL;
 	int rc = 0;
 
-	rt = ip_route_output(&init_net, dst_ip, src_ip, 0, 0);
+	rt = ip_route_output(&init_net, dst_ip, src_ip, 0, 0,
+			     RT_SCOPE_UNIVERSE);
 	if (IS_ERR(rt)) {
 		DP_ERR(dev, "ip_route_output returned error\n");
 		return -EINVAL;
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 2c5ed0a7cb18..c9f0415f780a 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3014,8 +3014,8 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
 		tags = NULL;
 
 		/* Find out through which dev should the packet go */
-		rt = ip_route_output(dev_net(bond->dev), targets[i], 0,
-				     RTO_ONLINK, 0);
+		rt = ip_route_output(dev_net(bond->dev), targets[i], 0, 0, 0,
+				     RT_SCOPE_LINK);
 		if (IS_ERR(rt)) {
 			/* there's no route to target - try to send arp
 			 * probe to generate any traffic (arp_validate=0)
diff --git a/drivers/net/ethernet/broadcom/cnic.c b/drivers/net/ethernet/broadcom/cnic.c
index 3d63177e7e52..c2b4188a1ef1 100644
--- a/drivers/net/ethernet/broadcom/cnic.c
+++ b/drivers/net/ethernet/broadcom/cnic.c
@@ -3682,7 +3682,8 @@ static int cnic_get_v4_route(struct sockaddr_in *dst_addr,
 #if defined(CONFIG_INET)
 	struct rtable *rt;
 
-	rt = ip_route_output(&init_net, dst_addr->sin_addr.s_addr, 0, 0, 0);
+	rt = ip_route_output(&init_net, dst_addr->sin_addr.s_addr, 0, 0, 0,
+			     RT_SCOPE_UNIVERSE);
 	if (!IS_ERR(rt)) {
 		*dst = &rt->dst;
 		return 0;
diff --git a/include/net/route.h b/include/net/route.h
index d4a0147942f1..315a8acee6c6 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -141,15 +141,22 @@ static inline struct rtable *ip_route_output_key(struct net *net, struct flowi4
 	return ip_route_output_flow(net, flp, NULL);
 }
 
+/* Simplistic IPv4 route lookup function.
+ * This is only suitable for some particular use cases: since the flowi4
+ * structure is only partially set, it may bypass some fib-rules.
+ */
 static inline struct rtable *ip_route_output(struct net *net, __be32 daddr,
-					     __be32 saddr, u8 tos, int oif)
+					     __be32 saddr, u8 tos, int oif,
+					     __u8 scope)
 {
 	struct flowi4 fl4 = {
 		.flowi4_oif = oif,
 		.flowi4_tos = tos,
+		.flowi4_scope = scope,
 		.daddr = daddr,
 		.saddr = saddr,
 	};
+
 	return ip_route_output_key(net, &fl4);
 }
 
diff --git a/net/atm/clip.c b/net/atm/clip.c
index 294cb9efe3d3..362e8d25a79e 100644
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -463,7 +463,7 @@ static int clip_setentry(struct atm_vcc *vcc, __be32 ip)
 		unlink_clip_vcc(clip_vcc);
 		return 0;
 	}
-	rt = ip_route_output(&init_net, ip, 0, 1, 0);
+	rt = ip_route_output(&init_net, ip, 0, 0, 0, RT_SCOPE_LINK);
 	if (IS_ERR(rt))
 		return PTR_ERR(rt);
 	neigh = __neigh_lookup(&arp_tbl, &ip, rt->dst.dev, 1);
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 35e10c5a766d..4242447be322 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -399,7 +399,8 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 				goto free_skb;
 
 			rt = ip_route_output(net, iph->daddr, 0,
-					     RT_TOS(iph->tos), 0);
+					     RT_TOS(iph->tos), 0,
+					     RT_SCOPE_UNIVERSE);
 			if (!IS_ERR(rt)) {
 				/* - Bridged-and-DNAT'ed traffic doesn't
 				 *   require ip_forwarding. */
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 0d0d725b46ad..ab82ca104496 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -456,7 +456,8 @@ static int arp_filter(__be32 sip, __be32 tip, struct net_device *dev)
 	/*unsigned long now; */
 	struct net *net = dev_net(dev);
 
-	rt = ip_route_output(net, sip, tip, 0, l3mdev_master_ifindex_rcu(dev));
+	rt = ip_route_output(net, sip, tip, 0, l3mdev_master_ifindex_rcu(dev),
+			     RT_SCOPE_UNIVERSE);
 	if (IS_ERR(rt))
 		return 1;
 	if (rt->dst.dev != dev) {
@@ -1056,7 +1057,8 @@ static int arp_req_set(struct net *net, struct arpreq *r,
 	if (r->arp_flags & ATF_PERM)
 		r->arp_flags |= ATF_COM;
 	if (!dev) {
-		struct rtable *rt = ip_route_output(net, ip, 0, RTO_ONLINK, 0);
+		struct rtable *rt = ip_route_output(net, ip, 0, 0, 0,
+						    RT_SCOPE_LINK);
 
 		if (IS_ERR(rt))
 			return PTR_ERR(rt);
@@ -1188,7 +1190,8 @@ static int arp_req_delete(struct net *net, struct arpreq *r,
 
 	ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
 	if (!dev) {
-		struct rtable *rt = ip_route_output(net, ip, 0, RTO_ONLINK, 0);
+		struct rtable *rt = ip_route_output(net, ip, 0, 0, 0,
+						    RT_SCOPE_LINK);
 		if (IS_ERR(rt))
 			return PTR_ERR(rt);
 		dev = rt->dst.dev;
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 717e97a389a8..9bf09de6a2e7 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1842,7 +1842,8 @@ static struct in_device *ip_mc_find_dev(struct net *net, struct ip_mreqn *imr)
 	if (!dev) {
 		struct rtable *rt = ip_route_output(net,
 						    imr->imr_multiaddr.s_addr,
-						    0, 0, 0);
+						    0, 0, 0,
+						    RT_SCOPE_UNIVERSE);
 		if (!IS_ERR(rt)) {
 			dev = rt->dst.dev;
 			ip_rt_put(rt);
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 6dab883a08dd..1303acb9cdd2 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -594,7 +594,7 @@ static struct net_device *inet_fib_lookup_dev(struct net *net,
 	struct in_addr daddr;
 
 	memcpy(&daddr, addr, sizeof(struct in_addr));
-	rt = ip_route_output(net, daddr.s_addr, 0, 0, 0);
+	rt = ip_route_output(net, daddr.s_addr, 0, 0, 0, RT_SCOPE_UNIVERSE);
 	if (IS_ERR(rt))
 		return ERR_CAST(rt);
 
-- 
2.39.2


