Return-Path: <netdev+bounces-180578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9DFA81BB1
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 05:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45EBF7AA9DE
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 03:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FDB155753;
	Wed,  9 Apr 2025 03:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="X9OizV73"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E95410E3
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 03:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744170556; cv=none; b=IqWS4Fj6dbyXucR0E2XnfCnxDx+EeX6Yx9EYT/JpPlSgVbq7UTy3gPiMrTcgpMn/c85bTsZZOoYx9LVKWIX6/B/2wqNCJ4Brk8RdJcvPMvFQDBSMH9NHDPq9TQIVfS1NyOKshd98qYU+E/6aUiihCaHmYSlsztfQrfQPZBq4mrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744170556; c=relaxed/simple;
	bh=EKX9CIfbKiTt29ZxkVuXsa3z+gTnkt7DnQwceh8032A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=soYHpcADWER41XcHfIAvXB/5sab+QfkyIIRi3gxBagrypvT1cEBoMfjW+ynIEWjPfZELuTuyfCB0/J5Qk3HZO18GezFx7GPXqMYS7sCIQd50cE8ffzdNgVLWV52hcpeWPwLk4n6Oh43Mycu6iNwraAy7qkVcyODCwyLIRCSuYSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=X9OizV73; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=AouMB
	HNPa08DmkVd5Laa6OWFeeQtROq+pwDf44Ej+aY=; b=X9OizV73iRjdFBQ2t3u/A
	aHjv6LGit8VUoA3kxJPVFS7xQSQgURJQJjGyOXYOb8L/CLwuKsrxA5hlNFKo7FVm
	wFSGlB+JbjhOCbTILmhYb+DXPBVYVCtK23NtwsxRoFrXKd18CdYOV6glqFbF75K4
	KoE28mWypR6ALExrjMFEzA=
Received: from x04j10049.na61.tbsite.net (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDX_3qE6vVnOYuYFA--.19509S2;
	Wed, 09 Apr 2025 11:33:25 +0800 (CST)
From: shaozhengchao@163.com
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	shaozhengchao@163.com
Subject: [PATCH net-next] ipv4: remove unnecessary judgment in ip_route_output_key_hash_rcu
Date: Wed,  9 Apr 2025 11:33:21 +0800
Message-ID: <20250409033321.108244-1-shaozhengchao@163.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX_3qE6vVnOYuYFA--.19509S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw4UKFWfuF4xZFW8Xw1rXrb_yoWDJFgE93
	Z7WrWrGF45Xr18Gan8Crs5Z3s8Kws0yrnYva1rKF9xta4rJF4DZF9FgryrJr9xGrZIg3sx
	ury3WFn8XFW2gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRR5l13UUUUU==
X-CM-SenderInfo: pvkd065khqwuxkdrqiywtou0bp/1tbiPQ8qvGf14n-QNAABsO

From: Zhengchao Shao <shaozhengchao@163.com>

In the ip_route_output_key_cash_rcu function, the input fl4 member saddr is
first checked to be non-zero before entering multicast, broadcast and
arbitrary IP address checks. However, the fact that the IP address is not
0 has already ruled out the possibility of any address, so remove
unnecessary judgment.

Signed-off-by: Zhengchao Shao <shaozhengchao@163.com>
---
 net/ipv4/route.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 753704f75b2c..22dfc971aab4 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2699,8 +2699,7 @@ struct rtable *ip_route_output_key_hash_rcu(struct net *net, struct flowi4 *fl4,
 
 	if (fl4->saddr) {
 		if (ipv4_is_multicast(fl4->saddr) ||
-		    ipv4_is_lbcast(fl4->saddr) ||
-		    ipv4_is_zeronet(fl4->saddr)) {
+		    ipv4_is_lbcast(fl4->saddr)) {
 			rth = ERR_PTR(-EINVAL);
 			goto out;
 		}
-- 
2.43.0


