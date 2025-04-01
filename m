Return-Path: <netdev+bounces-178485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA72A77278
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 04:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833CE168211
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 02:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA84F43AB7;
	Tue,  1 Apr 2025 02:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Igzdbqjx"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6C9EACE
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 02:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743472861; cv=none; b=XACr1GSHox9PV3+4isNc4nDGnepEj4UEWIuLpwP04C6xjNFFdqprtExTqs3CnLl3QCqvAodc3R2pGCXevm5/wO0D7SpOPIkrv1CsBQWSMr4kOkXFNz6pl3S/YI1Lh5DpI5fBT0ybkQO+3I+4hJAF5wsvux+gcd6jjXzq4jR38nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743472861; c=relaxed/simple;
	bh=EKX9CIfbKiTt29ZxkVuXsa3z+gTnkt7DnQwceh8032A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=St/UNqGsSdDfe8xLQWzkQSQlEVeUIKh+b5TPjrRTjsgroTQfqeC8D6VLYiwQrReVgNluGO0ZnRGGKxLSj1O7VVnmQr5aJtdkZIISEfzPfD8EQMQgL+vvSQc0OUBaf7cE1w6iBsIrzX0CrtUjOjppoQYhd2ZBozTHEJkCpF4sZUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Igzdbqjx; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=AouMB
	HNPa08DmkVd5Laa6OWFeeQtROq+pwDf44Ej+aY=; b=IgzdbqjxFEt+LwXn4Typt
	gEnpzb+j9qrYkqqgY54rerCoAfVJKw/5Xph6QMUA+Y47cXoMMNrMH7r4/jpNw97G
	fuk0OxMi8gB7fwAb+cZNTFMKt3+L/ych0pF9jS2xxQ0+dex61c/edkgscAamupWi
	uUdWNSiQXPQaiTfNZduWKc=
Received: from x04j10049.na61.tbsite.net (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDneoKzSOtn8DXnDA--.29599S2;
	Tue, 01 Apr 2025 10:00:20 +0800 (CST)
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
Date: Tue,  1 Apr 2025 10:00:17 +0800
Message-ID: <20250401020017.96438-1-shaozhengchao@163.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDneoKzSOtn8DXnDA--.29599S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw4UKFWfuF4xZFW8Xw1rXrb_yoWDJFgE93
	Z7WrWrGF45Xr18Gan8Crs5Z3s8Kws0yrnYva1rKF9xta4rJF4DZF9FgryrJr9xGrZIg3sx
	ury3WFn8XFW2gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRR-BMJUUUUU==
X-CM-SenderInfo: pvkd065khqwuxkdrqiywtou0bp/1tbiPR4ivGfrQcHJBwAAs-

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


