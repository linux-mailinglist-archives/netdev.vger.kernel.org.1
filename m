Return-Path: <netdev+bounces-128533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 495F197A23E
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F191F24810
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 12:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B68E155CBA;
	Mon, 16 Sep 2024 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="DwviWWQx"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEF51553B7;
	Mon, 16 Sep 2024 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489559; cv=none; b=tSiU9JugjZc/y1r5D8tiV3YseUkttb/vnAJYkZqhDGzYJFgdw3UIBUnwrGHwP5DvjLSwVqzfqkulYfa0ViZy9dmWHt2rni09sRQxYo/TpMS87jTCj32R6FpgAMEuYUn6VYMxMdw054gJPxIajfGY7k2H1D3RF6j+Ug3JHxzIvYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489559; c=relaxed/simple;
	bh=u966p51sgSEBSUnLsK0gdEYkL0s4sRyftNWcEuH4hd4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e/6xiG5N32mYJDyFKWkhTaKoLvWXH8w2o7sIWx7Wm3jNciqe2/o7eoi7wSJVKaXvidfJaokufvRsGcU7Flkx2Bz+sWsYKSLedg/O6S2pERIGOsfFrQyUL4mjJq971Wp7kAy3DrdqcApDslH8Lzg7q7B1TXRWUrHS+h7SvS0Wycw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=DwviWWQx; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1726489282; bh=u966p51sgSEBSUnLsK0gdEYkL0s4sRyftNWcEuH4hd4=;
	h=From:To:Cc:Subject:Date:From;
	b=DwviWWQxscsbPjrv4RWiczfo4wRhcHcU81HTlYnf/SlrLgfGAjHdi5gqzpjUwp3qm
	 4GeDipF972tyjUZvhU77ZJNUgIxrDvNsmAGvE+UkMk1dT7WNg0ib0+sXk7WVWMVgkS
	 Bpn/mzomS2xNAZ7Rb5IqaaLSVzTKmibJScNnrtkZKDuwKae/HcF+iPwnaT0QIIpk6M
	 N8xbu03rvq5FRNVvQUsw4T0fJyHSb+4f8shZj6UXk7oZcdTraSbfrhCjnkNMjdjEwt
	 3i+1IewTFfbXen0OJ16QTpKc/XOLZkHBM+plrlSfdNM94Z5GBr4S5qdFz1UrSuyi5M
	 k2EH1/Z+B3Upg==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPA id 8D0661230AA;
	Mon, 16 Sep 2024 14:21:21 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [RFC PATCH v1 0/7] landlock: Add UDP access control support
Date: Mon, 16 Sep 2024 14:22:23 +0200
Message-Id: <20240916122230.114800-1-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Landlocked processes can freely use UDP sockets. This may allow them to
escape their sandbox if they can reach UDP sockets of other vulnerable
processes on the same host, or allow them to send/receive to/from unwanted
hosts.

This is a first attempt to add access control around UDP usage, based on
https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
Linux 6.11-rc1 (8400291e289e).

The first two commits fix what I interpret as a bug in landlock's sample's
options parsing, in order to allow testing the actual patch contents.
These two are finished afaict and could be merged separately, but are
bundled here to have a working base-commit and allow the actual patch to
get a first round of feedback.

Add two new access rights in the same bind/connect hooks as used for
TCP, with the same semantics.

Also add two new hooks in recvmsg/sendmsg and two additional rights,
because:
- UDP allows processes to send traffic to anyone without any `bind()` nor
  `connect()` by specifying an arbitrary address in `sendmsg()`, so
  simply using existing hooks cannot prevent sending that traffic;
- UDP allows processes to receive traffic on ephemeral ports without any
  `bind()` (e.g. just `sendmsg()` to 127.0.0.1 to get a port assigned, then
  you can `recv()` on that port).

When benchmarking `iperf3 --udp` with and without sendmsg/recvmsg
sandboxing, the difference appears negligible on my laptop, which makes
me think I'm looking at a completely unrelated bottleneck somewhere else.
Advice or tests from someone with non-potato hardware and benchmarking
knowledge would be appreciated.

Selftests updated for UDP, coverage should encompass all non-critical-error
paths.

This is a first kernel patch attempt, any feedback appreciated.

Link: https://github.com/landlock-lsm/linux/issues/10

Matthieu Buffet (7):
  samples/landlock: Fix port parsing in sandboxer
  samples/landlock: Clarify option parsing behaviour
  landlock: Add UDP bind+connect access control
  landlock: Add UDP send+recv access control
  samples/landlock: Add sandboxer UDP access control
  selftests/landlock: Adapt existing tests for UDP
  selftests/landlock: Add UDP sendmsg/recvmsg tests

 include/uapi/linux/landlock.h                |  58 ++-
 samples/landlock/sandboxer.c                 | 181 +++++--
 security/landlock/limits.h                   |   2 +-
 security/landlock/net.c                      | 255 +++++++--
 security/landlock/syscalls.c                 |   2 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/net_test.c  | 518 +++++++++++++++++--
 7 files changed, 886 insertions(+), 132 deletions(-)

-- 
2.39.5


