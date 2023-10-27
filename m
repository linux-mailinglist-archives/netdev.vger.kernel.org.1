Return-Path: <netdev+bounces-44670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 836357D90E9
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39368281966
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 08:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF2A134BE;
	Fri, 27 Oct 2023 08:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A45FFC04
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 08:17:03 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E861AA
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 01:17:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 3DAAF20758;
	Fri, 27 Oct 2023 10:17:00 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pYK-HQZRXMsq; Fri, 27 Oct 2023 10:16:59 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 8E142206DF;
	Fri, 27 Oct 2023 10:16:59 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 8B72B80004A;
	Fri, 27 Oct 2023 10:16:59 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 27 Oct 2023 10:16:59 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 27 Oct
 2023 10:16:59 +0200
Date: Fri, 27 Oct 2023 10:16:52 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Antony Antony
	<antony.antony@secunet.com>, "David S. Miller" <davem@davemloft.net>,
	<devel@linux-ipsec.org>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 ipsec-next 2/2] xfrm: fix source address in icmp error
 generation from IPsec gateway
Message-ID: <300c36a0644b63228cee8d0a74be0e1e81d0fe98.1698394516.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <e9b8e0f951662162cc761ee5473be7a3f54183a7.1639872656.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e9b8e0f951662162cc761ee5473be7a3f54183a7.1639872656.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

When enabling support for xfrm lookup using reverse ICMP payload,
We have identified an issue where the source address of the IPv4 e.g
"Destination Host Unreachable" message is incorrect. The IPv6 appear
to do the right thing.

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

Here is an example to reporduce:

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
ip netns exec host1 ping -W 9 -w 5 -c 1 10.1.4.3 || echo  "note the source address of unreachble"
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
ip netns exec host1 ping -W 5 -c 1 10.1.4.3 || echo "note source address"

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


