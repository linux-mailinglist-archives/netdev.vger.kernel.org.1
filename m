Return-Path: <netdev+bounces-167923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF19A3CDD2
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 00:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA101892F38
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 23:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2121DED5A;
	Wed, 19 Feb 2025 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UK+xFTPb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A58F1C82F4
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 23:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740009007; cv=none; b=l5jYf4FiAZwGq+96pq49inql/qPw67LW4vjCZ2407z2QBpA5LNN1BIQ4ni9/9T8V5CSOOd3uNaDh5Ee5ssNj5cpHKuVEc+nvroFuSmB+75OA2UZaGxw3gFKrHHLHqsn/sSzsTHrUb7dxhewXBayPmndD7TjM68dx22aPSQmRfoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740009007; c=relaxed/simple;
	bh=pJXYrZOSs+XUBJY304j7wzhw2pI9MnqXm9MF9047qN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lsxhN3nSOAerS3zchabYkV/VpZBlaxa5a7231uhEvfDuyb9hzAYP8Cv3GTsPjvWUSWdjQboAGOQ+LAZFiImbgmx4roW3QOmSiKbCGlbnqfnhC92a9GttIT1TNst1YbE5lQm1/rR1LCM9ItQbXKv7x87aFgLTOH3Njm3lfWQ3jCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UK+xFTPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F33C4CED1;
	Wed, 19 Feb 2025 23:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740009006;
	bh=pJXYrZOSs+XUBJY304j7wzhw2pI9MnqXm9MF9047qN0=;
	h=From:To:Cc:Subject:Date:From;
	b=UK+xFTPbMIv5cjTPh5+Vqjuj3P7D2X92WWl6+xt0Vpwb8UKAB36AMBmMGIemYqum0
	 Zotb7aNHN3xWYmqQpyLjrSw3KcuLwDOdVee70ZJ9KraijFZZeBQDpaSj2+z6o2d7or
	 2QKCxqc//arYmmBjDRPlxhlEkVgmnCmbi4ll068vm8RZ4/UYWl3fbl+P3nkfqhc+ZP
	 gH5J4NKtmiDesbPWBeSWQ735nrOKO1fIFSHvl0Gn9x1JF4vFg6RPTxojRhdQX0O6jM
	 DsQAmkIvTs+k5p3ODkrWcGdlodWJoubwERF8Uh26pcMKGyoRtWyCvoU0f8StQ8+Ldz
	 M7vT8NuPNC8BQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	stfomichev@gmail.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/7] selftests: drv-net: improve the queue test for XSK
Date: Wed, 19 Feb 2025 15:49:49 -0800
Message-ID: <20250219234956.520599-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We see some flakes in the the XSK test:

   Exception| Traceback (most recent call last):
   Exception|   File "/home/virtme/testing-18/tools/testing/selftests/net/lib/py/ksft.py", line 218, in ksft_run
   Exception|     case(*args)
   Exception|   File "/home/virtme/testing-18/tools/testing/selftests/drivers/net/./queues.py", line 53, in check_xdp
   Exception|     ksft_eq(q['xsk'], {})
   Exception| KeyError: 'xsk'

I think it's because the method or running the helper in the background
is racy. Add more solid infra for waiting for a background helper to be
initialized.

v2:
 - add patch 1, 3 and 4
 - redo patch 5
v1: https://lore.kernel.org/20250218195048.74692-1-kuba@kernel.org

Jakub Kicinski (7):
  selftests: drv-net: add a warning for bkg + shell + terminate
  selftests: drv-net: use cfg.rpath() in netlink xsk attr test
  selftests: drv-net: add missing new line in xdp_helper
  selftests: drv-net: probe for AF_XDP sockets more explicitly
  selftests: drv-net: add a way to wait for a local process
  selftests: drv-net: improve the use of ksft helpers in XSK queue test
  selftests: drv-net: rename queues check_xdp to check_xsk

 .../selftests/drivers/net/xdp_helper.c        | 63 ++++++++++++++--
 tools/testing/selftests/drivers/net/queues.py | 61 ++++++++--------
 tools/testing/selftests/net/lib/py/ksft.py    |  5 ++
 tools/testing/selftests/net/lib/py/utils.py   | 72 +++++++++++++++++--
 4 files changed, 161 insertions(+), 40 deletions(-)

-- 
2.48.1


