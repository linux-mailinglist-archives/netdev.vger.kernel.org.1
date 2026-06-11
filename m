Return-Path: <netdev+bounces-298210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Xb3HDhbiKmoaywMAu9opvQ
	(envelope-from <netdev+bounces-298210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:28:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6930B6737FC
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:28:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=buffet.re header.s=mx1 header.b="RJ/YF946";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298210-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298210-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=buffet.re;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA93330449BE
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C81142B725;
	Thu, 11 Jun 2026 16:21:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E534266B1;
	Thu, 11 Jun 2026 16:21:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194911; cv=none; b=fwimyRFzozv7jnxPc5N+GMdP4f63WhCGCBhH/9Z8Zxhex4+8/ISdJyAE+poiY8mBkwiEpATkAb438LEpxMaB+HwAvZtRbTyT9Ta5p1nBZBG6xEj+U2N8a+cr5QzoJPyCMKHJX3zswvAJvXJ94sI+VGDzuJ/GMkLHlMm9EbvixYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194911; c=relaxed/simple;
	bh=Sy/uyKwIT7avvnKqBnGYYgmi6B/oKwD7z26mUetEzUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QLRJZNwZCFWmNm/AyxX/ql5X4M16A1vRNMbBW11vVkCbJyPW5nhESnYBTDTJfA9qDAgpAj8eEJKV77T9sjyimBMPfMzaxJ8HUKxNYrre1oRBeGbLQjt60NXD1GR99ikddffwkGjiFY7cnqw/gj3QRE10sRRsXChylM9ByqohzLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=RJ/YF946; arc=none smtp.client-ip=51.83.41.69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1781194905; bh=Sy/uyKwIT7avvnKqBnGYYgmi6B/oKwD7z26mUetEzUY=;
	h=From:To:Cc:Subject:Date:From;
	b=RJ/YF946MP4a9c8apnOjFEnP9/G7JjVMTTXBtYX6k7yCkf3tvzTzLEGdk7JHLXKQq
	 qrng/nK/zI+bT2bw7bkIQLsEVpcAaeT9S8bkUvHe0D3pg/obglCxj/sPHJLAZ0cLo1
	 gZ9wXFS6zY5kt4ZkHD741Lc6lCm3TfNeeQAesBfbvgdv/K7RsL9uWzllOk/w1C2jOY
	 fDPgD67AZrG2XX8gl7dD5rAEO/1L3W+UebSqmh/Ch2iVlsbwPD/SmkV1ffGKJXNFNG
	 phX0eSfDwh9GNLNQDFLcq4a9L9Ex59+Ih2AjAUgJk8yX51htPbZwcu1Xw1zd7pvhzf
	 j5HBpj+wY6+Ag==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 7E0691253FC;
	Thu, 11 Jun 2026 18:21:44 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH v5 0/6] landlock: Add UDP access control support
Date: Thu, 11 Jun 2026 18:21:00 +0200
Message-ID: <20260611162107.49278-1-matthieu@buffet.re>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[buffet.re,quarantine];
	R_DKIM_ALLOW(-0.20)[buffet.re:s=mx1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298210-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[matthieu@buffet.re,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mic@digikod.net,m:gnoack@google.com,m:linux-security-module@vger.kernel.org,m:ivanov.mikhail1@huawei-partners.com,m:konstantin.meskhidze@huawei.com,m:m@maowtm.org,m:netdev@vger.kernel.org,m:matthieu@buffet.re,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[buffet.re:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthieu@buffet.re,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,buffet.re:dkim,buffet.re:mid,buffet.re:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6930B6737FC

Hi,

This is V5 (hopefully final) of UDP access control in Landlock. It has
very few changes compared to v4, described below, all feedback given so
far should be in there (if not that's a mistake on my part). It adds
only two access rights, to restrict configuring local and remote
addresses on UDP sockets. The one that restricts setting a remote
address also controls sending datagrams to explicit remote addresses
-ignoring any remote address preset on the socket-. The one that
restricts binding to a local port also applies when the kernel
auto-binds an ephemeral port.

Changes v1->v2
==============
- recvmsg hook is gone and sendmsg hook doesn't apply when sending to a
  remote address pre-set on socket, to improve performance
- don't add a get_addr_port() helper function, which required a weird
  "am I in IPv4 or IPv6 context"
- reorder hook prologue for consistency: check domain, then type and
  family

Changes v2->v3
==============
- removed support for sending datagrams with explicit destination
  address of family AF_UNSPEC, which allowed to bypass restrictions with
  a race condition
- rebased on linux-mic/next => add support for auditing
- fixed mistake in selftests when using unspec_srv variables, which were
  implicitly of type SOCK_STREAM and did not actually test UDP code
- add tests for IPPROTO_IP
- improved docs, split off TCP-related refactoring

Changes v3->v4
==============
- merge LANDLOCK_ACCESS_NET_CONNECT_UDP and
  LANDLOCK_ACCESS_NET_SENDTO_UDP into
  LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP (everything that might set the
  destination of a datagram)
- make LANDLOCK_ACCESS_NET_BIND_UDP apply when kernel is about to
  auto-bind an ephemeral port for the caller. Block it if policy would
  not allow an explicit call to bind(0)
- only deny sending AF_UNSPEC datagrams on IPv6 sockets, where there is
  a risk of the address family changing midway

Changes v4->v5
==============
- fix unmarked racy socket address family accesses
- fix improper bind(0) autobind access check when connecting to AF_UNSPEC
- fix example code structure in documentation to match pattern of usage
  used in the rest of the code
- fix bad copy-pastes in selftests, and some unimportant variable types
- squash LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP commits
- add a small help note in sandboxer to point out the need to allow
  binding a source port when emitting, to reduce surprises if people
  try to get a feeling of the feature through sandboxer before reading
  the docs

v1:
Link: https://lore.kernel.org/all/20240916122230.114800-1-matthieu@buffet.re/
v2:
Link: https://lore.kernel.org/all/20241214184540.3835222-1-matthieu@buffet.re/
v3:
Link: https://lore.kernel.org/all/20251212163704.142301-1-matthieu@buffet.re/
v4:
Link: https://lore.kernel.org/all/20260502124306.3975990-1-matthieu@buffet.re/

Based on https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
9ea6fb415fc8 ("selftests/landlock: Explicitly disable audit in teardowns")
from branch next.
All lines added are covered with selftests (net.c goes from 93.1% to 95.3%
line coverage).

Closes: https://github.com/landlock-lsm/linux/issues/10

Matthieu Buffet (6):
  landlock: Add UDP bind() access control
  landlock: Add UDP send+connect access control
  selftests/landlock: Add tests for UDP bind/connect
  selftests/landlock: Add tests for UDP send
  samples/landlock: Add sandboxer UDP access control
  landlock: Add documentation for UDP support

 Documentation/userspace-api/landlock.rst     |   91 +-
 include/uapi/linux/landlock.h                |   35 +-
 samples/landlock/sandboxer.c                 |   41 +-
 security/landlock/audit.c                    |    3 +
 security/landlock/limits.h                   |    2 +-
 security/landlock/net.c                      |  155 ++-
 security/landlock/syscalls.c                 |    2 +-
 tools/testing/selftests/landlock/base_test.c |    4 +-
 tools/testing/selftests/landlock/net_test.c  | 1166 ++++++++++++++++--
 9 files changed, 1353 insertions(+), 146 deletions(-)


base-commit: 9ea6fb415fc8b535da91dadd74f948d96ba3d41d
-- 
2.47.3


