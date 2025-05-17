Return-Path: <netdev+bounces-191310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBEAABAC37
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 22:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9419189DD1A
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 20:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DE71FDA9E;
	Sat, 17 May 2025 20:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOcZ/UUx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9951A00E7
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747512496; cv=none; b=jPSTgxC6a9qsqXaekqMRjXP+bVoryDL3uUWTnA1IqItUQKCnOxZnhfkFx/vS5j7ZxOzbQUJP0CtSXH5f5Zlb7ddZbhYScV5ep/wu1ANN/Tt8v4BTdIiNbgoZqe9Fso0xIonJtCeLaNmE7huyKICwvCdDfdGCwPGc9+oC+7aXOso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747512496; c=relaxed/simple;
	bh=iA1Y5fx4gXzRmsr7cuWs91Z2WnmPtG6tdy/PS9jMGS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cknwp1b4Tv0h3+u4UMUuZ19pGxRJ9b1LoNib7BVP2yJDXpVPsTGNGb1McYyv2aDAKU5fDwNZcEz9HDL6qqkaF8FdHEyxZITerpVfThq8hXFJuJCHCfMyiQVre30odlxiWyX+R0XrnyQQiU2wlb4V5yy7MpB0I35sBoGF6PoVy6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOcZ/UUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DFEC4CEE3;
	Sat, 17 May 2025 20:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747512494;
	bh=iA1Y5fx4gXzRmsr7cuWs91Z2WnmPtG6tdy/PS9jMGS8=;
	h=From:To:Cc:Subject:Date:From;
	b=oOcZ/UUxtdChgIw83wmcPrziPn3PbAwqdo2AFLMSQ62+TWl+XvFkxhP6jzPHDz3S2
	 NAs1iHjI9gJ+goNlfegx9e6zlFw4FdF/9o4AKnkXiOK+ntyf1P3TJzAsIY766jXBLR
	 zGvF0l6gY2sjtfUPg63+YsUcMqjuOn5SHrYivtuA3Lx/zThZpWl/0VY6AnXx7ZePil
	 Iq87IL8IRs0kyRNWzd1TRsTTWEwzDADEgPYUoj/zLv/7s09uYTYpkl4ayohykbvs8w
	 Pg3osMnydhlMJr7wIldTrKVByO2vgJHb/fT55gwwWyQLwWb3fl3ruVWGD4P4l0tpv+
	 HXbvaW1mZEUlQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	kuniyu@amazon.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2] net: let lockdep compare instance locks
Date: Sat, 17 May 2025 13:08:10 -0700
Message-ID: <20250517200810.466531-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AFAIU always returning -1 from lockdep's compare function
basically disables checking of dependencies between given
locks. Try to be a little more precise about what guarantees
that instance locks won't deadlock.

Right now we only nest them under protection of rtnl_lock.
Mostly in unregister_netdevice_many() and dev_close_many().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - drop the speculative small rtnl handling
v1: https://lore.kernel.org/20250516012459.1385997-1-kuba@kernel.org
---
 include/net/netdev_lock.h | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
index 2a753813f849..c345afecd4c5 100644
--- a/include/net/netdev_lock.h
+++ b/include/net/netdev_lock.h
@@ -99,16 +99,15 @@ static inline void netdev_unlock_ops_compat(struct net_device *dev)
 static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
 				     const struct lockdep_map *b)
 {
-	/* Only lower devices currently grab the instance lock, so no
-	 * real ordering issues can occur. In the near future, only
-	 * hardware devices will grab instance lock which also does not
-	 * involve any ordering. Suppress lockdep ordering warnings
-	 * until (if) we start grabbing instance lock on pure SW
-	 * devices (bond/team/veth/etc).
-	 */
 	if (a == b)
 		return 0;
-	return -1;
+
+	/* Allow locking multiple devices only under rtnl_lock,
+	 * the exact order doesn't matter.
+	 * Note that upper devices don't lock their ops, so nesting
+	 * mostly happens in batched device removal for now.
+	 */
+	return lockdep_rtnl_is_held() ? -1 : 1;
 }
 
 #define netdev_lockdep_set_classes(dev)				\
-- 
2.49.0


