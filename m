Return-Path: <netdev+bounces-141693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC689BC0D1
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 23:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED7CDB20E21
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 22:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE901FCF71;
	Mon,  4 Nov 2024 22:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6iEvdNX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F021C32E2;
	Mon,  4 Nov 2024 22:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759116; cv=none; b=fB0G+B/UHcuozlA0VdBmVk8uYjjOw9itQyU8SfPSZuNaX4+UiVC1cdEjrfZmQTEwxh7OJ2N0PWKF+P89Qsx82ozmH9MOij51lFG3gfzXaGf5SW007J0H1UJSxsfXkCny0dV9F6k4HzAEvfdYjCFEPiV4Hh85D8zVcE7diJznQwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759116; c=relaxed/simple;
	bh=nnathdskUxGu/VhOcY1X1w1dugmZGedEo3+8ThGIWak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FVm+XKmadRQe8L9YVo9nUdNVH7RhzZ9FsgWt1URPgRgxKHjXXir8vAOB31Bvi2sPff+utQXUxDmOKaPLNoLKw5gc2JAaYcX5CtX+XCHsRFbqmf7RoYYXjbJCSXdog8S/O0gEQzoVeyFQPM9hQQkwMW5/NXbkawsllQ8DibEoQZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6iEvdNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8160EC4CED0;
	Mon,  4 Nov 2024 22:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730759116;
	bh=nnathdskUxGu/VhOcY1X1w1dugmZGedEo3+8ThGIWak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F6iEvdNXK1P9b+EeoDpbBDRPc5nyEPF25BUX2NtZe+r1mN4d1dKP997O5Wu39g2nW
	 SJVR8Hbc3B40s9MzXVCDy0NlbgaLBFE5fIboQOsATCBlRzRkB0sa3sqNt2eINQlqSZ
	 iO6e5f4PsGSNUgMpS53nrsiZZKkgvvJbcHfBfgxI2x65pL8rchlm0SYBDYvZqQnNd4
	 TJbT9/7+4dhk8KOSa1xO1FrnQZLEU433bwhPwwwqKj7Z1F+iI2HcAsv2B0i0Ix1/3M
	 j4domQUn4WsCn8rNXdP87d/JM9oMq2d7AMztS+NriQ5F2Hf7rLvtyeDfz6nR5RLWw1
	 xirX9VQ5tdQ1A==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH RFC 2/5] net: core: dev.c confirmed to use classic sockaddr
Date: Mon,  4 Nov 2024 14:25:04 -0800
Message-Id: <20241104222513.3469025-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104221450.work.053-kees@kernel.org>
References: <20241104221450.work.053-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1411; i=kees@kernel.org; h=from:subject; bh=nnathdskUxGu/VhOcY1X1w1dugmZGedEo3+8ThGIWak=; b=owGbwMvMwCVmps19z/KJym7G02pJDOmangcXe0/zuTZ9zjqzEOlFk17VPHGVKPP7/FnKSNH9n Nd0jr2NHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABPJf8bIsFto5mf+rK9ehbds Dn/0cdfbtURj05z80LDIKaYfCyou5jAy3Jq4QGP9t/1MRtNsNzncdflxWXFazmadFsaeB5f/Gqh 1MgIA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Add comments about the sockaddr arguments being actual classic "max 14
bytes in sa_data" sockaddr.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 net/core/dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 582466a0176a..c95779cb42a6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9075,7 +9075,8 @@ EXPORT_SYMBOL(dev_pre_changeaddr_notify);
 /**
  *	dev_set_mac_address - Change Media Access Control Address
  *	@dev: device
- *	@sa: new address
+ *	@sa: new address in a classic "struct sockaddr", which will never
+ *	     have more than 14 bytes in @sa::sa_data
  *	@extack: netlink extended ack
  *
  *	Change the hardware (MAC) address of the device
@@ -9109,6 +9110,7 @@ EXPORT_SYMBOL(dev_set_mac_address);
 
 DECLARE_RWSEM(dev_addr_sem);
 
+/* "sa" is a classic sockaddr: it will only ever use 14 bytes from sa_data. */
 int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
 			     struct netlink_ext_ack *extack)
 {
@@ -9121,6 +9123,7 @@ int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
 }
 EXPORT_SYMBOL(dev_set_mac_address_user);
 
+/* "sa" is a classic sockaddr: it will only ever use 14 bytes from sa_data. */
 int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
 {
 	size_t size = sizeof(sa->sa_data);
-- 
2.34.1


