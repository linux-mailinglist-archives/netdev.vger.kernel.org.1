Return-Path: <netdev+bounces-75100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA688682DD
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 22:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5971C26796
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 21:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6F5131751;
	Mon, 26 Feb 2024 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6kD+AaM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4BC131739
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982429; cv=none; b=cks1isFYcL/RfzIbDKkEQMGwZpqC8Wj5CAuzplMrnbz8sfhkx50VLwOSc32g1ZAHXhqyE1xf0FAPxwiUCFZe0G5SPl835eANrOL63cw7p3SnR1MnvzFyIJz5P8KmIJwX1A3n5c4n7wOBKQDlB3T3m6mIfEnj6Gsi4nRP9dXx+Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982429; c=relaxed/simple;
	bh=SD3Xh34qf/Tfrr2hLX3IGnlSMM4aUZLhnM7HteC/Xl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nV3YQjEdR6JutMJi4n2Jpu/1C0FAzdzT2T27Oa5SsZwxqsZMnqBGVooHR4knPfgsrSHCX/Uk0/JLbikM8dCuVghdpRSIGdZoCfC9ZHiV2IyOY1Co43HcasLfy1VD/0KAjLd383Pc7Mj9hqcSTMpE30SQAnR+pb5L8DfjRAiyvZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6kD+AaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794D8C43399;
	Mon, 26 Feb 2024 21:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708982428;
	bh=SD3Xh34qf/Tfrr2hLX3IGnlSMM4aUZLhnM7HteC/Xl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c6kD+AaMBcLN2zqoxDafM7g7ZOsgBbAQRC8arXMHY/Ovx15kCYWEZf8eoEFMVkHT9
	 0kyx7pYoSSUnwVPBHaKjAaUuSo96TPw6Hb7ZHF4U2pdpixUnzqOmOoVtAp9K+ngiE4
	 frZgrChDxMqOPu4SCaFP2Y+UIIr9J/BqscbFZbFLTkZtgk6vc0vooZPb19WrDJU77u
	 QK/m3BZz/VhsWCUpGjRPP/Y6/U/xfSUVnxFd4dieeXz4JQVtAV2Bo97LWM31U9fFRI
	 PAPxBUIrx56NrFW48NPoOS+S8C2uR2q4hGH8CCIVDIWcaR6Jx1d+TgM0wwc7whCIfB
	 21wy2u9oCkbHA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	nicolas.dichtel@6wind.com,
	donald.hunter@gmail.com,
	jiri@resnulli.us,
	sdf@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 01/15] tools: ynl: give up on libmnl for auto-ints
Date: Mon, 26 Feb 2024 13:20:07 -0800
Message-ID: <20240226212021.1247379-2-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240226212021.1247379-1-kuba@kernel.org>
References: <20240226212021.1247379-1-kuba@kernel.org>
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

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
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


