Return-Path: <netdev+bounces-243814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 99601CA7DF3
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 15:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 389073018978
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 14:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A782F83D8;
	Fri,  5 Dec 2025 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjTuIjcc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DC624167F
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764943247; cv=none; b=qRVg/WyCgfer0pJMZauKSef5YNfANkVZwff3Lvd4WvozzsoX9FHTCkS+m8T0u2R8d5mg1+UYpxOVqQQdIawR+IzFY3STwhgH6HV9BrQB7BnLLVYXJdfiLA+oeck/yNxULy22ts8mCCMBByHCWPzSaev6CDXSBjY9cJ630WMM6cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764943247; c=relaxed/simple;
	bh=yaGpHOqzPBNtnDw2Z3jifEuWcWd2bbxsuUosPd8zTBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoUTZTWxKO59F/qBdjr6fPI4LHD570LAt/za4McvY4ULJQ/dhETq3XGNkPKPi51cNGNPWaCaaxcoI1SzLqHGJwkS1hGt4b9tp49JTfhDLqyRKnPozjFUcZP9oNev4cCUROCt1g74u3RcXYygx0mur4WQWFZybv7zVp/y/RfJFs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjTuIjcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F072FC4CEF1;
	Fri,  5 Dec 2025 14:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764943246;
	bh=yaGpHOqzPBNtnDw2Z3jifEuWcWd2bbxsuUosPd8zTBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OjTuIjccQwO5VAyUFy1CE7r1+chxnGTExnO8UVNMkihw4yu4bkBXvf1Q5i+XsxD1D
	 1IA/6UJfRG5WAHenHWGXeUYb1xJM5oXw9AnaB+39O4jVkFi0x2pz7P+l4xyUJG8d0O
	 dxbrwBvK6cqzj/JAeQK9PiCCZWReq7Ifr8xjQCOfKljUIRKauUR7vxU6jJ6xn2NbEd
	 3iwppPBrIHFObOo8bxs2aKzZLgyA+0ojbJoU1V/NXJK4IUkKtWrZ06+lV4ybGc0NKq
	 gRGWbKQF1JqH+g7lX0lgMFl6YaBk+oxIuwQj6ykSG+JMujcMCPEt4q2Dm+8rkTkw5i
	 x0V1XHBgjCh4w==
Date: Fri, 5 Dec 2025 14:00:42 +0000
From: Simon Horman <horms@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Antony Antony <antony.antony@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH ipsec] xfrm: set ipv4 no_pmtu_disc flag only on output sa
 when direction is set
Message-ID: <aTLlin9RN1N-oeMc@horms.kernel.org>
References: <17a716f13124491528d5ee4ff15019f785755d50.1764249526.git.antony.antony@secunet.com>
 <aTJ5UrS_3xPrbtSm@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTJ5UrS_3xPrbtSm@secunet.com>

On Fri, Dec 05, 2025 at 07:18:58AM +0100, Steffen Klassert wrote:
> On Thu, Nov 27, 2025 at 03:05:55PM +0100, Antony Antony wrote:
> > The XFRM_STATE_NOPMTUDISC flag is only meaningful for output SAs, but
> > it was being applied regardless of the SA direction when the sysctl
> > ip_no_pmtu_disc is enabled. This can unintentionally affect input SAs.
> > 
> > Limit setting XFRM_STATE_NOPMTUDISC to output SAs when the SA direction
> > is configured.
> > 
> > Reported-by: https://github.com/roth-m
> 
> This tag does not make much sense IMO. We neither have a
> real name nor an email address to contact.

FWIIW, I noticed that too.
And if that is all the information available
then I'd suggest dropping the tag.

