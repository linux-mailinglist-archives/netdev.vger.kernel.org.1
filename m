Return-Path: <netdev+bounces-95178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95408C1A44
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041541C22D0E
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1DE4437;
	Fri, 10 May 2024 00:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h9tgdsDK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E9A1396
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299744; cv=none; b=kSaCSu8vR6zHrGvR7IXy3YNeICtVC7M7wjbdENoAfZXqz6j6XU9ZsfVhlOurIlp9SIMh2pkqeZCzrGAvajPMJFs01CKCnrCxk1sKQD55/HJ5zAuO+1l6TZSuekbRT5mACULjKwVWeWlUmRceIZFKZ76U4HShNyjmZRQcoSmAGQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299744; c=relaxed/simple;
	bh=5+QjSJTDZDNs5LVpnFKjIsPkpeAYO79PdZNw5dzhpsw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D/a8elT3dcGaIOGPiyjoZuuatzEx0bpcIUiYinSGKBQuJqxAXJPdXxTM7KPcyf9JV2A2gg3RErLbfLRawCNavDH2R85sPfFODYrc9kZxizV8KoXiGvVuHoMUVoPynEBpuFPHwUSkBcYVTNB+tJB5Goc7/5oL1ZlMpvInFmVMGLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h9tgdsDK; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f472477050so1077976b3a.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 17:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299742; x=1715904542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dNdh0DGLEI6gEofoq5pc03LS982vJLdNlPLV5JPTShI=;
        b=h9tgdsDKQonzlutSxCpCwGPMTCbcvMrqZzF0AYdIrIxrWxUrqXprVaPq5cqWJ8MOr3
         lgB1BrOO1VUoc1t7uBAH8Spm9+4hydxfZeA/fTwFn4OlH1kA3okrvCYxzmJtmhXOMJvj
         PfLN0FY7JYKfNcvgmL484uWG9RdvMzHAkWFVaUvtCwg3mIsNc9SGCpCVM7ekCOI5A3UZ
         lp/818zvDFq2fU3xGgCUz14NpxLekjhfyuoSVkaZZsXJbMroJFeEZ/L38UIhV/Ghn+oS
         LGwe0l7lagho55QJxjRBItBP+neCI58B3RSBHPG6FT3nVkXcH3aZSOIZZyC3RC9cFXuS
         LtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299742; x=1715904542;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dNdh0DGLEI6gEofoq5pc03LS982vJLdNlPLV5JPTShI=;
        b=fQUBzARWkpLbnQ/yloeedE2W2/E/0yvdtnHpnWODdmpBAHdGH0DH6RymW/0Cwl6R+M
         jE9QeH7fvNpqhMQLxXyTDIdnmjoNzN5XabDCMcn7SJSSMrec8AdBnnL/EUwjJEGw4NxF
         9XC5ouOwqe9hRxwcz5Yy2Yk66go76oOUmFWk/Kp+zTg1vrue+vW/S75bFg6Kgo4lk86B
         3oMgfhmbcDJaBUObYkk8dbjw0nlTV8XbOvfvXvr/5a1uSm4K+kZ6KLNPNYPGKj84WWxs
         7fA7aV32DHRHqjFAa+AjJS7uXtwGyDgbSDsj4GBDg6BHVSJj/ROOn/TmiowfwlZchyUl
         PJww==
X-Forwarded-Encrypted: i=1; AJvYcCXXUnWn+Zp6mfQcS1zPinR2Fh2JcTMWCDGhZF4qBVPHVLpyxzgHeTSY4vrUGZzrdvTpy4brs9gyakSJSYERG+BEHEj6193p
X-Gm-Message-State: AOJu0YwDK4gat4G7j3DTOa+6CnX2yq6o4S+7c2179BGw3x2P+huCVLiR
	DMYWla6Q8YASDd4Pc+OBDJ2fzto/ucUA5thR2oanAgM8xs/HhpZb2epYUPbMj8SXrMrCKwztr0Q
	imA==
X-Google-Smtp-Source: AGHT+IGtTUZs+3MsCtZfU8WOyARtKSKltxR3na4oeEBppwpGfuKUIqgIQ9le2QPvBBObPpo5IStZo3NSvjc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3c8a:b0:6f3:f447:57df with SMTP id
 d2e1a72fcca58-6f4e029a229mr27317b3a.1.1715299741860; Thu, 09 May 2024
 17:09:01 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:18 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-2-edliaw@google.com>
Subject: [PATCH v4 01/66] selftests: Compile with -D_GNU_SOURCE when including lib.mk
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

lib.mk will add -D_GNU_SOURCE to CFLAGS by default.  This will make it
unnecessary to add #define _GNU_SOURCE in the source code.

Suggested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/Makefile | 4 ++--
 tools/testing/selftests/lib.mk   | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index f0431e6cb67e..9039f3709aff 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -170,11 +170,11 @@ ifneq ($(KBUILD_OUTPUT),)
   # $(realpath ...) resolves symlinks
   abs_objtree := $(realpath $(abs_objtree))
   BUILD := $(abs_objtree)/kselftest
-  KHDR_INCLUDES := -D_GNU_SOURCE -isystem ${abs_objtree}/usr/include
+  KHDR_INCLUDES := -isystem ${abs_objtree}/usr/include
 else
   BUILD := $(CURDIR)
   abs_srctree := $(shell cd $(top_srcdir) && pwd)
-  KHDR_INCLUDES := -D_GNU_SOURCE -isystem ${abs_srctree}/usr/include
+  KHDR_INCLUDES := -isystem ${abs_srctree}/usr/include
   DEFAULT_INSTALL_HDR_PATH := 1
 endif

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 3023e0e2f58f..e782f4c96aee 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -67,7 +67,7 @@ MAKEFLAGS += --no-print-directory
 endif

 ifeq ($(KHDR_INCLUDES),)
-KHDR_INCLUDES := -D_GNU_SOURCE -isystem $(top_srcdir)/usr/include
+KHDR_INCLUDES := -isystem $(top_srcdir)/usr/include
 endif

 # In order to use newer items that haven't yet been added to the user's system
@@ -188,6 +188,9 @@ endef
 clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
 	$(CLEAN)

+# Build with _GNU_SOURCE by default
+CFLAGS += -D_GNU_SOURCE
+
 # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
 # make USERCFLAGS=-Werror USERLDFLAGS=-static
 CFLAGS += $(USERCFLAGS)
--
2.45.0.118.g7fe29c98d7-goog


