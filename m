Return-Path: <netdev+bounces-188393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E529DAACA4B
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 18:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DAD3ACC4A
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 15:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181B9284676;
	Tue,  6 May 2025 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGt6rFDo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB5D283FF6;
	Tue,  6 May 2025 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547207; cv=none; b=VSmZAQQU82fVS+Dv9y7WKZ7syBvFmrmj9KKBlmDYf+ydf7Kf3wVwCP8d9OpmLuZ6CMHNdI2Rwl95+ZbLY8zz0koXwxm9ZQ9RVOi1qs4HRDVGK3Y3tek7C1BKS2ONc6UAH+MgIfVGEtdzwx4oBaRYCwDvS2GllCbVSUXqipx48GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547207; c=relaxed/simple;
	bh=szbW/T48e07o7nsdAtspJ3TqCa91gXQ5dwM1QNp7ZX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0d4Hh5r+g9mkyMeI2NaWOuisu9tMNsPi6ioQp1/JosDRvDw9cqVD+iNz8/dzFXnPobnxAQoWthRd74L2vDQsRMcp+ohqnWvTzxP+3KC4SWuJFK1rZLKG4XLA1VUnGi/kZwok15HHBoNlUrQMuxbmAz+4lrQf066OlYTLqMBmVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGt6rFDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E42C4CEE4;
	Tue,  6 May 2025 16:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746547206;
	bh=szbW/T48e07o7nsdAtspJ3TqCa91gXQ5dwM1QNp7ZX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MGt6rFDota1d2WLpw7YKaQYlev1YgRkYOc97GjSpPzuQaqANHfObtJFxL0NbA9jpV
	 fqrNNUZV6D7tKBJK6R5rWmTPS9NmzWrBJuGVo32+kLhVmLb41NkVmC1cWPEmfC4y3Q
	 DcDYZDkvzEftF40AffVwywKhmBK5CyHg3Ka1heSiEfTi6SGf+mgEe63VThumLnTS0d
	 NMiksZH4+DB/niW4uVrKhq+W5sayApdu9lNAXx8fPSdFSBLf1s+e9ErWFxTYPlJ9uS
	 R54vHMJTjmcSfkDO3TsLYJazLU29CDW04BydjOh/w93ZxqsULPkQZsCJ9OPvz+FxZd
	 1JOwKPeANPx8g==
Date: Tue, 6 May 2025 16:59:58 +0100
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Lee Trager <lee@trager.us>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	Milena Olech <milena.olech@intel.com>, pavan.kumar.linga@intel.com,
	"Singhai, Anjali" <anjali.singhai@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 01/14] virtchnl: create
 'include/linux/intel' and move necessary header files
Message-ID: <20250506155958.GT3339421@horms.kernel.org>
References: <20250424113241.10061-1-larysa.zaremba@intel.com>
 <20250424113241.10061-2-larysa.zaremba@intel.com>
 <20250428161542.GD3339421@horms.kernel.org>
 <10fd9a4b-f071-47eb-bdde-13438218aee9@intel.com>
 <20250430085545.GT3339421@horms.kernel.org>
 <aBhvNfWP-Rmec3Ci@soc-5CG4396X81.clients.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBhvNfWP-Rmec3Ci@soc-5CG4396X81.clients.intel.com>

On Mon, May 05, 2025 at 09:56:37AM +0200, Larysa Zaremba wrote:
> On Wed, Apr 30, 2025 at 09:55:45AM +0100, Simon Horman wrote:
> > On Tue, Apr 29, 2025 at 11:47:58AM -0700, Jacob Keller wrote:
> > > On 4/28/2025 9:15 AM, Simon Horman wrote:
> > > > On Thu, Apr 24, 2025 at 01:32:24PM +0200, Larysa Zaremba wrote:

...

> > > >> diff --git a/MAINTAINERS b/MAINTAINERS
> > > >> index 657a67f9031e..2e2a57dfea8f 100644
> > > >> --- a/MAINTAINERS
> > > >> +++ b/MAINTAINERS
> > > >> @@ -11884,8 +11884,8 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
> > > >>  F:	Documentation/networking/device_drivers/ethernet/intel/
> > > >>  F:	drivers/net/ethernet/intel/
> > > >>  F:	drivers/net/ethernet/intel/*/
> > > >> -F:	include/linux/avf/virtchnl.h
> > > >> -F:	include/linux/net/intel/iidc.h
> > > >> +F:	include/linux/intel/iidc.h
> > > >> +F:	include/linux/intel/virtchnl.h
> > > > 
> > > > I'm not sure that I understand the motivation for moving files out of
> > > > include/linux/net, but I guess the answer is that my suggestion, which
> > > > would be to move files into include/linux/net, is somehow less good.
> > > > 
> > > > But if file are moving out of include/linux/net then I think it would
> > > > make sense to make a corresponding update to NETWORKING DRIVERS.
> > > > 
> > > > Also, include/linux/intel, does feel a bit too general. These files
> > > > seem to relate to NICs (of some sort of flavour or another). But Intel
> > > > does a lot more than make NICs.
> > > > 
> > > 
> > > 'include/linux/net/intel' seems fine to me. I agree with moving
> > > virtchnl.h there since it is quite clear that any historical ambitions
> > > about AVF being vendor agnostic are long dead, so having it in its own
> > > 'non-intel' folder is silly.
> > > 
> > > Strictly speaking, I think the goal of moving the files is due to the
> > > fact that a lot of the core ixd code is not really network layer but
> > > instead PCI layer.
> > 
> > Sure. I was more thinking out loud in my previous email than requesting any
> > action. Thanks for filling in my understanding of the situation.
> >
> 
> Olek suggested this because intel was the only resident in include/linux/net and 
> include/linux/intel was vacant.
>  
> > But could we please consider updating NETWORKING DRIVERS so
> > that get_maintainers.pl can help people to CC netdev and it's maintainers
> > as appropriate?
> 
> I am not sure what kind of update do you mean, include/linux/net directory was 

Thanks I missed that.

> not under any maintainer. include/linux/mlx5 and include/linux/mlx4 are only 
> under vendor maintainers.
> 
> For sure I should add include/linux/intel/* under Tony.
> Do you think it also should be added to general networking maintainers?

I think it would make sense to add it to general networking, or at least
those files that would tend to be updated via netdev. But at least let's
put the directory under Tony so it's maintained by somebody.

