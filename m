Return-Path: <netdev+bounces-75500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BAE86A286
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 23:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23BB283C1B
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 22:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F5457863;
	Tue, 27 Feb 2024 22:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4m3Va6L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FA357860
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 22:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073052; cv=none; b=fBiSUCw0P0GFc4ij+vVgITmmWuhuBnwLxdq9/WBFCxHkK7Mp8iY/Zf6IPJhTd/cRheyyUh12MWEBNwRnD28BBlSGXLnSKOaHgMxWmXTez7Vu+Wy1IzEzXrgqv1sPEgVOJDo9TYZxzE8n8EpJ9h1R7BxZZcorPG0DXIacCrGLpKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073052; c=relaxed/simple;
	bh=9JF46KlKPMpcwmZ4pDNuwmMQzCtUGz3MHupD7i0rgao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMUSXnWA+b3pp9LK6gmiaV0/gc5ZkmC/AUsj518mVicpJKVPlFCp/zL69TwyDUpM7wL96O8unrXU80INshwD90Z68TltRvIo2E1t1H2naHylj87XGvmlw55tx5KlbS18QOOdMw8wGH8Gh8p+IraCzIpXavd6wUcjQckc9OOcEj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4m3Va6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B18AC43399;
	Tue, 27 Feb 2024 22:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709073052;
	bh=9JF46KlKPMpcwmZ4pDNuwmMQzCtUGz3MHupD7i0rgao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i4m3Va6Lbx8u3+/4wylyRTfEgNZFLcjcluHy9x0WxIKu9DozJJi7esok19Iz/Lnum
	 C1pMlWY+yv/MuCdy6cZgLGLuxbzhRa2lP8Mb+WTQRxSCSZ0oO+VmDdYhmVPXTlGKZw
	 ZIOVK7FVUyFOsb8LJkHHwVHjZzCp1M1GnrU7IeoKot7odS9L6+jvNtZ8omHUPyNXBa
	 uC5A40/6JlssLmFl+tZmhwAQ7GDirU6CJ9RMcxjjmjxCCNSa/K7A9Ta8d1pJ260tPK
	 eCDUF8yN7EkBl8NeBCOu722yj5js3V2w+B8DTIaQP8lQn/fRNhIDZ5K72Mlz96ys+Y
	 mTRpqBLVi3ZbQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	nicolas.dichtel@6wind.com,
	donald.hunter@gmail.com,
	jiri@resnulli.us,
	sdf@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 14/15] tools: ynl: remove the libmnl dependency
Date: Tue, 27 Feb 2024 14:30:31 -0800
Message-ID: <20240227223032.1835527-15-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227223032.1835527-1-kuba@kernel.org>
References: <20240227223032.1835527-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't use libmnl any more.

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h   | 4 +---
 tools/net/ynl/lib/ynl.c        | 1 -
 tools/net/ynl/samples/Makefile | 2 +-
 tools/net/ynl/ynl-gen-c.py     | 1 -
 4 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index 5150ef1dacda..a8099fab035d 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -2,8 +2,8 @@
 #ifndef __YNL_C_PRIV_H
 #define __YNL_C_PRIV_H 1
 
+#include <stdbool.h>
 #include <stddef.h>
-#include <libmnl/libmnl.h>
 #include <linux/types.h>
 
 struct ynl_parse_arg;
@@ -12,8 +12,6 @@ struct ynl_parse_arg;
  * YNL internals / low level stuff
  */
 
-/* Generic mnl helper code */
-
 enum ynl_policy_type {
 	YNL_PT_REJECT = 1,
 	YNL_PT_IGNORE,
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 9d028929117a..f8a66ae88ba9 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -6,7 +6,6 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <linux/types.h>
-#include <libmnl/libmnl.h>
 #include <linux/genetlink.h>
 #include <sys/socket.h>
 
diff --git a/tools/net/ynl/samples/Makefile b/tools/net/ynl/samples/Makefile
index 28bdb1557a54..1d33e98e3ffe 100644
--- a/tools/net/ynl/samples/Makefile
+++ b/tools/net/ynl/samples/Makefile
@@ -9,7 +9,7 @@ ifeq ("$(DEBUG)","1")
   CFLAGS += -g -fsanitize=address -fsanitize=leak -static-libasan
 endif
 
-LDLIBS=-lmnl ../lib/ynl.a ../generated/protos.a
+LDLIBS=../lib/ynl.a ../generated/protos.a
 
 SRCS=$(wildcard *.c)
 BINS=$(patsubst %.c,%,${SRCS})
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 375d5f5e3052..2f5febfe66a1 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2677,7 +2677,6 @@ _C_KW = {
 
     if args.mode == "user":
         if not args.header:
-            cw.p("#include <libmnl/libmnl.h>")
             cw.p("#include <linux/genetlink.h>")
             cw.nl()
             for one in args.user_header:
-- 
2.43.2


