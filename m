Return-Path: <netdev+bounces-262417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNGhAHdopGlcfgUAu9opvQ
	(envelope-from <netdev+bounces-262417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 17:25:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4783D1D09F3
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 17:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD78F3005D20
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 16:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C1E332EA7;
	Sun,  1 Mar 2026 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xwo/5ALN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1F231D39A
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772382323; cv=none; b=TbW2dwbkvsTqSgesP0TApI6WBWU/E5X5GiKSUeVfkYk7/RA1OExko+rXDvJTl1NVyuVxkv+fRb9wcpMOPP/9t5YVv8Crwd9gGI0deS+6oJkGv5Wxg29RsNQuxuCendB4i3uPE0PUh9pprRE3uG5Uzf3JexVwUdWQPB0TE5vBKvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772382323; c=relaxed/simple;
	bh=zbceCgA0dGvUGim3PMJxYsfnjgqq57VC94KMmvAxCWM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gzkRje1vtcygSW9H/a/ysR+Z0ieUlVbG99azfQPbgueRJm/kJ9n1HlrOORc61fLTdhWWrU7RL6gWLiJS0g1Ls0iFSg27LaXyhL4KVr7bTSlwj7htOTVP1SBlKtmCRq4Slmj4zJqrx1uL79S45+7WXEsfXNIvmKSrnex6OI7Ggas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xwo/5ALN; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-896fae40578so447969566d6.0
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 08:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772382318; x=1772987118; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nt/H0NtZQl7Noh1cBFTfPxF4Ox10YZt40UGbazZBzBg=;
        b=Xwo/5ALNiAvTu0qD19USSClcmhcWKYKfKy5Tm1dcxAdqrZh1fZiDoXZ22/OuAROzrE
         ODkZ3PhxuSFjaPjfluOxuYD20y9pxinWX/ogtTXVCIl0cQPqmvpT+MQ3Z8gvXjBAvyCL
         tFPN0899uZCWNn1DQFGbd6LTZyZeOoxeBfBxNZj8zp8CIi5HIWCJXIE+vDgX5Lb/J/cR
         iyYgWl8ck9wmY4zvsS8ND9qT7t6xjeiD3lLb/WLa0gK/XjoIiaa+OM0BIhnr/ITBd62g
         w3I9WwHqf8q2xlG7Qi4GO/eilJ1ovolNJdF2DtuLQPbp9aCbgcrBPu1AzJ+xJ3Mr4nIa
         /Q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772382318; x=1772987118;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nt/H0NtZQl7Noh1cBFTfPxF4Ox10YZt40UGbazZBzBg=;
        b=GrSuELm44t7+fjAo/RH6/RsflQQynyhe7/I2+DewOrsSxi1HEGqsPGbJGAnJlAiTnF
         5AdmtJRiXwWeOKHk+pO2R+V+e2fiMWEk+wHEAZY7+x35UejyHjn91ltGH5M3eEbFC0B6
         57X0QONlpsxBZJTOZqqE/+ltKivPYIhvHni7gVTGvoSN5dCTMvYwbDJuuqmDwqk3LJNu
         rWOgyN1z6TD3hPH8m5ZVUwqwOucku9qhmsGC/kqQoBM8TypzgrzhwozbY0YJq2T8PZKE
         JKcGDehbSP6HiVx1hMRsl466T0OKxyq7f/AaKXHefgoSFDhkg5GaOkjeyExexOJ3pOtM
         3Tdw==
X-Forwarded-Encrypted: i=1; AJvYcCVMUnR/goHaEy4NjaXPcXuvA4jEbkl/NFA0Y3EJ9p3BcuahtUCNBBxE2sifBWMfGDznrTzt814=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbn3QN4uwkU0OE8XBHOqejD2EyjvweyW+1b+I+XsfHeKixC4c2
	DRLfIiNH/FzQq/eZoy5sxHwyRdWFGF1FJ9L/Ymr8dh3DBRn2u7z2NZ51AQOH1Mq0wHD48P/zkZt
	+7w9FP1KL/QXxeA==
X-Received: from qvja7.prod.google.com ([2002:a0c:c587:0:b0:895:4d35:cb07])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:4c0b:0:b0:899:e9bf:3744 with SMTP id 6a1803df08f44-899e9bf3929mr38902866d6.63.1772382318118;
 Sun, 01 Mar 2026 08:25:18 -0800 (PST)
Date: Sun,  1 Mar 2026 16:25:14 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260301162514.3347319-1-edumazet@google.com>
Subject: [PATCH net-next] ipv6: add IPV6_CALL() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com,nvidia.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262417-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 4783D1D09F3
X-Rspamd-Action: no action

ipv6_stub use is racy, we should add READ_ONCE() and WRITE_ONCE(),
even if this pointer can only change once.

Add IPV6_CALL() macro to factorize the READ_ONCE(), and perform
direct calls when CONFIG_IPV6=y.

ipv6_stub->nd_tbl will need a separate patch.

$ size vmlinux.old vmlinux.new
   text	   data	    bss	    dec	    hex	filename
37705007	23152761	4747540	65605308	3e90ebc	vmlinux.0
37702861	23152665	4747540	65603066	3e905fa	vmlinux

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/22 grow/shrink: 0/25 up/down: 0/-1025 (-1025)
Function                                     old     new   delta
nexthop_select_path                          832     828      -4
ipv4_confirm_neigh                           426     422      -4
fib_detect_death                             348     344      -4
br_do_suppress_nd                            671     667      -4
udp_lib_setsockopt                           893     888      -5
set_xfrm_gro_udp_encap_rcv                   117     112      -5
__ipv6_neigh_lookup_noref_stub               336     328      -8
udp_tunnel_encap_enable                       57      45     -12
udp_tunnel6_dst_lookup                       465     453     -12
setup_udp_tunnel_sock                        251     239     -12
nexthop_free_rcu                             254     242     -12
bpf_xmit                                    1203    1191     -12
bpf_input                                    500     488     -12
__remove_nexthop                            1705    1693     -12
xfrm6_tunnel_check_size                      631     616     -15
sch_frag_xmit_hook                          1233    1218     -15
icmp_build_probe                             922     907     -15
eafnosupport_fib6_select_path                 15       -     -15
ip_neigh_gw6                                 708     692     -16
__pfx_eafnosupport_ipv6_route_input           16       -     -16
__pfx_eafnosupport_ipv6_fragment              16       -     -16
__pfx_eafnosupport_ipv6_dst_lookup_flow       16       -     -16
__pfx_eafnosupport_ipv6_dev_find              16       -     -16
__pfx_eafnosupport_ip6_mtu_from_fib6          16       -     -16
__pfx_eafnosupport_ip6_del_rt                 16       -     -16
__pfx_eafnosupport_fib6_table_lookup          16       -     -16
__pfx_eafnosupport_fib6_select_path           16       -     -16
__pfx_eafnosupport_fib6_nh_init               16       -     -16
__pfx_eafnosupport_fib6_lookup                16       -     -16
__pfx_eafnosupport_fib6_get_table             16       -     -16
eafnosupport_ip6_mtu_from_fib6                17       -     -17
eafnosupport_fib6_get_table                   17       -     -17
skb_do_redirect                             2878    2858     -20
eafnosupport_ipv6_route_input                 20       -     -20
eafnosupport_ip6_del_rt                       20       -     -20
eafnosupport_fib6_table_lookup                20       -     -20
eafnosupport_fib6_lookup                      20       -     -20
eafnosupport_ipv6_dst_lookup_flow             22       -     -22
eafnosupport_ipv6_dev_find                    22       -     -22
nh_rt_cache_flush                            191     167     -24
fib_check_nh                                1580    1556     -24
nat_keepalive_work_single                   1319    1292     -27
eafnosupport_ipv6_fragment                    35       -     -35
eafnosupport_fib6_nh_init                     49       -     -49
rtm_new_nexthop                             8495    8441     -54
bpf_ipv6_fib_lookup                         1107    1043     -64
.compoundliteral                            5792    5592    -200
Total: Before=25219423, After=25218398, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
CC: Ido Schimmel <idosch@nvidia.com>
---
 drivers/infiniband/core/addr.c                |  2 +-
 drivers/infiniband/sw/rxe/rxe_net.c           |  6 ++---
 .../ethernet/mellanox/mlx5/core/en/tc_tun.c   |  4 ++--
 .../ethernet/netronome/nfp/flower/action.c    |  2 +-
 .../netronome/nfp/flower/tunnel_conf.c        |  6 ++---
 drivers/net/ethernet/sfc/tc_encap_actions.c   |  4 ++--
 drivers/net/gtp.c                             |  2 +-
 drivers/net/ovpn/peer.c                       |  4 ++--
 drivers/net/ovpn/udp.c                        |  2 +-
 drivers/net/usb/cdc_mbim.c                    |  2 +-
 drivers/net/vxlan/vxlan_multicast.c           |  4 ++--
 drivers/net/wireguard/socket.c                |  4 ++--
 include/net/ipv6_stubs.h                      | 24 +++++++++++++------
 include/net/udp_tunnel.h                      |  2 +-
 net/core/filter.c                             | 12 +++++-----
 net/core/lwt_bpf.c                            |  4 ++--
 net/ipv4/fib_semantics.c                      |  4 ++--
 net/ipv4/icmp.c                               |  5 +++-
 net/ipv4/nexthop.c                            | 15 ++++++------
 net/ipv4/udp.c                                |  4 ++--
 net/ipv6/addrconf_core.c                      | 10 +++++---
 net/ipv6/af_inet6.c                           | 12 ++++++----
 net/ipv6/ip6_output.c                         |  1 +
 net/ipv6/ip6_udp_tunnel.c                     |  3 +--
 net/ipv6/ndisc.c                              |  1 +
 net/mpls/af_mpls.c                            |  2 +-
 net/openvswitch/actions.c                     |  2 +-
 net/sched/sch_frag.c                          |  5 ++--
 net/tipc/udp_media.c                          |  8 +++----
 net/xfrm/espintcp.c                           |  2 +-
 net/xfrm/xfrm_nat_keepalive.c                 |  4 ++--
 net/xfrm/xfrm_output.c                        |  2 +-
 32 files changed, 93 insertions(+), 71 deletions(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 866746695712aeae425100eefb231e44d52d52d4..5de8fd283ac9b0dbc07d5851f05d15e84c3645e3 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -411,7 +411,7 @@ static int addr6_resolve(struct sockaddr *src_sock,
 	fl6.saddr = src_in->sin6_addr;
 	fl6.flowi6_oif = addr->bound_dev_if;
 
-	dst = ipv6_stub->ipv6_dst_lookup_flow(addr->net, NULL, &fl6, NULL);
+	dst = IPV6_CALL(ip6_dst_lookup_flow)(addr->net, NULL, &fl6, NULL);
 	if (IS_ERR(dst))
 		return PTR_ERR(dst);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 0bd0902b11f734acbbb9fa521bf117bbf6a7710d..d5c81705c801bcd618520d143bff023b65b7132a 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -138,9 +138,9 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
 	memcpy(&fl6.daddr, daddr, sizeof(*daddr));
 	fl6.flowi6_proto = IPPROTO_UDP;
 
-	ndst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(recv_sockets.sk6->sk),
-					       recv_sockets.sk6->sk, &fl6,
-					       NULL);
+	ndst = IPV6_CALL(ip6_dst_lookup_flow)(sock_net(recv_sockets.sk6->sk),
+					      recv_sockets.sk6->sk, &fl6,
+					      NULL);
 	if (IS_ERR(ndst)) {
 		rxe_dbg_qp(qp, "no route to %pI6\n", daddr);
 		return NULL;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
index a14f216048cd2dbe37d0f905c55138ab2c744a42..45462aa0960b9fb23885b0bd6b8b398880369299 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
@@ -453,8 +453,8 @@ static int mlx5e_route_lookup_ipv6_get(struct mlx5e_priv *priv,
 
 	if (tunnel && tunnel->get_remote_ifindex)
 		attr->fl.fl6.flowi6_oif = tunnel->get_remote_ifindex(dev);
-	dst = ipv6_stub->ipv6_dst_lookup_flow(dev_net(dev), NULL, &attr->fl.fl6,
-					      NULL);
+	dst = IPV6_CALL(ip6_dst_lookup_flow)(dev_net(dev), NULL, &attr->fl.fl6,
+					     NULL);
 	if (IS_ERR(dst))
 		return PTR_ERR(dst);
 
diff --git a/drivers/net/ethernet/netronome/nfp/flower/action.c b/drivers/net/ethernet/netronome/nfp/flower/action.c
index aca2a7417af37c52fd26278139263760a781e72b..71da2f6fdfa5364d704ac140967b41bf0dfc39e9 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/action.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/action.c
@@ -470,7 +470,7 @@ nfp_fl_set_tun(struct nfp_app *app, struct nfp_fl_set_tun *set_tun,
 
 		flow.daddr = ip_tun->key.u.ipv6.dst;
 		flow.flowi4_proto = IPPROTO_UDP;
-		dst = ipv6_stub->ipv6_dst_lookup_flow(net, NULL, &flow, NULL);
+		dst = IPV6_CALL(ip6_dst_lookup_flow)(net, NULL, &flow, NULL);
 		if (!IS_ERR(dst)) {
 			set_tun->ttl = ip6_dst_hoplimit(dst);
 			dst_release(dst);
diff --git a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
index 0cef0e2b85d09de991d242dce9f6a174bc6d4457..a6dab3fc00bf355be2b32ab7c2ccef2950924677 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
@@ -650,7 +650,7 @@ static void nfp_tun_neigh_update(struct work_struct *work)
 		flow6.daddr = *(struct in6_addr *)n->primary_key;
 		if (!neigh_invalid) {
 			struct dst_entry *dst;
-			/* Use ipv6_dst_lookup_flow to populate flow6->saddr
+			/* Use ip6_dst_lookup_flow to populate flow6->saddr
 			 * and other fields. This information is only needed
 			 * for new entries, lookup can be skipped when an entry
 			 * gets invalidated - as only the daddr is needed for
@@ -815,8 +815,8 @@ void nfp_tunnel_request_route_v6(struct nfp_app *app, struct sk_buff *skb)
 	flow.flowi6_proto = IPPROTO_UDP;
 
 #if IS_ENABLED(CONFIG_INET) && IS_ENABLED(CONFIG_IPV6)
-	dst = ipv6_stub->ipv6_dst_lookup_flow(dev_net(netdev), NULL, &flow,
-					      NULL);
+	dst = IPV6_CALL(ip6_dst_lookup_flow)(dev_net(netdev), NULL, &flow,
+					     NULL);
 	if (IS_ERR(dst))
 		goto fail_rcu_unlock;
 #else
diff --git a/drivers/net/ethernet/sfc/tc_encap_actions.c b/drivers/net/ethernet/sfc/tc_encap_actions.c
index da35705cc5e19d0e2435407bdd2cf8e273e22b59..be5dea4441d47a72590785cbdd7b604334926ef9 100644
--- a/drivers/net/ethernet/sfc/tc_encap_actions.c
+++ b/drivers/net/ethernet/sfc/tc_encap_actions.c
@@ -149,8 +149,8 @@ static int efx_bind_neigh(struct efx_nic *efx,
 #if IS_ENABLED(CONFIG_IPV6)
 			struct dst_entry *dst;
 
-			dst = ipv6_stub->ipv6_dst_lookup_flow(net, NULL, &flow6,
-							      NULL);
+			dst = IPV6_CALL(ip6_dst_lookup_flow)(net, NULL, &flow6,
+							     NULL);
 			rc = PTR_ERR_OR_ZERO(dst);
 			if (rc) {
 				NL_SET_ERR_MSG_MOD(extack, "Failed to lookup route for IPv6 encap");
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index e8949f5562090513e2d95ea01f3d463356e58cfb..e42cedaf413261eedd9dc9982be6423bbbfa51b6 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -374,7 +374,7 @@ static struct rt6_info *ip6_route_output_gtp(struct net *net,
 	fl6->saddr		= *saddr;
 	fl6->flowi6_proto	= sk->sk_protocol;
 
-	dst = ipv6_stub->ipv6_dst_lookup_flow(net, sk, fl6, NULL);
+	dst = IPV6_CALL(ip6_dst_lookup_flow)(net, sk, fl6, NULL);
 	if (IS_ERR(dst))
 		return ERR_PTR(-ENETUNREACH);
 
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 3716a1d828015e2f6cdfa75d1a81c89d1f32b4ce..2f9dec27bdeee38a6c021d495a717a2803e08966 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -821,8 +821,8 @@ static struct in6_addr ovpn_nexthop_from_rt6(struct ovpn_priv *ovpn,
 		.daddr = dest,
 	};
 
-	entry = ipv6_stub->ipv6_dst_lookup_flow(dev_net(ovpn->dev), NULL, &fl,
-						NULL);
+	entry = IPV6_CALL(ip6_dst_lookup_flow)(dev_net(ovpn->dev), NULL, &fl,
+					       NULL);
 	if (IS_ERR(entry)) {
 		net_dbg_ratelimited("%s: no route to host %pI6c\n",
 				    netdev_name(ovpn->dev), &dest);
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 272b535ecaad4c75ff2aa9d4589b4cfa36a0dea9..20db16a37777e82d7c5c6ac2b0400863bff8b7d9 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -251,7 +251,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 		dst_cache_reset(cache);
 	}
 
-	dst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(sk), sk, &fl, NULL);
+	dst = IPV6_CALL(ip6_dst_lookup_flow)(sock_net(sk), sk, &fl, NULL);
 	if (IS_ERR(dst)) {
 		ret = PTR_ERR(dst);
 		net_dbg_ratelimited("%s: no route to host %pISpc: %d\n",
diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
index dbf01210b0e783ddc3c6961663ebf8d4574b6bf0..e645c9c33ee781eae975d7d4be3d14050d2851a5 100644
--- a/drivers/net/usb/cdc_mbim.c
+++ b/drivers/net/usb/cdc_mbim.c
@@ -343,7 +343,7 @@ static void do_neigh_solicit(struct usbnet *dev, u8 *buf, u16 tci)
 	in6_dev_put(in6_dev);
 
 	/* ipv6_stub != NULL if in6_dev_get returned an inet6_dev */
-	ipv6_stub->ndisc_send_na(netdev, &iph->saddr, &msg->target,
+	IPV6_CALL(ndisc_send_na)(netdev, &iph->saddr, &msg->target,
 				 is_router /* router */,
 				 true /* solicited */,
 				 false /* override */,
diff --git a/drivers/net/vxlan/vxlan_multicast.c b/drivers/net/vxlan/vxlan_multicast.c
index a7f2d67dc61b80197f1f2c9ec978e1b7d984e4e2..54e1b275b81263ca7b815a4b95c4ecd56b161358 100644
--- a/drivers/net/vxlan/vxlan_multicast.c
+++ b/drivers/net/vxlan/vxlan_multicast.c
@@ -39,7 +39,7 @@ int vxlan_igmp_join(struct vxlan_dev *vxlan, union vxlan_addr *rip,
 
 		sk = sock6->sock->sk;
 		lock_sock(sk);
-		ret = ipv6_stub->ipv6_sock_mc_join(sk, ifindex,
+		ret = IPV6_CALL(ipv6_sock_mc_join)(sk, ifindex,
 						   &ip->sin6.sin6_addr);
 		release_sock(sk);
 #endif
@@ -73,7 +73,7 @@ int vxlan_igmp_leave(struct vxlan_dev *vxlan, union vxlan_addr *rip,
 
 		sk = sock6->sock->sk;
 		lock_sock(sk);
-		ret = ipv6_stub->ipv6_sock_mc_drop(sk, ifindex,
+		ret = IPV6_CALL(ipv6_sock_mc_drop)(sk, ifindex,
 						   &ip->sin6.sin6_addr);
 		release_sock(sk);
 #endif
diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
index 253488f8c00f887d68b5c592e9f09e1a1777d9cc..66901b0e76c8b628faaf73104fc44ef6b96ab2f2 100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -136,8 +136,8 @@ static int send6(struct wg_device *wg, struct sk_buff *skb,
 			if (cache)
 				dst_cache_reset(cache);
 		}
-		dst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(sock), sock, &fl,
-						      NULL);
+		dst = IPV6_CALL(ip6_dst_lookup_flow)(sock_net(sock), sock, &fl,
+						     NULL);
 		if (IS_ERR(dst)) {
 			ret = PTR_ERR(dst);
 			net_dbg_ratelimited("%s: No route to %pISpfsc, error %d\n",
diff --git a/include/net/ipv6_stubs.h b/include/net/ipv6_stubs.h
index d3013e721b1441158e732b04d94078c0a7e9aa6a..162c7bbae85b4b2bb2a5e636ac38ac03aa98bf44 100644
--- a/include/net/ipv6_stubs.h
+++ b/include/net/ipv6_stubs.h
@@ -17,18 +17,22 @@ struct fib6_nh;
 struct fib6_config;
 struct fib6_result;
 
+int ipv6_route_input(struct sk_buff *skb);
+
 /* This is ugly, ideally these symbols should be built
  * into the core kernel.
  */
 struct ipv6_stub {
+	struct neigh_table *nd_tbl;
+#if !defined(CONFIG_IPV6)
 	int (*ipv6_sock_mc_join)(struct sock *sk, int ifindex,
 				 const struct in6_addr *addr);
 	int (*ipv6_sock_mc_drop)(struct sock *sk, int ifindex,
 				 const struct in6_addr *addr);
-	struct dst_entry *(*ipv6_dst_lookup_flow)(struct net *net,
-						  const struct sock *sk,
-						  struct flowi6 *fl6,
-						  const struct in6_addr *final_dst);
+	struct dst_entry *(*ip6_dst_lookup_flow)(struct net *net,
+						 const struct sock *sk,
+						 struct flowi6 *fl6,
+						 const struct in6_addr *final_dst);
 	int (*ipv6_route_input)(struct sk_buff *skb);
 
 	struct fib6_table *(*fib6_get_table)(struct net *net, u32 id);
@@ -67,14 +71,14 @@ struct ipv6_stub {
 	int (*xfrm6_rcv_encap)(struct sk_buff *skb, int nexthdr, __be32 spi,
 			       int encap_type);
 #endif
-	struct neigh_table *nd_tbl;
 
-	int (*ipv6_fragment)(struct net *net, struct sock *sk, struct sk_buff *skb,
-			     int (*output)(struct net *, struct sock *, struct sk_buff *));
+	int (*ip6_fragment)(struct net *net, struct sock *sk, struct sk_buff *skb,
+			    int (*output)(struct net *, struct sock *, struct sk_buff *));
 	struct net_device *(*ipv6_dev_find)(struct net *net, const struct in6_addr *addr,
 					    struct net_device *dev);
 	int (*ip6_xmit)(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 			__u32 mark, struct ipv6_txoptions *opt, int tclass, u32 priority);
+#endif
 };
 extern const struct ipv6_stub *ipv6_stub __read_mostly;
 
@@ -99,4 +103,10 @@ struct ipv6_bpf_stub {
 };
 extern const struct ipv6_bpf_stub *ipv6_bpf_stub __read_mostly;
 
+#if defined(CONFIG_IPV6)
+#define IPV6_CALL(X) (X)
+#else
+#define IPV6_CALL(X) (READ_ONCE(ipv6_stub)->X)
+#endif
+
 #endif
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index d9c6d04bb3b587d50397e83df087b39963ba5121..fade8bd88e87d8b994d8496c39209e565be4e587 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -230,7 +230,7 @@ static inline void udp_tunnel_encap_enable(struct sock *sk)
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (READ_ONCE(sk->sk_family) == PF_INET6)
-		ipv6_stub->udpv6_encap_enable();
+		IPV6_CALL(udpv6_encap_enable)();
 #endif
 	udp_encap_enable();
 }
diff --git a/net/core/filter.c b/net/core/filter.c
index 0d5d5a17acb2d62a171075d83ca302a52a5e4887..c9db6c70992af7a399d6c5ab3296244f46eadd72 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2276,7 +2276,7 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 			.saddr	      = ip6h->saddr,
 		};
 
-		dst = ipv6_stub->ipv6_dst_lookup_flow(net, NULL, &fl6, NULL);
+		dst = IPV6_CALL(ip6_dst_lookup_flow)(net, NULL, &fl6, NULL);
 		if (IS_ERR(dst))
 			goto out_drop;
 
@@ -6281,11 +6281,11 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 			params->tbid = 0;
 		}
 
-		tb = ipv6_stub->fib6_get_table(net, tbid);
+		tb = IPV6_CALL(fib6_get_table)(net, tbid);
 		if (unlikely(!tb))
 			return BPF_FIB_LKUP_RET_NOT_FWDED;
 
-		err = ipv6_stub->fib6_table_lookup(net, tb, oif, &fl6, &res,
+		err = IPV6_CALL(fib6_table_lookup)(net, tb, oif, &fl6, &res,
 						   strict);
 	} else {
 		if (flags & BPF_FIB_LOOKUP_MARK)
@@ -6296,7 +6296,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 		fl6.flowi6_tun_key.tun_id = 0;
 		fl6.flowi6_uid = sock_net_uid(net, NULL);
 
-		err = ipv6_stub->fib6_lookup(net, oif, &fl6, &res, strict);
+		err = IPV6_CALL(fib6_lookup)(net, oif, &fl6, &res, strict);
 	}
 
 	if (unlikely(err || IS_ERR_OR_NULL(res.f6i) ||
@@ -6317,11 +6317,11 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 		return BPF_FIB_LKUP_RET_NOT_FWDED;
 	}
 
-	ipv6_stub->fib6_select_path(net, &res, &fl6, fl6.flowi6_oif,
+	IPV6_CALL(fib6_select_path)(net, &res, &fl6, fl6.flowi6_oif,
 				    fl6.flowi6_oif != 0, NULL, strict);
 
 	if (check_mtu) {
-		mtu = ipv6_stub->ip6_mtu_from_fib6(&res, dst, src);
+		mtu = IPV6_CALL(ip6_mtu_from_fib6)(&res, dst, src);
 		if (params->tot_len > mtu) {
 			params->mtu_result = mtu; /* union with tot_len */
 			return BPF_FIB_LKUP_RET_FRAG_NEEDED;
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index 9f40be0c3e71dd893b9eb86daa039aa42d81fffe..f0e97e086ea39df1bb01ff361a4080089550746b 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -103,7 +103,7 @@ static int bpf_lwt_input_reroute(struct sk_buff *skb)
 		dev_put(dev);
 	} else if (skb->protocol == htons(ETH_P_IPV6)) {
 		skb_dst_drop(skb);
-		err = ipv6_stub->ipv6_route_input(skb);
+		err = IPV6_CALL(ipv6_route_input)(skb);
 	} else {
 		err = -EAFNOSUPPORT;
 	}
@@ -233,7 +233,7 @@ static int bpf_lwt_xmit_reroute(struct sk_buff *skb)
 		fl6.daddr = iph6->daddr;
 		fl6.saddr = iph6->saddr;
 
-		dst = ipv6_stub->ipv6_dst_lookup_flow(net, skb->sk, &fl6, NULL);
+		dst = IPV6_CALL(ip6_dst_lookup_flow)(net, skb->sk, &fl6, NULL);
 		if (IS_ERR(dst)) {
 			err = PTR_ERR(dst);
 			goto err;
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 01cb587866d8f8d02c6bacce565c6e9f46afebeb..4dfd0c4526fc1fb374befc305270608833f32bba 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1083,7 +1083,7 @@ static int fib_check_nh_v6_gw(struct net *net, struct fib_nh *nh,
 	struct fib6_nh fib6_nh = {};
 	int err;
 
-	err = ipv6_stub->fib6_nh_init(net, &fib6_nh, &cfg, GFP_KERNEL, extack);
+	err = IPV6_CALL(fib6_nh_init)(net, &fib6_nh, &cfg, GFP_KERNEL, extack);
 	if (!err) {
 		nh->fib_nh_dev = fib6_nh.fib_nh_dev;
 		netdev_hold(nh->fib_nh_dev, &nh->fib_nh_dev_tracker,
@@ -1091,7 +1091,7 @@ static int fib_check_nh_v6_gw(struct net *net, struct fib_nh *nh,
 		nh->fib_nh_oif = nh->fib_nh_dev->ifindex;
 		nh->fib_nh_scope = RT_SCOPE_LINK;
 
-		ipv6_stub->fib6_nh_release(&fib6_nh);
+		IPV6_CALL(fib6_nh_release)(&fib6_nh);
 	}
 
 	return err;
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index ac6d2ffc1963f1a7650faee8f054a51c05071d4a..98e962347ca03f500448541009173000d6be5a85 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -1342,7 +1342,10 @@ bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
 		case ICMP_AFI_IP6:
 			if (iio->ident.addr.ctype3_hdr.addrlen != sizeof(struct in6_addr))
 				goto send_mal_query;
-			dev = ipv6_stub->ipv6_dev_find(net, &iio->ident.addr.ip_addr.ipv6_addr, dev);
+			dev = IPV6_CALL(ipv6_dev_find)(
+					net,
+					&iio->ident.addr.ip_addr.ipv6_addr,
+					dev);
 			dev_hold(dev);
 			break;
 #endif
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 1aa2b05ee8de856d187b198beb9af699921caa49..e30d0a816688e149e48d8a4662b65819d9d7c426 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -16,6 +16,7 @@
 #include <net/nexthop.h>
 #include <net/route.h>
 #include <net/sock.h>
+#include <net/ip6_route.h>
 
 #define NH_RES_DEFAULT_IDLE_TIMER	(120 * HZ)
 #define NH_RES_DEFAULT_UNBALANCED_TIMER	0	/* No forced rebalancing. */
@@ -510,7 +511,7 @@ static void nexthop_free_single(struct nexthop *nh)
 		fib_nh_release(nh->net, &nhi->fib_nh);
 		break;
 	case AF_INET6:
-		ipv6_stub->fib6_nh_release(&nhi->fib6_nh);
+		IPV6_CALL(fib6_nh_release)(&nhi->fib6_nh);
 		break;
 	}
 	kfree(nhi);
@@ -2143,7 +2144,7 @@ static void __remove_nexthop_fib(struct net *net, struct nexthop *nh)
 		fib6_info_hold(f6i);
 
 		spin_unlock_bh(&nh->lock);
-		ipv6_stub->ip6_del_rt(net, f6i,
+		IPV6_CALL(ip6_del_rt)(net, f6i,
 				      !READ_ONCE(net->ipv4.sysctl_nexthop_compat_mode));
 
 		spin_lock_bh(&nh->lock);
@@ -2201,7 +2202,7 @@ static void nh_rt_cache_flush(struct net *net, struct nexthop *nh,
 		rt_cache_flush(net);
 
 	list_for_each_entry(f6i, &nh->f6i_list, nh_list)
-		ipv6_stub->fib6_update_sernum(net, f6i);
+		IPV6_CALL(fib6_update_sernum)(net, f6i);
 
 	/* if an IPv6 group was replaced, we have to release all old
 	 * dsts to make sure all refcounts are released
@@ -2215,7 +2216,7 @@ static void nh_rt_cache_flush(struct net *net, struct nexthop *nh,
 		struct nh_info *nhi = rtnl_dereference(nhge->nh->nh_info);
 
 		if (nhi->family == AF_INET6)
-			ipv6_stub->fib6_nh_release_dsts(&nhi->fib6_nh);
+			IPV6_CALL(fib6_nh_release_dsts)(&nhi->fib6_nh);
 	}
 }
 
@@ -2496,7 +2497,7 @@ static void __nexthop_replace_notify(struct net *net, struct nexthop *nh,
 	}
 
 	list_for_each_entry(f6i, &nh->f6i_list, nh_list)
-		ipv6_stub->fib6_rt_update(net, f6i, info);
+		IPV6_CALL(fib6_rt_update)(net, f6i, info);
 }
 
 /* send RTM_NEWROUTE with REPLACE flag set for all FIB entries
@@ -2869,13 +2870,13 @@ static int nh_create_ipv6(struct net *net,  struct nexthop *nh,
 		fib6_cfg.fc_flags |= RTF_GATEWAY;
 
 	/* sets nh_dev if successful */
-	err = ipv6_stub->fib6_nh_init(net, fib6_nh, &fib6_cfg, GFP_KERNEL,
+	err = IPV6_CALL(fib6_nh_init)(net, fib6_nh, &fib6_cfg, GFP_KERNEL,
 				      extack);
 	if (err) {
 		/* IPv6 is not enabled, don't call fib6_nh_release */
 		if (err == -EAFNOSUPPORT)
 			goto out;
-		ipv6_stub->fib6_nh_release(fib6_nh);
+		IPV6_CALL(fib6_nh_release)(fib6_nh);
 	} else {
 		nh->nh_flags = fib6_nh->fib_nh_flags;
 	}
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 6c6b68a66dcd3b3d8f1747fead868c195e04a0a9..d808742d5994bd3d27780e43186d4cf43466745d 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2966,7 +2966,7 @@ static void set_xfrm_gro_udp_encap_rcv(__u16 encap_type, unsigned short family,
 
 	if (udp_test_bit(GRO_ENABLED, sk) && encap_type == UDP_ENCAP_ESPINUDP) {
 		if (IS_ENABLED(CONFIG_IPV6) && family == AF_INET6)
-			new_gro_receive = ipv6_stub->xfrm6_gro_udp_encap_rcv;
+			new_gro_receive = IPV6_CALL(xfrm6_gro_udp_encap_rcv);
 		else
 			new_gro_receive = xfrm4_gro_udp_encap_rcv;
 
@@ -3039,7 +3039,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 #if IS_ENABLED(CONFIG_IPV6)
 			if (sk->sk_family == AF_INET6)
 				WRITE_ONCE(up->encap_rcv,
-					   ipv6_stub->xfrm6_udp_encap_rcv);
+					   IPV6_CALL(xfrm6_udp_encap_rcv));
 			else
 #endif
 				WRITE_ONCE(up->encap_rcv,
diff --git a/net/ipv6/addrconf_core.c b/net/ipv6/addrconf_core.c
index c008d21925d7f4afa31cc55deec0ccc321cdab04..5171bc29397b240505af29c08b8d0176a871c2d5 100644
--- a/net/ipv6/addrconf_core.c
+++ b/net/ipv6/addrconf_core.c
@@ -129,7 +129,8 @@ int inet6addr_validator_notifier_call_chain(unsigned long val, void *v)
 }
 EXPORT_SYMBOL(inet6addr_validator_notifier_call_chain);
 
-static struct dst_entry *eafnosupport_ipv6_dst_lookup_flow(struct net *net,
+#if !defined(CONFIG_IPV6)
+static struct dst_entry *eafnosupport_ip6_dst_lookup_flow(struct net *net,
 							   const struct sock *sk,
 							   struct flowi6 *fl6,
 							   const struct in6_addr *final_dst)
@@ -203,9 +204,11 @@ static struct net_device *eafnosupport_ipv6_dev_find(struct net *net, const stru
 {
 	return ERR_PTR(-EAFNOSUPPORT);
 }
+#endif
 
 const struct ipv6_stub *ipv6_stub __read_mostly = &(struct ipv6_stub) {
-	.ipv6_dst_lookup_flow = eafnosupport_ipv6_dst_lookup_flow,
+#if !defined(CONFIG_IPV6)
+	.ip6_dst_lookup_flow = eafnosupport_ip6_dst_lookup_flow,
 	.ipv6_route_input  = eafnosupport_ipv6_route_input,
 	.fib6_get_table    = eafnosupport_fib6_get_table,
 	.fib6_table_lookup = eafnosupport_fib6_table_lookup,
@@ -214,8 +217,9 @@ const struct ipv6_stub *ipv6_stub __read_mostly = &(struct ipv6_stub) {
 	.ip6_mtu_from_fib6 = eafnosupport_ip6_mtu_from_fib6,
 	.fib6_nh_init	   = eafnosupport_fib6_nh_init,
 	.ip6_del_rt	   = eafnosupport_ip6_del_rt,
-	.ipv6_fragment	   = eafnosupport_ipv6_fragment,
+	.ip6_fragment	   = eafnosupport_ipv6_fragment,
 	.ipv6_dev_find     = eafnosupport_ipv6_dev_find,
+#endif
 };
 EXPORT_SYMBOL_GPL(ipv6_stub);
 
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 23cc9b4cb2f122975e8601f83b36c168784b9041..2c7c52bbd08785c29d1fca351edd2e9e3c811e2e 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -1023,16 +1023,18 @@ static struct pernet_operations inet6_net_ops = {
 	.exit = inet6_net_exit,
 };
 
-static int ipv6_route_input(struct sk_buff *skb)
+int ipv6_route_input(struct sk_buff *skb)
 {
 	ip6_route_input(skb);
 	return skb_dst(skb)->error;
 }
 
 static const struct ipv6_stub ipv6_stub_impl = {
+	.nd_tbl	= &nd_tbl,
+#if !defined(CONFIG_IPV6)
 	.ipv6_sock_mc_join = ipv6_sock_mc_join,
 	.ipv6_sock_mc_drop = ipv6_sock_mc_drop,
-	.ipv6_dst_lookup_flow = ip6_dst_lookup_flow,
+	.ip6_dst_lookup_flow = ip6_dst_lookup_flow,
 	.ipv6_route_input  = ipv6_route_input,
 	.fib6_get_table	   = fib6_get_table,
 	.fib6_table_lookup = fib6_table_lookup,
@@ -1053,10 +1055,10 @@ static const struct ipv6_stub ipv6_stub_impl = {
 	.xfrm6_gro_udp_encap_rcv = xfrm6_gro_udp_encap_rcv,
 	.xfrm6_rcv_encap = xfrm6_rcv_encap,
 #endif
-	.nd_tbl	= &nd_tbl,
-	.ipv6_fragment = ip6_fragment,
+	.ip6_fragment = ip6_fragment,
 	.ipv6_dev_find = ipv6_dev_find,
 	.ip6_xmit = ip6_xmit,
+#endif
 };
 
 static const struct ipv6_bpf_stub ipv6_bpf_stub_impl = {
@@ -1235,7 +1237,7 @@ static int __init inet6_init(void)
 
 	/* ensure that ipv6 stubs are visible only after ipv6 is ready */
 	wmb();
-	ipv6_stub = &ipv6_stub_impl;
+	WRITE_ONCE(ipv6_stub, &ipv6_stub_impl);
 	ipv6_bpf_stub = &ipv6_bpf_stub_impl;
 out:
 	return err;
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 8e2a6b28cea7ae69099859b337c9044caf99e631..315808dc2a07a2cb724cab72fd7878b5c5063a33 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1045,6 +1045,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	kfree_skb(skb);
 	return err;
 }
+EXPORT_SYMBOL_GPL(ip6_fragment);
 
 static inline int ip6_rt_check(const struct rt6key *rt_key,
 			       const struct in6_addr *fl_addr,
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index cef3e021074440adc5c284719fc45f79dffd7dd8..5e2d00efac4aa9050d7d94f1a02a66ebf3ff7244 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -162,8 +162,7 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 	fl6.fl6_dport = dport;
 	fl6.flowlabel = ip6_make_flowinfo(dsfield, key->label);
 
-	dst = ipv6_stub->ipv6_dst_lookup_flow(net, sock->sk, &fl6,
-					      NULL);
+	dst = IPV6_CALL(ip6_dst_lookup_flow)(net, sock->sk, &fl6, NULL);
 	if (IS_ERR(dst)) {
 		netdev_dbg(dev, "no route to %pI6\n", &fl6.daddr);
 		return ERR_PTR(-ENETUNREACH);
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index f6a5d8c73af9721741c11b543e5abeecdbf2079f..dbe41a1fcef1c1d4dfc0cb2ac09e1f4af8a8a3c5 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -576,6 +576,7 @@ void ndisc_send_na(struct net_device *dev, const struct in6_addr *daddr,
 
 	ndisc_send_skb(skb, daddr, src_addr);
 }
+EXPORT_SYMBOL(ndisc_send_na);
 
 static void ndisc_send_unsol_na(struct net_device *dev)
 {
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index ae85a7654b1f6d2871c29e936f582a6faa5d0656..a4e58968af66b8861238b9c7bcf26304088e5261 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -642,7 +642,7 @@ static struct net_device *inet6_fib_lookup_dev(struct net *net,
 
 	memset(&fl6, 0, sizeof(fl6));
 	memcpy(&fl6.daddr, addr, sizeof(struct in6_addr));
-	dst = ipv6_stub->ipv6_dst_lookup_flow(net, NULL, &fl6, NULL);
+	dst = IPV6_CALL(ip6_dst_lookup_flow)(net, NULL, &fl6, NULL);
 	if (IS_ERR(dst))
 		return ERR_CAST(dst);
 
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 792ca44a461da0bb98d49bfe9f233214fb57a61e..e9c9117cd07f2b182de165607f2e008c98bdcad1 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -810,7 +810,7 @@ static void ovs_fragment(struct net *net, struct vport *vport,
 		skb_dst_set_noref(skb, &ovs_rt.dst);
 		IP6CB(skb)->frag_max_size = mru;
 
-		ipv6_stub->ipv6_fragment(net, skb->sk, skb, ovs_vport_output);
+		IPV6_CALL(ip6_fragment)(net, skb->sk, skb, ovs_vport_output);
 		refdst_drop(orig_dst);
 	} else {
 		WARN_ONCE(1, "Failed fragment ->%s: eth=%04x, MRU=%d, MTU=%d.",
diff --git a/net/sched/sch_frag.c b/net/sched/sch_frag.c
index d1d87dce7f3f72e33e3c8ec0c0eb35bdd9b5c9f1..f490c0a5829cbaaea3940d267154002c4879e237 100644
--- a/net/sched/sch_frag.c
+++ b/net/sched/sch_frag.c
@@ -6,6 +6,7 @@
 #include <net/dst.h>
 #include <net/ip.h>
 #include <net/ip6_fib.h>
+#include <net/ip6_route.h>
 
 struct sch_frag_data {
 	unsigned long dst;
@@ -127,8 +128,8 @@ static int sch_fragment(struct net *net, struct sk_buff *skb,
 		skb_dst_set_noref(skb, &sch_frag_rt.dst);
 		IP6CB(skb)->frag_max_size = mru;
 
-		ret = ipv6_stub->ipv6_fragment(net, skb->sk, skb,
-					       sch_frag_xmit);
+		ret = IPV6_CALL(ip6_fragment)(net, skb->sk, skb,
+					      sch_frag_xmit);
 		local_unlock_nested_bh(&sch_frag_data_storage.bh_lock);
 		refdst_drop(orig_dst);
 	} else {
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 2b8e385d1e5141a880e312d4a07963e4b7b3b0a7..10d2ff0ad85071863dff1bef2603eac7e0bdb797 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -207,9 +207,9 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 				.saddr = src->ipv6,
 				.flowi6_proto = IPPROTO_UDP
 			};
-			ndst = ipv6_stub->ipv6_dst_lookup_flow(net,
-							       ub->ubsock->sk,
-							       &fl6, NULL);
+			ndst = IPV6_CALL(ip6_dst_lookup_flow)(net,
+							      ub->ubsock->sk,
+							      &fl6, NULL);
 			if (IS_ERR(ndst)) {
 				err = PTR_ERR(ndst);
 				goto tx_error;
@@ -418,7 +418,7 @@ static int enable_mcast(struct udp_bearer *ub, struct udp_media_addr *remote)
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		lock_sock(sk);
-		err = ipv6_stub->ipv6_sock_mc_join(sk, ub->ifindex,
+		err = IPV6_CALL(ipv6_sock_mc_join)(sk, ub->ifindex,
 						   &remote->ipv6);
 		release_sock(sk);
 #endif
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index e1b11ab59f6ee834bee093e2011f48be6757fde7..714687e39602dd3b891ba72305de14a748f17229 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -43,7 +43,7 @@ static void handle_esp(struct sk_buff *skb, struct sock *sk)
 	local_bh_disable();
 #if IS_ENABLED(CONFIG_IPV6)
 	if (sk->sk_family == AF_INET6)
-		ipv6_stub->xfrm6_rcv_encap(skb, IPPROTO_ESP, 0, TCP_ENCAP_ESPINTCP);
+		IPV6_CALL(xfrm6_rcv_encap)(skb, IPPROTO_ESP, 0, TCP_ENCAP_ESPINTCP);
 	else
 #endif
 		xfrm4_rcv_encap(skb, IPPROTO_ESP, 0, TCP_ENCAP_ESPINTCP);
diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.c
index ebf95d48e86c149ceabd6e059d85d39660df5b8c..7b8f2b23c6b9daf5696659856435189565f51842 100644
--- a/net/xfrm/xfrm_nat_keepalive.c
+++ b/net/xfrm/xfrm_nat_keepalive.c
@@ -98,14 +98,14 @@ static int nat_keepalive_send_ipv6(struct sk_buff *skb,
 	local_lock_nested_bh(&nat_keepalive_sk_ipv6.bh_lock);
 	sk = this_cpu_read(nat_keepalive_sk_ipv6.sock);
 	sock_net_set(sk, net);
-	dst = ipv6_stub->ipv6_dst_lookup_flow(net, sk, &fl6, NULL);
+	dst = IPV6_CALL(ip6_dst_lookup_flow)(net, sk, &fl6, NULL);
 	if (IS_ERR(dst)) {
 		local_unlock_nested_bh(&nat_keepalive_sk_ipv6.bh_lock);
 		return PTR_ERR(dst);
 	}
 
 	skb_dst_set(skb, dst);
-	err = ipv6_stub->ip6_xmit(sk, skb, &fl6, skb->mark, NULL, 0, 0);
+	err = IPV6_CALL(ip6_xmit)(sk, skb, &fl6, skb->mark, NULL, 0, 0);
 	sock_net_set(sk, &init_net);
 	local_unlock_nested_bh(&nat_keepalive_sk_ipv6.bh_lock);
 	return err;
diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index 54222fcbd7fd81d3b90fbf82749285b33d897990..82a68a530a875c9e7031117a7ea69862989bd8f4 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -900,7 +900,7 @@ int xfrm6_tunnel_check_size(struct sk_buff *skb)
 		skb->protocol = htons(ETH_P_IPV6);
 
 		if (xfrm6_local_dontfrag(sk))
-			ipv6_stub->xfrm6_local_rxpmtu(skb, mtu);
+			IPV6_CALL(xfrm6_local_rxpmtu)(skb, mtu);
 		else if (sk)
 			xfrm_local_error(skb, mtu);
 		else
-- 
2.53.0.473.g4a7958ca14-goog


