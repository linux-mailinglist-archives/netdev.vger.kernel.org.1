Return-Path: <netdev+bounces-182723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53838A89C43
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8171891BE9
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A754E2C17B7;
	Tue, 15 Apr 2025 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b="dXl25H+z"
X-Original-To: netdev@vger.kernel.org
Received: from mail.codelabs.ch (mail.codelabs.ch [109.202.192.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2E02918E3
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 11:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.202.192.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715954; cv=none; b=DsgerB7k2JvB4e7ZZIQvZ7ODcILI3jZ2dDEwRfqTcG2c9/4l+bDqQ8hPEtxGluqA5La12l71CT8zue+FHv5NbdpEBNmttkpuTbtswced2EQNlDACx+WdR7x+nn4WWYRAugkL9SGlV4CnlZwZV2M6o4kqChxUA7Bz3AYK3AC9d9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715954; c=relaxed/simple;
	bh=RZlCu175uFL9a//hKaiw2Y1xSDrV3RahZOeZJENru7M=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=Iz6ZvLHmWlR6sc4ihSKE6V7o07p3Qo6w07WBhSBeLty+b8etVMfA09R3R4FtEpYU5DwLBOWzkHebFDWqE0s9LQkTdZNv4vvFCTlq6LmoDSVRKqwcpd4SUHrMrcpEdJ0gIktR4NvJxiaP8VVbLEvVo8uLo5X0/W4KAwVU/tDpNo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org; spf=pass smtp.mailfrom=strongswan.org; dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b=dXl25H+z; arc=none smtp.client-ip=109.202.192.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strongswan.org
Received: from localhost (localhost [127.0.0.1])
	by mail.codelabs.ch (Postfix) with ESMTP id E48E25A0004;
	Tue, 15 Apr 2025 13:13:19 +0200 (CEST)
Received: from mail.codelabs.ch ([127.0.0.1])
 by localhost (fenrir.codelabs.ch [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ERwiawREVumD; Tue, 15 Apr 2025 13:13:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=strongswan.org;
	s=default; t=1744715598;
	bh=RZlCu175uFL9a//hKaiw2Y1xSDrV3RahZOeZJENru7M=;
	h=Date:From:To:Cc:Subject:From;
	b=dXl25H+zgcftF4PYHAsAytpE2yjpfAWqZXjxi9O/Yyo1h6vtp2DkTypUP3SBa54ZD
	 EmPNwdF7ibCYjYs4A7b1hRVnXxbouAL+Yr6AOWe0aN9BCCSL20zzbqjMqRTHGLtLG2
	 2MYfJZouza/dbZMZIhpanqhigfuBL9JU2/FCPzxebgu6ycG8im3IYyO7RIexTnThS1
	 wk5Aj3Vmg1iC0EM6AgzM3tvmgrc50JYrrEBzEd9aSta4bSVHwtNo2jNkFTt5qIcctR
	 vsV5JWY/VjYsSoJQJWMtDBuI9XC5o/5bYDx+BsJN9wMitMhduyzNX4/voPWBFw/LYH
	 +HN/luNt2lQdA==
Received: from [IPV6:2a01:8b81:5400:f500:a878:5f67:3cae:afad] (unknown [IPv6:2a01:8b81:5400:f500:a878:5f67:3cae:afad])
	by mail.codelabs.ch (Postfix) with ESMTPSA id C43075A0003;
	Tue, 15 Apr 2025 13:13:18 +0200 (CEST)
Message-ID: <c08a77a7-dac9-424d-8dcd-7207a1191e9b@strongswan.org>
Date: Tue, 15 Apr 2025 13:13:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tobias Brunner <tobias@strongswan.org>
Content-Language: de-CH, en-US
To: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 =?UTF-8?B?4oCcRGF2aWQgUy4gTWlsbGVy4oCd?= <davem@davemloft.net>
Cc: netdev@vger.kernel.org, devel@linux-ipsec.org
Autocrypt: addr=tobias@strongswan.org; keydata=
 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
 tvkh7XWO2ycrW1UlzUzM4KV3SDLIhfOU
Subject: [PATCH ipsec] xfrm: Fix UDP GRO handling for some corner cases
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This fixes an issue that's caused if there is a mismatch between the data
offset in the GRO header and the length fields in the regular sk_buff due
to the pskb_pull()/skb_push() calls.  That's because the UDP GRO layer
stripped off the UDP header via skb_gro_pull() already while the UDP
header was explicitly not pulled/pushed in this function.

For example, an IKE packet that triggered this had len=data_len=1268 and
the data_offset in the GRO header was 28 (IPv4 + UDP).  So pskb_pull()
was called with an offset of 28-8=20, which reduced len to 1248 and via
pskb_may_pull() and __pskb_pull_tail() it also set data_len to 1248.
As the ESP offload module was not loaded, the function bailed out and
called skb_push(), which restored len to 1268, however, data_len remained
at 1248.

So while skb_headlen() was 0 before, it was now 20.  The latter caused a
difference of 8 instead of 28 (or 0 if pskb_pull()/skb_push() was called
with the complete GRO data_offset) in gro_try_pull_from_frag0() that
triggered a call to gro_pull_from_frag0() that corrupted the packet.

This change uses a more GRO-like approach seen in other GRO receivers
via skb_gro_header() to just read the actual data we are interested in
and does not try to "restore" the UDP header at this point to call the
existing function.  If the offload module is not loaded, it immediately
bails out, otherwise, it only does a quick check to see if the packet
is an IKE or keepalive packet instead of calling the existing function.

Fixes: 172bf009c18d ("xfrm: Support GRO for IPv4 ESP in UDP encapsulation")
Fixes: 221ddb723d90 ("xfrm: Support GRO for IPv6 ESP in UDP encapsulation")
Signed-off-by: Tobias Brunner <tobias@strongswan.org>
---
 net/ipv4/xfrm4_input.c | 18 ++++++++++--------
 net/ipv6/xfrm6_input.c | 18 ++++++++++--------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index b5b06323cfd9..0d31a8c108d4 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -182,11 +182,15 @@ struct sk_buff *xfrm4_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
 	int offset = skb_gro_offset(skb);
 	const struct net_offload *ops;
 	struct sk_buff *pp = NULL;
-	int ret;
-
-	offset = offset - sizeof(struct udphdr);
+	int len, dlen;
+	__u8 *udpdata;
+	__be32 *udpdata32;
 
-	if (!pskb_pull(skb, offset))
+	len = skb->len - offset;
+	dlen = offset + min(len, 8);
+	udpdata = skb_gro_header(skb, dlen, offset);
+	udpdata32 = (__be32 *)udpdata;
+	if (unlikely(!udpdata))
 		return NULL;
 
 	rcu_read_lock();
@@ -194,11 +198,10 @@ struct sk_buff *xfrm4_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
 	if (!ops || !ops->callbacks.gro_receive)
 		goto out;
 
-	ret = __xfrm4_udp_encap_rcv(sk, skb, false);
-	if (ret)
+	/* check if it is a keepalive or IKE packet */
+	if (len <= sizeof(struct ip_esp_hdr) || udpdata32[0] == 0)
 		goto out;
 
-	skb_push(skb, offset);
 	NAPI_GRO_CB(skb)->proto = IPPROTO_UDP;
 
 	pp = call_gro_receive(ops->callbacks.gro_receive, head, skb);
@@ -208,7 +211,6 @@ struct sk_buff *xfrm4_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
 
 out:
 	rcu_read_unlock();
-	skb_push(skb, offset);
 	NAPI_GRO_CB(skb)->same_flow = 0;
 	NAPI_GRO_CB(skb)->flush = 1;
 
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 4abc5e9d6322..841c81abaaf4 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -179,14 +179,18 @@ struct sk_buff *xfrm6_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
 	int offset = skb_gro_offset(skb);
 	const struct net_offload *ops;
 	struct sk_buff *pp = NULL;
-	int ret;
+	int len, dlen;
+	__u8 *udpdata;
+	__be32 *udpdata32;
 
 	if (skb->protocol == htons(ETH_P_IP))
 		return xfrm4_gro_udp_encap_rcv(sk, head, skb);
 
-	offset = offset - sizeof(struct udphdr);
-
-	if (!pskb_pull(skb, offset))
+	len = skb->len - offset;
+	dlen = offset + min(len, 8);
+	udpdata = skb_gro_header(skb, dlen, offset);
+	udpdata32 = (__be32 *)udpdata;
+	if (unlikely(!udpdata))
 		return NULL;
 
 	rcu_read_lock();
@@ -194,11 +198,10 @@ struct sk_buff *xfrm6_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
 	if (!ops || !ops->callbacks.gro_receive)
 		goto out;
 
-	ret = __xfrm6_udp_encap_rcv(sk, skb, false);
-	if (ret)
+	/* check if it is a keepalive or IKE packet */
+	if (len <= sizeof(struct ip_esp_hdr) || udpdata32[0] == 0)
 		goto out;
 
-	skb_push(skb, offset);
 	NAPI_GRO_CB(skb)->proto = IPPROTO_UDP;
 
 	pp = call_gro_receive(ops->callbacks.gro_receive, head, skb);
@@ -208,7 +211,6 @@ struct sk_buff *xfrm6_gro_udp_encap_rcv(struct sock *sk, struct list_head *head,
 
 out:
 	rcu_read_unlock();
-	skb_push(skb, offset);
 	NAPI_GRO_CB(skb)->same_flow = 0;
 	NAPI_GRO_CB(skb)->flush = 1;
 
-- 
2.43.0


