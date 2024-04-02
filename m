Return-Path: <netdev+bounces-84126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D04E895ABE
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 19:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE021C2459E
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 17:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB9F15A4B5;
	Tue,  2 Apr 2024 17:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVlyn1qu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4556315A4A6
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079160; cv=none; b=OYxNQl0YhcCozjIRvqzR1AcsYo8jTvNqHLQpoByuQqDdmDoh32aCu0JgAfg+swxdWdmYLRPThrcTzy8dXK95YGZYC2Qg6TZySFxNLSADQLmZOiMglNjAD958J+tFYJvlQvDOzHpqbpIBMnML9VnN9/4bvfdRYQWvUyADVOkTvG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079160; c=relaxed/simple;
	bh=7ikLca2So/pkvxItKa5H37g8vN6rYbVCvkqt0lLxVog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDcB1S6Finf6IhW2ZBjUqhZ89+Hhy1SCrpMqjQlbII2dw+SHkF2TgHP9cm4mvHCHxEfyxKDt4mDJLVsnM8+03SMR5hMRiA1uht0b/kva/Z4NyKyZl0Za+bmomddkyYLTw/Vd2PDvjyQQHo6qHTm21N7tgZK/1No1pqMWNGQbgRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVlyn1qu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309F3C433F1;
	Tue,  2 Apr 2024 17:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712079159;
	bh=7ikLca2So/pkvxItKa5H37g8vN6rYbVCvkqt0lLxVog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pVlyn1quo6pgp9DoXIomFPBSX1SWSVByNVtQQa2DtV2oiwTydtGSA1kfwmfWAFtlW
	 bIer/g55ewcxnpPCOhzl3uXr8TwKQSTAL3VT6W5EpVlrp6D97uI/IVo392ehYNw6OE
	 OhCWMjG+UNip9/ZFmEKWMR+02kJnykOL6OuL0SAMsq/Yzq1fdtP4P7rzlEnXR4fQKs
	 Wu7RTmSVgPr4+B1VVIJJGGMu/MwKq22GQzhsZmW94DWWfl49xhoDlo/prkWG+R7v2m
	 nxub1SbO6pR0wrvH8zQD9nubC+SLAOc0AEPIpdWSbuneSnLPhHe79QMgnH4C7RQDCT
	 d5FgIC4/priww==
Date: Tue, 2 Apr 2024 20:32:35 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: ICMP_PARAMETERPROB and ICMP_TIME_EXCEEDED during connect
Message-ID: <20240402173235.GK11187@unreal>
References: <20240326133412.47cf6d99@kernel.org>
 <CADVnQymqFELYQqpoDsxh=z2XxvhMSvdUfCyjgRYeA1QaesnpEg@mail.gmail.com>
 <20240326165554.541551c3@kernel.org>
 <CANn89iJDxv2hkT7-KCaizu3r44HpT=xbvRtMXjxd-LUQS=Br8g@mail.gmail.com>
 <20240402132137.GJ11187@unreal>
 <CANn89i+=MOmFzLzdwTX4k8Bc1mrXXzpOzgpAe8KSnjAmuX3kLA@mail.gmail.com>
 <CAL+tcoBKjPeHKv7OrxUVAppM+as+DANCeOYnfb1c2-2mqRqHCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoBKjPeHKv7OrxUVAppM+as+DANCeOYnfb1c2-2mqRqHCQ@mail.gmail.com>

On Tue, Apr 02, 2024 at 10:17:16PM +0800, Jason Xing wrote:
> On Tue, Apr 2, 2024 at 9:32 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Tue, Apr 2, 2024 at 3:21 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Wed, Mar 27, 2024 at 02:05:17PM +0100, Eric Dumazet wrote:
> > > > On Wed, Mar 27, 2024 at 12:55 AM Jakub Kicinski <kuba@kernel.org> wrote:
> > > > >
> > > > > On Tue, 26 Mar 2024 23:03:26 +0100 Neal Cardwell wrote:
> > > > > > On Tue, Mar 26, 2024 at 9:34 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > > > > > >
> > > > > > > Hi!
> > > > > > >
> > > > > > > I got a report from a user surprised/displeased that ICMP_TIME_EXCEEDED
> > > > > > > breaks connect(), while TCP RFCs say it shouldn't. Even pointing a
> > > > > > > finger at Linux, RFC5461:
> > > > > > >
> > > > > > >    A number of TCP implementations have modified their reaction to all
> > > > > > >    ICMP soft errors and treat them as hard errors when they are received
> > > > > > >    for connections in the SYN-SENT or SYN-RECEIVED states.  For example,
> > > > > > >    this workaround has been implemented in the Linux kernel since
> > > > > > >    version 2.0.0 (released in 1996) [Linux].  However, it should be
> > > > > > >    noted that this change violates section 4.2.3.9 of [RFC1122], which
> > > > > > >    states that these ICMP error messages indicate soft error conditions
> > > > > > >    and that, therefore, TCP MUST NOT abort the corresponding connection.
> > > > > > >
> > > > > > > Is there any reason we continue with this behavior or is it just that
> > > > > > > nobody ever sent a patch?
> > > > > >
> > > > > > Back in November of 2023 Eric did merge a patch to bring the
> > > > > > processing in line with section 4.2.3.9 of [RFC1122]:
> > > > > >
> > > > > > 0a8de364ff7a tcp: no longer abort SYN_SENT when receiving some ICMP
> > > > > >
> > > > > > However, the fixed behavior did not meet some expectations of Vagrant
> > > > > > (see the netdev thread "Bug report connect to VM with Vagrant"), so
> > > > > > for now it got reverted:
> > > > > >
> > > > > > b59db45d7eba tcp: Revert no longer abort SYN_SENT when receiving some ICMP
> > > > > >
> > > > > > I think the hope was to root-cause the Vagrant issue, fix Vagrant's
> > > > > > assumptions, then resubmit Eric's commit. Eric mentioned on Jan 8,
> > > > > > 2024: "We will submit the patch again for 6.9, once we get to the root
> > > > > > cause." But I don't think anyone has had time to do that yet.
> > > > >
> > > > > Ah.
> > > > >
> > > > > Thank you!!
> > > >
> > > > For the record, Leon Romanovsky brought this issue directly to Linus
> > > > Torvalds, stating that I broke things.
> > >
> > > Just to make it clear, Linus was involved after we didn't progress for
> > > more than one month after initial starting "Bug report connect to VM with Vagrant",
> > > while approaching to merge window.
> > > https://lore.kernel.org/netdev/MN2PR12MB44863139E562A59329E89DBEB982A@MN2PR12MB4486.namprd12.prod.outlook.com/
> > >
> > > Despite long standing netdev patch flow: apply fast -> revert fast, this
> > > patch was treated differently.
> >
> > I was waiting input from you. I think you only waited for "revert first"
> >
> > >
> > > >
> > > > It tooks weeks before Shachar did some debugging, but with no
> > > > conclusion I recall.
> > >
> > > Shachar didn't do debugging, she didn't write the bisected patch.
> > > She is verification engineer who was ready to run ANY tests and try
> > > ANY debug patch which you wanted.
> > >
> > > >
> > > > This kind of stuff makes me not very eager to work on this point.
> > > >
> > >
> > > OK, so it is not important at the end.
> >
> > I certainly do not want to waste time arguing with you on a valid
> > patch, which happens to break some buggy user space.
> >
> > Apparently some people think RFC are not important.
> 
> RFC is important.
> 
> Honestly, I read those threads over and over again. Since she provided
> some tcpdump logs which do not include ICMP, my question is still the
> same as Eric: why does this breakage have a relationship with this
> patch??? I get lost. It doesn't make sense really...

It was unfortunate outcome of moving the discussion to be private.
https://lore.kernel.org/netdev/CANn89i+e2TcvSU1EgrVZRUoEmZ5NDauXd3=kEkjpsGjmaypHOw@mail.gmail.com/

> 
> If someone is able to more easily reproduce this issue, I'm happy to help debug.
> 
> Thanks,
> Jason
> 

