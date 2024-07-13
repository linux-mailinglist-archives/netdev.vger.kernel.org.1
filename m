Return-Path: <netdev+bounces-111176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2E69302F1
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 03:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A784D1C210BF
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 01:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5816F8BE0;
	Sat, 13 Jul 2024 01:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLrM5D48"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316ED4C6E
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720833032; cv=none; b=b18F38eC2mW3o22o8npx6I0VKCaDzGHl8TcIK4q3svf+RvtJ+H69iyj/ArvvHRewFJush2XwxpNz3iJXHRfdPfxzS8ASyfCtQvk2tBmV3o59ecmnnFJxjkDRwHX/gWfNnkrUa7fD3iePnayL7quZtgi6zun5b7ncWNEcDxM+JqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720833032; c=relaxed/simple;
	bh=XF5QVXWuEk1EoOj+cTSH2LmVsMKdzRwj7e5tLnEHnMc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QKLmkVsNRuUpeOb2td6tBqUledgYqnTVxN+6cRzeAwZ70dSpibJuuZN0N8FPvmcPj9aP+WNkg5lRZLGwp6ePjelGWsD7EwFNVPiaDBqk6/ywA/asaVRVaCiNkSD2AFjcQATWEuqtjKiw9WVm9Pz0bLX2Or3ZpL9ttFJPWGZftVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLrM5D48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1F24C4AF07;
	Sat, 13 Jul 2024 01:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720833031;
	bh=XF5QVXWuEk1EoOj+cTSH2LmVsMKdzRwj7e5tLnEHnMc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eLrM5D48pTNdNT5xJyifGtHVNhT5N9WjXsmBiWXmErd7c4dKOg3ZUDr5XzTPImwaV
	 CydNGZhK8OuBlm5Wgt5ONWMhKHdxVqxo4Lx4gIVehqVKTuqf94OpLP2lDHnY6fwbzO
	 yJA4T5k1DXEcESgG77mxs99quet0Z2VYHE3QPT7zmlxUqrgj2L7V3rmfQUP4dILaYt
	 guzM6GfyO4al6fphnSbXkdK10rjIYYeo6w6czvgzAYF2VYcI7O1wEXIcdBNfqv5hix
	 WGQ4+xylRUwAtcY3JESQBvmkLi03c6pI8+7s2Qa8ib2jdr3smABKXJdZuW5GlcMuzx
	 2CFCWEEF8DLkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9563DDAE95C;
	Sat, 13 Jul 2024 01:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnxt_en: Fix crash in bnxt_get_max_rss_ctx_ring()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172083303160.3780.17657565730244077368.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jul 2024 01:10:31 +0000
References: <20240712175318.166811-1-michael.chan@broadcom.com>
In-Reply-To: <20240712175318.166811-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, leitao@debian.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jul 2024 10:53:18 -0700 you wrote:
> On older chips not supporting multiple RSS contexts, reducing
> ethtool channels will crash:
> 
> BUG: kernel NULL pointer dereference, address: 00000000000000b8
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> CPU: 1 PID: 7032 Comm: ethtool Tainted: G S                 6.10.0-rc4 #1
> Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.4.3 01/17/2017
> RIP: 0010:bnxt_get_max_rss_ctx_ring+0x4c/0x90 [bnxt_en]
> Code: c3 d3 eb 4c 8b 83 38 01 00 00 48 8d bb 38 01 00 00 4c 39 c7 74 42 41 8d 54 24 ff 31 c0 0f b7 d2 4c 8d 4c 12 02 66 85 ed 74 1d <49> 8b 90 b8 00 00 00 49 8d 34 11 0f b7 0a 66 39 c8 0f 42 c1 48 83
> RSP: 0018:ffffaaa501d23ba8 EFLAGS: 00010202
> RAX: 0000000000000000 RBX: ffff8efdf600c940 RCX: 0000000000000000
> RDX: 000000000000007f RSI: ffffffffacf429c4 RDI: ffff8efdf600ca78
> RBP: 0000000000000080 R08: 0000000000000000 R09: 0000000000000100
> R10: 0000000000000001 R11: ffffaaa501d238c0 R12: 0000000000000080
> R13: 0000000000000000 R14: ffff8efdf600c000 R15: 0000000000000006
> FS:  00007f977a7d2740(0000) GS:ffff8f041f840000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000000b8 CR3: 00000002320aa004 CR4: 00000000003706f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <TASK>
> ? __die_body+0x15/0x60
> ? page_fault_oops+0x157/0x440
> ? do_user_addr_fault+0x60/0x770
> ? _raw_spin_lock_irqsave+0x12/0x40
> ? exc_page_fault+0x61/0x120
> ? asm_exc_page_fault+0x22/0x30
> ? bnxt_get_max_rss_ctx_ring+0x4c/0x90 [bnxt_en]
> ? bnxt_get_max_rss_ctx_ring+0x25/0x90 [bnxt_en]
> bnxt_set_channels+0x9d/0x340 [bnxt_en]
> ethtool_set_channels+0x14b/0x210
> __dev_ethtool+0xdf8/0x2890
> ? preempt_count_add+0x6a/0xa0
> ? percpu_counter_add_batch+0x23/0x90
> ? filemap_map_pages+0x417/0x4a0
> ? avc_has_extended_perms+0x185/0x420
> ? __pfx_udp_ioctl+0x10/0x10
> ? sk_ioctl+0x55/0xf0
> ? kmalloc_trace_noprof+0xe0/0x210
> ? dev_ethtool+0x54/0x170
> dev_ethtool+0xa2/0x170
> dev_ioctl+0xbe/0x530
> sock_do_ioctl+0xa3/0xf0
> sock_ioctl+0x20d/0x2e0
> 
> [...]

Here is the summary with links:
  - [net] bnxt_en: Fix crash in bnxt_get_max_rss_ctx_ring()
    https://git.kernel.org/netdev/net/c/f7ce5eb2cb79

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



