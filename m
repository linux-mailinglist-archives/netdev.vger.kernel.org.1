Return-Path: <netdev+bounces-51896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C347FCAAF
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68FA1C20EC1
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ECD5C3DD;
	Tue, 28 Nov 2023 23:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyUpvDd7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481325C3C5;
	Tue, 28 Nov 2023 23:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0247DC4167E;
	Tue, 28 Nov 2023 23:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701213564;
	bh=jAuqtIZ6y5xknP5XM9ZdxCIvw7Lzknsk+buxAL1vfvo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pyUpvDd7gUxi3SIJ9TH8luk5XyKcZrL2PerB98S1pFyE6zWK7vpuaiXM1/B2ivCjA
	 iXbXvDvBx9VI7zXA44eLQprVSGlb5CUUS1RNPGGL9RayPWczcL/KK0du4ba287CSrE
	 T3VmD+XMKIAYFMyhv64fX1eF2JVeX7cDT6luMZFLcW48AUWOrZZA8EBdm7IsoZcKMU
	 flF80mR0wIU4zieiHkOUbww43zxThF0J61d69HZeD0SiXNbrDjM7indvVX+f2m6s4E
	 /4udSrwEgT+efJIhO5hKik4nhv6GmPgat8Aunj7+4mILUlWO/vS+SritUm1G0VzHAP
	 8RPV2rY48jjfA==
From: Mat Martineau <martineau@kernel.org>
Date: Tue, 28 Nov 2023 15:18:50 -0800
Subject: [PATCH net-next v4 06/15] mptcp: userspace pm rename remove_err to
 out
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-send-net-next-2023107-v4-6-8d6b94150f6b@kernel.org>
References: <20231128-send-net-next-2023107-v4-0-8d6b94150f6b@kernel.org>
In-Reply-To: <20231128-send-net-next-2023107-v4-0-8d6b94150f6b@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.4

From: Geliang Tang <geliang.tang@suse.com>

The value of 'err' will not be only '-EINVAL', but can be '0' in some
cases.

So it's better to rename the label 'remove_err' to 'out' to avoid
confusions.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/pm_userspace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 5c01b9bc619a..efecbe3cf415 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -276,12 +276,12 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
-		goto remove_err;
+		goto out;
 	}
 
 	if (id_val == 0) {
 		err = mptcp_userspace_pm_remove_id_zero_address(msk, info);
-		goto remove_err;
+		goto out;
 	}
 
 	lock_sock(sk);
@@ -296,7 +296,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		release_sock(sk);
-		goto remove_err;
+		goto out;
 	}
 
 	list_move(&match->list, &free_list);
@@ -310,7 +310,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	err = 0;
- remove_err:
+out:
 	sock_put(sk);
 	return err;
 }

-- 
2.43.0


