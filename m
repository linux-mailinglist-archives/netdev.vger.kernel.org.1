Return-Path: <netdev+bounces-105484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537449116B7
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 01:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCF29B2161D
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 23:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632F27CF39;
	Thu, 20 Jun 2024 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhOqUWVO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2D443ABC
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718926153; cv=none; b=OO2xuNLIEt596KmGVU3JDKhAoKWCceV4NNU/SA1oUMQ9mVxePftZvSyHv4WSSvxG+XjLlcl9qe+UGF76h1QLYvZcQvF9CgDEPvdKPyy3TdlK9KU862s5CK4k1GKuth/0iYUL86tyTKrimoxa4j04fqel+21XRe4HA29yHxGyp3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718926153; c=relaxed/simple;
	bh=PuhMuVDlce06RRllFv7knwAbRBS9a6jyymX9l0eowkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rkK4769NQR5LRCfJoPIQZvFxelRfi9FFz7QndD7RzTsaB1OuxvZ02SbGFJv0xD81PRqmwcsjRq/IcOH5b8HTnOOUInjT8nRN6Q29OAhBaGt3pvIG6WH1tPljae/128AlcjHz2rnWKJ/zSimzfPG6FZ7fLr/2GxcpKXNBkbp6Rzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhOqUWVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B7FC2BD10;
	Thu, 20 Jun 2024 23:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718926152;
	bh=PuhMuVDlce06RRllFv7knwAbRBS9a6jyymX9l0eowkM=;
	h=From:To:Cc:Subject:Date:From;
	b=lhOqUWVO/ynFqM8hNdJg5QeKuj63r8ApWWHt9wqU3Tw55H8VLdETnZB+weCMCVOEg
	 oIlEXP9oXvjiML29LCQrzXTKORGlpvPbfrl0GVTbFHZpq0NBebqDLztC6ohvdMnUGj
	 nKEnNU22DI81VQrpbVXHz6qszm0tl0h0amkgxf6rpfxiiB0DMcwtxftc+45KUSpuu/
	 uIGXR1UWKISp3eiDdGJ8u9JsQoZC3nndTYGAXMm4BiHUhg5kfMN95RaxB9OzuBtUHr
	 I0Rai1VQ/wzZDhdxA6UZVXWqLPAJPx/ltWtfo03xNv5ibSE2ewgaWxCDYMmiBSBUv/
	 +BPPj60QF2gdw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/4] selftests: drv-net: rss_ctx: add tests for RSS contexts
Date: Thu, 20 Jun 2024 16:28:57 -0700
Message-ID: <20240620232902.1343834-1-kuba@kernel.org>
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

  $ ./drivers/net/hw/rss_ctx.py
  KTAP version 1
  1..6
  ok 1 rss_ctx.test_rss_key_indir
  ok 2 rss_ctx.test_rss_context
  ok 3 rss_ctx.test_rss_context4
  # Increasing queue count 44 -> 66
  # Failed to create context 32, trying to test what we got
  ok 4 rss_ctx.test_rss_context32 # SKIP Tested only 31 contexts, wanted 32
  ok 5 rss_ctx.test_rss_context_overlap
  ok 6 rss_ctx.test_rss_context_overlap2
  # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:1 error:0

Jakub Kicinski (4):
  selftests: drv-net: try to check if port is in use
  selftests: drv-net: add helper to wait for HW stats to sync
  selftests: drv-net: add ability to wait for at least N packets to load
    gen
  selftests: drv-net: rss_ctx: add tests for RSS configuration and
    contexts

 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/rss_ctx.py       | 243 ++++++++++++++++++
 .../selftests/drivers/net/lib/py/env.py       |  21 +-
 .../selftests/drivers/net/lib/py/load.py      |  33 ++-
 tools/testing/selftests/net/lib/py/ksft.py    |   5 +
 tools/testing/selftests/net/lib/py/utils.py   |  25 +-
 6 files changed, 314 insertions(+), 14 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_ctx.py

-- 
2.45.2


