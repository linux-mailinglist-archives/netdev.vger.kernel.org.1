Return-Path: <netdev+bounces-227982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8ACBBE8A9
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 17:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30EF61897E74
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 15:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1282D73BB;
	Mon,  6 Oct 2025 15:49:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93A22D5408;
	Mon,  6 Oct 2025 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759765744; cv=none; b=KV/m4r9VFbCbGr6XI7aP2Mp2HQTYwr9ONPW1xD/5Jibt1CK4lb63p7tTblvKMrL3JLZ5cLWTx/twGh9SbPG1e82uy6Ill/nytsZk2m1M9x/ZYRRL7HYHagv+RGsyRQ8cHcwcA+WS0ZhFjpay1SRAL2DLtpBPoauWe0SryOaByBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759765744; c=relaxed/simple;
	bh=U4EyToafNC5MnqAwQQIy5rWeujtlVsbLqs/JsM2ItZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsmcjT4Hgh0qVratR7vpwImeBQk9zH3HBwVBOMxogg5sV76zrFIBmiN6OTivf5bMakWkccGMW9eOQsb+dHDotz9JHvBAD/0kDdaIjK5OqU12Cl+USo4h+GzYTGQWT9xlrDo5VwCpxZ/DCZiGcTEcwOOiinB4Nb/4In8XnaNrJG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47CE11515;
	Mon,  6 Oct 2025 08:48:54 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D63313F66E;
	Mon,  6 Oct 2025 08:48:59 -0700 (PDT)
Date: Mon, 6 Oct 2025 16:48:57 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>,
	Jassi Brar <jassisinghbrar@gmail.com>
Cc: Adam Young <admiyo@os.amperecomputing.com>,
	Sudeep Holla <sudeep.holla@arm.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH net-next v29 1/3] mailbox: add callback function for rx
 buffer allocation
Message-ID: <20251006-large-astute-rattlesnake-c913fe@sudeepholla>
References: <20250925190027.147405-1-admiyo@os.amperecomputing.com>
 <20250925190027.147405-2-admiyo@os.amperecomputing.com>
 <5dacc0c7-0399-4363-ba9c-944a95afab20@amperemail.onmicrosoft.com>
 <CABb+yY3T6LdPoGysNAyNr_EgCAcq2Vxz3V1ReDgF_fGYcqRrbw@mail.gmail.com>
 <fe645202-9e00-4968-9aea-8680271a2067@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe645202-9e00-4968-9aea-8680271a2067@amperemail.onmicrosoft.com>

On Mon, Oct 06, 2025 at 11:24:23AM -0400, Adam Young wrote:
> 
> On 10/5/25 19:34, Jassi Brar wrote:
> > On Sun, Oct 5, 2025 at 12:13 AM Adam Young
> > <admiyo@amperemail.onmicrosoft.com> wrote:
> > > Jassi, this one needs your attention specifically.
> > > 
> > > Do you have an issue with adding this callback?  I think it will add an
> > > important ability to the receive path for the mailbox API: letting the
> > > client driver specify how to allocate the memory that the message is
> > > coming in.  For general purpose mechanisms like PCC, this is essential:
> > > the mailbox cannot know all of the different formats that the drivers
> > > are going to require.  For example, the same system might have MPAM
> > > (Memory Protection) and MCTP (Network Protocol) driven by the same PCC
> > > Mailbox.
> > > 
> > Looking at the existing code, I am not even sure if rx_alloc() is needed at all.
> > 
> > Let me explain...
> > 1) write_response, via rx_alloc, is basically asking the client to
> > allocate a buffer of length parsed from the pcc header in shmem.
> Yes, that is exactly what it is doing.  Write response encapsulates the PCC
> specific logic for extracting the message length from the shared buffer. 
> Anything using an extended memory (type 3 or 4) PCC channel is going to have
> to do this logic.
> > 2) write_response is called from isr and even before the
> > mbox_chan_received_data() call.
> Yes. Specifically, it is marshalling the data from the shared buffer into
> kernel space.  This is logic that every single PCC driver needs to do.  It
> should be put in  common code.
> > 
> > Why can't you get rid of write_response() and simply call
> >      mbox_chan_received_data(chan, pchan->chan.shmem)
> > for the client to allocate and memcpy_fromio itself?
> 
> Moving write_response into the client and out of the mailbox means that it
> has to be implemented properly on every driver, leading to cut-and-paste
> errors.
> 

Agreed, but I don’t think we need to add a new API to the mailbox framework
solely to handle duplication across PCC client drivers. As I’ve mentioned a
few times already, we can introduce common helpers later if a second driver
ends up replicating this logic. That alone isn’t a good reason to add generic
APIs to the mailbox framework right now.

We can revisit this idea in the future if there’s a clear benefit, but in my
opinion, a multi-step approach is more appropriate:

1. First, add the initial driver with all the required client handling.

2. Then, if a second driver needs similar functionality, we can introduce
   shared helpers.

3. Finally, if it still makes sense at that point, we can discuss defining a
   new mailbox API - with the benefit of having concrete examples already in the
   upstream tree.

> So, yes, I can do that, but then every single driver that needs to use the
> pcc mailbox has to do the exact same code.  This is the first Type 3/4 PCC
> driver to use extended memory, and thus it needs to implement new logic. 
> That logic is to make sure  we have proper serialized access to the shared
> buffer.  It is this kind of access that the mailbox API is well designed to
> provide:  if both sides follow the protocol, it will only deliver a single
> message at a time.  If we move the logic out of the mailbox, we end up
> duplicating the serialization code in the client driver.  I could make a
> helper function for it, but we are getting to the point, then, where the
> mailbox API is not very useful.   If we are going to have an abstraction
> like this (and I think we should) then we should use it.
>

Sorry but you haven't demonstrated this with example. First try the above
mentioned step and lets talk later if you still have issues.

> We have more drivers like this coming.  There is code that is going to be
> non-PCC, but really PCC like that will need an MCTP driver.  That driver
> will also need to allocate an sk_buff for receiving the  data.  There is
> also MPAM code that will use the PCC driver and a type3  (extended memory)
> channel.  The mailbox API, in order to be more generally useful, should
> allow for swapping the memory allocation scheme between different clients of
> the same mailbox.  Then the mailbox layer is responsible for handling the
> mailboxes, and the clients are domain-specific code.
> 

You can always improve the code later. We don't know what will the discussions
lead to when you submit that driver later. We can keep those discussion for
later and just concentrate on getting the first step done here.

Hi Jassi,

If you don't have any objections, can we first get the revert in place and
let Adam attempt adding code to the client and take the discussions from
there.

-- 
Regards,
Sudeep

