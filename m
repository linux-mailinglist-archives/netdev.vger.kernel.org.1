Return-Path: <netdev+bounces-154435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6484B9FDC65
	for <lists+netdev@lfdr.de>; Sat, 28 Dec 2024 23:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A3A160FA5
	for <lists+netdev@lfdr.de>; Sat, 28 Dec 2024 22:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EC522612;
	Sat, 28 Dec 2024 22:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1/3C6wf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CF778F29
	for <netdev@vger.kernel.org>; Sat, 28 Dec 2024 22:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735425238; cv=none; b=Tir4Fi8CU5LZQ0UWjHbHLoRGEm88Cy5b65vdnjgDjcNkyuQ8p7y3CKFWlIypDfkJltC6VsOBMmB0ix07TiNYykoC5Z7K+f++gE/qGpycyegmkvsEdm9tfctC4fZTK28hdRC131rcHg78Rf9aNH/5aX+4LWe6fmuxhkdR8UfGuH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735425238; c=relaxed/simple;
	bh=wAilquljEfoKTwDm86E3RZLfj5HcODaDL8PphQwLxHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fmoihz83HD+371t16neq9CafEza9p648h3n7G+lpSIU2O147LEawNVGDEjET2p2VvYKSXd0DoclkxrPrCh54fwqQW0GI1MTlghfJft0r1FE8LlG5hoBxWV50DLAY3jFRYQsYmxBlDurfs4cY1WWmc2kdo6phzDD1y7AEjLyG9xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1/3C6wf; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e5390ed85a1so8772631276.1
        for <netdev@vger.kernel.org>; Sat, 28 Dec 2024 14:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735425235; x=1736030035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ONf6Z1d2yilza4D9jyG+gZOIh5GH7ub/Yhwixk/hI0g=;
        b=I1/3C6wfHSJbxDwEW7Lcb/Zqev/BHYbgkAhZgQlGtHeZ2mdpy8Dhk0Cd+3DBMiT0ay
         mL1/HUFKO4aFXmkjpO5qroWq7ryWepI6Xa/Zcfo/9RsbPKj+t8ewh0hPe5e5HUjNHyxG
         IBblYhJMCKLluSE9hdOI33tSnT+0ftWiDDqNExXEJMt81cSEWRa2T+Zky1mNydrts+y6
         i3ESQvU5BsplNZG6sjY1Icm+sQxWq1uTH9HkzlxexM3JtOV13o0w2CaAlDGdKW9bnkDn
         Kqya1g2jkJKZxbril3o7oG9EGRa6gvZ+tIGeFxiCE3MQ8RwsvCCM9LRpYoH+zYRqYKWD
         sv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735425235; x=1736030035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ONf6Z1d2yilza4D9jyG+gZOIh5GH7ub/Yhwixk/hI0g=;
        b=CF3ZxNzNDfZsdd8uQx3+Yk3h8y3LJ7qpC9TuaygYDMh+aifsm61ojfAHFSQEhklKXV
         cI6+Ni3cWN6FX+gip0afrsBhghp/7g/60Cu5wmuNARUzKKWjM1VtLVV7zgMzLpNfRGFW
         mb0Zv4UsWnAsRHxevkXgIuQ7eauv4W+0LntJL7V/+0VLT7saetBW0WdkEdYXTDyKggQL
         Ub1dAo8mkhtItApzsvnrf2kKOpHfMPJPNB9VEHbsbnQ6vFy8JQflQybyWHOnvRqyCCKD
         ruYexHAw/EgiGXStCQkP8A7qqZNoyJPPTAfRSkgEK28GhopqnG0qmg8YCzUXJCvFqPTi
         gmiQ==
X-Gm-Message-State: AOJu0Yzh+VOrVzQd+Gc+CdvfMVAXdNK+/Vm5dsZ2Yv2V3XTyjUH5d9X2
	lE3IgQUgjRobOtWXVaPmLJzr/l2/9RE+jIRbeaqE7cyA6kQgspxkUngygM2eVjs=
X-Gm-Gg: ASbGncsh00alwFALP7Udh4wosXDQziu+OqnibZe6zsOJVE8K8FjK0v7nt4LPo5IaGS/
	EwG6V2+zZy3TR8Cmt5diqfWMfxqX5+RnqalLkaD/LXhHyTd2AIuz7kaJXd4wX6NH+P0O61qSEcn
	q0QtP6jSNT4G90DQ7NzLYSCXP/k83tfMnzmJzS8tu2HrCPiwPBrrMShrI1oWVKT5tCBthp+HnyX
	OzpMPe8HlKFxGq+fRzGbRd0Fh9KqLu5LGwPyFDg5SHhg+NQOxaBQjxNhMnhhMc69VgldwhMoRP5
	CJk=
X-Google-Smtp-Source: AGHT+IHQznPng0dPO7dQD+1Z84iTUh6TShAg8cJm4dsyCJEgDqk3uLDOD+QkloWxTPaGslw52M0hKg==
X-Received: by 2002:a05:690c:6605:b0:6ef:57f9:ec4 with SMTP id 00721157ae682-6f3f80de947mr216711377b3.5.1735425235423;
        Sat, 28 Dec 2024 14:33:55 -0800 (PST)
Received: from localhost.localdomain ([2603:6080:4502:9259:76d8:3eff:fe5e:180c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e7837ff7sm49066057b3.110.2024.12.28.14.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 14:33:55 -0800 (PST)
From: Neil Svedberg <neil.svedberg@gmail.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	Neil Svedberg <neil.svedberg@gmail.com>
Subject: [PATCH] iproute2: Fix grammar in duplicate argument error message
Date: Sat, 28 Dec 2024 17:33:46 -0500
Message-ID: <20241228223346.369003-1-neil.svedberg@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change "is a garbage" to "is garbage". Because garbage is a collective
noun, it does not need the indefinite article.

Signed-off-by: Neil Svedberg <neil.svedberg@gmail.com>
---
 lib/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/utils.c b/lib/utils.c
index aea4e8b7..be2ce0fe 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -812,7 +812,7 @@ void duparg(const char *key, const char *arg)
 void duparg2(const char *key, const char *arg)
 {
 	fprintf(stderr,
-		"Error: either \"%s\" is duplicate, or \"%s\" is a garbage.\n",
+		"Error: either \"%s\" is duplicate, or \"%s\" is garbage.\n",
 		key, arg);
 	exit(-1);
 }
-- 
2.47.1


