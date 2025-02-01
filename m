Return-Path: <netdev+bounces-161887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDEEA24635
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 02:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8143716794F
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 01:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22B31D555;
	Sat,  1 Feb 2025 01:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bx32FJv7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2B917C91
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 01:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738373459; cv=none; b=Z1u86scqeuP+9mGd34oydfTyYV2LY0lELZItyf8PLcF5KNzwFJ4ScM95cjYOsr1GibTAGHcQuBZxwIdKt39NVZZiCbJeLx5uu07Za4PHUwn4yZk15lBm9ixoYzz5dA0bwTEgtKyhVCoFJKerueDa2d0ADDtGbe3bYuKmnIm7u2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738373459; c=relaxed/simple;
	bh=LxvN03VahFM8lOIsUmvolYJQJd9OUEuz0HRUhUCmKAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mW1rmT0xhX6fx0xpwirqHra5kfPdW6KSxba/i+8Bkaxk0m3vRAgk3qVCvYbfia4CVkO6V+R47UxyZpB8OmmssjqSkw40Gx4IGsHuukayKZAJGNCA90c0QscwKh4kV23kfR1kAckvt9iSjul1I3euIKIiCjo5JcuOWFMVv7SRlnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bx32FJv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4AFC4CEE7;
	Sat,  1 Feb 2025 01:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738373459;
	bh=LxvN03VahFM8lOIsUmvolYJQJd9OUEuz0HRUhUCmKAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bx32FJv79d2G+XDsKikzfQkRPjLwUvJi3h8jrrP+Vyse0JC768+W+q/cKOoB54C6Y
	 c/ft+vY1X21PCmTBjLiAiPtpG+pgYfVZpHwLgsPqcF1AQWlXtPHnC7MFmGHcPvzqMA
	 gw7HmiPQ/O7yfe8oClIKxNAb3GIRUJAmbIlZvpRT11nsEJF3WfEulvQtFN5WZ1iMWy
	 vHteLj0S+jK3yjAakbmgDv9BFZy2vweLTfxwQPXBli45VklucKJ24wuWk6P98U3LXz
	 xI8ofJ2p76OOKboUJNDWCVFOgDzVL/I3f24A/lb4yO5l69XLPv/i7g5Y59tk1WgYtq
	 7IewVecKfezzA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	ecree.xilinx@gmail.com,
	gal@nvidia.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 2/4] ethtool: ntuple: fix rss + ring_cookie check
Date: Fri, 31 Jan 2025 17:30:38 -0800
Message-ID: <20250201013040.725123-3-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250201013040.725123-1-kuba@kernel.org>
References: <20250201013040.725123-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The info.flow_type is for RXFH commands, ntuple flow_type is inside
the flow spec. The check currently does nothing, as info.flow_type
is 0 for ETHTOOL_SRXCLSRLINS.

Fixes: 9e43ad7a1ede ("net: ethtool: only allow set_rxnfc with rss + ring_cookie if driver opts in")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 34bee42e1247..7609ce2b2c5e 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -993,7 +993,7 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 		return rc;
 
 	/* Nonzero ring with RSS only makes sense if NIC adds them together */
-	if (cmd == ETHTOOL_SRXCLSRLINS && info.flow_type & FLOW_RSS &&
+	if (cmd == ETHTOOL_SRXCLSRLINS && info.fs.flow_type & FLOW_RSS &&
 	    !ops->cap_rss_rxnfc_adds &&
 	    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
 		return -EINVAL;
-- 
2.48.1


