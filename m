Return-Path: <netdev+bounces-213820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CB1B26EB2
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 20:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21AE5E47EF
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 18:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875C32253E9;
	Thu, 14 Aug 2025 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rSvnquOy"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4289063B9
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755195368; cv=none; b=Uj5SGdGso7dEymTU2X2xsLWjTa5Dzjl1Zrns8UZG+vmipemy1/m0sd4u1LwUHj31n9MUNnOZIj2U2rMm0RTHrItkuLKkOiVsC7aHobDr0UNcCitTejEEVRM/PlP854jhnsWEf0VKtptOwSJXPtfamA4tQU3VMKX5gk6nlwA4oSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755195368; c=relaxed/simple;
	bh=d2Ulm/XIjGVlbLGsYARxfo4PVZkxzdBk4wMZupOCeLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aEVLSBBueyzn7Eg6j67dT6TVFQLCR8cSsqPwVdqn7xHrioF3Fc+rl8Iv/qK8AIc/p20AeoyPMpnmjL+jdLDSyxAithLdXlDfzt+6XYM4nPTYk3qxKGuBZuTaJDtPGgy8CUG2qaWJs5x1O5XsvTBNKa2drxLkFR/RKnUbkPnujEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rSvnquOy; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755195360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gBXi1Jms/31Rd25COKA1CAhr6nVAQI7I8OoejczvZE8=;
	b=rSvnquOyMSeHgEKHNzEYWTfxgYcT51QQM3kzCYSgwsxajFdThWV4oee6hlq96w+H0MvkGn
	vCXKweFJKqYiRdWUHK1UunoU72lbtYv+u5sRHbGQJfO8bCyl6fC2NQ1ScYj69vLr55bmsn
	hdQYD+r0zo5m7OsZa7FcrKSwGIJEzN4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: Space: Replace memset(0) + strscpy() with strscpy_pad()
Date: Thu, 14 Aug 2025 20:05:14 +0200
Message-ID: <20250814180514.251000-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace memset(0) followed by strscpy() with strscpy_pad() to improve
netdev_boot_setup_add(). This avoids zeroing the memory before copying
the string and ensures the destination buffer is only written to once,
simplifying the code and improving efficiency.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/net/Space.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/Space.c b/drivers/net/Space.c
index dc50797a2ed0..c01e2c2f7d6c 100644
--- a/drivers/net/Space.c
+++ b/drivers/net/Space.c
@@ -67,8 +67,7 @@ static int netdev_boot_setup_add(char *name, struct ifmap *map)
 	s = dev_boot_setup;
 	for (i = 0; i < NETDEV_BOOT_SETUP_MAX; i++) {
 		if (s[i].name[0] == '\0' || s[i].name[0] == ' ') {
-			memset(s[i].name, 0, sizeof(s[i].name));
-			strscpy(s[i].name, name, IFNAMSIZ);
+			strscpy_pad(s[i].name, name);
 			memcpy(&s[i].map, map, sizeof(s[i].map));
 			break;
 		}
-- 
2.50.1


