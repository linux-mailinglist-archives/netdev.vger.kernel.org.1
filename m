Return-Path: <netdev+bounces-244189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF470CB1FBC
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 06:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7079D30271B4
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 05:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895AF239E9D;
	Wed, 10 Dec 2025 05:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9Pdmo5C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179A621767D
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 05:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765344743; cv=none; b=ig27MvefsSkDz8ll5CWlVgypm8hO/SLY4VgIUoNPVm3gflU5WfcJ/ONROllClGi/RRrGAnJn2rK3Oyd+jCk2QNtP3rvP7pWkgPK8ksk//G5ToEMr1Iz4aQ67i9mloYdylB6vgDnTIoeYIbpVYR+UnD2vffCLEwUkdVClmYhymO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765344743; c=relaxed/simple;
	bh=fk5/LHKKD4le83o1mXBewiqtFtt0hn9fKUiCbco//Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a3Kz0AI2YJZ6krf2r8MGTEwNtK6+L3NUJpvKFvmlh/k1JQ7GuwH8hAEY8Zy0r7e5V/H4GJiklDFtDw/6ZUfSuafHT/qGm2+XLUVoB57oMBDhnNw58NKljNSyZG0WhRGp743nZeHmcyQ9VhIK1YTpy9ybFZldjRnMgUbHMTXds8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9Pdmo5C; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29e1b8be48fso32981345ad.1
        for <netdev@vger.kernel.org>; Tue, 09 Dec 2025 21:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765344741; x=1765949541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vM7j2WXHjtgjj5MgOjevIVqk4YB0lHlzSI/NymmfyOw=;
        b=b9Pdmo5CppIAt9cAafO5esqQ2t3y9XdiPPtjGFVy15YRLKzouqLnlUKtfI0w41VOC/
         JkLmtyVisYKx77ES4TMGeTfV/agLaXdkHdD36mV/EVRziN1V8MMqlFacmW3OCm6cTOZp
         M6LpYFdGICfdWi2e/YAzo/b1cO9Jg4R9QJpL41pS20SFfeWUatkgQ72EKL7eLKalCNxb
         oZARrXCS6p5SxZk/rkMmLhGHOFBnTV5w4DGOoFMvpDURusT4E57bRQNcLncZDqkCo2X1
         I4JH1WxKZ8ig+B1jkVcCJ0fsiABuOzNwgXVREDP31MvL4fx+uEUYOWiT/TOFjV5yVvfS
         0TWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765344741; x=1765949541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vM7j2WXHjtgjj5MgOjevIVqk4YB0lHlzSI/NymmfyOw=;
        b=CDMxbG2ctnsf0o7TV2TvTKdTt4GDpJJw/plWZxLoyQ346yIZab5D59ROXsESqs32f/
         JLAVriq8hwtmWN6t386QtVxy6LIZR1pzDxYpvtQ5hL1M8TYBqYoyKCPwfdDEu3vO3kC5
         zzLn1lxRnKrl1gqbIJC4V+M4wRYvyc2tDs/exutDviDLxPqhekwXFeTWU92PjkhwuPCT
         RAszZz0fwwb7WS2sGhSKEL5Ctp90anMXkbZdJEn81K+kaGtW6PRqH9U24kkOtmDZkdhg
         00EETOFjIFwO9WQHeE4Vw+gf5HtGQr10SnatU2lt2mC4fltit4yeGHMizoqkGul7CX3I
         Pg3g==
X-Gm-Message-State: AOJu0Yzo6TVZR3WAKSgwabQZxr3TUw1hRpObupTmhogkxurmtSjxvsy4
	cohLFywAZ9pVtsGAUcj52cSMdLI0qDJ8iWEosQcM38LA6Yo3fp4UQezY
X-Gm-Gg: AY/fxX4vWLhkvPFyG2a7i7OYl7girQfLiykVwlCi+A1lqa8E4AIsNjXDX//Zn4Xpb7X
	humUwzvloULzz2yOoHDjfVA6J+bXBaZ4912+Cpuagm0oxT4u8dCt7xihipu/biZF4U32WWdosYy
	BajqpuOgMRpCJ2awkwkzqf+EttHLWRo51yi7aTVuE2IIz+QcrOUUmrrbO4y7gz3yAjZNiZ/QbHp
	cxB07EKEfYBIm5WcATrPdkXAJFERvqi9ZusE4yIRanUzDlkPlWlFNh2Zqb1VfrPD0jGJRPKSpPR
	3aEKpGMtuEB7QbkFyDhAp2UTA/gc3sFupGymamEu4XDD6ef/P1m0A4SVgU1EAWO6sS3idIYCAxr
	Jq830WqTjuZzxDHOFb06+IX5hT7NpvVCpSznFyOr566RDQeOv7uwA1FqeAF8FcWh79qUHrB+FHt
	BXVxn9stWZLnA09bXPkLBhki4uMKKXWV6h
X-Google-Smtp-Source: AGHT+IEJFvSN5b4kbfNTtphRwswMa2FaKOMa/KI5fVEE+KEHsVFQdnzSspwV616LLkhtMJxBIDDe3A==
X-Received: by 2002:a17:903:2f50:b0:295:5972:4363 with SMTP id d9443c01a7336-29ec218f5bamr16473545ad.0.1765344741245;
        Tue, 09 Dec 2025 21:32:21 -0800 (PST)
Received: from localhost.localdomain ([38.134.139.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeae6e95sm173061665ad.95.2025.12.09.21.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 21:32:20 -0800 (PST)
From: Dharanitharan R <dharanitharan725@gmail.com>
To: syzbot+422806e5f4cce722a71f@syzkaller.appspotmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dharanitharan725@gmail.com
Subject: [PATCH net v2] team: fix qom_list corruption by using list_del_init_rcu()
Date: Wed, 10 Dec 2025 05:31:05 +0000
Message-ID: <20251210053104.23608-2-dharanitharan725@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In __team_queue_override_port_del(), repeated deletion of the same port
using list_del_rcu() could corrupt the RCU-protected qom_list. This
happens if the function is called multiple times on the same port, for
example during port removal or team reconfiguration.

This patch replaces list_del_rcu() with list_del_init_rcu() to:

  - Ensure safe repeated deletion of the same port
  - Keep the RCU list consistent
  - Avoid potential use-after-free and list corruption issues

Testing:
  - Syzbot-reported crash is eliminated in testing.
  - Kernel builds and runs cleanly

Fixes: 108f9405ce81 ("team: add queue override configuration mechanism")
Reported-by: syzbot+422806e5f4cce722a71f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=422806e5f4cce722a71f
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

