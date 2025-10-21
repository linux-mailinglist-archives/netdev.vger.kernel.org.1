Return-Path: <netdev+bounces-231421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFFBBF929E
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 00:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198DC18974DB
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 22:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8022BEC2A;
	Tue, 21 Oct 2025 22:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVDctv+2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A85C296BD8
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761087390; cv=none; b=YQZQUFKJ/2Qh1MlYB9xn/aRFVguHNKsr7SjxC+I3aLCMhLZYSZPMvHOPRbiCCqUcNc885VnCGj7KQkQBXUPTtzMiPzKbzMRT2R2CPWpFRQ1NHys526ytE2c+RkLx3uv93+JmnOv+syEAGrTtItM022CFWm7T4aVCAQOoG//VmiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761087390; c=relaxed/simple;
	bh=lQIy5OmM0g4Bx04XenAx/SMjMc7ULEgLvmSxKg2NdTo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCEjFZSJd3nBHNXRPichucif+9wgFe55JUXWv6YfUPDixux8SiOzJkkR7ZfiAIfSJYrN6g/9sWlmqscxXifgnApv5wjzYUYYClPdUJehp03vHrqgDgmtqwDgw4JnWtgXIKfI+OXxNuH5Oddfb12/KlxK7gzxzJHq6eSujgzj2DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVDctv+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C9CC4CEF1;
	Tue, 21 Oct 2025 22:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761087389;
	bh=lQIy5OmM0g4Bx04XenAx/SMjMc7ULEgLvmSxKg2NdTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HVDctv+2OwEwZI9Z2aAwvDCA6Dsk6V19t+fkSBGNC9mIigKJuoSi67PAEIoqDmkPx
	 /UgU/is9sBT7rNVCq8OYSdczZXCTIvqF0bQW0SL34Ks1jXu6J3mKSx9IXQIxi1S50s
	 ewkeaDb6kvA4fj2ONF4n3MNykp99MVwpoP5jsV3h3Y0E2xVp8SGbzxunZT5ADDnelA
	 3T1Sxs/hscB3/4/M13lnYeqG04+JU8n46nTHL+6n8OGyCd4v5sGbfkbaVcN/PRy4Bb
	 qnIevgRn4iXPISlpk3pQYWHlnpxrBX8hKGz98Zq1qMjfCa0fAa33plqhkkBfE4ybmK
	 oo8dcqCS1Babg==
Date: Tue, 21 Oct 2025 15:56:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wilder <wilder@us.ibm.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "jv@jvosburgh.net" <jv@jvosburgh.net>, Pradeep
 Satyanarayana <pradeep@us.ibm.com>, "i.maximets@ovn.org"
 <i.maximets@ovn.org>, Adrian Moreno Zapata <amorenoz@redhat.com>, Hangbin
 Liu <haliu@redhat.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "horms@kernel.org" <horms@kernel.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "edumazet@google.com"
 <edumazet@google.com>, Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net-next v13 6/7] bonding: Update for extended
 arp_ip_target format.
Message-ID: <20251021155628.7383bfca@kernel.org>
In-Reply-To: <MW3PR15MB3913E83123930C417DDD1AC8FAE9A@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20251013235328.1289410-1-wilder@us.ibm.com>
	<20251013235328.1289410-7-wilder@us.ibm.com>
	<ef443366-f841-4a84-9409-818fc31b2c0c@redhat.com>
	<20251016124908.759bbb63@kernel.org>
	<MW3PR15MB3913E83123930C417DDD1AC8FAE9A@MW3PR15MB3913.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 00:21:02 +0000 David Wilder wrote:
> > > I guess you should update bond_get_size() accordingly???
> > >
> > > Also changing the binary layout of an existing NL type does not feel
> > > safe. @Jakub: is that something we can safely allow?  
> >
> > In general extending attributes is fine, but going from a scalar
> > to a struct is questionable. YNL for example will not allow it.  
> 
> I am not sure I understand your concern. I have change the
> netlink socket payload from a fixed 4 bytes to a variable number of bytes.
> 4 bytes for ipv4 address followed by some number of bytes with the
> list of vlans, could be zero. Netlink sockets just need to be told the
> payload size.  Or have I missed the point?

Are you replacing a line that says nla_put() which outputs raw bytes
or a line which says nla_put_x32() which outputs a scalar?
What I'm saying is that while growing raw byte attrs is pretty common
in Netlink, replacing a scalar with a struct may cause user space
to reject the attrs.

> > I haven't looked at the series more closely until now.
> >
> > Why are there multiple vlan tags per target?  
> 
> You can have a vlan inside a vlan, the original arp_ip_target
> option code supported this.
> 
> > Is this configuration really something we should support in the kernel?
> > IDK how much we should push "OvS-compatibility" into other parts of the
> > stack. If user knows that they have to apply this funny configuration
> > on the bond maybe they should just arp from user space?  
> 
> This change is not just for compatibility with OVS. Ilya Maximets pointed out:
> "..this is true not only for OVS.  You can add various TC qdiscs onto the
> interface that will break all those assumptions as well, for example.  Loaded
> BPF/XDP programs will too."
> 
> When using the arp_ip_target option the bond driver must discover what
> vlans are in the path to the target. These special arps must be generated by
> the bonding driver to know what bonded slave the packets is to sent and
> received on and at what frequency.
> 
> When the the arp_ip_target feature was first introduced discovering vlans in the
> path to the target was easy by following the linked net_devices. As our
> networking code has evolved this is no longer possible with all configurations
> as Ilya pointed out.  What I have done is provide alternate way to provide the
> list of vlans so this desirable feature can continue to function.

I understand your perspective. I'm not convinced that kernel must
support such custom configurations, if it can't infer the correct
behavior from information it already has.

I don't feel strongly about it, if you manage to collect a review 
tag from the bonding maintainers or another netdev maintainer I won't
stand in the way. Otherwise, given that the uAPI is questionable and
there's total of 0 review tags on v13, this series is starting to look
like a dead end.

