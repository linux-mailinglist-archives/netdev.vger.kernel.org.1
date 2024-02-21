Return-Path: <netdev+bounces-73711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DB885DFDA
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F6022837AD
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 14:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527607FBB2;
	Wed, 21 Feb 2024 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Dh03oRPS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01237FBAD
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526162; cv=none; b=tjEjBCtrM2rSWjN+9fnFDw1e4ySoKNYRNUclOCS444l9UO25aLIC/FzOBlK+4eMrhRoLoAfUfdGKptu1r0N0qQVMgh9iewC4E/sH42R9NIW8g+KeWgaK6wejrICqKywbippnpBS8xwRjfXkmz/Hygo0bYwoFXxBGfP5thxQhjI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526162; c=relaxed/simple;
	bh=QKxUWbkSwd0UL7rEI8V6cSO+xxkOhs8K7xIK8f7b1+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tde+9fF0hUlAzziy30AhMitNuCQJJAJeEKzLTykQ6iylpOfJgUkLdcQyk1yLwTcB3rMO+XdtHy7vrQRcNuAMeB9bFYTPVOIxWpSxJ29WyefDxoTUzPUW5u6p/nUqQM7uPYLHIZw4wXw4K04eMCemsAKqxqTv1fYWFV1klVkm25E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Dh03oRPS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ERmSmiijN9fPXGAmKEXje0WlrpsSOgwMM1gk3X1IgmU=; b=Dh03oRPSM9wsT90t16B9Em/ohM
	79Ofbcfvc1jcYBbReVeBe/7XeIgUQPi7Ae0/mi7ae6nhVdWLQBmGSvlOm8Fpvq9YA063aH8UZkph5
	+z8C4DZWPWEurHSzmxLx9AmHyu8eY+j9ewEV9b7ZvFc4+olsnVhMp6ECmSioQCkuN7og=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rcnhO-008N8Y-CN; Wed, 21 Feb 2024 15:35:50 +0100
Date: Wed, 21 Feb 2024 15:35:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maciej.fijalkowski@intel.com,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH] net: txgbe: fix GPIO interrupt blocking
Message-ID: <96b3ed32-1115-46bf-ae07-9eea0c24e85a@lunn.ch>
References: <20240206070824.17460-1-jiawenwu@trustnetic.com>
 <9259e4eb-8744-45cf-bdea-63bc376983a4@lunn.ch>
 <003801da6249$888e4210$99aac630$@trustnetic.com>
 <33eed490-7819-409e-8c79-b3c1e4c4fd66@lunn.ch>
 <00e301da63de$bd53db90$37fb92b0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00e301da63de$bd53db90$37fb92b0$@trustnetic.com>

On Tue, Feb 20, 2024 at 05:25:26PM +0800, Jiawen Wu wrote:
> On Mon, Feb 19, 2024 12:45 AM, Andrew Lunn wrote:
> > On Sun, Feb 18, 2024 at 05:04:52PM +0800, Jiawen Wu wrote:
> > > On Tue, Feb 6, 2024 11:29 PM, Andrew Lunn wrote:
> > > > On Tue, Feb 06, 2024 at 03:08:24PM +0800, Jiawen Wu wrote:
> > > > > GPIO interrupt is generated before MAC IRQ is enabled, it causes
> > > > > subsequent GPIO interrupts that can no longer be reported if it is
> > > > > not cleared in time. So clear GPIO interrupt status at the right
> > > > > time.
> > > >
> > > > This does not sound correct. Since this is an interrupt controller, it
> > > > is a level interrupt. If its not cleared, as soon as the parent
> > > > interrupt is re-enabled, is should cause another interrupt at the
> > > > parent level. Servicing that interrupt, should case a descent to the
> > > > child, which will service the interrupt, and atomically clear the
> > > > interrupt status.
> > > >
> > > > Is something wrong here, like you are using edge interrupts, not
> > > > level?
> > >
> > > Yes, it is edge interrupt.
> > 
> > So fix this first, use level interrupts.
> 
> I have a question here.
> 
> I've been setting the interrupt type in chip->irq_set_type. The 'type' is
> passed as IRQ_TYPE_EDGE_BOTH. Then I config GPIO registers based on
> this type, and use edge interrupts. Who decides this type? Can I change
> it at will?

There are a few different mechanism. In DT you can specify it as part
of the phandle reference. You can also pass flags to

request_irq(unsigned int irq, irq_handler_t handler, unsigned long flags,
	    const char *name, void *dev)

#define IRQF_TRIGGER_NONE	0x00000000
#define IRQF_TRIGGER_RISING	0x00000001
#define IRQF_TRIGGER_FALLING	0x00000002
#define IRQF_TRIGGER_HIGH	0x00000004
#define IRQF_TRIGGER_LOW	0x00000008

	Andrew

