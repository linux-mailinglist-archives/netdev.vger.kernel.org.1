Return-Path: <netdev+bounces-70485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB7684F35D
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 11:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0269E1F22A3F
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 10:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAB469949;
	Fri,  9 Feb 2024 10:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIvcvpwf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9390F6994D
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474306; cv=none; b=K1oKfomJQ71tVFypesHjeCgxjzOGbHSq7GVlDIddBI/pL7w83KaBkqZaClIsCxMaQF5zAaW1aZdunEUK0yOiqsR2VVcrX9Mxw5p7o4i+6WM3yxxYTAMwCaTUlNOyCIca1JiVXmUUHuSM70ssJg2URQ6ydXq7n/lqT2dKQ5dS+g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474306; c=relaxed/simple;
	bh=B5/BTwBMB0HuMS8m/9S9EeEIASkWudV/EHDng9uf0pA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JOblISqJgKm0BC/QuvagNk0a643lJEUN2dVT9G3/43u7OJR8IM4wzPkS1QpNDVepIFDG/mTdbI9sZH/HQ1WJVVhOLOA8n97ZgT+HEOU8P34CuE6Fkinqe/3T592a1iFDMAqCNaHUPK5U15CWltm3TYHAnbnsF3HpsuPCKDFFyuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SIvcvpwf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707474303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MEsuYP1VU1bP5NDuOHlb7q81k+CG3K51b7MgvcCauaw=;
	b=SIvcvpwfnRqN/PzDX2zvKd+0oGfoyPbIuXK0C+ikQSRbNUBbYUowwH4URE9sY+XfrGqZ/k
	LKp1NDGuECJiwRHbotxEqBLcVSjTHILv6jEVl7ZFi5rimzVp+et5p7pezLDBfAsQlKU+Zq
	4woXxft+E/gG1pgpumLclhKasxSNadQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-ttrpd-0qP1GPH94luv7dMA-1; Fri, 09 Feb 2024 05:24:59 -0500
X-MC-Unique: ttrpd-0qP1GPH94luv7dMA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 576B085A58B;
	Fri,  9 Feb 2024 10:24:59 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.194.214])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D0647112132A;
	Fri,  9 Feb 2024 10:24:57 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	sgallagh@redhat.com
Subject: [PATCH] iproute2: fix build failure on ppc64le
Date: Fri,  9 Feb 2024 11:24:47 +0100
Message-ID: <d13ef7c00b60a50a5e8ddbb7ff138399689d3483.1707474099.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

ppc64le build fails with error on ifstat.c when
-Wincompatible-pointer-types is enabled:

ifstat.c: In function ‘dump_raw_db’:
ifstat.c:323:44: error: initialization of ‘long long unsigned int *’ from incompatible pointer type ‘__u64 *’ {aka ‘long unsigned int *’} [-Wincompatible-pointer-types]
  323 |                 unsigned long long *vals = n->val;

Several other warnings are produced when -Wformat= is set, for example:

ss.c:3244:34: warning: format ‘%llu’ expects argument of type ‘long long unsigned int’, but argument 2 has type ‘__u64’ {aka ‘long unsigned int’} [-Wformat=]
 3244 |                 out(" rcv_nxt:%llu", s->mptcpi_rcv_nxt);
      |                               ~~~^   ~~~~~~~~~~~~~~~~~
      |                                  |    |
      |                                  |    __u64 {aka long unsigned int}
      |                                  long long unsigned int
      |                               %lu

This happens because __u64 is defined as long unsigned on ppc64le.  As
pointed out by Florian Weimar, we should use -D__SANE_USERSPACE_TYPES__
if we really want to use long long unsigned in iproute2.

This fix the build failure and all the warnings without any change on
the code itself.

Suggested-by: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 8024d45e..3b9daede 100644
--- a/Makefile
+++ b/Makefile
@@ -60,7 +60,7 @@ CC := gcc
 HOSTCC ?= $(CC)
 DEFINES += -D_GNU_SOURCE
 # Turn on transparent support for LFS
-DEFINES += -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
+DEFINES += -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D__SANE_USERSPACE_TYPES__
 CCOPTS = -O2 -pipe
 WFLAGS := -Wall -Wstrict-prototypes  -Wmissing-prototypes
 WFLAGS += -Wmissing-declarations -Wold-style-definition -Wformat=2
-- 
2.43.0


