Return-Path: <netdev+bounces-47826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C347EB722
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 20:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9B2CB20BAD
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BE733066;
	Tue, 14 Nov 2023 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tk4QmYKi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310DF41A97;
	Tue, 14 Nov 2023 19:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DF1C43391;
	Tue, 14 Nov 2023 19:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699991907;
	bh=4LaAPrJNRyV9Kxo822qcQi+Li0GOQODfZw7dr5xUWj0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tk4QmYKiiSox5Eo9b3x4ORBjlYy+VFmBqAcw4aLoeclpd+MgjD3wRYdEB7sCjTFZO
	 Ps9S0hJAFfAXtyCD/l0RPP4WnivH3uuMRBQBLbrcSM9XwTqcayozUDUs5QeOtX/ReF
	 +7zyZ4iSsvYo6p/LRQlNgOx9OVkTa+5F08ncKXggYQmmLQ+B4ajCkdaCeup1BRQyxw
	 hd/7FjGFguykbB2IudmtsqkkNhPmczFPkX6gw1TrtnEK/HHMQPnX4KcnegTvs7EB57
	 meowfgAU5DBPk9autZKvPYlcUWTYsExAjUfhdDOpeiEBw6pKpL0YVo4uw+/Q7S/Tlm
	 06pBDXcYQHbwA==
From: Mat Martineau <martineau@kernel.org>
Date: Tue, 14 Nov 2023 11:56:54 -0800
Subject: [PATCH net-next v2 12/15] selftests: mptcp: add missing
 oflag=append
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-send-net-next-2023107-v2-12-b650a477362c@kernel.org>
References: <20231114-send-net-next-2023107-v2-0-b650a477362c@kernel.org>
In-Reply-To: <20231114-send-net-next-2023107-v2-0-b650a477362c@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.4

From: Geliang Tang <geliang.tang@suse.com>

In mptcp_connect.sh we are missing something like "oflag=append"
because this will write "${rem}" bytes at the beginning of the file
where there is already some random bytes. It should write that at
the end.

This patch adds this missing 'oflag=append' flag for 'dd' command in
make_file().

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 3b971d1617d8..c4f08976c418 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -593,7 +593,7 @@ make_file()
 	rem=$((SIZE - (ksize * 1024)))
 
 	dd if=/dev/urandom of="$name" bs=1024 count=$ksize 2> /dev/null
-	dd if=/dev/urandom conv=notrunc of="$name" bs=1 count=$rem 2> /dev/null
+	dd if=/dev/urandom conv=notrunc of="$name" oflag=append bs=1 count=$rem 2> /dev/null
 	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
 
 	echo "Created $name (size $(du -b "$name")) containing data sent by $who"

-- 
2.41.0


