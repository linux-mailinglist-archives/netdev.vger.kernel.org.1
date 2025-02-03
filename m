Return-Path: <netdev+bounces-162067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48177A25A3D
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 13:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0E33A3CE1
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 12:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF5B2046B4;
	Mon,  3 Feb 2025 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwUuFOSV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5F6204595
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738587570; cv=none; b=EI4BJoK3GEOX+w8Asl2W8gFjF16vG7iIqyCsRW1oAHFn0bESzEn7bCwW9buYYeUNNSCGSMZpltCUDzco4znz0uCfLV227H5m8cR8w6z+9Yq0blFAhlHYKRO2rwHrpzD9aUYszQ0H3kRNYr3hW221+zBPzVtEMW00TIoLvCVkhms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738587570; c=relaxed/simple;
	bh=5uyJxssV596p6f8mslUcXQKPAsqMMuYY065Ux9B0v0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lehb9OeIEFYVX7Lp0cAYmaEjBltP/H9Q9Z5wMZ2XwWBxvbXpyV+pGzG9s94L8peAVfuLy8MHv2QznrSbJEdLVM0et5s2byKcyzoPtS8XQj1MWkFdoqyXclD5wS+1J05liTe61wkfgRYU03g/epayXZmzgf4/b9gUgAW53HadlAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwUuFOSV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC7EC4CEE0;
	Mon,  3 Feb 2025 12:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738587569;
	bh=5uyJxssV596p6f8mslUcXQKPAsqMMuYY065Ux9B0v0Y=;
	h=From:To:Cc:Subject:Date:From;
	b=OwUuFOSVJh44Zl8L0XrnGtMDNw0rc7cSOiJMAyzcfNSDlFghYvEWExXCHKlkVwnN6
	 NuK6ekdzfiT6ChaoNOmxQmMDj2IgDPt4F9kK+QKCf1fqsSBIR/9ATO8Yt+TSLdjXKy
	 0jHMPMJBKiiOOkdtp20tuKe6DGoGvL4LMZTwKKiim+VQ6yI8Lsv5YAC512VV5dNz7Q
	 CZla2a1QyewYgB7hhQUyXNIebxlVwLrrhK6SMGjeXGGBJwrnNNQsLW92JSLa6n2ZTC
	 DKe7zB1gxALWH/hwpVQQ9hoXz0tvj3bguJD0XfNYSDRQmtENZaZ2k+R+i2zx5/oVcy
	 K+ynFG+E+iPcQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] bonding: delete always true device check
Date: Mon,  3 Feb 2025 14:59:23 +0200
Message-ID: <0b2f8f5f09701bb43bbd83b94bfe5cb506b57adc.1738587150.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

XFRM API makes sure that xs->xso.dev is valid in all XFRM offload
callbacks. There is no need to check it again.

Fixes: 1ddec5d0eec4 ("bonding: add common function to check ipsec device")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
There is nothing urgent in this change, it can go to net-next too.
---
 drivers/net/bonding/bond_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index bfb55c23380b..154e670d8075 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -432,9 +432,6 @@ static struct net_device *bond_ipsec_dev(struct xfrm_state *xs)
 	struct bonding *bond;
 	struct slave *slave;
 
-	if (!bond_dev)
-		return NULL;
-
 	bond = netdev_priv(bond_dev);
 	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
 		return NULL;
-- 
2.48.1


