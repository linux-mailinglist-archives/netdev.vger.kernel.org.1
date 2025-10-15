Return-Path: <netdev+bounces-229650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4C7BDF488
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 17:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCE23BF794
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 15:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48C12D73B4;
	Wed, 15 Oct 2025 15:08:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175052D7DDE
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760540893; cv=none; b=si2zHmLRSGIYXklD3qwVUTQjH5OBruDvB2hJGVg9cZTombFFeoNx5pC00FDVDTS9JnMS6bwEcdl01Y0waTPbo+4RQ9kO9nZ8B0PM/vDIHpOyfqszgXkkrtEdYHU16oVxxpHwJwxlFIiQuEwyUq65VBpIGViB+H+hZXlSH+wxXjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760540893; c=relaxed/simple;
	bh=DuiPtryBBi0eCs251UEa0Jkk3wsagB+gMqFBrhTj2FU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+zuKFlEx/rKpVSFOY+X9rM8jeRh6y5EXI7pCT01z9YG5E3WzQGgFCUYSlftziy3nXrjBKXLwW52lGneUa7bK7l/FZL2a97MnEgkxrjRKp2kx8gk30n9HyKrHOmO/Ww6LUh/CkDtsJmZakIYsiLiAGyWWxkXCYN1ZY7Q0RjWzhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 09D4B1601E2;
	Wed, 15 Oct 2025 15:08:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id CDEDB32;
	Wed, 15 Oct 2025 15:08:01 +0000 (UTC)
Date: Wed, 15 Oct 2025 11:08:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
 "bigeasy@linutronix.de" <bigeasy@linutronix.de>, "clrkwllms@kernel.org"
 <clrkwllms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
Subject: Re: Query about the impact of using CONFIG_PREEMPT_RT on locking
 mechanisms within networking drivers
Message-ID: <20251015110809.324e980e@gandalf.local.home>
In-Reply-To: <TYCPR01MB12093B8476E1B9EC33CBA4953C2E8A@TYCPR01MB12093.jpnprd01.prod.outlook.com>
References: <TYCPR01MB12093B8476E1B9EC33CBA4953C2E8A@TYCPR01MB12093.jpnprd01.prod.outlook.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5ebdw4je9ujae9w9spy77bg6u1sxo74f
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: CDEDB32
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/D8EB/L4/HKo5DEYJn+Etmid2SyCYmDs4=
X-HE-Tag: 1760540881-33100
X-HE-Meta: U2FsdGVkX19kRaSX07wJF0XB8ocgV/LvGjJs7grkpUyDX6RqBpNGOgPQbe0x473ECyIwu9zeaIJ/P+m5qB01bKl5k8I+aZO4doDcR3wtm8i7IsBqzQ4QRKXa8BG53r5vdlGJCYzHLj5f8nl3aQybYXf3y3CTfRA3PIhocDRqDQVFXG3augxdssqnCh9+95xsINZLD9NPDX76H9+iF5ARCFUKLYYlOpkjuegYHfqS0eNmDts6oT56SYi7FMlSYnS2sbKPo0E+iaC5h9s9JN/hK+pzy96oj+NL1oiJDfap4O3sSV5DyAu6t3PO94ItTQFyNgmA988YRnZRWpMw/uo46N8TcatgR/iF

On Wed, 15 Oct 2025 11:24:35 +0000
Fabrizio Castro <fabrizio.castro.jz@renesas.com> wrote:

> Dear All,
> 
> We have recently started debugging some issues that only show up
> with the kernel built with CONFIG_PREEMPT_RT=y, and we have noticed
> some differences w.r.t. the non-RT version.
> 
> One of the major differences that we have noticed is that spin locks
> basically become rtmutexes with the RT kernel, whereas they are mapped
> to raw spin locks in non-RT kernels.
> 
> When is using raw spin locks directly in networking drivers considered
> acceptable (if ever)?
> 
> Thank you for taking the time for reading this email, comments welcome.

The reason for the spin locks conversion to mutexes is simply to allow for
more preemption. A raw spin lock can not be preempted. If a lock is held
for more than a microsecond, you can consider it too long. There's a few
places that may hold locks longer (like the scheduler) but there's no
choice.

To allow spin locks to become mutexes, interrupts are also converted into
threads (including softirqs). There are also "local locks" that are used
for places that need to protect per-cpu data that is usually protected by
preempt_disable().

What issues are you having? It's likely that it can be tweaked so that you
do not have issues with PREEMPT_RT.

-- Steve


