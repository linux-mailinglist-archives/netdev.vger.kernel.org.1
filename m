Return-Path: <netdev+bounces-182272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3CCA88668
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E7F1905B50
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A6F28A1C7;
	Mon, 14 Apr 2025 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPx99ufO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A7A28937D;
	Mon, 14 Apr 2025 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641961; cv=none; b=CU3JzcGMSlhV4uSsB5HN0SV3SP5e4UHpvSOubPaWT5LO3g3jpv3W0UpGCy5R/FXtH87+OEKHkfthN0TiBVc1hKMv4Twuki3yliyVdShm9EjkR6r0qktRQOfIeh32mtEMCvEiJCUpdUQ8KZbwtLK7agHlrCkASytSY3eWZH8IyxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641961; c=relaxed/simple;
	bh=LtVONm9f6LVh+uOhagzHyX5XyhmKUXGOJrHT4/14OCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WAJvf4WjLHF0NXxIi7AUbAkcBB4wpXD1zJJrj5hvIE1TQoHGOk2yFMuBSP68tqRY6ANvYdRnZpZeYAk9Uml+uNj83HWcDs+acvGwQC33N1StdACsNI4Ui6gsq5ttswtfPXNE0+phDP/9CuKcJAB3H3ie6Zu1TSoiewbrmo0luT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPx99ufO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B13C4CEEB;
	Mon, 14 Apr 2025 14:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744641960;
	bh=LtVONm9f6LVh+uOhagzHyX5XyhmKUXGOJrHT4/14OCI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TPx99ufO5L0EEqnYXv1CL8LWYSsBHXFHzSazl078qNA3sTcq3n3JwiGJuAaMR+j8E
	 KfPmX24fo5HPapGHtqOjhpFwv4oEXQQLXBnL2ztdzA6okGjFSZoVi/GmClBaHBB8KK
	 Oyzu1kT2MfsdBcnpcVNGU9ZVGmDmqYAiwOYZHGIIQ7QkKQBI1tq5q5+NR9XTr+/izU
	 oDUO3GMMG1LnB8YprjjfGPzP4F5KqFO60l32P3f9MZnS+BQUzzLt/WoCiEir4Ycbtf
	 kS7LOWAsY0LHHEuFvhQ6hakNIhWuthZlyRsKmD1+5KRYZXqVbF4NEDxi0Rljjd99su
	 P80WzjWBHl3sQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 14 Apr 2025 10:45:49 -0400
Subject: [PATCH 4/4] net: register debugfs file for net_device refcnt
 tracker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-reftrack-dbgfs-v1-4-f03585832203@kernel.org>
References: <20250414-reftrack-dbgfs-v1-0-f03585832203@kernel.org>
In-Reply-To: <20250414-reftrack-dbgfs-v1-0-f03585832203@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Qasim Ijaz <qasdev00@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=780; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=LtVONm9f6LVh+uOhagzHyX5XyhmKUXGOJrHT4/14OCI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn/R+iIfOuXFQqARGbygeisj/5a536bm6dqV6+g
 bhATKwQcz+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/0fogAKCRAADmhBGVaC
 FbInD/9q4YHd1P32c1dDYiQoHRKo14yZQ7HGWWTIoiE4RMAY4GmtVn5JdCFG6k+b2ktMJpmiiYN
 4/tfxYpOibfpc2QjtJIznVrFHfB3No6xw4REAIKYq0rAKCaJSf0LoPkJybdLlb5wS2X5LP+FwSE
 vRuM76sKzWOenGefZkNcdg1Zrd+HXi9SMpjLu4fGfWz5PzsbrCzADodMJ0ui2cOpKZgfgzw0L72
 ztqXAmLlzi4cGV7B681oJTbihdVBZpXNO4qVqYLOx1T1RGrlHoZ/erNT2txpF0JAuZQ+nkJ7nMe
 PvJ84TeMIiXRzAL8y2CG4Oom/lX2CMwxU4hLYDZTA3MGXhdCkSgHKZDtZXz+K02APeZum12LfNF
 VKYCIsTsRCuWkWXEbTIgRiuYYpZZjikAL0T2ru4GwBFUufJmPWU8pRjXIdVMzNsV+2yz2lVc76/
 ZF/05VYAYWMlmcbyvF1SijAnrHFQf9sbtgQ90inXxv7da2PDZiqdTZSaq9hoi0omMk/Cmxdru9Q
 AWbt2sdWCEEBL9OcPwU08u2JTh7xjzyMiX7qmNEw86GlzfGWI8PFs080qKVHNEiX4mRkk0UsmlY
 s5njbFZEr9Wyl4u1aREbrgOn8k0V//3e5bFujRl7NZzwZhBBsIbimevSQd90tlIDwJulFHPJEZ9
 hgbgxcHAD1D7RPg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

As a nearly-final step in register_netdevice(), finalize the name in the
refcount tracker, and register a debugfs file for it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/core/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 2f7f5fd9ffec7c0fc219eb6ba57d57a55134186e..db9cac702bb2230ca2bbc2c04ac0a77482c65fc3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10994,6 +10994,8 @@ int register_netdevice(struct net_device *dev)
 	    dev->rtnl_link_state == RTNL_LINK_INITIALIZED)
 		rtmsg_ifinfo(RTM_NEWLINK, dev, ~0U, GFP_KERNEL, 0, NULL);
 
+	/* Register debugfs file for the refcount tracker */
+	ref_tracker_dir_debugfs(&dev->refcnt_tracker, dev->name);
 out:
 	return ret;
 

-- 
2.49.0


