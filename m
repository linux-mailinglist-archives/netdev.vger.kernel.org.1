Return-Path: <netdev+bounces-170583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F390A49123
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 06:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0B73B059E
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 05:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B208B1C3C06;
	Fri, 28 Feb 2025 05:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tyoOVQ84"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F9C1C1F05
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 05:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740721919; cv=none; b=iwP17ywo7HHeFqf91nZIlrhWpICvfIISM/jqjPNT2e+bOjcNb3dnZdtUxePBiXFMt5O7e+sZzFL1Wy4kdqWUUFIcVgiWNbgrMU/7IoEoAcl8uo8PoE7uyNVjecV2DzZde+bfF0pLLks4e3L97GEYYHNpSNGVgK7bePZ4h3P/Sd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740721919; c=relaxed/simple;
	bh=jQ0mvOO2ZFMK8vaOnq+3OiJhcPOVu/rV64BQ6cnKjE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sv4McPpmePONEjK6X+HooTUQK2ElUCGWiFtJWBVR8LzEw/2dlTrWwGQom+vLDrFlGku/7GsQ5+p8r9NaSbOUiAWTak1jPUq14oM7V00Rt0KnGLG65E0nt62MLgN7APlCzOIpL8RAaFOXY6Gt9kn3CuTfnQHwCsk5UJ/EfdOE604=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tyoOVQ84; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740721916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HCwtNd+g+fkSkGCZp+PS2GqWiSUDlgAUtiYKlrhsjEw=;
	b=tyoOVQ84xmzLpEUfw2abe3X+7kdpIsp3T9JLGZOSUnimwXvoQ3mackWJSvGRlWZ5As3HK9
	sazjX1tG81VYGwFUMv7IGMMwe2U5+YYqb18SkPCCkypmbjmh167dNp2Na0IQsbUOmNatDp
	vl39sV7FD/xO2H+GWxLWv9ARUgSybGQ=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: xiyou.wangcong@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	martin.lau@linux.dev
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	mhal@rbox.co,
	jiayuan.chen@linux.dev,
	sgarzare@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mrpre@163.com,
	cong.wang@bytedance.com
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: Add socketpair to create_pair to support unix socket
Date: Fri, 28 Feb 2025 13:51:05 +0800
Message-ID: <20250228055106.58071-3-jiayuan.chen@linux.dev>
In-Reply-To: <20250228055106.58071-1-jiayuan.chen@linux.dev>
References: <20250228055106.58071-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Current wrapper function create_pair() is used to create a pair of
connected links and returns two fds, but it does not support unix sockets.

Here we introduce socketpair() into create_pair(), which supports creating
a pair of unix sockets, since the semantics of the two are the same.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/socket_helpers.h       | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
index 1bdfb79ef009..a805143dd84f 100644
--- a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
@@ -313,11 +313,22 @@ static inline int recv_timeout(int fd, void *buf, size_t len, int flags,
 
 static inline int create_pair(int family, int sotype, int *p0, int *p1)
 {
-	__close_fd int s, c = -1, p = -1;
+	__close_fd int s = -1, c = -1, p = -1;
 	struct sockaddr_storage addr;
 	socklen_t len = sizeof(addr);
 	int err;
 
+	if (family == AF_UNIX) {
+		int fds[2];
+
+		err = socketpair(family, sotype, 0, fds);
+		if (!err) {
+			*p0 = fds[0];
+			*p1 = fds[1];
+		}
+		return err;
+	}
+
 	s = socket_loopback(family, sotype);
 	if (s < 0)
 		return s;
-- 
2.47.1


