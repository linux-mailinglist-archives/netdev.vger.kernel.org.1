Return-Path: <netdev+bounces-245446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E6BCCDA83
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 22:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E53E30109A5
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 21:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4483C30AAC9;
	Thu, 18 Dec 2025 21:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrJDbduT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068AD2EAD1C
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 21:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766092518; cv=none; b=Wjk3aUanlG9GBGBKuUsXWy601L8skVjpoI+S4GnEXFegrtc5GMpa+Xucw1c+V928XDO2dEELXEI0vnz2UWGtdbkpkMDzscO8lLsulyPj6cNjyNZ9cOSsV/Jku7/6FnNC3gPesHwwUuHeAkO8Ty+9HOPQrhnpt40k51Eklsn+GyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766092518; c=relaxed/simple;
	bh=kDYBrODo75g8AhRSFpwd4cdqYkiEKhQgUsCdgrGWRTA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=OZX1CxMY/Ktt5zwtQwqdcI+pVTZggLPrw6/LNN1DKDcF3ejXkKsa1IwOoQgkKC6j0c1uJ9xEhu5GJUIPpV0xrvpdbV3dLIrA+tC9OzXBoU4oA2rjoemYp0I4gGxx8seiU5vKiRlp+R7X4IF1eQ5J305hO7tstGlwUT1c+XRu6ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrJDbduT; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-78c33d0df85so14566147b3.0
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 13:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766092510; x=1766697310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7EJNg3GNbNtFly+Dgb11Z3nvaLC93gGijDefaE9bOk=;
        b=BrJDbduTX2VuayZQDYyxkcPSSPoatdQznUi+FgfT56ngWtsP7UbWAJ98GVgd6c2BST
         HZQC0Mv99zVKNU0pkBo8BMjxOble/Klf8PVMbQ1NQ6kR/YVlP5VUKVueFRhEZgxsbOW2
         H8NjhW0vsx0ZJVxDcgdzVXmkSOe+56XfI6qcGVQATgEjl5noFc9aU1caIh/BKOCU5Mf9
         58qUEb/5pN5m7UOl2pKx0sX9WP2LzcetLxvS29F/4a0U3BOVnzuYj1BRVUNQaDRXRa4D
         gtMuzk6OSFyKtUNOU3RNmwzhExKREJO/oPacs3+k+mPGMmsbCwj1HRjLqyqYTKzImYfS
         FlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766092510; x=1766697310;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b7EJNg3GNbNtFly+Dgb11Z3nvaLC93gGijDefaE9bOk=;
        b=CY4gPdDDRAnul3kRTiCUE8U/jHc2QXAiP81HSoM6g845EivldKa8Ur8D4cvWic3dcj
         kOmdStUu4LJQesY49chgLbZTAKwCLM5XQVJAYfn/F+AbuihrYKPz4b9vYofZr8TeceWg
         J9q9bxB+1/zshD+t26M0n+xM/EqBCBumR1vbva51Mh+N6QlTYSVvCfO005RVnjSNvqd6
         TAGCz6ePf9f0DDPRxVWsob/ApdtZlTHezmH6mIyTa1JDqXXiXDmOTEMS4BY0A+j5b5cE
         WRzYgl5RGnJ1o5Uee4cxQR1hwMO1p/3noUKc8VjiRBIaKWj/NX8gh67/JYC2nukI4yWI
         yQuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7vXLTmwrw2JGjHW86b4WpmJyGWAvnIizhNuDZ+QqSSCochu7Ud5j1Q0OzOEnSj7AkT4Fa7NY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmLPUa4Rc9XKif0GjisvBTUPHSOXZva5zLm6hFGk17E0fgO1R4
	8D98Cc99ovdXa/BlOOVUmBSPGFx25XyVClLzIuvo8wBBGwlFXgk0tR86
X-Gm-Gg: AY/fxX7i3E57GHnANO+AlvctpJ3LsIPEO2WI0IkIqTOraRn8UMwk5FNjb51+lkeau7Q
	cFJw4EGEg79nxYfd573/nozxvAFNcmUOugKiXBH7n/dXghPrCwZjIIlEj+eNF8o4GEBMzPweB6P
	Su/xVKtOFXSBEI74tgboscRN04nWXn5rw4xWRzdYU/Lks3oV/K9vjwYzkAY/e0B5y8KkAYBsJg6
	7KS3Z7ey5HxE/JByGaS8LaFxrfoh5hs6zG8s2krDRBzW6/uLHteFbbowyLLmZBC+svONBUuKZNf
	11qWVacFOwgk916rwvXVC/x3FnE5UWeju8dSKOybj97n57pKvkWsCRqRiI5UkO0+EpYBFYrwiTO
	M2fuVkqOte6b7qh5QSSG3vH40QdBt8tH39lzvqnME5MsTOOIm14HOZ/BbzwyP0NmgW3l5gjH4Fh
	bsL09QE580d0ixacGySPqmT6o7tzkjRxD4Hs4vS3orG+8kcdZREo8NQOeyoRxHeFypcvo=
X-Google-Smtp-Source: AGHT+IG4ECQi8oDKhQxGm1qHPHPvrScfN7C5vMJkOguq9B4//xNoSJKvZk6KXg/e2kyUwtNjtUFDfA==
X-Received: by 2002:a05:690c:6288:b0:783:7867:eeb4 with SMTP id 00721157ae682-78fb4064e7cmr6281617b3.53.1766092510327;
        Thu, 18 Dec 2025 13:15:10 -0800 (PST)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78fb416b32csm2312937b3.0.2025.12.18.13.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 13:15:09 -0800 (PST)
Date: Thu, 18 Dec 2025 16:15:09 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: io-uring@vger.kernel.org, 
 kuba@kernel.org, 
 kuniyu@google.com, 
 willemb@google.com, 
 stable@vger.kernel.org, 
 Julian Orth <ju.orth@gmail.com>
Message-ID: <willemdebruijn.kernel.164466b751181@gmail.com>
In-Reply-To: <2ed38b2d-6f87-4878-b988-450cd95f8679@kernel.dk>
References: <20251218150114.250048-1-axboe@kernel.dk>
 <20251218150114.250048-2-axboe@kernel.dk>
 <willemdebruijn.kernel.2e22e5d8453bd@gmail.com>
 <2ed38b2d-6f87-4878-b988-450cd95f8679@kernel.dk>
Subject: Re: [PATCH 1/2] af_unix: don't post cmsg for SO_INQ unless explicitly
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
> On 12/18/25 1:35 PM, Willem de Bruijn wrote:
> > Jens Axboe wrote:
> >> A previous commit added SO_INQ support for AF_UNIX (SOCK_STREAM), but
> >> it posts a SCM_INQ cmsg even if just msg->msg_get_inq is set. This is
> >> incorrect, as ->msg_get_inq is just the caller asking for the remainder
> >> to be passed back in msg->msg_inq, it has nothing to do with cmsg. The
> >> original commit states that this is done to make sockets
> >> io_uring-friendly", but it's actually incorrect as io_uring doesn't
> >> use cmsg headers internally at all, and it's actively wrong as this
> >> means that cmsg's are always posted if someone does recvmsg via
> >> io_uring.
> >>
> >> Fix that up by only posting cmsg if u->recvmsg_inq is set.
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: df30285b3670 ("af_unix: Introduce SO_INQ.")
> >> Reported-by: Julian Orth <ju.orth@gmail.com>
> >> Link: https://github.com/axboe/liburing/issues/1509
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >> ---
> >>  net/unix/af_unix.c | 10 +++++++---
> >>  1 file changed, 7 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> >> index 55cdebfa0da0..110d716087b5 100644
> >> --- a/net/unix/af_unix.c
> >> +++ b/net/unix/af_unix.c
> >> @@ -3086,12 +3086,16 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
> >>  
> >>  	mutex_unlock(&u->iolock);
> >>  	if (msg) {
> >> +		bool do_cmsg;
> >> +
> >>  		scm_recv_unix(sock, msg, &scm, flags);
> >>  
> >> -		if (READ_ONCE(u->recvmsg_inq) || msg->msg_get_inq) {
> >> +		do_cmsg = READ_ONCE(u->recvmsg_inq);
> >> +		if (do_cmsg || msg->msg_get_inq) {
> >>  			msg->msg_inq = READ_ONCE(u->inq_len);
> >> -			put_cmsg(msg, SOL_SOCKET, SCM_INQ,
> >> -				 sizeof(msg->msg_inq), &msg->msg_inq);
> >> +			if (do_cmsg)
> >> +				put_cmsg(msg, SOL_SOCKET, SCM_INQ,
> >> +					 sizeof(msg->msg_inq), &msg->msg_inq);
> > 
> > Is it intentional that msg_inq is set also if msg_get_inq is not set,
> > but do_cmsg is?
> 
> It doesn't really matter, what matters is the actual cmsg posting be
> guarded. The msg_inq should only be used for a successful return anyway,
> I think we're better off reading it unconditionally than having multiple
> branches.
> 
> Not really important, if you prefer to keep them consistent, that's fine
> with me too.
> 
> > 
> > It just seems a bit surprising behavior.
> > 
> > That is an entangling of two separate things.
> > - msg_get_inq sets msg_inq, and
> > - cmsg_flags & TCP_CMSG_INQ inserts TCP_CM_INQ cmsg
> > 
> > The original TCP patch also entangles them, but in another way.
> > The cmsg is written only if msg_get_inq is requested.
> 
> The cmsg is written iff TCP_CMSG_INQ is set, not if ->msg_get_inq is the
> only thing set. That part is important.
> 
> But yes, both need the data left.

I see, writing msg_inq if not requested is benign indeed. The inverse
is not true.

Ok. I do think it would be good to have the protocols consistent.
Simpler to reason about the behavior and intent long term.
 
> -- 
> Jens Axboe



