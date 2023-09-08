Return-Path: <netdev+bounces-32618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9EA798C64
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 20:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC562281BF0
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 18:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC9814AAA;
	Fri,  8 Sep 2023 18:14:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A2E14F61
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 18:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBB6C116A5;
	Fri,  8 Sep 2023 18:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694196858;
	bh=sAJVwDnVfMC68NnK7e6bGEnmQvv4Qz9zWh7h7t9PFqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eDueDMfnCslX+oAth2yeDaqk1JfRomVN/zDort4Ta3EuISCLYgNlauy5Mhw4Q9A9A
	 9L+gudNIVeYBuR790uYd8w11bmCT2ew142sWP6WR5W3e6BabqVRxMJpMUghJL4fP16
	 UYbeXdI9xonj1y+VkvNUbgEe+XbEjx8hYbvQyRzxhWZ5ZgiT38XUSnlp0homGTuw04
	 LbFMgQbZxyThEE7bJrcWo1A5gk8ss4lWGGb6AA/uxYqlP5Y+si+KlG4DTe7KhZkTAV
	 r49rP/Z2HuHVgQ9nMGRgMXXk+3PIPKqzuJ44BDyW0lM0aNgRPEf4dJ/kK1uYu14YY3
	 TG9E5N1Lx1KyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: xu xin <xu.xin16@zte.com.cn>,
	Yang Yang <yang.yang29@zte.com.cn>,
	Si Hao <si.hao@zte.com.cn>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 18/45] net/ipv4: return the real errno instead of -EINVAL
Date: Fri,  8 Sep 2023 14:12:59 -0400
Message-Id: <20230908181327.3459042-18-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181327.3459042-1-sashal@kernel.org>
References: <20230908181327.3459042-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit

From: xu xin <xu.xin16@zte.com.cn>

[ Upstream commit c67180efc507e04a87f22aa68bd7dd832db006b7 ]

For now, No matter what error pointer ip_neigh_for_gw() returns,
ip_finish_output2() always return -EINVAL, which may mislead the upper
users.

For exemple, an application uses sendto to send an UDP packet, but when the
neighbor table overflows, sendto() will get a value of -EINVAL, and it will
cause users to waste a lot of time checking parameters for errors.

Return the real errno instead of -EINVAL.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
Cc: Si Hao <si.hao@zte.com.cn>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Link: https://lore.kernel.org/r/20230807015408.248237-1-xu.xin16@zte.com.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 6ba1a0fafbaab..f28c87533a465 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -236,7 +236,7 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
 	net_dbg_ratelimited("%s: No header cache and no neighbour!\n",
 			    __func__);
 	kfree_skb_reason(skb, SKB_DROP_REASON_NEIGH_CREATEFAIL);
-	return -EINVAL;
+	return PTR_ERR(neigh);
 }
 
 static int ip_finish_output_gso(struct net *net, struct sock *sk,
-- 
2.40.1


