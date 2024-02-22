Return-Path: <netdev+bounces-74207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2938B860739
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 00:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C91D5B22585
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 23:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9069143C40;
	Thu, 22 Feb 2024 23:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UI/H19gG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B689014265C
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 23:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646193; cv=none; b=HZrWHz/veJZi920PAMjVFa8s5T0W10bq0hSV1cJI9sBX29xFQhWHAjZzNzzrH0FcO4KeORDPgkUI2LL/T90eF1H9sBk9h6/8hh4COBP20vlsHd14nuETjwTDYSL67c8BP0Vddedgl9wgIz76K1253PDOupXUtTW0b8/lcQRJmbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646193; c=relaxed/simple;
	bh=r2AM1GE8K+Jk+X7ZcLAMIGD8Oi+EV60OidErbIp26fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMvzW6t9q6qhk3FalIzo84SUKVm3FndjzubQ2uDcdc0Tzww1zdEHo7VjyEd6OxgWDyuVFcpjdvHkvtUHwp8Pyu9g3dSRMGVjw/uShmnCZgYz35Sk1z7fJKEvSgX4NNOpJ3+C/opGt31kXf/SexqwuGSAgTv3tLoHoXI19+GMPsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UI/H19gG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8987C43330;
	Thu, 22 Feb 2024 23:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708646193;
	bh=r2AM1GE8K+Jk+X7ZcLAMIGD8Oi+EV60OidErbIp26fE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UI/H19gGVN3NQ9LcPuBRvx6ZpD2mzl0cad+N6MEUX1ZdAOEzKjWJFlTs038TFbj5p
	 HvQ3V0mHpZjJPbhzZdMBVEdiur7dSY+opWVDJvHVFCWRC35BoyhF7LzogzO4w/EEZ3
	 HbNMhIgo1JR6Ixx5PptF2PjaLI4ch082P962cD6X1WklYxG5RXGu2TqWgjftQszfEK
	 CcmKGBCPRJ64bj9edW9h6lvyE1I1rl1ehRjPc7/eZwU9PhCUcXJ3zCYKIIeiHK2F9r
	 pWH776tduPZCIv2TukoyyDS6uSWop9C0b/dWb2HL5JtXu+2tId5+EYsLAxheJpg4oa
	 w/nNsrQDn5TtA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	sdf@google.com,
	nicolas.dichtel@6wind.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 14/15] tools: ynl: remove the libmnl dependency
Date: Thu, 22 Feb 2024 15:56:13 -0800
Message-ID: <20240222235614.180876-15-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222235614.180876-1-kuba@kernel.org>
References: <20240222235614.180876-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't use libmnl any more.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h   | 4 +---
 tools/net/ynl/lib/ynl.c        | 1 -
 tools/net/ynl/samples/Makefile | 2 +-
 tools/net/ynl/ynl-gen-c.py     | 1 -
 4 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index 37720e505a11..42b8d88ae587 100644
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
index febb7581062d..e9631226cd8d 100644
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
index f12e03d8753f..9a58dba2ef1d 100755
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


