Return-Path: <netdev+bounces-22809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DF476950B
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 13:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A084C28109F
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1895182AA;
	Mon, 31 Jul 2023 11:38:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0F1182A0
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B4EC433C8;
	Mon, 31 Jul 2023 11:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690803521;
	bh=4Kut+Aj34e0b4FvRLDaGTDfUM4AGVvNXmN+OkJ4YXXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nZmMlhhZ3HC73+irFN/YqJ6Ws5nW8xV53e8kw/p0PoPh1SyL5qxdVlb3bivSjg0BC
	 SzjeIATzrh23JxGezenpCat3hoT0ueIGMG1QPzCGai62NbcGwDAGGqkubsCjZuo4fF
	 c3k+DH0hj1IHqlmiCBgmLSrCrsfXjBj0x5j9yLYkeBuxIIy1cGaEK5+Khnfl0KgGhk
	 Ux2aRG5Vcj7aL/8xlYhaUshsYVj8mGqxRdkddV6Jh5BZ3JqIMifR7EOD9hQyVsZBU0
	 ATYflLiR9TsX8IV1CqoMc30c2aqoDLch+w7OTUEGL79PknSuaXWQcRlYU61jhhQPhV
	 mIdtbWfRgZu6Q==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Raed Salem <raeds@nvidia.com>
Subject: [PATCH ipsec-rc 1/2] xfrm: delete offloaded policy
Date: Mon, 31 Jul 2023 14:38:26 +0300
Message-ID: <8a4865f5b78314be70cb8540027cc48f86d45d89.1690803052.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690803052.git.leon@kernel.org>
References: <cover.1690803052.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

The policy memory was released but not HW driver data. Add
call to xfrm_dev_policy_delete(), so drivers will have a chance
to release their resources.

Fixes: 919e43fad516 ("xfrm: add an interface to offload policy")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 net/xfrm/xfrm_user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index c34a2a06ca94..5a117aac4274 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2336,6 +2336,7 @@ static int xfrm_get_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
 					    NETLINK_CB(skb).portid);
 		}
 	} else {
+		xfrm_dev_policy_delete(xp);
 		xfrm_audit_policy_delete(xp, err ? 0 : 1, true);
 
 		if (err != 0)
-- 
2.41.0


