Return-Path: <netdev+bounces-245674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 571B0CD4C64
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 07:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5573F3004CA7
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 06:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92277302CD5;
	Mon, 22 Dec 2025 06:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIoDhPWz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107AE2F83A1
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 06:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766383999; cv=none; b=MWpNMC47kB2oQk3I/XJ05Hz/LTUR35lCNwBYWr0aT2oIptxFDIq+XSKKE3ihwSPzy+rWtinsdhtLJr/18bR1sAYl7eVfJxwVMwhZoMK4OforbRWDzBHj0rHLJxotje35tsp4ta2hFv3kphLVkzAj2qKc/X1Zfu9nknOuSL6IjSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766383999; c=relaxed/simple;
	bh=dcMfJF0tfihPZgBMo5BBEeuPQtcGmMrTlcKB8HaQNso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nXx8rpP7hIm+wzXM8P5+W6lClqKgtlCk/GSMcxKOKVUC5A7ngQYfNx3K7z6H573j+zjDifHi13Dx28/snveUv0Oopd/N9K8j9fdp9qNoPdT+M7cAlG9PnAqYFp3GQqQBKvg+8PgY96w4aDqHEAQ/fP1Br0ZcP87o2HEfYVmeYGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIoDhPWz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0d5c365ceso46015525ad.3
        for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 22:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766383997; x=1766988797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3S4jAgS6Y3OH5s26cfxtt4FgF9TFQpYXvTl4gwzt3WM=;
        b=hIoDhPWz5jKGkn4gif9iQmmoeP3Bc1PbqPAPPAdiI6moHcTMpwvJX0/28RCtupLwgg
         bcGsYyt8Pw0dKiE2wJNJi+rhxlIBn59KVW1nK5g+Tns7QdF2r4yZu/CsS1zkjNQvXN9w
         BnNR7fJsrRaRReeIaf0sCorpgZ9oJQ3AbGfNdsVMTaKxm6xb2bChcvi5l5XURktJ6o6d
         BI2iEdgPxZPY2gR26J/tlgaRR6VftTwUvp/76WA/K5/JVwbJ0hvt2dCWMUc7wmcL6cal
         7JUJe+mWcVFIqrDzBkOrri67Zhotqs+1WKj0TjNYJjuvmfsmnk5mV1fgQX7tbCL3Ywvl
         Hakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766383997; x=1766988797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3S4jAgS6Y3OH5s26cfxtt4FgF9TFQpYXvTl4gwzt3WM=;
        b=OPa3XivBURtz+Q+C7akePCh4kgycXAmqi2umLQ9zJD6tHfJMb+tkrFN6JBV/7zk1DA
         lDo1RJpcU3qwNq9yaYg+XYtpHR/wxtzHV0C6W583TLwhtQ9Tw7bnWjwYUqdlCvhZIe6b
         V872wKDRgHMTOLvsGsCXEItv0jottSAn1r4m42uOGednYThr9M3+9AQyH9QobzuHlf6q
         8yewstZ0Ak6mVwicLGNVFZ0McN6lFcLlWhKnWOYboHdh0C/XSBxTiSsbQfIrAmWDm891
         WS5iF/2Ef8Na9GwjGYzcauKF5pryuJeyqpHafGnY8s/kn0j7MCkv0VzQ9RR0B3rp32dF
         83vg==
X-Forwarded-Encrypted: i=1; AJvYcCX51qDK26ZYQHPMzLQbrsERCgQLHMkRuN3MMXCzaLp3crR+wGVBIt3ZEExbVvrNPb7RrAaspH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdiaMaDnTgb0q9jdjpu2lzojhvIxLRKbNt5WEc+M1vQtzVYFfh
	nY/DWshObyeoWtwb2MSTW3GgfzpWtqATsJ1CbBkE+fPhP76A06OazTI7
X-Gm-Gg: AY/fxX7JklmidXkUibjGwTM830kptb6Yn2EoPFaVN+fvX+cH+dZF9kRitlhSbPwUfss
	vAMzwCSRhVeWE6yCu/7Ec8Yh3PiDchfRB/9SSqj3NT7I44gkymFhU90t10lx+BzgrWlXAu6B23P
	XPKMKhjvk29diXPCXLja42M+tzM8K8U3xokDV1zfTGwM8nBdhOTiOZbiKtzmuodLnJ/EQkUyip5
	n67CwRrz3MZoLjvLc5RBaaxVeUoZs41M6fo35iD2V7IdB3taE/ogHxIqLSfW0Pmp6x9bQGA2+kf
	yfxdQk0L1JHziVwtmqxz6LnmIDcZwKoSiv21c6G93af+JkWtHx0f7qFvL4cTUCL6oRdhZFcifDG
	M04hw+ncpJsHt8JCG82DL70dGY0Q4gB7Ou8BMbMvXLnhLlY3vz64FmMBy4KjjWpvdiQL0WwBKxd
	FIzEjDiA==
X-Google-Smtp-Source: AGHT+IFm4l8dcKmr0PiWYkDopuxXg0BxrY4X6KsefFxFPAmT83JBEAf3V2esc+K5Zqovpr54R5R52w==
X-Received: by 2002:a17:903:41cd:b0:298:55c8:eb8d with SMTP id d9443c01a7336-2a2f272bd8fmr96236925ad.35.1766383997351;
        Sun, 21 Dec 2025 22:13:17 -0800 (PST)
Received: from lmao.. ([2405:201:2c:5868:68b9:5b3c:f13:3fb2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c82ab4sm86453845ad.32.2025.12.21.22.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 22:13:16 -0800 (PST)
From: Manas <ghandatmanas@gmail.com>
To: stephen@networkplumber.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manas <ghandatmanas@gmail.com>
Subject: [PATCH v2] net/sched: Fix divide error in tabledist
Date: Mon, 22 Dec 2025 11:43:06 +0530
Message-ID: <20251222061306.28902-1-ghandatmanas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, a duplication check was added to ensure that a
duplicating netem cannot exist in a tree with other netems. When
check_netem_in_tree() fails after parameter updates, the qdisc
structure is left in an inconsistent state with some new values
applied but duplicate not updated. Move the tree validation check
before modifying any qdisc parameters

v1 -> v2: Fix whitespace
---
 net/sched/sch_netem.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 32a5f3304046..1a2b498ada83 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -1055,6 +1055,11 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 		q->loss_model = CLG_RANDOM;
 	}
 
+	ret = check_netem_in_tree(sch, qopt->duplicate, extack);
+	if (ret)
+		goto unlock;
+	q->duplicate = qopt->duplicate;
+
 	if (delay_dist)
 		swap(q->delay_dist, delay_dist);
 	if (slot_dist)
@@ -1068,12 +1073,6 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	q->counter = 0;
 	q->loss = qopt->loss;
 
-	ret = check_netem_in_tree(sch, qopt->duplicate, extack);
-	if (ret)
-		goto unlock;
-
-	q->duplicate = qopt->duplicate;
-
 	/* for compatibility with earlier versions.
 	 * if gap is set, need to assume 100% probability
 	 */
-- 
2.43.0


