Return-Path: <netdev+bounces-14653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85FA742CEE
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 21:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6332528094E
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 19:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094D5168AC;
	Thu, 29 Jun 2023 19:02:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F03168AE
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 19:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7747BC433CC;
	Thu, 29 Jun 2023 19:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688065338;
	bh=x5f/0OP5DmFPrMmGOnST/mYYWSC3cHxDbbtZMsxsoAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BpErmPvUXjnwIPLaMmM5JBhnHHrDsRnKUD048WZPfS+9XSIHcJPWbEnisJdhSz6X7
	 WpWDrK2W73cjjLJ7wn43szznE6Q8wfs6whj2o1rKl7k50tgyGrfPn+1cY56/dAZ6dH
	 qtEJFp9J6SxhBMTIS22yKCfyvHqb0wtLDbWi9CRTME9jpPxasURhTeSv/3PgprzL2r
	 oEddI6uRZuxisDp7ub2vVGBXZ+RDqUFlly9d2ZBTUH72ybBTlMol1VTQv+WYulhmgx
	 3VmV0dzBohIzFbErTI3gIpMbQTNG+LAf2ynebaYazueA5ZxbLqCD7Pfc0sAYciHtL3
	 HL5iNUMp0Q2Sw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 5/5] net: loopback: use NET_NAME_PREDICTABLE for name_assign_type
Date: Thu, 29 Jun 2023 15:02:12 -0400
Message-Id: <20230629190212.908306-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190212.908306-1-sashal@kernel.org>
References: <20230629190212.908306-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.248
Content-Transfer-Encoding: 8bit

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

[ Upstream commit 31d929de5a112ee1b977a89c57de74710894bbbf ]

When the name_assign_type attribute was introduced (commit
685343fc3ba6, "net: add name_assign_type netdev attribute"), the
loopback device was explicitly mentioned as one which would make use
of NET_NAME_PREDICTABLE:

    The name_assign_type attribute gives hints where the interface name of a
    given net-device comes from. These values are currently defined:
...
      NET_NAME_PREDICTABLE:
        The ifname has been assigned by the kernel in a predictable way
        that is guaranteed to avoid reuse and always be the same for a
        given device. Examples include statically created devices like
        the loopback device [...]

Switch to that so that reading /sys/class/net/lo/name_assign_type
produces something sensible instead of returning -EINVAL.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/loopback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 14545a8797a8a..7788f72c262e6 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -206,7 +206,7 @@ static __net_init int loopback_net_init(struct net *net)
 	int err;
 
 	err = -ENOMEM;
-	dev = alloc_netdev(0, "lo", NET_NAME_UNKNOWN, loopback_setup);
+	dev = alloc_netdev(0, "lo", NET_NAME_PREDICTABLE, loopback_setup);
 	if (!dev)
 		goto out;
 
-- 
2.39.2


