Return-Path: <netdev+bounces-243919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56918CAAC3B
	for <lists+netdev@lfdr.de>; Sat, 06 Dec 2025 19:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22442300CA22
	for <lists+netdev@lfdr.de>; Sat,  6 Dec 2025 18:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7542D4B57;
	Sat,  6 Dec 2025 18:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3ovT8LC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AD92D3A69
	for <netdev@vger.kernel.org>; Sat,  6 Dec 2025 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765046089; cv=none; b=iGUkkLMJHiKoLTCbnjOgCZIGO6uhQOHBwv63pFLYNCTheBfubsLZbndQeuvxJISGeScqvoL23TtEwl+IK10sbpMw6DDTqWfkqzkrYGb4AIHicBUMDG5U1Z/sJSeVQukmkYY6Y8iyvKSky59iYhLHZDhmfW27AzbBRcv252gfxnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765046089; c=relaxed/simple;
	bh=1IRpld83xMZ/drvhIoU9A9UdatZ3zIc0QHPBeO90PwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LRJKFqJi2vB1DQ4ULVhlFwVRe7oo+KGD+prjQfsjx0aScAo9QGAK90/iMMhjzbx8Ai+pGNw//5KpdRjkX3v19MUXT/dy/R5lci3tRh76V4eLUGfKoWvmOSZnrFLJIveHkHG5c1DbQrwcx3EAMFErvpc/bJ4BMoqnY7x8qRcrMLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3ovT8LC; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so3741033b3a.1
        for <netdev@vger.kernel.org>; Sat, 06 Dec 2025 10:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765046086; x=1765650886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QEfkkRUioZd9SWMtUtcnRsb5wthZOOn5MPiTu5OxMss=;
        b=Y3ovT8LCPHZgy2ConTMR0qAWOVKsjZnCy2cvMPhGqEl4pQ49psGJcuO2OKX7uKa4O+
         +k88IvuQIpLuJji+aacnHlNuiXb98ICeNghnUsYfo4b7y47Jj8fThPFf8rF3ervsWv6t
         yrlS2nd9WPBncPSXoCR0dln00bUyXovVu3vO3/a5YNjUYH/I/KjAdEnoCk0pnz6Mbcpt
         tN7WvNJ/9pQETE3tOrAvlxanRL6GyBNeCbN6bFm+CkhcFPkxh3BH6kKBbVPxV9ws1WF0
         RlFTouNr2XhgBYTJr/a46RPMEnYGCTR5iVbPgu2zoba7bm7iI57ZhdJGA5JVwegsCqZK
         dCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765046086; x=1765650886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEfkkRUioZd9SWMtUtcnRsb5wthZOOn5MPiTu5OxMss=;
        b=tG87GlyzAcnYcro5UhWSUgZeqeMKdg0Z1ak+GOAsUH5re5bmuPYJDXqk2sFH9eAv9V
         fuW5KVAs80N0Wx35J0p1HDPcGr/AuvZGdbr9HoPHa57Md/j4sNzCug9b3ZIuozHRc5yd
         /kjOON5MdRyTgYG9HInclTFs64EhBbEprexvTRqWG0HgTwHgWldcTGNOXZvLi4jvNMDf
         dF8xKuVUTBpCCKkgstcmeHkxlZMdNzzMyEeVy8ZkmDSBYtVqA1852/fiV6tQASzrAazn
         A5pnx6b+bxhg3MLYOmMs1BS5wEQzx1Iq0Mg47cmDdusHOC0Et4vysZ1lF3nXPX2hxTQP
         Iduw==
X-Gm-Message-State: AOJu0YzhLbJcPsKvdBExEX0KLxjs1fUdbii0afwXMFp40BuAFhIMa09O
	iP6dwB5DCvqtV+pxpnSBq7jCtnWhNkTELJyC18FkBJ41QWUwRr+V188x0XD35b4q
X-Gm-Gg: ASbGncvidpHP4hxnN0qkTijDkQy9Q6b/E0fYE4JIlig2ZJVOEMYKCpWplBev6xFQmex
	HelkV4GNYxUtg3/1ibiktP6ci5t50/lB2yzB7mi+MNnAj00mCxDpk2AErUek0tSQ/gPjw5XlxD2
	UaO+OAwF2lNrLzAHaa+dl5Wq0Q8R4cQTAd3SED6QmFHa2V0W59IH+DdqNBbu5ot+/HllpySIVi+
	9p0XNgTZ3p+WmEtF9pUAlIkNtMmwpVcGe5Yj13LayOqXIefkEZu+0rRN7n1rjRyg9RZTqrwY8qM
	K9Iup1Dhz1XTTr9GAhCtoX/P5l1liViRKxVhMQBi/MjnC4gvAV0pqvI3jk6LMNpGqDp4RB63IO0
	8tahWQkTQsrjty6W1K2u3UxGwdzM/X2m7GEhFwQewoNWXX0AmuJKcvDCikgQY54wBKlOs323vqM
	nOy0774gmlClcns5MPRt1N+O+s46mQ4+G/l5aFWIKBRQ==
X-Google-Smtp-Source: AGHT+IFeTIyilu6i/nv6MjVhe109PqaHt6XteJMIbolrykyX6578g5dgjInEvjk23UfPaf+tnRd2mw==
X-Received: by 2002:a05:6a00:94d6:b0:7e8:450c:61bc with SMTP id d2e1a72fcca58-7e8c523cc07mr2510672b3a.44.1765046086206;
        Sat, 06 Dec 2025 10:34:46 -0800 (PST)
Received: from localhost.localdomain ([103.98.63.195])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2af18dbc0sm8539472b3a.59.2025.12.06.10.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 10:34:45 -0800 (PST)
From: Dharanitharan R <dharanitharan725@gmail.com>
To: netdev@vger.kernel.org
Cc: syzbot+422806e5f4cce722a71f@syzkaller.appspotmail.com,
	Dharanitharan R <dharanitharan725@gmail.com>
Subject: [PATCH] team: fix qom_list corruption by using list_del_init_rcu()
Date: Sat,  6 Dec 2025 18:34:21 +0000
Message-ID: <20251206183421.12039-1-dharanitharan725@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


