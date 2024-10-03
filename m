Return-Path: <netdev+bounces-131821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37A398FA62
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 01:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E281C21FAA
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F0D1CEEB8;
	Thu,  3 Oct 2024 23:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6MI6wry"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30031CC171;
	Thu,  3 Oct 2024 23:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727997681; cv=none; b=ervAiZNrYxKMk+VFeu4uDPajDLbVoUi+FL3OOPCrbW1doZFqhVwtZcPqFTJ+Yr3L55/L80v1jXtdY7SxC4tDt2KChQlg82v0Cr+xIOPgkK81Wv4tEoU2HEsbh1woIS70n5aGuPjs8HgpZmVyYWW4/FZ8u7VyYUGJ6h149rgRg6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727997681; c=relaxed/simple;
	bh=eVXg8u3XrljKjiiOHqhj35PcopvH9VNwN0nDMPr7NM0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DU7kMh8juAik7Udp7ploo+pBOHJRiszybo7x4G5sdVIBWScqvI3iEq7Z+r44YDQ5NqU0l31Ie58oJrMyRKLSrYS7jZt7eg8AVxpl5QD+vZhjMLcudI8wBS5HV+KKQKhIdHOrmA2846nqCErB0t3aic9VUB5FmHW/hQeH7kFj2ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6MI6wry; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d00322446so1401080f8f.2;
        Thu, 03 Oct 2024 16:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727997678; x=1728602478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UqoWLMlr5CIUseH/hnIdpOyZlgW/tBriMEfRLE9+5SE=;
        b=b6MI6wryyp+A06wYI9Mnk6hhsp3FG4I/RtRbch2IMSQD5bvxoF/Iv7rXaMryRwTw8O
         5bsNpTWIW8Q6SmGoV5YF6q3SFEgOnLWtdh18PbAkv9KK+CjpTRBSxOZxg5PKCEwlaPbg
         VFuH8iDk6ebIArHXKicQlVdHka2EFWeV7yK/xcuWWDXENpGaRnJxJe9ZdFpWzQsV3Hr7
         1jRThpRdgVbTq6DfLzCjidB46gFvJMmXr5NIMo/L0qKb900Vc2TbhkJ9iLdgNqgtMJgm
         TDdEJRZI+daBGjE79NHj9r5hqvb7uoZ34YRmzLZpgSePUG5L7/U08kIZXBhho/+hgFlh
         1G9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727997678; x=1728602478;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqoWLMlr5CIUseH/hnIdpOyZlgW/tBriMEfRLE9+5SE=;
        b=HWZqBnJ+R5JmRQQR1KGo+Gen6nD0ShoBDYMk7RBsvfvcewLd4psH7ArMDyuLyBBKas
         zFtkuO+X/YXfayQOeUZ3k3euqa7iFQOsZYgiHynqiZIbMB1PyF9bDmVJ1CN/OmoSkONO
         4k9komjNY21JxeMucS/cQM6G34Y4HJKJvvIRmU7VZu8qibtT2w8nb2MeSFlGcBB3txS2
         VNv+Eoeu8qXD8FvhkjTtNzg4ixWhS2W+toZWQUFiWycpnFdO88ymMKPC+i0nJPl9VU4q
         oeYZEj3ax2Er3wOIYvmtzzgcoefzAzgWy1mrK66F7j5a59O0u3fRoG1rsRdR3K/Jt1Uu
         J1wg==
X-Forwarded-Encrypted: i=1; AJvYcCVpgpqXHyWZ5s64ga5/p+qTTMWLbVx+NmOlafTBMQ5j59vCG+K4vetPW05XmCaoZjov4lGNYx8b@vger.kernel.org, AJvYcCW5omCflU6mCldC6+xrri9Y2bcaoYt9lfqo3rOGMzcD9HEubiqvwm9xoNSfx3UkxkW4EvFTqbP6KBOyODE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYeEEu6ncAMyfwBtMfgeiaxRK7SO92utUGLEqmTQvW/IVL3gzt
	Xggn2936t1Tyy6jaux0REuUmQ8qrR1LsQA/eZkALnHoZHGmpNetK
X-Google-Smtp-Source: AGHT+IF2STV3AbfwcL5mkbfl8DyA1LgpI73c34VDKr80PTUO/pVFNkPWpV7LETS0blHWAsRcKYXVkw==
X-Received: by 2002:a5d:538f:0:b0:374:c10c:83b3 with SMTP id ffacd0b85a97d-37d0eae4b45mr492524f8f.54.1727997677987;
        Thu, 03 Oct 2024 16:21:17 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082a6992sm2131873f8f.68.2024.10.03.16.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 16:21:16 -0700 (PDT)
Message-ID: <66ff26ec.5d0a0220.cfdfb.a95d@mx.google.com>
X-Google-Original-Message-ID: <Zv8m5u0fUNgj9dB0@Ansuel-XPS.>
Date: Fri, 4 Oct 2024 01:21:10 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: phy: Validate PHY LED OPs presence before
 registering
References: <20241003221250.5502-1-ansuelsmth@gmail.com>
 <20241003222400.q46szutlnxivzrup@skbuf>
 <66ff1bb3.7b0a0220.135f57.013e@mx.google.com>
 <20241003230357.z2czrn3pymhuywud@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003230357.z2czrn3pymhuywud@skbuf>

On Fri, Oct 04, 2024 at 02:03:57AM +0300, Vladimir Oltean wrote:
> On Fri, Oct 04, 2024 at 12:33:17AM +0200, Christian Marangi wrote:
> > On Fri, Oct 04, 2024 at 01:24:00AM +0300, Vladimir Oltean wrote:
> > > On Fri, Oct 04, 2024 at 12:12:48AM +0200, Christian Marangi wrote:
> > > > Validate PHY LED OPs presence before registering and parsing them.
> > > > Defining LED nodes for a PHY driver that actually doesn't supports them
> > > > is wrong and should be reported.
> > > 
> > > What about the case where a PHY driver gets LED support in the future?
> > > Shouldn't the current kernel driver work with future device trees which
> > > define LEDs, and just ignore that node, rather than fail to probe?
> > 
> > Well this just skip leds node parse and return 0, so no fail to probe.
> > This just adds an error. Maybe I should use warn instead?
> > 
> > (The original idea was to return -EINVAL but it was suggested by Daniel
> > that this was too much and a print was much better)
> 
> Ok, the "exit" label returns 0, not a probe failure, but as you say,
> there's still the warning message printed to dmesg. What's its intended
> value, exactly?
> 
> What would you do if you were working on a board which wasn't supported
> in mainline but instead you only had the DTB for it, and you had to run
> a git bisect back to when the driver didn't support parsing the PHY LED
> nodes? What would you do, edit the DTB to add/remove the node at each
> bisect step, so that the kernel gets what it understands in the device
> tree and nothing more?
> 
> Why would the kernel even act so weird about it and print warnings or
> return errors in the first place? Nobody could possibly develop anything
> new with patches like this, without introducing some sort of mishap in
> past kernels. Is there some larger context around this patch which I'm
> missing?

No larger context. I posted 2 other patch in net that fix some problem
and found it strange that this change wasn't in place. Looks wrong to
define leds node for a PHY ID with the driver not having OPs for it.

I posted this in net-next detached from the other 2 as I wasn't sure if
it was that correct, just taste. The problematic part is registering a
LED that is actually not usable cause as you described I can totally see
someone proposing downstream DTS with LED in the PHY node and never
actually care to implement LED support for it. User might get confused
and think there is some kind of bug in the driver as he would have LED
present but everything gives errors, while in reality is just the
feature missing in the driver.

Totally ok to ignore this but aside from the bisec scenario that can
produce false-warning, the warning might be useful in some situation.

-- 
	Ansuel

