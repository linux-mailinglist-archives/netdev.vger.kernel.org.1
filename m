Return-Path: <netdev+bounces-65653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1577283B430
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 22:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9959B22A22
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 21:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63C1135A5B;
	Wed, 24 Jan 2024 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uxo4VOma"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34BF135A58
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132494; cv=none; b=ZXLMjsOuPjoCJrJXYrH+r4lGLDC0g8qGAp+FgAnWsCSPciqZpE5eXOQSgSpFQLopDrJSz92oe2paghHPIFQ1xa025RapkFs1bqs7ju3dNbg32l97yh73ZJ7t25lI8LEjVIExjceJO9ik0sPPUPDMdgg/FoHAQhaaJiJ7uFM5FFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132494; c=relaxed/simple;
	bh=uGTPCJ4KadVLOvov+WSpwl51de34SMMbJdxNYoZBlyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WrQnuH3cmJ5cE2Qwg2GM3pzrHXfIi21RCn+O3OYyeWokQaQOnhuTlIgyFiCFxFPe8XXlnyVK99IS8uN4U51cm6CMm1TQlnzSdohIagkLQQT+H6aC55m7BslVvbtaPr27l1QmWT7XxUGerRbX7xJtXGW0O15sc0exNOKjuSSABR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uxo4VOma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20FBC433F1;
	Wed, 24 Jan 2024 21:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706132494;
	bh=uGTPCJ4KadVLOvov+WSpwl51de34SMMbJdxNYoZBlyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uxo4VOmaNHrwcjwrHdlIvS6rOzPpjImwIuDI0MP6FqC7mEMewtAJGpxYiLdxN8Lfi
	 7S6puZS0UeXvy+CVVwrIFlU50OdntcR/rVhO+9NQwMGxMatl1PdFHdJJGWr4ZnXgz4
	 UsycbnUSKNQ0E4yUiSCyVJ6vlTUv7dlTJStnKsXxwab7JYm7/6PlfcdnwHGxpM8Ue9
	 8kP3Cc3JxZNy4+Xyb4t/bO7/0dZxOtzn+4nH/i2UlmTLZXv0F/a9EX7XMi/2VbZVgw
	 2jGmp4nZqtjOj5d5oxWC+SmeSR/ao/9uzhHXLOdDy3sY5VnlsqoZADIt6S9BEbSXTe
	 wV+eDQNUa7PhQ==
From: David Ahern <dsahern@kernel.org>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next 2/3] selftest: Fix set of ping_group_range in fcnal-test
Date: Wed, 24 Jan 2024 14:41:16 -0700
Message-Id: <20240124214117.24687-3-dsahern@kernel.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240124214117.24687-1-dsahern@kernel.org>
References: <20240124214117.24687-1-dsahern@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ping_group_range sysctl has a compound value which does not go
through the various function layers in tact. Create a helper
function to bypass the layers and correctly set the value.

Signed-off-by: David Ahern <dsahern@kernel.org>
---
 tools/testing/selftests/net/fcnal-test.sh | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/selftests/net/fcnal-test.sh
index 3d69fac6bcc0..f590b0fb740e 100755
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@ -190,6 +190,15 @@ kill_procs()
 	sleep 1
 }
 
+set_ping_group()
+{
+	if [ "$VERBOSE" = "1" ]; then
+		echo "COMMAND: ${NSA_CMD} sysctl -q -w net.ipv4.ping_group_range='0 2147483647'"
+	fi
+
+	${NSA_CMD} sysctl -q -w net.ipv4.ping_group_range='0 2147483647'
+}
+
 do_run_cmd()
 {
 	local cmd="$*"
@@ -838,14 +847,14 @@ ipv4_ping()
 	set_sysctl net.ipv4.raw_l3mdev_accept=1 2>/dev/null
 	ipv4_ping_novrf
 	setup
-	set_sysctl net.ipv4.ping_group_range='0 2147483647' 2>/dev/null
+	set_ping_group
 	ipv4_ping_novrf
 
 	log_subsection "With VRF"
 	setup "yes"
 	ipv4_ping_vrf
 	setup "yes"
-	set_sysctl net.ipv4.ping_group_range='0 2147483647' 2>/dev/null
+	set_ping_group
 	ipv4_ping_vrf
 }
 
@@ -2056,12 +2065,12 @@ ipv4_addr_bind()
 
 	log_subsection "No VRF"
 	setup
-	set_sysctl net.ipv4.ping_group_range='0 2147483647' 2>/dev/null
+	set_ping_group
 	ipv4_addr_bind_novrf
 
 	log_subsection "With VRF"
 	setup "yes"
-	set_sysctl net.ipv4.ping_group_range='0 2147483647' 2>/dev/null
+	set_ping_group
 	ipv4_addr_bind_vrf
 }
 
@@ -2524,14 +2533,14 @@ ipv6_ping()
 	setup
 	ipv6_ping_novrf
 	setup
-	set_sysctl net.ipv4.ping_group_range='0 2147483647' 2>/dev/null
+	set_ping_group
 	ipv6_ping_novrf
 
 	log_subsection "With VRF"
 	setup "yes"
 	ipv6_ping_vrf
 	setup "yes"
-	set_sysctl net.ipv4.ping_group_range='0 2147483647' 2>/dev/null
+	set_ping_group
 	ipv6_ping_vrf
 }
 
-- 
2.39.3 (Apple Git-145)


