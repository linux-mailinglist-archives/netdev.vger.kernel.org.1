Return-Path: <netdev+bounces-78122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3421874224
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 22:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 948C1B223E9
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 21:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E5B19478;
	Wed,  6 Mar 2024 21:44:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E851363C8;
	Wed,  6 Mar 2024 21:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709761476; cv=none; b=dQE9HZpEjUlgzIzjnYDzi8weAbVOgm1WMouGgaE7AWXTlWDlGalvrArSB6bzrXj8Vji+nG1ng3dyykw3jHIqx2OseqL7UqkNfzXeeEC10Mf4p7E5zyv15f6Z7wPWRErDjlSksSe8giVLDYy4248VQ2lOkPnR1lhTLGDI3XhlQYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709761476; c=relaxed/simple;
	bh=NykU08nLzEZ91K+MMjjKpK5S8+ge0fdkiC/HpzTY4is=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HUVk8frfhgt6GTahjMPK4oYL4JMbkaZ6RmuKUoNXCEouBpbMtjCW31k4aplEdmuVChdz3lmL27xpOvP4eCFmz4+0oc+BA9i/r1vavD4u4O1iiqZgM1zUR+PRYxXh02vxNjuxtmCcnnLpebTzdHRFjOeL1P9WWYDNBxl8OHpvzhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E95BC433F1;
	Wed,  6 Mar 2024 21:44:34 +0000 (UTC)
Date: Wed, 6 Mar 2024 16:46:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, kuba@kernel.org,
 roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, jiri@resnulli.us, ivecera@redhat.com,
 mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next 4/4] net: switchdev: Add tracepoints
Message-ID: <20240306164626.5a11f3cd@gandalf.local.home>
In-Reply-To: <874jdjgmdd.fsf@waldekranz.com>
References: <20240223114453.335809-1-tobias@waldekranz.com>
	<20240223114453.335809-5-tobias@waldekranz.com>
	<20240223103815.35fdf430@gandalf.local.home>
	<4838ad92a359a10944487bbcb74690a51dd0a2f8.camel@redhat.com>
	<87a5nkhnlv.fsf@waldekranz.com>
	<20240228095648.646a6f1a@gandalf.local.home>
	<877cihhb7y.fsf@waldekranz.com>
	<20240306101557.2c56fbc6@gandalf.local.home>
	<874jdjgmdd.fsf@waldekranz.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 06 Mar 2024 21:02:06 +0100
Tobias Waldekranz <tobias@waldekranz.com> wrote:

> On ons, mar 06, 2024 at 10:15, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Mon, 04 Mar 2024 23:40:49 +0100
> > Tobias Waldekranz <tobias@waldekranz.com> wrote:
> >  
> >> On ons, feb 28, 2024 at 09:56, Steven Rostedt <rostedt@goodmis.org> wrote:  
> >> > On Wed, 28 Feb 2024 11:47:24 +0100
> >> > Tobias Waldekranz <tobias@waldekranz.com> wrote:
> >> >  
> >> > The "trace_seq p" is a pointer to trace_seq descriptor that can build
> >> > strings, and then you can use it to print a custom string in the trace
> >> > output.    
> >> 
> >> Yes I managed to decode the hidden variable :) I also found
> >> trace_seq_acquire() (and its macro alter ego __get_buf()), which would
> >> let me keep the generic stringer functions. So far, so good.
> >> 
> >> I think the foundational problem remains though: TP_printk() is not
> >> executed until a user reads from the trace_pipe; at which point the
> >> object referenced by __entry->info may already be dead and
> >> buried. Right?  
> >
> > Correct. You would need to load all the information into the event data
> > itself, at the time of the event is triggered, that is needed to determine
> > how to display it.  
> 
> Given that that is quite gnarly to do for the events I'm trying to
> trace, because of the complex object graph, would it be acceptable to
> format the message in the assign phase and store it as dynamic data?
> I.e., what (I think) you suggested at the end of your first response.

It's really up to what you want to do ;-)

> 
> My thinking is:
> 
> - Managing a duplicate (flattened) object graph, exclusively for use by
>   these tracepoints, increases the effort to keep the tracing in sync
>   with new additions to switchdev; which I think will result in
>   developers simply avoiding it altogether. In other words: I'd rather
>   have somewhat inefficient but simple flashlight, rather than a very
>   efficient one that no one knows how to change the batteries in.
> 
> - This is typically not a very hot path. Most events are triggered by
>   user configuration. Otherwise when new neighbors are discovered.
> 
> - __entry->info is still there for use by raw tracepoint consumers from
>   userspace.

How big is this info?

-- Steve

