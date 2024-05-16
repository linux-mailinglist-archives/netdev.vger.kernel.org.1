Return-Path: <netdev+bounces-96800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74938C7E08
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 23:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB279B21428
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 21:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A6815820F;
	Thu, 16 May 2024 21:30:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD4C1581E7;
	Thu, 16 May 2024 21:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715895020; cv=none; b=CtaBvHcPVNiPtc27MxeZK0f6iaKIfQTH8oHvBp0gD/MChPQBgEF6epMLWTXhf8AJBz50SLSQzDEPFDbn0fIktA+ldAY++CMQrfR5n0v540BjB5d8/xLgth76hXpDoCfeKqs2flyHmKIMF7QrZXuDQLB9Ljb0CMfTW/0QfjxOk/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715895020; c=relaxed/simple;
	bh=6q2nWa2SrVoqw58skrR0PsQ4PkkG7VEnK6C9KKhOYVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyJ4j0ycrWNe8Ubwj+yzqWZIPHNrqaFvfy1TWdIFJDMdmyoHeHjuINEdZ2Yd05KLbvlkZ+ox6SplxW+3VspkWd/reEhIiZxTlVa0RObwg/mAsbik9cH9GwvwGIzaR7t+BIMbBIJtlQ1nR+CENVPgiw1wcbtTLBD1m8ihPTllDts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gnumonks.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gnumonks.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.94.2)
	(envelope-from <laforge@gnumonks.org>)
	id 1s7ifs-00FLNt-Ly; Thu, 16 May 2024 23:30:04 +0200
Received: from laforge by localhost.localdomain with local (Exim 4.97)
	(envelope-from <laforge@gnumonks.org>)
	id 1s7ifo-00000004ZaZ-1Qrr;
	Thu, 16 May 2024 23:30:00 +0200
Date: Thu, 16 May 2024 23:30:00 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>
Subject: Re: [Intel-wired-lan] [PATCH net-next v6 00/21] ice: add PFCP filter
 support
Message-ID: <ZkZ62F_iCCOf4nmM@nataraja>
References: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
 <ZkSivjg7uZsA20ft@nataraja>
 <ZkXjfeLhB9T5MLfX@mev-dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkXjfeLhB9T5MLfX@mev-dev>

Hi Michal,

thanks for your response.

On Thu, May 16, 2024 at 12:44:13PM +0200, Michal Swiatkowski wrote:

> > I'm curious to understand why are *pfcp* packets hardware offloaded?
> > PFCP is just the control plane, similar to you can consider netlink the
> > control plane by which userspace programs control the data plane.
> > 
> > I can fully understand that GTP-U packets are offloaded to kernel space or
> > hardware, and that then some control plane mechanism like PFCP is needed
> > to control that data plane.  But offloading packets of that control
> > protocol?
> 
> It is hard for me to answer your concerns, because oposite to you, I
> don't have any experience with telco implementations. We had client that
> want to add offload rule for PFCP in the same way as for GTP. 

I've meanwhile done some reading and it seems there are indeed some
papers suggesting that in specific implementations of control/data plane
splits, the transaction rate between control and data plane (to set up /
tear down / modify tunnels) is to low.  As a work-around, the entire
PFCP parsing is then off-loaded into (e.g. P4 capable) hardware.

So it seems at least there appears to be equipment where PFCP offloading
is useful to significantly incresae performance.

For those curious, https://faculty.iiitd.ac.in/~rinku/resources/slides/2022-sosr-accelupf-slides.pdf
seems to cover one such configuration where offloading processing the
control-plane protocol into the P4 hardware switch has massively
improved the previously poor PFCP processing rate.

> Intel
> hardware support matching on specific PFCP packet parts. We spent some
> time looking at possible implementations. As you said, it is a little
> odd to follow the same scheme for GTP and PFCP, but it look for me like
> reasonable solution.

Based on what I understand, I am not sure I would agree with the
"reasonable solution" part.  But then of course, it is a subjective
point of view.

I understand and appreciate the high-level goal of giving the user some
way to configure a specific feature of an intel NIC.

However, I really don't think that this should come at the expense of
introducing tunnel devices (or other net-devs) for things that are not
tunnels, and by calling things PFCP whcih are not an implementation of
PFCP.

Tou are introducing something called "pfcp" into the kernel,
whcih is not pfcp.  What if somebody else at some point wanted to
introduce some actual PFCP support in some form?  How should they call
their sub-systems / Kconfigs / etc?  They could no longer call it simply
"pfcp" as you already used this very generic term for (from the
perspective of PFCP) a specific niche use case of configuring a NIC to
handle all of PFCP.

> Do you have better idea for that?

I am not familiar with the use cases and the intel NICs and what kind of
tooling or third party software might be out there wanting to configure
it.  It's really not my domain of expertise and as such I have no
specific proposal, sorry.

It just seems mind-boggling to me that we would introduce
* a net-device for sometthing that's not a net-device
* a tunnel for something that does no tunneling whatsoeer
* code mentioning "PFCP encapsulated traffic" when in fact it is
  impossible to encapsulate any traffic in PFCP, and the code does
  not - to the best of my understanding - do any such encapsulation
  or even configure hardware to perform any such non-existant PFCP
  encapsulation

[and possibly more] *just* so that a user can use 'tc' to configure a
hardware offloading feature in their NIC.

IMHO, there must be a better way.

> > I also see the following in the patch:
> > 
> > > +MODULE_DESCRIPTION("Interface driver for PFCP encapsulated traffic");
> > 
> > PFCP is not an encapsulation protocol for user plane traffic.  It is not
> > a tunneling protocol.  GTP-U is the tunneling protocol, whose
> > implementations (typically UPFs) are remote-controlled by PFCP.
> > 
> 
> Agree, it is done like that to simplify implementation and reuse kernel
> software stack.

My comment was about the module description.  It claims something that
makes no sense and that it does not actually implement.  Unless I'm not
understanding what the code does, it is outright wrong and misleading.

Likewise is the comment on top of the drivers/net/pfcp.c file says:

> * PFCP according to 3GPP TS 29.244

While the code is in fact *not* implementing any part of TS 29.244.  The
code is using the udp_tunnel infrastructure for something that's not a
tunnel.  From what i can tell it is creating an in-kernel UDP socket
(whcih can be done without any relation to udp_tunnel) and it is
configuring hardware offload features in a NIC.  The fact that the
payload of those UDP packets may be PFCP is circumstancial - nothing in
the code actually implements even the tiniest bit of PFCP protocol
parsing.

> This is the way to allow user to steer PFCP packet based on specific
> opts (type and seid) using tc flower. If you have better solution for
> that I will probably agree with you and will be willing to help you
> with better implementation.

sadly, neither tc nor intel NIC hardware offload capabilities are my
domain of expertise, so I am unable to propose detials of a better
solution.

> I assume the biggest problem here is with treating PFCP as a tunnel
> (done for simplification and reuse) and lack of any functionality of
> PFCP device

I don't think the kernel should introduce a net-device (here
specifically a tunnel device) for something that is not a tunnel.  This
device [nor the hardware accelerator it controls] will never encapsulate
or decapsulate any PFCP packet, as PFCP is not a tunnel / encapsulation
protocol.

> (moving the PFCP specification implementation into kernel
> probably isn't good idea and may never be accepted).

I would agree, but that is a completely separate discussion.  Even if
one ignores this, the hypothetical kernel PFCP implementation would not
be a tunnel, and not be a net-device at all.  It would simply be some
kind of in-kernel UDP socket parsing and responding to packets, similar
to the in-kernel nfs daemon or whatever other in-kernel UDP users exist.

Also: The fact that you or we think an actual PFCP implementation would
not be accepted in the kernel should *not* be an argument in favor of
accepting something else into the kernel, call it PFCP and create tunnel
devices for things that are not tunnels :)

> Offloading doesn't sound like problematic. If there is a user that want
> to use that (to offload for better performance, or even to steer between
> VFs based on PFCP specific parts) why not allow to do that?

The papers I read convinced me that there is a use case.  I very much
believe the use case is a work-around for a different problem (the
inefficiency of the control->data plance protocol in this case), but
my opinion on that doesn't matter here.  I do agree with you that there
are apparently people who would want to make use of such a feature, and
that there is nothing wrong with provoding them means to do this.

However, the *how* is what I strongly object to.  Once again, I may miss
some part of your architecture, and I am happy to be proven otherwise.

But if all of this is *just* to configure hardware offloading in a nic,
I don't think there should be net-devices or tunnels that never
encap/decap a single packet or for protocols / use cases that clearly do
not encap or decap packets.

I also think this sets very bad precedent.  What about other prootocols
in the future?  Will we see new tunnels in the kernel for things that
are not tunnels at all, every time there is some new protocol that gains
hardware offloading capability in some NIC? Surely this kind of
proliferation is not the kind of software architecture we want to have?

Once again, I do apologize for raising my concerns at such a late stage.
I am not a kernel developer anymore these days, and I do not follow any
of the related mailing lists.  It was pure coincidence that the net-next
merge of some GTP improvements I was involved in specifying also
contained the PFCP code and I started digging what this was all about.

Regards,
	Harald

-- 
- Harald Welte <laforge@gnumonks.org>          https://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

