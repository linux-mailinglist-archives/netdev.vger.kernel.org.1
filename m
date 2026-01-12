Return-Path: <netdev+bounces-249035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5DCD12FBD
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1AE33004F4F
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 13:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E6C35A954;
	Mon, 12 Jan 2026 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zq4VCEZa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4D534DB71
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768226317; cv=none; b=lpDsv9hHL86xLOW01NneEXhWprDy4ChAExbXI0dbMFNhEP9sHiDO2fjhqfqsD8pGi6BevfRrbprqCGvYZPIoKmqvMxhk6SIRqjZCwV/w0u211mUZ0NR6gARfCp2cY0oD7ncV3xLBX5U4QwYzV/pLXNdPoiSQzxYDx2vhnWxNByw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768226317; c=relaxed/simple;
	bh=T+GK6b1uowAqZPepq8A3zrFaIzOjZkACQPLeAvudjUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNS+atIWrK4QOk8axpyKprvyo9hEs0HQCWIMb6GHE/9rlt/KVouTS6nO7wX33nnT9GEz3KxIvP6zV78L1VCR0s/yO/D5EaIZLsyliC5acvW1e1Z+H9RoUK/ZPoVaMvh78cUiQnncjP/3CaKZo5ZiER1L5s3lh4RxKl7rGicnDQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zq4VCEZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57532C16AAE;
	Mon, 12 Jan 2026 13:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768226317;
	bh=T+GK6b1uowAqZPepq8A3zrFaIzOjZkACQPLeAvudjUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zq4VCEZao7MqqXwELU/lKXrmvwJ93PAAgrb6MAesKRuDKHmKZQT8cf6ZX2KeCTVEy
	 jzKM/YYh0Dvp9Y7GJwYgokmQ/sZMj6spw2phNHlPee4K43Wy+JQ8FYr1tAmsU645d6
	 PZGstD1kaaVlgcas4J7YJuS9W7r/o5TezpWW71YN15krPc1Jmhzjcv4Q3qmmxHVSy6
	 BQYDwouzSpSjrPwlc+ccot5MBAf6OAh8qRwLiFW7lEVCdNWd8lN6zvpz9KXNNQwwEV
	 HZHAgT2w8tlkGPaieipozxxQt9Qh+xobCeRCF6vS4EpVWq6BEukI9geje2D80jRJyq
	 AqqMSCZxdJZAw==
Date: Mon, 12 Jan 2026 13:58:33 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Florian Westphal <fw@strlen.de>, Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com,
	Mazin Al Haddad <mazin@getstate.dev>
Subject: Re: [PATCH v2 net] ip6_gre: use skb_vlan_inet_prepare() instead of
 pskb_inet_may_pull()
Message-ID: <aWT-CTaKuup9OYvo@horms.kernel.org>
References: <20260106144529.1424886-1-edumazet@google.com>
 <20260106095648.07a870f1@kernel.org>
 <CANn89iJnXg892OU13PeJMGvBKw90fJdqDaAmJ867Rptsm0zgNA@mail.gmail.com>
 <aV4ddkDATvo9lBHi@strlen.de>
 <CANn89iKkThtD7VAN3OaOmC9=Ekiu2u-0TJ1BJaD+g7LCg9ARVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKkThtD7VAN3OaOmC9=Ekiu2u-0TJ1BJaD+g7LCg9ARVQ@mail.gmail.com>

On Wed, Jan 07, 2026 at 10:01:22AM +0100, Eric Dumazet wrote:
> On Wed, Jan 7, 2026 at 9:46 AM Florian Westphal <fw@strlen.de> wrote:
> >
> > Eric Dumazet <edumazet@google.com> wrote:
> > > On Tue, Jan 6, 2026 at 6:56 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > > >
> > > > On Tue,  6 Jan 2026 14:45:29 +0000 Eric Dumazet wrote:
> > > > > v2: invert the conditions (Jakub)
> > > >
> > > > Thanks! Much better now, but still failing
> > > > tools/testing/selftests/net/gre_gso.sh
> > > >
> > > > TAP version 13
> > > > 1..1
> > > > # timeout set to 3600
> > > > # selftests: net: gre_gso.sh
> > > > # 2.16 [+2.16]     TEST: GREv6/v4 - copy file w/ TSO                                   [ OK ]
> > > > # 3.16 [+1.01] 2026/01/06 10:32:57 socat[20546] W exiting on signal 15
> > > > # 3.17 [+0.01] 2026/01/06 10:32:57 socat[20546] W exiting on signal 15
> > > > # 3.17 [+0.00]     TEST: GREv6/v4 - copy file w/ GSO                                   [FAIL]
> > > > # 3.18 [+0.01] 2026/01/06 10:32:57 socat[20533] W exiting on signal 15
> > > > # 3.19 [+0.00]     TEST: GREv6/v6 - copy file w/ TSO                                   [ OK ]
> > > > # 4.19 [+1.00] 2026/01/06 10:32:59 socat[20559] W exiting on signal 15
> > > > # 4.19 [+0.01]     TEST: GREv6/v6 - copy file w/ GSO                                   [FAIL]
> > > > # 4.20 [+0.01] 2026/01/06 10:32:59 socat[20549] W exiting on signal 15
> > > > # 4.22 [+0.02] 2026/01/06 10:32:59 socat[20560] W exiting on signal 15
> > > > # 4.23 [+0.01]
> > > > # 4.23 [+0.00] Tests passed:   2
> > > > # 4.23 [+0.00] Tests failed:   2
> > > > not ok 1 selftests: net: gre_gso.sh # exit=1
> > > >
> > > > https://netdev-ctrl.bots.linux.dev/logs/vmksft/net/results/461862/65-gre-gso-sh/stdout
> > >
> > > For some reason I am unable to run this test from a virtme-ng instance.
> > >
> > > I guess I wlll not make a new version of this patch, maybe Florian can
> > > take over.
> >
> > Its failing because nhoff is moved by 14 bytes, test passes after doing:
> >
> > -       if (skb_vlan_inet_prepare(skb, false))
> > +       if (skb_vlan_inet_prepare(skb, true))
> 
> Thanks Florian.
> 
> I finally understood that my virtme-ng problem with this test is that
> on my platform, /proc/sys/net/core/fb_tunnels_only_for_init_net was
> set to 2
> 
> Tests have a hidden dependency against this sysctl.

Should unhide it by making the tests check or set this value?

It seems like a lot of time was lost on this already.

