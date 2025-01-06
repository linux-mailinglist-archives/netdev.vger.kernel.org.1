Return-Path: <netdev+bounces-155405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA365A02363
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 11:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776B73A485E
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 10:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B201DAC80;
	Mon,  6 Jan 2025 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ZB6yQ7B7"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D841D9353
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 10:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736160476; cv=none; b=fTnLZy6dDUnLqBbu/CZMZHLGTIgiWMfaCQhvyOqd/AONiU8uLbKtezDLmb4lacBTwOhjls/550gBPO9kRcM0jT3y81XWeGTHCVDw0vXi+Z2YXPeQlGP0G/XO8UIRWIzRuduFKpmlXnKefjAetiJ4CwBpWhE7YptBhhIeEDA8N9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736160476; c=relaxed/simple;
	bh=BKk9qe1PxjFeSw8mK2dqClvBnAP1949uCTMXbeOxnpY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R47TEgNeGClNUFLmnkvOXzbb325x79ITQ9O2WsqmgL3x+UQ0j9O8JQ9ksE+xSMRaL8NLwa5NzMnk5TMvbZx5ztSBRf0Huzav65uab9l1QP117iW3TLJrP5RoofLePFV9LSUx8oAhcN9a3um11nNIDt8JviEftsWl74irfmOtASc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ZB6yQ7B7; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id B3DD0206DF;
	Mon,  6 Jan 2025 11:41:33 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EGsiM3-LLHoW; Mon,  6 Jan 2025 11:41:33 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 053FD206D0;
	Mon,  6 Jan 2025 11:41:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 053FD206D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1736160093;
	bh=ZlmFhM9DP3p7/Fli3dGNGy7oAZ4JpUqVDZdG0//DPGc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=ZB6yQ7B7uYrUZfyAXq/smJUr7/1hlfaM9i0esXXU9A8PR4aagUt5dBHf4QV/K9sRA
	 e7/Qgs01BnowOsmE/nUPWdchKbGS/dheX7A4QpMhc0ze46IK72Fbpezl1INUO7PFeA
	 eDtkhRh7+R1enhvW0hqTqlHpSS68e9YkoPzmNOYLS+ceguYVkgQ66wamCsWb7qDes2
	 V3/kgwDbgPbXvhg1IyX5SoU7iVLmFtrvqr45IGcoM5c+TPzuFyFjzXJzKdl6C9YXrw
	 Fjbt3R66LenikHSey4WXBH8QOXfB3MG6WcjuwjuhDWtUhdFEENUEFQQMQfY1juzou7
	 QRju/L+Dq5kBA==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 6 Jan 2025 11:41:32 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 11:41:32 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 55DC23180647; Mon,  6 Jan 2025 11:41:32 +0100 (CET)
Date: Mon, 6 Jan 2025 11:41:32 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Eric Dumazet <edumazet@google.com>
CC: Shahar Shitrit <shshitrit@nvidia.com>, "brianvv@google.com"
	<brianvv@google.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "kuniyu@amazon.com" <kuniyu@amazon.com>,
	"martin.lau@kernel.org" <martin.lau@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Ziyad Atiyyeh <ziyadat@nvidia.com>, "Dror
 Tennenbaum" <drort@nvidia.com>
Subject: Re: [PATCH v3 net-next 4/5] ipv6: tcp: give socket pointer to
 control skbs
Message-ID: <Z3uzXOzV1T3Uv4f+@gauss3.secunet.de>
References: <CY5PR12MB63224DE8AEEC1A2410E65466DA3B2@CY5PR12MB6322.namprd12.prod.outlook.com>
 <CANn89iL8ihnVyi+g1aKNu3=BJCQoRv4_s29OvVSXBBQdOM4foQ@mail.gmail.com>
 <CANn89iKAZsG=RepuJmStFTH2QK+N5s9Cu=OnD2GmQAb1JKCfeQ@mail.gmail.com>
 <Z2KHMLJ4oTUwgBSo@gauss3.secunet.de>
 <CANn89iJGYFzHi7eUQo49hmo0eTZzHvDTTqKXTxrSZvKKJXHa7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJGYFzHi7eUQo49hmo0eTZzHvDTTqKXTxrSZvKKJXHa7g@mail.gmail.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Dec 18, 2024 at 10:04:19AM +0100, Eric Dumazet wrote:
> On Wed, Dec 18, 2024 at 9:26 AM Steffen Klassert
> <steffen.klassert@secunet.com> wrote:
> >
> > Can you provide a bit more context? I don't see the problem.
> 
> 
> skb->sk is used in xfrm, and the assumption is that it is a full socket.
> 
> List of things that are supported, even for timewait and
> request_sockets, and used in xfrm:
> 
> sk->sk_bound_dev_if
> sock_net(skb->sk)
> inet_sk(sk)->inet_dport;
> 
> But xfrmi_xmit2() for instance is doing :
> 
> err = dst_output(xi->net, skb->sk, skb);
> 
> Other dst_output() users use : dst_output(net, sk, skb), because sk
> can be different than skb->sk
> 
> Also xfrm6_local_dontfrag() is assuming sk is an inet6 socket:
> 
> if (proto == IPPROTO_UDP || proto == IPPROTO_RAW)
>      return inet6_test_bit(DONTFRAG, sk);
> 
> xfrm_lookup_with_ifid() seems ok (it uses sk_const_to_full_sk()), but
> we probably miss some fixes.

Thanks for the explanation!

I did a first audit of the xfrm stack to find the problematic
skb->sk usages. The result is the (still untested) patch below.
I need to go over it again to make sure I found everyting.

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index f3281312eb5e..8cf5f6634775 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -279,7 +279,7 @@ static void esp_output_done(void *data, int err)
 		    x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
 			esp_output_tail_tcp(x, skb);
 		else
-			xfrm_output_resume(skb->sk, skb, err);
+			xfrm_output_resume(skb_to_full_sk(skb), skb, err);
 	}
 }
 
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index b2400c226a32..fad4d7c9fa50 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -315,7 +315,7 @@ static void esp_output_done(void *data, int err)
 		    x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
 			esp_output_tail_tcp(x, skb);
 		else
-			xfrm_output_resume(skb->sk, skb, err);
+			xfrm_output_resume(skb_to_full_sk(skb), skb, err);
 	}
 }
 
diff --git a/net/ipv6/xfrm6_output.c b/net/ipv6/xfrm6_output.c
index 5f7b1fdbffe6..b3d5d1f266ee 100644
--- a/net/ipv6/xfrm6_output.c
+++ b/net/ipv6/xfrm6_output.c
@@ -82,14 +82,14 @@ static int __xfrm6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 	toobig = skb->len > mtu && !skb_is_gso(skb);
 
-	if (toobig && xfrm6_local_dontfrag(skb->sk)) {
+	if (toobig && xfrm6_local_dontfrag(sk)) {
 		xfrm6_local_rxpmtu(skb, mtu);
 		kfree_skb(skb);
 		return -EMSGSIZE;
 	} else if (toobig && xfrm6_noneed_fragment(skb)) {
 		skb->ignore_df = 1;
 		goto skip_frag;
-	} else if (!skb->ignore_df && toobig && skb->sk) {
+	} else if (!skb->ignore_df && toobig && sk) {
 		xfrm_local_error(skb, mtu);
 		kfree_skb(skb);
 		return -EMSGSIZE;
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 98f1e2b67c76..c397eb99d867 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -506,7 +506,7 @@ xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 	skb_dst_set(skb, dst);
 	skb->dev = tdev;
 
-	err = dst_output(xi->net, skb->sk, skb);
+	err = dst_output(xi->net, skb_to_full_sk(skb), skb);
 	if (net_xmit_eval(err) == 0) {
 		dev_sw_netstats_tx_add(dev, 1, length);
 	} else {
diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index e5722c95b8bb..1fb4dc0a76e1 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -796,7 +796,7 @@ static int xfrm4_tunnel_check_size(struct sk_buff *skb)
 	     !skb_gso_validate_network_len(skb, ip_skb_dst_mtu(skb->sk, skb)))) {
 		skb->protocol = htons(ETH_P_IP);
 
-		if (skb->sk)
+		if (skb->sk && sk_fullsock(skb->sk))
 			xfrm_local_error(skb, mtu);
 		else
 			icmp_send(skb, ICMP_DEST_UNREACH,
@@ -832,6 +832,7 @@ static int xfrm6_tunnel_check_size(struct sk_buff *skb)
 {
 	int mtu, ret = 0;
 	struct dst_entry *dst = skb_dst(skb);
+	struct sock *sk = skb_to_full_sk(skb);
 
 	if (skb->ignore_df)
 		goto out;
@@ -846,9 +847,9 @@ static int xfrm6_tunnel_check_size(struct sk_buff *skb)
 		skb->dev = dst->dev;
 		skb->protocol = htons(ETH_P_IPV6);
 
-		if (xfrm6_local_dontfrag(skb->sk))
+		if (xfrm6_local_dontfrag(sk))
 			ipv6_stub->xfrm6_local_rxpmtu(skb, mtu);
-		else if (skb->sk)
+		else if (sk)
 			xfrm_local_error(skb, mtu);
 		else
 			icmpv6_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu);
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 4408c11c0835..c27da1fd070e 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2959,7 +2959,7 @@ static void xfrm_policy_queue_process(struct timer_list *t)
 		skb_dst_drop(skb);
 		skb_dst_set(skb, dst);
 
-		dst_output(net, skb->sk, skb);
+		dst_output(net, skb_to_full_sk(skb), skb);
 	}
 
 out:

