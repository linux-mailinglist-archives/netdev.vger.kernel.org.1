Return-Path: <netdev+bounces-230191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FEFBE529B
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 21:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DEA51AA0436
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 19:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E4D23D7D9;
	Thu, 16 Oct 2025 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D217VmIn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8630923C516;
	Thu, 16 Oct 2025 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641394; cv=none; b=jsDgidVci49kGN/FOQqlDj8lOuCi5UiRnaTXENkFwm0n/Sk/Qo7ApUsxu3gDEULsso+QANGk9NPAifHPXssBfHv1rI/gn5kKItPni+0tYxgWibuFJah+YIy59+opTC48w5u6B7fVE1Ol9iDEwlT0/WmMogYnPBtC8fWBMJ5pivk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641394; c=relaxed/simple;
	bh=/svoWHeXOS5kyJXHlew/DzxM7PeeoVPP4zawYSZ0BBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzD4V7ijFbwr6Wqjkv3U45XnKkWm56gHvKgOYkRiiRWUtqyZGC4NOkbim2eBLfe5PG1zu2UF724WjbAXQxErSd0YNUFWfNEusehf5mjhLxods4Q1JBJnjVFio+Q3tzy5eNVX7xx4DG+aDZpacvwFUI4CPLYdBc36P/s9im7Erfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D217VmIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B287C4CEF1;
	Thu, 16 Oct 2025 19:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760641394;
	bh=/svoWHeXOS5kyJXHlew/DzxM7PeeoVPP4zawYSZ0BBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D217VmIns/z5GA+fv8iF5JXLetra8+kbwzk/1qKgHsww226jfwCLdSRKYCHa2zkQc
	 Gja7iIsZ13AIs0GduApLg2/IunDfD9KXqhPwGGEjicdzyWMYh7kOk0MJQVDmJhFqI6
	 lLi100fx2DeAwJu8U/soLf1xfZjzbOY79+k3oG6tbMz00Z3lDOEFlYZk3DX/qzOXP6
	 w2QFy/bA+xPTP1jr2SYF6EdNEbA7+aRIbPf8lhEob59XRqr7JfxLOZfOvvRSsCZdF3
	 id4BqbkPJMAFTEt2/q8UjQ9OFv0sTZZ7yNPEUg2tOJCBxA72rNfGZBGWzgMTDpMSFp
	 fZ0AoJEThsvng==
Date: Thu, 16 Oct 2025 20:03:07 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dan Nowlin <dan.nowlin@intel.com>,
	Qi Zhang <qi.z.zhang@intel.com>, Jie Wang <jie1x.wang@intel.com>,
	Junfeng Guo <junfeng.guo@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next 06/14] ice: Extend PTYPE bitmap coverage for GTP
 encapsulated flows
Message-ID: <aPFBazc43ZYNvrz7@horms.kernel.org>
References: <20251015-jk-iwl-next-2025-10-15-v1-0-79c70b9ddab8@intel.com>
 <20251015-jk-iwl-next-2025-10-15-v1-6-79c70b9ddab8@intel.com>
 <aPDjUeXzS1lA2owf@horms.kernel.org>
 <64d3e25a-c9d6-4a43-84dd-cffe60ac9848@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64d3e25a-c9d6-4a43-84dd-cffe60ac9848@intel.com>

On Thu, Oct 16, 2025 at 10:20:25AM -0700, Jacob Keller wrote:
> 
> 
> On 10/16/2025 5:21 AM, Simon Horman wrote:
> > On Wed, Oct 15, 2025 at 12:32:02PM -0700, Jacob Keller wrote:
> >> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> >>
> >> Consolidate updates to the Protocol Type (PTYPE) bitmap definitions
> >> across multiple flow types in the Intel ICE driver to support GTP
> >> (GPRS Tunneling Protocol) encapsulated traffic.
> >>
> >> Enable improved Receive Side Scaling (RSS) configuration for both user
> >> and control plane GTP flows.
> >>
> >> Cover a wide range of protocol and encapsulation scenarios, including:
> >>  - MAC OFOS and IL
> >>  - IPv4 and IPv6 (OFOS, IL, ALL, no-L4)
> >>  - TCP, SCTP, ICMP
> >>  - GRE OF
> >>  - GTPC (control plane)
> >>
> >> Expand the PTYPE bitmap entries to improve classification and
> >> distribution of GTP traffic across multiple queues, enhancing
> >> performance and scalability in mobile network environments.
> >>
> >> --
> > 
> > Hi Jacob,
> > 
> > Perhaps surprisingly, git truncates the commit message at
> > the ('--') line above. So, importantly, the tags below are absent.
> > 
> 
> Its somewhat surprising, since I thought you had to use '---' for that.
> Regardless, this shouldn't be in the commit message at all.
> > Also, the two lines below seem out of place.
> > 
> >>  ice_flow.c |   54 +++++++++++++++++++++++++++---------------------------
> >>  1 file changed, 26 insertions(+), 26 deletions(-)
> >>
> 
> Yep these shouldn't have been here at all. I checked, and for some
> reason it was included in the original message id of the patch. b4
> happily picked it up when using b4 shazam.
> 
> See:
> https://lore.kernel.org/intel-wired-lan/20250915133928.3308335-5-aleksandr.loktionov@intel.com/
> 
> I am not sure if this is the fault of b4, though it has different
> behavior than other git tooling here.

TBH, I am also surprised that git truncates at '--'. I also thought
'---'. And as this is the second time it's come up recently,
while I don't recall seeing it before, perhaps due to some tooling change
somewhere: e.g. interaction between git and b4.

> I fixed this on my end, and can resubmit after the 24hr period if needed.

FWIIW, I'd lean towards reposting after 24h if you don't hear from one of
the maintainers.



