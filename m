Return-Path: <netdev+bounces-220377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A5CB45AAD
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 16:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7A67C2363
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 14:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4D73705BB;
	Fri,  5 Sep 2025 14:37:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5141A37058D;
	Fri,  5 Sep 2025 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757083048; cv=none; b=f097kQcgc02YRzH11X8Rcd9NzaIQSFLIHeKrqQNpUvb9BtbBeJcWzI4UYCc9RnRK1lVXvIvytyxRi/9pMwqjDFrK8o/nKd7vy5gKvyAKU1R9k+/VbTsy5eRmIv6NPRwuqTGl9mA2bsnCxp9gHO3UFvT1l2Qbl6SezYwFZ7H0KYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757083048; c=relaxed/simple;
	bh=0uIO+pXu/JU2heMAb1WAHVGx0acUgun+JCcvKNJ2sBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEcFrNN/W+vuxJfgzaHt43zTmGuX8ZwRxyt9G8GfpbZ3nlfQHuEeOi4LpLf2JXj68pNLvz5L0JRvaKvtBz0XnoTuU6XgVniX8mlp/WQUBzgNVBZoyiPDqxSEbc0lbiFr65DYbPHFMrWM2zSKleJ0NmGFyyOhIjmZ7i/WrZr9YgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64396152B;
	Fri,  5 Sep 2025 07:37:18 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2CB13F63F;
	Fri,  5 Sep 2025 07:37:23 -0700 (PDT)
Date: Fri, 5 Sep 2025 15:37:21 +0100
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
Message-ID: <20250905-speedy-giga-puma-1fede6@sudeepholla>
References: <20250715001011.90534-1-admiyo@os.amperecomputing.com>
 <20250715001011.90534-2-admiyo@os.amperecomputing.com>
 <20250904-expert-invaluable-moose-eb5b7b@sudeepholla>
 <2456ece8-0490-4d57-b882-6d4646edc86d@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2456ece8-0490-4d57-b882-6d4646edc86d@amperemail.onmicrosoft.com>

On Thu, Sep 04, 2025 at 01:06:09PM -0400, Adam Young wrote:
> Answers inline.
> 
> On 9/4/25 07:00, Sudeep Holla wrote:

[...]

> > Who will change this value as it is fixed to false always.
> > That makes the whole pcc_write_to_buffer() reduntant. It must go away.
> > Also why can't you use tx_prepare callback here. I don't like these changes
> > at all as I find these redundant. Sorry for not reviewing it in time.
> > I was totally confused with your versioning and didn't spot the mailbox/pcc
> > changes in between and assumed it is just MCTP net driver changes. My mistake.
> 
> This was a case of leaving the default as is to not-break the existing
> mailbox clients.
> 
> The maibox client can over ride it in its driver setup.
> 

What if driver changes in the middle of an ongoing transaction ? That
doesn't sound like a good idea to me.

You didn't respond as why tx_prepare callback can be used to do exactly
same thing ?

> > > +	void *(*rx_alloc)(struct mbox_client *cl,  int size);
> > Why this can't be in rx_callback ?
> 
> Because that is too late.
> 
> The problem is that the client needs  to allocate the memory that the
> message comes in in order to hand it off.
> 
> In the case of a network device, the rx_alloc code is going to return the
> memory are of a struct sk_buff. The Mailbox does not know how to allocate
> this. If the driver just kmallocs memory for the return message, we would
> have a re-copy of the message.
>

I still don't understand the requirement. The PCC users has access to shmem
and can do what they want in rx_callback, so I don't see any reason for
this API.

> This is really a mailbox-api level issue, but I was trying to limit the
> scope of my changes as much as possible.
> 

Please explain the issue. Sorry if I have missed, pointer are enough if
already present in some mail thread.

> The PCC mailbox code really does not match the abstractions of the mailbox
> in general.  The idea that copying into and out of the buffer is done by
> each individual driver leads to a lot of duplicated code.  With this change,
> most of the other drivers could now be re-written to let the mailbox manage
> the copying, while letting the mailbox client specify only how to allocate
> the message buffers.
> 

Yes that's because each user have their own requirement. You can do what
you want in rx_callback.

> Much of this change  was driven by the fact that the PCC mailbox does not
> properly check the flags before allowing writes to the rx channel, and that
> code is not exposed to the driver.  Thus, it was impossible to write
> everything in the rx callback regardless. This work was based on Huisong's
> comments on version 21 of the patch series.
> 

Pointers please, sorry again. But I really don't like the merged code and
looking for ways to clean it up as well as address the requirement if it
is not available esp. if we have to revert this change.

-- 
Regards,
Sudeep

