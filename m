Return-Path: <netdev+bounces-106721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B914B91758A
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 03:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD951C21A32
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72CD8BEF;
	Wed, 26 Jun 2024 01:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNIPQclA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833DDD51D
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 01:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719365100; cv=none; b=Jz/9wDnj64O4PS+umluZJD4bEEj+sQduNzl774T16+UZj+maWEIBbh6PPzfqgzk5Nd85Rz3X0H36NoSr5J8Q65tJ13yjxkHjs9PN4xocbjaJ8JE6NETNylZG187WI16D7m6tbtWYeZ4Y5RCprZES/9fOb4IFrNGziw3CxXYigvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719365100; c=relaxed/simple;
	bh=RW6Q3elRK4arljIJXZmd4bUFr78M/hdfKcjvXjh1YxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FOwNlKO4VLBT0D29dyp+irVQFTmakxp79UZUaUoExJMSHcFZdFkwk0+hD/DJQns/dX6dLltUxuOQIGkvaC/HF2341iZSRCBP+J22NJocVQ4prdY0bDPf9g+ftkp/0VQX38obAS9d13BB7zud8q1SbXfwtsOqkiRBaDPQQOGgzso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNIPQclA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6342C32781;
	Wed, 26 Jun 2024 01:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719365100;
	bh=RW6Q3elRK4arljIJXZmd4bUFr78M/hdfKcjvXjh1YxI=;
	h=From:To:Cc:Subject:Date:From;
	b=jNIPQclAg7kOKQ36iy780CnuaXLqPZ9QLZeQIUNnyacza8iKHoit0UKLtAjIapzOL
	 Z923AHaj5N3DEJRShmALlYlqQbSswksJw5zt5wSA7GdUR8siAPLqtfFS9s+19R1qdu
	 jjIc00QRYT+OMoz6Z/Jfle8c86vvIs7e/kN2Am3f827lsrQ53zoZvgDeQC9+EUKPM8
	 vXDM0eDe+tau8v+td0Jtjy8LOvCCXXhwkCdNzXDdFEN/jaTghWS6F3crJKzA4ynEcK
	 FqGOB1OAdGLG0OXvMgwZq04zCCx1hzqTSeiNy6U3PC0rnJgsdTsp47dd13lKr+Qpfh
	 Z0CiG7m8KOyNA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	dw@davidwei.uk,
	przemyslaw.kitszel@intel.com,
	michael.chan@broadcom.com,
	andrew.gospodarek@broadcom.com,
	leitao@debian.org,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 0/4] selftests: drv-net: rss_ctx: add tests for RSS contexts
Date: Tue, 25 Jun 2024 18:24:52 -0700
Message-ID: <20240626012456.2326192-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a few tests exercising RSS context API.
In addition to basic sanity checks, tests add RSS contexts,
n-tuple rule to direct traffic to them (based on dst port),
and qstats to make sure traffic landed where we expected.

v2 adds a test for removing contexts out of order. When testing
bnxt - either the new test or running more tests after the overlap
test makes the device act strangely. To the point where it may start
giving out ntuple IDs of 0 for all rules..

Ed, could you try the tests with your device?

  $ export NETIF=eth0 REMOTE_...
  $ ./drivers/net/hw/rss_ctx.py
  KTAP version 1
  1..8
  ok 1 rss_ctx.test_rss_key_indir
  ok 2 rss_ctx.test_rss_context
  ok 3 rss_ctx.test_rss_context4
  # Increasing queue count 44 -> 66
  # Failed to create context 32, trying to test what we got
  ok 4 rss_ctx.test_rss_context32 # SKIP Tested only 31 contexts, wanted 32
  ok 5 rss_ctx.test_rss_context_overlap
  ok 6 rss_ctx.test_rss_context_overlap2
  # .. sprays traffic like a headless chicken ..
  not ok 7 rss_ctx.test_rss_context_out_of_order
  ok 8 rss_ctx.test_rss_context4_create_with_cfg
  # Totals: pass:6 fail:1 xfail:0 xpass:0 skip:1 error:0

v2: https://lore.kernel.org/all/20240625010210.2002310-1-kuba@kernel.org
v1: https://lore.kernel.org/all/20240620232902.1343834-1-kuba@kernel.org

Jakub Kicinski (4):
  selftests: drv-net: try to check if port is in use
  selftests: drv-net: add helper to wait for HW stats to sync
  selftests: drv-net: add ability to wait for at least N packets to load
    gen
  selftests: drv-net: rss_ctx: add tests for RSS configuration and
    contexts

 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/rss_ctx.py       | 383 ++++++++++++++++++
 .../selftests/drivers/net/lib/py/env.py       |  19 +-
 .../selftests/drivers/net/lib/py/load.py      |  37 +-
 tools/testing/selftests/net/lib/py/ksft.py    |   5 +
 tools/testing/selftests/net/lib/py/utils.py   |  27 +-
 6 files changed, 457 insertions(+), 15 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_ctx.py

-- 
2.45.2


