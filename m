Return-Path: <netdev+bounces-167089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86886A38C94
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 20:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831B01893F46
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 19:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE6F22B5A3;
	Mon, 17 Feb 2025 19:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l50jy7zI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7711624F9
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739821324; cv=none; b=cw1SRoVaJAR2Io/ktzsAjbq7Ayaqnu/PXokgAyfY71XbvPKp0XX8zQssphXnaVPThyu0YwIGxWL6dd6pyz7YmI/JIGpillOuPXE/pXozK+MLs61QXzZ8Is/w+pVqasAgCUGvGPDHLzOvZb8Ir16zA9Gslk1PcqyIsZUdD8mfqoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739821324; c=relaxed/simple;
	bh=/wS6NwYDBdZNoKBWb+ldmB44MkA8M/HFlsu4DTJDbss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UGDbgna9SdsbckIObYN8KLkGoJQbntIuU9lD1efUsLIOr29doMiXvwXT7x+uQ93RK9tv0NAcW2YfENeXNvmtsXPeSN5jB7jlOp6knWt3+oYpRe98jgpQplED4vBwipi/CMTfk6feTn7uNyOVEF8uQJiwUaJ5/dyFxWqDul8xjgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l50jy7zI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7247C4CEE4;
	Mon, 17 Feb 2025 19:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739821323;
	bh=/wS6NwYDBdZNoKBWb+ldmB44MkA8M/HFlsu4DTJDbss=;
	h=From:To:Cc:Subject:Date:From;
	b=l50jy7zIcJCcU3aYedn1HQoHlkWFL3F8zhyGj2owFpbVXpo3yhcnth5o/KL0tJvNC
	 nLeu9osRb+vb4cyQag98PRkXKhWCLsg8XHW3s+w/NOEQgBf3ffFY1oL34/6mSA+QQv
	 5uZi6t+dHXtuOZsedHY9oCZ9EuwvYd/MgDWroKCdjlKeP9g7unGZRQOBk70LYVBi70
	 r1K57Z+OVgXd/wNK3gR7GxM3b29lXTr2gQw1cyLkd/Wn/uUhbMTNNKSrm4WZzLUeHN
	 P6GeUWzmmTiijpn84AngA0MP0YMDL+7aDIzvzdpXJdeA+kHr1E8qP6ymXc2aVkGbmA
	 qyPK6yW1RJKhg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	petrm@nvidia.com,
	stfomichev@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 0/4] selftests: drv-net: add a simple TSO test
Date: Mon, 17 Feb 2025 11:41:56 -0800
Message-ID: <20250217194200.3011136-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple test for exercising TSO over tunnels.

Similarly to csum test we want to iterate over ip versions.
Rework how addresses are stored in env to make this easier.

v3:
 - [patch 3] new patch
 - [patch 4] rework after new patch added
v2: https://lore.kernel.org/20250214234631.2308900-1-kuba@kernel.org
 - [patch 1] check for IP being on multiple ifcs
 - [patch 4] lower max noise
 - [patch 4] mention header overhead in the comment
 - [patch 4] fix the basic v4 TSO feature name
 - [patch 4] also run a stream with just GSO partial for tunnels
v1: https://lore.kernel.org/20250213003454.1333711-1-kuba@kernel.org

Jakub Kicinski (4):
  selftests: drv-net: resolve remote interface name
  selftests: drv-net: get detailed interface info
  selftests: drv-net: store addresses in dict indexed by ipver
  selftests: drv-net: add a simple TSO test

 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../testing/selftests/drivers/net/hw/csum.py  |  48 ++--
 .../selftests/drivers/net/hw/devmem.py        |   6 +-
 tools/testing/selftests/drivers/net/hw/tso.py | 222 ++++++++++++++++++
 .../selftests/drivers/net/lib/py/env.py       |  58 +++--
 tools/testing/selftests/drivers/net/ping.py   |  12 +-
 6 files changed, 286 insertions(+), 61 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/tso.py

-- 
2.48.1


