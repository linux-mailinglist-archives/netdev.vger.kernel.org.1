Return-Path: <netdev+bounces-191963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADE7ABE098
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE8A4C4762
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BCD27D782;
	Tue, 20 May 2025 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Myu942yl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7E127CCE4
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757969; cv=none; b=FjohIhsw+pTFFcDr5v5i0J+r4yLq14k6gyyPgJuX6j6zscNCsI5/EuCyukQiLS2issMnHhijh5zanO/IBionQ7xoz8eJCCUJw2McK2bnA2AVgYZ9Acyex9TAUxRjtGRW6JWbfnpsTKkVa9UqXNG0ochE6uw+0CJlOeIlfnMu5Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757969; c=relaxed/simple;
	bh=hosW0XWyFytDFe89coz1ARVkPvZ7saE5ErjaxLfay+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5rxxvDtSmGutPg7Q8os/IzX3Dp8Knqw+Vpni9hhygGtvgbu53UU+2Clqr+BvKsHWpN2n2f4zfehRSsw5FXpMNkn4qIo0BmEQzjvvDePuitghjqa+Z8wT1zBeVkI3kcjveG3M4q7JrMCPC+dVJmyg6cX74bmuGbpb758ZTwpp1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Myu942yl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15600C4CEEB;
	Tue, 20 May 2025 16:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747757969;
	bh=hosW0XWyFytDFe89coz1ARVkPvZ7saE5ErjaxLfay+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Myu942yljnLk48KKiQ5EZN817v754cQUZZWKyoQjOePDwuY/trcGVgLzQsHA4wrDG
	 WrQrQKTjFsu0Z5Ir23YnWrBl4by7pGgPO9+vudmv12NLUAmVPWDad5GHP/9zq+bzR/
	 KahjfJ4HA3AvfWCYmaB3WkMVSB7g1Lh8dT4IZjWnoTxW0T5A3tFdZ5PKrC2U1Dmp2L
	 04FnD/q7JYMLc95EhEZ5qew1NGTk990peZyu3vEnOXFEe7c1Zi9ON9NEU6ztWALZJ/
	 16fhlwPekYPqyy81D6iJVFgmN3HLekupeLAtRlQVnqYqu0inDXRZK8FDDapSSe+nBN
	 46i5pFM7aQz0A==
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
	kory.maincent@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 10/12] tools: ynl: enable codegen for TC
Date: Tue, 20 May 2025 09:19:14 -0700
Message-ID: <20250520161916.413298-11-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520161916.413298-1-kuba@kernel.org>
References: <20250520161916.413298-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are ready to support most of TC. Enable C code gen.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - add more headers to the local includes to build on Ubuntu 22.04
v1: https://lore.kernel.org/20250517001318.285800-10-kuba@kernel.org
---
 tools/net/ynl/Makefile.deps      | 7 +++++++
 tools/net/ynl/generated/Makefile | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 8c378356fc87..90686e241157 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -39,4 +39,11 @@ CFLAGS_rt-neigh:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
 	$(call get_hdr_inc,__LINUX_NEIGHBOUR_H,neighbour.h)
 CFLAGS_rt-route:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
 CFLAGS_rt-rule:=$(call get_hdr_inc,__LINUX_FIB_RULES_H,fib_rules.h)
+CFLAGS_tc:= $(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
+	$(call get_hdr_inc,__LINUX_PKT_SCHED_H,pkt_sched.h) \
+	$(call get_hdr_inc,__LINUX_PKT_CLS_H,pkt_cls.h) \
+	$(call get_hdr_inc,_TC_CT_H,tc_act/tc_ct.h) \
+	$(call get_hdr_inc,_TC_MIRRED_H,tc_act/tc_mirred.h) \
+	$(call get_hdr_inc,_TC_SKBEDIT_H,tc_act/tc_skbedit.h) \
+	$(call get_hdr_inc,_TC_TUNNEL_KEY_H,tc_act/tc_tunnel_key.h)
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


