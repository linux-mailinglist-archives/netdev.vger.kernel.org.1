Return-Path: <netdev+bounces-78104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 097278740F8
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 21:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8871C2189E
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 20:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6602140E38;
	Wed,  6 Mar 2024 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="poo9N2WI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D169813E7E9
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 20:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755332; cv=none; b=a4Ptv4XTocvZU7/8nkDilyjtyM3niar4+tQi+d11M3SIkLKNIzJIJB4BH1xlwXLc2HXGFkHYNPTAnaZneF3H1xz8HVjxketLd4tNWly8dCmh2F/GAg+LNohFoeWRagNizUZhpz/fzzUej/2oQW/xj+3J1KQ22w0QdMW42d+z574=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755332; c=relaxed/simple;
	bh=j+Z8eV2Ad17vD9BNn3ZEokhmshK7uIW9xSUxhkncv6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Am+uiFAprbdOFhEeAv9tlrqAr1AB3Cy0WPrQmLdbpIipqyCLv+ws1fzTvIhZ/8C1/F0H6EKxXA4/U3QU8VMpXBhhwWl9U6IgyAyJt8hPrKNp3uGR0gAUTVXEhAm0v/rBckd9M1Wzc1z/Hss6nT1QBe2cbZAmGlu4Ffg+jdKR0zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=poo9N2WI; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5131316693cso124570e87.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 12:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1709755329; x=1710360129; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YaXY6Xh9pDzPIu4VWiSWL9VM8zgGbBQy5cbJZfmP2hk=;
        b=poo9N2WIkSqOS689oVLx7DEOo/cqNvqoE7ot0YdFvEnp0s2lJ3TK/qPUXC+5VfCBan
         H2VFIMrvRmEnVpzCuWcJG0+DZ4shC58Z6E7dVOJmSzdzuaocDDlO6iPJS3ML4sn8xdPr
         6hMdBypfBwyIDGRetzqVxc7rgSGOHeXUkGRubX8HTZDUytAU0ZvjMJ+Z40aQzrzMX+11
         drZ84IREal7uaJV4wUL6GuwAAsGN1hQV2HB1M9Y3gjrejRjgabobukW86yMjkr53pKnz
         /ngI9SrGzXYYzvNJS0lQDZLOKLhT9955E1tuDt7Do0jUiKG1O3Yy2wWamIrtk5lAnDH7
         pxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709755329; x=1710360129;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YaXY6Xh9pDzPIu4VWiSWL9VM8zgGbBQy5cbJZfmP2hk=;
        b=dFnive2MXsb8hK3etQcF8UG04u5qXtkQWLqFBbQSSWyfefGuAY7QcfUk6Ds1xkQQL4
         m3oYRn/QJtIzK49ly+RbbugD/HvUMrhxaeREEwMLVKAiBAh0FPAL/fO20ARppJGDc+Cu
         pniS5SGT5o/v7eBeITUCUHteGWiwEuhx5rK/lBf79uvyBXjPSBwh47e3UyQZvg7nbljG
         EeHSpNvECvKa4aB/ir0MuuQ7oHSHec2J1ipYwynssyrK2kreZOOOHbQ5Fzt8qpJ+hx3p
         pmLXV13ufSCMVfTdSrKGioE8O+hMn8qW1TwA84f5IYCrHEMef6UwkK6mds/LkBj1YBMb
         Ll3A==
X-Forwarded-Encrypted: i=1; AJvYcCXH71m+jhdS4fTdmndhW5Dbv8m7iN7M5naPFpx90KmV+2giCT5Pzbw/4ZRYe7y3nS3DVzxRYaJxKCcp6PzoZCE7X8foMKjG
X-Gm-Message-State: AOJu0YxEXFHnT2UXvT94JdksSQS08zeESSeNCWs+mOeSA9w2DC98EnpI
	rveXutMpDdLNllFBn5603j2TFTXseWIUquxhESUyN1n82V+OKCli031aTvaqtOM=
X-Google-Smtp-Source: AGHT+IHoRs6YNdDZM2DtOtbQ5KJZaDe+eAr2vwjc4MVHxDWNhaSnPPnr3Xw6VshITVo4qSpAtd4PMg==
X-Received: by 2002:a05:6512:4db:b0:513:597a:c60d with SMTP id w27-20020a05651204db00b00513597ac60dmr111280lfq.22.1709755328635;
        Wed, 06 Mar 2024 12:02:08 -0800 (PST)
Received: from wkz-x13 (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id a19-20020ac25e73000000b005131914f680sm2726264lfr.189.2024.03.06.12.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 12:02:07 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, kuba@kernel.org,
 roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, jiri@resnulli.us, ivecera@redhat.com,
 mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next 4/4] net: switchdev: Add tracepoints
In-Reply-To: <20240306101557.2c56fbc6@gandalf.local.home>
References: <20240223114453.335809-1-tobias@waldekranz.com>
 <20240223114453.335809-5-tobias@waldekranz.com>
 <20240223103815.35fdf430@gandalf.local.home>
 <4838ad92a359a10944487bbcb74690a51dd0a2f8.camel@redhat.com>
 <87a5nkhnlv.fsf@waldekranz.com>
 <20240228095648.646a6f1a@gandalf.local.home>
 <877cihhb7y.fsf@waldekranz.com>
 <20240306101557.2c56fbc6@gandalf.local.home>
Date: Wed, 06 Mar 2024 21:02:06 +0100
Message-ID: <874jdjgmdd.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On ons, mar 06, 2024 at 10:15, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 04 Mar 2024 23:40:49 +0100
> Tobias Waldekranz <tobias@waldekranz.com> wrote:
>
>> On ons, feb 28, 2024 at 09:56, Steven Rostedt <rostedt@goodmis.org> wrote:
>> > On Wed, 28 Feb 2024 11:47:24 +0100
>> > Tobias Waldekranz <tobias@waldekranz.com> wrote:
>> >  
>> > The "trace_seq p" is a pointer to trace_seq descriptor that can build
>> > strings, and then you can use it to print a custom string in the trace
>> > output.  
>> 
>> Yes I managed to decode the hidden variable :) I also found
>> trace_seq_acquire() (and its macro alter ego __get_buf()), which would
>> let me keep the generic stringer functions. So far, so good.
>> 
>> I think the foundational problem remains though: TP_printk() is not
>> executed until a user reads from the trace_pipe; at which point the
>> object referenced by __entry->info may already be dead and
>> buried. Right?
>
> Correct. You would need to load all the information into the event data
> itself, at the time of the event is triggered, that is needed to determine
> how to display it.

Given that that is quite gnarly to do for the events I'm trying to
trace, because of the complex object graph, would it be acceptable to
format the message in the assign phase and store it as dynamic data?
I.e., what (I think) you suggested at the end of your first response.

My thinking is:

- Managing a duplicate (flattened) object graph, exclusively for use by
  these tracepoints, increases the effort to keep the tracing in sync
  with new additions to switchdev; which I think will result in
  developers simply avoiding it altogether. In other words: I'd rather
  have somewhat inefficient but simple flashlight, rather than a very
  efficient one that no one knows how to change the batteries in.

- This is typically not a very hot path. Most events are triggered by
  user configuration. Otherwise when new neighbors are discovered.

- __entry->info is still there for use by raw tracepoint consumers from
  userspace.


