Return-Path: <netdev+bounces-95188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF7C8C1A7C
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288201C21C74
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF29E4E1D9;
	Fri, 10 May 2024 00:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tCVm6HFD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3175B4D59E
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299780; cv=none; b=uFmENe8UzdF/BRIhRSYft03Mz9+Kgvb1Xor2Vt5UbU1pMsYdcPQJwkW42xzplGLoaJ/heuuLPAvEk8RYDjG/0kEfd47U84LvqI3S1pExyJZIh6h1nFvt2UaFqZ6lcpmO9FJo6qdrt/XKhish3//swomF3efRH1KuQupBoKssCBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299780; c=relaxed/simple;
	bh=CSBdvD2frVESGJuxr2TaxNx/hmxxufst4kdYORfDT+M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XLMSv/VkuKr6c/iYqBFMy6R14TT2h6SoUme1KcbuP0DGerFien9ZQfpESZwyRTexbPmYl9cA/3N7MdL6FnNIqWLpewOZrvFtv8r5i17uev+3Tl8NDMmjZSaia8sqxexysd80YgzzN1JAAGfxqHzbotGXsxQYlON0Hnbo9U+FCrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tCVm6HFD; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ee128aa957so1488119b3a.2
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 17:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299779; x=1715904579; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/pfiCQCOCpeS3b+P79XSlfM275G98aKUlpvA+FpfZ7E=;
        b=tCVm6HFD5zhVvaybywcHIwxwbYbNsK3Otb5KsDPdkcmDyimr/mrIAYJozwtuZdFvqR
         qpc5U3H4FHtDCWIpPa7wR99FOKAqBW/R+xe5sEN5W9vOHZLRnlG+ji1puKBC8LYsZqCL
         wWRw9Ls7RvWFNvDCv4/GDEWoG7gJXQDzXlg8pNNL1rd0FsONRXFvMhOsXEieecGhijM+
         U4ltlo6e0fzHw/JG+MUZU9bGZJRzCJO4ncwq+BJ2NPoWoZoQi6IQsbskUwiQ6VpuzLen
         wxOrjjmrOAoarQIwNpsIFGFkZJJu4OlD/JkXB8IB5RLhN2AK/hY2G4ealYuTYN3NVFLD
         kt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299779; x=1715904579;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/pfiCQCOCpeS3b+P79XSlfM275G98aKUlpvA+FpfZ7E=;
        b=pQDHVg8lfM+OV5DayuQer/vfjKs9kQrjKzXLzXqmFqlzDcZ29wST72FcSM0WDru16j
         eaYFvY+lU28/BVujC0kpMr8czbv1uYA6nPqIfO2cW2rtAiGZbvA4B3rmX9VP8qmwVRPy
         uuJKiYQK/2r5yc6PKpUjfSBHJnMbwo2tqJuPrXuBzm772W3/U69fcAKFGZuNxsZ0f6Rl
         Exu18/6EljfrCknJepPAoebxND0oj4Rj6ng/T+uDMRklrWOrKLD4Jf3IQlzEdJXzLpMX
         bYNXcl0FwOyIsV9DSz8V24dL/BE2fNYuNE5VWEqf3oEb3Gsre6iNXKXCWKm6HBb6v8Xt
         CTPg==
X-Forwarded-Encrypted: i=1; AJvYcCWvRbAYr7fHdxFk3iyIDy0HjrnSjca1dQvo8n8wTV/6c/yj4rA9dcrGuQhlSBfDfnpXHstz1XhgNMr+J4fDcdqM1UBQaVDn
X-Gm-Message-State: AOJu0YxJH3yyHSheax2w9dzhuCl9shJJp4HcQju2wklAdHkuivbtdJuv
	Ydg4rJsBOaKqgFyBZQeDoRfsj8wg/DkEgHZQPcuC0qA7SbpSJ+9qKWUXkDa2DypBVCrM0iW2rck
	oTg==
X-Google-Smtp-Source: AGHT+IHa1F5rhkXxvj9b2QgJYJivMxzP9dzNJAuDLYs3QTWopUFJ10s7HO1AbC/fEg0FqzMYeA/jrLgYEm4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:2da8:b0:6f3:ea4b:d232 with SMTP id
 d2e1a72fcca58-6f4e01b953cmr21075b3a.0.1715299778653; Thu, 09 May 2024
 17:09:38 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:28 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-12-edliaw@google.com>
Subject: [PATCH v4 11/66] selftests/damon: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	SeongJae Park <sj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, damon@lists.linux.dev, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c     | 2 --
 .../damon/debugfs_target_ids_read_before_terminate_race.c       | 1 -
 2 files changed, 3 deletions(-)

diff --git a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
index 0cc2eef7d142..3f0dd30f61ef 100644
--- a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
+++ b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
@@ -3,8 +3,6 @@
  * Author: SeongJae Park <sj@kernel.org>
  */
 
-#define _GNU_SOURCE
-
 #include <fcntl.h>
 #include <stdbool.h>
 #include <stdint.h>
diff --git a/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c b/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
index b06f52a8ce2d..611396076420 100644
--- a/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
+++ b/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
@@ -2,7 +2,6 @@
 /*
  * Author: SeongJae Park <sj@kernel.org>
  */
-#define _GNU_SOURCE
 
 #include <fcntl.h>
 #include <stdbool.h>
-- 
2.45.0.118.g7fe29c98d7-goog


