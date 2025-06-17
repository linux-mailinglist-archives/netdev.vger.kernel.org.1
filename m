Return-Path: <netdev+bounces-198473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5287BADC43B
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 10:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F7D178846
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 08:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CDF293474;
	Tue, 17 Jun 2025 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/7Ef0Eg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E49C76026
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147627; cv=none; b=Uf1LdaqX+ZcbTebh5zsbAH92yDMFP+3knh48pkzHOr3GW5SScbHmA5opgLvkVXCxCnGH+6PFf0LVMWD5dtCiliIROdYel2i/wFceMDu5SnAdyBjqxP0eYxOzqF75qbiOIps4Napvv75+IZh6mPFHvCDe1jn4DdGyNf34Z86Eq+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147627; c=relaxed/simple;
	bh=pACZh5Ors2JWoBCQ5wSD+JCjZ16wNiaxqRMKQ07Qx94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O+eqFsQgxW/PknL2r6Y8c6jbC+A2r9VE/rLeXmBWE/FfA/v/GJO3iUUXgCVnk3M9ynqEsir7PjeI3RNOEWvbBpnDgjNUyPN80zIzne5SSnArxuHlEXXIKJ8yR91laFGi9E/p59V1hJzW4ZMr86i4SMbBFz2p3H3wzloOZrsZyXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/7Ef0Eg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05635C4CEE3;
	Tue, 17 Jun 2025 08:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750147626;
	bh=pACZh5Ors2JWoBCQ5wSD+JCjZ16wNiaxqRMKQ07Qx94=;
	h=From:To:Cc:Subject:Date:From;
	b=M/7Ef0EgiD/sWm3Xpz2M1GcwqXx2hvyq/dspg8Qn7h9Wx5q05MxJ0n9G+wknK7r2W
	 uaMjk6gxSJDT+R5FFJ40kVGhyioBLlravsm2OXlO5+LMt1sEK6+LwCuwoXZl9NZ9Cg
	 u7R7e7Njgx5rNhLjaikmv/Ld4vVn6zgUMKfxcO6XUiBU1GqQobtrhsrNEm3a8DNRGc
	 6RTLidOiU0d1s/hHOb5Juy0AaLJriFsPcC4co78i6MKP81bnFtB2FN+yVjDG6nZCsm
	 +Mf29RmCgrIsJKO9/QE0ngxLTtOnDzaUei0NOiElWyjiE2udof/lLedkHtqTOZ+2Ky
	 rBuph3Az8t+9Q==
From: Leon Romanovsky <leon@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>
Cc: Mark Zhang <markzhang@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next v1] net/mlx4e: Don't redefine IB_MTU_XXX enum
Date: Tue, 17 Jun 2025 11:06:30 +0300
Message-ID: <382c91ee506e7f1f3c1801957df6b28963484b7d.1750147222.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Zhang <markzhang@nvidia.com>

Rely on existing IB_MTU_XXX definitions which exist in ib_verbs.h.

Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Changelog:
v1:
 * Change target from net to be net-next
 * Rewrote commit message
 * Removed Fixes line
v0: https://lore.kernel.org/all/aca9b2c482b4bea91e3750b15b2b00a33ee0265a.1750062150.git.leon@kernel.org
---
 drivers/net/ethernet/mellanox/mlx4/main.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index febeadfdd5a5..03d2fc7d9b09 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -49,6 +49,8 @@
 #include <linux/mlx4/device.h>
 #include <linux/mlx4/doorbell.h>
 
+#include <rdma/ib_verbs.h>
+
 #include "mlx4.h"
 #include "fw.h"
 #include "icm.h"
@@ -1246,14 +1248,6 @@ static ssize_t set_port_type(struct device *dev,
 	return err ? err : count;
 }
 
-enum ibta_mtu {
-	IB_MTU_256  = 1,
-	IB_MTU_512  = 2,
-	IB_MTU_1024 = 3,
-	IB_MTU_2048 = 4,
-	IB_MTU_4096 = 5
-};
-
 static inline int int_to_ibta_mtu(int mtu)
 {
 	switch (mtu) {
@@ -1266,7 +1260,7 @@ static inline int int_to_ibta_mtu(int mtu)
 	}
 }
 
-static inline int ibta_mtu_to_int(enum ibta_mtu mtu)
+static inline int ibta_mtu_to_int(enum ib_mtu mtu)
 {
 	switch (mtu) {
 	case IB_MTU_256:  return  256;
-- 
2.49.0


