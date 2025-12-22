Return-Path: <netdev+bounces-245743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01397CD6D57
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 18:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3776F3045F7D
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 17:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF002319604;
	Mon, 22 Dec 2025 17:24:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5917A2FE589;
	Mon, 22 Dec 2025 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766424293; cv=none; b=nWkACNLVCFjFRLRjS67aiHNtO6+k/7FrRV2nj0/sw/8e3Y4VsIyWzi49WvS6kZFDrjZN8ioMnggQRZvvpxQk/rd4Uu/qSUF2J7DA0mhu/8wWw44OpCibSc3iuesghLd80fFF9OID69qXwStN8dLCfy4ixdZ+FWwTviXIvJzlbS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766424293; c=relaxed/simple;
	bh=Lv1tifWSSAu97WJmWQDHDADcPhJWieLqs0WZxgRO3xI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7e/641ELGnMlEh440eKp2/lUdqQqyaR1+LPHo5kEMmdXxMr7pxOynZ64YzeMU21NtIR3OvaB+kLZK0NEoLAKdsk+6xC7HmJlqkS7VIfCdRYe9tiZxaDlnLT7S28SPOkwbRISUvqv0XKwxSCbaC071Mx5/9XkILueSRxKZp4WEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 5A1A81A026B;
	Mon, 22 Dec 2025 17:24:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 96E1E2000F;
	Mon, 22 Dec 2025 17:24:40 +0000 (UTC)
Date: Mon, 22 Dec 2025 12:26:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
 syzbot+9b35e9bc0951140d13e6@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v2] ipv6: fix a BUG in rt6_get_pcpu_route() under
 PREEMPT_RT
Message-ID: <20251222122628.38e9bc89@gandalf.local.home>
In-Reply-To: <20251222121639.3953ea08@gandalf.local.home>
References: <20251219025140.77695-1-jiayuan.chen@linux.dev>
	<CANn89iLeASUZyonYSLX0AG5mbC=gxux0efehkBc_j1bbj6xrvA@mail.gmail.com>
	<20251222121639.3953ea08@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 96E1E2000F
X-Stat-Signature: 9i3hpyxor4p4sb7rzgjh6mcpxdefcgga
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19qDrVqYSa0iEs6XcszNqiIWakCG1vHKeY=
X-HE-Tag: 1766424280-938894
X-HE-Meta: U2FsdGVkX1//i2lGNRX/XANnKqiYMMBVA+zbELtJSIzCY62u8nwLmyETToVIkmc4gsZJAIsI+/u2ueorbztRO2o5Mx5QlY9pMXYQ+HVhaRB7C6OIm4HTWOsUa5YbFwLfBEqJhWKZEhc/2uR+UTJJbsN6P4VMb1bqJI4Y/sMrza+/ZP9VTfJK4zu+wzPH59Vq0wFlXZ9HQRbFiWsutRxU2oRlr/14ZafD65Aq3FrboudtKyG0sSVqiQu7NXOikLctZUHdMyBKfRgoIjsyx0eb3WheytPbZmiJvi8xt92NoAEmEASR5larMP5vdqhGcIZgO0YfPIkW06kGHttULL+3wAL26qJupM6ujNEVRyUcAxB53Ow8o73PEi++8tVM9kVKRlvFLRcelNGTWIMsfxEOrybq8ucQ7q8EoyvLsgiq7w0RTFdjQp13WyAZk6HPmMXUcsSzMuWHA4Yv5y4M9+cVCg==

On Mon, 22 Dec 2025 12:16:39 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 22 Dec 2025 09:50:58 +0100
> Eric Dumazet <edumazet@google.com> wrote:
> 
> > > Link: https://syzkaller.appspot.com/bug?extid=9b35e9bc0951140d13e6
> > > Fixes: 951f788a80ff ("ipv6: fix a BUG in rt6_get_pcpu_route()")    
> > 
> > I would rather find when PREEMPT_RT was added/enabled, there is no
> > point blaming such an old commit
> > which was correct at the time, and forcing pointless backports to old
> > linux kernels.  
> 
> Ack!

Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")

That was the first commit to enable PREEMPT_RT on any architecture (just
happened to be x86).

-- Steve

