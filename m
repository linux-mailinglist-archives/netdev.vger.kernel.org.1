Return-Path: <netdev+bounces-205905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C179B00BA8
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370684E82FE
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 18:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBA42FD58D;
	Thu, 10 Jul 2025 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OX0m5Hj7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5560118E25;
	Thu, 10 Jul 2025 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752173368; cv=none; b=UgsFVytIQUfH57N5GOmG3l24xu/fKLwBitXdso9lcjozCINpFDZ/1+zlSVXHJjOX3zMhD304nQ8FErM5N1LrgAyW+xJM4rrXIarZ/PwLNntXmI8496ofANWFvzhWWnzQ/LKFsz0xfB9hGHyIQ3TiTOqyMcuKzNwCIpmZpZR3QjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752173368; c=relaxed/simple;
	bh=PYBQTtwI7qUGNZYkLdqat2uZgEeL9RAyXWixkPD0vO4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arDaw4WHNOIfBTg82wtgpX6l6/iDDB/2g9qfMy2gYGFvP8YLA2BIrz6ZzLvvpgBXAhB/trkwuSfapk8YeSztez0oBLydrwOUEyu4Jk8JbBT6meD70LZ39eGDU6Zi9qxpWlNfYcTThxwf6zn9eYGGqLQIa8uFityk3GLuYhzyRPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OX0m5Hj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7241FC4CEE3;
	Thu, 10 Jul 2025 18:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752173367;
	bh=PYBQTtwI7qUGNZYkLdqat2uZgEeL9RAyXWixkPD0vO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OX0m5Hj7/oHn9SK0dlRslPbntIbL04R0yEig+jcfrsqx3FgPqCMhmfz8p1Uzv63Gd
	 UWd10oGsXY8ROaK2MIt9pNUbVirIJSdQNwTVOgPxT+3mPz2b5FEUZPdvEZF2Mr7q7n
	 6fIhbqVfHRSnmTi3jjWpPgsmtUCCeRdZdUiS48s3Iwvq5miohKEo9oQx8OFgaNF5KO
	 7TTJOM4tGHAQnuL1yD1UT4Ps1N93L1dQiGcYvQuKgp2BqfnaPq/GChZhYzky5872bA
	 yHBJMUQCr+3WD4FAO07RuxJO4kExw4sKKJ/vcJS23s2Svkr+Dlybl/afaVnniyyJVU
	 uwA58h2oJ0Viw==
Date: Thu, 10 Jul 2025 11:49:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Florian Fainelli <f.fainelli@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH net] net: phy: Don't register LEDs for genphy
Message-ID: <20250710114926.7ec3a64f@kernel.org>
In-Reply-To: <04583ed9-0997-4a54-a255-540837f1dff8@linux.dev>
References: <20250707195803.666097-1-sean.anderson@linux.dev>
	<20250707163219.64c99f4d@kernel.org>
	<3aae1c17-2ce8-4229-a397-a8a25cc58fe9@linux.dev>
	<1019ee40-e7df-43a9-ae3f-ad3172e5bf3e@linux.dev>
	<20250710105254.071c2af4@kernel.org>
	<04583ed9-0997-4a54-a255-540837f1dff8@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 14:17:18 -0400 Sean Anderson wrote:
> On 7/10/25 13:52, Jakub Kicinski wrote:
> > On Thu, 10 Jul 2025 13:40:33 -0400 Sean Anderson wrote:  
> >> I see this is marked "Changes Requested" in patchwork. However, I don't
> >> believe that I need to change anything until the above commit is merged
> >> into net/main. Will you be merging that commit? Or should I just resend
> >> without changes?  
> > 
> > The patch must build when posted. If it didn't you need to repost.  
> 
> It builds on net/main. Which is what I posted for. The CI applied it to net-next/main.

Damn, I see your point now, sorry :/
So in net-next we'll have to drop the phy_driver_is_genphy_10g() ?

I think it may be best if we turn this into an explicit merge
conflict, IOW if you could post both net and net-next version
I will merge them at the same time. Upstream trees like CI or
linux-next will have easier time handling a git conflict than
a build failure. Does that make sense? For the net-next version
describe it from the perspective of the net patch already being
merged and you're writing the "-next" version of the patch.
I'll edit in the git hash of the net commit when applying.

