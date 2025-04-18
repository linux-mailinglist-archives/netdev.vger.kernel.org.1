Return-Path: <netdev+bounces-184166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23331A938A4
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 16:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CAEC467228
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 14:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21BE1DE4FB;
	Fri, 18 Apr 2025 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvAQt92z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B22B1DE4D5;
	Fri, 18 Apr 2025 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744986285; cv=none; b=MENsZnT5gvKkqXt/FXTHux8X3aW+wvQFlB1aLxSrrss18SdoOs+SqE5i0IvzcWX8MLJqYd8UO5MA+AN7eWA2f4MJy4kCHcqXInQSAvbM0kVNN3scOSFRk7h1g5FiGwbgGAj9Y8W0DurwW4RYqywmJMwT57jRWETe0AcDmlHJS9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744986285; c=relaxed/simple;
	bh=VYc4cFX2kNa24+VMNVEjITkhtJG0EHEVrqimNoAqlQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZIkBmrlNgeAA/RO/pvnVMEH0isDhDYEiiOtI68dXlsVWtls0SNYo3QPNDBGALOtgH4KFe4SCiz63JQvmuNf/Wz4cghLuFWoe78aVmnBpvRfBj7M/4XNoQ/C+6OsCIhRsslzz8MnSdfigQXcmwJwJmyDsgvOjX3w8CfNNDUOtCqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvAQt92z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC8CC4CEED;
	Fri, 18 Apr 2025 14:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744986285;
	bh=VYc4cFX2kNa24+VMNVEjITkhtJG0EHEVrqimNoAqlQE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pvAQt92zkZx+onsQHNxzRQEupQHp8eFznCGYCeWGmlQfwPYcapTQrbevcMtB3YHQS
	 uKHS8DnNfTAKAmBtG3h5tvbqE+M5xpACwq/C3Nl+Pk/Yg5QPYsO4szANR4t55XcSnG
	 i+fSf/hVIyz8HtwFMmG6hqRHuHQoqwCdjR9i5+VIwjFe76xnAeBY4GJC/egbZ2xApF
	 Ms5Fg2Nb10Cpa0yPn0v2pGYcdHLMVeOBOk0ehnAnziHGSa9MYGWOFgXw2I1X1enUxM
	 /Ygrx2tB+WJH4jziuM68B6OUCwG5CFzFJ9Vh4C41TRtpUyx1w9ElyFPhBtS8Wnb3bM
	 1fuVP38JVs4+A==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 18 Apr 2025 10:24:31 -0400
Subject: [PATCH v4 7/7] net: register debugfs file for net_device refcnt
 tracker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-reftrack-dbgfs-v4-7-5ca5c7899544@kernel.org>
References: <20250418-reftrack-dbgfs-v4-0-5ca5c7899544@kernel.org>
In-Reply-To: <20250418-reftrack-dbgfs-v4-0-5ca5c7899544@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1306; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=VYc4cFX2kNa24+VMNVEjITkhtJG0EHEVrqimNoAqlQE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoAmCic1DxTa7/YRueIIGZpg4utucryKIFa0uLO
 Ib1Lc8GNpuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaAJgogAKCRAADmhBGVaC
 FYnNEADTvOQjXbqGWzjGC1YCBBgnunz+49uokptG6ejAhHPYiIlqQw2Wy9NFNITxfoNu5BZvs1e
 1HvUGL86LFtNSOqOfpPDG39kbdSnSnqKlHwUMA2wSqpiKnrkqjPr5E1Jk9USNXIRTXBdF9//uQ2
 0qbKjyMPYBSAcrn0vwjuAqFv/J0l5FzCRuwSQUU0iMhQeppwTU7imIcVN70vxCc3/Nbc5HXAZH6
 BgFyp4fodJmGYQEBfFz8ruiC7F+Fq1FbGRP8dEOZRtSFHo87+RehHGg5mwNQ2SIRnTy8BBVGEXI
 XVNv1yrheGXJ5An8rxkQzhzT53uYstGCALLbmQQ54AW7eUOSln06ao73YNmu0LbQ4OjXuvDFXta
 O7z0xnX48yme7DuPhBtABT2wqhDKyV0CBN3l2pgf3PYQYDMuCwi+2qzCPFru0PgPvPlN+zKH9lY
 q0gF6UQspx7djjrAqYSYgrtqBk4/UVhH9xWh2PBhwc0JXcGtvzrQJ7w3k9ojuJIew+WHNmtgQ1j
 dPLXbWtbGdzS1ZogoNF9XmLLtNAxdguV/k6hhKmpTZlpGVCTxCBJTMndXfQO56/mwoMfRGQMSfJ
 8mdZx3tDFqJkX7brojC/iLe+o19gXx1uMFvABFVZpZWldFg4kX9ZdNCVqDQH91wnwYEV23f3tpX
 AqUNLSluMusNfWw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

As a nearly-final step in register_netdevice(), finalize the name in the
refcount tracker, and register a debugfs file for it.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/core/dev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 2f7f5fd9ffec7c0fc219eb6ba57d57a55134186e..377a19240f2b774281088d91e7da3e4b6ec52e33 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10834,8 +10834,9 @@ static void netdev_free_phy_link_topology(struct net_device *dev)
  */
 int register_netdevice(struct net_device *dev)
 {
-	int ret;
 	struct net *net = dev_net(dev);
+	char name[NAME_MAX + 1];
+	int ret;
 
 	BUILD_BUG_ON(sizeof(netdev_features_t) * BITS_PER_BYTE <
 		     NETDEV_FEATURE_COUNT);
@@ -10994,6 +10995,9 @@ int register_netdevice(struct net_device *dev)
 	    dev->rtnl_link_state == RTNL_LINK_INITIALIZED)
 		rtmsg_ifinfo(RTM_NEWLINK, dev, ~0U, GFP_KERNEL, 0, NULL);
 
+	/* Register debugfs file for the refcount tracker */
+	if (snprintf(name, sizeof(name), "netdev-%s@%p", dev->name, dev) < sizeof(name))
+		ref_tracker_dir_debugfs(&dev->refcnt_tracker, name);
 out:
 	return ret;
 

-- 
2.49.0


