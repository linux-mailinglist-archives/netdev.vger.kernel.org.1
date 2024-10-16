Return-Path: <netdev+bounces-136184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 567659A0D48
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 16:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DCFB1F24044
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 14:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C3C20CCD0;
	Wed, 16 Oct 2024 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EKKKBTcF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="10MRcRyK"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2652B14F114;
	Wed, 16 Oct 2024 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090342; cv=none; b=Deli5/9xqkUI9vOqlFdJlY5ZyxyugcGdQEXzmw2jtQdwn5/vYbSwh61h6ZlZpAo2Qi0F9MjwhqsSHGHIRFGYh/SWgfIP5vAYf3v3qHlX8rSAYoVZGh4iYKJ4AQz2NgHsNLFfYjgt4z5KzguCMtfytjpzEi0TxpwXmU0BzZTnhQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090342; c=relaxed/simple;
	bh=jheGUNQp3jvmRMEIsYqXlubhRBxYkRt6CAwDq2F8TF0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OXpPwFycxHwr+oGb529djKhAdrLebavEdjMLyWxkwmLUsyJsI1m9LcUXJCHm4YV92vhEveqUuUdXk9lWRSNVD7dhXhGvornBvFTzKSAoSCjiHmAAIW4CHukD8v6buoUa2jH1zeSggeM0Xqwpm1KMX73KMWVu2zczGw3EvCVXZLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EKKKBTcF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=10MRcRyK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729090338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nQFpIFRQ+pVFsLZBaGtgYJvYAa5CdSGNPAeItWvRYvM=;
	b=EKKKBTcFLZ+C71M7W+roVrj3cbDM4ysJVOm2W1ad04Zvs/ixRYtXchmlT7tJBOhi9WzLcB
	D1jSzdJmsT9TZWKNlf5VV8UxEk7hnyd/oLJsV2L+d3XVGiDxr6TUDfNhRfc/OkOUyiU9iu
	gQ5kLmSRsnH1gzpPD4+9/VCmJmSR9nYLgBttoKyH9rDpIKBDnU7j5Y2sQkApYsU6Z2r8KF
	VOW1th59jxN+5kflshlqDzJ4ITS7y6XzSZlH6D4IDAj5IULF0OrtUBiyvnLcgVP3DvmIsT
	HZD+Eded7xpObpFZrsUZ7K9b6UDsLEs7xld/wGririYGDIq+5jLDi43fDPnBQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729090338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nQFpIFRQ+pVFsLZBaGtgYJvYAa5CdSGNPAeItWvRYvM=;
	b=10MRcRyKWUIcuypO0VhFvsnizU44PXSmLWC5xVarwisKqZdpF+e3GNNL67VbL5ifxOy7wv
	6Kt1/5oOOTZ+QVAw==
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, bryan.whitehead@microchip.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 anna-maria@linutronix.de, frederic@kernel.org, richardcochran@gmail.com,
 johnstul@us.ibm.com, UNGLinuxDriver@microchip.com, jstultz@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 1/2] posix-clock: Fix missing timespec64 check
 in pc_clock_settime()
In-Reply-To: <20241015162227.4265d7b2@kernel.org>
References: <20241009072302.1754567-1-ruanjinjie@huawei.com>
 <20241009072302.1754567-2-ruanjinjie@huawei.com>
 <20241011125726.62c5dde7@kernel.org> <87v7xtc7z5.ffs@tglx>
 <20241015162227.4265d7b2@kernel.org>
Date: Wed, 16 Oct 2024 16:52:17 +0200
Message-ID: <87frowcd7i.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 15 2024 at 16:22, Jakub Kicinski wrote:
> On Wed, 16 Oct 2024 00:33:02 +0200 Thomas Gleixner wrote:
>> > I'm guessing we can push this into 6.12-rc and the other patch into
>> > net-next. I'll toss it into net on Monday unless someone objects.  
>> 
>> Can you folks please at least wait until the maintainers of the code in
>> question had a look ?
>
> You are literally quoting the text where I say I will wait 3 more days.
> Unfortunately "until the maintainers respond" leads to waiting forever
> 50% of the time, and even when we cap at 3 working days we have 300
> patches in the queue (292 right now, and I already spent 2 hours
> reviewing today). Hope you understand.

I understand very well, but _I_ spent the time to review the earlier
variants of these patches and to debate with the submitter up to rev
5.

Now you go and apply a patch to a subsystem you do not even maintain just
because I did not have the bandwidth to look at it within the time
limit you defined? Seriously?

This problem is there for years, so a few days +/- are absolutely not
relevant.

> Sorry if we applied too early, please review, I'll revert if it's no
> good.

I assume you route it to Linus before 6.12 final. So let it applied.

Thanks,

        tglx

