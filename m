Return-Path: <netdev+bounces-20990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4A276217B
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 648952819C9
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC9A2592E;
	Tue, 25 Jul 2023 18:35:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A36024163;
	Tue, 25 Jul 2023 18:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB2FC433CB;
	Tue, 25 Jul 2023 18:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690310099;
	bh=QwCnG5+Z7TjpjUwNXP4jPD4RDLcuQH9RqoFnYbUu7zk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WLf9j7bNRkk+C8wUwtTrglbCQ3trv6Z5i+Zv5RaFOU5WMeevBR/rtSw8yhsVhBBfw
	 dyHdV38/mRlnvb23QCiusBcAHxk7+94J21m7kZ+lSCKX9ul+lGD2jsU8tePClT8+kU
	 7uUZTlvC9zwgqNmqilX6liw03A3rTxbKOTWeQYV1Gq0bYjMsuUFlEwObeKUaadu8rH
	 HzNOje1HztlFsHcRZvusUrku48cZorlJlRHHffHCkw8FtJNVp5kW7a6BoJhaIv7KOY
	 c6gJebLmPrmnh7iOuvGrKkEmuZzaN5+MZYRaplzGLZsYYviKfmpcQqo4S/1amIDrCQ
	 p3rBM5xXuYBgQ==
From: Mat Martineau <martineau@kernel.org>
Date: Tue, 25 Jul 2023 11:34:55 -0700
Subject: [PATCH net 1/2] selftests: mptcp: join: only check for ip6tables
 if needed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230725-send-net-20230725-v1-1-6f60fe7137a9@kernel.org>
References: <20230725-send-net-20230725-v1-0-6f60fe7137a9@kernel.org>
In-Reply-To: <20230725-send-net-20230725-v1-0-6f60fe7137a9@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geliang Tang <geliang.tang@suse.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, stable@vger.kernel.org, 
 Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.3

From: Matthieu Baerts <matthieu.baerts@tessares.net>

If 'iptables-legacy' is available, 'ip6tables-legacy' command will be
used instead of 'ip6tables'. So no need to look if 'ip6tables' is
available in this case.

Fixes: 0c4cd3f86a40 ("selftests: mptcp: join: use 'iptables-legacy' if available")
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e6c9d5451c5b..3c2096ac97ef 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -162,9 +162,7 @@ check_tools()
 	elif ! iptables -V &> /dev/null; then
 		echo "SKIP: Could not run all tests without iptables tool"
 		exit $ksft_skip
-	fi
-
-	if ! ip6tables -V &> /dev/null; then
+	elif ! ip6tables -V &> /dev/null; then
 		echo "SKIP: Could not run all tests without ip6tables tool"
 		exit $ksft_skip
 	fi

-- 
2.41.0


