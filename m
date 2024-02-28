Return-Path: <netdev+bounces-75776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B994786B272
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 15:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23964288C22
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E8A15B967;
	Wed, 28 Feb 2024 14:54:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804D215B11F;
	Wed, 28 Feb 2024 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132086; cv=none; b=HVAgoXsERvjHbvIsUY/fduWrUbB/rPMjcafiEuLnFKir+arxo5sFXdcH8nKRih38IMM6R6rJXzzj1Ou0oYz8ypKB9RAyegvJKo8sybeFAB8VbrovTgO8u4WD4Qy0dxoq6N+drJ4Ji3t1T8U8USAH2IbG5OP/7U3cSr5pt3GQuPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132086; c=relaxed/simple;
	bh=wW+rzE5/HSFl0GaMs1eCk+iBVbwVvAHBBLkAbYyERb0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOVpxhBrbN29/tAibs7M74KeUuh8KRx24klGA+KDST3Y7ZTs7UYpBtXJYLyRkXLGFSaCitLBqbelpb3rdgDGMwiayUeSl44taic3bnQn/3Evv5NjlrqrDJ/g7EnYHMBBcSvadXAz5K4Uz7RatSs0ePMd4f5rqAszcTeJ4vmHzFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D31C43390;
	Wed, 28 Feb 2024 14:54:44 +0000 (UTC)
Date: Wed, 28 Feb 2024 09:56:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, kuba@kernel.org,
 roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, jiri@resnulli.us, ivecera@redhat.com,
 mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next 4/4] net: switchdev: Add tracepoints
Message-ID: <20240228095648.646a6f1a@gandalf.local.home>
In-Reply-To: <87a5nkhnlv.fsf@waldekranz.com>
References: <20240223114453.335809-1-tobias@waldekranz.com>
	<20240223114453.335809-5-tobias@waldekranz.com>
	<20240223103815.35fdf430@gandalf.local.home>
	<4838ad92a359a10944487bbcb74690a51dd0a2f8.camel@redhat.com>
	<87a5nkhnlv.fsf@waldekranz.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 11:47:24 +0100
Tobias Waldekranz <tobias@waldekranz.com> wrote:

> >> > +	TP_fast_assign(
> >> > +		__entry->val = val;
> >> > +		__assign_str(dev, info->dev ? netdev_name(info->dev) : "(null)");
> >> > +		__entry->info = info;
> >> > +		__entry->err = err;
> >> > +		switchdev_notifier_str(val, info, __entry->msg, SWITCHDEV_TRACE_MSG_MAX);  
> >> 
> >> Is it possible to just store the information in the trace event and then
> >> call the above function in the read stage?  
> >
> > I agree with Steven: it looks like that with the above code the
> > tracepoint itself will become measurably costily in terms of CPU
> > cycles: we want to avoid that.
> >
> > Perhaps using different tracepoints with different notifier_block type
> > would help? so that each trace point could just copy a few specific
> > fields.  
> 
> This can be done, but you will end up having to duplicate the decoding
> and formatting logic from switchdev-str.c, with the additional hurdle of
> having to figure out the sizes of all referenced objects in order to
> create flattened versions of every notification type.

Would it help if you could pass a trace_seq to it? The TP_printk() has a
"magical" trace_seq variable that trace events can use in the TP_printk()
called "p".

Look at:

  include/trace/events/libata.h:

const char *libata_trace_parse_status(struct trace_seq*, unsigned char);
#define __parse_status(s) libata_trace_parse_status(p, s)

Where we have:

const char *
libata_trace_parse_status(struct trace_seq *p, unsigned char status)
{
	const char *ret = trace_seq_buffer_ptr(p);

	trace_seq_printf(p, "{ ");
	if (status & ATA_BUSY)
		trace_seq_printf(p, "BUSY ");
	if (status & ATA_DRDY)
		trace_seq_printf(p, "DRDY ");
	if (status & ATA_DF)
		trace_seq_printf(p, "DF ");
	if (status & ATA_DSC)
		trace_seq_printf(p, "DSC ");
	if (status & ATA_DRQ)
		trace_seq_printf(p, "DRQ ");
	if (status & ATA_CORR)
		trace_seq_printf(p, "CORR ");
	if (status & ATA_SENSE)
		trace_seq_printf(p, "SENSE ");
	if (status & ATA_ERR)
		trace_seq_printf(p, "ERR ");
	trace_seq_putc(p, '}');
	trace_seq_putc(p, 0);

	return ret;
}

The "trace_seq p" is a pointer to trace_seq descriptor that can build
strings, and then you can use it to print a custom string in the trace
output.



> 
> What I like about the current approach is that when new notification and
> object types are added, switchdev_notifier_str will automatically be
> able to decode them and give you some rough idea of what is going on,
> even if no new message specific decoding logic is added. It is also
> reusable by drivers that might want to decode notifications or objects
> in error messages.
> 
> Would some variant of (how I understand) Steven's suggestion to instead
> store the formatted message in a dynamic array (__assign_str()), rather
> than in the tracepoint entry, be acceptable?

Matters if you could adapt using a trace_seq for the output. Or at least
use a seq_buf, as that's what is under the covers of trace_seq. If you
rather just use seq_buf, the above could pretty much be the same by passing
in: &p->seq.

-- Steve

