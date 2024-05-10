Return-Path: <netdev+bounces-95198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45A38C1AB0
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A211C20950
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E5612BF22;
	Fri, 10 May 2024 00:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bTyEcJaq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F134812B15A
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299805; cv=none; b=bqZ4RZIDAsjfrfxaxQ/e2Y/YtK3dQaWFBndj+7F8BVIq1wFMqC+XZMGwwaI8mSfyzOxBiilxhF4b8vLQA1CxkGQSlKt5i1a2r2KgYEk6zVcUtSvTzIcylf/iJzkI76X76zhgv04tZPI/qZv/zelYnGJZ74M1isBNApkB2RXVU9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299805; c=relaxed/simple;
	bh=VGsCQqHe1ICNXcu6Xm0RUTfwKrG6XqF3VyhcVP10zHU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ITBKlfV8jgE1hcqEMdegH5U0sbdBExZWeSLvGvEJl8z+OYuZcmwIN8Ow395rxUE8zI6AdVH298MMS2SqD8Weq0C9F3COGNSWlz3vG4uwr+QjuFXzhpI561ou0ktZLzt2IAHFNiR/xbdz3ITuEYk11ls6xT6ryXf9Cpmjy3N3flo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bTyEcJaq; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ec3c838579so13786295ad.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 17:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299803; x=1715904603; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=29EvGICOAZ0F1vgmDohmB/AvF71KDeoXeGxlYusrQjw=;
        b=bTyEcJaqKkbeFmvMpIjnUdQiZzatL6hXadqCE1RfXyOJwaJQxKL5TYx06ZeqGYliuf
         4tMwYCpuQ44qL1UrLdD5aZkr5XNWcVk5X9IAq039Dm4p6sN9LioVFwcDeVJ27i3indCJ
         Y7rKsBsFXC83QQYSbY+m+TpCsnNO0E0S40B/GQxdMR7nshuwKplPk5P9E7aQOiFCNkWg
         IbSXxK9Wkjg9i8xHAilMEBkJo/o70QmP0FG2wC2lqy1MCLXYH4RVv+W7rIZdTtjtX7kY
         +vFSIGsvu84EIJwhJcJcloTw0X7fQsnAvxtX45R4BJo7+oLgoie4Gu6CkwVZ4D+LIUa/
         EbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299803; x=1715904603;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29EvGICOAZ0F1vgmDohmB/AvF71KDeoXeGxlYusrQjw=;
        b=aBc+Z3EL9s35UhoJHtQKbnWuOSRKvDkQ6U6ZKlSQiq9DisKbfKX0shXMxYUV+DMm26
         4l1XmD9BRpSXrBMrCkDJZRf8QcH24NL55Eh19om7dRF3jELdev5RMOvQmmw1N/e2gwdt
         fVQ2La0lEVkhqGgYZvuLieoMiEm+wg/HFndveT/W7DMiAPtkBmGx+HSRJRbkvwPwEPo8
         hvxGMrr+oCarKHTaApvv+XSzjv5pMR6/jrIGAhXE1jahgzvsXCxZDbiMqz8q6yATiJcG
         GZho1UMZ/KO6QNtqCchMYBhkvOlv4J7bgrVwwvHeVDaH/i9vfBse2X98VZUab8RTZz+l
         7hng==
X-Forwarded-Encrypted: i=1; AJvYcCWcmuMAsvvykynRl2dT9oXndkkI1pMnsO4l8SU9iyHZkMJj8t2en4qul/SunrsF/gWVKIT2VtOyUMyuknaZJ3Ye+3VZomew
X-Gm-Message-State: AOJu0YxPOan//mLp+lp3625d3HqLMTF5lQSgTIA7205ro9HWRGM1LzF2
	a1uyMB8In1Lzjc1kbhiSX52xgcaGRLuWMR1Bu61FvGzy1bH5mwbNTfYlPbeKq8R1tZOrY0TenP3
	DNg==
X-Google-Smtp-Source: AGHT+IFtyDIvJI7P2PUSrXqhLacKlQqz9FKu6p6E/UDw2sNkrLVdEwZSqWvpAdJ2mtDw06xzYlMjZpMo9tw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:903:234f:b0:1e8:51fd:a85c with SMTP id
 d9443c01a7336-1ef43f53a85mr727745ad.12.1715299803227; Thu, 09 May 2024
 17:10:03 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:38 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-22-edliaw@google.com>
Subject: [PATCH v4 21/66] selftests/intel_pstate: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/intel_pstate/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/intel_pstate/Makefile b/tools/testing/selftests/intel_pstate/Makefile
index 05d66ef50c97..f45372cb00fe 100644
--- a/tools/testing/selftests/intel_pstate/Makefile
+++ b/tools/testing/selftests/intel_pstate/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS := $(CFLAGS) -Wall -D_GNU_SOURCE
+CFLAGS := $(CFLAGS) -Wall
 LDLIBS += -lm
 
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
-- 
2.45.0.118.g7fe29c98d7-goog


