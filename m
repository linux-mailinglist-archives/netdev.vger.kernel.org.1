Return-Path: <netdev+bounces-199828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8489AE1FB8
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 18:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A97F23B1FA0
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 16:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFE32DE200;
	Fri, 20 Jun 2025 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QeNRSKWG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A432D3A6A;
	Fri, 20 Jun 2025 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750435264; cv=none; b=OioWeu4aoN2tKDJQpRQTVvZOd7VpQvA+nxU7LuqdBC/yuk+BYBsUNUFancCqmKNSr+Duan7fGzbhW7oRD99v5GePNRAbY2pxoefIgzkIHave+0UkOKmp3keymmiey8TT/l8YO9lfqKZ7fkla+ht6YQC/zoMCzMzOuXMDDx0XPIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750435264; c=relaxed/simple;
	bh=476EDcByVUDcMJq9G0/L+M1afs1hWsv5RMTIUVRlTMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEnaQM2h5vJ2AAMeOIuGob6vj22DyDdPQ3pSgvXAiYh6B2Ub4b41n6fW8UkyAzkeKU7oCH64MNn93HEZ6FjiYDMBz0UuN9UTnQiDl0PPGuSjivdXI8gPK+1trcPWGLawIT12hU5/zCEFQpu4TzI7Ud+cUZtUVWe09DhN7WySsRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QeNRSKWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F27C4CEE3;
	Fri, 20 Jun 2025 16:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750435264;
	bh=476EDcByVUDcMJq9G0/L+M1afs1hWsv5RMTIUVRlTMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QeNRSKWGt70s6g1hwBDaHF1e0D8Pd+LYbrtycRrUqtWP4xqpmf51Q62U0NHpRDVqA
	 pqBOl2B8YSaxaEhX3Fq4vtZWrImkX0Rf2jTJ7jZooe75XlMgkCsXadzhhYWETF9JAV
	 knXOlLmUBr0FCnGmWondl/AB0jOCbK554Ve2lLDA=
Date: Fri, 20 Jun 2025 18:01:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	Saravana Kannan <saravanak@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH net 0/4] net: axienet: Fix deferred probe loop
Message-ID: <2025062054-tameness-canal-2204@gregkh>
References: <20250619200537.260017-1-sean.anderson@linux.dev>
 <2025062004-sandblast-overjoyed-6fe9@gregkh>
 <56f52836-545a-45aa-8a6b-04aa589c2583@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56f52836-545a-45aa-8a6b-04aa589c2583@linux.dev>

On Fri, Jun 20, 2025 at 11:41:52AM -0400, Sean Anderson wrote:
> On 6/20/25 01:10, Greg Kroah-Hartman wrote:
> > On Thu, Jun 19, 2025 at 04:05:33PM -0400, Sean Anderson wrote:
> >> Upon further investigation, the EPROBE_DEFER loop outlined in [1] can
> >> occur even without the PCS subsystem, as described in patch 4/4. The
> >> second patch is a general fix, and could be applied even without the
> >> auxdev conversion.
> >> 
> >> [1] https://lore.kernel.org/all/20250610183459.3395328-1-sean.anderson@linux.dev/
> > 
> > I have no idea what this summary means at all, which isn't a good start
> > to a patch series :(
> > 
> > What problem are you trying to solve?
> 
> See patch 4/4.

That's not what should be in patch 0/4 then, right?

> > What overall solution did you come up with?
> 
> See patch 4/4.

Again, why write a 0/4 summary at all then?

> > Who is supposed to be reviewing any of this?
> 
> Netdev. Hence "PATCH net".
> 
> And see [1] above for background. I will quote it more-extensively next time.

Referring to random links doesn't always work as we deal with thousands
of patches daily, and sometimes don't even have internet access (like
when reviewing patches on long flights/train rides...)

Make things self-contained please.

thanks,

greg k-h

