Return-Path: <netdev+bounces-245563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFE2CD2135
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 23:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB6B03024124
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 22:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A5023278D;
	Fri, 19 Dec 2025 22:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2tYGyiS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A891C8626
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 22:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766181829; cv=none; b=LFG6dDMUAE4TWL30/qTUb2VhF6jOUsi1etWGHVeVFxD7tGyNfDIrHmrnzNUx4NdOmnbQNA3/0vbfhKoaxIDe5l6upkSLnOawmUhbF8JzG+b5lwtHAn/ujTww8x7KIILmlOfJItSmUgxlzd6UdtESRdb85/J4EzFzYxYD9LZ0BKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766181829; c=relaxed/simple;
	bh=K65eQvVjrtr+R/qeNuGKbX+IGHno8mYV8ytfYwaYLXo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XLMw6AYHOaBiThDKs2s+kVG4okYHQKCQhUy9kQdCTA57yGLFVH8iYSkRXdJbLxz8KCdvv93JpEoeBiaQ8e6jkZcOG/HdzM/UCAIWzg8yXx9xl+3EasRZvyHT2PJ7sMW+Dh7T8Dpuskzpj+OXqzTkrzzTp6+2wpaJB2GehYAu4Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2tYGyiS; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-64661975669so2304806d50.3
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 14:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766181827; x=1766786627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lj1SJyG/89F30p8mVkC7c1DiowXQMB0L5Q80WibFOIY=;
        b=J2tYGyiSyRNxEKgKYZc02XzeBUIGeXpkUDQasR10yhZFRB6PvS5H79cRpG5yWsIY5T
         eTiRR+zV/+ey3o4/tGFknhUrk6jPP5cSPCzyAwqZX8uCpVurmxeuPxHjlHZ3VY1QT4U6
         e0FtizqbmcyFCCpRyo/rvNTgFtLciP65Y6ignI+NlpW01TXBwNIyF7p34rWv+A6U0rKe
         R6xs6f/PFsaSYfZciL81WNwXCqsQia+wc+IMJ0yW69w5bvQbFtLw+nHyh04KrmGKeKeg
         duF+DNrv9xtmI4kxr58vvPqg7w70PofFHnsYEAPbXQCB2tibSkXDBxeS8ICTFYzF4Tws
         GgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766181827; x=1766786627;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lj1SJyG/89F30p8mVkC7c1DiowXQMB0L5Q80WibFOIY=;
        b=I3uqiweWf+tTehs2JdG5J9XO4pQlNFmMRerppn0bYcLkQTOEPTq/RVDuBhoGGh7VgX
         vXnbBki04JfXeqZ2kgI2bMRjfJKsb7o/aMPLfAl73HnygN688PWZqDmehFA/k3w8gGhM
         ujd1QZYoEmvKRG3emKACPj+BR/IU2YKy6lIOiwiqC8aFUlEFZF7OhBwgsc+GX+IgNwVO
         VXqVyCSqa3DPzBmKnR07HgSNONJ1bcSKALU3p9ZNLXJe8O/hNrEzKTt0bqqIQQhN+PUD
         Zrd/QV+V7YGd/laWmIgImZeLR1h3t7+a/hz1jbjbYpsisyPKu8GYbnDEUA8CGM4bpjlB
         WtGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB9yLVJ/w7G8nvPea9lJYw4OrWk38WkgJYZxJRPCnmWiG8WDcw/mmtyRJAsVqDWvnSYKMFvUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxaSss7+gYW4eMbcHt5Hlg7nIJ3mHtd4ZHIBUBBL3ALIVkXQ9w
	4uHU75Td0LFeY5EAWWFIZ5hgId7FLCXqJqi/c3ckIlnisJJbLiSYbA/b
X-Gm-Gg: AY/fxX7GjlpdeHjfb4LijlhPEh7sZYRfOPyN0d/hnlBe0RJZ/qcjo6vtYB1D5xXy65M
	LhZWmm6rdP8IxOqD8SAwRR69wTT7nXtQf1JLh6VvpqATmNid6JDIWblNiuygUumHPBUpoYuTvNx
	j2brmxdQN7AksEifL4SL9SPeAHTQzrj01TgkwA37wm38id6Fqhgs3l2mTHfmGad46og+AkmzXB1
	ibKKQCbKe3NbMnM0nEizDRpVmaiVIKKif6C2eysRRVd5EPsQqaN2PRUYgffwfSTJJaWUxwNQ33S
	RMdnrMqs5NvFCSbD/kI1TvrohxUvHdQu2RAc23w7jTzliKDi3s2xDLvE88ViPVl9ftvCo6aHHVE
	m5qpw1hmLVqQ+QcZavlb+Iro1uYcFvrYPE/dMLpLHSICJpN8A4djKVkaUTIsdBquCQ6Mq4EYjE9
	Kzo2zz7WuvlEcU+sX4C6//hw/I3QA/bXgbk9o6CRvitwqww2RBdoUli5aeLEq4vMSfocNN9jwgn
	0Uq/w==
X-Google-Smtp-Source: AGHT+IEVGU00vwSi7v6iKm43/byfAJ7Qsim+j5WMdfV7lUcLiMPf+iJ/uOJzkmL8KzeK7aJGdiwuFg==
X-Received: by 2002:a05:690e:11c2:b0:63f:beb2:9519 with SMTP id 956f58d0204a3-6466a87edf4mr3514400d50.5.1766181826945;
        Fri, 19 Dec 2025 14:03:46 -0800 (PST)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6466a8bd4c3sm1720410d50.8.2025.12.19.14.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 14:03:46 -0800 (PST)
Date: Fri, 19 Dec 2025 17:03:45 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev <netdev@vger.kernel.org>
Cc: io-uring <io-uring@vger.kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Julian Orth <ju.orth@gmail.com>
Message-ID: <willemdebruijn.kernel.24d8030f7a3de@gmail.com>
In-Reply-To: <460fe33a-bf6d-4966-be04-abb6d89b9f9e@kernel.dk>
References: <07adc0c2-2c3b-4d08-8af1-1c466a40b6a8@kernel.dk>
 <willemdebruijn.kernel.18e89ba05fbac@gmail.com>
 <fe9dbb70-c345-41b2-96d6-2788e2510886@kernel.dk>
 <willemdebruijn.kernel.1996d0172c2e@gmail.com>
 <460fe33a-bf6d-4966-be04-abb6d89b9f9e@kernel.dk>
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

Jens Axboe wrote:
> On 12/19/25 1:08 PM, Willem de Bruijn wrote:
> > [PATCH net v2] assuming this is intended to go through the net tree.
> 
> Assuming this will hit -rc3 then, as netdev PRs usually go out on
> thursdays?
> 
> > Jens Axboe wrote:
> >> On 12/19/25 12:02 PM, Willem de Bruijn wrote:
> >>> Jens Axboe wrote:
> >>>> A previous commit added SO_INQ support for AF_UNIX (SOCK_STREAM), but it
> >>>> posts a SCM_INQ cmsg even if just msg->msg_get_inq is set. This is
> >>>> incorrect, as ->msg_get_inq is just the caller asking for the remainder
> >>>> to be passed back in msg->msg_inq, it has nothing to do with cmsg. The
> >>>> original commit states that this is done to make sockets
> >>>> io_uring-friendly", but it's actually incorrect as io_uring doesn't use
> >>>> cmsg headers internally at all, and it's actively wrong as this means
> >>>> that cmsg's are always posted if someone does recvmsg via io_uring.
> >>>>
> >>>> Fix that up by only posting a cmsg if u->recvmsg_inq is set.
> >>>>
> >>>> Additionally, mirror how TCP handles inquiry handling in that it should
> >>>> only be done for a successful return. This makes the logic for the two
> >>>> identical.
> >>>>
> >>>> Cc: stable@vger.kernel.org
> >>>> Fixes: df30285b3670 ("af_unix: Introduce SO_INQ.")
> >>>> Reported-by: Julian Orth <ju.orth@gmail.com>
> >>>> Link: https://github.com/axboe/liburing/issues/1509
> >>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >>>>
> >>>> ---
> >>>>
> >>>> V2:
> >>>> - Unify logic with tcp
> >>>> - Squash the two patches into one
> >>>>
> >>>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> >>>> index 55cdebfa0da0..a7ca74653d94 100644
> >>>> --- a/net/unix/af_unix.c
> >>>> +++ b/net/unix/af_unix.c
> >>>> @@ -2904,6 +2904,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
> >>>>  	unsigned int last_len;
> >>>>  	struct unix_sock *u;
> >>>>  	int copied = 0;
> >>>> +	bool do_cmsg;
> >>>>  	int err = 0;
> >>>>  	long timeo;
> >>>>  	int target;
> >>>> @@ -2929,6 +2930,9 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
> >>>>  
> >>>>  	u = unix_sk(sk);
> >>>>  
> >>>> +	do_cmsg = READ_ONCE(u->recvmsg_inq);
> >>>> +	if (do_cmsg)
> >>>> +		msg->msg_get_inq = 1;
> >>>
> >>> I would avoid overwriting user written fields if it's easy to do so.
> >>>
> >>> In this case it probably is harmless. But we've learned the hard way
> >>> that applications can even get confused by recvmsg setting msg_flags.
> >>> I've seen multiple reports of applications failing to scrub that field
> >>> inbetween calls.
> >>>
> >>> Also just more similar to tcp:
> >>>
> >>>        do_cmsg = READ_ONCE(u->recvmsg_inq);
> >>>        if ((do_cmsg || msg->msg_get_inq) && (copied ?: err) >= 0) {
> >>
> >> I think you need to look closer, because this is actually what the tcp
> >> path does:
> >>
> >> if (tp->recvmsg_inq) {
> >> 	[...]
> >> 	msg->msg_get_inq = 1;
> >> }
> > 
> > I indeed missed that TCP does the same. Ack. Indeed consistency was
> > what I asked for.
> 
> FWIW, I don't disagree with you, but sorting that out should then be a
> followup patch that would then touch both tcp and streams.

Agreed. That's more for net-next. I'll take a look.
 
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> 
> Thanks!
> 
> -- 
> Jens Axboe



