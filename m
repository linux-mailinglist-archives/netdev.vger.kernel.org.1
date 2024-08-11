Return-Path: <netdev+bounces-117479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2177A94E169
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 15:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2C4CB20F8A
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 13:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49752148841;
	Sun, 11 Aug 2024 13:24:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627BA148838;
	Sun, 11 Aug 2024 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723382663; cv=none; b=mrGzcZ+/wMMgg43q1HdjlmBGsTAFQC/oDWo/NEKEt72E9Lew4p3CeOcaf57y1WVOQ7DSzX7GTEqiM2+sb2DFLWUMVuSxqPT8+NV7HQSy0Ukhgx7cM8FvOhx7XDHdDpYfTrhi5k67uNLPhk8TA5ABzi2eRhJZ3VZ3pPWY2W7luCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723382663; c=relaxed/simple;
	bh=Po5/mFOf0/VTScGzn6+mtQuzX/UGKG4Vw71o8feai/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rywU/UX41czih6GDcckmzd8V/ZFUrY8ApPPhpGarGLxLhvRrtUhWvtT4No2Hc8JrY9v0WjDADAkprOkU2aF//Z6ePQ738n4dX+iTtqlx6KvfYq6TcoYga5yLrKNwXTHCTyKvI8M0jnEveUpnNpp2VniP8n65bvsc52yMJbRDZuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sd8YN-0004rw-GL; Sun, 11 Aug 2024 15:24:11 +0200
Date: Sun, 11 Aug 2024 15:24:11 +0200
From: Florian Westphal <fw@strlen.de>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com,
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING: refcount bug in inet_twsk_kill
Message-ID: <20240811132411.GB13736@breakpoint.cc>
References: <0000000000003a5292061f5e4e19@google.com>
 <20240811022903.49188-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811022903.49188-1-kuniyu@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> From: syzbot <syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com>
> Date: Sat, 10 Aug 2024 18:29:20 -0700
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    33e02dc69afb Merge tag 'sound-6.10-rc1' of git://git.kerne..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=117f3182980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=25544a2faf4bae65
> > dashboard link: https://syzkaller.appspot.com/bug?extid=8ea26396ff85d23a8929
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-33e02dc6.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/573c88ac3233/vmlinux-33e02dc6.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/760a52b9a00a/bzImage-33e02dc6.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com
> > 
> > ------------[ cut here ]------------
> > refcount_t: decrement hit 0; leaking memory.
> > WARNING: CPU: 3 PID: 1396 at lib/refcount.c:31 refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
> 
> Eric, this is the weird report I was talking about at netdevconf :)
> 
> It seems refcount_dec(&tw->tw_dr->tw_refcount) is somehow done earlier
> than refcount_inc().
> 
> I started to see the same splat at a very low rate after consuming
> commit b334b924c9b7 ("net: tcp/dccp: prepare for tw_timer un-pinning").

I think I see why.

The reported splat is without this above commit.
But from backtrace we entered here:

                if (net->ipv4.tcp_death_row.hashinfo->pernet) {
                        /* Even if tw_refcount == 1, we must clean up kernel reqsk */
                        inet_twsk_purge(net->ipv4.tcp_death_row.hashinfo);
                } else if (!purged_once) {
-------------->         inet_twsk_purge(&tcp_hashinfo);  // THIS
                        purged_once = true;

> The commit a bit deferred refcount_inc(tw_refcount) after the hash dance,
> so twsk is now visible before tw_dr->tw_refcount is incremented.
> 
> I came up with the diff below but was suspecting a bug in another place,
> possibly QEMU, so I haven't posted the diff officially.
> 
> refcount_inc() was actually deferred, but it's still under an ehash lock,

but different struct inet_hashinfo, so the locks don't help :/

