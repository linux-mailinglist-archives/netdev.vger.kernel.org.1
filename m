Return-Path: <netdev+bounces-76382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F6986D891
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 02:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72870B223A0
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 01:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9602B9B3;
	Fri,  1 Mar 2024 01:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuT/u2Jx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4532AD2A
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 01:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709255616; cv=none; b=jwEmLl2StzNSZ08tB4A5gsVGK5k9I6g3ldQqdbNdcKRDtp58zIGG/7Jp07QUlG/lBuqkpJMcIHqj/2gwLklYniFBOJCH9D3xtfLIzRQ5vQhjV5rXNzPPizTXxDb3gIEFLPRTKrFwj/wzCW/VGVUo4GpR5+BZgw4J8TcfxEx+/dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709255616; c=relaxed/simple;
	bh=Cjdxju0o9i2QRy125ykTauGACSC+6yKkOGCKKsWsln4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TsIfDajYSDrgGtb+sFOtdLD58KC6/zmNzaMdm8hUQ6hlmeUBVH02/KIu3hqdmrcUA6dBovJmJ13Sbe43i7oJn/X8++pRZ0FqICu2xE+UPbsk0tKZzWQMp4EpfFhmUF7fSYmQMGU6k3fkby5e6uNJPz88y/CrGbB3iQvJt6tJ5Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuT/u2Jx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A06C433C7;
	Fri,  1 Mar 2024 01:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709255615;
	bh=Cjdxju0o9i2QRy125ykTauGACSC+6yKkOGCKKsWsln4=;
	h=From:To:Cc:Subject:Date:From;
	b=JuT/u2JxDVwg85MoRG3vWR4LTZ5n2Mfi0dlo3PZ4fisH64CY3x2trv19LytSEop/W
	 BPUgeIv016LDtHkn4KzW7mg6paSkH+5GYkYCoE04QHFq2AZyOPYDu1qyjWENUp/ZqB
	 LNEaXMmR/Rr0hiAMc4rahkENhlVSmiMZmAYRY2GonLajtOZyp1pEjdxkGSt5934FiJ
	 1bTlObbZojre+mq7VzZXmPbNrHD05/eyJOqw7oaDTseLUZ3fLQsipLSAePmmo7GCDl
	 /K6vHnLN2mCly5x7xgfRaS0ZDHwBRh9j1idbvwiSiEBMD5ZL7mpQob2/2LtYwEtBWM
	 ZFuifUWwCZA/g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	hawk@kernel.org
Subject: [PATCH net] page_pool: fix netlink dump stop/resume
Date: Thu, 29 Feb 2024 17:13:31 -0800
Message-ID: <20240301011331.2945115-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If message fills up we need to stop writing. 'break' will
only get us out of the iteration over pools of a single
netdev, we need to also stop walking netdevs.

This results in either infinite dump, or missing pools,
depending on whether message full happens on the last
netdev (infinite dump) or non-last (missing pools).

Fixes: 950ab53b77ab ("net: page_pool: implement GET in the netlink API")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: hawk@kernel.org
---
 net/core/page_pool_user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index ffe5244e5597..278294aca66a 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -94,11 +94,12 @@ netdev_nl_page_pool_get_dump(struct sk_buff *skb, struct netlink_callback *cb,
 			state->pp_id = pool->user.id;
 			err = fill(skb, pool, info);
 			if (err)
-				break;
+				goto out;
 		}
 
 		state->pp_id = 0;
 	}
+out:
 	mutex_unlock(&page_pools_lock);
 	rtnl_unlock();
 
-- 
2.43.2


