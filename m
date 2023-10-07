Return-Path: <netdev+bounces-38770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB927BC66E
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 11:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FBEA281D88
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 09:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BBF168DE;
	Sat,  7 Oct 2023 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OfKuyt06"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194A0168BA
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 09:28:33 +0000 (UTC)
X-Greylist: delayed 379 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 07 Oct 2023 02:28:32 PDT
Received: from out-205.mta0.migadu.com (out-205.mta0.migadu.com [91.218.175.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903B8B9
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 02:28:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1696670531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S5S6Bq/7hDO06XukKZO/A8hT6aAJLIcw9FkCCFsFcrU=;
	b=OfKuyt06uvla2JwmSaRP6rudbR3SVvhlLJS3/RFt0oaL6UFITpEI7c7wxH1VGk48Jug7PV
	ZRRM7b1W9+PJHRo2D5CJSKYEBGklbiR4pM05SxfFbYcN6IbzL48q+qW9671+bMC83p7KyU
	8cR2jNKbHq8RnPM8N7CpJ4i2gTLAwdw=
From: George Guo <dongtai.guo@linux.dev>
To: edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH] tcp: fix secure_{tcp, tcpv6}_ts_off call parameter order mistake
Date: Sat,  7 Oct 2023 17:23:37 +0800
Message-Id: <20231007092337.1540036-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: George Guo <guodongtai@kylinos.cn>

Fix secure_tcp_ts_off and secure_tcpv6_ts_off call parameter order mistake

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 net/ipv4/syncookies.c | 4 ++--
 net/ipv4/tcp_ipv4.c   | 2 +-
 net/ipv6/syncookies.c | 4 ++--
 net/ipv6/tcp_ipv6.c   | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index dc478a0574cb..537f368a0b66 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -360,8 +360,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 
 	if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
 		tsoff = secure_tcp_ts_off(sock_net(sk),
-					  ip_hdr(skb)->daddr,
-					  ip_hdr(skb)->saddr);
+					  ip_hdr(skb)->saddr,
+					  ip_hdr(skb)->daddr);
 		tcp_opt.rcv_tsecr -= tsoff;
 	}
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 27140e5cdc06..3d6c9b286b5a 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -104,7 +104,7 @@ static u32 tcp_v4_init_seq(const struct sk_buff *skb)
 
 static u32 tcp_v4_init_ts_off(const struct net *net, const struct sk_buff *skb)
 {
-	return secure_tcp_ts_off(net, ip_hdr(skb)->daddr, ip_hdr(skb)->saddr);
+	return secure_tcp_ts_off(net, ip_hdr(skb)->saddr, ip_hdr(skb)->daddr);
 }
 
 int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 5014aa663452..9af484a4d518 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -162,8 +162,8 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 
 	if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
 		tsoff = secure_tcpv6_ts_off(sock_net(sk),
-					    ipv6_hdr(skb)->daddr.s6_addr32,
-					    ipv6_hdr(skb)->saddr.s6_addr32);
+					    ipv6_hdr(skb)->saddr.s6_addr32,
+					    ipv6_hdr(skb)->daddr.s6_addr32);
 		tcp_opt.rcv_tsecr -= tsoff;
 	}
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 3a88545a265d..ce9cc4c43cf2 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -119,8 +119,8 @@ static u32 tcp_v6_init_seq(const struct sk_buff *skb)
 
 static u32 tcp_v6_init_ts_off(const struct net *net, const struct sk_buff *skb)
 {
-	return secure_tcpv6_ts_off(net, ipv6_hdr(skb)->daddr.s6_addr32,
-				   ipv6_hdr(skb)->saddr.s6_addr32);
+	return secure_tcpv6_ts_off(net, ipv6_hdr(skb)->saddr.s6_addr32,
+				   ipv6_hdr(skb)->daddr.s6_addr32);
 }
 
 static int tcp_v6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
-- 
2.34.1


