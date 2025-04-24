Return-Path: <netdev+bounces-185679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DD7A9B51B
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 19:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A82B5A2240
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3522928B510;
	Thu, 24 Apr 2025 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOGHdP2l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ACD4438B;
	Thu, 24 Apr 2025 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745515141; cv=none; b=ILrL/pYEVQPtBAZHNasu8B2qbZWryjjG1hKmeSCZJtbXCpMcOQLIe2i/YZuCdhirSHUh8PLxR7EkJTFMARIBmybQFPXHmheGae7aiYjWOzcFiE1WWfs4GdJOMAAzWjxS2xM/qhKilo6UM6r7d7BOGT1PiuQmyaRkqnmwXMKZjOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745515141; c=relaxed/simple;
	bh=UTw/8mwpp1aAVyqy5jlKWuEcFbcgEiGTY6G17jcDkik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuTwTjkTcKLkqKDqTR+ckhZOTx90Ts0a4ZvFGGIYfDJYv3Zv9PyRtKREjjjn367mSZCml3rZjNEIrNv230lKgvKrTE6RE/5vyAlA/c9PlK2zvnTPO72iBa7KhOuqrM/36HhwxlsO5yxGnJg+zw3BeI2KTk+8We6N0StU/qAhtQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOGHdP2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63044C4CEE3;
	Thu, 24 Apr 2025 17:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745515140;
	bh=UTw/8mwpp1aAVyqy5jlKWuEcFbcgEiGTY6G17jcDkik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KOGHdP2l+R7HFxRxhUl8RIBFTlITlwCa0aHlQw7QjEU/k/OgkcstzDPfdLF8JBFiG
	 NVpRMKXz29UjZtdZATZ0MJrECO7uEAhbjD3tXzsmDz5IQ4jltIVPcbShwMTCc2BP45
	 U2DqYiHVAV4ne7gD9Y87xo2mZAVjgFj38Cnpd113JUZP/WMt2G16os8WSVp7q3vyuF
	 Go2A0YY9kbXsgqTrPZBSUS5XxrpMe8yi5UjIcMe/jtt2tGQhsV56puE/7nqQ+LHpz5
	 MJqVoj4kA0liuBNJfU1/ooMjL54loJtTnK76hMYHi0qIpGI2arB9Do177Il2OQIjuo
	 LbThoRp4li7dQ==
Date: Thu, 24 Apr 2025 18:18:56 +0100
From: Simon Horman <horms@kernel.org>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] e1000e: disregard NVM checksum on tgp when valid
 checksum mask is not set
Message-ID: <20250424171856.GK3042781@horms.kernel.org>
References: <5555d3bd-44f6-45c1-9413-c29fe28e79eb@jacekk.info>
 <20250424162444.GH3042781@horms.kernel.org>
 <dc357533-f7e3-49fc-9a27-4554eb46fd43@jacekk.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc357533-f7e3-49fc-9a27-4554eb46fd43@jacekk.info>

On Thu, Apr 24, 2025 at 06:46:45PM +0200, Jacek Kowalski wrote:
> > > Fixes: 4051f68318ca9 ("e1000e: Do not take care about recovery NVM
> > > checksum")
> > 
> > I think that while the commit cited above relates to this problem, this
> > bug actually dates back to the patch I'm citing immediately below. And I
> > think we should cite that commit here. IOW, I'm suggesting:
> > 
> > Fixes: fb776f5d57ee ("e1000e: Add support for Tiger Lake")
> 
> I had my doubts when choosing a commit for the "Fixes" tag, but since
> my setup would most likely work up until 4051f68318ca9, I selected it
> specifically.
> 
> On my laptop NVM write attempt does (temporarily) fix a checksum
> and makes driver loading possible. Only after 4051f68318ca9, which
> disabled this code path (because it broke someone else's setup), I'd
> be unable to use my network adapter anymore.

Thanks, in that case things aren't as clear as I had assumed
when writing my previous email.

If the problem only occurs after 4051f68318ca9 then I think
it is fine to use that commit in the Fixes tag.

Although I do wonder if commit 4051f68318ca9 is backported,
will this patch (once accepted) end up being backported far enough?

