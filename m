Return-Path: <netdev+bounces-153215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D599F7353
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 04:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DADA1669D6
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 03:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D809D136E09;
	Thu, 19 Dec 2024 03:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XP9zd6fc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48662AE72
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 03:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734578915; cv=none; b=FgftW3H8BwnBuJIdkIZ8tNtL6MshD/Og6vn9GTzfM1RiuP8VsgCP5aiR2LdZiLX3lgDxq4OvKngfHAU6ivftVVdLjK6O+GzKR7kwowjxh7HVFoLJkZoqO9GBeOUa9uVqnvUvNPa8uhia4pmdh878LguyOPg1VUVgXnhhW4OwSlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734578915; c=relaxed/simple;
	bh=K98nzwZdrBaj6n5MfiOuK/XIM5QGN2s3GR+bpGzt0GA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KcqSWn7IKNQY7qVK/zgrYOwQ5YbC2ujLRnFY5CB3AvNcRxpuJ4s+kLndMm2LOF7j/Ep8kxZqTSkTdCRJIuxpBj5b5J/RtB0z/xpEyNor45aVKbuHajSPbYxMyzdWv4MjlqCcLnkmxxT2cLfe044TEDhEuN3YamJwdtmqv9lkLH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XP9zd6fc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CAFC4CED4;
	Thu, 19 Dec 2024 03:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734578915;
	bh=K98nzwZdrBaj6n5MfiOuK/XIM5QGN2s3GR+bpGzt0GA=;
	h=From:To:Cc:Subject:Date:From;
	b=XP9zd6fcs0rC1gN0mj6FauYc67SpBu4Hj2RAUJD7MfSJ32QxsChnPmwALMVChD5hk
	 51+lL/RJGgpGiHGnIvBSf2KjMP3pVYRY5oV4Ycg/hGeW+IP5dDLhYKj0SxTh5PipGw
	 Z6T313QDJmGuQiS63X33inCKOvt1RwWYV709U4NK4zgpgYi0iEwTjO2R6u3n+BSFmn
	 JGtCoCbKSRztWUc+HdetyCRu0V/Q0WSfgceirBBrX+A520WDYOn1h6WS3RJWQUGAsf
	 CWputvfik0+DKx7tswqx1NGuY71TRR1qhftk/+WI6XDm5cpVQa6+SaB50+BIahZ66o
	 +HSik99DPuNmQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jdamato@fastly.com,
	almasrymina@google.com,
	sridhar.samudrala@intel.com,
	amritha.nambiar@intel.com
Subject: [PATCH net v2 1/2] netdev-genl: avoid empty messages in napi get
Date: Wed, 18 Dec 2024 19:28:32 -0800
Message-ID: <20241219032833.1165433-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Empty netlink responses from do() are not correct (as opposed to
dump() where not dumping anything is perfectly fine).
We should return an error if the target object does not exist,
in this case if the netdev is down we "hide" the NAPI instances.

Fixes: 27f91aaf49b3 ("netdev-genl: Add netlink framework functions for napi")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - fix the locking
v1: https://lore.kernel.org/20241218024305.823683-1-kuba@kernel.org

CC: jdamato@fastly.com
CC: almasrymina@google.com
CC: sridhar.samudrala@intel.com
CC: amritha.nambiar@intel.com
---
 net/core/netdev-genl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 2d3ae0cd3ad2..b0772d135efb 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -246,8 +246,12 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 	rcu_read_unlock();
 	rtnl_unlock();
 
-	if (err)
+	if (err) {
 		goto err_free_msg;
+	} else if (!rsp->len) {
+		err = -ENOENT;
+		goto err_free_msg;
+	}
 
 	return genlmsg_reply(rsp, info);
 
-- 
2.47.1


