Return-Path: <netdev+bounces-140061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 283229B5232
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACFC41F2468A
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 18:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DE3206E9C;
	Tue, 29 Oct 2024 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b="PZ0AnZCx"
X-Original-To: netdev@vger.kernel.org
Received: from qs51p00im-qukt01080101.me.com (qs51p00im-qukt01080101.me.com [17.57.155.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F6A1FF7B9
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730228059; cv=none; b=kmcTx3mgdT16IXNUEPWjh8EqqNVC6J7SHSlYl6GI7NSRmLQnWoyo3Gic5ERBeELf7kT7mv/TehDgygMEISHDTL36yHypTEqHCtBImO5YHGE88RJU/TQcZXWs145wKOx5HTSUEyoOqmn+WemrO1UMuimiKP0Un5/Q7Y8OLsUuGz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730228059; c=relaxed/simple;
	bh=ckbsHEzwnu5wXLc8QplViBPt7ixtAnXZvH1uZTq3cB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T6H2BJioigx86dRD3wshC1TFSk7wLowjbMyMkBH7kXQ9YleBLvaHT11gldBmF6QfkNxr/BW9ljc+EX57KuxhkZyc5bunvc9+ok1cbZisn0dGhpXj3u6krSyNI3pwbBEGBJRFHg62uYDmpCj1ff78z4ECU1+z7zdFVLIhIwENqQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=PZ0AnZCx; arc=none smtp.client-ip=17.57.155.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verdict.gg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1;
	t=1730228054; bh=+GXo77iF382n05S8NDeFUX1ji3TOpY0hD35XJskg4W4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=PZ0AnZCxV6BLapSItF69iJIE7Ht/G12ZeQS+wtxHfVE2vebTdJiHMnyXmac9Pjdgj
	 opf5Z6sgESgu7OcUfD38WqNed+hu8d9z90hLga7l3dtnzHltSOu6A2f9dpAvhQAjrW
	 3Vw9bIISmXMtR2BQP3MIdI6YROhggT38DhD/jqlm888TvPmh5wZ75NmSKcmuWJaOfU
	 DD6nAJrVvTwURiK1wTz9NYqlgRrMW+4IgAgliWknkk4kJoeR/1vPPr7VihfTL8P9Xj
	 LNKtLwWtOxEjj4p2hvy+lyw6CBHwak4UJgfTiucRhPCD0cWeJjQr6EPNAWrd3qtxTu
	 aZcDNPWkk+MuQ==
Received: from ubuntu-std3-4-8-100gb.. (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01080101.me.com (Postfix) with ESMTPSA id 3219C6180405;
	Tue, 29 Oct 2024 18:54:13 +0000 (UTC)
From: Vladimir Vdovin <deliran@verdict.gg>
To: netdev@vger.kernel.org,
	dsahern@kernel.org,
	davem@davemloft.net
Cc: Vladimir Vdovin <deliran@verdict.gg>
Subject: [PATCH v2] net: ipv4: Cache pmtu for all packet paths if multipath enabled
Date: Tue, 29 Oct 2024 18:46:45 +0000
Message-ID: <20241029185350.304763-1-deliran@verdict.gg>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kALREeiLoM55vl-zzaPrHm0JpPsmosTU
X-Proofpoint-GUID: kALREeiLoM55vl-zzaPrHm0JpPsmosTU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_14,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410290142

Check number of paths by fib_info_num_path(),
and update_or_create_fnhe() for every path.
Problem is that pmtu is cached only for the oif
that has received icmp message "need to frag",
other oifs will still try to use "default" iface mtu.

V2:
  - fix fib_info_num_path parameter pass

An example topology showing the problem:

                    |  host1
                +---------+
                |  dummy0 | 10.179.20.18/32  mtu9000
                +---------+
        +-----------+----------------+
    +---------+                     +---------+
    | ens17f0 |  10.179.2.141/31    | ens17f1 |  10.179.2.13/31
    +---------+                     +---------+
        |    (all here have mtu 9000)    |
    +------+                         +------+
    | ro1  |  10.179.2.140/31        | ro2  |  10.179.2.12/31
    +------+                         +------+
        |                                |
---------+------------+-------------------+------
                        |
                    +-----+
                    | ro3 | 10.10.10.10  mtu1500
                    +-----+
                        |
    ========================================
                some networks
    ========================================
                        |
                    +-----+
                    | eth0| 10.10.30.30  mtu9000
                    +-----+
                        |  host2

host1 have enabled multipath and
sysctl net.ipv4.fib_multipath_hash_policy = 1:

default proto static src 10.179.20.18
        nexthop via 10.179.2.12 dev ens17f1 weight 1
        nexthop via 10.179.2.140 dev ens17f0 weight 1

When host1 tries to do pmtud from 10.179.20.18/32 to host2,
host1 receives at ens17f1 iface an icmp packet from ro3 that ro3 mtu=1500.
And host1 caches it in nexthop exceptions cache.

Problem is that it is cached only for the iface that has received icmp,
and there is no way that ro3 will send icmp msg to host1 via another path.

Host1 now have this routes to host2:

ip r g 10.10.30.30 sport 30000 dport 443
10.10.30.30 via 10.179.2.12 dev ens17f1 src 10.179.20.18 uid 0
    cache expires 521sec mtu 1500

ip r g 10.10.30.30 sport 30033 dport 443
10.10.30.30 via 10.179.2.140 dev ens17f0 src 10.179.20.18 uid 0
    cache

So when host1 tries again to reach host2 with mtu>1500,
if packet flow is lucky enough to be hashed with oif=ens17f1 its ok,
if oif=ens17f0 it blackholes and still gets icmp msgs from ro3 to ens17f1,
until lucky day when ro3 will send it through another flow to ens17f0.

Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
---
 net/ipv4/route.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 723ac9181558..cbb2e22510ce 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1027,10 +1027,23 @@ static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 		struct fib_nh_common *nhc;
 
 		fib_select_path(net, &res, fl4, NULL);
+#ifdef CONFIG_IP_ROUTE_MULTIPATH
+		if (fib_info_num_path(res.fi) > 1) {
+			int nhsel;
+
+			for (nhsel = 0; nhsel < fib_info_num_path(res.fi); nhsel++) {
+				nhc = fib_info_nhc(res.fi, nhsel);
+				update_or_create_fnhe(nhc, fl4->daddr, 0, mtu, lock,
+					jiffies + net->ipv4.ip_rt_mtu_expires);
+			}
+			goto rcu_unlock;
+		}
+#endif /* CONFIG_IP_ROUTE_MULTIPATH */
 		nhc = FIB_RES_NHC(res);
 		update_or_create_fnhe(nhc, fl4->daddr, 0, mtu, lock,
 				      jiffies + net->ipv4.ip_rt_mtu_expires);
 	}
+rcu_unlock:
 	rcu_read_unlock();
 }
 

base-commit: 66600fac7a984dea4ae095411f644770b2561ede
-- 
2.43.0


