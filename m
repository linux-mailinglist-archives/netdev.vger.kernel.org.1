Return-Path: <netdev+bounces-126486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D94B9714BA
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 12:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D1EFB23759
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9581E1B5338;
	Mon,  9 Sep 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="QxLVwekz"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057831B5302
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876224; cv=none; b=irP0jh7HzwR7WdG6zIiSc9PR35E/HJhOj2yxvW5qvTYlS9ipaLLgv0T2nNjfC7oZpHtczC/M9tGRG5cZCH8/1kSruQOCspPYtW0/iWHVh+iuzcWbLL0R+9FGl8EtYPmwpph0ORZHjDHHuS5mFJuCiv3t0CpUaW2nfJ7Hyf44U2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876224; c=relaxed/simple;
	bh=SIPd6Z5aL3Lp3FYnctyiQ1dGGqnXaoxXXLIn+8qspZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqN3A00YRAOl6pLZGYvn4TZ4+8N2Gj/lnrabL9bDNKzdC4ARDGgKm4vUXB9LogTVEeEXSJy97fwMmbdCqdM5thtrtTJs/ZJEseuSQVm1crUmLoPkt8pLobTKnkJCl3R7ZIAbu3wnrQHN98SnnuFxIe/uwjdLbxb7zzg4ZTk0k3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=QxLVwekz; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 6FA7420885;
	Mon,  9 Sep 2024 12:03:41 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KX4FxEuZDXis; Mon,  9 Sep 2024 12:03:41 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id E6A082085A;
	Mon,  9 Sep 2024 12:03:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com E6A082085A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725876220;
	bh=tMEEwy5Cmg7N/evH9gbiuV98BtUYHX/bTp8srDZmoB4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=QxLVwekzuccRX85I0NcIQkOYj1rHgYT+Gx3MhAxUXayge+cVNjJFyBTeR3KwG6EJQ
	 43bCj0yZ390AsW+7kyfyw2Hc2+vuuS0yoyZLbxx1PeiyEg7NXbCzd50Su5ffHUOz9F
	 lAKQzC9H7RDtiF1QyRA5i7pU3jvbfeP4RWMS67KqXg1wAA5g2Z9VTmBfDOZpkCXkFH
	 3rC7M04w9jw6cXoLPZDJcFDeSiGwJ3SMB7aIoQr6820bwJv9UcqLhulUT59zwdaVRc
	 m5civ/3TFsF/mf5Dl+BnuEpdFqCEn+U8ZH9nE1UB4sUrtGn26agKugr+YvJvW++Y2B
	 Lsxv9tj5fCFww==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 12:03:40 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 12:03:40 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 5C9F131847E6; Mon,  9 Sep 2024 12:03:34 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 11/11] Revert "xfrm: add SA information to the offloaded packet"
Date: Mon, 9 Sep 2024 12:03:28 +0200
Message-ID: <20240909100328.1838963-12-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909100328.1838963-1-steffen.klassert@secunet.com>
References: <20240909100328.1838963-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

This reverts commit e7cd191f83fd899c233dfbe7dc6d96ef703dcbbd.

While supporting xfrm interfaces in the packet offload API
is needed, this patch does not do the right thing. There are
more things to do to really support xfrm interfaces, so revert
it for now.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_output.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index a12588e7b060..e5722c95b8bb 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -706,8 +706,6 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 	struct xfrm_state *x = skb_dst(skb)->xfrm;
 	int family;
 	int err;
-	struct xfrm_offload *xo;
-	struct sec_path *sp;
 
 	family = (x->xso.type != XFRM_DEV_OFFLOAD_PACKET) ? x->outer_mode.family
 		: skb_dst(skb)->ops->family;
@@ -730,25 +728,6 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 			kfree_skb(skb);
 			return -EHOSTUNREACH;
 		}
-		sp = secpath_set(skb);
-		if (!sp) {
-			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
-			kfree_skb(skb);
-			return -ENOMEM;
-		}
-
-		sp->olen++;
-		sp->xvec[sp->len++] = x;
-		xfrm_state_hold(x);
-
-		xo = xfrm_offload(skb);
-		if (!xo) {
-			secpath_reset(skb);
-			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
-			kfree_skb(skb);
-			return -EINVAL;
-		}
-		xo->flags |= XFRM_XMIT;
 
 		return xfrm_output_resume(sk, skb, 0);
 	}
-- 
2.34.1


