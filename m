Return-Path: <netdev+bounces-72592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C42858BC9
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 01:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D60D28224D
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 00:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090FBD2FA;
	Sat, 17 Feb 2024 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgRYTOEk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4654C8F
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708129069; cv=none; b=rEtHFScFH/E2x0qXEtkR0ftX4O4ZTYHWj4rkCUwKvIvu7zatkMqhDOPgKEB6uQWo9ioxpf9ssjWzOO5pDEkBfMao2/yVGtfilmtUcuBahXXlMKfBGcrs4tM3CayMf1/jsnPavywzrvF1sgvisg3XnZQc7rLgRQEKPj4J2OxcwyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708129069; c=relaxed/simple;
	bh=a7YHHQSj9YCCeh/jBrdS4CXQwN6TNph0vPkHrSTG33g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btLMAtUYyaE+YjpCG4vgtJi76BXHazNlW1eNyz3VlducNs6/M3oLPvRzb+H65NcF0INQTLFemo2cy7/a6SRCY8+L/TciDgOQ4Tg7e2tcY/Vj90zRwmFtBCgJHTjiPi6TPYAhoEdEeGeTM5XByEoNW0NtxEZOB9eU3umpdeO62pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgRYTOEk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CCFC433C7;
	Sat, 17 Feb 2024 00:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708129069;
	bh=a7YHHQSj9YCCeh/jBrdS4CXQwN6TNph0vPkHrSTG33g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XgRYTOEkU5yaX5s0+JRNiv4wXeEYTDPb/6E8fZOKOJrRY0UrRp9KNppgCvrolicI9
	 oLuvm0+l/Pipoq46rVY9Z5USnvxl5vOgoH8bTpHr5FVeK0pIxjdiJH7Exjj3UKcWaK
	 IrN1zwWw4H5uiHjB0nB3B5IG/PukhWDLHizVOi8ouDzCKlEoZgm1eiQyVcGAGCZooC
	 5Vf3O3G4XcD7IGkrKngFf3B32fSAT1sEB0Erp5j2jyIImbCpHtgZaYetvVX0YCnr3e
	 g1vNDGewdQDujDMNdb7ts0leiDR7uEcrJdlc1UALSzTIXK8oxP8IGPzHBz/FKLiBWh
	 yYufKqdlKr1gQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	chuck.lever@oracle.com,
	jiri@resnulli.us,
	nicolas.dichtel@6wind.com,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 1/3] tools: ynl: fix header guards
Date: Fri, 16 Feb 2024 16:17:40 -0800
Message-ID: <20240217001742.2466993-2-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217001742.2466993-1-kuba@kernel.org>
References: <20240217001742.2466993-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devlink and ethtool have a trailing _ in the header guard. I must have
copy/pasted it into new guards, assuming it's a headers_install artifact.

Fixes: 8f109e91b852 ("tools: ynl: include dpll and mptcp_pm in C codegen")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: chuck.lever@oracle.com
CC: jiri@resnulli.us
---
 tools/net/ynl/Makefile.deps | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index e6154a1255f8..7dcec16da509 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -15,9 +15,9 @@ UAPI_PATH:=../../../../include/uapi/
 get_hdr_inc=-D$(1) -include $(UAPI_PATH)/linux/$(2)
 
 CFLAGS_devlink:=$(call get_hdr_inc,_LINUX_DEVLINK_H_,devlink.h)
-CFLAGS_dpll:=$(call get_hdr_inc,_LINUX_DPLL_H_,dpll.h)
+CFLAGS_dpll:=$(call get_hdr_inc,_LINUX_DPLL_H,dpll.h)
 CFLAGS_ethtool:=$(call get_hdr_inc,_LINUX_ETHTOOL_NETLINK_H_,ethtool_netlink.h)
 CFLAGS_handshake:=$(call get_hdr_inc,_LINUX_HANDSHAKE_H,handshake.h)
-CFLAGS_mptcp_pm:=$(call get_hdr_inc,_LINUX_MPTCP_PM_H_,mptcp_pm.h)
+CFLAGS_mptcp_pm:=$(call get_hdr_inc,_LINUX_MPTCP_PM_H,mptcp_pm.h)
 CFLAGS_netdev:=$(call get_hdr_inc,_LINUX_NETDEV_H,netdev.h)
 CFLAGS_nfsd:=$(call get_hdr_inc,_LINUX_NFSD_NETLINK_H,nfsd_netlink.h)
-- 
2.43.0


