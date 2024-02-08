Return-Path: <netdev+bounces-70345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE72684E732
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 18:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A886E28CCBA
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 17:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95B884FBD;
	Thu,  8 Feb 2024 17:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjvD+otd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67997CF15
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415086; cv=none; b=Ys6KQXpplkWJzq4zFFX6Y/I+t2jjC7SSkAqorxWGzg078w5T8klXjEe9w5jwmeQDL0/tfaW1abDF/z2AbInpUj+iiMZgnNfspMdwAWlMC2saGfn0EgQgwp3axTjAKGdk6O5lYJzdqzvCQ8nNAN270pbgJtXFw/NUzSynFDCAI+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415086; c=relaxed/simple;
	bh=Z7VO71pXoZegGiktT4itHsuvL45306hW2cI2M2BBd3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fD9KM7skMq1ze1aYjhQDbN5UhK6qncW/F1FyBPiOVdp6qrLd2h/Axu63/Qh8La2F9aJRQ1U1rbsEIGEw81cnbkDMkt3FyxNIp1q3i12+vdMbuwvkzNrEUpPznV2cyS1JxIgguazJpYBd+3v3yDbpufe7wQoONexARxB7XQfUh+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YjvD+otd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707415083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Iz8MKrilgB5RR4P9uodXji3Zfn9p3LF9RKyva2gdw0k=;
	b=YjvD+otdPt8ewTg2p7HOZQBnbfsBk2rwlFJIteQxDYLx1nKNvXsakHLx5FDGmjo2S3qypI
	VmWzKfzXb8WSgBbaCPElN5C8s/LtWH5WF3Y/jdPZjQcMy3vRYtKHGfQjr8bcJkXrI7rX10
	BfgmlF6m9Mf9yZgwvMiXCCvqhfqVdXE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-ly2duhYZP8ykGzYrkeQpmw-1; Thu, 08 Feb 2024 12:58:01 -0500
X-MC-Unique: ly2duhYZP8ykGzYrkeQpmw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61F20185A784;
	Thu,  8 Feb 2024 17:58:01 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.247])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2AB951C14B04;
	Thu,  8 Feb 2024 17:58:00 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: net: ignore timing errors in txtimestamp if KSFT_MACHINE_SLOW
Date: Thu,  8 Feb 2024 18:57:49 +0100
Message-ID: <bca0a7a2bac7fb1db6288a54936cdacdb0eb345b.1707411748.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

This test is time sensitive. It may fail on virtual machines and for
debug builds.

Similar to commit c41dfb0dfbec ("selftests/net: ignore timing errors in
so_txtime if KSFT_MACHINE_SLOW"), optionally suppress failure for timing
errors (only).

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/txtimestamp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
index 10f2fde3686b..ec60a16c9307 100644
--- a/tools/testing/selftests/net/txtimestamp.c
+++ b/tools/testing/selftests/net/txtimestamp.c
@@ -163,7 +163,8 @@ static void validate_timestamp(struct timespec *cur, int min_delay)
 	if (cur64 < start64 + min_delay || cur64 > start64 + max_delay) {
 		fprintf(stderr, "ERROR: %" PRId64 " us expected between %d and %d\n",
 				cur64 - start64, min_delay, max_delay);
-		test_failed = true;
+		if (!getenv("KSFT_MACHINE_SLOW"))
+			test_failed = true;
 	}
 }
 
-- 
2.43.0


