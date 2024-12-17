Return-Path: <netdev+bounces-152462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1C49F4051
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 03:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31185188D872
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 02:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356BD7F7FC;
	Tue, 17 Dec 2024 02:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/vWsSpb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0734F2B9CD;
	Tue, 17 Dec 2024 02:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734401090; cv=none; b=q2buxsfGB8Ay0kihLwnsKsEdRgkFSfey+Z7If8+qxiCKdvlHh9XrvsWU6RD4X5DmezYYYPrufKUVC4I+nvB/zEEVAhmBTmOI2V5MiL2gKcRPdpHMOIYSKmlaTUp7bSeMC64eGMQmnGUKqrUgwJKlhMWrujILC45dsFS4x3idpfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734401090; c=relaxed/simple;
	bh=BTSN9M6hbNaevPQDTr9VKyPD+Neg+lgWqgTutRYqPCY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OVZAyMR8yov/BkIMU8QWC7z0XDpwR2hsJGEuJFjHwO4sUph2wIAdolaib9Vh1dR6JEU/SENBd2/UqGTp0vPxih1BibwPnPE/AeYuWIc1Fdyu6pSk3hpMc3xWIsJqiaCD4HzMB0Z9TQidBDvO/ZIjlvA4cX8WJYGl7kfVdLbm1HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/vWsSpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B769C4CED0;
	Tue, 17 Dec 2024 02:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734401089;
	bh=BTSN9M6hbNaevPQDTr9VKyPD+Neg+lgWqgTutRYqPCY=;
	h=From:To:Cc:Subject:Date:From;
	b=f/vWsSpbBzTQOBGM0w5uCSl+ZQvSYFYlQapLhFQYntwS1jttm4nWiQIU07/y9vyDq
	 50f1GB3KNjj/s4o+PTaiD8ceiFuHv8XNoseFnIqr7Ag7HnUnmGiYpwppylxBBC04UR
	 28AXlQrvAv6ICf0XFnEuklvyS8QXFM8pSXQWehsCBTQh3TxAmkW0j7V2eTaF6xk9RJ
	 ACgEgFyDZArIgM0AhM9YDR0wUIQ9/YZOZLbwMlIdl4D42vl0sHkuVhKYwWybbR03X0
	 YmvKSdB273ddUzFcAZ8C3u3Mx6Zd9H6bdt4V0EevIpYz+MPGgBeHJ+JABElaKEHIuk
	 Udms+ldyEiq+w==
From: Kees Cook <kees@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Kees Cook <kees@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] rtnetlink: do_setlink: Use true struct sockaddr
Date: Mon, 16 Dec 2024 18:04:45 -0800
Message-Id: <20241217020441.work.066-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1911; i=kees@kernel.org; h=from:subject:message-id; bh=BTSN9M6hbNaevPQDTr9VKyPD+Neg+lgWqgTutRYqPCY=; b=owGbwMvMwCVmps19z/KJym7G02pJDOkJd2yPbTCbxDi7of9UrHHKSbmkV8z8M2z6/LN2OFyqn yT/5LpqRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwETMFRgZzlw/yPR5VveRV9Ic UyWCAsLYBC+4LzKar6LSKfgkhkViIcP/vKMCH4vrjZ4wvjc/9b6ghe3L2uj5sv9aOx142nyT9nf zAAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Instead of a heap allocation use a stack allocated struct sockaddr, as
dev_set_mac_address_user() is the consumer (which uses a classic
struct sockaddr). Cap the copy to the minimum address size between
the incoming address and the traditional sa_data field itself.

Putting "sa" on the stack means it will get a reused stack slot since
it is smaller than other existing single-scope stack variables (like
the vfinfo array).

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org
---
 net/core/rtnetlink.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index ab5f201bf0ab..6da0edc0870d 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3048,21 +3048,13 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
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
-		memcpy(sa->sa_data, nla_data(tb[IFLA_ADDRESS]),
-		       dev->addr_len);
-		err = dev_set_mac_address_user(dev, sa, extack);
-		kfree(sa);
+		struct sockaddr sa = { };
+
+		/* dev_set_mac_address_user() uses a true struct sockaddr. */
+		sa.sa_family = dev->type;
+		memcpy(sa.sa_data, nla_data(tb[IFLA_ADDRESS]),
+		       min(dev->addr_len, sizeof(sa.sa_data_min)));
+		err = dev_set_mac_address_user(dev, &sa, extack);
 		if (err)
 			goto errout;
 		status |= DO_SETLINK_MODIFIED;
-- 
2.34.1


