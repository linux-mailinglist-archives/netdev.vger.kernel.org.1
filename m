Return-Path: <netdev+bounces-95239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44C28C1B84
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEDA0B20E5A
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F91413F454;
	Fri, 10 May 2024 00:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JeIaZUpi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF54713F441
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299921; cv=none; b=QPh1tTcIgQ+0uGk1wBBk/2lD4BENqwWSHTKsBtxVTqzT0KFGbSfVJP8zmM00Ch4EciibaJIVBLTWRfmu1oHjpe9rELAqqd6IKKkYTPQjELq3yKWi0WPFbp+pc9NIrDm5Drrp/FobVMWLbHiz9xZnOIigwGx9foAeqx7BTjf27vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299921; c=relaxed/simple;
	bh=jE45gpZ1KTSsY5XCGOeLgNUi9aY8DlfJc8fY4kJyD/4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XTRc0tEu6AIqUGSEuY6d+GVS7newB+KfhGLRXK2d/ljfH+fY+/AATV5hFQn8EeFA2Qi4J/3/ypTHmoGH5iukpafddcz+kcKqU2Rf39+TXp4tqfSyXNdFCIFZ/SMApytDbpXsH+gb4N73uVJxBpudiW929UpthgoIMxs1MVcn//w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JeIaZUpi; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso2035243276.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 17:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299919; x=1715904719; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BYMEuhcBRYdrdeW7LE9Reeo43EZwSWrRoGWRRX0Ndg8=;
        b=JeIaZUpiXk/5lUq5fO8xgTskNOrXuOLETXFDH8wVBspHlCDbqJdwOk+LYYfNnpfHmK
         yO1JR0GOYYkSwL3+EHb2Z3FTetA2kGB4P+JrrBV0scd0zLwW8oCFJYagj98Kzu1uoT+L
         j3Vn2TmVmu5QuHC10uv7GnX8FKmZwwyq0t6mfz/KU+230zFF9kKoMr2v1QPZopddapNS
         sCflhKldIFor91Ln2S6rp7QVk+kUXt8x+afF8W4osY8d9HzfQ+GHLp/coYmuUGH6HsnF
         G4Nqo9E5eqrvde1/XggbLormRNfojVwWTx1m1EEHd/DTIXqZV62itEnU50jdzHyf6Ufw
         Y9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299919; x=1715904719;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYMEuhcBRYdrdeW7LE9Reeo43EZwSWrRoGWRRX0Ndg8=;
        b=ib43dRsmeBmCYu4YAO2rEiYY6Kw9SjPd9TGg2fmxV9NB05B4dbvfuMa8Jy2Ouk6Z3j
         cqy1KtEfBGr6sqmptToDscy+rJ1JZQASCv/yQq8hk2pVbSmlZgsIcxdpFWCWJtoUthnL
         KEyZSA+gyh2vH3ZBS8ZPvckppxqqfsc1bV/WRwOJ9kK7cq/ZPSWjxpEIzIFOO4TLJ3Qk
         NbJir1Ew0+z4wGIdKGSyUXBLtSKr2812lp8vTQCWytlVXgigBnERILfqzoNOV7PSJyvu
         JMe5X6jheP4JXdwDnnmTji9Z/0IYSTH2Yk1C06qfSOEmbCqdBcBjoMZYJPsgiKxEWYVE
         fuJA==
X-Forwarded-Encrypted: i=1; AJvYcCX1a8AjOGJjeNFYDdhNmZk4djSg/GbREDvM47h0Gbt0x7fGz5x51gWBWMeQMm18pgl7xWWHtKLR6LkyMoFOS8YJTWpwZ28s
X-Gm-Message-State: AOJu0Yy84Iat7en2MDO1TuWYEviCxgyprep8sCsda/PY7w6gagoxUdQy
	MR8fKt34yjKhuZqhWVaWpCwSsZn1izYuUegJYaPvUP7206gFZs1F6pnjVDUVNPOZ/BpmYD3pcur
	Gww==
X-Google-Smtp-Source: AGHT+IGnRoeQBtuZxzcPWjwywyTHSBvqGTn57r+x1oMgzZldK2qRt0ARLK/sBbQJDZzDkd0rOgXURBYUR5w=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1502:b0:de5:3003:4b7d with SMTP id
 3f1490d57ef6-dee4f0e7b62mr294526276.0.1715299918958; Thu, 09 May 2024
 17:11:58 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:18 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-62-edliaw@google.com>
Subject: [PATCH v4 61/66] selftests/tmpfs: Drop duplicate -D_GNU_SOURCE
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
 tools/testing/selftests/tmpfs/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/tmpfs/Makefile b/tools/testing/selftests/tmpfs/Makefile
index aa11ccc92e5b..3be931e1193f 100644
--- a/tools/testing/selftests/tmpfs/Makefile
+++ b/tools/testing/selftests/tmpfs/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2
-CFLAGS += -D_GNU_SOURCE
 
 TEST_GEN_PROGS :=
 TEST_GEN_PROGS += bug-link-o-tmpfile
-- 
2.45.0.118.g7fe29c98d7-goog


