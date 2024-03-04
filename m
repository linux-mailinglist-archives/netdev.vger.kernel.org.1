Return-Path: <netdev+bounces-77266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D1E87102E
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 23:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474431C20F8A
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 22:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0207BAE3;
	Mon,  4 Mar 2024 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="g0V6xPBK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3B017555
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 22:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592055; cv=none; b=VdZnlC0rS1VkPslCZcoWuJ6Mqf2mUvB3vVq0/dmc7N0kl+LAFO47rS5AVM/KkdxCslYsKiAFtVp6475keTT+5OkZ/wJtz56xy7RjIVbf65PlEOOjS2hEVdlnM/zdkETyowWcgfcVc0gMZ/KBYPIRLbxmP36tV1gomk8mW5ldRcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592055; c=relaxed/simple;
	bh=5XXHkM40iiZTjxlfUzE91RiBOCSflLc2nfbu/SaZ7VY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mw0FvQVYZARswunKo2TKB1JhOom10R4qWQB5w9l5fpZ0OJaEB1Gw/KqPmiaoUAvKTsylbZQYmDSSkrFcVTRH7n9tWFpr1KWMZulBaiZASmpFRYXguJbz8nKNO2r96+U9lz9MJvJwKmpW8kB4esPZkayPB6Pq0u8vFyT6TjiBKQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=g0V6xPBK; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d28387db09so60084721fa.0
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 14:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1709592052; x=1710196852; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cdh0FQGbsGzvigQxix/33N2xTkkyynvJysdSSvdUw/k=;
        b=g0V6xPBKGqMQd1t2e0j8AyVjOnWOdsj2BpUredOU3YtjV7K5RVyQO/tV/6scMqWMDM
         AukxZP88WjbvcASSw9bYUoDw4aecXlV1RZoQ0/kE8uQgKiX+ixhCY//2FNqwR/hoj6AH
         ABPreEkHAnOQW/k8r4ROC2zr/8x18KufLKZNqtwaHLxHsh8AcZoHBMfrt/icuTa6c+mu
         SxsixTrPEDz8hsYWCN8bqc1JIN9SI/wjGlu9BqyCye+wwuaYT3fCQWhU6RyNBCpSxbc+
         eYdRbHP7QJv0uqkuGvsEs0oMsJ3bbl9P4I8+nZiyX8Ly34A+QEhjwfiGPcIkbwcL/T2Y
         pTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709592052; x=1710196852;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cdh0FQGbsGzvigQxix/33N2xTkkyynvJysdSSvdUw/k=;
        b=nTIz2dB8oEaCCoCvvw3EzDzb3qyVjkQQvdHyjwGQko8hW0sqY94NdIBHeyHE+MSZHc
         gxzx7jOmSEle7wb8FgoBL9CxPHipwS86viZ+FRyHKKNnWZrjEqzk0EP7NyZWeO1x3SBW
         B33IamFg5b6jP/oeFFvvlV+zk66KT8TI+qGIyehFIhPTLLbbXwEVFZjbccowBqL2OaNK
         m3g58CDN8WgEMzYgGliNAcKPzWMMKsvUk2Btuse1fpdNR5brj6IP8pI+SAei4OTxsKn8
         qhccWDjUPHPAqVZR+IZrGyd+b3utLs6kXYudZjo1tV4rpFdRa6jZ31FIdufFztq/Zhcq
         ZnBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy7onrxBRuGOAMyidgyakT5WxFpxglSgPLw5/uxFI7GnfM5xuLA5wK0Abewc6WZba9CLqe+aqmiOO3x9g7qnMy6SRQ7+Xg
X-Gm-Message-State: AOJu0YwANYkcO69hZY6vo3lZVwTdTz1X/ZlVJ31TTF9uolKBs9sg8hXE
	Duhj5U7wT/3bSxGnzDi0rpt4qCp+Gaodp9ikxyO56x7YXoKsN/MyPy9sqdt0WcHNChr/JSv8M6G
	Q
X-Google-Smtp-Source: AGHT+IGg/uCC7hFxHYqui84BZlHHuBl0x+92dDxwC2cR3sRjEmRA8Zpl/zu6I+pg9ZhRpfixGDWZNQ==
X-Received: by 2002:ac2:5e7c:0:b0:512:f5af:3bdf with SMTP id a28-20020ac25e7c000000b00512f5af3bdfmr75071lfr.68.1709592051651;
        Mon, 04 Mar 2024 14:40:51 -0800 (PST)
Received: from wkz-x13 (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id i27-20020ac25b5b000000b005128cf5b323sm1913264lfp.251.2024.03.04.14.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 14:40:50 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, kuba@kernel.org,
 roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, jiri@resnulli.us, ivecera@redhat.com,
 mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next 4/4] net: switchdev: Add tracepoints
In-Reply-To: <20240228095648.646a6f1a@gandalf.local.home>
References: <20240223114453.335809-1-tobias@waldekranz.com>
 <20240223114453.335809-5-tobias@waldekranz.com>
 <20240223103815.35fdf430@gandalf.local.home>
 <4838ad92a359a10944487bbcb74690a51dd0a2f8.camel@redhat.com>
 <87a5nkhnlv.fsf@waldekranz.com>
 <20240228095648.646a6f1a@gandalf.local.home>
Date: Mon, 04 Mar 2024 23:40:49 +0100
Message-ID: <877cihhb7y.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On ons, feb 28, 2024 at 09:56, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 28 Feb 2024 11:47:24 +0100
> Tobias Waldekranz <tobias@waldekranz.com> wrote:
>
>> >> > +	TP_fast_assign(
>> >> > +		__entry->val = val;
>> >> > +		__assign_str(dev, info->dev ? netdev_name(info->dev) : "(null)");
>> >> > +		__entry->info = info;
>> >> > +		__entry->err = err;
>> >> > +		switchdev_notifier_str(val, info, __entry->msg, SWITCHDEV_TRACE_MSG_MAX);  
>> >> 
>> >> Is it possible to just store the information in the trace event and then
>> >> call the above function in the read stage?  
>> >
>> > I agree with Steven: it looks like that with the above code the
>> > tracepoint itself will become measurably costily in terms of CPU
>> > cycles: we want to avoid that.
>> >
>> > Perhaps using different tracepoints with different notifier_block type
>> > would help? so that each trace point could just copy a few specific
>> > fields.  
>> 
>> This can be done, but you will end up having to duplicate the decoding
>> and formatting logic from switchdev-str.c, with the additional hurdle of
>> having to figure out the sizes of all referenced objects in order to
>> create flattened versions of every notification type.
>
> Would it help if you could pass a trace_seq to it? The TP_printk() has a
> "magical" trace_seq variable that trace events can use in the TP_printk()
> called "p".
>
> Look at:
>
>   include/trace/events/libata.h:
>
> const char *libata_trace_parse_status(struct trace_seq*, unsigned char);
> #define __parse_status(s) libata_trace_parse_status(p, s)
>
> Where we have:
>
> const char *
> libata_trace_parse_status(struct trace_seq *p, unsigned char status)
> {
> 	const char *ret = trace_seq_buffer_ptr(p);
>
> 	trace_seq_printf(p, "{ ");
> 	if (status & ATA_BUSY)
> 		trace_seq_printf(p, "BUSY ");
> 	if (status & ATA_DRDY)
> 		trace_seq_printf(p, "DRDY ");
> 	if (status & ATA_DF)
> 		trace_seq_printf(p, "DF ");
> 	if (status & ATA_DSC)
> 		trace_seq_printf(p, "DSC ");
> 	if (status & ATA_DRQ)
> 		trace_seq_printf(p, "DRQ ");
> 	if (status & ATA_CORR)
> 		trace_seq_printf(p, "CORR ");
> 	if (status & ATA_SENSE)
> 		trace_seq_printf(p, "SENSE ");
> 	if (status & ATA_ERR)
> 		trace_seq_printf(p, "ERR ");
> 	trace_seq_putc(p, '}');
> 	trace_seq_putc(p, 0);
>
> 	return ret;
> }
>
> The "trace_seq p" is a pointer to trace_seq descriptor that can build
> strings, and then you can use it to print a custom string in the trace
> output.

Yes I managed to decode the hidden variable :) I also found
trace_seq_acquire() (and its macro alter ego __get_buf()), which would
let me keep the generic stringer functions. So far, so good.

I think the foundational problem remains though: TP_printk() is not
executed until a user reads from the trace_pipe; at which point the
object referenced by __entry->info may already be dead and
buried. Right?

>> 
>> What I like about the current approach is that when new notification and
>> object types are added, switchdev_notifier_str will automatically be
>> able to decode them and give you some rough idea of what is going on,
>> even if no new message specific decoding logic is added. It is also
>> reusable by drivers that might want to decode notifications or objects
>> in error messages.
>> 
>> Would some variant of (how I understand) Steven's suggestion to instead
>> store the formatted message in a dynamic array (__assign_str()), rather
>> than in the tracepoint entry, be acceptable?
>
> Matters if you could adapt using a trace_seq for the output. Or at least
> use a seq_buf, as that's what is under the covers of trace_seq. If you
> rather just use seq_buf, the above could pretty much be the same by passing
> in: &p->seq.
>
> -- Steve

