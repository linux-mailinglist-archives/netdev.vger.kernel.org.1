Return-Path: <netdev+bounces-244522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E962ACB964C
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 18:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BF9A30198ED
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 17:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37E82D94A8;
	Fri, 12 Dec 2025 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="Rdc1trI1"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCCD2D9485;
	Fri, 12 Dec 2025 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765557883; cv=none; b=fObH35HV5eqQK2/xlV2tsx1IRq82KI/QX64QmudhVI7EMlgbYW6tVrt0WARucb5UF3vHwIeS32eLjouchNEbO786ipEs6n4sxN0oUN77IF79eqTB5D1kA9W6IEOar9MyozkCdqf+aLovIi68aUC3J/MrvlI5Y0XiVAlUGgUNxV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765557883; c=relaxed/simple;
	bh=pNbg9DJUqQQgtIsx6NXCtC85KUXG4AdSJF+kXikG/qo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bbnKcwaimHn3QN7IVRxXcWNNaxzSoF0BNlbKZNjS+jEi4J5NQ9YUBhh2pGoB6FWluzrO+SYMCeFGObudnLQqDBGv6oikbrnzmOS/rMjNYJdk7OOWZ3aYogm3XnpJ+TGimNVKg+tegvDNUYEmNotBEyj5lubIE1E6W4bcHUvmQmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=Rdc1trI1; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1765557420; bh=pNbg9DJUqQQgtIsx6NXCtC85KUXG4AdSJF+kXikG/qo=;
	h=From:To:Cc:Subject:Date:From;
	b=Rdc1trI16IxrzagfKqpCEmQdjCF+kGygbxAHjEq5dUn+Hum0IB/FqmY7H+KwWs8Hu
	 hU4AHqD2ZKJMvrla7mnjkAhLRSvPAKLJSK2wrTyelojt+Tz0oooarJh2Rl4zzN5bCP
	 B/2U3r3PvnAcmHOyOv1uTZBFq1XbY8AXmcH3KYLkL7Tjgk5b134JZLCBkZfoZ2vt5P
	 MJHX1x7udlh7hierIKwduuQaF1hj2ueoJjHapwww+F5adPCE4LkHmTQU6aMNGBTJYR
	 BiXVkH3U9MtNORKi6dkyCcKEMXjMB16MvwU9xpNic0sMSqv8Skg5EVPaY90R+EOQHu
	 RO728QXLuWYpQ==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id D6C1B12535F;
	Fri, 12 Dec 2025 17:36:59 +0100 (CET)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [RFC PATCH v3 0/8] landlock: Add UDP access control support
Date: Fri, 12 Dec 2025 17:36:56 +0100
Message-Id: <20251212163704.142301-1-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mickaël, Günther, Mikhail, Konstantin,

Here is v3 of UDP support for Landlock. My apologies for the delay, I've
had to deal with unrelated problems. All feedback from v1/v2 should be
merged, thanks again for taking the time to review them.

I based these patches on linux-mic/next commit 1a3cedbdc156 ("landlock:
Fix wrong type usage") plus my previous patch "landlock: Fix TCP
handling of short AF_UNSPEC addresses" to avoid adding UDP with already
known bugs, duplicated from TCP. I waited a bit to get feedback on that
patch and no one yelled, so I hope it's acceptable, tell me if it's not.
Link: https://lore.kernel.org/linux-security-module/20251027190726.626244-4-matthieu@buffet.re/

Changes since v2
================
Link: https://lore.kernel.org/all/20241214184540.3835222-1-matthieu@buffet.re/
- removed support for sending datagrams with explicit destination
  address of family AF_UNSPEC, which allowed to bypass restrictions with
  a race condition
- rebased on linux-mic/next => add support for auditing
- fixed mistake in selftests when using unspec_srv variables, which were
  implicitly of type SOCK_STREAM and did not actually test UDP code
- add tests for IPPROTO_IP
- improved docs, split off TCP-related refactoring into another commit

Changes since v1
================
Link: https://lore.kernel.org/all/20240916122230.114800-1-matthieu@buffet.re/
- recvmsg hook is gone and sendmsg hook doesn't apply to connected
  sockets anymore, to improve performance
- don't add a get_addr_port() helper function, which required a weird
  "am I in IPv4 or IPv6 context" to avoid a addrlen > sizeof(struct
  sockaddr_in) check in connect(AF_UNSPEC) IPv6 context. A helper was
  useful when ports also needed to be read in a recvmsg() hook, now it
  is just a simple switch case in the sendmsg() hook, more readable
- rename sendmsg access right to LANDLOCK_ACCESS_NET_UDP_SENDTO
- reorder hook prologue for consistency: check domain, then type and
  family
- add additional selftests cases around minimal address length
- update documentation

All important cases should have a selftest now. lcov gives me net.c
going from 91.9% lines/82.5% branches to 93.4% lines/87% branches.
Thank you for taking the time to read this!

Closes: https://github.com/landlock-lsm/linux/issues/10

Matthieu Buffet (8):
  landlock: Minor reword of docs for TCP access rights
  landlock: Refactor TCP socket type check
  landlock: Add UDP bind+connect access control
  selftests/landlock: Add UDP bind/connect tests
  landlock: Add UDP sendmsg access control
  selftests/landlock: Add tests for UDP sendmsg
  samples/landlock: Add sandboxer UDP access control
  landlock: Add documentation for UDP support

 Documentation/userspace-api/landlock.rst     |  94 ++-
 include/uapi/linux/landlock.h                |  46 +-
 samples/landlock/sandboxer.c                 |  58 +-
 security/landlock/audit.c                    |   3 +
 security/landlock/limits.h                   |   2 +-
 security/landlock/net.c                      | 119 +++-
 security/landlock/syscalls.c                 |   2 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/net_test.c  | 691 ++++++++++++++++---
 9 files changed, 869 insertions(+), 148 deletions(-)


base-commit: 1a3cedbdc156e100eb1a5208a8562a3265c35d87
prerequisite-patch-id: 22051d5d4076a87481b22798c127ce84e219ca97
prerequisite-patch-id: 37a1b44596a2d861ba91989edb1d7aac005931d6
prerequisite-patch-id: c7be1c906699a2590ab7112cdf2ab6892178ec07
-- 
2.47.3


