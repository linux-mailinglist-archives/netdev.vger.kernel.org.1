Return-Path: <netdev+bounces-228613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241A9BD0277
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 14:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F433B7C10
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 12:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B590259CA4;
	Sun, 12 Oct 2025 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="0JgSFZSl"
X-Original-To: netdev@vger.kernel.org
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745562236FD
	for <netdev@vger.kernel.org>; Sun, 12 Oct 2025 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760273328; cv=none; b=ZCUDxwaG7GywxAtQid47bv03iIoqdfKt8osF6EmAekAQ8Z2jI3mV19tA2+UxpBglv4k8ghf5xUjp5zgFZ/JpjelZmL6G6gLWUVYX889tRLxh3rMHHZaQ56OSJdQPWv4W3wovbLw6SK1lC/f5Zggqfe957/g/o4Cyjk34xyQto4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760273328; c=relaxed/simple;
	bh=vDxVpac/Ox+XxFTnHRHxFn3y5pfd1kABLAoPctHNAfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VhUOunocygswuw73lP5wsqq4xp4P6C6e8Pz3/BfTyB3vShV+Kq1uDSQvLFjdYbPV1RPpiBPO1DIwwODRtjP5P+X/746LzzOim1w+Bq6h8puCKKldZvDGEXhWRcju260O+50m1oWArZmWgII137f2H9DUbQcOQvJQI8tOBv7C5WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=0JgSFZSl; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
From: Yureka <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1760272817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GSvEYHfdyfVtYJg9xbUSMtLAyxdfKwNPJGE6h4muC/Q=;
	b=0JgSFZSlBVPEBeHJhSPZpBvjK6dP7IBpi82Yaj8B6tfDA7+OywpL2ezuT5vS7euW82Xd7v
	cGFf47hL+qiqcpRvdXpeon3CyV4Xf+Utx74QBB7LNQsE58mihNS9KQ/R9GLip7+zsRo0Ah
	dFhhf6Igciwvis50ZNEkwU7eMScniz0=
To: David Ahern <dsahern@gmail.com>,
	netdev@vger.kernel.org
Cc: Yureka <yureka@cyberchaos.dev>
Subject: [PATCH iproute2-next] lib: bridge: avoid redefinition of in6_addr
Date: Sun, 12 Oct 2025 14:39:47 +0200
Message-ID: <20251012124002.296018-1-yureka@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On musl libc, which does not use the kernel definitions of in6_addr, including
the libc headers after the kernel (UAPI) headers would cause a redefinition
error. The opposite order avoids the redefinition.

Fixes: 9e89d5b94d749f37525cd8778311e1c9f28f172a
Signed-off-by: Yureka <yureka@cyberchaos.dev>
---

I'm not one-hundred-percent sure how the opposite order avoids the
redefinition, but it fixes my build against musl libc headers.

 lib/bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bridge.c b/lib/bridge.c
index 5386aa01..104f5858 100644
--- a/lib/bridge.c
+++ b/lib/bridge.c
@@ -2,8 +2,8 @@
 
 #include <net/if.h>
 
-#include "bridge.h"
 #include "utils.h"
+#include "bridge.h"
 
 void bridge_print_vlan_flags(__u16 flags)
 {
-- 
2.51.0


