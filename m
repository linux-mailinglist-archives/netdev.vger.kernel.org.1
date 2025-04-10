Return-Path: <netdev+bounces-180968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A439AA834F3
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B54AA7B0599
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 00:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BCAC13B;
	Thu, 10 Apr 2025 00:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNTdRx26"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5000C4C8F;
	Thu, 10 Apr 2025 00:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744243888; cv=none; b=IJU2Lf9dezVbf3r7tMa75Y6zBnW6SOoXwO5TlfhxoIpsRDwXObmcyVZusxAzXNdSfOwaeYR6dfg7uJA43SVkZMKEkwda85qfi1V/s3qFtMxmyDaI7Y6es9pXusGjzfpm6aPVIo7xyxyCoSnlvYlDubt14rd2C7++MTfvX1b190Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744243888; c=relaxed/simple;
	bh=B43cXcCMVukr4s9eVIV7PT3CKGMOEh0Lt1ehXgVQI4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LoHcgvgIJj1pPCHhgey1eCRg6v3+VI7tKQl2qKcYd8qo66SbaH1Ygl1CK6NaBWt6PjIAnJH3hzQdWhUMLoSpNfoq7QGMqSGfd0GkYiCGUL3fVuYpXhkoXvaJWLc84oDoYQXQO9fA/XJbJb6SuaVE0LRuTPfRC1qpt6+9wNphMV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNTdRx26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3010C4CEEC;
	Thu, 10 Apr 2025 00:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744243888;
	bh=B43cXcCMVukr4s9eVIV7PT3CKGMOEh0Lt1ehXgVQI4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HNTdRx267Yd9ZPAf0CjbS+R7SJdL1fOT4gIcuk6GEmCkHBRqMDOWR3Vzv7M861j/l
	 vMhkmlDOshN3ov5ximz9waGylyPw28XP7Mxcdx5LrDBldGhBYiK+wyxq8Kk9QAW4Qo
	 SPfch3jPje4bXMW2V01QrZWbMltyEdQQVKKJzakOSE5LatLWVoilwbwx7Mtp6kWqNJ
	 7tWcNVCT7xXUiLNpFV5MpJu5LYQHV6+mKwaSGn7NCGznhA/HmQZoyhF7/Iv1HQd7YO
	 UeukjSFiUG5Lf+aUB56RfHzbfMXNh8TOcSrko4T2RhEtxp/Vi2mvDfHxCLiOj3+EY7
	 PkT6vokW/huQw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 02/10] tools headers: Update the socket headers with the kernel sources
Date: Wed,  9 Apr 2025 17:11:17 -0700
Message-ID: <20250410001125.391820-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
In-Reply-To: <20250410001125.391820-1-namhyung@kernel.org>
References: <20250410001125.391820-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes in:

  64e844505bc08cde include: uapi: protocol number and packet structs for AGGFRAG in ESP
  18912c520674ec4d tcp: devmem: don't write truncated dmabuf CMSGs to userspace

Addressing this perf tools build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h
    diff -u tools/perf/trace/beauty/include/linux/socket.h include/linux/socket.h

Please see tools/include/uapi/README for further details.

Cc: netdev@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/linux/in.h                  | 2 ++
 tools/perf/trace/beauty/include/linux/socket.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
index 5d32d53508d99f86..ced0fc3c3aa5343a 100644
--- a/tools/include/uapi/linux/in.h
+++ b/tools/include/uapi/linux/in.h
@@ -79,6 +79,8 @@ enum {
 #define IPPROTO_MPLS		IPPROTO_MPLS
   IPPROTO_ETHERNET = 143,	/* Ethernet-within-IPv6 Encapsulation	*/
 #define IPPROTO_ETHERNET	IPPROTO_ETHERNET
+  IPPROTO_AGGFRAG = 144,	/* AGGFRAG in ESP (RFC 9347)		*/
+#define IPPROTO_AGGFRAG		IPPROTO_AGGFRAG
   IPPROTO_RAW = 255,		/* Raw IP packets			*/
 #define IPPROTO_RAW		IPPROTO_RAW
   IPPROTO_SMC = 256,		/* Shared Memory Communications		*/
diff --git a/tools/perf/trace/beauty/include/linux/socket.h b/tools/perf/trace/beauty/include/linux/socket.h
index d18cc47e89bd0164..c3322eb3d6865d5e 100644
--- a/tools/perf/trace/beauty/include/linux/socket.h
+++ b/tools/perf/trace/beauty/include/linux/socket.h
@@ -392,6 +392,8 @@ struct ucred {
 
 extern int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_storage *kaddr);
 extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);
+extern int put_cmsg_notrunc(struct msghdr *msg, int level, int type, int len,
+			    void *data);
 
 struct timespec64;
 struct __kernel_timespec;
-- 
2.49.0.504.g3bcea36a83-goog


