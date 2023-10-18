Return-Path: <netdev+bounces-42359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB93E7CE738
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 20:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0B91F221E6
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 18:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4112E42BE3;
	Wed, 18 Oct 2023 18:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2fabzfQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F033B2AE
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 18:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7210BC433C8;
	Wed, 18 Oct 2023 18:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697655155;
	bh=0dIQ/gAybuCcQehKEtt6P/pIePD9JqS3NZyzeFwG+CQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f2fabzfQBdKMfHCySwfPrw+bumY2rE05Dc5s5Z/dLfoG0LLRCCnpYQLhiT3unmI/N
	 kWA4eeOC639eutASh9NNNd1I52WMdZAt7FcopSbrNjk77vBQgVOGqc2Zm5r6OeMIFf
	 qZhVcxdCXvYai3Zc63gWxBBXdYGgGw4FJz11gT5+mUDknsQ5e40IX+vNU/NbfkKs3R
	 PPj/ZSfAkKdEy57sWANmeg9j2qSvIZVqU7kePTb9Otzm/MEFCDAOa3i7mSn3M1P6i5
	 JHrofScHknVWcoxnXT2KZvMjYZ+xc/j8fCXncXtMkYG2GLpOxqJ9mU0tAjOLcwUgCt
	 Y/oUg1nMaIk7A==
Date: Wed, 18 Oct 2023 11:52:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Wheeler <netdev@lists.ewheeler.net>
Cc: netdev@vger.kernel.org, drbd-dev@lists.linbit.com, Philipp Reisner
 <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>,
 Christoph =?UTF-8?B?QsO2aG13YWxkZXI=?= <christoph.boehmwalder@linbit.com>
Subject: Re: BUG: looking up invalid subclass: 8
Message-ID: <20231018115234.42070e51@kernel.org>
In-Reply-To: <44d7fba4-3887-50ff-3dd1-3ca39164e6a@ewheeler.net>
References: <cea84b66-2ad5-76af-3feb-418b78cdd87@ewheeler.net>
	<20231017170900.62f951cd@kernel.org>
	<44d7fba4-3887-50ff-3dd1-3ca39164e6a@ewheeler.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Oct 2023 11:44:43 -0700 (PDT) Eric Wheeler wrote:
> Here it is from two different hosts.
> 
> This is vanilla v6.5.7:
> 
> Oct 16 09:48:47 hv1.ewheeler.net kernel: BUG: looking up invalid subclass: 8
> Oct 16 09:48:47 hv1.ewheeler.net kernel: turning off the locking correctness validator.
> Oct 16 09:48:47 hv1.ewheeler.net kernel: CPU: 8 PID: 13275 Comm: drbdsetup-84 Tainted: G            E      6.5.7 #23
> Oct 16 09:48:47 hv1.ewheeler.net kernel: Hardware name: Supermicro Super Server/H11SSL-i, BIOS 2.4 12/27/2021
> Oct 16 09:48:47 hv1.ewheeler.net kernel: Call Trace:
> Oct 16 09:48:47 hv1.ewheeler.net kernel: <TASK>
> Oct 16 09:48:47 hv1.ewheeler.net kernel: dump_stack_lvl+0x60/0xa0
> Oct 16 09:48:47 hv1.ewheeler.net kernel: look_up_lock_class+0x10b/0x150
> Oct 16 09:48:47 hv1.ewheeler.net kernel: register_lock_class+0x48/0x500
> Oct 16 09:48:47 hv1.ewheeler.net kernel: ? srso_return_thunk+0x5/0x10
> Oct 16 09:48:47 hv1.ewheeler.net kernel: __lock_acquire+0x5f/0xb80
> Oct 16 09:48:47 hv1.ewheeler.net kernel: lock_acquire.part.0+0x90/0x210
> Oct 16 09:48:47 hv1.ewheeler.net kernel: ? lock_all_resources+0x5a/0x90 [drbd]
> Oct 16 09:48:47 hv1.ewheeler.net kernel: ? lock_all_resources+0x5a/0x90 [drbd]
> Oct 16 09:48:47 hv1.ewheeler.net kernel: ? srso_return_thunk+0x5/0x10
> Oct 16 09:48:47 hv1.ewheeler.net kernel: ? lock_acquire+0x10b/0x120
> Oct 16 09:48:47 hv1.ewheeler.net kernel: ? lock_all_resources+0x5a/0x90 [drbd]
> Oct 16 09:48:47 hv1.ewheeler.net kernel: _raw_spin_lock_nested+0x33/0x80
> Oct 16 09:48:47 hv1.ewheeler.net kernel: ? lock_all_resources+0x5a/0x90 [drbd]
> Oct 16 09:48:47 hv1.ewheeler.net kernel: lock_all_resources+0x5a/0x90 [drbd]
> Oct 16 09:48:47 hv1.ewheeler.net kernel: drbd_adm_attach+0x748/0x1340 [drbd]


Oh, that's much clearer, thank you.
The warnings comes from DRBD, genl is just the entry point.
Adding DRBD folks.

> Oct 16 09:48:47 hv1.ewheeler.net kernel: ? __nla_validate_parse+0x13f/0x1f0
> Oct 16 09:48:47 hv1.ewheeler.net kernel: genl_family_rcv_msg_doit.isra.0+0xe4/0x150
> Oct 16 09:48:47 hv1.ewheeler.net kernel: genl_family_rcv_msg+0x187/0x260
> Oct 16 09:48:47 hv1.ewheeler.net kernel: ? __pfx_drbd_adm_attach+0x10/0x10 [drbd]
> Oct 16 09:48:47 hv1.ewheeler.net kernel: genl_rcv_msg+0x4b/0xb0
> Oct 16 09:48:47 hv1.ewheeler.net kernel: ? __pfx_genl_rcv_msg+0x10/0x10
> Oct 16 09:48:47 hv1.ewheeler.net kernel: netlink_rcv_skb+0x66/0x120
> Oct 16 09:48:47 hv1.ewheeler.net kernel: genl_rcv+0x28/0x40
> Oct 16 09:48:47 hv1.ewheeler.net kernel: netlink_unicast+0x1b8/0x280
> Oct 16 09:48:47 hv1.ewheeler.net kernel: netlink_sendmsg+0x273/0x520
> Oct 16 09:48:47 hv1.ewheeler.net kernel: sock_write_iter+0x188/0x190
> Oct 16 09:48:47 hv1.ewheeler.net kernel: vfs_write+0x3e5/0x520
> Oct 16 09:48:47 hv1.ewheeler.net kernel: ksys_write+0xc8/0x100
> Oct 16 09:48:47 hv1.ewheeler.net kernel: do_syscall_64+0x3f/0xa0
> Oct 16 09:48:47 hv1.ewheeler.net kernel: entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> Oct 16 09:48:47 hv1.ewheeler.net kernel: RIP: 0033:0x7f41c473e987
> Oct 16 09:48:47 hv1.ewheeler.net kernel: Code: 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> Oct 16 09:48:47 hv1.ewheeler.net kernel: RSP: 002b:00007ffe80a28648 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> Oct 16 09:48:47 hv1.ewheeler.net kernel: RAX: ffffffffffffffda RBX: 00000000000000c8 RCX: 00007f41c473e987
> Oct 16 09:48:47 hv1.ewheeler.net kernel: RDX: 00000000000000c8 RSI: 000055be8e4f7320 RDI: 0000000000000004
> Oct 16 09:48:47 hv1.ewheeler.net kernel: RBP: 000055be8e4f7320 R08: 0000000000000000 R09: 0000000000000000
> Oct 16 09:48:47 hv1.ewheeler.net kernel: R10: 0000000000001000 R11: 0000000000000246 R12: 00000000000000c8
> Oct 16 09:48:47 hv1.ewheeler.net kernel: R13: 0000000000000004 R14: 00007ffe80a28970 R15: 000055be8d383848
> Oct 16 09:48:47 hv1.ewheeler.net kernel: </TASK>

