Return-Path: <netdev+bounces-243932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E67E2CAB08F
	for <lists+netdev@lfdr.de>; Sun, 07 Dec 2025 03:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B07E9306A501
	for <lists+netdev@lfdr.de>; Sun,  7 Dec 2025 02:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7DE2417DE;
	Sun,  7 Dec 2025 02:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HT281mXc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1743B8D70
	for <netdev@vger.kernel.org>; Sun,  7 Dec 2025 02:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765076363; cv=none; b=EXgr/P6ONJmWoKt/Z8KV2dzs9vX2SJCcbtBxod0J2wJnjIWKJ7aSI+/91vLjJrtZEyY9VjCpEUe6aJCWe1cV5jSCMIn3FIhXGgO/SeRFLFJN7JcUrQ/4s+ZS3AW5LUsbwjfrTWkPxPbfD3VKjt6H4wm9JCRbs4H477YSn6NBrD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765076363; c=relaxed/simple;
	bh=f1VBgMK7mIywAS991LeDTaomjC4XPqbXN434IwwJVk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7phtFGlxO3Irmp9nnb4k9BNapjUXcGeWUos1rpr0J3syWoT84us3NYPnIVUo8YgFTuzb+R/6r5oAY6SewQlGGMXmcfeHtscFcbcWhfbij20/5NwZqV6pnZgw2FijFlf5K6N1FxnY9J/+z4pZ7t9ekhjQUW8wcl1l4olpNXu/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HT281mXc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-298145fe27eso52185635ad.1
        for <netdev@vger.kernel.org>; Sat, 06 Dec 2025 18:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765076361; x=1765681161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqHjFF5VQUBgHPfC4eg5CVVciGmhATwVYxzqjeHGRqg=;
        b=HT281mXc/Mc0G2IScU25qQA0KDiBWdmq3EmKCyYT0d4hp61XknboePwjCX22L1MSti
         r7o4qhGsqnhhGQf5ZEZGZA1T2eX/IUOUPfzcXKQj/zn/ogXZfV61idmF0+/oXrcPX78P
         JuwOLbGAi4AvndwVYNirs6YbdPO22ja9QAPkuYpwGjnzLekY7QH4ecEbmyca5uh8cUeI
         zeRPEMGDHjxPqEUHjpQN63m3CGCP2HsQoeP1Q7zQ8fwvkPbJcZfbzHfBxWmhRvzigIkv
         493m6VvochIlQCUc31P9c9MgaZCA6Wvu0XpC7jbGyKDZR7c62BaWrVr9sevp5hi3jRSM
         3k8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765076361; x=1765681161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wqHjFF5VQUBgHPfC4eg5CVVciGmhATwVYxzqjeHGRqg=;
        b=LijwNSe4PpYUWLy83Bo8ukyS+kHDxnXSY7Q9FCNe77C+GdxaMS2lNyFz0S94ZF5a9t
         bxPlXb7pnc+datWDLO6GPVO0EN0j0VHbrThEQgI1v8kVAonyayRDrifUSRRyJXoE+RlF
         Citu+m4QZGWxGsduoM3fGsJL+bE04fORftYqgJv0INjzk4EUhrzH8JlWQj7hOOL+mzya
         7mow8kImLNFxMiKs/UlrkB8me6nOEMIDsaOJ4eEgC0Rpx9lv8NLQgn+lc44LLK3COzNh
         eKYe0Y52T/BlVlq/IqE43rD9oorIKBeHwjWpc7Q6QxIvr/lyqnF0jf25goyhE0VVV4n1
         /OWw==
X-Gm-Message-State: AOJu0YyYMvBB93SXQ+ilXpLSdR7bzKFDxv5lj/rl6GZkEM5roRfU9aGt
	oHS9ccRBBv+Eze55fLZ6dQCTHqsPIhpsoMT9Fi8CLzkhYRaflTuSVNnX
X-Gm-Gg: ASbGncvbSZ3SA4qUAlsUDmZe/NoRahoNOgICaxmBwoOlt50BN0htT1qhkN8g5IdBLvC
	Tpjb1El09wD+fM5MGsm3LuKupFbaMtp/pFnwCcVNAvOJLCvSOuV6nWL4rkh1HmvKoNpSKwyLuLz
	s6n//zTg//wh4Swoiz5/hivnXY2MoiKrgBVvflbZrvC60aTvd3I9OrliKK7QGSXOrqKbJV193Y/
	F7gmn1rNuA0SP2YAiS0i9uPJ51Y04QxVXMwzJBmN+EyURRTUGNBIE1LqrslfxV2pw9WdN//5s96
	9j6lcUOxLn+fA6sHuQRZ1mXbGoslFLdn6Sbll6CfZjfYA577r+tJ5VMemZAHA/IUfdt7wP8RTyB
	Hm2huo6PT7BhzzFvLAYvQ4Ysmavkac3nLGDTHWkEMSZ/ng/d6gMUO9UDAwDtLdV9ivoDfpakr+n
	5UNA63j6RzBvTD7HFL4yL5DNlQK/W9bcilVxMf9sgJrf4=
X-Google-Smtp-Source: AGHT+IEH/X9T9G5TirdKusk0UHKDWLGYx98tpOX0o8yVNPtVi1UDXB3JzWQACpehz0hSgOmA7TruqA==
X-Received: by 2002:a17:902:f683:b0:295:7806:1d7b with SMTP id d9443c01a7336-29df5deb440mr36158025ad.45.1765076361263;
        Sat, 06 Dec 2025 18:59:21 -0800 (PST)
Received: from localhost.localdomain ([38.224.232.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4a13d2sm85864055ad.9.2025.12.06.18.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 18:59:20 -0800 (PST)
From: Dharanitharan R <dharanitharan725@gmail.com>
To: syzbot+422806e5f4cce722a71f@syzkaller.appspotmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dharanitharan R <dharanitharan725@gmail.com>
Subject: [PATCH] team: fix qom_list corruption by using list_del_init_rcu()
Date: Sun,  7 Dec 2025 02:58:08 +0000
Message-ID: <20251207025807.1674-2-dharanitharan725@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6903e344.050a0220.32483.022d.GAE@google.com>
References: <6903e344.050a0220.32483.022d.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Reported-by: syzbot+422806e5f4cce722a71f@syzkaller.appspotmail.com
Signed-off-by: Dharanitharan R <dharanitharan725@gmail.com>
---
 drivers/net/team/team_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 4d5c9ae8f221..d6d724b52dbf 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -823,7 +823,8 @@ static void __team_queue_override_port_del(struct team *team,
 {
 	if (!port->queue_id)
 		return;
-	list_del_rcu(&port->qom_list);
+	/* Ensure safe repeated deletion */
+	list_del_init_rcu(&port->qom_list);
 }
 
 static bool team_queue_override_port_has_gt_prio_than(struct team_port *port,
-- 
2.43.0


