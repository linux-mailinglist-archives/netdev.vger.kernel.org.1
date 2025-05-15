Return-Path: <netdev+bounces-190886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D21EAB92C7
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 01:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33673BCB04
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 23:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0672296716;
	Thu, 15 May 2025 23:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpH2jHFH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B862A296162
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 23:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747351031; cv=none; b=lFqv/A9D7Ln7IWH6WPG9xhuY4kb+THRiHN9WupyNixfYuL3Bg4h9lRynnTaoSYVzMCJ3+0wdxmJgX+KFyYiz7BVgcHm1jjeHosIZTf+5clp8KHPb9QuIeoyPkd5I+MZhPa1Qa37hlGT5PsmPqi7zgNnd0k6eR6mFdC9EOiiCE9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747351031; c=relaxed/simple;
	bh=5Dl71sxdLyIdg3efDNhYkfJ8M4IsB0cH9u76Rj8nngI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uh3S1FCxEY1ajHc0Il80QNqr/UGVk+3OVWoML8seBiV8tilmCp61aK7cvqqhgfACEhCd2G+EABI5jkvojAaGYIWYl4AmtBxMyN9RliVS5gaQtogB0GikcCCvNSgxkWQ2LaBQhzFGPIbTNVRFU8OZIzOJgfnOC7OEvxqCFrkX8+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpH2jHFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DE9C4CEE7;
	Thu, 15 May 2025 23:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747351031;
	bh=5Dl71sxdLyIdg3efDNhYkfJ8M4IsB0cH9u76Rj8nngI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fpH2jHFHe+bZQ79uLouvVUx66tjGZTLP4Qt/Owp9jYXmJ+dsHtLIUKYPgIq5laQ2x
	 TgM3FO44dAl6Pu/Z16sF/OS1cicO6SQtAYQMDZEzhTFHxL47p1yGca5uDZjbB0MUfp
	 aR9VFMBp29/cKj+kKgb4DrYp6zn9U2QO49wGlqCf3tG0iekjxkI6mK2GFnr5+UZ2GW
	 fPZQL/+Bi20H3nAkPWO8f1YzZuFn2byOEN3TjVmoKO5i1vC/bW4f4NxP5xw4vOSZWR
	 FIBJAR0q7n8EU7GlrirGH/0qO9RiXyQLLiGeLsk30EX79xN/hiubu7W4PgojflDD83
	 PBzgJPT/pk1MQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	daniel@iogearbox.net,
	nicolas.dichtel@6wind.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 8/9] tools: ynl: enable codegen for all rt- families
Date: Thu, 15 May 2025 16:16:49 -0700
Message-ID: <20250515231650.1325372-9-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515231650.1325372-1-kuba@kernel.org>
References: <20250515231650.1325372-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch from including Classic netlink families one by one to excluding.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/Makefile.deps      | 4 ++++
 tools/net/ynl/generated/Makefile | 7 +++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index a5e6093903fb..e5a5cb1b2cff 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -33,5 +33,9 @@ CFLAGS_ovs_flow:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_ovs_vport:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_rt-addr:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
 	$(call get_hdr_inc,__LINUX_IF_ADDR_H,if_addr.h)
+CFLAGS_rt-link:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
+	$(call get_hdr_inc,_LINUX_IF_LINK_H,if_link.h)
+CFLAGS_rt-neigh:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
 CFLAGS_rt-route:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
+CFLAGS_rt-rule:=$(call get_hdr_inc,__LINUX_FIB_RULES_H,fib_rules.h)
 CFLAGS_tcp_metrics:=$(call get_hdr_inc,_LINUX_TCP_METRICS_H,tcp_metrics.h)
diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
index 6603ad8d4ce1..9208feed28c1 100644
--- a/tools/net/ynl/generated/Makefile
+++ b/tools/net/ynl/generated/Makefile
@@ -22,10 +22,9 @@ TOOL:=../pyynl/ynl_gen_c.py
 TOOL_RST:=../pyynl/ynl_gen_rst.py
 
 SPECS_DIR:=../../../../Documentation/netlink/specs
-GENS_PATHS=$(shell grep -nrI --files-without-match \
-		'protocol: netlink' \
-		$(SPECS_DIR))
-GENS=$(patsubst $(SPECS_DIR)/%.yaml,%,${GENS_PATHS}) rt-addr rt-route
+SPECS_PATHS=$(wildcard $(SPECS_DIR)/*.yaml)
+GENS_UNSUP=conntrack nftables tc
+GENS=$(filter-out ${GENS_UNSUP},$(patsubst $(SPECS_DIR)/%.yaml,%,${SPECS_PATHS}))
 SRCS=$(patsubst %,%-user.c,${GENS})
 HDRS=$(patsubst %,%-user.h,${GENS})
 OBJS=$(patsubst %,%-user.o,${GENS})
-- 
2.49.0


