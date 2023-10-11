Return-Path: <netdev+bounces-40041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ACB7C5894
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 17:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638E31C20C28
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 15:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35EA208CF;
	Wed, 11 Oct 2023 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LS8DXBNH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825EB19BDF
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 15:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD270C433C7;
	Wed, 11 Oct 2023 15:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697039552;
	bh=LVzkJfjdR7UBE70mbS0Jj7AuNyw3UWXjjX6rUc6CNBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LS8DXBNHueri7Phg49zoT7PFY5Nr3Mb06epzae/5BmVa9pvAJ424X/W5pjkfTt4q/
	 ucVYPN3mPL8T52yd2+ZrD83mwSo4mv01aBHp4Td0sS3y5Pnu6DziXVEPb5F4ud9fMJ
	 oL7EYSsupA4Re+sL9iera6ly49nNcuIhSWDbt6Po0Ww0QdLgcKrWcJFwOP9Q4XwvPF
	 9dP0YyNlvU1d8k1AmxFx1/gpo7CxCK2OzQXw721hFp9jHKgsINm1tfpTSo0Yd8WQRW
	 RF50P4HHrOKDCTB6w8Hq42q3zS7UZYjytR0/tDaiv8cHtA48DQ3t0uX/Jo32/9JmAX
	 I46j/zGb1Sp7Q==
Date: Wed, 11 Oct 2023 08:52:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
 fw@strlen.de, pablo@netfilter.org, jiri@resnulli.us, mkubecek@suse.cz,
 aleksander.lobakin@intel.com, Thomas Haller <thaller@redhat.com>
Subject: Re: [RFC] netlink: add variable-length / auto integers
Message-ID: <20231011085230.2d3dc1ab@kernel.org>
In-Reply-To: <6ec63a78-b0cc-452e-9946-0acef346cac2@6wind.com>
References: <20231011003313.105315-1-kuba@kernel.org>
	<f75851720c356fe43771a5c452d113ca25d43f0f.camel@sipsolutions.net>
	<6ec63a78-b0cc-452e-9946-0acef346cac2@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Oct 2023 16:03:26 +0200 Nicolas Dichtel wrote:
> > On Tue, 2023-10-10 at 17:33 -0700, Jakub Kicinski wrote:  
> >> We currently push everyone to use padding to align 64b values in netlink.
> >> I'm not sure what the story behind this is. I found this:
> >> https://lore.kernel.org/all/1461339084-3849-1-git-send-email-nicolas.dichtel@6wind.com/#t  
> There was some attempts before:
> https://lore.kernel.org/netdev/20121205.125453.1457654258131828976.davem@davemloft.net/
> https://lore.kernel.org/netdev/1355500160.2626.9.camel@bwh-desktop.uk.solarflarecom.com/
> https://lore.kernel.org/netdev/1461142655-5067-1-git-send-email-nicolas.dichtel@6wind.com/
> 
> >> but it doesn't go into details WRT the motivation.
> >> Even for arches which don't have good unaligned access - I'd think
> >> that access aligned to 4B *is* pretty efficient, and that's all
> >> we need. Plus kernel deals with unaligned input. Why can't user space?  
> > 
> > Hmm. I have a vague recollection that it was related to just not doing
> > it - the kernel will do get_unaligned() or similar, but userspace if it
> > just accesses it might take a trap on some architectures?
> > 
> > But I can't find any record of this in public discussions, so ...  
> If I remember well, at this time, we had some (old) architectures that triggered
> traps (in kernel) when a 64-bit field was accessed and unaligned. Maybe a mix
> between 64-bit kernel / 32-bit userspace, I don't remember exactly. The goal was
> to align u64 fields on 8 bytes.

Reading the discussions I think we can chalk the alignment up 
to "old way of doing things". Discussion was about stats64, 
if someone wants to access stats directly in the message then yes, 
they care a lot about alignment.

Today we try to steer people towards attr-per-field, rather than
dumping structs. Instead of doing:

	struct stats *stats = nla_data(attr);
	print("A: %llu", stats->a);

We will do:

	print("A: %llu", nla_get_u64(attrs[NLA_BLA_STAT_A]));

Assuming nla_get_u64() is unalign-ready the problem doesn't exist.

If user space goes thru a standard parsing library like YNL
the application never even sees the raw netlink message,
and deals with deserialized structs.


Does the above sounds like a fair summary? If so I'll use it in 
the commit message?

