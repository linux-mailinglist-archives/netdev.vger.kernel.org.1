Return-Path: <netdev+bounces-249672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DF797D1C199
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 919F630021CD
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 02:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987B82EF662;
	Wed, 14 Jan 2026 02:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+HZnI9i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736EC2E11A6;
	Wed, 14 Jan 2026 02:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768356733; cv=none; b=ejiGksP9txeTgHwq+LxBl3LoyCdWSRyFUXUWN8agenf2b6b0gIZVdfGBBLReA5ycuBoiZwZkHV1RxfIIvKO4/O04f03lyTzO75trIGLWq6yshu7IDUVOlUIME4aTH6eU3s6uGFLdlEoTfcPpmv9TFf/RZ7aHadJ1M44uzlLIVEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768356733; c=relaxed/simple;
	bh=qhEwBB246rvLL0bZN3WJFb3er0bt0sN5Lua9ou6cD70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RCqZ3rk9muWEtOwzoPfIB8JE1CAhXn3cs9ZbQHX2QU/rXUQmSrhfqjWLvCkUzOBfIUB+74BbkggwqFR6IP8bw1GUjFJiYwnvccrcmXMjt1p0L7xPuNkPU0yvXfN9EYq27G7746QqEIYFuGC+HC7P27Ss2T40jjZbHFtYccQ8eIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+HZnI9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3261C116C6;
	Wed, 14 Jan 2026 02:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768356733;
	bh=qhEwBB246rvLL0bZN3WJFb3er0bt0sN5Lua9ou6cD70=;
	h=From:To:Cc:Subject:Date:From;
	b=s+HZnI9iuxn3k1jpkM8cTNVigRe0xEd6wDz5Y4uk/1pf0g/WNH+Wzye5Sx/GmlAue
	 FdZcChZZ3gO5kBQZS43V4IFlmrCGJtrM3qlmz7cxskLyW4vZYsYdZjQQA3GhX67UHD
	 u5DRg9W3R9v5MaHms4cZi2HYRTkRrovVbjGcUe/oWQ63xLXOwTpeMlz5yJ8Rzl9CwI
	 oRBcU/bRkiCCrh+KQuOys0xYi4+kB4qc8HCebnZf4hWq5yzROZ0U+MANQBBI0emMip
	 gFlfqmmmx5hpfrm0SHLvyVO72jyqmM5SJakt2I+nt/Vp/8m8o5bGiuhUdmw/O7xBq1
	 OCX/6N9hlt5ow==
From: Geliang Tang <geliang@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Gang Yan <yangang@kylinos.cn>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH net-next] selftests: tls: use mkstemp instead of open(O_TMPFILE)
Date: Wed, 14 Jan 2026 10:12:03 +0800
Message-ID: <3936106c6b3cc45c570023e083a1e56fa6548b41.1768356312.git.geliang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

When running TLS tests in a virtual machine/container environment, they
fail:

 # tls.c:1479:mutliproc_even: Expected fd (-1) >= 0 (0)
 # mutliproc_even: Test terminated by assertion
 #          FAIL  tls.12_aes_gcm.mutliproc_even
 not ok 59 tls.12_aes_gcm.mutliproc_even
 #  RUN           tls.12_aes_gcm.mutliproc_readers ...
 # tls.c:1479:mutliproc_readers: Expected fd (-1) >= 0 (0)
 # mutliproc_readers: Test terminated by assertion
 #          FAIL  tls.12_aes_gcm.mutliproc_readers
 not ok 60 tls.12_aes_gcm.mutliproc_readers
 #  RUN           tls.12_aes_gcm.mutliproc_writers ...
 # tls.c:1479:mutliproc_writers: Expected fd (-1) >= 0 (0)
 # mutliproc_writers: Test terminated by assertion
 #          FAIL  tls.12_aes_gcm.mutliproc_writers
 not ok 61 tls.12_aes_gcm.mutliproc_writers

This is because the /tmp directory uses the virtiofs filesystem, which does
not support the O_TMPFILE feature.

This patch uses mkstemp() to create temporary files, thereby eliminating
the dependency on the O_TMPFILE feature. And closes the file descriptor
(fd) and deletes the temfile after the test ends.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 tools/testing/selftests/net/tls.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 9e2ccea13d70..f4b8dd99d501 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1456,6 +1456,7 @@ test_mutliproc(struct __test_metadata *_metadata, struct _test_data_tls *self,
 	       bool sendpg, unsigned int n_readers, unsigned int n_writers)
 {
 	const unsigned int n_children = n_readers + n_writers;
+	char tmpfile[] = "/tmp/tls_test_tmpfile_XXXXXX";
 	const size_t data = 6 * 1000 * 1000;
 	const size_t file_sz = data / 100;
 	size_t read_bias, write_bias;
@@ -1469,7 +1470,7 @@ test_mutliproc(struct __test_metadata *_metadata, struct _test_data_tls *self,
 	write_bias = n_readers / n_writers ?: 1;
 
 	/* prep a file to send */
-	fd = open("/tmp/", O_TMPFILE | O_RDWR, 0600);
+	fd = mkstemp(tmpfile);
 	ASSERT_GE(fd, 0);
 
 	memset(buf, 0xac, file_sz);
@@ -1527,6 +1528,8 @@ test_mutliproc(struct __test_metadata *_metadata, struct _test_data_tls *self,
 			left -= res;
 		}
 	}
+	close(fd);
+	unlink(tmpfile);
 }
 
 TEST_F(tls, mutliproc_even)
-- 
2.51.0


