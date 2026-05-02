Return-Path: <netdev+bounces-283406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFoZHuDz9WnwQgIAu9opvQ
	(envelope-from <netdev+bounces-283406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 14:53:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E13914B20AC
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 14:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4FBF300B3C9
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 12:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C386A36CE06;
	Sat,  2 May 2026 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="LJCze0hS"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DD330E83A;
	Sat,  2 May 2026 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777726429; cv=none; b=J0/VwZUKt3IKwOQw99UmnKJ74qrQjjB7YgBPKTlee4CDW1FL6CDlx+JfGwN/eeGWCguNW7WXrzMahTdZimRicTl8YdHPI/YQiy2jq8slkXE3D9qKOukoyl8Al85x9riYjW/Z4w492Ps5kuI0YK0r1IeAIjvs4d/c1cOrwoMAfzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777726429; c=relaxed/simple;
	bh=ar9ulHxkkWIn6+7xRUQDtqTK4weZSK60FAJ22y5k8Sc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GuFqen/YtW5byGZhp0kLcNsiockr5nAlRuG2v73zr7ldM2jp6f4U/Dz/zEIsZEFoBtDR0ixwfVepaa/lhI5+5fQnwbo1CytphY7y7nAfZI7zkzSo0keAPthAaA9UoTBu4yz5rV4fB+3AUEqUKg07hIoM9CF+je286LKJovg1+Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=LJCze0hS; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1777725860; bh=ar9ulHxkkWIn6+7xRUQDtqTK4weZSK60FAJ22y5k8Sc=;
	h=From:To:Cc:Subject:Date:From;
	b=LJCze0hSmnBUziOFXJ8MLcNeu/B3HanQEFXoVqLmn1iZJ+zWpTqxlrAEpHK4FdAPJ
	 cNnfbtEBD4kiMoFwaD3LkJtk+iGzpZEnfIEv78SyA1BI1qX8Vu07WvkOvctnAK3E/t
	 SqydvfPGwoG+LltFdieSjFTGAXPiZrYEhCqce0JobM5vqRcHP6bKfkvW2BeB1c6suQ
	 +9K5be1pQIPflIMRiPUksIIHEVI0Lk0F5ZnSfR2kedlt0ECrXaEHypMRevc4UhnWey
	 2IHAPMaPPF5yugVDJ/fSXYUAM1/CdzXaAA6QcbwUfIRjq9Dknu+qzLgw9Dhh5k2e7S
	 MLyTkcEuhVzRg==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id ABC261257B9;
	Sat,  2 May 2026 14:44:20 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH v4 0/7] landlock: Add UDP access control support
Date: Sat,  2 May 2026 14:42:59 +0200
Message-Id: <20260502124306.3975990-1-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E13914B20AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[buffet.re,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[buffet.re:s=mx1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283406-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[matthieu@buffet.re,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[buffet.re:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,buffet.re:dkim,buffet.re:mid]

Hi,

This is V4 of UDP access control in Landlock. Thanks to the round of
review of v3, access rights have changed to something that seems easier
to use and understand. It adds only two access rights, to restrict
configuring local and remote addresses on UDP sockets. The one that
restricts setting a remote address also controls sending datagrams to
explicit remote addresses -ignoring any remote address preset on the
socket-. The one that restricts binding to a local port also applies
when the kernel auto-binds an ephemeral port.
v1:
Link: https://lore.kernel.org/all/20240916122230.114800-1-matthieu@buffet.re/
v2:
Link: https://lore.kernel.org/all/20241214184540.3835222-1-matthieu@buffet.re/
v3:
Link: https://lore.kernel.org/all/20251212163704.142301-1-matthieu@buffet.re/

The limitation around allowing a process to send but not receive is
still there, and could warrant another patch if there is a real user
need.
I'm just not super happy about the clarity of logs generated for denied
autobinds ("domain=xxxxxx blockers=net.bind_udp"), due to the fact that
addresses and ports are currently only logged if they are non-0. A later
(coordinated LSM-wide) patch could improve readability by replacing != 0
checks with new booleans in struct lsm_network_audit. I'm also not
exactly happy with the integration in existing TCP selftests, but
refactoring them has already been discussed earlier.

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

Patch is based on https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
3457a5ccacd3 ("landlock: Document fallocate(2) as another truncation corner case")
All lines added are covered with selftests, except the "default: return
0" in current_check_autobind_udp_socket() which is not currently
reachable (net.c goes from 92.9%->94.6% line coverage).

Let me know what you think!

Closes: https://github.com/landlock-lsm/linux/issues/10

Matthieu Buffet (7):
  landlock: Add UDP bind() access control
  landlock: Add UDP connect() access control
  landlock: Add UDP send access control
  selftests/landlock: Add UDP bind/connect tests
  selftests/landlock: Add tests for sendmsg()
  samples/landlock: Add sandboxer UDP access control
  landlock: Add documentation for UDP support

 Documentation/userspace-api/landlock.rst     |   89 +-
 include/uapi/linux/landlock.h                |   35 +-
 samples/landlock/sandboxer.c                 |   40 +-
 security/landlock/audit.c                    |    3 +
 security/landlock/limits.h                   |    2 +-
 security/landlock/net.c                      |  161 ++-
 security/landlock/syscalls.c                 |    2 +-
 tools/testing/selftests/landlock/base_test.c |    4 +-
 tools/testing/selftests/landlock/net_test.c  | 1146 ++++++++++++++++--
 9 files changed, 1341 insertions(+), 141 deletions(-)


base-commit: 3457a5ccacd34fdd5ebd3a4745e721b5a1239690
-- 
2.39.5


