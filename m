Return-Path: <netdev+bounces-216490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0148EB340E7
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 15:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4C437B0B7E
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 13:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE542673A5;
	Mon, 25 Aug 2025 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJJ4madx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EC121257E
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129080; cv=none; b=qaZbfQeonXt2ZMaRtpK63k8NEuuNjgejk86/h3o3s2cjTA2WqUhv1/Q+lo99ElLvgapWw4P7xjApthbYFWD3gjkiF2h1c7Sf7J/e4VuV3XDS1Zg/F4at5gv/JoTekGNF/LMtPyZd691aGcVUFkJrLnnnimcMCXfsDt9uwwRRPpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129080; c=relaxed/simple;
	bh=Vyy+d2487HcwY8EKEOXTal4i3r0G2MtyySTLbdRvLFI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lktb0G7/Sj0CeURZOOp9yNWoonvT4YVXLb4z3eTKJso7CLNOc0NwgQQMbGxs04d7hJzwhCorR6uSxYbwvFSkmUVXGS9eiZypZi2CUUU/FLRDXTm1oIrJx9sDFHYnNpTBrbjkzjuPzUPv2KMLw6ZzQsZ4EX/NAxIXsEsbROXnEGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NJJ4madx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756129076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=wtTnGGH114IBvoOyckWMbqskHEdwnDANLpfHqS0UmOI=;
	b=NJJ4madx1HGLS1qh6kkl375VKDTEU1lmd2lK5sMSlnO2mva9nWbqVyqIe8je6Gjlg3Cjif
	ZqkYej0NKf6zU2gprkqjWYiIZtP4neRk3j0DnUOnSl2ggNJsbCtdGgXDg6C9XPJGfbMi9Q
	+64d35LniUeFld9PwepvpBSlGAT3gx4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-aHuGH84xMm6BbGmS8RyVSA-1; Mon, 25 Aug 2025 09:37:53 -0400
X-MC-Unique: aHuGH84xMm6BbGmS8RyVSA-1
X-Mimecast-MFC-AGG-ID: aHuGH84xMm6BbGmS8RyVSA_1756129073
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70da9c0b048so18961276d6.1
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 06:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756129073; x=1756733873;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtTnGGH114IBvoOyckWMbqskHEdwnDANLpfHqS0UmOI=;
        b=xQMLgMjsENKhfHhJ6+NGiPVEtvubpv1GBC+Uuc0I9T8P1XQdnCu/bz6+nUsgPbeeyK
         ZQl+jDymClH4XDtFI0slv3cda/zuM1c18BMZXjDPjOPtadwYMfJbjhze3GhEKmalfaDi
         iPttkTM0uEWWYRpv+gjA+imx09VJfUL9BVgrnqdxTmaQT//8WebmDWI6RbUJiG1ZBIXB
         plkoWZgmgodkCtzg1EwJNV2ZDFutUZ1JrmRvL85v1a0i3Om2dfFnCpDFJKOMwcnVt+Vg
         49FQ/1S34KxBKPoy954L1OdD9oyZA333IrYdAuxmtpMqIkYluVd80aa9Djpq1gWl58NI
         7BtQ==
X-Gm-Message-State: AOJu0Yzb8CPklZSsqjftnU6NmekE3yNbczNK9mx4LUb9SYT0jbz9Q2rA
	XIyKBYvMhKPNZ7L4FuNDSVnNbrYQjzv/K/PRyMPr0CohzqoXRje0zDoe6M0Iq7Hc8u7xBog0Bd+
	yRQiFT8H5Br3h42UXwIhvxDoZN3bPMcE0QdDlu/E5dODxi/HCIaKoPGT47g==
X-Gm-Gg: ASbGncvM7yIu0WNYmTlhxV+IfqAoAb9BsoXi4zw2DE1xBIDXX4DdY5Mk5YXrSK9bAaW
	czhWn1+T5KR5sbr92KhpKRiiPFWp8l5rH3lmRRAg+Hf0dF9ECvfxb2iqhbqn2JUORE7GWUD0ycl
	5wTWI5dL/D1pl027h4lq5gxmha/l45fQ8lpssyETq2JTbUexv8axEegJzct7MicJ0YmXBvDEdIG
	ZpDaLb+dlTJYJFwroo303o86Mmj5w4t0ormU666c9j0Cdpxc7sRjLNIkIrsrsUEACLx7VD3cpEs
	3nGMnUezEV4usUyo15Ar9FtnOZ8CJ/3vNGaMFHP7EyFJwv1SQn125AXO8h8xB99Ium5l9BCirt7
	uw9tsdHNNdoeyQY37Dw==
X-Received: by 2002:a05:6214:c2d:b0:709:e54b:262a with SMTP id 6a1803df08f44-70d9738f3c0mr111349446d6.44.1756129072384;
        Mon, 25 Aug 2025 06:37:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFif9QncrAhsXFEiIO6g8fO0zZC/6pGBMhQNmitr+00a1LfyW6n/cbW5OqT7zAv6wy+LXj1vA==
X-Received: by 2002:a05:6214:c2d:b0:709:e54b:262a with SMTP id 6a1803df08f44-70d9738f3c0mr111348856d6.44.1756129071472;
        Mon, 25 Aug 2025 06:37:51 -0700 (PDT)
Received: from debian (2a01cb058918ce0048dd797e0334a429.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:48dd:797e:334:a429])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da717edf6sm46028526d6.32.2025.08.25.06.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 06:37:50 -0700 (PDT)
Date: Mon, 25 Aug 2025 15:37:43 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	David Ahern <dsahern@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH v2 net-next] ipv4: Convert ->flowi4_tos to dscp_t.
Message-ID: <29acecb45e911d17446b9a3dbdb1ab7b821ea371.1756128932.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert the ->flowic_tos field of struct flowi_common from __u8 to
dscp_t, rename it ->flowic_dscp and propagate these changes to struct
flowi and struct flowi4.

We've had several bugs in the past where ECN bits could interfere with
IPv4 routing, because these bits were not properly cleared when setting
->flowi4_tos. These bugs should be fixed now and the dscp_t type has
been introduced to ensure that variables carrying DSCP values don't
accidentally have any ECN bits set. Several variables and structure
fields have been converted to dscp_t already, but the main IPv4 routing
structure, struct flowi4, is still using a __u8. To avoid any future
regression, this patch converts it to dscp_t.

There are many users to convert at once. Fortunately, around half of
->flowi4_tos users already have a dscp_t value at hand, which they
currently convert to __u8 using inet_dscp_to_dsfield(). For all of
these users, we just need to drop that conversion.

But, although we try to do the __u8 <-> dscp_t conversions at the
boundaries of the network or of user space, some places still store
TOS/DSCP variables as __u8 in core networking code. Those can hardly be
converted either because the data structure is part of UAPI or because
the same variable or field is also used for handling ECN in other parts
of the code. In all of these cases where we don't have a dscp_t
variable at hand, we need to use inet_dsfield_to_dscp() when
interacting with ->flowi4_dscp.

Changes since v1:
  * Fix space alignment in __bpf_redirect_neigh_v4() (Ido).

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 drivers/net/amt.c                                   |  6 ++++--
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c |  7 ++++---
 drivers/net/ethernet/sfc/tc_encap_actions.c         |  4 +++-
 drivers/net/gtp.c                                   |  7 ++++---
 drivers/net/ipvlan/ipvlan_core.c                    |  4 ++--
 drivers/net/vrf.c                                   |  4 ++--
 include/net/flow.h                                  | 11 ++++++-----
 include/net/inet_dscp.h                             |  6 ++++++
 include/net/ip_fib.h                                |  2 +-
 include/net/ip_tunnels.h                            |  4 +++-
 include/net/route.h                                 |  2 +-
 include/trace/events/fib.h                          |  4 +++-
 net/core/filter.c                                   |  4 ++--
 net/core/lwt_bpf.c                                  |  4 ++--
 net/ipv4/fib_frontend.c                             |  7 ++++---
 net/ipv4/fib_rules.c                                |  4 ++--
 net/ipv4/icmp.c                                     |  5 +++--
 net/ipv4/ip_gre.c                                   |  4 ++--
 net/ipv4/ip_output.c                                |  3 ++-
 net/ipv4/ipmr.c                                     |  3 ++-
 net/ipv4/netfilter.c                                |  4 ++--
 net/ipv4/netfilter/ipt_rpfilter.c                   |  4 ++--
 net/ipv4/netfilter/nf_dup_ipv4.c                    |  4 ++--
 net/ipv4/netfilter/nft_fib_ipv4.c                   |  4 ++--
 net/ipv4/route.c                                    |  8 ++++----
 net/ipv4/udp_tunnel_core.c                          |  3 ++-
 net/ipv4/xfrm4_policy.c                             |  4 ++--
 net/netfilter/nft_flow_offload.c                    |  4 ++--
 net/sctp/protocol.c                                 |  3 ++-
 net/xfrm/xfrm_policy.c                              |  6 +++---
 30 files changed, 81 insertions(+), 58 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index ed86537b2f61..902c817a0dea 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -11,6 +11,7 @@
 #include <linux/net.h>
 #include <linux/igmp.h>
 #include <linux/workqueue.h>
+#include <net/flow.h>
 #include <net/pkt_sched.h>
 #include <net/net_namespace.h>
 #include <net/ip.h>
@@ -28,6 +29,7 @@
 #include <net/addrconf.h>
 #include <net/ip6_route.h>
 #include <net/inet_common.h>
+#include <net/inet_dscp.h>
 #include <net/ip6_checksum.h>
 
 static struct workqueue_struct *amt_wq;
@@ -1018,7 +1020,7 @@ static bool amt_send_membership_update(struct amt_dev *amt,
 	fl4.flowi4_oif         = amt->stream_dev->ifindex;
 	fl4.daddr              = amt->remote_ip;
 	fl4.saddr              = amt->local_ip;
-	fl4.flowi4_tos         = AMT_TOS;
+	fl4.flowi4_dscp        = inet_dsfield_to_dscp(AMT_TOS);
 	fl4.flowi4_proto       = IPPROTO_UDP;
 	rt = ip_route_output_key(amt->net, &fl4);
 	if (IS_ERR(rt)) {
@@ -1133,7 +1135,7 @@ static bool amt_send_membership_query(struct amt_dev *amt,
 	fl4.flowi4_oif         = amt->stream_dev->ifindex;
 	fl4.daddr              = tunnel->ip4;
 	fl4.saddr              = amt->local_ip;
-	fl4.flowi4_tos         = AMT_TOS;
+	fl4.flowi4_dscp        = inet_dsfield_to_dscp(AMT_TOS);
 	fl4.flowi4_proto       = IPPROTO_UDP;
 	rt = ip_route_output_key(amt->net, &fl4);
 	if (IS_ERR(rt)) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
index 2162d776fe35..a14f216048cd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
@@ -1,7 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2018 Mellanox Technologies. */
 
-#include <net/inet_ecn.h>
+#include <net/flow.h>
+#include <net/inet_dscp.h>
 #include <net/vxlan.h>
 #include <net/gre.h>
 #include <net/geneve.h>
@@ -233,7 +234,7 @@ int mlx5e_tc_tun_create_header_ipv4(struct mlx5e_priv *priv,
 	int err;
 
 	/* add the IP fields */
-	attr.fl.fl4.flowi4_tos = tun_key->tos & ~INET_ECN_MASK;
+	attr.fl.fl4.flowi4_dscp = inet_dsfield_to_dscp(tun_key->tos);
 	attr.fl.fl4.daddr = tun_key->u.ipv4.dst;
 	attr.fl.fl4.saddr = tun_key->u.ipv4.src;
 	attr.ttl = tun_key->ttl;
@@ -349,7 +350,7 @@ int mlx5e_tc_tun_update_header_ipv4(struct mlx5e_priv *priv,
 	int err;
 
 	/* add the IP fields */
-	attr.fl.fl4.flowi4_tos = tun_key->tos & ~INET_ECN_MASK;
+	attr.fl.fl4.flowi4_dscp = inet_dsfield_to_dscp(tun_key->tos);
 	attr.fl.fl4.daddr = tun_key->u.ipv4.dst;
 	attr.fl.fl4.saddr = tun_key->u.ipv4.src;
 	attr.ttl = tun_key->ttl;
diff --git a/drivers/net/ethernet/sfc/tc_encap_actions.c b/drivers/net/ethernet/sfc/tc_encap_actions.c
index e872f926e438..eef06e48185d 100644
--- a/drivers/net/ethernet/sfc/tc_encap_actions.c
+++ b/drivers/net/ethernet/sfc/tc_encap_actions.c
@@ -11,6 +11,8 @@
 #include "tc_encap_actions.h"
 #include "tc.h"
 #include "mae.h"
+#include <net/flow.h>
+#include <net/inet_dscp.h>
 #include <net/vxlan.h>
 #include <net/geneve.h>
 #include <net/netevent.h>
@@ -99,7 +101,7 @@ static int efx_bind_neigh(struct efx_nic *efx,
 	case EFX_ENCAP_TYPE_GENEVE:
 		flow4.flowi4_proto = IPPROTO_UDP;
 		flow4.fl4_dport = encap->key.tp_dst;
-		flow4.flowi4_tos = encap->key.tos;
+		flow4.flowi4_dscp = inet_dsfield_to_dscp(encap->key.tos);
 		flow4.daddr = encap->key.u.ipv4.dst;
 		flow4.saddr = encap->key.u.ipv4.src;
 		break;
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 4b668ebaa0f7..5cb59d72bc82 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -21,9 +21,10 @@
 #include <linux/file.h>
 #include <linux/gtp.h>
 
+#include <net/flow.h>
+#include <net/inet_dscp.h>
 #include <net/net_namespace.h>
 #include <net/protocol.h>
-#include <net/inet_dscp.h>
 #include <net/inet_sock.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
@@ -352,7 +353,7 @@ static struct rtable *ip4_route_output_gtp(struct flowi4 *fl4,
 	fl4->flowi4_oif		= sk->sk_bound_dev_if;
 	fl4->daddr		= daddr;
 	fl4->saddr		= saddr;
-	fl4->flowi4_tos		= inet_dscp_to_dsfield(inet_sk_dscp(inet_sk(sk)));
+	fl4->flowi4_dscp	= inet_sk_dscp(inet_sk(sk));
 	fl4->flowi4_scope	= ip_sock_rt_scope(sk);
 	fl4->flowi4_proto	= sk->sk_protocol;
 
@@ -2401,7 +2402,7 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 
 	udp_tunnel_xmit_skb(rt, sk, skb_to_send,
 			    fl4.saddr, fl4.daddr,
-			    fl4.flowi4_tos,
+			    inet_dscp_to_dsfield(fl4.flowi4_dscp),
 			    ip4_dst_hoplimit(&rt->dst),
 			    0,
 			    port, port,
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index e3e65772c599..d7e3ddbcab6f 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -2,7 +2,7 @@
 /* Copyright (c) 2014 Mahesh Bandewar <maheshb@google.com>
  */
 
-#include <net/inet_dscp.h>
+#include <net/flow.h>
 #include <net/ip.h>
 
 #include "ipvlan.h"
@@ -433,7 +433,7 @@ static noinline_for_stack int ipvlan_process_v4_outbound(struct sk_buff *skb)
 	ip4h = ip_hdr(skb);
 	fl4.daddr = ip4h->daddr;
 	fl4.saddr = ip4h->saddr;
-	fl4.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(ip4h));
+	fl4.flowi4_dscp = ip4h_dscp(ip4h);
 
 	rt = ip_route_output_flow(net, &fl4, NULL);
 	if (IS_ERR(rt))
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 3ccd649913b5..571847a7f86d 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -26,6 +26,7 @@
 
 #include <linux/inetdevice.h>
 #include <net/arp.h>
+#include <net/flow.h>
 #include <net/ip.h>
 #include <net/ip_fib.h>
 #include <net/ip6_fib.h>
@@ -38,7 +39,6 @@
 #include <net/sch_generic.h>
 #include <net/netns/generic.h>
 #include <net/netfilter/nf_conntrack.h>
-#include <net/inet_dscp.h>
 
 #define DRV_NAME	"vrf"
 #define DRV_VERSION	"1.1"
@@ -505,7 +505,7 @@ static netdev_tx_t vrf_process_v4_outbound(struct sk_buff *skb,
 	/* needed to match OIF rule */
 	fl4.flowi4_l3mdev = vrf_dev->ifindex;
 	fl4.flowi4_iif = LOOPBACK_IFINDEX;
-	fl4.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(ip4h));
+	fl4.flowi4_dscp = ip4h_dscp(ip4h);
 	fl4.flowi4_flags = FLOWI_FLAG_ANYSRC;
 	fl4.flowi4_proto = ip4h->protocol;
 	fl4.daddr = ip4h->daddr;
diff --git a/include/net/flow.h b/include/net/flow.h
index a1839c278d87..ae9481c40063 100644
--- a/include/net/flow.h
+++ b/include/net/flow.h
@@ -12,6 +12,7 @@
 #include <linux/atomic.h>
 #include <linux/container_of.h>
 #include <linux/uidgid.h>
+#include <net/inet_dscp.h>
 
 struct flow_keys;
 
@@ -32,7 +33,7 @@ struct flowi_common {
 	int	flowic_iif;
 	int     flowic_l3mdev;
 	__u32	flowic_mark;
-	__u8	flowic_tos;
+	dscp_t	flowic_dscp;
 	__u8	flowic_scope;
 	__u8	flowic_proto;
 	__u8	flowic_flags;
@@ -70,7 +71,7 @@ struct flowi4 {
 #define flowi4_iif		__fl_common.flowic_iif
 #define flowi4_l3mdev		__fl_common.flowic_l3mdev
 #define flowi4_mark		__fl_common.flowic_mark
-#define flowi4_tos		__fl_common.flowic_tos
+#define flowi4_dscp		__fl_common.flowic_dscp
 #define flowi4_scope		__fl_common.flowic_scope
 #define flowi4_proto		__fl_common.flowic_proto
 #define flowi4_flags		__fl_common.flowic_flags
@@ -103,7 +104,7 @@ static inline void flowi4_init_output(struct flowi4 *fl4, int oif,
 	fl4->flowi4_iif = LOOPBACK_IFINDEX;
 	fl4->flowi4_l3mdev = 0;
 	fl4->flowi4_mark = mark;
-	fl4->flowi4_tos = tos;
+	fl4->flowi4_dscp = inet_dsfield_to_dscp(tos);
 	fl4->flowi4_scope = scope;
 	fl4->flowi4_proto = proto;
 	fl4->flowi4_flags = flags;
@@ -141,7 +142,7 @@ struct flowi6 {
 #define flowi6_uid		__fl_common.flowic_uid
 	struct in6_addr		daddr;
 	struct in6_addr		saddr;
-	/* Note: flowi6_tos is encoded in flowlabel, too. */
+	/* Note: flowi6_dscp is encoded in flowlabel, too. */
 	__be32			flowlabel;
 	union flowi_uli		uli;
 #define fl6_sport		uli.ports.sport
@@ -163,7 +164,7 @@ struct flowi {
 #define flowi_iif	u.__fl_common.flowic_iif
 #define flowi_l3mdev	u.__fl_common.flowic_l3mdev
 #define flowi_mark	u.__fl_common.flowic_mark
-#define flowi_tos	u.__fl_common.flowic_tos
+#define flowi_dscp	u.__fl_common.flowic_dscp
 #define flowi_scope	u.__fl_common.flowic_scope
 #define flowi_proto	u.__fl_common.flowic_proto
 #define flowi_flags	u.__fl_common.flowic_flags
diff --git a/include/net/inet_dscp.h b/include/net/inet_dscp.h
index 72f250dffada..1aa9f04ed1ab 100644
--- a/include/net/inet_dscp.h
+++ b/include/net/inet_dscp.h
@@ -39,6 +39,12 @@ typedef u8 __bitwise dscp_t;
 
 #define INET_DSCP_MASK 0xfc
 
+/* A few places in the IPv4 code need to ignore the three high order bits of
+ * DSCP because of backward compatibility (as these bits used to represent the
+ * IPv4 Precedence in RFC 791's TOS field and were ignored).
+ */
+#define INET_DSCP_LEGACY_TOS_MASK ((__force dscp_t)0x1c)
+
 static inline dscp_t inet_dsfield_to_dscp(__u8 dsfield)
 {
 	return (__force dscp_t)(dsfield & INET_DSCP_MASK);
diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index 48bb3cf41469..b4495c38e0a0 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -440,7 +440,7 @@ static inline bool fib4_rules_early_flow_dissect(struct net *net,
 
 static inline bool fib_dscp_masked_match(dscp_t dscp, const struct flowi4 *fl4)
 {
-	return dscp == inet_dsfield_to_dscp(RT_TOS(fl4->flowi4_tos));
+	return dscp == (fl4->flowi4_dscp & INET_DSCP_LEGACY_TOS_MASK);
 }
 
 /* Exported by fib_frontend.c */
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 8cf1380f3656..4314a97702ea 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -11,7 +11,9 @@
 #include <linux/bitops.h>
 
 #include <net/dsfield.h>
+#include <net/flow.h>
 #include <net/gro_cells.h>
+#include <net/inet_dscp.h>
 #include <net/inet_ecn.h>
 #include <net/netns/generic.h>
 #include <net/rtnetlink.h>
@@ -362,7 +364,7 @@ static inline void ip_tunnel_init_flow(struct flowi4 *fl4,
 
 	fl4->daddr = daddr;
 	fl4->saddr = saddr;
-	fl4->flowi4_tos = tos;
+	fl4->flowi4_dscp = inet_dsfield_to_dscp(tos);
 	fl4->flowi4_proto = proto;
 	fl4->fl4_gre_key = key;
 	fl4->flowi4_mark = mark;
diff --git a/include/net/route.h b/include/net/route.h
index 7ea840daa775..c71998f464f8 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -189,7 +189,7 @@ static inline struct rtable *ip_route_output(struct net *net, __be32 daddr,
 {
 	struct flowi4 fl4 = {
 		.flowi4_oif = oif,
-		.flowi4_tos = inet_dscp_to_dsfield(dscp),
+		.flowi4_dscp = dscp,
 		.flowi4_scope = scope,
 		.daddr = daddr,
 		.saddr = saddr,
diff --git a/include/trace/events/fib.h b/include/trace/events/fib.h
index 20b914250ce9..feb28b359eff 100644
--- a/include/trace/events/fib.h
+++ b/include/trace/events/fib.h
@@ -7,6 +7,8 @@
 
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
+#include <net/flow.h>
+#include <net/inet_dscp.h>
 #include <net/ip_fib.h>
 #include <linux/tracepoint.h>
 
@@ -44,7 +46,7 @@ TRACE_EVENT(fib_table_lookup,
 		__entry->err = err;
 		__entry->oif = flp->flowi4_oif;
 		__entry->iif = flp->flowi4_iif;
-		__entry->tos = flp->flowi4_tos;
+		__entry->tos = inet_dscp_to_dsfield(flp->flowi4_dscp);
 		__entry->scope = flp->flowi4_scope;
 		__entry->flags = flp->flowi4_flags;
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 63f3baee2daf..0d7a4878cdc3 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2373,7 +2373,7 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 		struct flowi4 fl4 = {
 			.flowi4_flags = FLOWI_FLAG_ANYSRC,
 			.flowi4_mark  = skb->mark,
-			.flowi4_tos   = inet_dscp_to_dsfield(ip4h_dscp(ip4h)),
+			.flowi4_dscp  = ip4h_dscp(ip4h),
 			.flowi4_oif   = dev->ifindex,
 			.flowi4_proto = ip4h->protocol,
 			.daddr	      = ip4h->daddr,
@@ -6020,7 +6020,7 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 		fl4.flowi4_iif = params->ifindex;
 		fl4.flowi4_oif = 0;
 	}
-	fl4.flowi4_tos = params->tos & INET_DSCP_MASK;
+	fl4.flowi4_dscp = inet_dsfield_to_dscp(params->tos);
 	fl4.flowi4_scope = RT_SCOPE_UNIVERSE;
 	fl4.flowi4_flags = 0;
 
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index ae74634310a3..9f40be0c3e71 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -8,12 +8,12 @@
 #include <linux/skbuff.h>
 #include <linux/types.h>
 #include <linux/bpf.h>
+#include <net/flow.h>
 #include <net/lwtunnel.h>
 #include <net/gre.h>
 #include <net/ip.h>
 #include <net/ip6_route.h>
 #include <net/ipv6_stubs.h>
-#include <net/inet_dscp.h>
 
 struct bpf_lwt_prog {
 	struct bpf_prog *prog;
@@ -209,7 +209,7 @@ static int bpf_lwt_xmit_reroute(struct sk_buff *skb)
 		fl4.flowi4_oif = oif;
 		fl4.flowi4_mark = skb->mark;
 		fl4.flowi4_uid = sock_net_uid(net, sk);
-		fl4.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(iph));
+		fl4.flowi4_dscp = ip4h_dscp(iph);
 		fl4.flowi4_flags = FLOWI_FLAG_ANYSRC;
 		fl4.flowi4_proto = iph->protocol;
 		fl4.daddr = iph->daddr;
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 6e1b94796f67..1dab44e13d3b 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -32,6 +32,7 @@
 #include <linux/list.h>
 #include <linux/slab.h>
 
+#include <net/flow.h>
 #include <net/inet_dscp.h>
 #include <net/ip.h>
 #include <net/protocol.h>
@@ -293,7 +294,7 @@ __be32 fib_compute_spec_dst(struct sk_buff *skb)
 			.flowi4_iif = LOOPBACK_IFINDEX,
 			.flowi4_l3mdev = l3mdev_master_ifindex_rcu(dev),
 			.daddr = ip_hdr(skb)->saddr,
-			.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(ip_hdr(skb))),
+			.flowi4_dscp = ip4h_dscp(ip_hdr(skb)),
 			.flowi4_scope = scope,
 			.flowi4_mark = vmark ? skb->mark : 0,
 		};
@@ -358,7 +359,7 @@ static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 	fl4.flowi4_iif = oif ? : LOOPBACK_IFINDEX;
 	fl4.daddr = src;
 	fl4.saddr = dst;
-	fl4.flowi4_tos = inet_dscp_to_dsfield(dscp);
+	fl4.flowi4_dscp = dscp;
 	fl4.flowi4_scope = RT_SCOPE_UNIVERSE;
 	fl4.flowi4_tun_key.tun_id = 0;
 	fl4.flowi4_flags = 0;
@@ -1372,7 +1373,7 @@ static void nl_fib_lookup(struct net *net, struct fib_result_nl *frn)
 	struct flowi4           fl4 = {
 		.flowi4_mark = frn->fl_mark,
 		.daddr = frn->fl_addr,
-		.flowi4_tos = frn->fl_tos & INET_DSCP_MASK,
+		.flowi4_dscp = inet_dsfield_to_dscp(frn->fl_tos),
 		.flowi4_scope = frn->fl_scope,
 	};
 	struct fib_table *tb;
diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index fa58d6620ed6..51f0193092f0 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -23,6 +23,7 @@
 #include <linux/list.h>
 #include <linux/rcupdate.h>
 #include <linux/export.h>
+#include <net/flow.h>
 #include <net/inet_dscp.h>
 #include <net/ip.h>
 #include <net/route.h>
@@ -193,8 +194,7 @@ INDIRECT_CALLABLE_SCOPE int fib4_rule_match(struct fib_rule *rule,
 	 * to mask the upper three DSCP bits prior to matching to maintain
 	 * legacy behavior.
 	 */
-	if (r->dscp_full &&
-	    (r->dscp ^ inet_dsfield_to_dscp(fl4->flowi4_tos)) & r->dscp_mask)
+	if (r->dscp_full && (r->dscp ^ fl4->flowi4_dscp) & r->dscp_mask)
 		return 0;
 	else if (!r->dscp_full && r->dscp &&
 		 !fib_dscp_masked_match(r->dscp, fl4))
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 91765057aa1d..7248c15cbd75 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -72,6 +72,7 @@
 #include <linux/string.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/slab.h>
+#include <net/flow.h>
 #include <net/snmp.h>
 #include <net/ip.h>
 #include <net/route.h>
@@ -444,7 +445,7 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 	fl4.saddr = saddr;
 	fl4.flowi4_mark = mark;
 	fl4.flowi4_uid = sock_net_uid(net, NULL);
-	fl4.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(ip_hdr(skb)));
+	fl4.flowi4_dscp = ip4h_dscp(ip_hdr(skb));
 	fl4.flowi4_proto = IPPROTO_ICMP;
 	fl4.flowi4_oif = l3mdev_master_ifindex(skb->dev);
 	security_skb_classify_flow(skb, flowi4_to_flowi_common(&fl4));
@@ -495,7 +496,7 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 	fl4->saddr = saddr;
 	fl4->flowi4_mark = mark;
 	fl4->flowi4_uid = sock_net_uid(net, NULL);
-	fl4->flowi4_tos = inet_dscp_to_dsfield(dscp);
+	fl4->flowi4_dscp = dscp;
 	fl4->flowi4_proto = IPPROTO_ICMP;
 	fl4->fl4_icmp_type = type;
 	fl4->fl4_icmp_code = code;
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index f5b9004d6938..761a53c6a89a 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -28,6 +28,7 @@
 #include <linux/etherdevice.h>
 #include <linux/if_ether.h>
 
+#include <net/flow.h>
 #include <net/sock.h>
 #include <net/ip.h>
 #include <net/icmp.h>
@@ -44,7 +45,6 @@
 #include <net/gre.h>
 #include <net/dst_metadata.h>
 #include <net/erspan.h>
-#include <net/inet_dscp.h>
 
 /*
    Problems & solutions
@@ -930,7 +930,7 @@ static int ipgre_open(struct net_device *dev)
 	if (ipv4_is_multicast(t->parms.iph.daddr)) {
 		struct flowi4 fl4 = {
 			.flowi4_oif = t->parms.link,
-			.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(&t->parms.iph)),
+			.flowi4_dscp = ip4h_dscp(&t->parms.iph),
 			.flowi4_scope = RT_SCOPE_UNIVERSE,
 			.flowi4_proto = IPPROTO_GRE,
 			.saddr = t->parms.iph.saddr,
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 84e7f8a2f50f..2b96651d719b 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -63,6 +63,7 @@
 #include <linux/stat.h>
 #include <linux/init.h>
 
+#include <net/flow.h>
 #include <net/snmp.h>
 #include <net/ip.h>
 #include <net/protocol.h>
@@ -485,7 +486,7 @@ int __ip_queue_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl,
 		inet_sk_init_flowi4(inet, fl4);
 
 		/* sctp_v4_xmit() uses its own DSCP value */
-		fl4->flowi4_tos = tos & INET_DSCP_MASK;
+		fl4->flowi4_dscp = inet_dsfield_to_dscp(tos);
 
 		/* If this fails, retransmit mechanism of transport layer will
 		 * keep trying until route appears or the connection times
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index e86a8a862c41..345e5faac634 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -42,6 +42,7 @@
 #include <linux/init.h>
 #include <linux/if_ether.h>
 #include <linux/slab.h>
+#include <net/flow.h>
 #include <net/net_namespace.h>
 #include <net/ip.h>
 #include <net/protocol.h>
@@ -2120,7 +2121,7 @@ static struct mr_table *ipmr_rt_fib_lookup(struct net *net, struct sk_buff *skb)
 	struct flowi4 fl4 = {
 		.daddr = iph->daddr,
 		.saddr = iph->saddr,
-		.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(iph)),
+		.flowi4_dscp = ip4h_dscp(iph),
 		.flowi4_oif = (rt_is_output_route(rt) ?
 			       skb->dev->ifindex : 0),
 		.flowi4_iif = (rt_is_output_route(rt) ?
diff --git a/net/ipv4/netfilter.c b/net/ipv4/netfilter.c
index e60e54e7945d..ce310eb779e0 100644
--- a/net/ipv4/netfilter.c
+++ b/net/ipv4/netfilter.c
@@ -11,10 +11,10 @@
 #include <linux/skbuff.h>
 #include <linux/gfp.h>
 #include <linux/export.h>
+#include <net/flow.h>
 #include <net/route.h>
 #include <net/xfrm.h>
 #include <net/ip.h>
-#include <net/inet_dscp.h>
 #include <net/netfilter/nf_queue.h>
 
 /* route_me_harder function, used by iptable_nat, iptable_mangle + ip_queue */
@@ -44,7 +44,7 @@ int ip_route_me_harder(struct net *net, struct sock *sk, struct sk_buff *skb, un
 	 */
 	fl4.daddr = iph->daddr;
 	fl4.saddr = saddr;
-	fl4.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(iph));
+	fl4.flowi4_dscp = ip4h_dscp(iph);
 	fl4.flowi4_oif = sk ? sk->sk_bound_dev_if : 0;
 	fl4.flowi4_l3mdev = l3mdev_master_ifindex(dev);
 	fl4.flowi4_mark = skb->mark;
diff --git a/net/ipv4/netfilter/ipt_rpfilter.c b/net/ipv4/netfilter/ipt_rpfilter.c
index a27782d7653e..6d9bf5106868 100644
--- a/net/ipv4/netfilter/ipt_rpfilter.c
+++ b/net/ipv4/netfilter/ipt_rpfilter.c
@@ -8,8 +8,8 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
-#include <net/inet_dscp.h>
 #include <linux/ip.h>
+#include <net/flow.h>
 #include <net/ip.h>
 #include <net/ip_fib.h>
 #include <net/route.h>
@@ -76,7 +76,7 @@ static bool rpfilter_mt(const struct sk_buff *skb, struct xt_action_param *par)
 	flow.daddr = iph->saddr;
 	flow.saddr = rpfilter_get_saddr(iph->daddr);
 	flow.flowi4_mark = info->flags & XT_RPFILTER_VALID_MARK ? skb->mark : 0;
-	flow.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(iph));
+	flow.flowi4_dscp = ip4h_dscp(iph);
 	flow.flowi4_scope = RT_SCOPE_UNIVERSE;
 	flow.flowi4_l3mdev = l3mdev_master_ifindex_rcu(xt_in(par));
 	flow.flowi4_uid = sock_net_uid(xt_net(par), NULL);
diff --git a/net/ipv4/netfilter/nf_dup_ipv4.c b/net/ipv4/netfilter/nf_dup_ipv4.c
index ed08fb78cfa8..9a773502f10a 100644
--- a/net/ipv4/netfilter/nf_dup_ipv4.c
+++ b/net/ipv4/netfilter/nf_dup_ipv4.c
@@ -12,10 +12,10 @@
 #include <linux/skbuff.h>
 #include <linux/netfilter.h>
 #include <net/checksum.h>
+#include <net/flow.h>
 #include <net/icmp.h>
 #include <net/ip.h>
 #include <net/route.h>
-#include <net/inet_dscp.h>
 #include <net/netfilter/ipv4/nf_dup_ipv4.h>
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 #include <net/netfilter/nf_conntrack.h>
@@ -33,7 +33,7 @@ static bool nf_dup_ipv4_route(struct net *net, struct sk_buff *skb,
 		fl4.flowi4_oif = oif;
 
 	fl4.daddr = gw->s_addr;
-	fl4.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(iph));
+	fl4.flowi4_dscp = ip4h_dscp(iph);
 	fl4.flowi4_scope = RT_SCOPE_UNIVERSE;
 	fl4.flowi4_flags = FLOWI_FLAG_KNOWN_NH;
 	rt = ip_route_output_key(net, &fl4);
diff --git a/net/ipv4/netfilter/nft_fib_ipv4.c b/net/ipv4/netfilter/nft_fib_ipv4.c
index 7e7c49535e3f..82af6cd76d13 100644
--- a/net/ipv4/netfilter/nft_fib_ipv4.c
+++ b/net/ipv4/netfilter/nft_fib_ipv4.c
@@ -10,7 +10,7 @@
 #include <net/netfilter/nf_tables.h>
 #include <net/netfilter/nft_fib.h>
 
-#include <net/inet_dscp.h>
+#include <net/flow.h>
 #include <net/ip.h>
 #include <net/ip_fib.h>
 #include <net/route.h>
@@ -114,7 +114,7 @@ void nft_fib4_eval(const struct nft_expr *expr, struct nft_regs *regs,
 	if (priv->flags & NFTA_FIB_F_MARK)
 		fl4.flowi4_mark = pkt->skb->mark;
 
-	fl4.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(iph));
+	fl4.flowi4_dscp = ip4h_dscp(iph);
 
 	if (priv->flags & NFTA_FIB_F_DADDR) {
 		fl4.daddr = iph->daddr;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index f639a2ae881a..5c661c06d381 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -84,6 +84,7 @@
 #include <linux/jhash.h>
 #include <net/dst.h>
 #include <net/dst_metadata.h>
+#include <net/flow.h>
 #include <net/inet_dscp.h>
 #include <net/net_namespace.h>
 #include <net/ip.h>
@@ -1291,7 +1292,7 @@ void ip_rt_get_source(u8 *addr, struct sk_buff *skb, struct rtable *rt)
 		struct flowi4 fl4 = {
 			.daddr = iph->daddr,
 			.saddr = iph->saddr,
-			.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(iph)),
+			.flowi4_dscp = ip4h_dscp(iph),
 			.flowi4_oif = rt->dst.dev->ifindex,
 			.flowi4_iif = skb->dev->ifindex,
 			.flowi4_mark = skb->mark,
@@ -2331,7 +2332,7 @@ ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	fl4.flowi4_oif = 0;
 	fl4.flowi4_iif = dev->ifindex;
 	fl4.flowi4_mark = skb->mark;
-	fl4.flowi4_tos = inet_dscp_to_dsfield(dscp);
+	fl4.flowi4_dscp = dscp;
 	fl4.flowi4_scope = RT_SCOPE_UNIVERSE;
 	fl4.flowi4_flags = 0;
 	fl4.daddr = daddr;
@@ -2690,7 +2691,6 @@ struct rtable *ip_route_output_key_hash(struct net *net, struct flowi4 *fl4,
 	struct rtable *rth;
 
 	fl4->flowi4_iif = LOOPBACK_IFINDEX;
-	fl4->flowi4_tos &= INET_DSCP_MASK;
 
 	rcu_read_lock();
 	rth = ip_route_output_key_hash_rcu(net, fl4, &res, skb);
@@ -3333,7 +3333,7 @@ static int inet_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 
 	fl4.daddr = dst;
 	fl4.saddr = src;
-	fl4.flowi4_tos = inet_dscp_to_dsfield(dscp);
+	fl4.flowi4_dscp = dscp;
 	fl4.flowi4_oif = nla_get_u32_default(tb[RTA_OIF], 0);
 	fl4.flowi4_mark = mark;
 	fl4.flowi4_uid = uid;
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index fce945f23069..54386e06a813 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -4,6 +4,7 @@
 #include <linux/socket.h>
 #include <linux/kernel.h>
 #include <net/dst_metadata.h>
+#include <net/flow.h>
 #include <net/udp.h>
 #include <net/udp_tunnel.h>
 #include <net/inet_dscp.h>
@@ -253,7 +254,7 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 	fl4.saddr = key->u.ipv4.src;
 	fl4.fl4_dport = dport;
 	fl4.fl4_sport = sport;
-	fl4.flowi4_tos = tos & INET_DSCP_MASK;
+	fl4.flowi4_dscp = inet_dsfield_to_dscp(tos);
 	fl4.flowi4_flags = key->flow_flags;
 
 	rt = ip_route_output_key(net, &fl4);
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index 7fb6205619e7..58faf1ddd2b1 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -14,7 +14,7 @@
 #include <linux/inetdevice.h>
 #include <net/dst.h>
 #include <net/xfrm.h>
-#include <net/inet_dscp.h>
+#include <net/flow.h>
 #include <net/ip.h>
 #include <net/l3mdev.h>
 
@@ -25,7 +25,7 @@ static struct dst_entry *__xfrm4_dst_lookup(struct flowi4 *fl4,
 
 	memset(fl4, 0, sizeof(*fl4));
 	fl4->daddr = params->daddr->a4;
-	fl4->flowi4_tos = inet_dscp_to_dsfield(params->dscp);
+	fl4->flowi4_dscp = params->dscp;
 	fl4->flowi4_l3mdev = l3mdev_master_ifindex_by_index(params->net,
 							    params->oif);
 	fl4->flowi4_mark = params->mark;
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 225ff293cd50..14dd1c0698c3 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -9,7 +9,7 @@
 #include <linux/netfilter/nf_conntrack_common.h>
 #include <linux/netfilter/nf_tables.h>
 #include <net/ip.h>
-#include <net/inet_dscp.h>
+#include <net/flow.h>
 #include <net/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables_core.h>
 #include <net/netfilter/nf_conntrack_core.h>
@@ -236,7 +236,7 @@ static int nft_flow_route(const struct nft_pktinfo *pkt,
 		fl.u.ip4.saddr = ct->tuplehash[!dir].tuple.src.u3.ip;
 		fl.u.ip4.flowi4_oif = nft_in(pkt)->ifindex;
 		fl.u.ip4.flowi4_iif = this_dst->dev->ifindex;
-		fl.u.ip4.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(ip_hdr(pkt->skb)));
+		fl.u.ip4.flowi4_dscp = ip4h_dscp(ip_hdr(pkt->skb));
 		fl.u.ip4.flowi4_mark = pkt->skb->mark;
 		fl.u.ip4.flowi4_flags = FLOWI_FLAG_ANYSRC;
 		break;
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 3b2373b3bd5d..9dbc24af749b 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -34,6 +34,7 @@
 #include <linux/memblock.h>
 #include <linux/highmem.h>
 #include <linux/slab.h>
+#include <net/flow.h>
 #include <net/net_namespace.h>
 #include <net/protocol.h>
 #include <net/ip.h>
@@ -437,7 +438,7 @@ static void sctp_v4_get_dst(struct sctp_transport *t, union sctp_addr *saddr,
 	fl4->fl4_dport = daddr->v4.sin_port;
 	fl4->flowi4_proto = IPPROTO_SCTP;
 	if (asoc) {
-		fl4->flowi4_tos = inet_dscp_to_dsfield(dscp);
+		fl4->flowi4_dscp = dscp;
 		fl4->flowi4_scope = ip_sock_rt_scope(asoc->base.sk);
 		fl4->flowi4_oif = asoc->base.sk->sk_bound_dev_if;
 		fl4->fl4_sport = htons(asoc->base.bind_addr.port);
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 7111184eef59..62486f866975 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2594,7 +2594,7 @@ xfrm_tmpl_resolve(struct xfrm_policy **pols, int npols, const struct flowi *fl,
 static dscp_t xfrm_get_dscp(const struct flowi *fl, int family)
 {
 	if (family == AF_INET)
-		return inet_dsfield_to_dscp(fl->u.ip4.flowi4_tos);
+		return fl->u.ip4.flowi4_dscp;
 
 	return 0;
 }
@@ -3462,7 +3462,7 @@ decode_session4(const struct xfrm_flow_keys *flkeys, struct flowi *fl, bool reve
 	}
 
 	fl4->flowi4_proto = flkeys->basic.ip_proto;
-	fl4->flowi4_tos = flkeys->ip.tos & ~INET_ECN_MASK;
+	fl4->flowi4_dscp = inet_dsfield_to_dscp(flkeys->ip.tos);
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -3594,7 +3594,7 @@ static bool xfrm_icmp_flow_decode(struct sk_buff *skb, unsigned short family,
 
 	fl1->flowi_oif = fl->flowi_oif;
 	fl1->flowi_mark = fl->flowi_mark;
-	fl1->flowi_tos = fl->flowi_tos;
+	fl1->flowi_dscp = fl->flowi_dscp;
 	nf_nat_decode_session(newskb, fl1, family);
 	ret = false;
 
-- 
2.47.2


