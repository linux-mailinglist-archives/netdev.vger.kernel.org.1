Return-Path: <netdev+bounces-79988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9A387C557
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 23:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33ED61F21906
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 22:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1C91FA1;
	Thu, 14 Mar 2024 22:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dw1umDvm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5899964D
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710456569; cv=none; b=Hbt/tTna+IwQEv++WrXLLIp07SJRdx/evRYAcCmeYYLn89HnwA4BV/tiawbktlvJyilReu3LHKcVyp/5pRP0iFT88iun0LVbHJi6nm3W01DfbTEZW0rNQ8A6PObd8BUsyNYIc2RBgNL80Xq30MPefUW75qpsJflxi3swHV98SoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710456569; c=relaxed/simple;
	bh=VF3L/+pFUYRX24p7qTPRcTb7bpzFEkqmei6fFdYfB7g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FnUkZQJ8l9zSnGvjgvMJkbkOurTn123YiQ7DehzIotiwi06D5PzhK7jGAqFO0Riz8fMIZsj4RsAIlubo1lR7cv/h0KYhkVFGSgphvnSaYMoDUARAlISZVtf5197ItzZLd/9ty82suTP/6u473e18TjuncsX9SwmzhjmTT3mFIsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=dw1umDvm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B61CC433F1;
	Thu, 14 Mar 2024 22:49:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dw1umDvm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1710456566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8BtLTHKOyS6ra9gecYbFDaUKk3XkvXJCQ15PvLLPeAA=;
	b=dw1umDvmD6XPVjronqjrzOHj3fsIoGKQfBgIMKzfvwET3heQ14pYtM77BL8EqiMlk8ApxH
	IR1N8HxaY6GiZwyeRxN1aJtL6Pyis5+BG/nm2Qkf9Kh0Ow4PprTXE+SVpzXfrOh0O43dc3
	lmiqoK2AtnXFqFdUmKqD+pIw+6C7rdA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cd2dd637 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Mar 2024 22:49:26 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org
Subject: [PATCH net 0/6] wireguard fixes for 6.9-rc1
Date: Thu, 14 Mar 2024 16:49:05 -0600
Message-ID: <20240314224911.6653-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey netdev,

This series has four WireGuard fixes:

1) Annotate a data race that KCSAN found by using READ_ONCE/WRITE_ONCE,
   which has been causing syzkaller noise.

2) Use the generic netdev tstats allocation and stats getters instead of
   doing this within the driver.

3) Explicitly check a flag variable instead of an empty list in the
   netlink code, to prevent a UaF situation when paging through GET
   results during a remove-all SET operation.

4) Set a flag in the RISC-V CI config so the selftests continue to boot.

Please apply these!

Thanks,
Jason


Breno Leitao (2):
  wireguard: device: leverage core stats allocator
  wireguard: device: remove generic .ndo_get_stats64

Jason A. Donenfeld (3):
  wireguard: netlink: check for dangling peer via is_dead instead of
    empty list
  wireguard: netlink: access device through ctx instead of peer
  wireguard: selftests: set RISCV_ISA_FALLBACK on riscv{32,64}

Nikita Zhandarovich (1):
  wireguard: receive: annotate data-race around
    receiving_counter.counter

 drivers/net/wireguard/device.c                        | 11 ++---------
 drivers/net/wireguard/netlink.c                       | 10 +++++-----
 drivers/net/wireguard/receive.c                       |  6 +++---
 .../selftests/wireguard/qemu/arch/riscv32.config      |  1 +
 .../selftests/wireguard/qemu/arch/riscv64.config      |  1 +
 5 files changed, 12 insertions(+), 17 deletions(-)

-- 
2.44.0


