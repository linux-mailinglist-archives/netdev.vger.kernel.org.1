Return-Path: <netdev+bounces-106297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1DB915B72
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 03:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6201C216F3
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63320125C0;
	Tue, 25 Jun 2024 01:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNusdkMj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8A01095B
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719277336; cv=none; b=UrbFdNGcLQeq0ux27rXQS57AsVdfTpcYIbwne3HzsGdMXETU2e7nJ2bv8nKZnL8kqsf2/t/UEV06ZDa+p3/k2Ah7MssVLJ8qDHuVR4g+d9slqKcFEkecwtP6FUvGFywCVNNKP+HAi9Y2VkwIC8JxPnmjyI40e3j41I6dwjVrc1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719277336; c=relaxed/simple;
	bh=VGJV5HnG9eJGfEry9+OBeY7UDiY3/8fCjm4sRzUqQ2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VtolenrP4OuEU46F0S+g5HR3V8Z2iHem2Vj4qm1oI1HKcDh7SfCN6erjjW95y9b7QdzZ1IUEYxjX29qnxo75Jhk1sY5rvOTXPxb80NEu1OXZW7XDwQISz+G+QXwX981RxaVjan4H6PvjukWJWC3u6WdRUQ6Ab0hwFH90aGxrTC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNusdkMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65624C2BBFC;
	Tue, 25 Jun 2024 01:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719277335;
	bh=VGJV5HnG9eJGfEry9+OBeY7UDiY3/8fCjm4sRzUqQ2g=;
	h=From:To:Cc:Subject:Date:From;
	b=kNusdkMjFVMMgiWtmrOHu9dz36PSiGJosVj/yqt8LZjHPwxtaOFFcn7pun4pjP4l4
	 y13vlN893Xd4OGZbmWTTf5dRVNHEwqqC54LfAmPi/4fCX8mzcf7CpPQ/zU97vTa7QF
	 yG3iK9IKLbQNpZWqLr1rS3HMY83DJyl3CTVupRe7ZQe/PDK4lIkivxWcRk6x+O3zDa
	 wLVUkjNAZuMH0ZS+gg9hlKwE/pAZMY979ZCwo3NH1A2UvCqwnkBhXUpfbsUsj2mWYR
	 IOJj3447HgV0VJWXd6XPiLSEuVHZ1PF78IAMGVa7H7RyXHrHcQi/L/ThtPfWfSTaZh
	 H4A8ds5ONL8yw==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/4] selftests: drv-net: rss_ctx: add tests for RSS contexts
Date: Mon, 24 Jun 2024 18:02:06 -0700
Message-ID: <20240625010210.2002310-1-kuba@kernel.org>
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
giving out ntuple IDs of 0 for all rules :S

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

Jakub Kicinski (4):
  selftests: drv-net: try to check if port is in use
  selftests: drv-net: add helper to wait for HW stats to sync
  selftests: drv-net: add ability to wait for at least N packets to load
    gen
  selftests: drv-net: rss_ctx: add tests for RSS configuration and
    contexts

 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/rss_ctx.py       | 383 ++++++++++++++++++
 .../selftests/drivers/net/lib/py/env.py       |  20 +-
 .../selftests/drivers/net/lib/py/load.py      |  37 +-
 tools/testing/selftests/net/lib/py/ksft.py    |   5 +
 tools/testing/selftests/net/lib/py/utils.py   |  26 +-
 6 files changed, 457 insertions(+), 15 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_ctx.py

-- 
2.45.2


