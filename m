Return-Path: <netdev+bounces-77859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D7C873386
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 11:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22C81F215C1
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 10:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9D05FB81;
	Wed,  6 Mar 2024 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="QHiD/NxA"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681D35EE84
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719500; cv=none; b=bXKvSgoilc1mVMx/MaQz5H83VgF1rCeE7AfKxlseldHwBuEnao0jycLPPXiTnnCmeSr7Rbj10e0AkYBXjgvqK2N3+YDp2TKgoIw8RjUvrvHV3JxLyWziv6ZXeGxm+ChX2PiM7IRTVuDjGhmB+mhvCzj8SfNPjx5NI+5wwgXnnJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719500; c=relaxed/simple;
	bh=cQzdlCkOLomfGSDwUwvTOKYZxmoj2lfcCHlP2MSyOXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pz6MhWvw2yMwrut/XGQOonbzlutiJfEm0pCxcE3lTqU4/kkTEyRXff7ZNzNwCYXjQroRA5RhNv5iZuQnpZ6J+1uOUeSrPKeoamKmujkUqhzkF5XO3MUPBTjgmhW6X045jWPRMNi01oPP4IAtAcTvu0bvmTPBe2+mQjUb3i3J46g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=QHiD/NxA; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id D35FF2074A;
	Wed,  6 Mar 2024 11:04:56 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fQI6k32cNM3F; Wed,  6 Mar 2024 11:04:52 +0100 (CET)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 3D94C20839;
	Wed,  6 Mar 2024 11:04:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 3D94C20839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1709719485;
	bh=WAVD2OsxliRG+gx/HUNsRk6Z5TumUFYSPiwWIlC0l/Y=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=QHiD/NxA6N4qAPd0AxE2wBuCW0Xs/wxX5A8LQYVzr0BVYkLkbfrC/ie7bDQlVJvnz
	 aWniBZwJPp437XCp8MwLaioyp0koMbo4Qz3CcSzQc03Xc+QGt28j2OCUyC3OL7vhDb
	 h3SyLpEFxkT2OU+04ZOp5vdHY68H4MaAr6Sz3MU1SI0t7SvceGAG0nNP7WT8S1XkzB
	 n/SgkMJcf3V7O6dqkJK9z8sixM4nsBquec7bEuNK9/bR6IFkRPICP8XljYax41pETd
	 l2N3vdfdI4ergsk8JJN5gE0y50v7bXmZBdKWBy55YBSLn1bKz0z4aHhOEy1DijUtyK
	 COV/x/Xl/GHQg==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 3229280004A;
	Wed,  6 Mar 2024 11:04:45 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 11:04:45 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 11:04:44 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id DA30A3182E3C; Wed,  6 Mar 2024 11:04:43 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 5/5] xfrm: set skb control buffer based on packet offload as well
Date: Wed, 6 Mar 2024 11:04:38 +0100
Message-ID: <20240306100438.3953516-6-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306100438.3953516-1-steffen.klassert@secunet.com>
References: <20240306100438.3953516-1-steffen.klassert@secunet.com>
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

From: Mike Yu <yumike@google.com>

In packet offload, packets are not encrypted in XFRM stack, so
the next network layer which the packets will be forwarded to
should depend on where the packet came from (either xfrm4_output
or xfrm6_output) rather than the matched SA's family type.

Test: verified IPv6-in-IPv4 packets on Android device with
      IPsec packet offload enabled
Signed-off-by: Mike Yu <yumike@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_output.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index 662c83beb345..e5722c95b8bb 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -704,9 +704,13 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 {
 	struct net *net = dev_net(skb_dst(skb)->dev);
 	struct xfrm_state *x = skb_dst(skb)->xfrm;
+	int family;
 	int err;
 
-	switch (x->outer_mode.family) {
+	family = (x->xso.type != XFRM_DEV_OFFLOAD_PACKET) ? x->outer_mode.family
+		: skb_dst(skb)->ops->family;
+
+	switch (family) {
 	case AF_INET:
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 		IPCB(skb)->flags |= IPSKB_XFRM_TRANSFORMED;
-- 
2.34.1


