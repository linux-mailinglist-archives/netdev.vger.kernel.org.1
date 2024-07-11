Return-Path: <netdev+bounces-110775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA0E92E3F5
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 12:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB91C1C2156F
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 10:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7498D158878;
	Thu, 11 Jul 2024 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="K+k2u9zW"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4EB5CDE9
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692039; cv=none; b=AzH+6pE8E6GbSFIsvqkyrZSSEOP2BS+OEZDoV4HBWq6ZHRX+c2S9HZWcrx7/1yep/XfCh0IrReqLxihfjWqT52rkrCewna5yYcutKolayq2Krju42LjJei0lOZafwcAz7200AWwTKFDnIxnnopnVxwQesjP9GVsCzGPWfdtjHnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692039; c=relaxed/simple;
	bh=gc1/Rs500KGXphntpckr99Gxfc+Wz1qwgBipyd5IVL8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XsSaNGRrZRBf3qGUgDVWfnTRv38Zwis3xkP10H6g1Cnjiv9VjIVx6pwdJ9pVVm166jGKGx2rU+vB79G0o0W1ucvxu0nHgIblvpFjiKR6FR7Fb0d5NqR3pP+SD27O+KXnd7Pcb2H/nnYxyvoXA3AEL920El8iqy1eBTBOMDKkOv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=K+k2u9zW; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id BFF9E207AC;
	Thu, 11 Jul 2024 12:00:34 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iGBDC9EdIwzo; Thu, 11 Jul 2024 12:00:34 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 85EAA207A4;
	Thu, 11 Jul 2024 12:00:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 85EAA207A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1720692032;
	bh=wlKRXmfzFJnNd+K7HdU+FKSM9ZikPtu6aDpPglXAaKQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=K+k2u9zWKwOYN8g6asIeh+AADGI2ems8wJx0NFKLfMauMCBqB6LPNctGzUPkUW382
	 e4eUpyuGsntZ2iiN//HiMBip4J4C0etUbZPh7+mpAQTwr+uDZrCYWx/buGL456HPQZ
	 amNP8NEZ4xFXpv8H4kv7QHAkdRP2vcJjhdTdQLfkZMwoqUTVGPKng80ewpQrOROIvt
	 DM0Hy6IUWI9m0yelsCKMxBIvlC/cxfNRNQPXU2BR8tw1cUqb1rmmpVrXU3ynZCI+yP
	 iBWB9CUekVMEUVCBw8bf0BKj71zVPMCjqga+tI0DuOMGKa0sThIJczyS2eX2rJ1LC9
	 d6cbjPPpgUk/w==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 77B5B80004A;
	Thu, 11 Jul 2024 12:00:32 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 12:00:32 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 12:00:31 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 1B2853183034; Thu, 11 Jul 2024 12:00:31 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 7/7] xfrm: call xfrm_dev_policy_delete when kill policy
Date: Thu, 11 Jul 2024 12:00:25 +0200
Message-ID: <20240711100025.1949454-8-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711100025.1949454-1-steffen.klassert@secunet.com>
References: <20240711100025.1949454-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Jianbo Liu <jianbol@nvidia.com>

xfrm_policy_kill() is called at different places to delete xfrm
policy. It will call xfrm_pol_put(). But xfrm_dev_policy_delete() is
not called to free the policy offloaded to hardware.

The three commits cited here are to handle this issue by calling
xfrm_dev_policy_delete() outside xfrm_get_policy(). But they didn't
cover all the cases. An example, which is not handled for now, is
xfrm_policy_insert(). It is called when XFRM_MSG_UPDPOLICY request is
received. Old policy is replaced by new one, but the offloaded policy
is not deleted, so driver doesn't have the chance to release hardware
resources.

To resolve this issue for all cases, move xfrm_dev_policy_delete()
into xfrm_policy_kill(), so the offloaded policy can be deleted from
hardware when it is called, which avoids hardware resources leakage.

Fixes: 919e43fad516 ("xfrm: add an interface to offload policy")
Fixes: bf06fcf4be0f ("xfrm: add missed call to delete offloaded policies")
Fixes: 982c3aca8bac ("xfrm: delete offloaded policy")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 5 ++---
 net/xfrm/xfrm_user.c   | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 475b904fe68b..10f68d572885 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -452,6 +452,8 @@ EXPORT_SYMBOL(xfrm_policy_destroy);
 
 static void xfrm_policy_kill(struct xfrm_policy *policy)
 {
+	xfrm_dev_policy_delete(policy);
+
 	write_lock_bh(&policy->lock);
 	policy->walk.dead = 1;
 	write_unlock_bh(&policy->lock);
@@ -1850,7 +1852,6 @@ int xfrm_policy_flush(struct net *net, u8 type, bool task_valid)
 
 		__xfrm_policy_unlink(pol, dir);
 		spin_unlock_bh(&net->xfrm.xfrm_policy_lock);
-		xfrm_dev_policy_delete(pol);
 		cnt++;
 		xfrm_audit_policy_delete(pol, 1, task_valid);
 		xfrm_policy_kill(pol);
@@ -1891,7 +1892,6 @@ int xfrm_dev_policy_flush(struct net *net, struct net_device *dev,
 
 		__xfrm_policy_unlink(pol, dir);
 		spin_unlock_bh(&net->xfrm.xfrm_policy_lock);
-		xfrm_dev_policy_delete(pol);
 		cnt++;
 		xfrm_audit_policy_delete(pol, 1, task_valid);
 		xfrm_policy_kill(pol);
@@ -2342,7 +2342,6 @@ int xfrm_policy_delete(struct xfrm_policy *pol, int dir)
 	pol = __xfrm_policy_unlink(pol, dir);
 	spin_unlock_bh(&net->xfrm.xfrm_policy_lock);
 	if (pol) {
-		xfrm_dev_policy_delete(pol);
 		xfrm_policy_kill(pol);
 		return 0;
 	}
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index e83c687bd64e..77355422ce82 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2455,7 +2455,6 @@ static int xfrm_get_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
 					    NETLINK_CB(skb).portid);
 		}
 	} else {
-		xfrm_dev_policy_delete(xp);
 		xfrm_audit_policy_delete(xp, err ? 0 : 1, true);
 
 		if (err != 0)
-- 
2.34.1


