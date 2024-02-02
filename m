Return-Path: <netdev+bounces-68255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59288846526
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 01:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B72A1C22CD8
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 00:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32BB5384;
	Fri,  2 Feb 2024 00:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3q4F7C1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B003B6FBB
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 00:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706834987; cv=none; b=MvMQ9alW8gaIb2GWG6pnAGVfQxbgNxSOGsWvoq5qxgrhs+fuZAMrLEdH0zuY9mMPnZCLCyutYpUOWYFOrUgpWMYG+hHSU7b8Drg33cpAsgEUeWBzI0hzbbuhpD3UasPmwqKq3mOhH5NBOw2xUUJjNbT55l1np01EHFWj1SLkZPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706834987; c=relaxed/simple;
	bh=2d6CeWRJMHuHFmGXNwOhn6j4nh+I+J8y/TBjfQZHSA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpDl4VVXqmd4ZSTxeSV1riHFekyfCWgQlM8uIxwiPAZxFfR2uHdMjO+EnaHWH/YtKacqvLx+/U0vMzuHuyg/lt4UDK4euOlshU0G5Lek2+UjubodoEx76bdi3d23fAjymQ5WkhW9qEGKWnDBD4CvSE8fKwTJpAQHIr2vcmEetHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3q4F7C1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AFD0C433C7;
	Fri,  2 Feb 2024 00:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706834987;
	bh=2d6CeWRJMHuHFmGXNwOhn6j4nh+I+J8y/TBjfQZHSA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u3q4F7C1AcuiHimrwv30KyJim3iI6NvenSCDGFYc+1iruVp1m6BVkH+DUa0buUKyq
	 FF00BhE51ncdtUIwI+3Lr1sxlCD3rT3ZUeFUMf0r+YP8D0YZT8lna6Zbi/Y6JvbMaS
	 qeVVXdKTcCdosf/e35Ph2R7w4nIjm129F8eIm0fyCraEQ1llf5qEdQuCDF++kjVbvW
	 mQ1UgQPUBTgU3iVrGjmDul4ZKSojPES/ZhV1JdmgagGb2IdAj6YwXi2YzetJGD5LhD
	 U3m2kv5VM8fP+ZXlEgY5SWbQPZ4vqO7uX9FtUByAGfsVT/rZrHvW01ea8FTAA2Fl+y
	 DlVKaQd76ASFA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	sdf@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/3] tools: ynl: auto-gen for all genetlink families
Date: Thu,  1 Feb 2024 16:49:26 -0800
Message-ID: <20240202004926.447803-4-kuba@kernel.org>
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

Instead of listing the genetlink families that we want to codegen
for, always codegen for everyone. We can add an opt-out later but
it seems like most families are not causing any issues, and yet
folks forget to add them to the Makefile.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/generated/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
index 3b9f738c61b8..7135028cb449 100644
--- a/tools/net/ynl/generated/Makefile
+++ b/tools/net/ynl/generated/Makefile
@@ -14,7 +14,10 @@ YNL_GEN_ARG_ethtool:=--user-header linux/ethtool_netlink.h \
 
 TOOL:=../ynl-gen-c.py
 
-GENS:=ethtool devlink dpll handshake fou mptcp_pm netdev nfsd ovs_datapath ovs_vport ovs_flow
+GENS_PATHS=$(shell grep -nrI --files-without-match \
+		'protocol: netlink' \
+		../../../../Documentation/netlink/specs/)
+GENS=$(patsubst ../../../../Documentation/netlink/specs/%.yaml,%,${GENS_PATHS})
 SRCS=$(patsubst %,%-user.c,${GENS})
 HDRS=$(patsubst %,%-user.h,${GENS})
 OBJS=$(patsubst %,%-user.o,${GENS})
-- 
2.43.0


