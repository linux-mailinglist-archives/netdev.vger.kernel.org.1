Return-Path: <netdev+bounces-227916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0469BBD651
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 10:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7760D3B8AB4
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 08:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C6425949A;
	Mon,  6 Oct 2025 08:54:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85571DF26A;
	Mon,  6 Oct 2025 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759740862; cv=none; b=YgSln4ZqZPCjmDvmABcqDDWZiWAbJWweO+5hnATtqXuEQh3FsUgEtfDKsvu+hCqeFZqOPTuzuf3qUBIbNX5g298Cn8RKfzeiLivZtATBZiO7DbTi3H21Y1p+Qaw0mLRVvMjbhZDQxRKnMzLUnxXzeJgh/vBBfnRwqxxP/kfK0ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759740862; c=relaxed/simple;
	bh=rDlg60WTok6XQfPMcJSecnQEE3DmDi1J2hdP+Bhurjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9Q+gvj/ZTLd2bXO8cnlp0nu9CBtUJTvJ72MNNkRg2fw0pyfZaYfvJZ+qWOhz9EBixJAMB88RooAQshAEzmut3fczyhS2jFLIYaD4M0r4NUybR7UBYIGY/PAd5w/t5kbsT6y8xysbq7gB2Q2FXwf/b91FEcdDkqyUsw8q0t/FIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 583051515;
	Mon,  6 Oct 2025 01:54:12 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BE423F66E;
	Mon,  6 Oct 2025 01:54:17 -0700 (PDT)
Date: Mon, 6 Oct 2025 09:54:15 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: Adam Young <admiyo@os.amperecomputing.com>, netdev@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH net-next v29 1/3] mailbox: add callback function for rx
 buffer allocation
Message-ID: <aOODt2lj--GOZkhU@bogus>
References: <20250925190027.147405-1-admiyo@os.amperecomputing.com>
 <20250925190027.147405-2-admiyo@os.amperecomputing.com>
 <5dacc0c7-0399-4363-ba9c-944a95afab20@amperemail.onmicrosoft.com>
 <CABb+yY3T6LdPoGysNAyNr_EgCAcq2Vxz3V1ReDgF_fGYcqRrbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABb+yY3T6LdPoGysNAyNr_EgCAcq2Vxz3V1ReDgF_fGYcqRrbw@mail.gmail.com>

On Sun, Oct 05, 2025 at 06:34:51PM -0500, Jassi Brar wrote:
> On Sun, Oct 5, 2025 at 12:13 AM Adam Young
> <admiyo@amperemail.onmicrosoft.com> wrote:
> >
> > Jassi, this one needs your attention specifically.
> >
> > Do you have an issue with adding this callback?  I think it will add an
> > important ability to the receive path for the mailbox API: letting the
> > client driver specify how to allocate the memory that the message is
> > coming in.  For general purpose mechanisms like PCC, this is essential:
> > the mailbox cannot know all of the different formats that the drivers
> > are going to require.  For example, the same system might have MPAM
> > (Memory Protection) and MCTP (Network Protocol) driven by the same PCC
> > Mailbox.
> >
> Looking at the existing code, I am not even sure if rx_alloc() is needed at all.
> 
> Let me explain...
> 1) write_response, via rx_alloc, is basically asking the client to
> allocate a buffer of length parsed from the pcc header in shmem.
> 2) write_response is called from isr and even before the
> mbox_chan_received_data() call.
> 
> Why can't you get rid of write_response() and simply call
>     mbox_chan_received_data(chan, pchan->chan.shmem)
> for the client to allocate and memcpy_fromio itself?
> Ideally, the client should have the buffer pre-allocated and only have
> to copy the data into it, but even if not it will still not be worse
> than what you currently have.
> 

Exactly, this is what I have been telling.

Adam,

Please share the code that you have attempted with this approach and the
problems you have faced.

-- 
Regards,
Sudeep

