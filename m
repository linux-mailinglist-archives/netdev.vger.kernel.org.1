Return-Path: <netdev+bounces-157273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E61ACA09D82
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 22:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44FA6188C157
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 21:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA09217705;
	Fri, 10 Jan 2025 21:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="PmD7ah6F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A86A21660F
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 21:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736546324; cv=none; b=LOz728BZWtc3V2yr/c0bCbttUDg9xuV3pSfEblzEO/+JExRYGoBsWrMshzETIJptVcFXOBq1OmFoWUx6ogSPie+l/BfI54W+quaFwOomS9jSYVxPRlFXMP4lCMF+8TniR+dq7/p+bc+o/J7515MoyC9e85+q0zUcZL610UjmHek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736546324; c=relaxed/simple;
	bh=gidcXNRWODZSclZ6gExmJdjh96byK2BBN3EVOZ/6kWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o11586VYERtlPlHM9i5Rj4I9USSmFhxLhEPbomjSrpyy6AHhvV2T/VsAsrQOo3hBic+TMMBp/ZdstPcXRdboJVJNHa1x1IEHtkwbA7+x84JtkA/zOk2QOVliKIGzQbLZWigYq+jWheBV2lJ2YO33QSow9Musn/P4ZaKWNWVxLQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=PmD7ah6F; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2166022c5caso40470685ad.2
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 13:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736546322; x=1737151122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KO+xr8O78bF6e7ZQiI9tC9ZI3gh048JQcb52yh+IL5E=;
        b=PmD7ah6FlCcPbX8TfnZ859gBvq2L741eLL0YgcS99GFvjk60SvMBKLuB4RbQq+N+4z
         Bb2Nu6FGV8w329r949x5xCNGQ+XfHWzfeVBQXBN7r93u31BRdSJpYKLbODeu3FyyRxOo
         Z4pux30cex19KKC03y+1TuW9oMVaSXqE37btA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736546322; x=1737151122;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KO+xr8O78bF6e7ZQiI9tC9ZI3gh048JQcb52yh+IL5E=;
        b=OefOyHQ4Rsn2ymO228dx2KtWBiI/nFztj2IDF3pFEkybDtENFfWr5GNxZgSuUUWq3v
         /F+INvSUd78LRZI5fOFwpo7YV8R5fzzpF9mHTUZmHDIkYgi0egB+NH6yqOgf0CJbCPwg
         M4+6mUmRYJlCmt092ETKUpfaKZoOXVgqCc2wwoOugxrp2JFauXwHjf4fbRSab5ETOX/+
         HtL7arsXV+IszQf2GrbLRAvSMGk4ibufzhTU5yYZViBPVnQFnX1ef6r62In+/UFXBv5o
         0AJQMzB3Gr27gBIWM5YBDtTVypdjRe8peq1sc4qBCELVJpZEihAKM7y/QrptkRZT8AQ0
         cl5g==
X-Forwarded-Encrypted: i=1; AJvYcCXPAQRKczovF5tvIjLz/M2sTKNoQYk+bzzwk+P/UwMG858AZT8LZTcuJ5WrA1YniXiBtobCdVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVJO2LNGo6HE4MfIMX1eTreZoDQiIhDdX5saBbp4DI7keD5jEZ
	DKgd8CNbHEALnJymP922tucpbjrYxLBWb5KdqIjQaxGy8hqeUXeFi9XKeNxv4nQ=
X-Gm-Gg: ASbGncti03JKqIWsLALv8q/y1auwJtjlxvSRAAVat81fEpDtQy32x3DPNMnobxLSZAS
	01mOSkEiuT6KvdSGvpKaSYRjzBs8uu9HLPoPygQq7sX2n5s1UxaiuxhI0k/pQ7ZVFUXYIrLI2gX
	SB923k/WgO7BEVp5DAFioK0F/zdona8ohZDDfcPgEuDGRoADtsPgtuo2oBcb18Koen7aOcf+7tp
	JA2O04ABOFc4wCnUvbZrPwZLXdaMJB5P7krMm5NZ/zyBH1VcLiR3ZJWIucvK8CFNIP+r+SmZb1E
	rXI3cX9XD0EdcT8lSAJnzVA=
X-Google-Smtp-Source: AGHT+IGxMvKrKa+SxhXLj6KHpff7N0G1qREUaVtLaXMX+1Emgcn3e+Cde9Y6hYFKoJL7Tu8kRG19IA==
X-Received: by 2002:a17:902:ec83:b0:215:7ce4:57bc with SMTP id d9443c01a7336-21a83f54a5cmr178494735ad.16.1736546322328;
        Fri, 10 Jan 2025 13:58:42 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f25a583sm17769505ad.244.2025.01.10.13.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 13:58:41 -0800 (PST)
Date: Fri, 10 Jan 2025 13:58:39 -0800
From: Joe Damato <jdamato@fastly.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: horms@kernel.org, davem@davemloft.net, donald.hunter@redhat.com,
	edumazet@google.com, kuba@kernel.org, kuni1840@gmail.com,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v1 net-next 06/12] af_unix: Reuse out_pipe label in
 unix_stream_sendmsg().
Message-ID: <Z4GYD_9dqOi7mXOj@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, horms@kernel.org,
	davem@davemloft.net, donald.hunter@redhat.com, edumazet@google.com,
	kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
	pabeni@redhat.com
References: <20250110114344.GA7706@kernel.org>
 <20250110152231.38703-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110152231.38703-1-kuniyu@amazon.com>

On Sat, Jan 11, 2025 at 12:22:31AM +0900, Kuniyuki Iwashima wrote:
> From: Simon Horman <horms@kernel.org>
> Date: Fri, 10 Jan 2025 11:43:44 +0000
> > On Fri, Jan 10, 2025 at 06:26:35PM +0900, Kuniyuki Iwashima wrote:
> > > This is a follow-up of commit d460b04bc452 ("af_unix: Clean up
> > > error paths in unix_stream_sendmsg().").
> > > 
> > > If we initialise skb with NULL in unix_stream_sendmsg(), we can
> > > reuse the existing out_pipe label for the SEND_SHUTDOWN check.
> > > 
> > > Let's rename do it and adjust the existing label as out_pipe_lock.
> > > 
> > > While at it, size and data_len are moved to the while loop scope.
> > > 
> > > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > ---
> > >  net/unix/af_unix.c | 23 +++++++++--------------
> > >  1 file changed, 9 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > > index b190ea8b8e9d..6505eeab9957 100644
> > > --- a/net/unix/af_unix.c
> > > +++ b/net/unix/af_unix.c
> > 
> > ...
> > 
> > > @@ -2285,16 +2283,12 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
> > >  		}
> > >  	}
> > >  
> > > -	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN) {
> > > -		if (!(msg->msg_flags & MSG_NOSIGNAL))
> > > -			send_sig(SIGPIPE, current, 0);
> > > -
> > > -		err = -EPIPE;
> > > -		goto out_err;
> > > -	}
> > > +	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
> > 
> > Hi Iwashima-san,
> > 
> > I think you need to set reason here.
> > 
> > Flagged by W=1 builds with clang-19.
> 
> Hi Simon,
> 
> I didn't set it here because skb == NULL and kfree_skb()
> doesn't touch reason, and KMSAN won't complain about uninit.
> 
> Should I use SKB_NOT_DROPPED_YET or drop patch 6 or leave
> it as is ?
> 
> What do you think ?

My vote is that SKB_NOT_DROPPED_YET is not appropriate here.

Maybe SKB_DROP_REASON_SOCKET_CLOSE since it is in SEND_SHUTDOWN
state?

