Return-Path: <netdev+bounces-92836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE8F8B90A6
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 22:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B7A283CF5
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 20:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206E01635C9;
	Wed,  1 May 2024 20:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOfz32qv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A8617C6A
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 20:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714595596; cv=none; b=uHGcz/0M3GgGJUNSPn7tDbzi1VCJXk6xg70OX1bp5jDlpcEG4DdMzweq2yYqHptQXdEOgrfV62moqpUMrt7NikMCQpgqdV4Dd3sXS94uB/th9Xj1wLttUy1MLP3FIfwvEc+uFLCQWLljViKeGmL2vXB8rfEmVGFQqLV9S53HR34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714595596; c=relaxed/simple;
	bh=tLiMWMjCRfjQ8L3ETm9UL12dgbZjHvBiB7IcntHGMh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqfRjhPAHyUkP22+D2ktZceylRKSc4sKbyAb/DDlAkLryK39ePkVq47eUB0aPNpvsiPORsPAriiShQYHBGI5cPkJdks1vP+4964M4BTrlHWuEEcczVPNMJzXDnBeVa8Sv/kYFAeZOK9YSKu5WswgGNScBI/Jo/bYV8g5EM0RAl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOfz32qv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A5CC072AA;
	Wed,  1 May 2024 20:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714595595;
	bh=tLiMWMjCRfjQ8L3ETm9UL12dgbZjHvBiB7IcntHGMh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SOfz32qvD+HC/gEYAznnT6F9GqVbIAZZj8z4dA0iFJ1fb5fYYXetCV3nl0Nu+3Tzf
	 fU1rB3j1cgFOMbkoEfLb3U3iLNM4aulV3YL3Omg3jgAEGS0Q3QspbjLVvbF8xP2J9K
	 LADtu0w7GNcu+nUQTM6lCIHJwxUNOqvAUHW2ezpQT+J38EAX7M6Epv1sb2BvU9okCW
	 q4UVW15dtZspMVzjXP/hmoxnGlz4vIKtdAELFxNHXbQVE58U+es5A22RIb9uzwUZzC
	 eyem7saWh1J4DeADwaEZ9J4QmDYVf4KpXDxCh/dOqhBBDPphfJ5wC0WGgq3UUbqb4y
	 l0iiacR836e7A==
Date: Wed, 1 May 2024 21:33:11 +0100
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geethasowjanya Akula <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] octeontx2-pf: Treat truncation of IRQ name as
 an error
Message-ID: <20240501203311.GA2821784@kernel.org>
References: <20240501-octeon2-pf-irq_name-truncation-v1-1-5fbd7f9bb305@kernel.org>
 <e2578f7a-7020-4ae4-94d7-69e828a523d5@lunn.ch>
 <20240501201146.GM516117@kernel.org>
 <aa0246ef-5696-42ea-9f00-4815d268abb7@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa0246ef-5696-42ea-9f00-4815d268abb7@lunn.ch>

On Wed, May 01, 2024 at 10:21:30PM +0200, Andrew Lunn wrote:
> On Wed, May 01, 2024 at 09:11:46PM +0100, Simon Horman wrote:
> > On Wed, May 01, 2024 at 09:46:15PM +0200, Andrew Lunn wrote:
> > > On Wed, May 01, 2024 at 07:27:09PM +0100, Simon Horman wrote:
> > > > According to GCC, the constriction of irq_name in otx2_open()
> > > > may, theoretically, be truncated.
> > > > 
> > > > This patch takes the approach of treating such a situation as an error
> > > > which it detects by making use of the return value of snprintf, which is
> > > > the total number of bytes, including the trailing '\0', that would have
> > > > been written.
> > > > +		name_len = snprintf(irq_name, NAME_SIZE, "%s-rxtx-%d",
> > > > +				    pf->netdev->name, qidx);
> > > > +		if (name_len >= NAME_SIZE) {
> > > 
> > > You say name_len includes the trailing \0. So you should be able to
> > > get NAME_SIZE bytes into an NAME_SIZE length array? So i think this
> > > can be >, not >= ?
> > 
> > Sorry, I misspoke.
> > name_len excludes the trailing \0.
> 
> The man page say:
> 
>        Upon successful return, these functions return the number of characters
>        printed (excluding the null byte used to end output to strings).
> 
>        The  functions  snprintf()  and vsnprintf() do not write more than size
>        bytes (including the terminating null byte ('\0')).  If the output  was
>        truncated  due  to  this  limit, then the return value is the number of
>        characters (excluding the terminating null byte) which would have  been
>        written  to the final string if enough space had been available.  Thus,
>        a return value of size or more means that  the  output  was  truncated.
>        (See also below under NOTES.)
> 
> Assuming the kernel snprintf() follows this, your condition is
> correct. So once the commit message is corrected, please add:
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks Andrew,

According to the documentation, the Kernel implementation
it matches the return value scheme described above.
For the record, the text in lib/vsprintf.c says:

 * The return value is the number of characters which would be
 * generated for the given input, excluding the trailing null,
 * as per ISO C99.  If the return is greater than or equal to
 * @size, the resulting string is truncated.

So I think the code is correct but my patch description text was wrong.
As you suggest, I'll fix that in v2.

