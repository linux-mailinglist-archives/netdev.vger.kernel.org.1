Return-Path: <netdev+bounces-217783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9818DB39D3A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B564607FE
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F6830F958;
	Thu, 28 Aug 2025 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SlmLv/AV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E7230F539;
	Thu, 28 Aug 2025 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383941; cv=none; b=fptpePVFO+MSB+4TdkBfuNd3zjgj6QOMXDAfFKar193hYaRRXcN2Py8GSiZSvieNJIMpOh5wMQeu18UXo4FOeNMqgVWm3hF/GuKQCKlIvGCKkJZVNipY9/f4Wapu7IYC6CXv0NCDV0kkk77U9ExsbK6NNWThfZ7b6iMGB21wFKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383941; c=relaxed/simple;
	bh=55pOfAEwdUFshkttiSg6HMTkC44P6HWHjEh17urY36Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EP/f+WC9+wYYo3wDfg+zRVf2HE++fsQf3k6AaZ6jpvltO6n/3Ox2/mYz6csoi+fKNhKoaZHaBu2B52Ok0Sjk8AAXwG75puA7jjJamhsYmkOG02dH1bwNwzL5Y0fXTLi/PONld/95/dNMnT4mGHo/VG20ud/p9gL/zeIkWuu4pHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SlmLv/AV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YJDph0fXZVk4m3ieOM7hmiCyKRXpxhXzgl8fdbR1bTI=; b=SlmLv/AV1LP/FS2SqD7LO7GGjN
	dn2NeprwgVsDrSNR2Ocxi7ij+yGusWyE3BfqOle/SFz/+XxVzyP7c4sMEbOQXki77wk2cIfH+WfTF
	guErJNOY9UEx0uRg+D1g0hOKEnknp7tsg4OlOlMCcjCYLJQQyeUtXK3k4OGQey0kuFW0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1urbgt-006LSS-LX; Thu, 28 Aug 2025 14:25:19 +0200
Date: Thu, 28 Aug 2025 14:25:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Konrad Leszczynski <konrad.leszczynski@intel.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, davem@davemloft.net,
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, cezary.rojewski@intel.com,
	sebastian.basierski@intel.com
Subject: Re: [PATCH net-next 0/7] net: stmmac: fixes and new features
Message-ID: <f77cb80c-d4b2-4742-96cb-db01fbd96e0e@lunn.ch>
References: <20250826113247.3481273-1-konrad.leszczynski@intel.com>
 <e4cb25cb-2016-4bab-9cc2-333ea9ae9d3a@linux.dev>
 <9e86a642-629d-42e9-9b70-33ea5e04343a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e86a642-629d-42e9-9b70-33ea5e04343a@intel.com>

On Thu, Aug 28, 2025 at 08:47:02AM +0200, Konrad Leszczynski wrote:
> 
> On 26-Aug-25 19:29, Vadim Fedorenko wrote:
> > On 26/08/2025 12:32, Konrad Leszczynski wrote:
> > > This series starts with three fixes addressing KASAN panic on ethtool
> > > usage, Enhanced Descriptor printing and flow stop on TC block setup when
> > > interface down.
> > > Everything that follows adds new features such as ARP Offload support,
> > > VLAN protocol detection and TC flower filter support.
> > 
> > Well, mixing fixes and features in one patchset is not a great idea.
> > Fixes patches should have Fixes: tags and go to -net tree while features
> > should go to net-next. It's better to split series into 2 and provide
> > proper tags for the "fixes" part
> 
> Hi Vadim,
> 
> Thanks for the review. I've specifically placed the fixes first and the
> features afterwards to not intertwine the patches. I can split them into two
> patchsets if you think that's the best way to go.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

You probably need to wait a week between the fixes and new features in
order that net and net-next are synced.

    Andrew

---
pw-bot: cr
	

