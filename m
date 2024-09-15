Return-Path: <netdev+bounces-128433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1ED979846
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 20:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2501F2178A
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 18:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB26C1C9EAB;
	Sun, 15 Sep 2024 18:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbWpzrev"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C191C7B63;
	Sun, 15 Sep 2024 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726426562; cv=none; b=lpunwgFv3BAfuCYATssCzqI5WQvHoFtm8CdaJ9XvKV4vk1B9rT6tYP2ZlrkTs3hUGWJoualiwuEE2E8tYeHjELJOdOjyd7jEtGRvcB+Yj12OiWIfof1p89+rM7ncatAeXcUmzeuOzDaO7v9Nd9xhJGL6wgu5HifugQP1T/XAG/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726426562; c=relaxed/simple;
	bh=pyXg3C+MBpFzSvMkYmhK5H0sNHIDq/A8dTv59B/xh+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6hYN955lm1cwL14Hc76TezJ2/oDZYdhbq3aRVkK3kNGjnAsz3BhKdV+eboLyWwdoZGCgxhVUuOj16nH/UpXnYt3szikA0GuleJjA/ZZZvXl8ykMU+3OMXM5OA/J4quExBiAX8yvrSHpiOZIgcnMycQRZe0zdnr1oejCnnEU+RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbWpzrev; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb9a0c300so32251785e9.0;
        Sun, 15 Sep 2024 11:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726426558; x=1727031358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FUXAf1Wvy+TtP7gfZ+RggUrHuJgfqEsJuKNT6i/ikoY=;
        b=UbWpzrev8IgpJtBelqRADgWMctuMs2q0xaDm4mW8CEDR4b7VT34BdmBlOMvkyEVLOd
         L8rExg0CHmiyA+yJDUIwzPgPO354tebBn6qmlnElkySe7L3qN635vLu9q/XPFiaZaqdz
         +Tcmipu4p71jodoHGN+PWE8WW4r/wRBDZj0kNmeqz9RVLs0hqbihlPkP4f5/6KJ5YuYA
         +BM1sT/lIjZJvLW7+L3NfD60lPdei+34SGXCDXedug+xY+tXNT8X5MZNCxt56sLk+9tC
         Uqqc22sv8sqzzzc46H5uNPhPFRLVEiRGU343ajgirigJdx3iV9gYnLT6OawrRcD4MQDT
         5EIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726426558; x=1727031358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUXAf1Wvy+TtP7gfZ+RggUrHuJgfqEsJuKNT6i/ikoY=;
        b=gg3+o6CIddoGHTsgGULwTMsnc/ndOXlK9ofYRONdgV1NZPSqMWQn6YdNydJaVReRq6
         YDK58f0hJdQe0dm6wMCMsV3qjIphGLlKexRs7HSIs0fUSJQwjUrOZ53EYLer3OtC//83
         lkuqm01ZlWHQOZTeyr6NI0YzclXXu8Rqbe1E57mVgtYLVqhOOiPErwIInntxtBC/rBzm
         SNWu7BU7qm8vLl5mDj5pp51TEFbi5dxuvYL3FsvH2cM6vafmcTzL9BfWqWZkIDFZlEYl
         PrJPA/7hL97CLT1UiM0rtRG/bfiP237EpFfhEAvit1VPgLhotcDtcJETTQpc/+1iiMyC
         hYjA==
X-Forwarded-Encrypted: i=1; AJvYcCUb6B2NhDRaUEbKwLs2ZUik6Fa3asE1ppEjQOqHp6cX+E0CvRSz+s9aGFoClgk2kfqHtln9uAJ7@vger.kernel.org, AJvYcCVdbeTGHhzaiMFoRuVKJjq8Bi1LC/9Yclnb2Y6JAqh89EYcnq1ckvkxupQ0HFdreTi7+8JkACzs75jCUR8uEeo=@vger.kernel.org, AJvYcCXe+VvJNRhTYi5Xc8dEl/fwshJvKGuoxCtaUo/GUkAhpVtq20CACs6l6ZI5wqgQBYM8vMBwd9WkbkD+B/b3@vger.kernel.org
X-Gm-Message-State: AOJu0YziUg/APIqvibwq5m5pvSzf3z4z/2C0SA3B+wts/VdfqoSTVvE4
	ITgsof2TuT7m0kC+6VQw+oNKP4tL+hI9/uYT95mhLfLhhoZcvG/j
X-Google-Smtp-Source: AGHT+IF0QEQ10abt4tDQYvW+SUo7hwzkw9XEuJL5muO4z7HqRzE4YD+BvBRUoFlDJ2+cYJ4q40HwzQ==
X-Received: by 2002:adf:fbc3:0:b0:374:cb5c:2966 with SMTP id ffacd0b85a97d-378c2d5a6f5mr7476056f8f.40.1726426557557;
        Sun, 15 Sep 2024 11:55:57 -0700 (PDT)
Received: from void.void ([141.226.169.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e71ed099sm5278847f8f.5.2024.09.15.11.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 11:55:57 -0700 (PDT)
Date: Sun, 15 Sep 2024 21:55:54 +0300
From: Andrew Kreimer <algonell@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2] ethernet: chelsio: fix a typo
Message-ID: <Zuctuiz-F3M7uFli@void.void>
References: <20240915132133.109268-1-algonell@gmail.com>
 <20240915184853.GC167971@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915184853.GC167971@kernel.org>

On Sun, Sep 15, 2024 at 07:48:53PM +0100, Simon Horman wrote:
> On Sun, Sep 15, 2024 at 04:21:32PM +0300, Andrew Kreimer wrote:
> > Fix a typo in comments.
> > 
> > Reported-by: Matthew Wilcox <willy@infradead.org>
> > Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> > ---
> > Keep the layout intact.
> > 
> >  drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h b/drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h
> > index 4c883170683b..422e147f540b 100644
> > --- a/drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h
> > +++ b/drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h
> > @@ -49,7 +49,7 @@
> >  /******************************************************************************/
> >  /** S/UNI-1x10GE-XP REGISTER ADDRESS MAP                                     **/
> >  /******************************************************************************/
> > -/* Refer to the Register Bit Masks bellow for the naming of each register and */
> > +/* Refer to the Register Bit Masks below for the naming of each register and  */
> >  /* to the S/UNI-1x10GE-XP Data Sheet for the signification of each bit        */
> >  /******************************************************************************/
> 
> Hi,
> 
> net-next is currently closed, as the merge window is open.
> Please repost once net-next opens, after v6.12-rc1 has been released,
> which will be in in approximately two weeks.

My bad.
> 
> Also, please explicitly target the patch at net-next.
> 
> 	Subject: [PATCH net-next vN] ...
> 
> Link: https://docs.kernel.org/process/maintainer-netdev.html

Thank you.
> 
> -- 
> pw-bot: defer

