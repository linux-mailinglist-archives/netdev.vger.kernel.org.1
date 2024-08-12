Return-Path: <netdev+bounces-117847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3779394F8B5
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 23:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA021B20EF1
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 21:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBB716BE0D;
	Mon, 12 Aug 2024 21:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XkQTPTtX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F8016BE0C;
	Mon, 12 Aug 2024 21:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723496634; cv=none; b=nZWzQiK2qI135Lk1HF+W28NTImnO6RTVPAPWf0LuflxlZzdegZyqT5QiX7pUGW+u5q7lysGIgERm1j2hoMTi7ttxfgJQwtK7Zm3dj8ei9lwmWiFb1p5fOFWRylmRb6x+nU/owmc1wZoxGntYrW/k64QZlhTdAbtKQvRKHqPP+OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723496634; c=relaxed/simple;
	bh=4H1Ysc5LqfnsrhAXsVm6DmlRNAZD3o2T7rofR8TvXFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwpUGnjmGzTlbqbHs6IXksdiiw4SKwScyduNyll6iKyMD9NEDq8qj/4vMBYtp8JdPmDXWumKlG//RgMWZmNlJjflqXmn6G8CbfqT/QapWL/y61RTVB201KnOunRdtKwdXQ0wmWsecjMIzJ5OmhLfxGG4pdAoKoxuFLFNkOQq988=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XkQTPTtX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=q5cMPBUHbooxWEGZnv7SZcmMFJ0mj2NafP7388hWDp0=; b=XkQTPTtXEgrHwvnDOGvEf8LaFB
	lrXnL90X4Oo3xsISqWKKn/CDypY0/9db2fpizaEpd5TWrbd0yG8IGi6g1puvlbJljsJkCJdxircuG
	lj5iDU1ZjgDdTXGUqwtgjuLxNogq3knv4oQzpaffNc/I07NY/4NpWojQB+SF9pgKOZp8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdcCd-004cUA-8r; Mon, 12 Aug 2024 23:03:43 +0200
Date: Mon, 12 Aug 2024 23:03:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	vburru@marvell.com, sedara@marvell.com, srasheed@marvell.com,
	sburla@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: octeon_ep_vf: use ethtool_sprintf/puts
Message-ID: <f06cab9a-853f-4ccf-ae4d-40e0e897ea60@lunn.ch>
References: <20240809044738.4347-1-rosenp@gmail.com>
 <20240812124224.GA7679@kernel.org>
 <CAKxU2N-m7SSTxuWQUuMH6E8FnF0RXGUMPepA=DunoZsvzJ-ahg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKxU2N-m7SSTxuWQUuMH6E8FnF0RXGUMPepA=DunoZsvzJ-ahg@mail.gmail.com>

> > 2. You have posed a number of similar patches.
> >    To aid review it would be best to group these, say in batches of
> >    no more than 10.
> I plan to do a treewide commit with a coccinelle script but would like
> to manually fix the problematic ones before doing so. Having said that
> I still need to figure out how to do a cover letter...

git format-patch --cover-letter HEAD~42

I also find `b4 prep` good for managing patchsets, and it will produce
a cover letter by default if there is more than one patch in the set:

https://b4.docs.kernel.org/en/latest/contributor/prep.html

	Andrew

