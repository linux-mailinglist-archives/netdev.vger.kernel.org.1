Return-Path: <netdev+bounces-192050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E9BABE5F0
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 23:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 164837A1B89
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 21:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AF2253F1B;
	Tue, 20 May 2025 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HL4iSFjN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98084B1E7B;
	Tue, 20 May 2025 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747776116; cv=none; b=rkKAmMthrsHA436Ng76qCYhYKjwX7xETb8gpi5rHTW2+3/m3Yds9+VyEhAkwocXUg4yZ/csjQFCMFSchcT3iLRehIWA9F0iE6QljCSLl8EX7Too0ei5WRKhiNSaEh2+FqzaQtYiixmjm82f0kDJOJNAVF/Tvfe8Ew/IT8TCXwQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747776116; c=relaxed/simple;
	bh=MjazGl/PJDE1NWBJ5iUg+P03PZ9R/Tfn1LeJ0uVHaGY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rbRG2UlHTCf1FV46kg39Tk9pxXsPgDp+ZYHhkLBcDVrRCZnwU/tVg6DaeQEjG/YbGtp+7a+zz4osB4IXKjWxLaEEAORPXNGCsf10XXvTp+WDSXoxT+SoquW6YHrCHECR+oHfXjFOu0J6YFddXxYgUhmIRIBPE/EZoUZnXdALsns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HL4iSFjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268CDC4CEE9;
	Tue, 20 May 2025 21:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747776116;
	bh=MjazGl/PJDE1NWBJ5iUg+P03PZ9R/Tfn1LeJ0uVHaGY=;
	h=From:To:Cc:Subject:Date:From;
	b=HL4iSFjNrtv9Qo4vUt/pvQT8B3uQMw1zG27jgY7fAaMXKxYNX+Vb7osBWH5uPCBsg
	 qpD1BxaQapCNd5LRLctkPR10dA2OLPSH4rLf8CnaAIxtOo2A4neFKPECnAvhBAEh4b
	 +nwcVEoYIH3Msp0gLArZ9rgQRJnL60SKPHv4u5kteyrLIWLkWm29i7khH92BJ9D6EE
	 HVPh18x1Pu62MRm1+FPN+6pv+EjbloCeiI3pCekyNQQIqqu8AwH1cS64p51c4sH1dG
	 CiGSlZbXO8f/iUwcwOrYnfLNkkZDOfRtWVR/w5C18dUUVrXz+SUplrZlaxNzxbKh6V
	 JzJkxMpTlFsSw==
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kees Cook <kees@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v2] rtnetlink: do_setlink: Use struct sockaddr_storage
Date: Tue, 20 May 2025 14:21:51 -0700
Message-Id: <20250520212147.it.062-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2212; i=kees@kernel.org; h=from:subject:message-id; bh=MjazGl/PJDE1NWBJ5iUg+P03PZ9R/Tfn1LeJ0uVHaGY=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk6n/LahBNSz7gcOb3lcTST/7R7e97oyvl933hyz2S/v MIlheeXd5SyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAExkUSLDX0nmKZ+ykpUkSmZw PxTNm5e6eM9B1undJ+/O25H5XaJCTIfhv/cVq0tMN3vK1r+anOE/JYeFS01uUu0TlaWBX997H33 /lhMA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Instead of a heap allocation a variably sized struct sockaddr and lie
about the type in the call to netif_set_mac_address(), use a stack
allocated struct sockaddr_storage. This lets us drop the cast and avoid
the allocation.

Putting "ss" on the stack means it will get a reused stack slot since
it the same size (128B) as other existing single-scope stack variables,
like the vfinfo array (128B), so no additional stack space is used by
this function.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 v1: https://lore.kernel.org/lkml/20241217020441.work.066-kees@kernel.org/
 v2: rebase, use struct sockaddr_storage now
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: <netdev@vger.kernel.org>
---
 net/core/rtnetlink.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 6b7731739bbf..4953e202d0c0 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3080,17 +3080,7 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 	}
 
 	if (tb[IFLA_ADDRESS]) {
-		struct sockaddr *sa;
-		int len;
-
-		len = sizeof(sa_family_t) + max_t(size_t, dev->addr_len,
-						  sizeof(*sa));
-		sa = kmalloc(len, GFP_KERNEL);
-		if (!sa) {
-			err = -ENOMEM;
-			goto errout;
-		}
-		sa->sa_family = dev->type;
+		struct sockaddr_storage ss = { };
 
 		netdev_unlock_ops(dev);
 
@@ -3098,10 +3088,9 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 		down_write(&dev_addr_sem);
 		netdev_lock_ops(dev);
 
-		memcpy(sa->sa_data, nla_data(tb[IFLA_ADDRESS]),
-		       dev->addr_len);
-		err = netif_set_mac_address(dev, (struct sockaddr_storage *)sa, extack);
-		kfree(sa);
+		ss->sa_family = dev->type;
+		memcpy(ss->__data, nla_data(tb[IFLA_ADDRESS]), dev->addr_len);
+		err = netif_set_mac_address(dev, &ss, extack);
 		if (err) {
 			up_write(&dev_addr_sem);
 			goto errout;
-- 
2.34.1


