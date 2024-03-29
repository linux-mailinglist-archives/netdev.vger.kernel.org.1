Return-Path: <netdev+bounces-83367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BFD8920BA
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D450E1C28342
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548BC1DDFC;
	Fri, 29 Mar 2024 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVMQHQUl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E261C0DF8
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711727028; cv=none; b=WmGHtU8lE6qAyq9+CIQrhReYG3B1Noz0AXFztf4+PVZnWAKq3Pf/N3tAZWAxjMIzHnjvBydN325ZFD36rUnHhHMqPGbD3pTOfGchfUsJ+rAwkWq6ZGuDbFClQsZY0OVdXQaQnpHzyd4h6rLnjSPrNdgKORPLjFvzMpSVJqG+uEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711727028; c=relaxed/simple;
	bh=l7MflZYo91eVIZusgFESMJFith/9tB59mQ+b1IRgnm0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ha2g0eszYiZUTIjApzHCpyIh+nhPGmYyL8Sx0sxTTMjanyHmQgwCOhTpQ2mNGvqWgOtoiEuJuNoB1T/Q4I2J0mZeF3RNmdDogNVDKkcV/6EBeLPBoYgyEvdCPcSSw23giZ5wCC/r4zIjS0oWo+yBLNRI91lOJItTIY5m7fS5aDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVMQHQUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FCAC433F1;
	Fri, 29 Mar 2024 15:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711727027;
	bh=l7MflZYo91eVIZusgFESMJFith/9tB59mQ+b1IRgnm0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UVMQHQUl681uyz2/eQoGCI0AuE09kj4RC8FAZ73WsTaraXCq6zrpDedTgPVjUXpbX
	 jfqdRmqxY+H3Rfo95FSngU1yekFjawNMN5+LSv+auBRHTqC8lwTGzXayLDJseB14WE
	 4DyNdvSjLXhZtRWJ7KJPd0S6aHh8Y2hPecb0pfWyKV1esFGwPhwq8L7s+hTSfUD1QG
	 nM3eDsZ/SG9h2gXL0Ec+5ByuM4oqpDOUApJjwFvfBfGIk+i8Ro4tnJDnRJeFbv57Dc
	 i5XVs6rCT0ZqGm/BzkntvGHp+WsMI2FIr5fYHzug00fZXaToS3Dm487Sl12NMwTvA1
	 WGrPuX0AJFPrw==
Date: Fri, 29 Mar 2024 08:43:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Jacob Keller <jacob.e.keller@intel.com>, Stanislav
 Fomichev <sdf@google.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 2/2] tools/net/ynl: Add multi message
 support to ynl
Message-ID: <20240329084346.7a744d1e@kernel.org>
In-Reply-To: <m234s9jh0k.fsf@gmail.com>
References: <20240327181700.77940-1-donald.hunter@gmail.com>
	<20240327181700.77940-3-donald.hunter@gmail.com>
	<20240328175729.15208f4a@kernel.org>
	<m234s9jh0k.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Mar 2024 13:37:31 +0000 Donald Hunter wrote:
> > We'd only support multiple "do" requests, I wonder if we should somehow
> > call this out. Is --multi-do unnecessary extra typing?  
> 
> I prefer --multi but will update the help text to say "DO-OPERATIION"
> and "... several do operations".

Alright, technically doing multi-dump should also work, but maybe
there's less of a benefit there, so we can keep the multi focused
on do for now.

Looking at the code again, are you sure we'll process all the responses
not just the first one?

Shouldn't this:

+                    del reqs_by_seq[nl_msg.nl_seq]
                     done = True

be something like:

		del reqs_by_seq[nl_msg.nl_seq]
		done = len(reqs_by_seq) == 0

?

Would be good to add an example of multi executing some get operations.

My other concern is the formatting of the response. For mutli we should
probably retain the indexes, e.g. 3 dos should produce an array with a
length of 3, some of the entries may be None if the command only acked.
Would that make sense?

