Return-Path: <netdev+bounces-289153-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIZQKHpcC2ppGAUAu9opvQ
	(envelope-from <netdev+bounces-289153-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:37:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DFC5725D1
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B238306396F
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ED838B7D6;
	Mon, 18 May 2026 18:34:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from passt.top (passt.top [88.198.0.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7969738B12A;
	Mon, 18 May 2026 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.0.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779129268; cv=none; b=hJBwrf33jdRBYmixuWzR6Gd5YQnOh7IHMhesbKbSk2JyRQ/Sx0mQ1Vn8MSZAqI+xjYdRoZkiGlbvYTcT6F0xpKREvYLA2i+1INob1RDTfwEEPmYMsLCWCaIlmq18kuWt1KmGXOictZ/nudNocfVsDRtnDg2mWVp5ERq6bcH4WnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779129268; c=relaxed/simple;
	bh=PdRPZQQOpmqJOxDDdmnFS15AOoR3KbmtVTn+hwxmRko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jfcYkgFVgjB38RyFQFh5YXmZk0ggQYIXOMXNK2EdQiQtgy5okgi8mh5XwnVgakj3nY9Igy2tjVRjmA3W1OEVrxxhjs94HEccd8RTJHn3lnhKfXb+IcDAIND/2X/bqlQ3DBoTrhjmAGn1tX8B3QLqUBJ1WXg52f4dpC3umjmuXO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=passt.top; arc=none smtp.client-ip=88.198.0.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=passt.top
Received: by passt.top (Postfix, from userid 1000)
	id 62D145A061B; Mon, 18 May 2026 20:34:24 +0200 (CEST)
From: Stefano Brivio <sbrivio@redhat.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Pavel Emelyanov <xemul@scylladb.com>,
	Laurent Vivier <lvivier@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>,
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
Subject: [PATCH net v2 0/2] Fix race condition between TCP_REPAIR dump and data receive
Date: Mon, 18 May 2026 20:34:22 +0200
Message-ID: <20260518183424.3144867-1-sbrivio@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[redhat.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289153-lists,netdev=lfdr.de];
	R_DKIM_NA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 58DFC5725D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If we receive data on a socket that's in repair mode, the sequence and
contents of the receive queue we dump depend on the timing. We need to
freeze the input queue, otherwise the connection parameters restored
later might not match the actual state of the connection.

Patch 1/2 has the full details and the fix, patch 2/2 introduces
selftests to illustrate the problem and verify the solution.

v2: Don't touch the fast path in 1/2 (concern raised by Kuniyuki Iwashima
    and Eric Dumazet). Further details in the message for 1/2 itself.

Stefano Brivio (2):
  tcp: Don't accept data when socket is in repair mode
  selftests: Add data path tests for TCP_REPAIR mode

 include/net/dropreason-core.h                 |   3 +
 include/net/tcp.h                             |   3 +-
 net/ipv4/tcp.c                                |   9 +
 net/ipv4/tcp_input.c                          |  15 +-
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/net/tcp_repair/.gitignore       |   3 +
 .../testing/selftests/net/tcp_repair/Makefile |  23 ++
 .../testing/selftests/net/tcp_repair/client.c | 273 ++++++++++++++++++
 .../testing/selftests/net/tcp_repair/inner.sh |  32 ++
 .../testing/selftests/net/tcp_repair/outer.sh |  44 +++
 tools/testing/selftests/net/tcp_repair/run.sh |  12 +
 .../testing/selftests/net/tcp_repair/server.c | 155 ++++++++++
 tools/testing/selftests/net/tcp_repair/talk.h |  26 ++
 13 files changed, 596 insertions(+), 3 deletions(-)
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


