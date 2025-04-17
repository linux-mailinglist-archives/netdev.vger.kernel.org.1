Return-Path: <netdev+bounces-183759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F70A91D77
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F653188B8DF
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA48024EAAE;
	Thu, 17 Apr 2025 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9UJQNFr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28AE24EAA2;
	Thu, 17 Apr 2025 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744895490; cv=none; b=AP9gDfO/BFkiK/8WiN7oq7004fk7UNchQNPv8Q073Ike7Nf9Q7ZRlV1Gy5FFMbJj+sLyigiPK7kBxFAXA3cjFoRuDWjueRionwonX+wsTY+ah/Lhltibm4qEkyfjIVaO+W/lHEtNMq1m/JFAOh5cCQr8U56c9dpZDSxr++KMsQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744895490; c=relaxed/simple;
	bh=WQDl9VxZJGJoqqYLaCnumasFC8mQLUW7g6SKFZtqLr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fEk0ERprqbWSX1TIS/me9BLAMuZKGQPANWpkqykELjqfz4psUoFWvWa8IjbOqVxDy3vfgN6w8H7cMRNMOziPRKZpAUkhUI7Ao7578qy72AaxhEVJk/2EUOYTZFNxT4dYH3UOXvsJeGzDrk/k+izJZjMT1HRussJ6FNRVSUr+StA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9UJQNFr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78972C4CEED;
	Thu, 17 Apr 2025 13:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744895490;
	bh=WQDl9VxZJGJoqqYLaCnumasFC8mQLUW7g6SKFZtqLr8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c9UJQNFr4j85puVE4/6p/SXMaCK1qIz8a/vuV74smA+5l8+bOVVlrd8kpIDOUIGtp
	 BjsbdUVOTRpHfvYXjvthGkB23+wl9rqDLy63U6Oj77ASp8Y6rP8yqeICF11vl6s7UX
	 YQkjhTDgnKeTcwSk40owukbvs5C4Vj1YJpHTDvfOeuRJD3LMphVRpkUzX0vWcpijtg
	 2hx+qS7gTjkJKL5i+drZMid4E1JqcZ/wvZFWv585L0CcsMS7LrEhtOj9rjVGFLDyDv
	 bupMr7CWgWRFuPxoKlLTc2WIThUSaUuEYDsUqFBM0455ndKfGaGeKdB8vIh4BvmTY6
	 g/shviy9PWY5Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 17 Apr 2025 09:11:11 -0400
Subject: [PATCH v3 8/8] net: register debugfs file for net_device refcnt
 tracker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-reftrack-dbgfs-v3-8-c3159428c8fb@kernel.org>
References: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>
In-Reply-To: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=WQDl9VxZJGJoqqYLaCnumasFC8mQLUW7g6SKFZtqLr8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoAP33hN4AKv5WkgFj3GwxmPh8a5UgMisNFvL3/
 4ENENdZxM+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaAD99wAKCRAADmhBGVaC
 FfmiEACpfLEr5qELW0papwIkeezJNBKDC9gbQuhKOeZbJjw99mc55OS7nfmO1hF09lofIx7Hlfy
 sfcdzCj0+9DKI76uhzdVSqlREYAcaX3oyDJ5HdnzVCcoJ9zg2MQGGeKbLW2pjcV8h/hVzRKgHkM
 STTbaQfnUfYAQzc85s6R5cVmFtT2B8dpupBlSI8PZpF2T2wr1vBsD8twOXnYMcIYW6pQS4bUHuJ
 XIVKKGYY1+qn6wTGla/er6xpmr7m1O3L9T2ysMFHiP9kK5pZ3RMBB5agrnJvIdeTrybqKeRT1Ly
 QUeKGVg/T5+wqlmMLcUJcQFgYVH22KYvx5vbNwRX6v78T8fxJHKYvxgiHXGdHgsx9w+wAWCvwYu
 NVpaKct+r8PY3ZIhrUKrTm7MusfdYkZdbPImr2qo1BYmqObszhztV9O0Y/cwqP0H3wPqrxyyV0A
 8CmVFPsOUgNsLf9Bc05oKmOHvUFfWAhcYrkEtrp2GqJv4jI9jnkMswVi4o/KQ3CMi4/jQVmeZYW
 FqBxXrRnSvs/gxf3aP8davFA1plQGf0mj8IeoreEFyhNbz7eS8eQAa0Rq0FT/RmDbU/BbuqPQO9
 2uZrPgDfhYzcLI6l2Fndt2ro/4KmVPx7DsP+UHsJu4i/PsVOZ/l6CrM5l6Xr0LujGs1uJooXttp
 Tvk2NmxE71gydsA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

As a nearly-final step in register_netdevice(), finalize the name in the
refcount tracker, and register a debugfs file for it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/core/dev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 2f7f5fd9ffec7c0fc219eb6ba57d57a55134186e..19fa4f2caba28cadf55ed1655b69b6eb1170d799 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10834,8 +10834,9 @@ static void netdev_free_phy_link_topology(struct net_device *dev)
  */
 int register_netdevice(struct net_device *dev)
 {
-	int ret;
 	struct net *net = dev_net(dev);
+	char name[REF_TRACKER_NAMESZ];
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


