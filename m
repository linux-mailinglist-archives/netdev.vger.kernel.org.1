Return-Path: <netdev+bounces-103404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB8F907E35
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 23:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09089B23735
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 21:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2016B13D24E;
	Thu, 13 Jun 2024 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0N4uuak"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12CA7FBD2
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314399; cv=none; b=BGCKvE4v3ictf5D1iR2q/3TolDM8oQilKyvi4A/G06nNOhltFo98fO4++v9HYfxTPTef1DhjzE2KuZJxvblIFXevd7a0Fj1VHBzkFolaRTydisFVR93MqrrT1Kac4COfrGe9Y6HvCExqge8MdCrh68Gi5jnpGqwJudzkYwOvmSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314399; c=relaxed/simple;
	bh=oX3mcOn7nb74hISDE+BUAMUTMMypRQDxk9hsVkHqpJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YPOqDzIeX7ypRpMXN/RG3NLFurPKSfV9ejrOsrGCXY2Ztj0DWAoRV3i0v3ZEuvLl25qjpBYUUFkD8NjYQ4olOmISJhbp9VVW1as+TspYD67wxKX+WtXQb6aPWyivAwcdzaQL+fEYB3fTDH4ihGLD0vMiI5mnFY0NRIBsCdTQhEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0N4uuak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48185C2BBFC;
	Thu, 13 Jun 2024 21:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718314398;
	bh=oX3mcOn7nb74hISDE+BUAMUTMMypRQDxk9hsVkHqpJM=;
	h=From:To:Cc:Subject:Date:From;
	b=J0N4uuaklZFQNZw/sMG++ji9Dja7HUa21MxVSKnv3dnVL5QQyEI5nhspPcsocwpT+
	 s2exS+Y4ipaGoVClG5LCFToHtYsUY2bRmY4emVkTM8cDSbgo6DdI7ClYjXJPkfBCU7
	 D6ChN5aUy1n//Erb/eH8Xt2zzFFvD3NzhPtxsV+2KAdnunEFYj8qn60UxHxbPDtSVE
	 qoWq6SO9II+FAI+NQbFDEszyd+ivuN548iAaBx+te6XYUqj03BVVKjfXWdA1bSJPrH
	 j8Ow/5lJSKShKc+fHRKMLYlN1anNtzY7Exk4O8Ds9YhoFixHbAzlYku/c+8jZlVFjC
	 DfZtZslBgci9g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] net: make for_each_netdev_dump() a little more bug-proof
Date: Thu, 13 Jun 2024 14:33:16 -0700
Message-ID: <20240613213316.3677129-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I find the behavior of xa_for_each_start() slightly counter-intuitive.
It doesn't end the iteration by making the index point after the last
element. IOW calling xa_for_each_start() again after it "finished"
will run the body of the loop for the last valid element, instead
of doing nothing.

This works fine for netlink dumps if they terminate correctly
(i.e. coalesce or carefully handle NLM_DONE), but as we keep getting
reminded legacy dumps are unlikely to go away.

Fixing this generically at the xa_for_each_start() level seems hard -
there is no index reserved for "end of iteration".
ifindexes are 31b wide, tho, and iterator is ulong so for
for_each_netdev_dump() it's safe to go to the next element.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f148a01dd1d1..85111502cf8f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3021,7 +3021,8 @@ int call_netdevice_notifiers_info(unsigned long val,
 #define net_device_entry(lh)	list_entry(lh, struct net_device, dev_list)
 
 #define for_each_netdev_dump(net, d, ifindex)				\
-	xa_for_each_start(&(net)->dev_by_index, (ifindex), (d), (ifindex))
+	for (; (d = xa_find(&(net)->dev_by_index, &ifindex,		\
+			    ULONG_MAX, XA_PRESENT)); ifindex++)
 
 static inline struct net_device *next_net_device(struct net_device *dev)
 {
-- 
2.45.2


