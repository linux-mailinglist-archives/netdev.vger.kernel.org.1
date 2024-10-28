Return-Path: <netdev+bounces-139696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFD09B3DB6
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09CEE1F21A6A
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 22:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57181EE02A;
	Mon, 28 Oct 2024 22:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJhpzlKk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904502E414
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 22:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730154406; cv=none; b=E0iZR1rHWOxalIbtPW+ERotyYyr5db+teGY3MYx2oZnQ2ET7MamDt/E3WyvkjGKhIWkT4uEj13bET6hcqv45fXcK5RLeYMjHOvud6fILuhQEluUfDj3Og0BjDuvhuD6+CDhzS+gYVH42CQthZQkopJVXan7PRoHiwqfE5PeaS1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730154406; c=relaxed/simple;
	bh=+xwynrlEDaBZ5gjSXwzNo1x3kIW76D0TjrroY36sHC4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=O6ILR7+pLovgLWwMUYN7dSSseHGujpxOHbutp/IQygH4epL+KfMZMWX8cHoBJqyM2/HtjyS/L/P/OxRDWAZvKeDos4CytaxYD98ka6O3oBel1L/ZqEjXVchsXjy60iAAL+pSV9MaknzMnVlYj3Bf0/OzKQp16uxZdvC3BD40OQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJhpzlKk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AD6C4CEC3;
	Mon, 28 Oct 2024 22:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730154406;
	bh=+xwynrlEDaBZ5gjSXwzNo1x3kIW76D0TjrroY36sHC4=;
	h=Date:From:To:Cc:Subject:From;
	b=ZJhpzlKkjsNxZq4QkaDmDQgPRC5h3q1+s2EPmNdgCkGas9WJewHFPymWiLZ3iR+7q
	 d0zgsjm+AdBuqZa8heut/zITx/GOG2g6eQfoaMfB4ObgXBSTWblHhHUvpTgx+8hZ4T
	 OhpVe0IqhnAsh8wAnU2ktKLzsEcHUpyvrbRyPcgWENRAZMV++0Rm/mGO+LCf47l5rP
	 CUevguVhAJwdA4jK7r1Nn0H7tO8UIpN5ElHDzglgJn4rqwdFOIU/BqMed1+ruV3Yta
	 ODAKhS/juoeQHsT1n/vbm0auYzRjOH8QfgLRELCjbcEE0WUbddOITenzhOzgJVUjhZ
	 l2P0WyFj7J79g==
Date: Mon, 28 Oct 2024 15:26:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: netdev@vger.kernel.org
Subject: [TEST] TCP AO tests failing with CONFIG_PROVE_RCU_LIST
Message-ID: <20241028152645.35a8be66@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Dmitry!

We just enabled CONFIG_PROVE_RCU_LIST with commit a3e4bf7f9675
("configs/debug: make sure PROVE_RCU_LIST=y takes effect")
in net-next. Looks like TCP AO tests now splat, eg:

[   42.597861][  T235] =============================
[   42.598195][  T235] WARNING: suspicious RCU usage
[   42.598452][  T235] 6.12.0-rc4-virtme #1 Not tainted
[   42.598697][  T235] -----------------------------
[   42.598959][  T235] net/ipv4/tcp_ao.c:2232 RCU-list traversed in non-reader section!!
[   42.599319][  T235] 
[   42.599319][  T235] other info that might help us debug this:
[   42.599319][  T235] 
[   42.600044][  T235] 
[   42.600044][  T235] rcu_scheduler_active = 2, debug_locks = 1
[   42.600443][  T235] 1 lock held by bench-lookups_i/235:
[   42.600734][  T235]  #0: ffff888005bd9098 (sk_lock-AF_INET6){+.+.}-{0:0}, at: do_tcp_getsockopt+0x40b/0x2fe0
[   42.601327][  T235] 
[   42.601327][  T235] stack backtrace:
[   42.601628][  T235] CPU: 2 UID: 0 PID: 235 Comm: bench-lookups_i Not tainted 6.12.0-rc4-virtme #1
[   42.602077][  T235] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   42.602605][  T235] Call Trace:
[   42.602796][  T235]  <TASK>
[   42.602930][  T235]  dump_stack_lvl+0xb0/0xd0
[   42.603178][  T235]  lockdep_rcu_suspicious+0x1ea/0x280
[   42.603426][  T235]  tcp_ao_copy_mkts_to_user+0xded/0x1050
[   42.603657][  T235]  ? __lock_acquire+0xb3f/0x1580
[   42.603917][  T235]  ? __pfx_tcp_ao_copy_mkts_to_user+0x10/0x10
[   42.604221][  T235]  ? lock_acquire.part.0+0xeb/0x330
[   42.604463][  T235]  ? __pte_offset_map_lock+0xfb/0x280
[   42.604707][  T235]  ? __pfx_lock_acquire.part.0+0x10/0x10
[   42.604947][  T235]  ? __pfx_lock_acquire.part.0+0x10/0x10
[   42.605220][  T235]  ? do_raw_spin_lock+0x131/0x270
[   42.605524][  T235]  ? __lock_acquire+0xb3f/0x1580
[   42.605796][  T235]  ? lock_acquire.part.0+0xeb/0x330
[   42.606049][  T235]  ? find_held_lock+0x2c/0x110
[   42.606300][  T235]  ? __lock_release+0x103/0x460
[   42.606545][  T235]  ? do_tcp_getsockopt+0x40b/0x2fe0
[   42.606809][  T235]  ? hlock_class+0x4e/0x130
[   42.607058][  T235]  ? mark_lock+0x38/0x3e0
[   42.607273][  T235]  ? do_tcp_getsockopt+0x10dd/0x2fe0
[   42.607508][  T235]  do_tcp_getsockopt+0x10dd/0x2fe0


https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/835822/1-bench-lookups-ipv6/stderr

