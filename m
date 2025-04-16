Return-Path: <netdev+bounces-183054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC946A8AC7C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E642D3BA160
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808F081E;
	Wed, 16 Apr 2025 00:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIEXSXVG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5608E191;
	Wed, 16 Apr 2025 00:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744762316; cv=none; b=OMnq4HhTQPzP8lgEr3zutQ8ujudRZvqj9FdrmOO2Q8kkbURK0wDcQ17tyvaLw4EkxzVmALNP5CqYFzacSsaeLvma2Fvo9nclSUQpp/24WVDzgWPWQa0ih7OiTuT69Bybpg8AX2hv0+z09a0Q8greHrizQhWmADLUXXjZrPTUmJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744762316; c=relaxed/simple;
	bh=xL9ny8CV902/yY69YyFSiULaRxyEDjm+/p0FOCTB06I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9+zpnUKwivVhFiiPX72OxwNgGwnOmj+jcH9Cs++AWsImoXliXKzVR1p+KgjbUryV1rogryXRVXW4zXrablqZCQGvFCx5VlCBMrAN4O7EkECBekjjmr5x/XlAP/kQvrVEVJQKzGW4NoR+lPF6FEDFcg+eGy2c3V+ptTn8JlfEeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIEXSXVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70559C4CEE7;
	Wed, 16 Apr 2025 00:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744762315;
	bh=xL9ny8CV902/yY69YyFSiULaRxyEDjm+/p0FOCTB06I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pIEXSXVGZlMbvbLiAxWWEXV4/seGGJN/JZxtRkRGepa+WV6BXvM233rMXoyFoAj8I
	 vmUcis8poxZGm+oYgXqh1CPJMpDd66oq9DMxzzouyb2OYEJI2R48kxw6k39gFZAAlZ
	 fFax/Aczr/6wWFxXqKypOU2Qq8mv71UH6pv67UNLo6ZdkJ+dkeoLgk3MJ/SEr0KLY7
	 jLzWme+iWVut26Cw6AdeS4XxksGhHJ5nC2nF8rylnEPgNLTeHTFAlBcHScDPM00MGd
	 L5w3v8wNmnd+K5gcriLSywcGPkkEojqcschvu9AMkIDbXcddGyfnV7bpoI6nXsMpPz
	 nZbCmgg+Ln5ng==
Date: Tue, 15 Apr 2025 17:11:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, David Wei <dw@davidwei.uk>, Eric Dumazet
 <edumazet@google.com>, open list <linux-kernel@vger.kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [RFC net 0/1] Fix netdevim to correctly mark NAPI IDs
Message-ID: <20250415171154.0382c7f7@kernel.org>
In-Reply-To: <Z_613wmrKRu4R-IP@LQ3V64L9R2>
References: <20250329000030.39543-1-jdamato@fastly.com>
	<20250331133615.32bd59b8@kernel.org>
	<Z-sX6cNBb-mFMhBx@LQ3V64L9R2>
	<20250331163917.4204f85d@kernel.org>
	<Z_613wmrKRu4R-IP@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 12:39:11 -0700 Joe Damato wrote:
> On Mon, Mar 31, 2025 at 04:39:17PM -0700, Jakub Kicinski wrote:
> > Up to you. The patch make me wonder how many other corner cases / bugs
> > we may be missing in drivers. And therefore if we shouldn't flesh out
> > more device-related tests. But exercising the core code makes sense
> > in itself so no strong feelings.  
> 
> Sorry to revive this old thread, but I have a bit of time to get
> this fixed now. I have a patch for netdevsim but am trying to figure
> out what the best way to write a test for this is.
> 
> Locally, I've hacked up a tools/testing/selftests/drivers/net/napi_id.py
> 
> I'm using NetDrvEpEnv, but am not sure: is there an easy way in
> Python to run stuff in a network namespace? Is there an example I
> can look at?
> 
> In my Python code, I was thinking that I'd call fork and have each
> python process (client and server) set their network namespace
> according to the NetDrvEpEnv cfg... but wasn't sure if there was a
> better/easier way ?
> 
> It looks like tools/testing/selftests/net/rds/test.py uses
> LoadLibrary to call setns before creating a socket.
> 
> Should I go in that direction too?

Why do you need a netns? The NetDrvEpEnv will create one for you
automatically and put one side of the netdevsim into it.
Do you mean that you need to adjust that other endpoint?
It's done the same way as if it was a remote machine:

	cmd(..., host=cfg.remote)

If you really need a netnes check out
tools/testing/selftests/net/lib/py/netns.py

