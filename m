Return-Path: <netdev+bounces-244392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1536CB6334
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 15:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5842E3063413
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 14:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E8A30F928;
	Thu, 11 Dec 2025 14:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b="RHwNxD97"
X-Original-To: netdev@vger.kernel.org
Received: from mail71.out.titan.email (mail71.out.titan.email [209.209.25.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4233230F805
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.209.25.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765463061; cv=none; b=sovQbHyq2rIei35aKMZW3/FNRE64g2wyO6efP7xOH8XaR2L8J5OxDaSJFzMUsnzINmkpXIGQpTm30gFKTcKSLalF8K9NrgQKipW6EznHuTMfQ3p2P4ayvqh4qKGyPMHYmGYFvHOLK4v+h8TVYhUEp2wmTZTd0UMvobhe4uFtnL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765463061; c=relaxed/simple;
	bh=hChgOZCNIdgOSuzX0O42o0vEgKrP9QpNsT+l2eEpsB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjZhmvddhcGvCxZcLkxLwfW6EIK+qtvIFo4rAemrpzEBWOE6pJxCLvDAJNc84GGR1yeUAFGMD3jornaBtZ2743f3hV6k1Q/1n1HHFp5I04mpbdJ+gWMK8QFmKtfMpoVT/f8BIYD1hbl4YL3T5JIvhwJsV3SFm0Pv9GPew5vmV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b=RHwNxD97; arc=none smtp.client-ip=209.209.25.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4dRvwY540tz9s18;
	Thu, 11 Dec 2025 14:24:13 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=HRX2FChc6mlfHqUE0R8NSQqyHXpRUt4CcSaNX8cKI4g=;
	c=relaxed/relaxed; d=ziyao.cc;
	h=message-id:from:date:to:subject:references:in-reply-to:cc:mime-version:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1765463053; v=1;
	b=RHwNxD97m4UEUe99dTDvFWKCjIKspti8DCh2060fmIeViRUTiq2m0/Vv5tJtseB3dMcPffeU
	PRr401UO5Mc47yspTBewywp4JKRX8Acl7/ZLmIwPOkQp5IulVi6tmK8ES6AciQISiXxbddApxi7
	tBedoQAyrislb9y2duQPxNe8=
Received: from pie (unknown [117.171.66.90])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 4dRvwM1z97z9rxH;
	Thu, 11 Dec 2025 14:24:02 +0000 (UTC)
Date: Thu, 11 Dec 2025 14:23:58 +0000
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: phasta@kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>, Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>, Runhua He <hua@aosc.io>,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH net-next v3 2/3] net: stmmac: Add glue driver for
 Motorcomm YT6801 ethernet controller
Message-ID: <aTrT3rHhtXkSyPOO@pie>
References: <20251205221629.GA3294018@bhelgaas>
 <27fec7d0ed633218a7787be3edce63c3038c63e2.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27fec7d0ed633218a7787be3edce63c3038c63e2.camel@mailbox.org>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1765463053534753273.21635.1565122319943870764@prod-use1-smtp-out1003.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=WtDRMcfv c=1 sm=1 tr=0 ts=693ad40d
	a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
	a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10 a=CEWIc4RMnpUA:10
	a=m9OAshgdpC4-_Ak1MIUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
	a=3z85VNIBY5UIEeAh_hcH:22 a=NWVoK91CQySWRX1oVYDe:22

On Mon, Dec 08, 2025 at 10:54:36AM +0100, Philipp Stanner wrote:
> On Fri, 2025-12-05 at 16:16 -0600, Bjorn Helgaas wrote:
> > [+to Philipp, Thomas for MSI devres question]
> > 
> > On Fri, Dec 05, 2025 at 09:34:54AM +0000, Russell King (Oracle) wrote:
> > > On Fri, Dec 05, 2025 at 05:31:34AM +0000, Yao Zi wrote:
> > > > On Mon, Nov 24, 2025 at 07:06:12PM +0000, Russell King (Oracle) wrote:
> > > > > On Mon, Nov 24, 2025 at 04:32:10PM +0000, Yao Zi wrote:

...

> > > This looks very non-intuitive, and the documentation for
> > > pci_alloc_irq_vectors() doesn't help:
> > > 
> > >  * Upon a successful allocation, the caller should use pci_irq_vector()
> > >  * to get the Linux IRQ number to be passed to request_threaded_irq().
> > >  * The driver must call pci_free_irq_vectors() on cleanup.
> > >    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > 
> > > because if what you say is correct (and it looks like it is) then this
> > > line is blatently incorrect.
> 
> True, this line is false. It should probably state "If you didn't
> enable your PCI device with pcim_enable_device(), you must call
> pci_free_irq_vectors() on cleanup."
> 
> If it's not a bug, one could keep the docu that way or at least phrase
> it in a way so that no additional users start relying on that hybrid
> mechanism.

Thanks for the clarification, would you mind me sending a patch to fix
the description, and also mention the automatic clean-up behavior
shouldn't be relied anymore in new code?

...

> The good news is that it's the last remainder of PCI hybrid devres and
> getting rid of it would allow for removal of some additional code, too
> (e.g., is_enabled bit and pcim_pin_device()).
> 
> The bad news is that it's not super trivial to remove. I looked into it
> about two times and decided I can't invest that time currently. You
> need to go over all drivers again to see who uses pcim_enable_device(),
> then add free_irq_vecs() for them all and so on…

Do you think adding an implementation of pcim_alloc_irq_vectors(), that
always call pci_free_irq_vectors() regardless whether the PCI device is
managed, will help the conversion?

This will make it more trival to rewrite drivers depending on the
automatic clean-up behavior: since calling pci_free_irq_vectors()
several times is okay, we could simply change pci_alloc_irq_vectors() to
pcim_alloc_irq_vectors(), without considering where to call
pci_free_irq_vectors().

Introducing pcim_alloc_irq_vectors() will also help newly-introduced
drivers to reduce duplicated code to handle resource clean-up.

> If you give me a pointer I can provide a TODO entry. In any case, feel
> free to set me as a reviewer!

> Regards
> Philipp

Regards,
Yao Zi

