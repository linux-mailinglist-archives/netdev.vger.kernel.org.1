Return-Path: <netdev+bounces-200041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 626C7AE2C5F
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 22:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0548118961A9
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 20:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA522701D8;
	Sat, 21 Jun 2025 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M6DmjXWd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3aagNb59"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B0D26FA5E;
	Sat, 21 Jun 2025 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750538579; cv=none; b=SEB2MefUHz501zkD9c2BmAbpJ1G+QVxlS0SPvt3JruvUhDqQGCJsSTO8cA9LzR4rYtNgl8eHEbNegsdWMe5oeGHv1NIcyyN8iTrJ4/FpNs6hRQ3J7Tb6FByodrLfyOzhvf4/EDkdoMV5Km7BZjLmzSTD3r5ZRxaWWxiZQv1/yRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750538579; c=relaxed/simple;
	bh=8b865mzkDVjLpqerOHXykHrNcC74FNQ/zusGWQGXblY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NY8Y2eTNLjuXUWfjBbVzdVDZipt+sBmxfjGcj4+i2D2VEgMWXqpjcBxKTOqsQ2HEeLxxmPHrq8PHr0ydQpXyTJC477HKtBRv3A9shsC0hnGc76pagjcxXiJ+P+b+OznoQ3+NzG47lvSHmZWGo19gUrCGBLgMWZsWP0eiO6iSN6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M6DmjXWd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3aagNb59; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750538575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R1qBwCioy5MgbwLhHqw29fMst1DLaJFYqcMmM7rC4bs=;
	b=M6DmjXWdj9ohG7zLJQrX4EA3xhl3D3890a/1fnfwjZPOpRafsGC1fAegk5XXdfvjB3tXwg
	EKnlehp76lZ9A9ojXa3OQg5fEy8oQZM2lYN/D181aZ8Q4YtfNSgXEjSJanWJalL91bZmlA
	KhVmvw7iPnKvaPOQGrxFuH8SVIp2zyurN4hlgjQuZaN8/pRIx6NMEYdk2U/qbO20oLu3sS
	RX8J+HfDbgqwviJCDl+rqsh64/WYXSNHtpnKOp4J9hSrK85Hr9z6NSnbSJHI5oeNTk9cA8
	yuDPNn8CBDYOmDk8JVbG/TNdq8ok6KTXPiUa9u7JwtD0DoFwmaGD/RpE4pW9+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750538575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R1qBwCioy5MgbwLhHqw29fMst1DLaJFYqcMmM7rC4bs=;
	b=3aagNb59/OvlaodLp+t5EqSvSEAh5R/3CsAST9/1nhquzhSYLwO0HMwEhl8FClxcrozW9h
	o+CHZVeBR2pO7HCw==
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
Subject: Re: [patch 07/13] ptp: Split out PTP_SYS_OFFSET ioctl code
In-Reply-To: <83c30e4a-d674-47a7-bda9-4b2fc0d590e3@linux.dev>
References: <20250620130144.351492917@linutronix.de>
 <20250620131944.156514985@linutronix.de>
 <83c30e4a-d674-47a7-bda9-4b2fc0d590e3@linux.dev>
Date: Sat, 21 Jun 2025 22:42:54 +0200
Message-ID: <87a560q10x.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jun 21 2025 at 21:14, Vadim Fedorenko wrote:
> On 20/06/2025 14:24, Thomas Gleixner wrote:
>> +	pct = &sysoff->ts[0];
>> +	for (unsigned int i = 0; i < sysoff->n_samples; i++) {
>> +		struct ptp_clock_info *ops = ptp->info;
>
> Looks like *ops initialization can be moved outside of the loop.

Well it can, but does it matter? No, because this is only a coding
artifact. The compiler can evaluate ptp->info inside of the loop at his
own peril even on both usage sites.

Though what's more important is that from a context point of view, ops
belongs into the loop, because that's where it is used and not outside,
no?

Thanks,

        tglx

