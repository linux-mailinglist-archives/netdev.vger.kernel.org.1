Return-Path: <netdev+bounces-108412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07807923B73
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 12:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DFC1B20D1C
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 10:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6EC1581F7;
	Tue,  2 Jul 2024 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmFQvUhf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DC3154449
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719916311; cv=none; b=koFwCss6N7UOFLCtZuxvhWQA2UzL4h29lotrnrTRh2SMdMo0L0W/U1rsdfcBpmfOF0ize1ML46kYk6RbpZ+d8FFngdaOYXR11QVwNKD/RAPzMCrHgwN2y7yzNV7C/Bsvq3z5wuWMQA9m4lSXQyNP23B3AdvKx0oqS0reuqT1+gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719916311; c=relaxed/simple;
	bh=bMjnNap+9P8AJoCAh8adxqw3fkMreOfHDcB7IeFFONw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpLUH33g+kOTTDoQvD8a8DWGnr1DVqTFYdiurMfckK7RuOBRgLrd7q7JHFs6Nvyp8QxNrdc6I8ZeoYdpFnbd972xvtSsXFmfZPQBIE0ylTcm7JK47HC77iNcUYLEmAGRaOeGKVg4P4trBbaJDwYgG9OnsiNsCLRAv/PKx8Uuoe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmFQvUhf; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52e743307a2so4523093e87.0
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 03:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719916308; x=1720521108; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ULRgGqYs7UNyw+zDj9HLkr04tyoeDAQXwbvUUUaEOC8=;
        b=lmFQvUhfliO3kFnHrk2V2SglNrhstU2kcKBoo1E6ACv2XVNeae51b6KRi0jBm/RxYq
         y4HD3Ir+rmfioEN9nIDEOR1gbpkpUD/VPFysv0LNr/wy1d/mo4baNy4atZ916bF/tlZl
         OL5js2qq2ks9ECTGVhdFfW7r1lnPjipMV2nlS6BK0nWcXUmXlbuiQ2YqVyYp63nY0UIG
         n5/7OojSTQnlLUupTKmMuNkqKY4zurCSLRHHXG0VBrpLY8iXXE5UJD3E+49G39+dtfpJ
         cLtRHjoL4EYxYGnnqibN42sqPUVYo/bUy9Gk9dTd6ag0PeSXzbg4BwIJMGp452PAPYar
         z7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719916308; x=1720521108;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ULRgGqYs7UNyw+zDj9HLkr04tyoeDAQXwbvUUUaEOC8=;
        b=cAj8/PRCQthAc6XOunKqu0Si5PZqjDwSPwue/teGKJQj3zBKzNAj8NnlTB1smc6vNG
         2Rdi8xpNskMZZiaTUU61jhuMvgz9Uth05Z3U9kmw3GdRnl7JwMKmk9cufms2SKrMZ4ef
         ebk3K3LhHoQwFEUGqtQnDEyEaBFxpF07utYZP78X6y6Lf/Iteqls5gQgj6x4bTUCocko
         Q/4dqoiIvtMH0Hjo6MFoC8o4VcFmY/pVSb8fwYdD2g/SxbdEmATe//q3KqGnFQtfNCf0
         d1xs6scBmoDvVviTeAD2Use7HLWlZSuhfkzyQKQSzrSBCjKAj0vANvQDd1ZRYNuay774
         /BZw==
X-Forwarded-Encrypted: i=1; AJvYcCWTvdVvd4DxDsOnB/cSeXJq95bFntWoVd9sbRsxqA8PIM/ygXk83mW6dty9TUTGUxEWdlCrm3inAsYMjxH63rBQfaZ63mgR
X-Gm-Message-State: AOJu0YwreT/2tD2oyHUlLFo3x8wMWqXI5WS1OAVcsbkw6MmBPvyNuqxQ
	6W1c6TRHqfqro0SnHA6lVYMDRX7RpqN3+w5Qg2OgzffyFRWF9Nbp
X-Google-Smtp-Source: AGHT+IFb6XJcFXfWrMoakLDXgRQHW3ix4TCDQfcJItRTi6sCcvEImAKe4aqIAiMDdYogdbhe5UYNYw==
X-Received: by 2002:a05:6512:3b0d:b0:52e:73a2:4415 with SMTP id 2adb3069b0e04-52e8270adecmr6632194e87.46.1719916307693;
        Tue, 02 Jul 2024 03:31:47 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab2ea9csm1754546e87.202.2024.07.02.03.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 03:31:47 -0700 (PDT)
Date: Tue, 2 Jul 2024 13:31:44 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: si.yanteng@linux.dev, "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v13 12/15] net: stmmac: Fixed failure to set
 network speed to 1000.
Message-ID: <gndedhwq6q6ou56nxnld6irkv4curb7mql4sy2i4wx5qnqksoh@6kpyuozs656l>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <e7ae2409f68a2f953ba7c823e248de7d67dfd4e9.1716973237.git.siyanteng@loongson.cn>
 <CAAhV-H6ZJwWQOhAPmoaH4KYr66LCurKq94f87FQ05yEX6XYoNg@mail.gmail.com>
 <ZlgpLm3L6EdFO60f@shell.armlinux.org.uk>
 <6ba14d835ff12f479eeced585b9336c1e6219d54@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ba14d835ff12f479eeced585b9336c1e6219d54@linux.dev>

On Tue, Jun 04, 2024 at 11:29:43AM +0000, si.yanteng@linux.dev wrote:
> 2024年5月30日 15:22, "Russell King (Oracle)" <linux@armlinux.org.uk> 写到:
> 
> Hi, Russell, Serge,
> 
> > 
> > On Thu, May 30, 2024 at 10:25:01AM +0800, Huacai Chen wrote:
> > 
> > > 
> > > Hi, Yanteng,
> > > 
> > >  
> > > 
> > >  The title should be "Fix ....." rather than "Fixed .....", and it is
> > > 
> > 
> > I would avoid the ambiguous "Fix" which for stable folk imply that this
> > 
> > is a bug fix - but it isn't. It's adding support for requiring 1G
> > 
> > speeds to always be negotiated.
> Oh, I get it now. Thanks!
> 
> > 
> > I would like this patch to be held off until more thought can be put
> > 
> > into how to handle this without having a hack in the driver (stmmac
> > 
> > has too many hacks and we're going to have to start saying no to
> > 
> > these.)
> Yeah, you have a point there, but I would also like to hear Serge's opinion.

I would be really glad not to have so many hacks in the STMMAC driver.
It would have been awesome if we are able to find a solution without
introducing one more quirk in the common driver code.

I started digging into this sometime ago, but failed to come up with
any decent hypothesis about the problem nature. One of the glimpse
idea was that the loongson_gnet_fix_speed() method code might be somehow
connected with the problem. But I didn't have much time to go further
than that.

Anyway I guess we'll need to have at least two more patchset
re-spins to settle all the found issues. Until then we can keep
discussing the problem Yanteng experience on his device. Russell, do
you have any suggestion of what info Yanteng should provide to better
understand the problem and get closer to it' cause?

-Serge(y)

> 
> 
> 
> Thanks,
> Yanteng

