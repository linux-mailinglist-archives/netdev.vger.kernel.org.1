Return-Path: <netdev+bounces-186540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E09AAA9F8B3
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A24160154
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4F02957B9;
	Mon, 28 Apr 2025 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLtAcB0c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EC819309C
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745865527; cv=none; b=FxA5T7pbXm9m1lAZ7Kqzw/WhbQvdYKvXyH9aclslBZblkLaldySe3i3A/4l/zh1VyHzHWitJdPk6epgLYUMgvOqj/1xBgXW2R3kV7QD8yuO6fsCBMTCpAB/Y+AGPYqmYwIR7apS6gDwj5aFgEDV6nqPvo99KdZL0R3QSbU0XE0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745865527; c=relaxed/simple;
	bh=cX6lHjm7razXGlspwkEPbOhhYujvtYHS524jc6/0y8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OCrBOj53ISUYoaTASRA65orHKV2U1ShkP8WyjyywCWu7kBWaUS4Edl/jiYJVHju5/FKaFc9/ipU73WIfD7u50Zs8iu7uZE5YvGxmgxqQxOIkF1QI5BQtcj5ZiPNqIBS86k0uac01cgiFD/IK6hJscMNXS3A5oRAmSvVlnJKeqoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLtAcB0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D16C4CEEF;
	Mon, 28 Apr 2025 18:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745865526;
	bh=cX6lHjm7razXGlspwkEPbOhhYujvtYHS524jc6/0y8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OLtAcB0cUOi7DbRVQjgUYaZBaSzDnWIJwHoI2af5yoNkfA7xu29hRDRkSEVyu9JWk
	 Z9vkO56Ag9hhR3kzGcZOPrSrDGehs7EYS/hik2DNZeeXBgoFPeltttdVQDBXN2OkMY
	 fObytSGT/B2Kg9wepnyVxBFnNw65e8jlNOTMeOpoErkdQYVOY844mS5qNFcvFGTD56
	 2+fd+Bueq34CtR5PgDPOwOexSNGb8U34kHjmK2/VGSji+70QowSeN3mrWCY8kkBHSP
	 +uWrexPbZh4ueibpx+MmYcA6zM/etqXbz5hQxHqo4VhzNPSvxE1A4rEan6D71ypR4p
	 fjhMJvvVDAFsA==
Date: Mon, 28 Apr 2025 11:38:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Samiullah Khawaja
 <skhawaja@google.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5] Add support to set napi threaded for
 individual napi
Message-ID: <20250428113845.543ca2b8@kernel.org>
In-Reply-To: <aA_FErzTzz9BfDTc@LQ3V64L9R2>
References: <20250423201413.1564527-1-skhawaja@google.com>
	<20250425174251.59d7a45d@kernel.org>
	<aAxFmKo2cmLUmqAJ@LQ3V64L9R2>
	<680cf086aec78_193a062946c@willemb.c.googlers.com.notmuch>
	<aA_FErzTzz9BfDTc@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 11:12:34 -0700 Joe Damato wrote:
> On Sat, Apr 26, 2025 at 10:41:10AM -0400, Willem de Bruijn wrote:
> > > Anyway: I have a preference for consistency  
> > 
> > +1
> > 
> > I don't think either solution is vastly better than the other, as
> > long as it is the path of least surprise. Different behavior for
> > different options breaks that rule.  
> 
> I agree and my feedback on the previous revision was that all NAPI
> config settings should work similarly. Whether that's what I already
> implemented for defer-hard-irq/gro-flush-timeout or something else I
> don't really have a strong preference.
> 
> Implementing something other than what already exists for
> defer-hard-irq/gro-flush-timeout, though, would probably mean you'll
> need to update how both of those work, for consistency.

Nobody will disagree with consistency being good. The question is how
broadly you define the scope :) If you say 'all settings within
napi-set' that's one level of consistency, if you say 'all netdev
netlink' then the picture is less clear.

> > This also reminds me of /proc/sys/net/ipv4/conf/{all, default, .. }
> > API. Which confuses me to this day.

Indeed. That scheme has the additional burden of not being consistently 
enforced :/ So I'm trying to lay down some rules (in the doc linked
upthread).

The concern I have with the write all semantics is what happens when
we delegate the control over a queue / NAPI to some application or
container. Is the expectation that some user space component prevents
the global settings from being re-applied when applications using
dedicated queues / NAPIs are running?

Second, more minor concern is that we expose all settings on all
sub-objects which I find slightly less clear for the admin. It's much
harder to tell at a glance which settings are overrides and which one
was the default.

