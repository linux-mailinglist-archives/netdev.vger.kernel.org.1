Return-Path: <netdev+bounces-72593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD03858BCA
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 01:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C54A281AD0
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 00:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACB81E4B1;
	Sat, 17 Feb 2024 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxZtIQ9/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CFB1DFF2
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708129070; cv=none; b=E2L9VKEiw8q/vD4EP5H9eeDDigYIaFNNiBDqSyc4Oi1UK5JMVa1ZKTZKKEq2fvVb6eGmzrpgTl1vQ9M4uhXryufoWP/rt1FWVNb/CPdSugE0gtaigxcbB5hVY7fKHwGkcRSXZEkUTqa/z0n7P4JDOBSbkeD3NhpziO2KgwdZBsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708129070; c=relaxed/simple;
	bh=BTtw9uM80+4mv3TNU1ObrLhkA/O2teSNcOXB/xkRzIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2qQBzjzBfOZWDNMHQ/eRQ9oupGyOIdYzC2ALOS9XYAd/ZUKjO8M1goYJ903KLso09IaYvSjjGY6YMDvd0vf5D1tMuhxtmSf8MDKXkfiRcCGhCWTJEeBsA3J6uz5gtx+SEyuVNQkWfZS6gsakeI5wFUTaBXOTdcqLzcsc52gLBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxZtIQ9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82436C43399;
	Sat, 17 Feb 2024 00:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708129069;
	bh=BTtw9uM80+4mv3TNU1ObrLhkA/O2teSNcOXB/xkRzIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CxZtIQ9/+yNJK0xQdYqIiqd5OoAwoNdaVZvkxUuj5Y1i7wP2CheQOFOrL2mDLf6Aj
	 16J/Sc1C0OcbtsiKhy+JXjKodwAnhnaIiiFCGIzUWrCZ5EL/ty8gnsVsC7ix2q/CfS
	 UjyMT1jpEHwPDQ2f/1oT3YNf88jeydUpYzFimJSRzpTRblXnr8RK9Rllk1it1JavWg
	 /KS3X/uCK/+lYkUmfNnKBXz7zpNEQeH4r7hkBGn7edVpcV4yqHgEQbQM4Ikd1R5Ps9
	 Iz159H2xesau/f/RyV/usM81JqG+9/3f3LPMOf9NORo8HpVCdAT1LLEupN49LTWBMY
	 uhFQ6NPVfCNmw==
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
Subject: [PATCH net 2/3] tools: ynl: make sure we always pass yarg to mnl_cb_run
Date: Fri, 16 Feb 2024 16:17:41 -0800
Message-ID: <20240217001742.2466993-3-kuba@kernel.org>
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

There is one common error handler in ynl - ynl_cb_error().
It expects priv to be a pointer to struct ynl_parse_arg AKA yarg.
To avoid potential crashes if we encounter a stray NLMSG_ERROR
always pass yarg as priv (or a struct which has it as the first
member).

ynl_cb_null() has a similar problem directly - it expects yarg
but priv passed by the caller is ys.

Found by code inspection.

Fixes: 86878f14d71a ("tools: ynl: user space helpers")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Further cleanup to enforce the types in net-next..
---
CC: nicolas.dichtel@6wind.com
CC: willemb@google.com
---
 tools/net/ynl/lib/ynl.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index c82a7f41b31c..9e41c8c0cc99 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -466,6 +466,8 @@ ynl_gemsg_start_dump(struct ynl_sock *ys, __u32 id, __u8 cmd, __u8 version)
 
 int ynl_recv_ack(struct ynl_sock *ys, int ret)
 {
+	struct ynl_parse_arg yarg = { .ys = ys, };
+
 	if (!ret) {
 		yerr(ys, YNL_ERROR_EXPECT_ACK,
 		     "Expecting an ACK but nothing received");
@@ -478,7 +480,7 @@ int ynl_recv_ack(struct ynl_sock *ys, int ret)
 		return ret;
 	}
 	return mnl_cb_run(ys->rx_buf, ret, ys->seq, ys->portid,
-			  ynl_cb_null, ys);
+			  ynl_cb_null, &yarg);
 }
 
 int ynl_cb_null(const struct nlmsghdr *nlh, void *data)
@@ -741,11 +743,14 @@ static int ynl_ntf_parse(struct ynl_sock *ys, const struct nlmsghdr *nlh)
 
 static int ynl_ntf_trampoline(const struct nlmsghdr *nlh, void *data)
 {
-	return ynl_ntf_parse((struct ynl_sock *)data, nlh);
+	struct ynl_parse_arg *yarg = data;
+
+	return ynl_ntf_parse(yarg->ys, nlh);
 }
 
 int ynl_ntf_check(struct ynl_sock *ys)
 {
+	struct ynl_parse_arg yarg = { .ys = ys, };
 	ssize_t len;
 	int err;
 
@@ -767,7 +772,7 @@ int ynl_ntf_check(struct ynl_sock *ys)
 			return len;
 
 		err = mnl_cb_run2(ys->rx_buf, len, ys->seq, ys->portid,
-				  ynl_ntf_trampoline, ys,
+				  ynl_ntf_trampoline, &yarg,
 				  ynl_cb_array, NLMSG_MIN_TYPE);
 		if (err < 0)
 			return err;
-- 
2.43.0


