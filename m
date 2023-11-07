Return-Path: <netdev+bounces-46313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9362C7E3291
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 02:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32673280DE9
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 01:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE6217C8;
	Tue,  7 Nov 2023 01:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="SPZJxXyu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B8017C7
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 01:22:34 +0000 (UTC)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1850103
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 17:22:32 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 757BA240027
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 02:22:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
	t=1699320151; bh=CZQ06YgnfpGiCUCYkYEdsye/GTLnq2HQ7pypTmh8jGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=SPZJxXyu5L4i2VxrX4XikeFUfFFNuOxXTWUgR8XpNbNwR17cS7W7e3itTLNOW7ZPt
	 AnM0/CYZFjUYYWQFfeEJM3xj68u0uzSC/PkProAzWRBoZ1kofd8yTFffP5fF5E3zVQ
	 bCk/xvmfoRtQpLxXdxaLNY4/S83Sxvy5wgSg44OLJjhl2lYtDd7Snlx8VlO07KSRH2
	 ddrZ1eO7JehvGTKodIdtSSr1Txw9aDk+IP3Gjbz4v1rVcZrHL8fm1Ly07T+/72ZaRJ
	 Z3oWWB8Rc0NzQu5gSfn+f3EyKBa4g7GYktYN9INUNVaRQUtzMGfUZ+2QtK8iXsGOBP
	 ZFzG8QecOYi2A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4SPVnf1D8Xz9rxG;
	Tue,  7 Nov 2023 02:22:30 +0100 (CET)
From: Max Kunzelmann <maxdev@posteo.de>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	Max Kunzelmann <maxdev@posteo.de>,
	Benny Baumann <BenBE@geshi.org>,
	Robert Geislinger <github@crpykng.de>
Subject: [PATCH iproute2] libnetlink: validate nlmsg header length first
Date: Tue,  7 Nov 2023 01:20:55 +0000
Message-ID: <20231107012147.668074-1-maxdev@posteo.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate the nlmsg header length before accessing the nlmsg payload
length.

Fixes: 892a25e286fb ("libnetlink: break up dump function")

Signed-off-by: Max Kunzelmann <maxdev@posteo.de>
Reviewed-by: Benny Baumann <BenBE@geshi.org>
Reviewed-by: Robert Geislinger <github@crpykng.de>
---
 lib/libnetlink.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/libnetlink.c b/lib/libnetlink.c
index 7edcd285..01648229 100644
--- a/lib/libnetlink.c
+++ b/lib/libnetlink.c
@@ -727,13 +727,15 @@ int rtnl_dump_request_n(struct rtnl_handle *rth, struct nlmsghdr *n)
 static int rtnl_dump_done(struct nlmsghdr *h,
 			  const struct rtnl_dump_filter_arg *a)
 {
-	int len = *(int *)NLMSG_DATA(h);
+	int len;
 
 	if (h->nlmsg_len < NLMSG_LENGTH(sizeof(int))) {
 		fprintf(stderr, "DONE truncated\n");
 		return -1;
 	}
 
+	len = *(int *)NLMSG_DATA(h);
+
 	if (len < 0) {
 		errno = -len;
 
-- 
2.42.0


