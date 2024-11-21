Return-Path: <netdev+bounces-146642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 497369D4D39
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 13:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02441F21B0D
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 12:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0911E1D3585;
	Thu, 21 Nov 2024 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp/XsfoX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C08F1D14E0;
	Thu, 21 Nov 2024 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732193704; cv=none; b=BleCrYjwDDhgN6IZCYcqdV2XN41U5NYPqQQW+378y+Xn2yPXJxMQXsmB2CwRqYuI49Drn5CafADpOia07FM6eg6g0LLA57f7ilspL7OqGfNKr1g5FZpm733/7hDJyX2IaGTl6o4+YaBvcwENAirfFdo52NFt6zilgMtGoS9b4xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732193704; c=relaxed/simple;
	bh=TyRK0v6JWrIoG6N1dVoWdnKtThdHjDpGnXnLbjIA28w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AH2no3Btz/TfLkmN3BRWWkY94wS9KJAMUU2lCltv6xSGHnEGWI5tZD7KuaLPSRD4RPLxtvX/jQ83pzg5SPKHdFmCbKAMSDJMLHMvOfOe2Ay00UTmEbbWbk+BeSN1MDIjKAQWVpItbuqYM0j4pTdP53rysvVR9cIldNrWpzm/gtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vp/XsfoX; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38231f84d8fso109097f8f.3;
        Thu, 21 Nov 2024 04:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732193701; x=1732798501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/mk/t5JsGWeIH/DpSPDEQ6FuPdTH3isfQI/VwO/903c=;
        b=Vp/XsfoXvdMGp+Gv51WYgJ4ht4sAmEuqdWZOqowJXQmMoVDpPOmi7WEP3rOy3QEVNC
         AQRI2HAlZKKFiSsoVC25pI3Ur+lP2etEwwHMHklBqannAW8AgNZiOEo75yO8Y9QpqrZi
         7DtoN8EG7uemJxCm9WlEUs37bIHw8Jsmp2LAIDA0PzeEXdkdSZvx2TUucmPr4jC06an4
         Oz5ScBACh5s9nHsH58mQe+3cQeXDSuQI2n5WDOMJ6AtmMhl7FNARYx6smf8zaLoqejzR
         MFn/WsJAlPDzleM2uOW01IpHuBYI3q4W3SQDIfIwq3uxcKBuS8bAZSwiBC2isbBBMFFb
         KHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732193701; x=1732798501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mk/t5JsGWeIH/DpSPDEQ6FuPdTH3isfQI/VwO/903c=;
        b=ayVM+oVLpbmQRO9ITG/idbB34V4TVlCuVA3q1pTbB1W9dnkclKqQl+MraM2iNxov7s
         gImLV08+HJNXoQAtLOPtktfsGPDZbGEa3atDvqxa9I/We8aFX/K19bdYlwNdgY+3hXD5
         +BhncrNsGX/9U0/uXyeeYL8r3bcziVjlaBMVxzsvN0sIc6ACgU+nDEj70Mkv2mODs9T+
         TpI5vxx6IVDYj2ofgq0gKgqFbin7osWhuiy7bR6l21Mp2uv9BaVvVT7LZNGtFfpQHmlM
         nPj6azegofO5LmNRvlTtGqjxJt5yRjLG9Tb6D5/sfrHASkHSned7Gb6MDux8uTNf82ss
         sX1A==
X-Forwarded-Encrypted: i=1; AJvYcCUYb/NI7w9i2eqMhl6lyVWgOrd65hIZYt6Jc/9aC++n7olhjMPyi0e9Ihw89RBhtUTcY/HaE0o6@vger.kernel.org, AJvYcCWjm7wvkV9L84Kg37qCh4SE6flGmLxLvWF3U2KSiRh4GWBInM425mIHlwanCgZkjYylL9s0bgS0o8eDqCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIymg4o2+MyYFuURr6xut5m5sf5Q1Fv4f0DgQevF4yD7qYtp7H
	NPdbThG5u6h1Td1TUXwrZ7SRSm7iLZ2L1SAHJ9soHHTaWOakuLZl
X-Gm-Gg: ASbGncuQ7bidCgSPfrmyX8/hXnZ9+3L+A+V2z7sN0IKdYUcpQisKNq29ISjhMP35Ajb
	C6wd3MOguAIGnev46KFKQGbe3d6Kd4PBruh9M3tukbIe7Dt5UtnlEWntf3H0ofDkuDX34sY2Ehg
	3v+vbdtBAr2wZcGiLTSD8zy6CCYqnC53+Uxp6j//h08E77XbS95piPwNrwHWXhzlWX1pFIm5omI
	8M/O2DvDa1zBFB4yT0qySsq6QqWbZaXEpK0YHs=
X-Google-Smtp-Source: AGHT+IFDTPLCdhZ3osSznMNoSPBMhCR1wAYH99OVovJbtBHn7pTWd7vID7NNkDjgBlDJ7dm0CyRsYg==
X-Received: by 2002:a05:6000:1f83:b0:382:4378:4637 with SMTP id ffacd0b85a97d-38254b21195mr2013739f8f.12.1732193701049;
        Thu, 21 Nov 2024 04:55:01 -0800 (PST)
Received: from skbuf ([188.25.135.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825494ca3fsm4982014f8f.111.2024.11.21.04.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 04:55:00 -0800 (PST)
Date: Thu, 21 Nov 2024 14:54:58 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Cong Yi <yicong.srfy@foxmail.com>, andrew@lunn.ch, hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	yicong@kylinos.cn
Subject: Re: [PATCH] net: phylink: Separating two unrelated definitions for
 improving code readability
Message-ID: <20241121125458.j237l34kw3uxhskz@skbuf>
References: <Zz2id5-T-2-_jj4Q@shell.armlinux.org.uk>
 <tencent_0F68091620B122436D14BEA497181B17C007@qq.com>
 <20241121105044.rbjp2deo5orce3me@skbuf>
 <Zz8Xve4kmHgPx-od@shell.armlinux.org.uk>
 <20241121115230.u6s3frtwg25afdbg@skbuf>
 <Zz8jVmO82CHQe5jR@shell.armlinux.org.uk>
 <20241121121548.gcbkhw2aead5hae3@skbuf>
 <Zz8nBN6Z8s7OZ7Fe@shell.armlinux.org.uk>
 <20241121124718.7behooc2khmgyfvm@skbuf>
 <Zz8sZ8WTocbX1x3r@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz8sZ8WTocbX1x3r@shell.armlinux.org.uk>

On Thu, Nov 21, 2024 at 12:49:43PM +0000, Russell King (Oracle) wrote:
> On Thu, Nov 21, 2024 at 02:47:18PM +0200, Vladimir Oltean wrote:
> > On Thu, Nov 21, 2024 at 12:26:44PM +0000, Russell King (Oracle) wrote:
> > > On Thu, Nov 21, 2024 at 02:15:48PM +0200, Vladimir Oltean wrote:
> > > > On Thu, Nov 21, 2024 at 12:11:02PM +0000, Russell King (Oracle) wrote:
> > > > > On Thu, Nov 21, 2024 at 01:52:30PM +0200, Vladimir Oltean wrote:
> > > > > > I don't understand what's to defend about this, really.
> > > > > 
> > > > > It's not something I want to entertain right now. I have enough on my
> > > > > plate without having patches like this to deal with. Maybe next year
> > > > > I'll look at it, but not right now.
> > > > 
> > > > I can definitely understand the lack of time to deal with trivial
> > > > matters, but I mean, it isn't as if ./scripts/get_maintainer.pl
> > > > drivers/net/phy/phylink.c lists a single person...
> > > 
> > > Trivial patches have an impact beyond just reviewing the patch. They
> > > can cause conflicts, causing work that's in progress to need extra
> > > re-work.
> > > 
> > > I have the problems of in-band that I've been trying to address since
> > > April. I have phylink EEE support that I've also been trying to move
> > > forward. However, with everything that has happened this year (first,
> > > a high priority work item, followed by holiday, followed by my eye
> > > operations) I've only _just_ been able to get back to looking at these
> > > issues... meanwhile I see that I'm now being asked for stuff about
> > > stacked PHYs which is also going to impact phylink. Oh, and to top it
> > > off, I've discovered that mainline is broken on my test platform
> > > (IRQ crap) which I'm currently trying to debug what has been broken.
> > > Meaning I'm not working on any phylink stuff right now because of
> > > other people's breakage.
> > > 
> > > It's just been bit of crap after another after another.
> > > 
> > > Give me a sodding break.
> > 
> > I just believe that any patch submitter has the right for their proposal
> > to be evaluated based solely on its own merits (even if time has to be
> > stretched in order for that to happen), not based on unrelated context.
> 
> Right, and my coding preference is as I've written the code. If my
> coding preference, as author and maintainer of this file, were
> different then I would've written it differently.
> 
> Am I not entitled to make my own choices for code I maintain?

Well, yes, I do believe that's the essence of our disagreement. I would
very much like phylink to not be the personal island of Russell King the
individual, but open to common patterns adopted across the entire
networking subsystem, and especially to other individuals. You've quoted
ata headers as an example of a similar pattern, but "git blame" says
that comes from pre-history, so I'm not sure it's exactly the best example
of what to do today.

