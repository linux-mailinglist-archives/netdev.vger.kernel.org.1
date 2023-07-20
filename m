Return-Path: <netdev+bounces-19327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4EA75A4C5
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 05:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B67281C23
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 03:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00F91115;
	Thu, 20 Jul 2023 03:30:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B2217D9
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 03:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F35FC433C8;
	Thu, 20 Jul 2023 03:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689823832;
	bh=OnSRL/M/dbuk991nGBrfC0/pCCMwx2qMx5t/Th8WDY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DLP0S+lHKonruVV95NGNwFLFr5aWNx45vINgAd1CVjDbI/PxvcmUv57niu5feAGkY
	 AWElUA7x+ISFrYGq/jkvkfn4q6t04zKRia/WReyo9T88T6CNd+m2heMlul2896iWth
	 JguL4emjfN7RreQNklhpOSKt4TGwUgNqssc7rhrAOqGdUy0Ixax1p0M54pRFVuyGwE
	 i7dgQlwm0YcCQHmSiMSik+TgPhgoWfrExGhO4xVhNqw1sBDlfaokr/47tixTw3D+mM
	 IrJc2AQzdNVRpO4QDu4TdwbOA4T2hESliP6LNvOgpqRdMk7YriQ3UqnC9d8w085jmB
	 EIvkZAqeEpKSg==
Date: Wed, 19 Jul 2023 20:30:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>, Aleksandr Nogikh <nogikh@google.com>,
 syzbot <syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com>,
 dsterba@suse.cz, bakmitopiacibubur@boga.indosterling.com, clm@fb.com,
 davem@davemloft.net, dsahern@kernel.org, dsterba@suse.com,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, josef@toxicpanda.com,
 kadlec@netfilter.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux@armlinux.org.uk,
 netfilter-devel@vger.kernel.org, pablo@netfilter.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] [netfilter?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS
 too low! (2)
Message-ID: <20230719203030.1296596a@kernel.org>
In-Reply-To: <20230719231207.GF32192@breakpoint.cc>
References: <20230719170446.GR20457@twin.jikos.cz>
	<00000000000042a3ac0600da1f69@google.com>
	<CANp29Y4Dx3puutrowfZBzkHy1VpWHhQ6tZboBrwq_qNcFRrFGw@mail.gmail.com>
	<20230719231207.GF32192@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jul 2023 01:12:07 +0200 Florian Westphal wrote:
> I don't see any netfilter involvement here.
> 
> The repro just creates a massive amount of team devices.
> 
> At the time it hits the LOCKDEP limits on my test vm it has
> created ~2k team devices, system load is at +14 because udev
> is also busy spawing hotplug scripts for the new devices.
> 
> After reboot and suspending the running reproducer after about 1500
> devices (before hitting lockdep limits), followed by 'ip link del' for
> the team devices gets the lockdep entries down to ~8k (from 40k),
> which is in the range that it has on this VM after a fresh boot.
> 
> So as far as I can see this workload is just pushing lockdep
> past what it can handle with the configured settings and is
> not triggering any actual bug.

The lockdep splat because of netdevice stacking is one of our top
reports from syzbot. Is anyone else feeling like we should add 
an artificial but very high limit on netdev stacking? :(

