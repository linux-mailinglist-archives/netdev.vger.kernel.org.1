Return-Path: <netdev+bounces-226727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840E9BA4775
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 17:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 125437A6680
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2752721D3F4;
	Fri, 26 Sep 2025 15:45:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8722221CC68;
	Fri, 26 Sep 2025 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901501; cv=none; b=YontRJ0AJJdXXjiRtJUuqFPef0dytlXpBsH0mXiiNriJdfJVyUK3mZIHT9FFnMtHoC8aQzPbw15p/KcsFs4TsAZfNPZEKt24ni6riz5Sx5U0VmwOI/vgdMox+u3ClLEeRegQqLUixFRvw6bFVqqNZblJb/OLBEk1F98v00T5lLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901501; c=relaxed/simple;
	bh=Z+08pd5trXxeIG91iltKrZxqf8DLeOFMe/rwCu6XuHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbzIy7UZ/0muoYU9eQ/BPBLuLGiD3ZXMA82qP/VKaA7OyUYpTVWZvk6u3KYQDj8wUwxZXxoVwwyKSVnUFf/svnr6hXy/4LzB0r+8ndqUDGm7kO4z46fKx/KKaCzO2DPAK8JzWeAz85D6VbauNWDWEs6Qv9tyEW2XdmuzHlYH9co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B60691691;
	Fri, 26 Sep 2025 08:44:50 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A07A23F66E;
	Fri, 26 Sep 2025 08:44:56 -0700 (PDT)
Date: Fri, 26 Sep 2025 16:44:53 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Adam Young <admiyo@os.amperecomputing.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH net-next v29 1/3] mailbox: add callback function for rx
 buffer allocation
Message-ID: <aNa09S7h8MgWajKe@bogus>
References: <20250925190027.147405-1-admiyo@os.amperecomputing.com>
 <20250925190027.147405-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925190027.147405-2-admiyo@os.amperecomputing.com>

Hi,

On Thu, Sep 25, 2025 at 03:00:24PM -0400, Adam Young wrote:
> Allows the mailbox client to specify how to allocate the memory
> that the mailbox controller uses to send the message to the client.
> 
> In the case of a network driver, the message should be allocated as
> a struct sk_buff allocated and managed by the network subsystem.  The
> two parameters passed back from the callback represent the sk_buff
> itself and the data section inside the skbuff where the message gets
> written.
> 
> For simpler cases where the client kmallocs a buffer or returns
> static memory, both pointers should point to the same value.
> 

I have posted a revert[1] of a patch that you got merged recently and
this change builds on top of that. Please start fresh with that patch/revert
applied and explain why you can't use tx_prepare and rx_callback as
suggested and then we can take it from there. It makes no sense to add
these optional callbacks the way it is done at the least. If you are
worried about duplication of shmem handling, IIUC, it is done intentionally
to give that flexibility to the clients. If you think it can be consolidated,
I would rather have them as a standard helper which can be assigned to
tx_prepare and rx_callback and convert few users to demonstrate the same.

So I definitely don't like this addition and NACK until all those details
are looked at and you have convinced it can't be achieved via those and need
more changes.

On the other hand, the consolidation is a good thought, but it can't be
addition without any other drivers except you new yet to be merged driver
as the sole user of that. If there are no users needing copying to/from
the shared memory like you driver, then I am happy to consider this but it
needs more thinking and reviewing for sure. I will also have a look.

Sorry for missing the review of the original patch that got merged, my bad.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/all/20250926153311.2202648-1-sudeep.holla@arm.com

