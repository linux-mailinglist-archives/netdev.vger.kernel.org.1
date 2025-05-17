Return-Path: <netdev+bounces-191247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF69ABA754
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 02:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636439E314C
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612EC4317D;
	Sat, 17 May 2025 00:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXOrRTlS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BD03594F
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 00:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440816; cv=none; b=oJmtq2Rr7hW6YJ97WtyhoT29Q7g3khK57gYN2VaV10+yz9aXzACocoVa3oNm5C5oFqQZvcTag/gGYfbBY2vyv6Sc6Z0nXZe4RIkBDYd/vkMyvRMm59Y16Ubku1I15JTO9KFDd4wtYQDWVpig4KpiOwnqp4Gzrug61szvrTix+Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440816; c=relaxed/simple;
	bh=CR21WpGc6ifIlipCQP2q/H7W+YC7vTdwoceHVQ7hyN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acOnKwvc7eidd6pR8sE3QgJEJSCsfJtMBEqDf64rAPeczF5qL7N/xWIanYW7C4dmUHPMI/GR3Gu35LzzBe/9H02Wy/wBPcC+VxYzyY2PYbWZ6l3FMxkR3Ni3Qzvxa/JqXBEb072v3XBmRVLcC4drMk7kgKzfnvs4phPkG2HyWNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXOrRTlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7011C4CEE9;
	Sat, 17 May 2025 00:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747440816;
	bh=CR21WpGc6ifIlipCQP2q/H7W+YC7vTdwoceHVQ7hyN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gXOrRTlSfmsww8Bwh0hQwX7O+2YJh5HatAV6yQoNhaeOBTXyu8PaEVJzO+63oSmyk
	 j7vG6hkWfJkUYdSjAxZjEE+Ky+AFqDZjZDNT6cfER8ZJE+vrFLdgttz9WV+mJhmU1a
	 gjOaLCjZRVutI3d4a+GdStAtIaMizMxDCjvU0YiG+1waZd8sHDf5jFGdwo3/Q0WguF
	 DN2hlNMi98dFa7DtkcPTqhXx8U2wVxfZndySNKI1yr94W6myePr3VyURH/4F82kXTG
	 Ob4HUVBMoqC5kOxQRDfHWZI9WdqFVWgqtTH/WBTDuFCA5u3+tqVcd4DLuM/KOVMHuK
	 J/bKUp85dTVdg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	jstancek@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 09/11] tools: ynl: enable codegen for TC
Date: Fri, 16 May 2025 17:13:16 -0700
Message-ID: <20250517001318.285800-10-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250517001318.285800-1-kuba@kernel.org>
References: <20250517001318.285800-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are ready to support most of TC. Enable C code gen.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/Makefile.deps      | 2 ++
 tools/net/ynl/generated/Makefile | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index e5a5cb1b2cff..4e5c4dff9188 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -38,4 +38,6 @@ CFLAGS_rt-link:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
 CFLAGS_rt-neigh:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
 CFLAGS_rt-route:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
 CFLAGS_rt-rule:=$(call get_hdr_inc,__LINUX_FIB_RULES_H,fib_rules.h)
+CFLAGS_tc:=$(call get_hdr_inc,__LINUX_PKT_SCHED_H,pkt_sched.h) \
+	$(call get_hdr_inc,__LINUX_PKT_CLS_H,pkt_cls.h)
 CFLAGS_tcp_metrics:=$(call get_hdr_inc,_LINUX_TCP_METRICS_H,tcp_metrics.h)
diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
index 9208feed28c1..86e1e4a959a7 100644
--- a/tools/net/ynl/generated/Makefile
+++ b/tools/net/ynl/generated/Makefile
@@ -23,7 +23,7 @@ TOOL_RST:=../pyynl/ynl_gen_rst.py
 
 SPECS_DIR:=../../../../Documentation/netlink/specs
 SPECS_PATHS=$(wildcard $(SPECS_DIR)/*.yaml)
-GENS_UNSUP=conntrack nftables tc
+GENS_UNSUP=conntrack nftables
 GENS=$(filter-out ${GENS_UNSUP},$(patsubst $(SPECS_DIR)/%.yaml,%,${SPECS_PATHS}))
 SRCS=$(patsubst %,%-user.c,${GENS})
 HDRS=$(patsubst %,%-user.h,${GENS})
-- 
2.49.0


