Return-Path: <netdev+bounces-84779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A003898506
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE1528AB9C
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 10:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408716D1D8;
	Thu,  4 Apr 2024 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="npABHii0"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DF3433AE
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712226728; cv=none; b=bFN1vyVBaSOZdi1oT0S5r15S1TIT32C0QlpYUkEsHxQsh6Gs7DC6kapGr7bfGuJ7bCWyAeU+d11MzmNYznr+RYlhybFhMhvpoClzzgzPdpjcl1pznDTB4qAKityrwQ3anzShR0ptAk8QvNnu9EJXAdK+vU9eHk95gm7ZKWVC3bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712226728; c=relaxed/simple;
	bh=TeJlJDqcGEZYxCd+qsv/45bcsJSawqiZZcu7w3xt4pU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+vRU6cn9SsSBXqEEKXRc7WtFx11VS6DS/+4YkB/pOQ6MlA4XI7NsRmKW8zILSD1Xx6h/zC8i4C8IgIL91O7A7GEurDOoynOKT90nLaJHZY6E4aoWdiCq4bNl0B3aQHUco713e2eS3G1MO0jTuKan3Yw5QexwxWhnfxUfs912nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=npABHii0; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 38F142082B;
	Thu,  4 Apr 2024 12:32:04 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 89lzlrYVdd7O; Thu,  4 Apr 2024 12:32:03 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 73EDB206BC;
	Thu,  4 Apr 2024 12:32:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 73EDB206BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1712226723;
	bh=k3z5fMAu0mVZjR++M7Zw7yKEdt6OtBQLYGlJw9IuYiY=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=npABHii0P4I8cXXTL52ovSYax9oKM6r2dCEGGv/Urm7BIQCIOaRQ4acBKQfYeUkFu
	 aWBfJVUGG54i/sjPX0Xv+0SoFpGagdYVoAxtDYcSGl8Z4lQM111FTW+sfoBAp93Aao
	 1yt6npZbjTcXCXVLrppAjMmkx/Hm8g43tIBUaX8K0Qi8vfdZxajFcPLz5G121u9meO
	 xncBUC1BS99YZSbN52ylZmUrpBnGagMP87V6rzjxg53+Hhxw8rAcCSxyOO1oNANo1h
	 EoevLrfEvJuspdr4rytYHy/olfoaapDGKuQYSc186l9J2EWYexazIi9O2Crgzh6ht2
	 +tXC/TM+8dySQ==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 65B5A80004A;
	Thu,  4 Apr 2024 12:32:03 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 12:32:03 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 4 Apr
 2024 12:32:02 +0200
Date: Thu, 4 Apr 2024 12:31:56 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>, Steffen Klassert
	<steffen.klassert@secunet.com>, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Antony Antony
	<antony.antony@secunet.com>, <devel@linux-ipsec.org>, Tobias Brunner
	<tobias@strongswan.org>
Subject: [PATCH net 1/1] xfrm: fix source address in icmp error generation
 from IPsec gateway
Message-ID: <20ea2ab0472ecf2d1625dadb7ca0df39cf4fe0f5.1712226175.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <cover.1712226175.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1712226175.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)

When enabling support for XFRM lookup using reverse ICMP payload, we
have identified an issue where the source address of the IPv4, e.g.,
"Destination Host Unreachable" message, is incorrect. The error message
received by the sender appears to originate from a 
non-existing/unreachable host.  IPv6 seems to behave correctly; respond 
with an existing source address from the gateway.

Here is example of incorrect source address for ICMP error response.
When sending a ping to an unreachable host, the sender would receive an
ICMP unreachable response with a fake source address. Rather the address
of the host that generated ICMP Unreachable message. This is confusing
and incorrect.

Example:
ping -W 9 -w 5 -c 1 10.1.4.3
PING 10.1.4.3 (10.1.4.3) 56(84) bytes of data.
From 10.1.4.3 icmp_seq=1 Destination Host Unreachable

Notice : packet has the source address of the ICMP "Unreachable host!"

This issue can be traced back to commit
415b3334a21a ("icmp: Fix regression in nexthop resolution during replies.")
which introduced a change that copied the source address from the ICMP
payload.

This commit would force to use source address from the gatway/host.
The ICMP error message source address correctly set from the host.

After fixing:
ping -W 5 -c 1 10.1.4.3
PING 10.1.4.3 (10.1.4.3) 56(84) bytes of data.
From 10.1.3.2 icmp_seq=1 Destination Host Unreachable

Here is an snippt to reporduce the issue.

export AB="10.1"
for i in 1 2 3 4 5; do
        h="host${i}"
        ip netns add ${h}
        ip -netns ${h} link set lo up
        ip netns exec ${h} sysctl -wq net.ipv4.ip_forward=1
        if [ $i -lt 5 ]; then
                ip -netns ${h} link add eth0 type veth peer name eth10${i}
                ip -netns ${h} addr add "${AB}.${i}.1/24" dev eth0
                ip -netns ${h} link set up dev eth0
        fi
done

for i in 1 2 3 4 5; do
        h="host${i}"
        p=$((i - 1))
        ph="host${p}"
        # connect to previous host
        if [ $i -gt 1 ]; then
                ip -netns ${ph} link set eth10${p} netns ${h}
                ip -netns ${h} link set eth10${p} name eth1
                ip -netns ${h} link set up dev eth1
                ip -netns ${h} addr add "${AB}.${p}.2/24" dev eth1
        fi
        # add forward routes
        for k in $(seq ${i} $((5 - 1))); do
                ip -netns ${h} route 2>/dev/null | (grep "${AB}.${k}.0" 2>/dev/null) || \
                ip -netns ${h} route add "${AB}.${k}.0/24" via "${AB}.${i}.2" 2>/dev/nul
        done

        # add reverse routes
        for k in $(seq 1 $((i - 2))); do
                ip -netns ${h} route 2>/dev/null | grep "${AB}.${k}.0" 2>/dev/null || \
                ip -netns ${h} route add "${AB}.${k}.0/24" via "${AB}.${p}.1" 2>/dev/nul
        done
done

ip netns exec host1 ping -q -W 2 -w 1 -c 1 10.1.4.2 2>&1>/dev/null && echo "success 10.1.4.2 reachable" || echo "ERROR"
ip netns exec host1 ping -W 9 -w 5 -c 1 10.1.4.3 || echo  "note the source address of unreachble of gateway"
ip -netns host1 route flush cache

ip netns exec host3 nft add table inet filter
ip netns exec host3 nft add chain inet filter FORWARD { type filter hook forward priority filter\; policy drop \; }
ip netns exec host3 nft add rule inet filter FORWARD counter ip protocol icmp drop
ip netns exec host3 nft add rule inet filter FORWARD counter ip protocol esp accept
ip netns exec host3 nft add rule inet filter FORWARD counter drop

ip -netns host2 xfrm policy add src 10.1.1.0/24 dst 10.1.4.0/24 dir out \
        flag icmp tmpl src 10.1.2.1 dst 10.1.3.2 proto esp reqid 1 mode tunnel

ip -netns host2 xfrm policy add src 10.1.4.0/24 dst 10.1.1.0/24 dir in \
        tmpl src 10.1.3.2 dst 10.1.2.1 proto esp reqid 2 mode tunnel

ip -netns host2 xfrm policy add src 10.1.4.0/24 dst 10.1.1.0/24 dir fwd \
        flag icmp tmpl src 10.1.3.2 dst 10.1.2.1 proto esp reqid 2 mode tunnel

ip -netns host2 xfrm state add src 10.1.2.1 dst 10.1.3.2 proto esp spi 1 \
        reqid 1 replay-window 1  mode tunnel aead 'rfc4106(gcm(aes))' \
        0x1111111111111111111111111111111111111111 96 \
        sel src 10.1.1.0/24 dst 10.1.4.0/24

ip -netns host2 xfrm state add src 10.1.3.2 dst 10.1.2.1 proto esp spi 2 \
        flag icmp reqid 2 replay-window 10 mode tunnel aead 'rfc4106(gcm(aes))' \
        0x2222222222222222222222222222222222222222 96

ip -netns host4 xfrm policy add src 10.1.4.0/24 dst 10.1.1.0/24 dir out \
        flag icmp tmpl src 10.1.3.2 dst 10.1.2.1 proto esp reqid 1 mode tunnel

ip -netns host4 xfrm policy add src 10.1.1.0/24 dst 10.1.4.0/24 dir in \
        tmpl src 10.1.2.1 dst 10.1.3.2 proto esp reqid 2  mode tunnel

ip -netns host4 xfrm policy add src 10.1.1.0/24 dst 10.1.4.0/24 dir fwd \
                flag icmp tmpl src 10.1.2.1 dst 10.1.3.2 proto esp reqid 2 mode tunnel

ip -netns host4 xfrm state add src 10.1.3.2 dst 10.1.2.1 proto esp spi 2 \
        reqid 1 replay-window 1 mode tunnel aead 'rfc4106(gcm(aes))' \
        0x2222222222222222222222222222222222222222 96

ip -netns host4 xfrm state add src 10.1.2.1 dst 10.1.3.2 proto esp spi 1 \
        reqid 2 replay-window 20 flag icmp  mode tunnel aead 'rfc4106(gcm(aes))' \
        0x1111111111111111111111111111111111111111 96 \
        sel src 10.1.1.0/24 dst 10.1.4.0/24

ip netns exec host1 ping -W 5 -c 1 10.1.4.2 2>&1 > /dev/null && echo ""
ip netns exec host1 ping -W 5 -c 1 10.1.4.3 || echo "note source address of gateway 10.1.3.2"

Again before the fix
ping -W 5 -c 1 10.1.4.3
From 10.1.4.3 icmp_seq=1 Destination Host Unreachable

After the fix
From 10.1.3.2 icmp_seq=1 Destination Host Unreachable

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/ipv4/icmp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index e63a3bf99617..bec234637122 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -555,7 +555,6 @@ static struct rtable *icmp_route_lookup(struct net *net,
 					    XFRM_LOOKUP_ICMP);
 	if (!IS_ERR(rt2)) {
 		dst_release(&rt->dst);
-		memcpy(fl4, &fl4_dec, sizeof(*fl4));
 		rt = rt2;
 	} else if (PTR_ERR(rt2) == -EPERM) {
 		if (rt)
--
2.30.2


