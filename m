Return-Path: <netdev+bounces-74194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE7286072C
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 00:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 836B5283458
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 23:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AF913BAF8;
	Thu, 22 Feb 2024 23:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVnnnIyW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4373E13BAF0
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646186; cv=none; b=mOVJozfLQ21OcjkpuRl7KwgxFQSWXhe//pNFYXksBoRCf9Z2NW94V2bPmSoxGzrFKm7rlJHVc72+OhxRW5bq8GASltoUXzT3lXSzOe85zSOsQtEy2csiAqCXnzGK2cSBzcUa3Ss4lz/tLncQGUfqwPeqSI9/f+iSPf5BGJPtcYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646186; c=relaxed/simple;
	bh=uR7+64NP9C83YXVNPnR/RoeLOX/nd5XOHSbFdARgCgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=siTcz0wnLUl+vaAz6cAdqphElV0ZZPgzLL7XwU300dJSK9C1Ox4PU+pPFfaLxtv4F04DwIHWZETSnoYeROiy7jvqZDTLHA7yEjzsJtFK+ueNF+eTeMLXIG/hQuuKeSAhgCiTeDTrVVoB4BFbqvwbWUdHUHUV0N4BsAuuZtdSsB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVnnnIyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B075C433C7;
	Thu, 22 Feb 2024 23:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708646185;
	bh=uR7+64NP9C83YXVNPnR/RoeLOX/nd5XOHSbFdARgCgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lVnnnIyWs7EZ51dZ5D8iVUGpfH0AZKl5sMn2wTm12oZFuVIdgQbpkBdMoWYWV85ji
	 5sJLp78a6wx081CsWR7JQ30ErISwSSFODz8u1a/LlzKVchon3YJvaxUf5htWqRdVzz
	 ZJSmiTtAvB5oYyPXArQUl+cw5A3IALNE1/t4p7IFldsUzlOWf4k0YDiK/Uce1WRuaS
	 mjmQBRHUdR0gk3auolKqjNjuxUnoKaMrK8E9RiDy+HwojquSSTo0opsFEehcSr45xY
	 8j2vvwVajmVo4MD+OBj+dr+Zy4dSSGASIUcSbhgrGf+x6sPCtET3SJEFvUcY/LhVQk
	 SpzGRRavKxDGg==
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
Subject: [PATCH net-next 01/15] tools: ynl: give up on libmnl for auto-ints
Date: Thu, 22 Feb 2024 15:56:00 -0800
Message-ID: <20240222235614.180876-2-kuba@kernel.org>
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

The temporary auto-int helpers are not really correct.
We can't treat signed and unsigned ints the same when
determining whether we need full 8B. I realized this
before sending the patch to add support in libmnl.
Unfortunately, that patch has not been merged,
so time to fix our local helpers. Use the mnl* name
for now, subsequent patches will address that.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h | 45 ++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index 7491da8e7555..eaa0d432366c 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -125,20 +125,47 @@ int ynl_exec_dump(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
 void ynl_error_unknown_notification(struct ynl_sock *ys, __u8 cmd);
 int ynl_error_parse(struct ynl_parse_arg *yarg, const char *msg);
 
-#ifndef MNL_HAS_AUTO_SCALARS
-static inline uint64_t mnl_attr_get_uint(const struct nlattr *attr)
+/* Attribute helpers */
+
+static inline __u64 mnl_attr_get_uint(const struct nlattr *attr)
 {
-	if (mnl_attr_get_payload_len(attr) == 4)
+	switch (mnl_attr_get_payload_len(attr)) {
+	case 4:
 		return mnl_attr_get_u32(attr);
-	return mnl_attr_get_u64(attr);
+	case 8:
+		return mnl_attr_get_u64(attr);
+	default:
+		return 0;
+	}
+}
+
+static inline __s64 mnl_attr_get_sint(const struct nlattr *attr)
+{
+	switch (mnl_attr_get_payload_len(attr)) {
+	case 4:
+		return mnl_attr_get_u32(attr);
+	case 8:
+		return mnl_attr_get_u64(attr);
+	default:
+		return 0;
+	}
 }
 
 static inline void
-mnl_attr_put_uint(struct nlmsghdr *nlh, uint16_t type, uint64_t data)
+mnl_attr_put_uint(struct nlmsghdr *nlh, __u16 type, __u64 data)
 {
-	if ((uint32_t)data == (uint64_t)data)
-		return mnl_attr_put_u32(nlh, type, data);
-	return mnl_attr_put_u64(nlh, type, data);
+	if ((__u32)data == (__u64)data)
+		mnl_attr_put_u32(nlh, type, data);
+	else
+		mnl_attr_put_u64(nlh, type, data);
+}
+
+static inline void
+mnl_attr_put_sint(struct nlmsghdr *nlh, __u16 type, __s64 data)
+{
+	if ((__s32)data == (__s64)data)
+		mnl_attr_put_u32(nlh, type, data);
+	else
+		mnl_attr_put_u64(nlh, type, data);
 }
 #endif
-#endif
-- 
2.43.2


