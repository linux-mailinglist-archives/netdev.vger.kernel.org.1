Return-Path: <netdev+bounces-151967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F27529F2080
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 19:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795FB188640B
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 18:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412F51A8F80;
	Sat, 14 Dec 2024 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="D9GOcKeC"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1392580C02;
	Sat, 14 Dec 2024 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734202424; cv=none; b=Qtpumkgbkmj3dTp0EBBOYrdqo6BGz1gW9d7PFiUwmg5dv+BA2anlAbgChogImQqP2JVyY8Oo1r7CPt7QHEicY7Jwx2ihfhlEqkQMNxS9IaLEGDpL4mTy8VvSLgNeKUk2PdxBOfn0PY2Kdh/B7MJxntldWJ0VvFPGOTPcud1RzfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734202424; c=relaxed/simple;
	bh=oCKT2oHPdAe+VXkRCxa2XD6OUm8jUcAcZdM74Lx+AXI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fN07ouaYJ0QgVtAhLM6Xi9vqthyJ7YFRuNbIjhpXshArAzL3m47jw7+siQgr52/jArriQpHYvPAO/ZHBpeShQCI6salwXDLawB56g8NnoR0Knw9oRGPKYkaBknAzpRA3G5tNIRLRZQLvvT8dJfSNcnViKFBYOerfNCYPAFsPzZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=D9GOcKeC; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1734201974; bh=oCKT2oHPdAe+VXkRCxa2XD6OUm8jUcAcZdM74Lx+AXI=;
	h=From:To:Cc:Subject:Date:From;
	b=D9GOcKeCXjU2qwnNqTooTW5qFY3JsaE/qkyCLHarBk496R9Q6oehRfWOJJgu2uWLY
	 TFUseMEPnXy440X7PQlMVWwJuogZm7+hpejuycvID0SFuDFzkMeLG/6Z3JQcPaK/3E
	 PegRRuVbKcBGqDkX2ynoMYfqeWbSEllEUIbIwkye8tV9BeOtJ3fS6TqwC3TE/DcvJe
	 2NDvTQ0aaxyrKjGxTrdz4oP2kvX+d1nTdEfBzraPL4ShF7xINKyMkCW/zwt8PW48d2
	 C2bhRZAQv8t/4c8y8tQ/gSF5xYlHmxWKjGyQp6NpS1DH8A11yukduVUIgJBwgZlkRt
	 CeLI+UJSe87gA==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPSA id 3309A1233B5;
	Sat, 14 Dec 2024 19:46:14 +0100 (CET)
From: Matthieu Buffet <matthieu@buffet.re>
To: Mickael Salaun <mic@digikod.net>
Cc: Gunther Noack <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH v2 0/6] landlock: Add UDP access control support
Date: Sat, 14 Dec 2024 19:45:34 +0100
Message-Id: <20241214184540.3835222-1-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mickael,

Thanks for your comments on the v1 of this patch, I should have everything
fixed so (hopefully) this v2 boils down to something simpler.

This patchset is based on
https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
Linux 6.12 (adc218676eef).

This patchset should add basic support to completely block a process
from sending and receiving UDP datagrams, and delegate the right to
send/receive based on remote/local port. It should fit nicely with
the socket creation restrictions WIP (either don't have UDP at all, or
have it with just the rights needed).

@Mikhail: I saw the discussions around TCP error code inconsistencies +
over-restriction, and your patch v1. I took extra care to minimize this
diff size: no unnecessary comment/refactor, especially in
current_check_access_socket(). It should be just what is required for a
basic UDP support without changing error handling in that main function.

The only question that remained open from v1 was about UDP rights naming.
Since there were no strong preferences and the hooks now only handle
sendmsg() if an explicit address is specified, that's now
LANDLOCK_ACCESS_NET_UDP_SENDTO since the name (and prototype with a
destination address parameter) of sendto(3) is closer to these semantics.

Changes since v1 (link below):
- recvmsg hook is gone and sendmsg hook doesn't apply to connected
  sockets anymore, to improve performance
- don't add a get_addr_port() helper function, which required a weird "am
  I in IPv4 or IPv6 context" to avoid a addrlen>sizeof(struct sockaddr_in)
  check in connect(AF_UNSPEC) IPv6 context. A helper was useful when ports
  also needed to be read in a recvmsg() hook, now it's just a simple
  switch case in the sendmsg() hook, more readable
- rename sendmsg access right to LANDLOCK_ACCESS_NET_UDP_SENDTO
- reorder hook prologue for consistency: check domain, then type and
  family
- add additional selftests cases around minimal address length
- update documentation

lcov gives me net.c going from 94% lines/80% functions to 96.6% lines/
85.7% functions

Any feedback welcome!

Link: https://lore.kernel.org/all/20240916122230.114800-1-matthieu@buffet.re/
Closes: https://github.com/landlock-lsm/linux/issues/10

Link: https://lore.kernel.org/all/20241017110454.265818-1-ivanov.mikhail1@huawei-partners.com/
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>

Matthieu Buffet (6):
  landlock: Add UDP bind+connect access control
  selftests/landlock: Adapt existing bind/connect for UDP
  landlock: Add UDP sendmsg access control
  selftests/landlock: Add ACCESS_NET_SENDTO_UDP
  samples/landlock: Add sandboxer UDP access control
  doc: Add landlock UDP support

 Documentation/userspace-api/landlock.rst     |  84 +++-
 include/uapi/linux/landlock.h                |  67 ++-
 samples/landlock/sandboxer.c                 |  58 ++-
 security/landlock/limits.h                   |   2 +-
 security/landlock/net.c                      | 137 +++++-
 security/landlock/syscalls.c                 |   2 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/net_test.c  | 455 +++++++++++++++++--
 8 files changed, 715 insertions(+), 92 deletions(-)


base-commit: adc218676eef25575469234709c2d87185ca223a
-- 
2.39.5


