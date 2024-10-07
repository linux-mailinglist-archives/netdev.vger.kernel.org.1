Return-Path: <netdev+bounces-132736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7966D992ECB
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9E61F24864
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7897B1D86EF;
	Mon,  7 Oct 2024 14:17:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB3D188588
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310654; cv=none; b=FU+It16PGBf/PNQ9BBgzHSy1m2xkH6hjKG4QSouYRWrO/DHkjUyXoTq/4P2UdJa1TaBvA+WPu2kyiXGM70NqLJJ1SeqBdzXOyetKecbfifIifNqOEDrqvP5yNrcwNgW8dzHAmqJCd87OWgnHwHH753Vxe9hC/C3KzkPtEtp1z3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310654; c=relaxed/simple;
	bh=w85rAFZ+a9VjpaEsbec1z60WY2nfBeNCdSS5loJlCIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U8l5hSim6cEbVUyiLcU0letCLi1hyHLQX9ciUHrJAK6O4StWqqhQfn7yWB2QGiRNs+nzK8c7yMS0LXXxSsmes0DdYayfeSyKFcPuC0z7N2V4zFdBYE3BM9zzGsOgqsQZnGBHpriEKbx/STwomaWmJyasPS3dCooOSTudsZJxQIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1sxoY4-0008LN-TF; Mon, 07 Oct 2024 16:17:20 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Mon, 07 Oct 2024 16:17:11 +0200
Subject: [PATCH 1/2] net: ipv4: igmp: optimize ____ip_mc_inc_group() using
 mc_hash
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-igmp-speedup-v1-1-6c0a387890a5@pengutronix.de>
References: <20241007-igmp-speedup-v1-0-6c0a387890a5@pengutronix.de>
In-Reply-To: <20241007-igmp-speedup-v1-0-6c0a387890a5@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Madalin Bucur <madalin.bucur@nxp.com>, 
 Sean Anderson <sean.anderson@seco.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

The runtime cost of joining a single multicast group in the current
implementation of ____ip_mc_inc_group grows linearly with the number of
existing memberships. This is caused by the linear search for an
existing group record in the multicast address list.

This linear complexity results in quadratic complexity when successively
adding memberships, which becomes a performance bottleneck when setting
up large numbers of multicast memberships.

If available, use the existing multicast hash map mc_hash to quickly
search for an existing group membership record. This leads to
near-constant complexity on the addition of a new multicast record,
significantly improving performance for workloads involving many
multicast memberships.

On profiling with a loopback device, this patch presented a speedup of
around 6 when successively setting up 2000 multicast groups using
setsockopt without measurable drawbacks on smaller numbers of
multicast groups.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 net/ipv4/igmp.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 9bf09de6a2e77c32f5eed565db8fd6c14bc7ea86..6a238398acc9d5684ec3d6305ef2a74834f5a3b3 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1437,16 +1437,32 @@ static void ip_mc_hash_remove(struct in_device *in_dev,
 static void ____ip_mc_inc_group(struct in_device *in_dev, __be32 addr,
 				unsigned int mode, gfp_t gfp)
 {
+	struct ip_mc_list __rcu **mc_hash;
 	struct ip_mc_list *im;
 
 	ASSERT_RTNL();
 
-	for_each_pmc_rtnl(in_dev, im) {
-		if (im->multiaddr == addr) {
-			im->users++;
-			ip_mc_add_src(in_dev, &addr, mode, 0, NULL, 0);
-			goto out;
+	mc_hash = rtnl_dereference(in_dev->mc_hash);
+	if (mc_hash) {
+		u32 hash = hash_32((__force u32)addr, MC_HASH_SZ_LOG);
+
+		for (im = rtnl_dereference(mc_hash[hash]);
+		     im;
+		     im = rtnl_dereference(im->next_hash)) {
+			if (im->multiaddr == addr)
+				break;
 		}
+	} else {
+		for_each_pmc_rtnl(in_dev, im) {
+			if (im->multiaddr == addr)
+				break;
+		}
+	}
+
+	if  (im) {
+		im->users++;
+		ip_mc_add_src(in_dev, &addr, mode, 0, NULL, 0);
+		goto out;
 	}
 
 	im = kzalloc(sizeof(*im), gfp);

-- 
2.39.5


