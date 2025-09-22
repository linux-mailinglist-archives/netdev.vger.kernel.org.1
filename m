Return-Path: <netdev+bounces-225142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFC8B8F4E9
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 09:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009CC189E867
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 07:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF802F5A2B;
	Mon, 22 Sep 2025 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="AVe+kzRM"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7765D188715
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 07:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758526526; cv=none; b=ugqMCzbMQ240ju0bZnECvRNeF4Rx9tKoXkPlWc9Q3iHb1cyB7VUeNeA1Ldbii6MgdzyLbpBzP9AZIyCvox0BCBJR0xUcENzsA+8wWNupGdHLsVuq0UWg+UxuQUDhZwrI9B1p17pLj4KPmctWYLkBPlIAc9I6Rjl1UDja+fM5t/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758526526; c=relaxed/simple;
	bh=edL47q7quT/AnpEJ4eqEELjInRHaGsgLmk3EAbQn6TA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmFb1+nm+ZsmY6Pkz7B34YPHUPpngHb8IUgFG2MQOVhPjMdZmtzPXk+24M3e3AhFpJyZB/gvPXVVF+NquNidXfYOj13msKvArVqwA8mgWBEs0BkjoCzKwwgawmRMgpx8JIqhALoqDb2AoV7CJ3dxfabKC66j4WzYv8/dyUnMwLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=AVe+kzRM; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 67FC22083B;
	Mon, 22 Sep 2025 09:35:22 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7M_a3jImvPyK; Mon, 22 Sep 2025 09:35:21 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B143E205ED;
	Mon, 22 Sep 2025 09:35:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B143E205ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1758526521;
	bh=dflIiM7PShn942iNHWX9XfNtqMJw890UCwCzRwF0mWo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=AVe+kzRMskhwC9zTWJoVlr5cs9wgPrWiBalrf1UDbI1oOWpjO+Ze3z3j7zxnRksKd
	 oG685FNFSvAmWDx2dRnIbQabjap/gdI62noO7xhaOh2lDs1tCBF9kcBCJDG23K13dy
	 oB21wYeV9uL9KLqaE1e7Prg5N9s52ZrHcoBojks/PzuDG8ZbD5T6NDjWjudYNGcHm3
	 iVqC+mvcV55EGnpkQq/cgoq5KN5Os5eTBndSI5j0cAbXzaU9N4pXf6MYO3tqMY8vzb
	 BSlnlSOoyAnegS1BGi5IvorJ5u1afP0wGD9eYYyoWqOuPLkncr9biINIlK14eFNYwx
	 zC0cTPnVx1WCA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 22 Sep
 2025 09:35:21 +0200
Received: (nullmailer pid 64935 invoked by uid 1000);
	Mon, 22 Sep 2025 07:35:19 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 2/2] xfrm: fix offloading of cross-family tunnels
Date: Mon, 22 Sep 2025 09:34:53 +0200
Message-ID: <20250922073512.62703-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922073512.62703-1-steffen.klassert@secunet.com>
References: <20250922073512.62703-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

From: Sabrina Dubroca <sd@queasysnail.net>

Xiumei reported a regression in IPsec offload tests over xfrmi, where
the traffic for IPv6 over IPv4 tunnels is processed in SW instead of
going through crypto offload, after commit
cc18f482e8b6 ("xfrm: provide common xdo_dev_offload_ok callback
implementation").

Commit cc18f482e8b6 added a generic version of existing checks
attempting to prevent packets with IPv4 options or IPv6 extension
headers from being sent to HW that doesn't support offloading such
packets. The check mistakenly uses x->props.family (the outer family)
to determine the inner packet's family and verify if
options/extensions are present.

In the case of IPv6 over IPv4, the check compares some of the traffic
class bits to the expected no-options ihl value (5). The original
check was introduced in commit 2ac9cfe78223 ("net/mlx5e: IPSec, Add
Innova IPSec offload TX data path"), and then duplicated in the other
drivers. Before commit cc18f482e8b6, the loose check (ihl > 5) passed
because those traffic class bits were not set to a value that
triggered the no-offload codepath. Packets with options/extension
headers that should have been handled in SW went through the offload
path, and were likely dropped by the NIC or incorrectly
processed. Since commit cc18f482e8b6, the check is now strict (ihl !=
5), and in a basic setup (no traffic class configured), all packets go
through the no-offload codepath.

The commits that introduced the incorrect family checks in each driver
are:
2ac9cfe78223 ("net/mlx5e: IPSec, Add Innova IPSec offload TX data path")
8362ea16f69f ("crypto: chcr - ESN for Inline IPSec Tx")
859a497fe80c ("nfp: implement xfrm callbacks and expose ipsec offload feature to upper layer")
32188be805d0 ("cn10k-ipsec: Allow ipsec crypto offload for skb with SA")
[ixgbe/ixgbevf commits are ignored, as that HW does not support tunnel
mode, thus no cross-family setups are possible]

Fixes: cc18f482e8b6 ("xfrm: provide common xdo_dev_offload_ok callback implementation")
Reported-by: Xiumei Mu <xmu@redhat.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index c7a1f080d2de..44b9de6e4e77 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -438,7 +438,7 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 
 	check_tunnel_size = x->xso.type == XFRM_DEV_OFFLOAD_PACKET &&
 			    x->props.mode == XFRM_MODE_TUNNEL;
-	switch (x->props.family) {
+	switch (x->inner_mode.family) {
 	case AF_INET:
 		/* Check for IPv4 options */
 		if (ip_hdr(skb)->ihl != 5)
-- 
2.43.0


