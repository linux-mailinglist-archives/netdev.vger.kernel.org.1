Return-Path: <netdev+bounces-202281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6EDAED02B
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 21:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F0C18911F8
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 19:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941061EA7C9;
	Sun, 29 Jun 2025 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1uw5iGv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F531E32D6
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751226634; cv=none; b=H1u1hCcn6kjW5bg5u2HGoHMyqbw+PE7xoZnPSeIkN9xu+WZ06Q/ukUndmypHh0Qq4Xk40o5vzjsf04fRtLL1ZnlIo9TWz9vFkALLQEGHIcOweBHFvuW+Qb42666nvepooosYb+X/ziIlk/Pu/h0pn7bieYwssmgiWR83g2kLqhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751226634; c=relaxed/simple;
	bh=C8mqdScJmc/LY2iSLt7YomPtZiRBML+wFNz3jA7tfUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F15+NY6XjJJ6rreGjSv2VSqzgcq8pGIpq39kp864IAqmtYVxl1SprFPsAu0k4GbNygUgXdtHZxAKCq/uoceTICuYrqqtzLgR2Jw4FhKNMGldcx8OFHIQrwV3l5e2AXxdmzQ2NtQDMoOY9blwpsHog0aCe/WrpoJCSFu5LsRnDPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1uw5iGv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235f9e87f78so12440985ad.2
        for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 12:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751226632; x=1751831432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=scEpvMRNJcRA7SEybT/FzGXA00Dk4ouygtr6rwr7LCo=;
        b=H1uw5iGvetlH2Cbs3NqSu0hlfCKJHd4EuaRcp3cR3OOLFRoi0ppSzrkHH+eV6sK1p8
         oel4yBzQSQpAckiHzJ4z5b69OK/PDq8SNoCaIC+hCHDTMVG5UsAFIPAyNC55QIkbuoJH
         Yx08261mBL80/oQGmjeWOA5yMKCSMAWAk37MH+eTNIV5DkyLdnSVWBFy2iL6RbXiMWNe
         51KRPrYsXud5Tbn2Tqo6ZoYtYeeUAsN/txo+kD00glo3Etcri+O3A+XDTrrSpMPm/M/z
         XR6uCwLf37FS2m/xL51Ofe2ZZaclNYCvqmKAvUbyJp0lW8Bc1G7mpna1MBp4i8xfvW7U
         yR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751226632; x=1751831432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scEpvMRNJcRA7SEybT/FzGXA00Dk4ouygtr6rwr7LCo=;
        b=Qg4wPIghKjwvuRlX9oF94Q2Kg8YE+iixdS9VUEfGPTl/twp2uQJhGNB/Ce2fKX0yVm
         1kqUYJkEzoyrUExeubLUsngUNpPeXKXgvDIFy8XtH0guZDUNmi7Y2WIYLcvPH3nzust/
         zFxVmo8STmzpa0e5+1oUvy8mD60u5Q3+nHhAV8ZBjOKDJq1pcUJfHowG8H/Tmf/+dQQj
         ylZanvfnNwDhGMQlE5cIM6IGs9ySjDQJ7xT4T4vjFqWSQz30u1B/4ogDEtnG9RENqRDO
         F99LH1Gy0SV1TYLFtcmmB08Qp6cT3cbexLgOuEMjt5e+qkhBlaWL6GkQHyZxORPhMzyd
         snqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6C4UtgdmdaFfbKmGVGLcr+IUG51+zpGhMsM8DHmspFbF18yETT1AZf7ZWsbu9eF11B5AZ49w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEzlLYP+pf3y3srXNIsjpiyMuyjOGo88laTzQfQIqpvka6o84P
	75dvhzTeyMpuE6S54t0iQT5rKnGaxd55+ilnM4U6M1nwKZxt4UQJlQtKAWP41w==
X-Gm-Gg: ASbGncvmaLyVKtU/+dBsZU1RonhXALTeDDTP7ms+DUzLVBaY5SGCy8MFfX+3LfNSuZs
	MBvnV0TQNihPDFfTH16kbQyHka5JBqxKIW5UmnHVItykveLz5c/JwbPQj8j81qEckglrSjmzKPA
	bhTFxD1AVbbNgIqWVHMCrWnnLLtgzwxkhMDf9Wtmr+3vbXa67vvPxLwSocBREuYnmg6bdstDDr/
	tS5wFTjXmKA/8T7MWHKYTbdSSmDQZIZSmsBMXJHQo8kLnTtnoViVtsyVOj9gSC06VFFowgQKghJ
	8EHdV8ou8xe0QEeG8bccvDoBpnmCwSlSdMqdALmIR/XhwrtVsdmNpBlEIxaexrHqqObToaGrviH
	qBa877GH+75S1f+9aEnNjNgdP+urEF4E/Ljkjbg==
X-Google-Smtp-Source: AGHT+IE1ntpM49tmpxjsylOclww2bx/cpYBW+VqYTmc0aMZYkTdx4uAjUq/CYd4NthPwkkTBidHMBw==
X-Received: by 2002:a17:903:1aab:b0:235:eefe:68f4 with SMTP id d9443c01a7336-23ac46066bcmr181298885ad.29.1751226632386;
        Sun, 29 Jun 2025 12:50:32 -0700 (PDT)
Received: from localhost (ucsc-guest-169-233-124-66.ucsc.edu. [169.233.124.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f21fesm64960525ad.73.2025.06.29.12.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 12:50:31 -0700 (PDT)
Date: Sun, 29 Jun 2025 12:50:30 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Lion Ackermann <nnamrec@gmail.com>, netdev@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>, Mingi Cho <mincho@theori.io>
Subject: Re: Incomplete fix for recent bug in tc / hfsc
Message-ID: <aGGZBpA3Pn4ll7FO@pop-os.localdomain>
References: <45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com>
 <aFosjBOUlOr0TKsd@pop-os.localdomain>
 <3af4930b-6773-4159-8a7a-e4f6f6ae8109@gmail.com>
 <5e4490da-3f6c-4331-af9c-0e6d32b6fc75@gmail.com>
 <CAM0EoMm+xgb0vkTDMAWy9xCvTF+XjGQ1xO5A2REajmBN1DKu1Q@mail.gmail.com>
 <d23fe619-240a-4790-9edd-bec7ab22a974@gmail.com>
 <CAM0EoM=rU91P=9QhffXShvk-gnUwbRHQrwpFKUr9FZFXbbW1gQ@mail.gmail.com>
 <CAM0EoM=mey1f596GS_9-VkLyTmMqM0oJ7TuGZ6i73++tEVFAKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM0EoM=mey1f596GS_9-VkLyTmMqM0oJ7TuGZ6i73++tEVFAKg@mail.gmail.com>

On Sun, Jun 29, 2025 at 10:29:44AM -0400, Jamal Hadi Salim wrote:
> > On "What do you think the root cause is here?"
> >
> > I believe the root cause is that qdiscs like hfsc and qfq are dropping
> > all packets in enqueue (mostly in relation to peek()) and that result
> > is not being reflected in the return code returned to its parent
> > qdisc.
> > So, in the example you described in this thread, drr is oblivious to
> > the fact that the child qdisc dropped its packet because the call to
> > its child enqueue returned NET_XMIT_SUCCESS. This causes drr to
> > activate a class that shouldn't have been activated at all.
> >
> > You can argue that drr (and other similar qdiscs) may detect this by
> > checking the call to qlen_notify (as the drr patch was
> > doing), but that seems really counter-intuitive. Imagine writing a new
> > qdisc and having to check for that every time you call a child's
> > enqueue. Sure  your patch solves this, but it also seems like it's not
> > fixing the underlying issue (which is drr activating the class in the
> > first place). Your patch is simply removing all the classes from their
> > active lists when you delete them. And your patch may seem ok for now,
> > but I am worried it might break something else in the future that we
> > are not seeing.
> >
> > And do note: All of the examples of the hierarchy I have seen so far,
> > that put us in this situation, are nonsensical
> >
> 
> At this point my thinking is to apply your patch and then we discuss a
> longer term solution. Cong?

I agree. If Lion's patch works, it is certainly much better as a bug fix
for both -net and -stable.

Also for all of those ->qlen_notify() craziness, I think we need to
rethink about the architecture, _maybe_ there are better architectural
solutions.

Thanks!

