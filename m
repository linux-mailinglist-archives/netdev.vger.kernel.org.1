Return-Path: <netdev+bounces-77967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F64E873A74
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE1C284BF7
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F022E13473B;
	Wed,  6 Mar 2024 15:14:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DF81339B1;
	Wed,  6 Mar 2024 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709738046; cv=none; b=dilePoKJBl7yqFKILokoVlAlA5uyvZ6c4B4DanbuSI4sZ3HeUsLsADsuahHUd3UBV5a8R1SdNYM9V0cRd9PDOTanGAD7lEQ/u9OYoZA5QUW/MAN8s3l7v64tG2uTpQGSTDdQcjLeRE/pxIu2JZQLR0OwcFaBft5/JnJWnKq1jTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709738046; c=relaxed/simple;
	bh=QPoRWBQwoZTSakOo7SWfWUWThzlvSWX6dzXYjN9HZ1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwofO3JT9LID3hIvL7sJLLsWyqDail+1F4mYZiN6dUST7VwZsfVxccsttBn79zHD8fJ26x/cAIZl0K0HoNEYGfylJhNxRaYutIVgfNDLJka7IYoy+eMqMhDmXtMRd96V9fBILaniJgzoTHf7TGn+G0sdLzaApPUhZPX9hJgWkmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0E1C433F1;
	Wed,  6 Mar 2024 15:14:05 +0000 (UTC)
Date: Wed, 6 Mar 2024 10:15:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, kuba@kernel.org,
 roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, jiri@resnulli.us, ivecera@redhat.com,
 mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next 4/4] net: switchdev: Add tracepoints
Message-ID: <20240306101557.2c56fbc6@gandalf.local.home>
In-Reply-To: <877cihhb7y.fsf@waldekranz.com>
References: <20240223114453.335809-1-tobias@waldekranz.com>
	<20240223114453.335809-5-tobias@waldekranz.com>
	<20240223103815.35fdf430@gandalf.local.home>
	<4838ad92a359a10944487bbcb74690a51dd0a2f8.camel@redhat.com>
	<87a5nkhnlv.fsf@waldekranz.com>
	<20240228095648.646a6f1a@gandalf.local.home>
	<877cihhb7y.fsf@waldekranz.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 04 Mar 2024 23:40:49 +0100
Tobias Waldekranz <tobias@waldekranz.com> wrote:

> On ons, feb 28, 2024 at 09:56, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Wed, 28 Feb 2024 11:47:24 +0100
> > Tobias Waldekranz <tobias@waldekranz.com> wrote:
> >  
> > The "trace_seq p" is a pointer to trace_seq descriptor that can build
> > strings, and then you can use it to print a custom string in the trace
> > output.  
> 
> Yes I managed to decode the hidden variable :) I also found
> trace_seq_acquire() (and its macro alter ego __get_buf()), which would
> let me keep the generic stringer functions. So far, so good.
> 
> I think the foundational problem remains though: TP_printk() is not
> executed until a user reads from the trace_pipe; at which point the
> object referenced by __entry->info may already be dead and
> buried. Right?

Correct. You would need to load all the information into the event data
itself, at the time of the event is triggered, that is needed to determine
how to display it.

-- Steve


