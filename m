Return-Path: <netdev+bounces-75988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF1986BDD4
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 02:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13DF6B217DA
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 01:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51AB41C84;
	Thu, 29 Feb 2024 00:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZFWBXCZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B72741A80;
	Thu, 29 Feb 2024 00:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168374; cv=none; b=V3zGpOvd/jKmNYBiV0BPvrRYCaPxMkSEEQWhzq+zKUB57uqRGTTYptqXjI5+lnaMgQkumIOQevq5wOtZWPPJ8vGEupu6nT0xBDwUsSz/nCOFXCBC1/Mi4sc/+7e285Yp/HKbsqr0sfdYAu6njb83AFZirCujtaKJQjwy4B9qqy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168374; c=relaxed/simple;
	bh=dZrum7wy2AkWih698zz9wzfDSh+S33eFRkVxQiIUlOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBwTCeY3PnkyaStM/WGcn3Urv2YLvgOZz70e4WyKRHS9FtGvtFzxCRFQYspCigVoT8URlEhrFDOGLGB9/wOgFm7rf2OYhKI8s5TJvFluOVNXga/McJRGtyJicujPWXvI85ZuMMsE88yr81tAXXilY8UJXxxQy0j7ZxeF9uw3wII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZFWBXCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E88CC433C7;
	Thu, 29 Feb 2024 00:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709168374;
	bh=dZrum7wy2AkWih698zz9wzfDSh+S33eFRkVxQiIUlOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QZFWBXCZE/9dSdiE26uw5BHMfgRw2W7yRhsnaN0Py6t42X4ZOy05sPOUu0faQMOjW
	 +gZxzBcpcMWbhtwjbNWCxejtB1Q6hKjSYSOELfRb+qPm2ExvpzOZ5cSKMq4N8Q3lqu
	 mI8G2/YzYYwGmHM8m3fKcud4T7cHWOxHy3z3t7cm6kPpk601p3FYI2KndnhKifj0Fy
	 qv8tshXhaAPkvemEfcHkolU1vrAfqP9fXlQS6i5zNz/uGNMhHLjPlxOqk9tQK3JqsR
	 idPi6SX+tKQAGLtNCRUU/wrpF6us2H0UMLt+V1BQMO1nz9ZUKU1gZiLJgOliK6zsgN
	 esV+XySVF4RtA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	mic@digikod.net,
	linux-security-module@vger.kernel.org,
	keescook@chromium.org,
	jakub@cloudflare.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v4 12/12] selftests: ip_local_port_range: use XFAIL instead of SKIP
Date: Wed, 28 Feb 2024 16:59:19 -0800
Message-ID: <20240229005920.2407409-13-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240229005920.2407409-1-kuba@kernel.org>
References: <20240229005920.2407409-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCTP does not support IP_LOCAL_PORT_RANGE and we know it,
so use XFAIL instead of SKIP.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/ip_local_port_range.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/ip_local_port_range.c b/tools/testing/selftests/net/ip_local_port_range.c
index 6ebd58869a63..193b82745fd8 100644
--- a/tools/testing/selftests/net/ip_local_port_range.c
+++ b/tools/testing/selftests/net/ip_local_port_range.c
@@ -365,9 +365,6 @@ TEST_F(ip_local_port_range, late_bind)
 	__u32 range;
 	__u16 port;
 
-	if (variant->so_protocol == IPPROTO_SCTP)
-		SKIP(return, "SCTP doesn't support IP_BIND_ADDRESS_NO_PORT");
-
 	fd = socket(variant->so_domain, variant->so_type, 0);
 	ASSERT_GE(fd, 0) TH_LOG("socket failed");
 
@@ -414,6 +411,9 @@ TEST_F(ip_local_port_range, late_bind)
 	ASSERT_TRUE(!err) TH_LOG("close failed");
 }
 
+XFAIL_ADD(ip_local_port_range, ip4_stcp, late_bind);
+XFAIL_ADD(ip_local_port_range, ip6_stcp, late_bind);
+
 TEST_F(ip_local_port_range, get_port_range)
 {
 	__u16 lo, hi;
-- 
2.43.2


