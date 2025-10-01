Return-Path: <netdev+bounces-227472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25735BB041A
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 13:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8F6C3B1493
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 11:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929132E7653;
	Wed,  1 Oct 2025 11:57:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8299B274FDB;
	Wed,  1 Oct 2025 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759319848; cv=none; b=MZ07TgK2VB3ZcljetljKz6dCQgWDVTeoZnaVuHJW6hW01+r7TG7YCaBQHHeyT6YeGMRyoxfYEy06U2bErIBZCDKGN8ur1XafiEuQeskmEL6U+o8ZhClwiAnf2YLcbyOfRtd8ooYhsLI5F8Oxu3zHJBnV+NbwXhcYCJM6nIJzCmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759319848; c=relaxed/simple;
	bh=BF5vlaRfBBcfg/QLrCOwGmvV/0Gv2eCviQVuNLH0MU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvInywDM9YdYBWyJ6MPNdXeCI1UIp1sjpWvhQHRWr0n4Dq/Dv38dGC/0H+dPilD9lhQGgw1BJ7rFwyoEyqHvHD25MtvUp0IN8GgBandc1ZFQ5TJ0Rs7L53bbaPYnTySgQ+AATtu3xEM8yHF1iIIj1pIM/4Pj2fnODhfgyN3pUs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEE3516F2;
	Wed,  1 Oct 2025 04:57:17 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CC993F66E;
	Wed,  1 Oct 2025 04:57:24 -0700 (PDT)
Date: Wed, 1 Oct 2025 12:57:21 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Adam Young <admiyo@os.amperecomputing.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "mailbox/pcc: support mailbox management of the
 shared buffer"
Message-ID: <20251001-masterful-benevolent-dolphin-a3fbea@sudeepholla>
References: <20250926153311.2202648-1-sudeep.holla@arm.com>
 <2ef6360e-834f-474d-ac4d-540b8f0c0f79@amperemail.onmicrosoft.com>
 <CABb+yY2Uap0ePDmsy7x14mBJO9BnTcCKZ7EXFPdwigt5SO1LwQ@mail.gmail.com>
 <0f48a2b3-50c4-4f67-a8f6-853ad545bb00@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f48a2b3-50c4-4f67-a8f6-853ad545bb00@amperemail.onmicrosoft.com>

On Wed, Oct 01, 2025 at 01:25:42AM -0400, Adam Young wrote:
> 
> On 9/29/25 20:19, Jassi Brar wrote:
> > On Mon, Sep 29, 2025 at 12:11 PM Adam Young
> > <admiyo@amperemail.onmicrosoft.com> wrote:
> > > I posted a patch that addresses a few of these issues.  Here is a top
> > > level description of the isse
> > > 
> > > 
> > > The correct way to use the mailbox API would be to allocate a buffer for
> > > the message,write the message to that buffer, and pass it in to
> > > mbox_send_message.  The abstraction is designed to then provide
> > > sequential access to the shared resource in order to send the messages
> > > in order.  The existing PCC Mailbox implementation violated this
> > > abstraction.  It requires each individual driver re-implement all of the
> > > sequential ordering to access the shared buffer.
> > > 
> > > Why? Because they are all type 2 drivers, and the shared buffer is
> > > 64bits in length:  32bits for signature, 16 bits for command, 16 bits
> > > for status.  It would be execessive to kmalloc a buffer of this size.
> > > 
> > > This shows the shortcoming of the mailbox API.  The mailbox API assumes
> > > that there is a large enough buffer passed in to only provide a void *
> > > pointer to the message.  Since the value is small enough to fit into a
> > > single register, it the mailbox abstraction could provide an
> > > implementation that stored a union of a void * and word.
> > > 
> > Mailbox api does not make assumptions about the format of message
> > hence it simply asks for void*.
> > Probably I don't understand your requirement, but why can't you pass the pointer
> > to the 'word' you want to use otherwise?
> > 
> > -jassi
> The mbox_send_message call will then take the pointer value that you give it
> and put it in a ring buffer.  The function then returns, and the value may
> be popped off the stack before the message is actually sent.  In practice we
> don't see this because much of the code that calls it is blocking code, so
> the value stays on the stack until it is read.  Or, in the case of the PCC
> mailbox, the value is never read or used.  But, as the API is designed, the
> memory passed into to the function should expect to live longer than the
> function call, and should not be allocated on the stack.

I’m still not clear on what exactly you are looking for. Let’s look at
mbox_send_message(). It adds the provided data pointer to the queue, and then
passes the same pointer to tx_prepare() just before calling send_data(). This
is what I’ve been pointing out that you can obtain the buffer pointer there and
use it to update the shared memory in the client driver.

-- 
Regards,
Sudeep

