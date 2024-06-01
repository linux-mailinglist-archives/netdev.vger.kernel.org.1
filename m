Return-Path: <netdev+bounces-99912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919E78D6FA8
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 14:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29071C20D54
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 12:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218B214F9D7;
	Sat,  1 Jun 2024 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILjt9Rou"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DF014F9D4
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717243606; cv=none; b=Swg1x2RGjelnlfbQ415YpFFRYqSN6BMPdh15VFdR7b0JiTCyYZna/RrmSUis+Od6pcNH93k4BtHqKEzaaH0RyrDbGfJjDTDt4HYum7FNNLhYN0BI3+5k7706Un0t1SD+HYC8zjKwUP5ghs0W1A8wbWo2bC7i16WnplmPlenH4po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717243606; c=relaxed/simple;
	bh=p5Sw3GRe1Lge4SnF2pmAC4IQ0ato2xmCd88hFsuZff8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWUwie9q5zeWI7xmmorOZU14wb6l7z9B7IivxAZggRKHoPIFenoTwSx2aeKLAjR3zfAUnpmtogpBy/Dh9YK412NcPoUDCHkz70HpytKMq58IkWFUWosndzecZQ4MdT+YO2kLMe+fx4qd3BUazBqEpumxzZzlrcvUp1ZHIynqCQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILjt9Rou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4ED9C116B1;
	Sat,  1 Jun 2024 12:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717243605;
	bh=p5Sw3GRe1Lge4SnF2pmAC4IQ0ato2xmCd88hFsuZff8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILjt9RouX1ucqRipERDIi+L/u5HdPvHVds7Ws10gho3vykMKgAg3HbaYTVcKm/PaW
	 7c3PQePyZi24BoY0mqWrphT1ZP7wBlS24+9NU9kXI0+13wrKKOPo/rZnhWifG9Cu6I
	 SMomQxlUTdXhDkrEl0SnCXiiOVyfW69RQCf03Ne8hSMvuk2BmAAKTICn2t77a4IjSz
	 UTaYleqf0RwHNvZViknzYuUejkBw0jbYpcs8Nwcow8xzHRfsbmi5mVrMbnwFu8tM7N
	 z4TzPON4rzXbgA8NUE7TvUiVDrl5gD5LG7jp5PqKrLXBJxciJeTn+FeRe+IfQJXCU/
	 tXKxznl4dh8AQ==
Date: Sat, 1 Jun 2024 13:06:41 +0100
From: Simon Horman <horms@kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc: "Zaki, Ahmed" <ahmed.zaki@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Guo, Junfeng" <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-next v2 11/13] ice: enable FDIR filters from raw
 binary patterns for VFs
Message-ID: <20240601120641.GH491852@kernel.org>
References: <20240527185810.3077299-1-ahmed.zaki@intel.com>
 <20240527185810.3077299-12-ahmed.zaki@intel.com>
 <20240531131802.GG123401@kernel.org>
 <f2cf6650-a164-4d3c-a3d9-cc57c66069a5@intel.com>
 <CO1PR11MB50893931EC0BE4F79FA46761D6FD2@CO1PR11MB5089.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CO1PR11MB50893931EC0BE4F79FA46761D6FD2@CO1PR11MB5089.namprd11.prod.outlook.com>

On Sat, Jun 01, 2024 at 12:24:14AM +0000, Keller, Jacob E wrote:
> 
> 
> > -----Original Message-----
> > From: Zaki, Ahmed <ahmed.zaki@intel.com>
> > Sent: Friday, May 31, 2024 8:48 AM
> > To: Simon Horman <horms@kernel.org>
> > Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Keller, Jacob E
> > <jacob.e.keller@intel.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> > Guo, Junfeng <junfeng.guo@intel.com>; Marcin Szycik
> > <marcin.szycik@linux.intel.com>
> > Subject: Re: [PATCH iwl-next v2 11/13] ice: enable FDIR filters from raw binary
> > patterns for VFs
> > 
> > 
> > 
> > On 2024-05-31 7:18 a.m., Simon Horman wrote:
> > > On Mon, May 27, 2024 at 12:58:08PM -0600, Ahmed Zaki wrote:
> > >> From: Junfeng Guo <junfeng.guo@intel.com>
> > >
> > > To me tweaking the order of includes seems to indicate
> > > that something isn't quite right. Is there some sort of
> > > dependency loop being juggled here?
> > 
> > This was needed because of the changes in ice_flow.h, struct ice_vsi is
> > now used. I will check if there is a better fix.
> > 
> 
> I think there is probably a dependency loop. Ice has had a lot of issues w.r.t. header includes ☹

Understood, let's leave that for another day :)

