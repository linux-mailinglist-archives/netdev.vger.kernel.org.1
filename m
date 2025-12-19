Return-Path: <netdev+bounces-245557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5D7CD1B60
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 21:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFF18304C299
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 20:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C04B2F90D8;
	Fri, 19 Dec 2025 20:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4SQs7Mt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2BA25B311
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 20:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766174919; cv=none; b=uFuccgVPxSTHxpceRVwwq4t4vwMzPvuLpTtXi9E+JYfSogyrWV1uWHhEmhPpzAi+i/HR3qECo60vl6jacXwPNZSnlchzlwzzNiPS0BuW9v65ox2u0aMRsFpiqSn6Md76SP5BQedbHJu8J5LVBH2wzP/d3yBtYMJkQcW5UKFdZgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766174919; c=relaxed/simple;
	bh=9x+BHlzCfrgk0ymGZgsiAnhK5TdheEWOye7/NjzDeoA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=A2z245b+ED2VzriZvaE0N5j3q6HufGbPOtlP//G5nC2sJ7VvHBzbF5eHQ3yMvTH9YgWSFsEpTj9oOsixC40BCuW09nLYNudtz3ryX4K/ASvqgkLzvgmQmK2LkbPUjoTMfuTCqBr4r+5J4nDVFQDUdRaGMMqkKYb28EUoDXwHsLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4SQs7Mt; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-78ab03c30ceso18069507b3.2
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 12:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766174916; x=1766779716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NXok9jk5x7VmYco9DIHQuFt8uZYNOxCwYoWX4lUVJQ=;
        b=b4SQs7MtSgO+cGuRZYe2xUJ4aF3DyXYNQLA39me/a2NKQLfG6N53K7KgBj0vu09twL
         d1KzQ7WVuG7toF8ncPK21wStmpOdqMAQXSh8wYgT6p+W3V4r2fPEImj1WRInvgh+QtEu
         UMxX2TqaMU/ua+LXThL4OuRA8lODJhPP47TwqWLgGYojwNc+y0rSy1UEr3HhCpxI4Yf1
         hlwoW+tGt6ZE/umGWzOlkO3iHbIV+I/0swWBi1fFMRscbY4cBJ1ySZDQoF7PorIOCJ9P
         j/SrN3JgP3pj6/zxjadMYxOf3gx1Wsaf5pd4r/AgDHoSQqnHCpP3M7ZWItiukijhf5uy
         SOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766174916; x=1766779716;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8NXok9jk5x7VmYco9DIHQuFt8uZYNOxCwYoWX4lUVJQ=;
        b=rc3VzfKysI0W0QFP/hw8/tRKSpRJx+AGRchn9TR2AHwvvOeUWfYMW7TnTrpO37dDMb
         pDlNAZVQJYiGanLwz7SbbOKNaSFgdE0BLHveUlHtFXgf0PqNEYmydDWTGJZyp+5Q69BA
         SDWoxVhwJJIpG/8RVuMQ/IQ3XBpocx1GP78EGOPjcKweOxJiL1EWg4v5C0MewjXaYOBx
         4Kq56H9LPKpFLgrbGdFq6ykywxl8q1S53eD+2VqHDl0fZkBOWDJyrh/A32LiGRezkKMr
         KjU/1I1wiBORwSt3YhLo82XrsQm8H22yZ5SbB35YCvXDJF1n5QQ7kQK8CVRMJyKTzZ/P
         qfrg==
X-Forwarded-Encrypted: i=1; AJvYcCUZtcgTHfgesxHkFG2FLxUIImhY7DAzu8bMG2IGLQVKjCw1JYpcRFQP1eTDFMwgGr5q/mecQvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFoa2pX54oxNQtLAxirWi2BZg9t5lKcr3sHQQau6xw5whTcXwV
	TFzJBXpmuH4iZJ2xYlda7MqXXpcIdCKyjslbKuqG3+mzdbCz7tOUagBX
X-Gm-Gg: AY/fxX5XBnCmb7opO0P26FnQSNUUyKPwkzJzhdz5laDXlaj2kaVBygdWUn7SapiC6ww
	HAtkszitbEfogM6Iode2cdjpNPwf8G+AS1r7HIrzifp42HQnvG4HWEeEVfsMMka/S4GGMdRHTsi
	hoN21HQwlo4DgO1LItHlnXab7Va78+1zLqwTrnVCCRkekVHDJTIPuO4BWhye7MU4sFdurOq/Ynx
	nWh2goAKyV9mEmVWVAfl6zcl9dInMPuTypnvHuCgTNTeC1jXb3SBN/YoZBTCpW2MnZNkDidc/3P
	7FH8NdgYJdQk8WF9T13SKMWuNQyWdudKgFiBXeXOy0SZE/aJXL/L3DYs1vivWoUGA/s8OR3eYU9
	cqCi7iIUtIew+Y+6TtISui2j2NTJjaAe5NDOQhJ6f4ucpiSSfUlqhESOTqkxLk+sOCS5Cbq+E2L
	G1BQrEUOAQ/yJrzIXZp9tnJxKOkyusU017rPceyN2JErZABDbPb8lUxZkv1LEbUu4KcBg=
X-Google-Smtp-Source: AGHT+IGPxz2c90v44nANJeVP7jDFN4UesF5ByFOceRM4axC63q7joyXty5wkuyVvH+UqFdw2cEKZQA==
X-Received: by 2002:a53:b68e:0:b0:644:402a:8d3b with SMTP id 956f58d0204a3-6466a844401mr2603664d50.10.1766174916234;
        Fri, 19 Dec 2025 12:08:36 -0800 (PST)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78fb44f9a42sm13230867b3.29.2025.12.19.12.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 12:08:35 -0800 (PST)
Date: Fri, 19 Dec 2025 15:08:35 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev <netdev@vger.kernel.org>
Cc: io-uring <io-uring@vger.kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Julian Orth <ju.orth@gmail.com>
Message-ID: <willemdebruijn.kernel.1996d0172c2e@gmail.com>
In-Reply-To: <fe9dbb70-c345-41b2-96d6-2788e2510886@kernel.dk>
References: <07adc0c2-2c3b-4d08-8af1-1c466a40b6a8@kernel.dk>
 <willemdebruijn.kernel.18e89ba05fbac@gmail.com>
 <fe9dbb70-c345-41b2-96d6-2788e2510886@kernel.dk>
Subject: Re: [PATCH v2] af_unix: don't post cmsg for SO_INQ unless explicitly
 asked for
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

[PATCH net v2] assuming this is intended to go through the net tree.

Jens Axboe wrote:
> On 12/19/25 12:02 PM, Willem de Bruijn wrote:
> > Jens Axboe wrote:
> >> A previous commit added SO_INQ support for AF_UNIX (SOCK_STREAM), but it
> >> posts a SCM_INQ cmsg even if just msg->msg_get_inq is set. This is
> >> incorrect, as ->msg_get_inq is just the caller asking for the remainder
> >> to be passed back in msg->msg_inq, it has nothing to do with cmsg. The
> >> original commit states that this is done to make sockets
> >> io_uring-friendly", but it's actually incorrect as io_uring doesn't use
> >> cmsg headers internally at all, and it's actively wrong as this means
> >> that cmsg's are always posted if someone does recvmsg via io_uring.
> >>
> >> Fix that up by only posting a cmsg if u->recvmsg_inq is set.
> >>
> >> Additionally, mirror how TCP handles inquiry handling in that it should
> >> only be done for a successful return. This makes the logic for the two
> >> identical.
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: df30285b3670 ("af_unix: Introduce SO_INQ.")
> >> Reported-by: Julian Orth <ju.orth@gmail.com>
> >> Link: https://github.com/axboe/liburing/issues/1509
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >>
> >> ---
> >>
> >> V2:
> >> - Unify logic with tcp
> >> - Squash the two patches into one
> >>
> >> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> >> index 55cdebfa0da0..a7ca74653d94 100644
> >> --- a/net/unix/af_unix.c
> >> +++ b/net/unix/af_unix.c
> >> @@ -2904,6 +2904,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
> >>  	unsigned int last_len;
> >>  	struct unix_sock *u;
> >>  	int copied = 0;
> >> +	bool do_cmsg;
> >>  	int err = 0;
> >>  	long timeo;
> >>  	int target;
> >> @@ -2929,6 +2930,9 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
> >>  
> >>  	u = unix_sk(sk);
> >>  
> >> +	do_cmsg = READ_ONCE(u->recvmsg_inq);
> >> +	if (do_cmsg)
> >> +		msg->msg_get_inq = 1;
> > 
> > I would avoid overwriting user written fields if it's easy to do so.
> > 
> > In this case it probably is harmless. But we've learned the hard way
> > that applications can even get confused by recvmsg setting msg_flags.
> > I've seen multiple reports of applications failing to scrub that field
> > inbetween calls.
> > 
> > Also just more similar to tcp:
> > 
> >        do_cmsg = READ_ONCE(u->recvmsg_inq);
> >        if ((do_cmsg || msg->msg_get_inq) && (copied ?: err) >= 0) {
> 
> I think you need to look closer, because this is actually what the tcp
> path does:
> 
> if (tp->recvmsg_inq) {
> 	[...]
> 	msg->msg_get_inq = 1;
> }

I indeed missed that TCP does the same. Ack. Indeed consistency was what I asked for.

Reviewed-by: Willem de Bruijn <willemb@google.com>

> 
> to avoid needing to check two things at the bottom. Which is actually
> why I did this for streams too, as the whole point was to unify the two
> and make them look the same.
> 
> Like I said, I'm happy to give you guys what you want, but you can't
> both ask for consistency and then want it different too. I just want the
> bug fixed and out of my hair and into a stable release, as it's causing
> regressions.
> 
> Let me know, and I'll send out a v3 if needed. But then let's please
> have that be it and move on.
> 
> -- 
> Jens Axboe



