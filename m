Return-Path: <netdev+bounces-135993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31B199FE7E
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20B6285527
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFC2158522;
	Wed, 16 Oct 2024 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlx8Ov0o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E4E156665;
	Wed, 16 Oct 2024 01:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729043429; cv=none; b=Fq1DkZasM5XPdz1Ozk52+rZkn8Wr8qEqKwVShS9VngtMqwMoRVly2qzFJw2KL8WOYxAhGkJZuVhDl6MW4T6YWNsKdVdroxafhAsvn5jWkCgOiGgPSqST9/ImkP9auJqVWBXxdyAS6xEAP8mEgVYHGAIFSX98e7V+dNHEEURGR70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729043429; c=relaxed/simple;
	bh=mm07ElCjhulSXq3WYF7H3Bml9aeL2nLx2xfXyryJgOc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JsnNUDbUT1iq0Au2j+v6fuRqIOJPr8s7GD36r6Ot6R7X0WMdF2rbMc9d1gn5WOv6GsbC20QC6i/ZSNiS8IkRXjzqIw/BGfSvsqdPhHbn5B7xIMjgq0hAcxFvJrJ6yhmVwUStcpyDyfRk0gwS90xvxrQn/j/hVsSvuDEMKwZrMLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlx8Ov0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DE3C4CEC6;
	Wed, 16 Oct 2024 01:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729043427;
	bh=mm07ElCjhulSXq3WYF7H3Bml9aeL2nLx2xfXyryJgOc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tlx8Ov0o0oq16fu0tDKUQl8uxyi9D2vq6kvKrTEeCYLdzlGrRojzP+WQhrT/z6fGT
	 c7DsurNOuAU/BFhQ8AYMEVtAbTiZOmkXRqNyMEsvMLPeu9xVvrOwSXQ94+LVTkGAa4
	 ENKPjp0f1Txs5ORhm3lsxCG2PRM7d9y0wrwO3I2N1siSqqqox/umxAFtpqzTgibztB
	 OJ2qmEXlJTrIkHUe8YfijeaNaxqFdIynF3BgONWLSQUvzzCWSkag+9JCeRRYw7RBUJ
	 inSC31nRBWCkLFaF+553jY+SKUKhBymEdjMEyTquHnAZrjdqE1DrC8ma5ulU+xw9YH
	 EvnMBaT/gLNyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1B43809A8A;
	Wed, 16 Oct 2024 01:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: microchip: vcap api: Fix memory leaks in
 vcap_api_encode_rule_test()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172904343274.1354363.4060688551856463197.git-patchwork-notify@kernel.org>
Date: Wed, 16 Oct 2024 01:50:32 +0000
References: <20241014121922.1280583-1-ruanjinjie@huawei.com>
In-Reply-To: <20241014121922.1280583-1-ruanjinjie@huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jensemil.schulzostergaard@microchip.com,
 UNGLinuxDriver@microchip.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Oct 2024 20:19:22 +0800 you wrote:
> Commit a3c1e45156ad ("net: microchip: vcap: Fix use-after-free error in
> kunit test") fixed the use-after-free error, but introduced below
> memory leaks by removing necessary vcap_free_rule(), add it to fix it.
> 
> 	unreferenced object 0xffffff80ca58b700 (size 192):
> 	  comm "kunit_try_catch", pid 1215, jiffies 4294898264
> 	  hex dump (first 32 bytes):
> 	    00 12 7a 00 05 00 00 00 0a 00 00 00 64 00 00 00  ..z.........d...
> 	    00 00 00 00 00 00 00 00 00 04 0b cc 80 ff ff ff  ................
> 	  backtrace (crc 9c09c3fe):
> 	    [<0000000052a0be73>] kmemleak_alloc+0x34/0x40
> 	    [<0000000043605459>] __kmalloc_cache_noprof+0x26c/0x2f4
> 	    [<0000000040a01b8d>] vcap_alloc_rule+0x3cc/0x9c4
> 	    [<000000003fe86110>] vcap_api_encode_rule_test+0x1ac/0x16b0
> 	    [<00000000b3595fc4>] kunit_try_run_case+0x13c/0x3ac
> 	    [<0000000010f5d2bf>] kunit_generic_run_threadfn_adapter+0x80/0xec
> 	    [<00000000c5d82c9a>] kthread+0x2e8/0x374
> 	    [<00000000f4287308>] ret_from_fork+0x10/0x20
> 	unreferenced object 0xffffff80cc0b0400 (size 64):
> 	  comm "kunit_try_catch", pid 1215, jiffies 4294898265
> 	  hex dump (first 32 bytes):
> 	    80 04 0b cc 80 ff ff ff 18 b7 58 ca 80 ff ff ff  ..........X.....
> 	    39 00 00 00 02 00 00 00 06 05 04 03 02 01 ff ff  9...............
> 	  backtrace (crc daf014e9):
> 	    [<0000000052a0be73>] kmemleak_alloc+0x34/0x40
> 	    [<0000000043605459>] __kmalloc_cache_noprof+0x26c/0x2f4
> 	    [<000000000ff63fd4>] vcap_rule_add_key+0x2cc/0x528
> 	    [<00000000dfdb1e81>] vcap_api_encode_rule_test+0x224/0x16b0
> 	    [<00000000b3595fc4>] kunit_try_run_case+0x13c/0x3ac
> 	    [<0000000010f5d2bf>] kunit_generic_run_threadfn_adapter+0x80/0xec
> 	    [<00000000c5d82c9a>] kthread+0x2e8/0x374
> 	    [<00000000f4287308>] ret_from_fork+0x10/0x20
> 	unreferenced object 0xffffff80cc0b0700 (size 64):
> 	  comm "kunit_try_catch", pid 1215, jiffies 4294898265
> 	  hex dump (first 32 bytes):
> 	    80 07 0b cc 80 ff ff ff 28 b7 58 ca 80 ff ff ff  ........(.X.....
> 	    3c 00 00 00 00 00 00 00 01 2f 03 b3 ec ff ff ff  <......../......
> 	  backtrace (crc 8d877792):
> 	    [<0000000052a0be73>] kmemleak_alloc+0x34/0x40
> 	    [<0000000043605459>] __kmalloc_cache_noprof+0x26c/0x2f4
> 	    [<000000006eadfab7>] vcap_rule_add_action+0x2d0/0x52c
> 	    [<00000000323475d1>] vcap_api_encode_rule_test+0x4d4/0x16b0
> 	    [<00000000b3595fc4>] kunit_try_run_case+0x13c/0x3ac
> 	    [<0000000010f5d2bf>] kunit_generic_run_threadfn_adapter+0x80/0xec
> 	    [<00000000c5d82c9a>] kthread+0x2e8/0x374
> 	    [<00000000f4287308>] ret_from_fork+0x10/0x20
> 	unreferenced object 0xffffff80cc0b0900 (size 64):
> 	  comm "kunit_try_catch", pid 1215, jiffies 4294898266
> 	  hex dump (first 32 bytes):
> 	    80 09 0b cc 80 ff ff ff 80 06 0b cc 80 ff ff ff  ................
> 	    7d 00 00 00 01 00 00 00 00 00 00 00 ff 00 00 00  }...............
> 	  backtrace (crc 34181e56):
> 	    [<0000000052a0be73>] kmemleak_alloc+0x34/0x40
> 	    [<0000000043605459>] __kmalloc_cache_noprof+0x26c/0x2f4
> 	    [<000000000ff63fd4>] vcap_rule_add_key+0x2cc/0x528
> 	    [<00000000991e3564>] vcap_val_rule+0xcf0/0x13e8
> 	    [<00000000fc9868e5>] vcap_api_encode_rule_test+0x678/0x16b0
> 	    [<00000000b3595fc4>] kunit_try_run_case+0x13c/0x3ac
> 	    [<0000000010f5d2bf>] kunit_generic_run_threadfn_adapter+0x80/0xec
> 	    [<00000000c5d82c9a>] kthread+0x2e8/0x374
> 	    [<00000000f4287308>] ret_from_fork+0x10/0x20
> 	unreferenced object 0xffffff80cc0b0980 (size 64):
> 	  comm "kunit_try_catch", pid 1215, jiffies 4294898266
> 	  hex dump (first 32 bytes):
> 	    18 b7 58 ca 80 ff ff ff 00 09 0b cc 80 ff ff ff  ..X.............
> 	    67 00 00 00 00 00 00 00 01 01 74 88 c0 ff ff ff  g.........t.....
> 	  backtrace (crc 275fd9be):
> 	    [<0000000052a0be73>] kmemleak_alloc+0x34/0x40
> 	    [<0000000043605459>] __kmalloc_cache_noprof+0x26c/0x2f4
> 	    [<000000000ff63fd4>] vcap_rule_add_key+0x2cc/0x528
> 	    [<000000001396a1a2>] test_add_def_fields+0xb0/0x100
> 	    [<000000006e7621f0>] vcap_val_rule+0xa98/0x13e8
> 	    [<00000000fc9868e5>] vcap_api_encode_rule_test+0x678/0x16b0
> 	    [<00000000b3595fc4>] kunit_try_run_case+0x13c/0x3ac
> 	    [<0000000010f5d2bf>] kunit_generic_run_threadfn_adapter+0x80/0xec
> 	    [<00000000c5d82c9a>] kthread+0x2e8/0x374
> 	    [<00000000f4287308>] ret_from_fork+0x10/0x20
> 	......
> 
> [...]

Here is the summary with links:
  - [net,v2] net: microchip: vcap api: Fix memory leaks in vcap_api_encode_rule_test()
    https://git.kernel.org/netdev/net/c/217a3d98d1e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



