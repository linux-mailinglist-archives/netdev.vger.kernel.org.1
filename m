Return-Path: <netdev+bounces-182965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E39A8A73C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 20:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81A99188DFC2
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2457423BCF9;
	Tue, 15 Apr 2025 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyerSjS/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1A923BCF0;
	Tue, 15 Apr 2025 18:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744743031; cv=none; b=X97na6DmOdJPpYT9WQ6lIS9dmhsdi5aORt0nBCambz1tlRWG1v33GNKqv9TvmedtkCo6kQwh8tt/EnCcv7NkOlt8Od531Edv2kURqPF0yt4E3CMsZ9M+WLh9NBAmQpHT2TKUsn4S/2wDgLOMpOChvGKEAY9wTFGjYiTvwaR9Cps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744743031; c=relaxed/simple;
	bh=eNo92cBQpj7b/wXPctGVOxEdwuf4gwvq9WIYh0h6UHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BfVuR8CbnX/akL85M0akFecutZRf7G/+9B1KnEg1VZjaGyFxYTCd7+Kbn/XvsP4D3pGjB86aHxXHOCe+hBuoMKfNMwuIQySAB/AwSe47m4DZjCnUyYZmssT8T78funSslxsCi3Ah/VZagQI1NgYejh0/nHDm0M0OkxAKExxO0eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyerSjS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A10DC4CEEE;
	Tue, 15 Apr 2025 18:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744743030;
	bh=eNo92cBQpj7b/wXPctGVOxEdwuf4gwvq9WIYh0h6UHs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HyerSjS/6aAzezlSc3gBYhuL9hhRNx+FnY2OoaHiDkzH/NptBv0fP/pH6/TwqsGeQ
	 yB2qHTMwaa0g9Xmv8G5igRi7z6ZkRhrEqFk086NqCkZZcShvtsTzaA+Kho8foeN7+h
	 3de0hQnFUsnVhEBj7GxT1v0UXnSb5aFIzaUg78Z85ePUdgd4nNacO6zHm5dFPqXNMw
	 krq/BFEH0tJNL17pvCPD3R1O1yqbV8e4KL/uChHZ6ejZPf1pwvqaKsQ4bqnC6sSumi
	 wM5PHUpeuRjfz/8Vax1fNEUYjRH7HrcRKAH8tmH9MAl9OBiiJwnLO8N85CAWVbiMUT
	 1BCS1+5l961ng==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 15 Apr 2025 14:49:46 -0400
Subject: [PATCH v2 8/8] net: register debugfs file for net_device refcnt
 tracker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-reftrack-dbgfs-v2-8-b18c4abd122f@kernel.org>
References: <20250415-reftrack-dbgfs-v2-0-b18c4abd122f@kernel.org>
In-Reply-To: <20250415-reftrack-dbgfs-v2-0-b18c4abd122f@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1201; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=eNo92cBQpj7b/wXPctGVOxEdwuf4gwvq9WIYh0h6UHs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn/qpql9dLvQ2791q+lprZuHaoBkdii84MRD0N7
 TXJFPiTyOqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/6qagAKCRAADmhBGVaC
 FTdRD/93ofcBTtdawaS7TUKN3LMF6FihrTC8SETLsjf68JDuyvJlL16MlPl8FGFLNkfpK3R2JkL
 qk6ojNXvy2MfT07DgXTIk18F0FswUA1gDSgltYY54OZVOMxJcdWlOQIs2KpRQHXDl4gmyiithfs
 Uk3VBd4VcHl5R69yCuryWJE8NtIwvZilxTFMaxy2iHL5xNlUgWl+WleqZP+qMtRGDXzP5nr9pLM
 zIOXSPP9pEHiqqtMAKeOwucYpB15kQvF8IkIJqg+WgdvLyJpSJsgMdT49FluxXO6zJ2iC20VugC
 x1v+aSPWXD3ubL/xeXuNACFjmxRYBPK9W0C5yeWBa/tN37M4gGeMxEu3gQiIE/CKEfZnjDjB+r8
 E/PUXK2dI4T7BpGKI0M58dCLwrEErzCK6Gf/siUOHOpP3CZb7Etjk6Eg7yKU/VSYdv6PF5xKXDg
 SjukSDmHi95S1cbjeFryGHYrhP0PvxX8MqcPoQmxysUPEm+cssBNCzUKAI2LUYnLBV8081Ppd4V
 slJOrApdUanx24WyYL3aMuWTb6CLCalq6frzl/FIdOJpR/9P2v1jVqxtwa+dcwe6CuQvV7mB863
 DAMRH5xUQDJz3XvmIflSMVfPz2C4rMoE0nxCi3VN3mcYmTaezvXqXQM1y4pdwu0IV9RAOAR8ZXt
 TInjHXSNE0tNbgw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

As a nearly-final step in register_netdevice(), finalize the name in the
refcount tracker, and register a debugfs file for it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/core/dev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 2f7f5fd9ffec7c0fc219eb6ba57d57a55134186e..a87488e127ed13fded156023de676851826a1a8f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10834,8 +10834,9 @@ static void netdev_free_phy_link_topology(struct net_device *dev)
  */
 int register_netdevice(struct net_device *dev)
 {
-	int ret;
 	struct net *net = dev_net(dev);
+	char name[64];
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


