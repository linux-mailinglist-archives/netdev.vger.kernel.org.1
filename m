Return-Path: <netdev+bounces-288766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAZkJM0NCmqPwQQAu9opvQ
	(envelope-from <netdev+bounces-288766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 20:49:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 307975635CF
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 20:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38AD6300E27E
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 18:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0683D330A;
	Sun, 17 May 2026 18:48:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from passt.top (passt.top [88.198.0.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0D03D16F6;
	Sun, 17 May 2026 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.0.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779043699; cv=none; b=kCDs8NKgqHfIH1QyCCHAM7EHseMyArjuoDXjVE8LBnwx2WqoJxiPqNzSeQSSF2gf3jstwOIW5ODmJwPTcplY4s5HnLLwVvFGezM+5HBaZ4QHHJss9/ZNO5hD+6MjkJA3xwbKSjdFhuoCVyVghJ75M+x1kW0tJHqapLida1G+o8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779043699; c=relaxed/simple;
	bh=Ls51sy7a8VSV/7b7mC+EWkCCZNY9AAUy27MYUf5Rhkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=db4kw7jyzxetWDDzQWv7S/wRvI+McaQ3avVaG2q/1D4K5ciEWHPuZKmOpO1LWI4M1ArQykN/96iP32IfFp6dZFQi4nnRjwAcP49/HOkfHRMTb/amX8tQcugawoW4c+pVt5zejPostuuYNFoM6/JY4NrAkeWxkPjeSMzTQtDbmwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=passt.top; arc=none smtp.client-ip=88.198.0.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=passt.top
Received: by passt.top (Postfix, from userid 1000)
	id CA39E5A0619; Sun, 17 May 2026 20:41:58 +0200 (CEST)
From: Stefano Brivio <sbrivio@redhat.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Pavel Emelyanov <xemul@scylladb.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Jon Maloy <jmaloy@redhat.com>,
	Dmitry Safonov <dima@arista.com>,
	Andrei Vagin <avagin@google.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net 0/2] Fix race condition between TCP_REPAIR dump and data receive
Date: Sun, 17 May 2026 20:41:56 +0200
Message-ID: <20260517184158.2757505-1-sbrivio@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 307975635CF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[redhat.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288766-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

If we receive data on a socket that's in repair mode, the sequence and
contents of the receive queue we dump depend on the timing. We need to
freeze the input queue, otherwise the connection parameters restored
later might not match the actual state of the connection.

Patch 1/2 has the full details and the fix, patch 2/2 introduces
selftests to illustrate the problem and verify the solution.

Stefano Brivio (2):
  tcp: Don't accept data when socket is in repair mode
  selftests: Add data path tests for TCP_REPAIR mode

 include/net/dropreason-core.h                 |   3 +
 net/ipv4/tcp_input.c                          |  14 +-
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/net/tcp_repair/.gitignore       |   3 +
 .../testing/selftests/net/tcp_repair/Makefile |  23 ++
 .../testing/selftests/net/tcp_repair/client.c | 273 ++++++++++++++++++
 .../testing/selftests/net/tcp_repair/inner.sh |  32 ++
 .../testing/selftests/net/tcp_repair/outer.sh |  44 +++
 tools/testing/selftests/net/tcp_repair/run.sh |  12 +
 .../testing/selftests/net/tcp_repair/server.c | 155 ++++++++++
 tools/testing/selftests/net/tcp_repair/talk.h |  26 ++
 11 files changed, 585 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/tcp_repair/.gitignore
 create mode 100644 tools/testing/selftests/net/tcp_repair/Makefile
 create mode 100644 tools/testing/selftests/net/tcp_repair/client.c
 create mode 100755 tools/testing/selftests/net/tcp_repair/inner.sh
 create mode 100755 tools/testing/selftests/net/tcp_repair/outer.sh
 create mode 100755 tools/testing/selftests/net/tcp_repair/run.sh
 create mode 100644 tools/testing/selftests/net/tcp_repair/server.c
 create mode 100644 tools/testing/selftests/net/tcp_repair/talk.h

-- 
2.43.0


