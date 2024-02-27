Return-Path: <netdev+bounces-75487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAB586A27A
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 23:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB30284699
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 22:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F74955761;
	Tue, 27 Feb 2024 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkFCoiFv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1903154664
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 22:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073045; cv=none; b=bfC068Any9GVfQNZsVuSDEr43rTuAVwjrVWAwuYvSBKsutIGMHlv3HjFJhnJqwi9Pa1MOjnDvGlLFo6VUJRWUhAu3FXGXEYEcl868LTm6TG86NmSY9Hl07OHwGGLyWD6O+rQQZsXVcZM6UVeA63rTt3Ms49Ca7b2zvfPkedHMhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073045; c=relaxed/simple;
	bh=lazClDQGTeB/VaPI+iAVUe7M73RDyTp4YxBKGzg1GwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DS/sCmHhGvGaEoPWVHa6ICaXUqzL0D0UxgCXztBzOynEaCzhlaLZ84Cwd3N+SbQhSbL9RFQJABEb/EnPQRzcDpRTGDwQX/BR29fVijkO92Nxc0QrXiEqHpE+iWp/jIsZbDavIobK9s2aYGsc/Q6yvwlvTEsOEer2pAPfHorpb2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkFCoiFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC27C43390;
	Tue, 27 Feb 2024 22:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709073044;
	bh=lazClDQGTeB/VaPI+iAVUe7M73RDyTp4YxBKGzg1GwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nkFCoiFviH1zlLj7Hx8cbCELtSPvJviTKsPwwkH40dT7Uy/Am/au0XZegYbR90qmS
	 HN/ecHrvp0G5p/0up71pNcEp+ygz9pfZDuFGsrVgV5TrGrSEqT2pMzuAz7YB1/BWgd
	 Pecfb2P9KL0yrmnaRiSBp+InI5g00dgdPql4VnS555X8/CRbJNpOHe9+9jTx9W/f7M
	 W6nsDByJijsG0N1uuWH8ZzUcKUGxNhC+BFzNudAwTF03I6YkzTwOH3aZOZYX5S2RWo
	 8OetYAGGp2vm/DlZ3sdr/ONicIMZuo2k2M/IOpvPxmXZ4m1GWL3Yk9yLIg0c7lIaW+
	 h0QNp+kW1UoGQ==
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
Subject: [PATCH net-next v3 01/15] tools: ynl: give up on libmnl for auto-ints
Date: Tue, 27 Feb 2024 14:30:18 -0800
Message-ID: <20240227223032.1835527-2-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227223032.1835527-1-kuba@kernel.org>
References: <20240227223032.1835527-1-kuba@kernel.org>
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

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
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


