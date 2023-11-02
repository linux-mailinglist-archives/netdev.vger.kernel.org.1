Return-Path: <netdev+bounces-45727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A72247DF36A
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 14:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33604B21151
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 13:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9224A11CA5;
	Thu,  2 Nov 2023 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="IovpZL7m"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1B313AD9
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 13:14:13 +0000 (UTC)
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ad])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CC2136
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 06:14:04 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SLkpx5hN5zMqJcN;
	Thu,  2 Nov 2023 13:14:01 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SLkpw6ZkyzMpnPm;
	Thu,  2 Nov 2023 14:14:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1698930841;
	bh=JUcQS3TJeMPBK3H6KZcOPpajxJbdHlxklTtQGbSiGVI=;
	h=From:To:Cc:Subject:Date:From;
	b=IovpZL7mVXcmpJ+3fp3aa2YUxDJ4Ag6H8RwR4LbB9iLZ02v2CS3C1TuNyn0XdjzfJ
	 oB2517iE8enLFHNChljK2yX4c/Msf9Fqcl8K1PZmGK74B/8Ly0l6jeqS3XwzsGg+zn
	 Fm1C5kP5017YSvEaRtJ7Tc1aCBtNF8LHV82B9fro=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	artem.kuzin@huawei.com,
	yusongping <yusongping@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org
Subject: [GIT PULL] Landlock updates for v6.7
Date: Thu,  2 Nov 2023 14:13:54 +0100
Message-ID: <20231102131354.263678-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi Linus,

This PR adds initial network support for Landlock (TCP bind and connect
access control), contributed by Konstantin Meskhidze [1].  Please pull
these changes for v6.7-rc1 .  These 13 commits merged cleanly with your
master branch and the LSM/dev branch [2].  The kernel code has been
tested in the latest linux-next releases for a month (next-20231003 [3])
but the related patch series has since been updated (while keeping the
same kernel code): extended tests, improved documentation and commit
messages.  I rebased the latest patch series (with some cosmetic fixes)
on v6.6-rc7 and added two more tests.

A Landlock ruleset can now handle two new access rights:
LANDLOCK_ACCESS_NET_BIND_TCP and LANDLOCK_ACCESS_NET_CONNECT_TCP.  When
handled, the related actions are denied unless explicitly allowed by a
Landlock network rule for a specific port.

The related patch series has been reviewed for almost two years, it has
evolved a lot and we now have reached a decent design, code and testing.
The refactored kernel code and the new test helpers also bring the
foundation to support more network protocols.

Test coverage for security/landlock is 92.4% of 710 lines according to
gcc/gcov-13, and it was 93.1% of 597 lines before this series.  The
decrease in coverage is due to code refactoring to make the ruleset
management more generic (i.e. dealing with inodes and ports) that also
added new WARN_ON_ONCE() checks not possible to test from user space.

syzkaller has been updated accordingly [4], and such patched instance
(tailored to Landlock) has been running for a month, covering all the
new network-related code [5].

Link: https://lore.kernel.org/r/20231026014751.414649-1-konstantin.meskhidze@huawei.com [1]
Link: https://lore.kernel.org/r/CAHC9VhS1wwgH6NNd+cJz4MYogPiRV8NyPDd1yj5SpaxeUB4UVg@mail.gmail.com [2]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git/commit/?id=c8dc5ee69d3a [3]
Link: https://github.com/google/syzkaller/pull/4266 [4]
Link: https://storage.googleapis.com/syzbot-assets/82e8608dec36/ci-upstream-linux-next-kasan-gce-root-ab577164.html#security%2flandlock%2fnet.c [5]

Regards,
 Mickaël

--
The following changes since commit 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1:

  Linux 6.6-rc7 (2023-10-22 12:11:21 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.7-rc1

for you to fetch changes up to f12f8f84509a084399444c4422661345a15cc713:

  selftests/landlock: Add tests for FS topology changes with network rules (2023-10-27 17:53:31 +0200)

----------------------------------------------------------------
Landlock updates for v6.7-rc1

----------------------------------------------------------------
Konstantin Meskhidze (11):
      landlock: Make ruleset's access masks more generic
      landlock: Refactor landlock_find_rule/insert_rule helpers
      landlock: Refactor merge/inherit_ruleset helpers
      landlock: Move and rename layer helpers
      landlock: Refactor layer helpers
      landlock: Refactor landlock_add_rule() syscall
      landlock: Support network rules with TCP bind and connect
      selftests/landlock: Share enforce_ruleset() helper
      selftests/landlock: Add network tests
      samples/landlock: Support TCP restrictions
      landlock: Document network support

Mickaël Salaün (2):
      landlock: Allow FS topology changes for domains without such rule type
      selftests/landlock: Add tests for FS topology changes with network rules

 Documentation/userspace-api/landlock.rst     |   99 +-
 include/uapi/linux/landlock.h                |   55 +
 samples/landlock/sandboxer.c                 |  115 +-
 security/landlock/Kconfig                    |    1 +
 security/landlock/Makefile                   |    2 +
 security/landlock/fs.c                       |  232 ++--
 security/landlock/limits.h                   |    6 +
 security/landlock/net.c                      |  200 +++
 security/landlock/net.h                      |   33 +
 security/landlock/ruleset.c                  |  405 ++++--
 security/landlock/ruleset.h                  |  185 ++-
 security/landlock/setup.c                    |    2 +
 security/landlock/syscalls.c                 |  158 ++-
 tools/testing/selftests/landlock/base_test.c |    2 +-
 tools/testing/selftests/landlock/common.h    |   13 +
 tools/testing/selftests/landlock/config      |    4 +
 tools/testing/selftests/landlock/fs_test.c   |   69 +-
 tools/testing/selftests/landlock/net_test.c  | 1738 ++++++++++++++++++++++++++
 18 files changed, 2967 insertions(+), 352 deletions(-)
 create mode 100644 security/landlock/net.c
 create mode 100644 security/landlock/net.h
 create mode 100644 tools/testing/selftests/landlock/net_test.c

