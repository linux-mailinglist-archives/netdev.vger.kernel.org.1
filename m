Return-Path: <netdev+bounces-68253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ADD846524
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 01:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9E11C24411
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 00:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E86468A;
	Fri,  2 Feb 2024 00:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPIFoZ68"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC0E5C85
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 00:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706834983; cv=none; b=fnMDIVBGgVRyj9TN9frClvqeRnXZGVxFMJbHBcv0pr4Klznl/eD755LFhguAj8p0OphbPReaAWOg5NRYKWRBZ5lXj6bw1tyXy/1XgFcjCyGLFHC8+i2sj87jGRPKWUHWjEeExnfx4FSfAQ0R/7wXEAqQoe8G08gM1IPtPy8ZuFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706834983; c=relaxed/simple;
	bh=HEMtDJ0MEISQDca3SSCsUMLBgTi+YBP2PMEILKqQuhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pE0m8H5fDGB8YlG4fKJhJbv3f9PVWY0uGofWZui+daqsF2eSXglSUd78OBhEfLdntU+X98SStiQQ7SFAT3l37D6lLUWPwmjwAVMfcvKjO2F/7QgOjUBeS7Pawf7ND5O8WS2oniqkJGoUgtlc6xu9wTeZ41QR6EhS1aS6F7w2VCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPIFoZ68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03F0C43390;
	Fri,  2 Feb 2024 00:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706834983;
	bh=HEMtDJ0MEISQDca3SSCsUMLBgTi+YBP2PMEILKqQuhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FPIFoZ68sUm3cvRJORDbcbLoEp66clz1ueOxW5S6Fa1Emd8Zd27VHUmODBaGXhGZz
	 xTiMLTbGVe+uHsYp9QocQtrnIvBlS6cYRZmDlz4+WHhmPcBjnWCBkHJc2n8EUrQLxH
	 XIOd9V4qxtG/28+a1+EIv5nEDtIu9kVdsdyL+5PtXrZ9w0p8LAdJhwRg5RjeRvo3W2
	 U9BT9YkDLrB9KyzYlNZrVxM0q5kE3tu20lvNHzgUsJR9QiA++FhFEqPJrRVCNwRWqq
	 7kcqQnrzQJdRLSF+QGfV+0+1R3m94TxITXFTD2RWnYQdwe5YCh6sIpeJWII1hs2ZTr
	 zSu7F8ShoEgOQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	sdf@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/3] tools: ynl: include dpll and mptcp_pm in C codegen
Date: Thu,  1 Feb 2024 16:49:24 -0800
Message-ID: <20240202004926.447803-2-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202004926.447803-1-kuba@kernel.org>
References: <20240202004926.447803-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DPLL and mptcp_pm families are pretty clean, and YNL C codegen
supports them fully with no changes. Add them to user space codegen
so that C samples can be written, and we know immediately if changes
to these families require YNL codegen work.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/Makefile.deps      | 2 ++
 tools/net/ynl/generated/Makefile | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 3110f84dd029..e6154a1255f8 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -15,7 +15,9 @@ UAPI_PATH:=../../../../include/uapi/
 get_hdr_inc=-D$(1) -include $(UAPI_PATH)/linux/$(2)
 
 CFLAGS_devlink:=$(call get_hdr_inc,_LINUX_DEVLINK_H_,devlink.h)
+CFLAGS_dpll:=$(call get_hdr_inc,_LINUX_DPLL_H_,dpll.h)
 CFLAGS_ethtool:=$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_H_,ethtool_netlink.h)
 CFLAGS_handshake:=$(call get_hdr_inc,_LINUX_HANDSHAKE_H,handshake.h)
+CFLAGS_mptcp_pm:=$(call get_hdr_inc,_LINUX_MPTCP_PM_H_,mptcp_pm.h)
 CFLAGS_netdev:=$(call get_hdr_inc,_LINUX_NETDEV_H,netdev.h)
 CFLAGS_nfsd:=$(call get_hdr_inc,_LINUX_NFSD_NETLINK_H,nfsd_netlink.h)
diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
index 84cbabdd02a8..0d826fd008ed 100644
--- a/tools/net/ynl/generated/Makefile
+++ b/tools/net/ynl/generated/Makefile
@@ -14,7 +14,7 @@ YNL_GEN_ARG_ethtool:=--user-header linux/ethtool_netlink.h \
 
 TOOL:=../ynl-gen-c.py
 
-GENS:=ethtool devlink handshake fou netdev nfsd
+GENS:=ethtool devlink dpll handshake fou mptcp_pm netdev nfsd
 SRCS=$(patsubst %,%-user.c,${GENS})
 HDRS=$(patsubst %,%-user.h,${GENS})
 OBJS=$(patsubst %,%-user.o,${GENS})
-- 
2.43.0


