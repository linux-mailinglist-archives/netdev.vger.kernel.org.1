Return-Path: <netdev+bounces-15524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6FD748386
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 13:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD6CA1C20B0A
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 11:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A026FB5;
	Wed,  5 Jul 2023 11:53:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1E96AB8
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 11:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94540C433C7;
	Wed,  5 Jul 2023 11:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688558002;
	bh=ieO2X/lBi2r10eqVd5hEK+hSNE8vmZv8+Pqsk4DwJpM=;
	h=From:To:Cc:Subject:Date:From;
	b=gQbr81r4/R+ddRIVgmE0eAMEoagIJLFIX/cjIvoNiy+BHkOfX9g/DqXPDJs5WgKQ5
	 mqEMTePBQEugZobzXpsEOWAUs4s0uMc/ZTvfK1DSt/K3UZ+dpetvaskhUjLhDVkh4h
	 G7vElXTvtboFmjT/+dRKu392wcxUMv3FbCjL8rllPFjlRm5RCcB76a6LlkFEESn4bK
	 lJ4C+BvPwEZQJtjURFUCZ84HNsCByMtWqHYWZU5FoJhLHJiCBh3oPVxNgFXF7MKYgs
	 NgU4mhEy/5RPVUlBoElbtyXe7z+THStzPCNIJfIVMz7bNE2I8HA9Yfrze6rMdbxKOx
	 1Ubm8Txt+ci7g==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Andrea Righi <andrea.righi@canonical.com>,
	Kees Cook <keescook@chromium.org>,
	Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
	netdev@vger.kernel.org
Subject: [PATCH] kselftest/runner.sh: Propagate SIGTERM to runner child
Date: Wed,  5 Jul 2023 13:53:17 +0200
Message-Id: <20230705115317.753182-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

Timeouts in kselftest are done using the "timeout" command with the
"--foreground" option. Without the "foreground" option, it is not
possible for a user to cancel the runner using SIGINT, because the
signal is not propagated to timeout which is running in a different
process group. The "forground" options places the timeout in the same
process group as its parent, but only sends the SIGTERM (on timeout)
signal to the forked process. Unfortunately, this does not play nice
with all kselftests, e.g. "net:fcnal-test.sh", where the child
processes will linger because timeout does not send SIGTERM to the
group.

Some users have noted these hangs [1].

Fix this by nesting the timeout with an additional timeout without the
foreground option.

Link: https://lore.kernel.org/all/7650b2eb-0aee-a2b0-2e64-c9bc63210f67@alu.unizg.hr/ # [1]
Fixes: 651e0d881461 ("kselftest/runner: allow to properly deliver signals to tests")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/kselftest/runner.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 1c952d1401d4..70e0a465e30d 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -36,7 +36,8 @@ tap_timeout()
 {
 	# Make sure tests will time out if utility is available.
 	if [ -x /usr/bin/timeout ] ; then
-		/usr/bin/timeout --foreground "$kselftest_timeout" $1
+		/usr/bin/timeout --foreground "$kselftest_timeout" \
+			/usr/bin/timeout "$kselftest_timeout" $1
 	else
 		$1
 	fi

base-commit: d528014517f2b0531862c02865b9d4c908019dc4
-- 
2.39.2


