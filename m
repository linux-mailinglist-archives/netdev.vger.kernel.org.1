Return-Path: <netdev+bounces-209956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C871B11789
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 07:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4756540D98
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 05:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122B123CEE5;
	Fri, 25 Jul 2025 05:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wd4dLo2T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64101DED40;
	Fri, 25 Jul 2025 05:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753419749; cv=none; b=qMPDKguipWxk7s9GFcpuAIfUR0OkFH9G7nDEbkJRTuG6ol6dTP1OHu1JD6d1JByt+aIpbp9vUzH3IJKnFq/TJ/aTgE3z45bxwpYYN50Md3i7F79VbqLdZ0qaQSeZKyoCRlKh/7AfVgUTJnHyLJn4nlwoAcO0jGu7Y+DxZuoOIO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753419749; c=relaxed/simple;
	bh=wDByJ5uADwgkr25ymazjxmukAUNM4cHMm2vqVskCphs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAERGeQfO9PlEWKUaOi9XHrfNTA63BJ7LCccnVGd6JocuOxKUg2ua9NbSui+zemGkJ/4G8m6w+E7QSHv6vSmjQlcPOXLx0REWeOeCSSBhUQTKPQP9Z1WI1SP9Khbj2JSCyc3FDt4FD8dTq3MbJuCVHG28GY5Oue0nwnmxOt3qA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wd4dLo2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE946C4CEF5;
	Fri, 25 Jul 2025 05:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753419748;
	bh=wDByJ5uADwgkr25ymazjxmukAUNM4cHMm2vqVskCphs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wd4dLo2T/szStSn24bnGbyUfbKYvCzTtBhtlaBgG7nKRFlbJSpb5YnW6oueFA2dru
	 zyeLW8XIbPSGsNHy7n5zXia/QW5opr+BGL7nTRfLLH8G4I0E260fQLZT6DWu01pDlf
	 xc9C6Bn/lr0zX4ebXSdvxn2khOHREMigrJ1vq4A0=
Date: Fri, 25 Jul 2025 07:02:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Leon Romanovsky <leon@kernel.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Dave Ertman <david.m.ertman@intel.com>,
	Saravana Kannan <saravanak@google.com>,
	linux-kernel@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH net v2 1/4] auxiliary: Support hexadecimal ids
Message-ID: <2025072543-senate-hush-573d@gregkh>
References: <2025071747-icing-issuing-b62a@gregkh>
 <5d8205e1-b384-446b-822a-b5737ea7bd6c@linux.dev>
 <2025071736-viscous-entertain-ff6c@gregkh>
 <03e04d98-e5eb-41c0-8407-23cccd578dbe@linux.dev>
 <2025071726-ramp-friend-a3e5@gregkh>
 <5ee4bac4-957b-481a-8608-15886da458c2@linux.dev>
 <20250720081705.GE402218@unreal>
 <e4b5e4fa-45c4-4b67-b8f1-7d9ff9f8654f@linux.dev>
 <20250723081356.GM402218@unreal>
 <991cbb9a-a1b5-4ab8-9deb-9ecea203ce0f@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <991cbb9a-a1b5-4ab8-9deb-9ecea203ce0f@linux.dev>

On Thu, Jul 24, 2025 at 09:55:59AM -0400, Sean Anderson wrote:
> On 7/23/25 04:13, Leon Romanovsky wrote:
> > On Mon, Jul 21, 2025 at 10:29:32AM -0400, Sean Anderson wrote:
> >> On 7/20/25 04:17, Leon Romanovsky wrote:
> >> > On Thu, Jul 17, 2025 at 01:12:08PM -0400, Sean Anderson wrote:
> >> >> On 7/17/25 12:33, Greg Kroah-Hartman wrote:
> >> > 
> >> > <...>
> >> > 
> >> >> Anyway, if you really think ids should be random or whatever, why not
> >> >> just ida_alloc one in axiliary_device_init and ignore whatever's
> >> >> provided? I'd say around half the auxiliary drivers just use 0 (or some
> >> >> other constant), which is just as deterministic as using the device
> >> >> address.
> >> > 
> >> > I would say that auxiliary bus is not right fit for such devices. This
> >> > bus was introduced for more complex devices, like the one who has their
> >> > own ida_alloc logic.
> >> 
> >> I'd say that around 2/3 of the auxiliary drivers that have non-constant
> >> ids use ida_alloc solely for the auxiliary bus and for no other purpose.
> >> I don't think that's the kind of complexity you're referring to.
> >> 
> >> >> Another third use ida_alloc (or xa_alloc) so all that could be
> >> >> removed.
> >> > 
> >> > These ID numbers need to be per-device.
> >> 
> >> Why? They are arbitrary with no semantic meaning, right?
> > 
> > Yes, officially there is no meaning, and this is how we would like to
> > keep it.
> > 
> > Right now, they are very correlated with with their respective PCI function number.
> > Is it important? No, however it doesn't mean that we should proactively harm user
> > experience just because we can do it.
> > 
> > [leonro@c ~]$ l /sys/bus/auxiliary/devices/
> > ,,,
> > rwxrwxrwx 1 root root 0 Jul 21 15:25 mlx5_core.rdma.0 -> ../../../devices/pci0000:00/0000:00:02.7/0000:0
> > 8:00.0/mlx5_core.rdma.0
> > lrwxrwxrwx 1 root root 0 Jul 21 15:25 mlx5_core.rdma.1 -> ../../../devices/pci0000:00/0000:00:02.7/0000:0
> > 8:00.1/mlx5_core.rdma
> 
> Well, I would certainly like to have semantic meaning for ids. But apparently
> that is only allowed if you can sneak it past the review process.

Do I need to dust off my "make all ids random" patch again and actually
merge it just to prevent this from happening?

greg k-h

