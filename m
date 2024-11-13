Return-Path: <netdev+bounces-144261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7CA9C667B
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 02:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830F71F24F04
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 01:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F394ABA34;
	Wed, 13 Nov 2024 01:11:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF557AD5A;
	Wed, 13 Nov 2024 01:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731460318; cv=none; b=EHVwaKKAoED7FB6DW8SEp1OX3IjsGk2NHddtuUgMu4AVtenHntmYTRZESHMvTNLPRk9BAWzKspRpBvXxbdz0pdgbIV9ttnkZggpdj1bc2ULmUqni6zAl5sVe33PXlsYCtd/6D74C7XHK6oFNOfZ18qZciIOsoY4kMYWDGriAHwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731460318; c=relaxed/simple;
	bh=8a7IghDD2F19zEoED7hhdIjA/SwpOf9+n+JnpHyC9aM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VfLdOUF+P7az1fScdwSmXZiddn+4mYNR8HVenVksN65GgNlr+QQeuUx5LQGnURrDOcbFGRSITUzGdk4gHbL/SQ0uA3x5yvFoNzx9yCBc+flr723GZ8iM9UywEy07dTNyUo6A+zosyriFsxzSi9MrDsazufCgwnrbiEtGMFWB1Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96733fcceba2-18bb7;
	Wed, 13 Nov 2024 09:11:44 +0800 (CST)
X-RM-TRANSID:2ee96733fcceba2-18bb7
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46733fccfe13-57401;
	Wed, 13 Nov 2024 09:11:44 +0800 (CST)
X-RM-TRANSID:2ee46733fccfe13-57401
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: kuba@kernel.org,
	donald.hunter@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	luoyifan@cmss.chinamobile.com,
	pabeni@redhat.com,
	sfr@canb.auug.org.au,
	netdev@vger.kernel.org
Subject: [PATCH net-next] ynl: samples: Fix the wrong format specifier
Date: Wed, 13 Nov 2024 09:11:42 +0800
Message-Id: <20241113011142.290474-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241112080236.092f5578@kernel.org>
References: <20241112080236.092f5578@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make a minor change to eliminate a static checker warning. The type
of s->ifc is unsigned int, so the correct format specifier should be
%u instead of %d.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 tools/net/ynl/samples/page-pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/samples/page-pool.c b/tools/net/ynl/samples/page-pool.c
index 332f281ee..e5d521320 100644
--- a/tools/net/ynl/samples/page-pool.c
+++ b/tools/net/ynl/samples/page-pool.c
@@ -118,7 +118,7 @@ int main(int argc, char **argv)
 			name = if_indextoname(s->ifc, ifname);
 			if (name)
 				printf("%8s", name);
-			printf("[%d]\t", s->ifc);
+			printf("[%u]\t", s->ifc);
 		}
 
 		printf("page pools: %u (zombies: %u)\n",
-- 
2.27.0




