Return-Path: <netdev+bounces-220854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79160B492F2
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 17:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 502B44E1CA7
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 15:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0FB30BF4B;
	Mon,  8 Sep 2025 15:20:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B9125634;
	Mon,  8 Sep 2025 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757344838; cv=none; b=ccGZZueOmFxsPR8EbDwYUxaIaPzrdEliDf3WONaX46DNIxYfwprBnMTzubRbbWibncS9CpLi8++EpJ3cz/Ilj8V42OyFevqmadp6GB6xfegEaR2qrJD6c2kX/kJw9l9H6GjQYbOg09EDrUk1qZzKwL92xnFnovR9SAx0TH3g5X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757344838; c=relaxed/simple;
	bh=7gu6rErY7yQyZZzp5eHW86wOgE+oDXZBLtrctFta85o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lz/gByEISxDkz5cZtQUx3QUQQF2Tz6yuZTntoVkeIBCyKnQVUfwdeZ0Drw1hLZoYk6DQiPs3TdIOeGksNQ7eIGhYRyKuWR/gU/c+FFqZeR4rvpHtkqGGDW44ttbqG1tME77ddnRGJwO4DzLmxvm3x+ITpL2vXyAz46Q2LHZaMmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C59BB1692;
	Mon,  8 Sep 2025 08:20:26 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C62D3F63F;
	Mon,  8 Sep 2025 08:20:32 -0700 (PDT)
Date: Mon, 8 Sep 2025 16:20:29 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: <admiyo@os.amperecomputing.com>, Jassi Brar <jassisinghbrar@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v23 1/2] mailbox/pcc: support mailbox management of the
 shared buffer
Message-ID: <aL70PVhM-UVi5UrS@bogus>
References: <20250715001011.90534-1-admiyo@os.amperecomputing.com>
 <20250715001011.90534-2-admiyo@os.amperecomputing.com>
 <20250904-expert-invaluable-moose-eb5b7b@sudeepholla>
 <1ec0cb87-463c-4321-a1c7-05f120c607aa@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ec0cb87-463c-4321-a1c7-05f120c607aa@amperemail.onmicrosoft.com>

On Mon, Sep 08, 2025 at 10:58:55AM -0400, Adam Young wrote:
> 
> On 9/4/25 07:00, Sudeep Holla wrote:
> > On Mon, Jul 14, 2025 at 08:10:07PM -0400,admiyo@os.amperecomputing.com wrote:
> > > From: Adam Young<admiyo@os.amperecomputing.com>
> > > 
> > > Define a new, optional, callback that allows the driver to
> > > specify how the return data buffer is allocated.  If that callback
> > > is set,  mailbox/pcc.c is now responsible for reading from and
> > > writing to the PCC shared buffer.
> > > 
> > > This also allows for proper checks of the Commnand complete flag
> > > between the PCC sender and receiver.
> > > 
> > > For Type 4 channels, initialize the command complete flag prior
> > > to accepting messages.
> > > 
> > > Since the mailbox does not know what memory allocation scheme
> > > to use for response messages, the client now has an optional
> > > callback that allows it to allocate the buffer for a response
> > > message.
> > > 
> > > When an outbound message is written to the buffer, the mailbox
> > > checks for the flag indicating the client wants an tx complete
> > > notification via IRQ.  Upon receipt of the interrupt It will
> > > pair it with the outgoing message. The expected use is to
> > > free the kernel memory buffer for the previous outgoing message.
> > > 
> > I know this is merged. Based on the discussions here, I may send a revert
> > to this as I don't think it is correct.
> 
> Have you decided what to do?  The MCTP over PCC driver depends on the
> behavior in this patch. If you do revert, I will need a path forward.
> 

Sorry not yet. I still need to understand and analyse your last reply.

> Based on other code review feed back, I need to make an additional change: 
> the rx_alloc callback function needs to be atomically set, and thus needs to
> move to the mailbox API.  There it will pair with the prepare transaction
> function.  It is a small change, but I expect some feedback from the mailbox
> maintainers.
> 
> I know all of the other drivers that use the PCC mailbox currently do direct
> management of the shared buffer.  I suspect that is the biggest change that
> is causing you concern.  Are you OK with maintaining a mailbox-managed path
> to buffer management as well?  I think it will be beneficial to other
> drivers in the long run.
> 

If you are really interesting to consolidating, then move all the buffer
management into the core. Just don't introduce things that just work on
your platform and for your use case. You need move all the drivers to this
new model of accessing the buffers. Otherwise I see no point as it is just
another churn but in core mailbox PCC driver instead of a client driver
using PCC. So, I am not OK with the change as is and needs to be reworked
or reverted. I need sometime to understand your email and requirements.

-- 
Regards,
Sudeep

