Return-Path: <netdev+bounces-108558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BE39243C4
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 18:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32401C233CC
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 16:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0CB1BD4F8;
	Tue,  2 Jul 2024 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnzXzmDT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B9615B104
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719938520; cv=none; b=PRWj9PPsTxQla97MRpRn5vm4imcxgc2SRLsvaIfY+/jZY6A0ODNaFTFw4NaKAebUypp3HSlQg2YBsv1N9oMPKPadLUsDICARrBWPjnh4igD5PUm91jIUUNOJX1O1+230QvjOmwrg3VsuSVvfozF1lTeTWBaFYtJqTUaUAQv1Ua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719938520; c=relaxed/simple;
	bh=CzDF+RAvljMge42z1X7reHYSbD/WJpVMxbN/Kf4mYHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qU0m1z9tscz36gfzr6Gv6b0CUn+9OHNjemSNyLsL01uIhHANUf4vm7MrwO7zItxX7QaLMPqc1vLuGTIbCeDFhjSgNl/K/UWf/cnaAOX0sys910vWvicPlHmjtCeAbDT63jpUdl6nfJIXCajmInBbfxX3Z1gfl7ALeOHfEagO7ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnzXzmDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8587C116B1;
	Tue,  2 Jul 2024 16:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719938520;
	bh=CzDF+RAvljMge42z1X7reHYSbD/WJpVMxbN/Kf4mYHQ=;
	h=From:To:Cc:Subject:Date:From;
	b=BnzXzmDTh7RT3DjvO2BRcEuDydWlbcUFSNoOlVd/yOOUAJl3mwdrfzmO5WaRd7b2z
	 21URkwzlP1qGH4s5ZzSqL3M75QtXaz6yXHUd+8CWWJ9j/PjIUPn/7H9tzIALpBX2AH
	 KfOufnfySBqaq9umAfzTsYX6k92GE9tzWm5iepFhDc2kJUO9OCj+PdBOXJEiDV0Y0R
	 SXH9J3e4OJenDerSzSbKbSxdl0dtT/IUnxkqIzkisnllvzK+cZTldL3NEr+1EE6MCk
	 c3TOQVQqXt2SzrJ/zoOFa5kd75Mc6yQUiAvNsbedR9EmdleX3cmtxBq8BkGJMkeJqn
	 UZPoJRicv2JnA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	przemyslaw.kitszel@intel.com,
	andrew@lunn.ch,
	ecree.xilinx@gmail.com,
	ahmed.zaki@intel.com
Subject: [PATCH net-next] net: ethtool: fix compat with old RSS context API
Date: Tue,  2 Jul 2024 09:41:57 -0700
Message-ID: <20240702164157.4018425-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device driver gets access to rxfh_dev, while rxfh is just a local
copy of user space params. We need to check what RSS context ID
driver assigned in rxfh_dev, not rxfh.

Using rxfh leads to trying to store all contexts at index 0xffffffff.
From the user perspective it leads to "driver chose duplicate ID"
warnings when second context is added and inability to access any
contexts even tho they were successfully created - xa_load() for
the actual context ID will return NULL, and syscall will return -ENOENT.

Looks like a rebasing mistake, since rxfh_dev was added relatively
recently by fb6e30a72539 ("net: ethtool: pass a pointer to parameters
to get/set_rxfh ethtool ops").

Fixes: eac9122f0c41 ("net: ethtool: record custom RSS contexts in the XArray")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: przemyslaw.kitszel@intel.com
CC: andrew@lunn.ch
CC: ecree.xilinx@gmail.com
CC: ahmed.zaki@intel.com
---
 net/ethtool/ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index d8795ed07ba3..46f0497ae6bc 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1483,13 +1483,13 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	/* Update rss_ctx tracking */
 	if (create && !ops->create_rxfh_context) {
 		/* driver uses old API, it chose context ID */
-		if (WARN_ON(xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context))) {
+		if (WARN_ON(xa_load(&dev->ethtool->rss_ctx, rxfh_dev.rss_context))) {
 			/* context ID reused, our tracking is screwed */
 			kfree(ctx);
 			goto out;
 		}
 		/* Allocate the exact ID the driver gave us */
-		if (xa_is_err(xa_store(&dev->ethtool->rss_ctx, rxfh.rss_context,
+		if (xa_is_err(xa_store(&dev->ethtool->rss_ctx, rxfh_dev.rss_context,
 				       ctx, GFP_KERNEL))) {
 			kfree(ctx);
 			goto out;
-- 
2.45.2


