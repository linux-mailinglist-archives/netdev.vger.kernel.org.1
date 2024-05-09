Return-Path: <netdev+bounces-95063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9870D8C15E2
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525AD285618
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9915485938;
	Thu,  9 May 2024 20:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YbxhrzLJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0BD84D3B
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284852; cv=none; b=k78U7dlF+O5RXpZjSOHUJRLS7Eck/UNz1FFBpfR/vUIimI/EDQwnCDnMN2Fyd/i3xfAGHzTp+iWcZ/FeyExg1M2eGUXzWv36UDFsJy1sE0Fs/YbKdW3QPoyBChTB3osM5tb8ppAk93sgBdLimiGYMd80FFbHtVYAppQtku2DCdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284852; c=relaxed/simple;
	bh=olG+XfDL3xDdohtjq5mUHNgjYfinvarWZWSY+TyFh0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XVIMT13a3Fibs1quDAD4VibPBEWzM8rZJliiPGVbcl7nAmKrVdyW8OAkjcCCR5eSNo6PQGtZHd/eC+S2Dvlj/WN+qJ7tz+dWY8p73v9lzXkROFqXpl9dV7DjceahleIFy0h/9FCuqxachahuNK+Qi5Dox/ZfkueMI2QXVxMlS/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YbxhrzLJ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61e0949fc17so20547077b3.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 13:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284849; x=1715889649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8CLdotFEq8j908dUbT6RbcvFD+YTCI0iXOlq7nFkwSk=;
        b=YbxhrzLJHfALsYA/PUh3m3WC4pHJpa3lO7g+ECbMiaUbh/ATox7Wt71ok3O00i9peh
         sIJDw27zFF36Waua/LrOBQtMWzpBxcu5PDn5wnk4RGSlAc+IpSqvmIZ6PPLHTONDuMu4
         bCFKATO65omrW3g9qKAAhwtosIW6+IlalFJiw5YfP+yH7fINC6/sXa7358MgqbGaw8XG
         PQqbNKxjfuu+SF62l7ABcnpm/5IHBZhJAfsc8vuWH0b00Znf/908z4QLf3SUdtDn0dqg
         5AOdTORHvH0K3RrY/2NaJSHidUh89a/tNXPo5sAKJK3VRncTfKq3FGwjH4NOq6A93aCC
         UE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284849; x=1715889649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8CLdotFEq8j908dUbT6RbcvFD+YTCI0iXOlq7nFkwSk=;
        b=h3lik35cj8ptDsdWUiNDpJStp1CPp6p7UoCpdadt369wY/2U4jFijhXg+3y/dVsNlN
         A1lkn+LOglDp4MURfKjHQkGn3xaN4fUqlY2/X5jEf6/U8peDfTnlQplCjDjo8OxHv3dO
         Lm9kG8YOziUGZY8fVEa8sINYwekLF2GULu7RHQBAxKaDuefg7cNaLESG8YEpIroUk+fE
         sZHyZbK9aHeHUtyV/dh5TK5P3I5SWSOpBrYO9CcwXdfcR/Q1C23ikqOtxy9+NCtzulzc
         oX6e6viMCD2qq4ixoMCkHdd/QvynlOceFXbuLzLd5+ratCGUBw8+HkZMBkt+FaCYg4aK
         PRsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKzuac53Ga9q2nfvKbzo1U794T+0NQSTIwzn18pb7Ik8HbQZOEl58hbeGvTv3/LzeoaNGVhro+AlPbf0IkZLfHaRToUVbw
X-Gm-Message-State: AOJu0YyAVMLu1YLZdAQraowRx1FaDIUiMyoHtV0DqbnpHLAD5bXFjby9
	XDSzoK0kigKnouwNfgZrz7wk07w1EDVsUWex6Ie3+sump9spX8Tj9SzCd8YtaGL5ZyjF9QnJeQs
	uLg==
X-Google-Smtp-Source: AGHT+IGZb1++ccVRLEMIHpSPN2qAQJXid7wFD4piJoYbkIu2XX8BrfoTxjJ3q5NtoiGCFIfHJDyo+fBfXww=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:705:b0:de4:5ce5:2656 with SMTP id
 3f1490d57ef6-dee4f301355mr46992276.8.1715284848710; Thu, 09 May 2024 13:00:48
 -0700 (PDT)
Date: Thu,  9 May 2024 19:57:55 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-4-edliaw@google.com>
Subject: [PATCH v3 03/68] selftests: Compile with -D_GNU_SOURCE when including lib.mk
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Edward Liaw <edliaw@google.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

lib.mk will add -D_GNU_SOURCE to CFLAGS by default.  This will make it
unnecessary to add #define _GNU_SOURCE in the source code.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
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


