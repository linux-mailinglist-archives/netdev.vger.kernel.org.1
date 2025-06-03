Return-Path: <netdev+bounces-194708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DF9ACC05D
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 08:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A409189104A
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 06:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A6F2036FA;
	Tue,  3 Jun 2025 06:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRgvZ4d1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2F04A1E
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 06:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748932891; cv=none; b=TEvvO/p+Qj8onnoX/Y5EV0pAI8UFet2Xcy4XH8oEKO+cOsNzMMFRCzDpiZZc3yFsAFYV7uho1gWXoRlMrODLA2Tqbq21TzPpBQ75InoVT6orBmjeQG88iXZKWSI/RqAFPWzLVsUVcVFBnNO6u1UsGOABJ/2Yjj7kpJzDIv1qk0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748932891; c=relaxed/simple;
	bh=GQ0KoW3gILOiQuVTO7zMZt8CNKX3BOBX/Ot6/uvcURM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvBkXwOZh40NkyOqQXq8+BK4fCFALImjXT5EiFVPzupWlglx492Bi78YW8LuIT9vnUxcAFaBbhXf8aG3+b1L9pXY7Hr/cD3uxbe4SHkP4nqCagTK/kzKB1GqqtSeIs1cR/i/3cOaTueeC1e2W4JN8lrpoi9VyVaMa8+Dq/QTD6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SRgvZ4d1; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748932890; x=1780468890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GQ0KoW3gILOiQuVTO7zMZt8CNKX3BOBX/Ot6/uvcURM=;
  b=SRgvZ4d130FPPZQ8yhtiggETU29a0wmeDke4sI38JtpHH0ovKZxQ5s1B
   4RuCq/vSpG6kmJnkjGG+6vvZ4bEiEirnFVZHZd1J8DVp9FShHvSIVS2vh
   RT3RluFJIarPrBtRDafSN8E8ti3tKpVm3T7B4vAuILuLthzETqyiOg2j+
   7w8Z7e9f7MavGklv6BWXBzupIE8hkLiUF+MxDeYF4vf8s2AYM/f4AuHH+
   FScFAWgJ2FCOdbtKIW/3MV1Q2Lqy4Ldy0R8s7LN4mF9F2mUlhg576qfhe
   tivekvUDfmnYWTKABslRrGJXxwT2kennGgipXCur0G3pys3HDreOFEf9J
   A==;
X-CSE-ConnectionGUID: P42DPm2HRKyKi1OGUZIsAg==
X-CSE-MsgGUID: nJioAK+pT8C7S2jel4fRBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="38585998"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="38585998"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 23:41:29 -0700
X-CSE-ConnectionGUID: YNvm0julRNOFCFuXCsd3Yw==
X-CSE-MsgGUID: Z4A6U+lJTfiUICA73IcYxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="148625595"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 23:41:27 -0700
Date: Tue, 3 Jun 2025 08:40:45 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Oleksandr Natalenko <oleksandr@natalenko.name>,
	Qingfang Deng <dqfext@gmail.com>,
	Gert Doering <gert@greenie.muc.de>
Subject: Re: [PATCH net 2/5] ovpn: ensure sk is still valid during cleanup
Message-ID: <aD6Y7b8xnObUjeJn@mev-dev.igk.intel.com>
References: <20250530101254.24044-1-antonio@openvpn.net>
 <20250530101254.24044-3-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530101254.24044-3-antonio@openvpn.net>

On Fri, May 30, 2025 at 12:12:51PM +0200, Antonio Quartulli wrote:
> Removing a peer while userspace attempts to close its transport
> socket triggers a race condition resulting in the following
> crash:
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000077: 0000 [#1] SMP KASAN
> KASAN: null-ptr-deref in range [0x00000000000003b8-0x00000000000003bf]
> CPU: 12 UID: 0 PID: 162 Comm: kworker/12:1 Tainted: G           O        6.15.0-rc2-00635-g521139ac3840 #272 PREEMPT(full)
> Tainted: [O]=OOT_MODULE
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-20240910_120124-localhost 04/01/2014
> Workqueue: events ovpn_peer_keepalive_work [ovpn]
> RIP: 0010:ovpn_socket_release+0x23c/0x500 [ovpn]
> Code: ea 03 80 3c 02 00 0f 85 71 02 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 64 24 18 49 8d bc 24 be 03 00 00 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 30
> RSP: 0018:ffffc90000c9fb18 EFLAGS: 00010217
> RAX: dffffc0000000000 RBX: ffff8881148d7940 RCX: ffffffff817787bb
> RDX: 0000000000000077 RSI: 0000000000000008 RDI: 00000000000003be
> RBP: ffffc90000c9fb30 R08: 0000000000000000 R09: fffffbfff0d3e840
> R10: ffffffff869f4207 R11: 0000000000000000 R12: 0000000000000000
> R13: ffff888115eb9300 R14: ffffc90000c9fbc8 R15: 000000000000000c
> FS:  0000000000000000(0000) GS:ffff8882b0151000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f37266b6114 CR3: 00000000054a8000 CR4: 0000000000750ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  unlock_ovpn+0x8b/0xe0 [ovpn]
>  ovpn_peer_keepalive_work+0xe3/0x540 [ovpn]
>  ? ovpn_peers_free+0x780/0x780 [ovpn]
>  ? lock_acquire+0x56/0x70
>  ? process_one_work+0x888/0x1740
>  process_one_work+0x933/0x1740
>  ? pwq_dec_nr_in_flight+0x10b0/0x10b0
>  ? move_linked_works+0x12d/0x2c0
>  ? assign_work+0x163/0x270
>  worker_thread+0x4d6/0xd90
>  ? preempt_count_sub+0x4c/0x70
>  ? process_one_work+0x1740/0x1740
>  kthread+0x36c/0x710
>  ? trace_preempt_on+0x8c/0x1e0
>  ? kthread_is_per_cpu+0xc0/0xc0
>  ? preempt_count_sub+0x4c/0x70
>  ? _raw_spin_unlock_irq+0x36/0x60
>  ? calculate_sigpending+0x7b/0xa0
>  ? kthread_is_per_cpu+0xc0/0xc0
>  ret_from_fork+0x3a/0x80
>  ? kthread_is_per_cpu+0xc0/0xc0
>  ret_from_fork_asm+0x11/0x20
>  </TASK>
> Modules linked in: ovpn(O)
> 
> This happens because the peer deletion operation reaches
> ovpn_socket_release() while ovpn_sock->sock (struct socket *)
> and its sk member (struct sock *) are still both valid.
> Here synchronize_rcu() is invoked, after which ovpn_sock->sock->sk
> becomes NULL, due to the concurrent socket closing triggered
> from userspace.
> 
> After having invoked synchronize_rcu(), ovpn_socket_release() will
> attempt dereferencing ovpn_sock->sock->sk, triggering the crash
> reported above.
> 
> The reason for accessing sk is that we need to retrieve its
> protocol and continue the cleanup routine accordingly.
> 
> This crash can be easily produced by running openvpn userspace in
> client mode with `--keepalive 10 20`, while entirely omitting this
> option on the server side.
> After 20 seconds ovpn will assume the peer (server) to be dead,
> will start removing it and will notify userspace. The latter will
> receive the notification and close the transport socket, thus
> triggering the crash.
> 
> To fix the race condition for good, we need to refactor struct ovpn_socket.
> Since ovpn is always only interested in the sock->sk member (struct sock *)
> we can directly hold a reference to it, raher than accessing it via
> its struct socket container.
> 
> This means changing "struct socket *ovpn_socket->sock" to
> "struct sock *ovpn_socket->sk".
> 
> While acquiring a reference to sk, we can increase its refcounter
> without affecting the socket close()/destroy() notification
> (which we rely on when userspace closes a socket we are using).
> 
> By increasing sk's refcounter we know we can dereference it
> in ovpn_socket_release() without incurring in any race condition
> anymore.
> 
> ovpn_socket_release() will ultimately decrease the reference
> counter.
> 
> Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
> Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
> Reported-by: Qingfang Deng <dqfext@gmail.com>
> Closes: https://github.com/OpenVPN/ovpn-net-next/issues/1
> Tested-by: Gert Doering <gert@greenie.muc.de>
> Link: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31575.html
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>  drivers/net/ovpn/io.c      |  8 ++---
>  drivers/net/ovpn/netlink.c | 16 ++++-----
>  drivers/net/ovpn/peer.c    |  4 +--
>  drivers/net/ovpn/socket.c  | 68 +++++++++++++++++++++-----------------
>  drivers/net/ovpn/socket.h  |  4 +--
>  drivers/net/ovpn/tcp.c     | 65 ++++++++++++++++++------------------
>  drivers/net/ovpn/tcp.h     |  3 +-
>  drivers/net/ovpn/udp.c     | 34 +++++++------------
>  drivers/net/ovpn/udp.h     |  4 +--
>  9 files changed, 102 insertions(+), 104 deletions(-)
> 

Thanks for wide description in commit message. Changes looks fine for
me.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.49.0

