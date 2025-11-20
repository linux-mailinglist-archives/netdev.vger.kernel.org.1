Return-Path: <netdev+bounces-240430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9D5C75006
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5E504ED8E7
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 15:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACE6362144;
	Thu, 20 Nov 2025 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlJcpGKB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6929C3612ED;
	Thu, 20 Nov 2025 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651837; cv=none; b=hbrWk91Puxj59laMcwAW5GEaRaE8u1tO/CBIr4gfPZqZPolT3Y61J2KBEJAHRHXihf2vHaLW+gQURJzULUyT3wxYTutntAEVIHQl47QTXgTgM2R3g0cY5/1F9hz9/5geFsQpiNaIktWXx27qkqiztAPIluWoVIufhwkRzA5+PYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651837; c=relaxed/simple;
	bh=0XkeEI6EtugL+gxBeZZYjRHFjTbVod/dVJdkyoFZesQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=juMMuDdAJ6ryrDQl3782Lb8yav8YGTxVnqpJfeCmR2exvWpj+Ij5naiG0NhFJeVMipiohtOwUx06+AhsElwmjQ2r6a9vM/17pAnVNp1Aro+GO+grpRDePii/p2inBUxnqnffrIeCnj789ZDjKubmyisC5a3b8ZckNxTaC8+Wlcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlJcpGKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C63BC4CEF1;
	Thu, 20 Nov 2025 15:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763651836;
	bh=0XkeEI6EtugL+gxBeZZYjRHFjTbVod/dVJdkyoFZesQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mlJcpGKBUdMDhbcuoqlJJC6B5wxHmWnnowVJH2Rv+4L5WnJfAJiX7cui/1Ntah8Ce
	 0Rbg5Zt6fz1w3nlvF6y19tBFIRmMhgiJzfAgm76baqoG3itGImarKzpT8S8Zqt6+7o
	 M0tVvLEhCkK8QxuL1ny4BJu1a1t80y0YMMR4CueBZc4T6i2PiRkN+ElEutfkqVw2QE
	 NZhgeEGPvkvGvI3DlEuK1MeqfLUNktCxCTsq0y1Kvxbcw4NIBv4FYFiuwWrChHHYfs
	 LigZ0A1MDqMUwzBSc6VoTCw3PnqZqQMeSrpLhl5Ohxc4f++LltQS9r2EBd7K9JpWmn
	 OBJ1UDnkU4fMQ==
Date: Thu, 20 Nov 2025 07:17:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, kuniyu@google.com,
 skhawaja@google.com, aleksander.lobakin@intel.com, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH net-next v5 0/2] net: Split ndo_set_rx_mode into
 snapshot
Message-ID: <20251120071715.28a47b21@kernel.org>
In-Reply-To: <20251120141354.355059-1-viswanathiyyappan@gmail.com>
References: <20251120141354.355059-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Nov 2025 19:43:52 +0530 I Viswanath wrote:
> Teardown path:
> 
> Relevant as they flush the work item. ens4 is the virtio-net interface.
> 
> virtnet_remove:
> ip maddr add 01:00:5e:00:03:02 dev ens4; echo 1 > /sys/bus/pci/devices/0000:00:04.0/remove
> 
> virtnet_freeze_down:
> ip maddr add 01:00:5e:00:03:02 dev ens4; echo mem > /sys/power/state

Running 

make -C tools/testing/selftests TARGETS="drivers/net/virtio_net" run_tests

[    1.967073] BUG: kernel NULL pointer dereference, address: 0000000000000018
[    1.967179] #PF: supervisor read access in kernel mode
[    1.967237] #PF: error_code(0x0000) - not-present page
[    1.967296] PGD 0 P4D 0 
[    1.967327] Oops: Oops: 0000 [#1] SMP
[    1.967372] CPU: 2 UID: 0 PID: 220 Comm: basic_features. Not tainted 6.18.0-rc5-virtme #1 PREEMPT(voluntary) 
[    1.967500] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[    1.967576] RIP: 0010:__flush_work+0x33/0x3a0
[    1.967651] Code: 41 55 41 54 55 53 48 83 ec 60 44 0f b6 25 0d ab 91 01 65 48 8b 05 2d ff 8d 01 48 89 44 24 58 31 c0 45 84 e4 0f 84 35 03 00 00 <48> 83 7f 18 00 48 89 fd 0f 84 30 03 00 00 41 89 f5 e8 07 24 07 00
[    1.967861] RSP: 0018:ffffab9bc0597cf0 EFLAGS: 00010202
[    1.967920] RAX: 0000000000000000 RBX: ffff9d08c2c549c0 RCX: ffffab9bc0597d28
[    1.968010] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    1.968100] RBP: ffff9d08c1cd5000 R08: ffff9d08c1db7b70 R09: 0000000000000000
[    1.968189] R10: ffff9d08c1db7f80 R11: ffff9d08c152e480 R12: 0000000000000001
[    1.968281] R13: ffffffffbd9ffe00 R14: ffff9d08c193e140 R15: 0000000000000008
[    1.968371] FS:  00007fb66173b000(0000) GS:ffff9d0940ce9000(0000) knlGS:0000000000000000
[    1.968472] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.968546] CR2: 0000000000000018 CR3: 00000000045e5006 CR4: 0000000000772ef0
[    1.968640] PKRU: 55555554
[    1.968669] Call Trace:
[    1.968700]  <TASK>
[    1.968729]  ? kernfs_should_drain_open_files+0x2e/0x40
[    1.968796]  ? __rtnl_unlock+0x37/0x60
[    1.968849]  ? netdev_run_todo+0x63/0x550
[    1.968894]  ? kernfs_name_hash+0x12/0x80
[    1.968938]  virtnet_remove+0x65/0xb0
[    1.968984]  virtio_dev_remove+0x3c/0x80
[    1.969029]  device_release_driver_internal+0x193/0x200
[    1.969090]  unbind_store+0x9d/0xb0
[    1.969136]  kernfs_fop_write_iter+0x12b/0x1c0
[    1.969197]  vfs_write+0x33a/0x470
[    1.969242]  ksys_write+0x65/0xe0
[    1.969287]  do_syscall_64+0xa4/0xfd0
[    1.969333]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[    1.969393] RIP: 0033:0x7fb66183b257
[    1.969434] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[    1.969640] RSP: 002b:00007fffca552fe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[    1.969729] RAX: ffffffffffffffda RBX: 00007fb661937780 RCX: 00007fb66183b257
[    1.969820] RDX: 0000000000000008 RSI: 0000558903e5a280 RDI: 0000000000000001
[    1.969911] RBP: 0000000000000008 R08: 0000000000000003 R09: 0000000000000077
[    1.970004] R10: 0000000000000063 R11: 0000000000000246 R12: 0000000000000008
[    1.970096] R13: 0000558903e5a280 R14: 0000000000000008 R15: 00007fb6619329c0
[    1.970189]  </TASK>
[    1.970218] Modules linked in:
[    1.970266] CR2: 0000000000000018
[    1.970311] ---[ end trace 0000000000000000 ]---
[    1.970372] RIP: 0010:__flush_work+0x33/0x3a0
[    1.970441] Code: 41 55 41 54 55 53 48 83 ec 60 44 0f b6 25 0d ab 91 01 65 48 8b 05 2d ff 8d 01 48 89 44 24 58 31 c0 45 84 e4 0f 84 35 03 00 00 <48> 83 7f 18 00 48 89 fd 0f 84 30 03 00 00 41 89 f5 e8 07 24 07 00
[    1.970656] RSP: 0018:ffffab9bc0597cf0 EFLAGS: 00010202
[    1.970717] RAX: 0000000000000000 RBX: ffff9d08c2c549c0 RCX: ffffab9bc0597d28
[    1.970806] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    1.970897] RBP: ffff9d08c1cd5000 R08: ffff9d08c1db7b70 R09: 0000000000000000
[    1.970988] R10: ffff9d08c1db7f80 R11: ffff9d08c152e480 R12: 0000000000000001
[    1.971081] R13: ffffffffbd9ffe00 R14: ffff9d08c193e140 R15: 0000000000000008
[    1.971174] FS:  00007fb66173b000(0000) GS:ffff9d0940ce9000(0000) knlGS:0000000000000000
[    1.971264] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.971337] CR2: 0000000000000018 CR3: 00000000045e5006 CR4: 0000000000772ef0
[    1.971431] PKRU: 55555554
[    1.971460] note: basic_features.[220] exited with irqs disabled
-- 
pw-bot: cr

