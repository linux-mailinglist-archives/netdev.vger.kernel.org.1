Return-Path: <netdev+bounces-75113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5BD8682ED
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 22:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1968EB23401
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 21:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C6B13328F;
	Mon, 26 Feb 2024 21:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFFAywxP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E2213328A
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 21:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982434; cv=none; b=JjSeP+/HgQ/vmLFIqohf4peln+bDpRiDCbro1z8WW5v/+O6fpkIkQlon8wMTddIc21vhBjrFpcgRiPWpxEa3uiiuQnMOx0Dv3DJNvp0ahhZ8+GGaK4U0IWGwzi5ai2lXkDZPEKTrYzgUxj9HModUTd2FIS47M3Vu036qItZDCSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982434; c=relaxed/simple;
	bh=njor6yy9tqlxIgdG0iiesjigwUlIK6GveF9DhMAiiyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzWCf9lpPasi2E378Pw9/7hAFs1evA401Jbmo1Z81NaU0l8vUPmjyTBInXLlnvk+a1wffgCBS1m/J148tCE5LF8e+J8KrFwnyQEPjMmeZYnm9NPjf/Y6ES/iwSCWbfHrGIqqM9oYCVBPDr99ITf2r8Z3+DTLK4l+TfvXh3fUi8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFFAywxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33ACBC43601;
	Mon, 26 Feb 2024 21:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708982434;
	bh=njor6yy9tqlxIgdG0iiesjigwUlIK6GveF9DhMAiiyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fFFAywxPl+7XjCdGvgXfy4y/T/a+vY77Dk5wQg9L87fPMAPBDqJV/kRHEC78nipPv
	 nAxz4uXKnmyDcVadVpC1Mmu2x/II1dsTq/5jaNvSrAY7kO6kB7OypZqZGSFajctaSN
	 xVsvIB+oVfCpFrq5x3ow90lEpB7tIVlmN/Qhz2i+vI5HxcSDpF1b5Phn8rhWS426JP
	 8066q4oh97ml7UktjzvsxIJzqExnlXJXzTB74AzsKmbV6tPDoE/gdBQDPhwYEL1zI2
	 NXvq+4ot9MOxi5+9c7w+9Av5KqxQqc4Hr5uKd0cW5Pc9NEvI4dlzBAZOS9nCvsNcIZ
	 wvQVMI1NX91rA==
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
Subject: [PATCH net-next v2 14/15] tools: ynl: remove the libmnl dependency
Date: Mon, 26 Feb 2024 13:20:20 -0800
Message-ID: <20240226212021.1247379-15-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240226212021.1247379-1-kuba@kernel.org>
References: <20240226212021.1247379-1-kuba@kernel.org>
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
index 791b3f665e26..8beacba00072 100644
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


