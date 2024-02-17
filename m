Return-Path: <netdev+bounces-72604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C618D858CE7
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 02:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82CD2286054
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 01:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626DC1B7F0;
	Sat, 17 Feb 2024 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSFj9aIN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE1E1B7EA
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 01:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708134453; cv=none; b=OczrIqrW5OYfgoBl15pO2Kbshj+V6BRdVv4aHsL2NFcpd20ylJO63OwIF57uxTBmoPDlRaWyoimtQritygVx0LLGvQ8K8bZ5BdePovELbkejLZLNv/CZHdiIhJ1U2MjGkHEswC3r0FiK1h7hQA8LK1OSe0AELkPkwTC8Qyr5wig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708134453; c=relaxed/simple;
	bh=5YuCThAED9F27nQqIVOThzgdSOE+ZjiltPYzgny5MeM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5eK3e7rkN8vzYOQsrzL7Mevm3VaSZznV44isC3z/X+AvfZOAZv7zSxh1xcP0s0B+R9wdk85O3TDoxdINec12J6kkR0gREqxNS5jCzgd3kIfDpTpHmkwTBe5o+CKGTODGUt7TqoaaEKK/Ck5PL06KhPYyw2s1TnwMyskvZCjSAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSFj9aIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A07DC433C7;
	Sat, 17 Feb 2024 01:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708134452;
	bh=5YuCThAED9F27nQqIVOThzgdSOE+ZjiltPYzgny5MeM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iSFj9aINJzuqi+q/eBqqypIwZy/eRdZWZMPhLCOg59z9y5xEhYHK1RqYs+UDERTAD
	 L4CIn4rO8ocIp4FpMDaqDuXwajOJAvFdxIvCoM/+DqnDKbURF2oc59k/LNGfdAgdkG
	 +PgJYWV1Ysj1ZM7z/8xHUn+ZTRrLM1g00yJj4e2c3fS3xICxgK7f4P/uYkSgvbj5Wx
	 EhTESbggnE/Rwzz+TYgeoV+jNf0eNnn5CHTimZ9uPZZZgbY4Yhx7yeLUO0DfNFyXJm
	 4XI9FK4eUNbXYr1Iluk4g6rS3l85EwU0ArUs5igu8zLkUvFZqVQQtodfPXc/+4opOW
	 YdXodxKTFCtFQ==
Date: Fri, 16 Feb 2024 17:47:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Sabrina
 Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v11 0/3] netdevsim: link and forward skbs
 between ports
Message-ID: <20240216174731.5dce1a43@kernel.org>
In-Reply-To: <cf9e07d6-6693-4511-93a6-e375d6f0e738@davidwei.uk>
References: <20240215194325.1364466-1-dw@davidwei.uk>
	<ea379c684c8dbab360dce3e9add3b3a33a00143f.camel@redhat.com>
	<cf9e07d6-6693-4511-93a6-e375d6f0e738@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 12:13:42 -0700 David Wei wrote:
> > this apparently causes rtnetlink.sh self-tests failures:
> > 
> > https://netdev.bots.linux.dev/flakes.html?tn-needle=rtnetlink-sh
> > 
> > example failure:
> > 
> > https://netdev-3.bots.linux.dev/vmksft-net/results/467721/18-rtnetlink-sh/stdout
> > 
> > the ipsec_offload test (using netdevsim) fails.  
> 
> Thanks for catching this Paulo. Can I sort this out in a separate patch,
> as the rtnetlink.sh test is disabled in CI right now?

Looks like the code needs fixing, still, so please tack the rtnetlink
fix onto the v12

