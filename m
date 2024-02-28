Return-Path: <netdev+bounces-75643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2199486AC59
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 11:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6701F24847
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 10:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B92112B151;
	Wed, 28 Feb 2024 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="NzU+m5fb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9F17E56C
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709117250; cv=none; b=A4MPm5yuWtBnXjmJL7Qy+2V9B0jFGdjqm4LUl+irzpesxdx+5OjMaKuTf+cgkUxLDMnrmZRHR8qLmJ9N5Y8BID13cWIAFQWTvpGay7EI0uKL5n/X+XNEEAzAfnvLdfkXrfrJrM/TbmfejAJOByZF9y25vdJyYnwLwaKd9gdV7hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709117250; c=relaxed/simple;
	bh=79YniYFNyG3YEwZJmfAuvVSIywECnQgPLZkG8Vpl12o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oLDsmDQdBlnlJ57oi4vPT3WFfEEB8P4SAxIVTeSs5EvK77REET0RpAM3VubOztT1mgdqlUrtQFKwUE7ClSEWoTVyHREQHYlz+gbHOq67gCzkQxTn29SoIC+LJKKzxtm7+rIhL2b2Q+gvnjjyRpmx7l5Fzuhes5GnS+88O02KR20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=NzU+m5fb; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513184f69abso894041e87.0
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 02:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1709117246; x=1709722046; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wfRgdwzRN8mqJPSb0k4wCFiTLF5dChF82GwwW7l41yg=;
        b=NzU+m5fbykbnLdAGdKKGwBiEthTk26pP2WU0/XHxh8BVyVaKaqalmt4OdKu4yWSWTa
         VlMLbBLwGADsZa8NOkPDvzOfobdLsZwQEwgVqfYpYL8B8eIsLkaaypFUs3BqBje5PYMG
         CcoFPB2BXuO6trmeGZPMi2ncAVoLq8nhoynU2bTnUSKiIbP+7liw4SOFGLE7wWbbxFPz
         UU+SqOFpKgdjYHdoMsT4PMGpDd9Jg3RlR6HJA3EkvyjULYt3KBrvB8xLGyHiFXh/LKCW
         a2lyHDspMBlEx4PaBHqO8xGFZvvxQt0Aw8UQQPsOs8J07xIuiJBOuk42LOB0fp+EGQso
         myng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709117246; x=1709722046;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wfRgdwzRN8mqJPSb0k4wCFiTLF5dChF82GwwW7l41yg=;
        b=NsdSAknxk1YGUXmfeImhw62DUb1Cgxk2NrhluKNBhUTF2ij+1ps6jdH0T9fGg9BW0H
         f5Cn9/m4c6YS0OGzbU2wdgox0jKJeIolUVosRGFm43NFS+/3hjK2LQ0zSb8j6p7V3drb
         Bu5yUtXSQAyHscrbxXrJqhs0lsQsWpEBn/xMYPY2cfmJERhUFdNc+aGrEEvONNMhqHtN
         EkxTpw92ORYDB3V8sOGdwsyfzobjLL6ViZtPw2NJCUXfEQWDm4td3KSd1/Vzj1styqlG
         itJEDrP3rF+4TD5yPIHcY65PbwGHnapUlIsQJ1AR6ahBPkJDCLKupgAZoVWOgSbmCq/q
         xu9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkpY8kk7dBqDGkPtnu0Vut2Oxg+EFmVoAC5l/EaQl2j7ASbQ/TYTlRBp5pYtrFArsj7yrpT1fVYY8cnhIC4jghyA6djvp+
X-Gm-Message-State: AOJu0YxwdC43PO/Ka4wllgFjhkHfHUXdih8lS9EMqustFy8RZwTnqvxF
	qQSgIMztzPorM/7TYRrstymU1bkrUoHgrRBp5Iq+erxsjcFiE2jxjW4xd8Dzjko=
X-Google-Smtp-Source: AGHT+IEy97/CGn9v9VzsDZdagJYqhpkYUS09Nc5/GsIGTxPAbM5/OEzCo2i0JMjsBhnS/6+ZX8dcSw==
X-Received: by 2002:a05:6512:11c9:b0:512:fabd:8075 with SMTP id h9-20020a05651211c900b00512fabd8075mr5191179lfr.48.1709117246014;
        Wed, 28 Feb 2024 02:47:26 -0800 (PST)
Received: from wkz-x13 (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id h4-20020a0565123c8400b005131f3fc893sm15009lfv.214.2024.02.28.02.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 02:47:25 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Paolo Abeni <pabeni@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com,
 razor@blackwall.org, bridge@lists.linux.dev, netdev@vger.kernel.org,
 jiri@resnulli.us, ivecera@redhat.com, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next 4/4] net: switchdev: Add tracepoints
In-Reply-To: <4838ad92a359a10944487bbcb74690a51dd0a2f8.camel@redhat.com>
References: <20240223114453.335809-1-tobias@waldekranz.com>
 <20240223114453.335809-5-tobias@waldekranz.com>
 <20240223103815.35fdf430@gandalf.local.home>
 <4838ad92a359a10944487bbcb74690a51dd0a2f8.camel@redhat.com>
Date: Wed, 28 Feb 2024 11:47:24 +0100
Message-ID: <87a5nkhnlv.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On tis, feb 27, 2024 at 11:04, Paolo Abeni <pabeni@redhat.com> wrote:
> On Fri, 2024-02-23 at 10:38 -0500, Steven Rostedt wrote:
>> On Fri, 23 Feb 2024 12:44:53 +0100
>> Tobias Waldekranz <tobias@waldekranz.com> wrote:
>> 
>> > Add a basic set of tracepoints:
>> > 
>> > - switchdev_defer: Fires whenever an operation is enqueued to the
>> >   switchdev workqueue for deferred delivery.
>> > 
>> > - switchdev_call_{atomic,blocking}: Fires whenever a notification is
>> >   sent to the corresponding switchdev notifier chain.
>> > 
>> > - switchdev_call_replay: Fires whenever a notification is sent to a
>> >   specific driver's notifier block, in response to a replay request.
>> > 
>> > Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> > ---
>> >  include/trace/events/switchdev.h | 74 ++++++++++++++++++++++++++++++++
>> >  net/switchdev/switchdev.c        | 71 +++++++++++++++++++++++++-----
>> >  2 files changed, 135 insertions(+), 10 deletions(-)
>> >  create mode 100644 include/trace/events/switchdev.h
>> > 
>> > diff --git a/include/trace/events/switchdev.h b/include/trace/events/switchdev.h
>> > new file mode 100644
>> > index 000000000000..dcaf6870d017
>> > --- /dev/null
>> > +++ b/include/trace/events/switchdev.h
>> > @@ -0,0 +1,74 @@
>> > +/* SPDX-License-Identifier: GPL-2.0 */
>> > +#undef TRACE_SYSTEM
>> > +#define TRACE_SYSTEM	switchdev
>> > +
>> > +#if !defined(_TRACE_SWITCHDEV_H) || defined(TRACE_HEADER_MULTI_READ)
>> > +#define _TRACE_SWITCHDEV_H
>> > +
>> > +#include <linux/tracepoint.h>
>> > +#include <net/switchdev.h>
>> > +
>> > +#define SWITCHDEV_TRACE_MSG_MAX 128
>> 
>> 128 bytes is awfully big to waste on the ring buffer. What's the average
>> size of a string?
>> 
>> > +
>> > +DECLARE_EVENT_CLASS(switchdev_call,
>> > +	TP_PROTO(unsigned long val,
>> > +		 const struct switchdev_notifier_info *info,
>> > +		 int err),
>> > +
>> > +	TP_ARGS(val, info, err),
>> > +
>> > +	TP_STRUCT__entry(
>> > +		__field(unsigned long, val)
>> > +		__string(dev, info->dev ? netdev_name(info->dev) : "(null)")
>> > +		__field(const struct switchdev_notifier_info *, info)
>> > +		__field(int, err)
>> > +		__array(char, msg, SWITCHDEV_TRACE_MSG_MAX)
>> > +	),
>> > +
>> > +	TP_fast_assign(
>> > +		__entry->val = val;
>> > +		__assign_str(dev, info->dev ? netdev_name(info->dev) : "(null)");
>> > +		__entry->info = info;
>> > +		__entry->err = err;
>> > +		switchdev_notifier_str(val, info, __entry->msg, SWITCHDEV_TRACE_MSG_MAX);
>> 
>> Is it possible to just store the information in the trace event and then
>> call the above function in the read stage?
>
> I agree with Steven: it looks like that with the above code the
> tracepoint itself will become measurably costily in terms of CPU
> cycles: we want to avoid that.
>
> Perhaps using different tracepoints with different notifier_block type
> would help? so that each trace point could just copy a few specific
> fields.

This can be done, but you will end up having to duplicate the decoding
and formatting logic from switchdev-str.c, with the additional hurdle of
having to figure out the sizes of all referenced objects in order to
create flattened versions of every notification type.

What I like about the current approach is that when new notification and
object types are added, switchdev_notifier_str will automatically be
able to decode them and give you some rough idea of what is going on,
even if no new message specific decoding logic is added. It is also
reusable by drivers that might want to decode notifications or objects
in error messages.

Would some variant of (how I understand) Steven's suggestion to instead
store the formatted message in a dynamic array (__assign_str()), rather
than in the tracepoint entry, be acceptable?

