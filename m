Return-Path: <netdev+bounces-227318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BA8BAC560
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 11:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91F048419A
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 09:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68E6301038;
	Tue, 30 Sep 2025 09:37:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1217D2F7475;
	Tue, 30 Sep 2025 09:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759225070; cv=none; b=uaPLcH8K+SC98t5A/3iavWxgpnS6u/uEfQVJjTwfWFEr8XqnqQ+eMCy1ETg+uSLNiOLivIVJ8ZjOnOaXhs70T8MO8EA+rErsDKaH88qF6cMrfBvM/q1e8tM4Ox2Zb4zmUPhVo3cmXE6Sn7dkh3RTcGGhiSqzsfaZhUXouGdGv2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759225070; c=relaxed/simple;
	bh=sB8QpoW7apk3wRrBGS7LSxK6IdeSDh3bKJHWIzEyZ5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnWI+/lmT3YJSDhoi9rpFUy6EKdE4snfQckPOFnKnX83/eP/PR8DtJBtYGANgQKif0EmoKzKQ3NHcJabp6owK580vVf2modZznL4fpbcawOVxEzoXhRUNFznzhAgyw0sz3nOtSAUOR88ohJ9297Yzhr86zTbBXxc8uPefYDIO7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 440671424;
	Tue, 30 Sep 2025 02:37:38 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2978D3F59E;
	Tue, 30 Sep 2025 02:37:45 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:37:42 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	Adam Young <admiyo@os.amperecomputing.com>,
	Sudeep Holla <sudeep.holla@arm.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "mailbox/pcc: support mailbox management of the
 shared buffer"
Message-ID: <20250930-little-numbat-of-justice-e8a3da@sudeepholla>
References: <20250926153311.2202648-1-sudeep.holla@arm.com>
 <2ef6360e-834f-474d-ac4d-540b8f0c0f79@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ef6360e-834f-474d-ac4d-540b8f0c0f79@amperemail.onmicrosoft.com>

On Mon, Sep 29, 2025 at 01:11:23PM -0400, Adam Young wrote:
> I posted a patch that addresses a few of these issues.  Here is a top level
> description of the isse
> 
> The correct way to use the mailbox API would be to allocate a buffer for the
> message,write the message to that buffer, and pass it in to
> mbox_send_message.  The abstraction is designed to then provide sequential
> access to the shared resource in order to send the messages in order.  The
> existing PCC Mailbox implementation violated this abstraction.  It requires
> each individual driver re-implement all of the sequential ordering to access
> the shared buffer.
> 

Please, let us keep the avoiding duplication as a separate topic atleast for
the discussion. We can take care of it even before merging if you prefer that
way but we need to explore what other drivers can use it. Otherwise it is
not yet duplication right ?

> Why? Because they are all type 2 drivers, and the shared buffer is 64bits in
> length:  32bits for signature, 16 bits for command, 16 bits for status.  It
> would be execessive to kmalloc a buffer of this size.
> 

Sure, if there is only and first driver needing large buffers, it is still
not duplication yet. I agree it can be moved to PCC, but lets start with
you client driver code first and then take it from there.

> This shows the shortcoming of the mailbox API.  The mailbox API assumes that
> there is a large enough buffer passed in to only provide a void * pointer to
> the message.  Since the value is small enough to fit into a single register,
> it the mailbox abstraction could provide an implementation that stored a
> union of a void * and word.  With that change, all of the type 2
> implementations could have their logic streamlined and moved into the PCC
> mailbox.
> 

No, it is left to the client driver interpretation as it clearly varies even
within PCC type 1-5. Again, let us start with client driver code and see how
to standardise later. I agree with PCC being standard, there is scope for
avoiding duplication, but we will get to know that only if you first present
it with the client driver code and we can then see how and what to make
generic.

> However, I am providing an implementation for a type3/type4 based driver,
> and I do need the whole managmenet of the message buffer. IN addition, I
> know of at least one other subsystem (MPAM) that will benefit from a type3
> implementation.
> 

Don't even go there. It is much bigger beast with all sorts of things to
consider. Now that you have mentioned that, I am interested more to look
at MPAM driver usage as well before merging anything as generic as I know
MPAM is not so trivial. You pulled that topic into this, sorry 😉.

> On 9/26/25 11:33, Sudeep Holla wrote:
> > This reverts commit 5378bdf6a611a32500fccf13d14156f219bb0c85.
> > 
> > Commit 5378bdf6a611 ("mailbox/pcc: support mailbox management of the shared buffer")
> > attempted to introduce generic helpers for managing the PCC shared memory,
> > but it largely duplicates functionality already provided by the mailbox
> > core and leaves gaps:
> > 
> > 1. TX preparation: The mailbox framework already supports this via
> >    ->tx_prepare callback for mailbox clients. The patch adds
> >    pcc_write_to_buffer() and expects clients to toggle pchan->chan.manage_writes,
> >    but no drivers set manage_writes, so pcc_write_to_buffer() has no users.
> 
> tx prepare is insufficient, as it does not provide access to the type3
> flags.  IN addition, it forces the user to manage the buffer memory
> directly.  WHile this is a necessary workaround for type 2 non extended
> memory regions, it does not make sense for a managed resource like the
> mailbox.
> 

Sorry if I am slow in understanding but I still struggle why tx_prepare won't
work for you. Please don't jump to solve 2 problems at the same time as it
just adds more confusion. Let us see if and how to make tx_prepare work for
your driver. And then we can look at standardising it as a helper function
that can be use in all the PCC mailbox client drivers if we can do that.

You are just adding parallel and optional APIs just to get your driver
working here. I am not against standardising to avoid duplication which
is your concern(very valid) but doen't need to be solved by adding another
API when the existing APIs already provides mechanism to do that.

If you need information about the PCC type3/4, we can explore that as well.

> You are correct that the manage_writes flag can be removed, but if (and only
> if) we limit the logic to type 3 or type 4 drivers.  I have made that change
> in a follow on patch:
> 

OK, but I would like to start fresh reverting this patch.

> > 2. RX handling: Data reception is already delivered through
> >     mbox_chan_received_data() and client ->rx_callback. The patch adds an
> >     optional pchan->chan.rx_alloc, which again has no users and duplicates
> >     the existing path.
> 
> The change needs to go in before there are users. The patch series that
> introduced this change requires this or a comparable callback mechanism.
> 

Not always necessary. Yes if it is agreed to get the user merged. But I am
now questioning why you need it when you do have rx_callback.

> However, the reviewers have shown that there is a race condition if the
> callback is provided to the PCC  mailbox Channel, and thus I have provided a
> patch which moves this callback up to the Mailbox API.

Sorry if I have missed it. Can you please point me to the race condition in
question. I am interested to know more details.

> This change, which is obviosuly not required when returning a single byte,
> is essential when dealing with larger buffers, such as those used by network
> drivers.
> 

I assume it can't be beyond the shmem area anyways. That can be read from the
rx_callback. Again I haven't understood your reasoning as why the allocation
and copy can't be part of rx_callback.

> > 
> > 3. Completion handling: While adding last_tx_done is directionally useful,
> >     the implementation only covers Type 3/4 and fails to handle the absence
> >     of a command_complete register, so it is incomplete for other types.
> 
> Applying it to type 2 and earlier would require a huge life of rewriting
> code that is both  multi architecture (CPPC)  and on esoteric hardware
> (XGene) and thus very hard to test. 

True but you have changed the generic code which could break Type1/2 PCC.
I am not sure if it is tested yet.

> While those drivers should make better use of  the mailbox mechanism,
> stopping the type 3 drivers from using this approach  stops an effort to
> provide a common implementation base. That should happen in future patches,
> as part of reqorking the type 2 drivers. 

No you need to take care to apply your changes only for Type3/4 so that
Type1/2 is unaffected. You can expect to break and someone else to fix
the breakage later.

> Command Complete is part of the PCC specification for type 3 drivers.
>

Agreed, that's not the argument. The check is done unconditionally. I will
send the patch once we agree to revert this change and start fresh. And each
feature handled separately instead of mixing 3 different things in one patch.

> > 
> > Given the duplication and incomplete coverage, revert this change. Any new
> > requirements should be addressed in focused follow-ups rather than bundling
> > multiple behavioral changes together.
> 
> I am willing to break up the previous work into multiple steps, provided the
> above arguments you provided are not going to prevent them from getting
> merged.  Type 3/4 drivers can and should make use of the Mailbox
> abstraction. Doing so can lay the ground work for making the type 2 drivers
> share a common implementation of the shared buffer management.
>

Sure. Lets revert this patch and start discussing your individual requirements
in individual patches and check why tx_prepare and rx_callback can't work for
you. Please share the client driver code changes you tried when checking
tx_prepare and rx_callback as well so that we can see why it can't work.

-- 
Regards,
Sudeep

