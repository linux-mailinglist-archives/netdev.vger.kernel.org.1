Return-Path: <netdev+bounces-97874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89C48CD9CA
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 20:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DB92B225FE
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 18:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E558D43AB4;
	Thu, 23 May 2024 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QgtG7xdf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0837A1F5E6
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716488596; cv=none; b=L17UrBVnBLpPSWa43WKgx8JylmnOF3uprFjXr+RCMCQ31QbauXkB8XFWPMrdLwiWlUWd8naHnt2uO1FNYynwY0M2gx7J4T2JO0JZh/u1RNyNd53iVxS4eT0jlJmwWZREQn9FsWo7a0IZjZXkGSAJfa6tLfvZznG0JEn5XLj7Bw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716488596; c=relaxed/simple;
	bh=YpLORyNL0Z5yk+8up8p9RuJQ5UV1uELRAJgfKqVMjik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTSNn0f3yhRNPLSCdntCkW36TTz7dPx43psn+BO8MXcXbpQ7cw4hDaTBQVmYv2OjSo3dfEd3XhKQ283tQva61UtliqULWXglm7GkLNfMgYLrVYkmpEUIKzlY2v1qZWFwlDnEwIpyR77+F07/tqtVYTMWKwBqJUbbmUYUWUN8FxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QgtG7xdf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42011507a54so13943595e9.0
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 11:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716488593; x=1717093393; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T0KoAdrCeMFcRSCQt6aCHjBcz1Lyjopl+ImFWGgoJ3w=;
        b=QgtG7xdfyrrG9oXgNjuPaCgxPCnpTacfJKnKnFdmX4+NfQmgfDMy7oeVeHkQLPDc1M
         wDIP/ySG9RhyjBuzc+evjo6pNBgYoNp7El9C1NYSSRVDOfAKfRHQKtXDzLfny84QJNxp
         pBocDIbMicg9/z1swDdDrRVJsGD36nPi7z8VIejNefyRiKpIhwHZOnNgP6C8e6H5cw3D
         lQB/42/LvK4QKqU3MPQlgKHIzY+6PMcNPAVGW3AMI/ANZdNGhp8NjZ3VurnznE4nWugc
         eGyOVNP398HMVYCVw1V7VZ4uc8/N4Ja1ysaxkhp7xtGBptZpiyyYGzdYl2vKv7bcxmSa
         mG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716488593; x=1717093393;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T0KoAdrCeMFcRSCQt6aCHjBcz1Lyjopl+ImFWGgoJ3w=;
        b=QzPc14ulJQmB6zYPWKPXjtmKbLY+ZPbYeVQJwYloGAr7h85ejnVT1Q+CMG6xW8Avcw
         64ok8O2AmV5up5ATLW30rtJjU51YEQ+44HZuNcPt896uOw7cSuP8JxLapfPC41hYPpbj
         x+AbAdqi8aUOrY4+Vif73W82TFl0sHSJJsjklzQM9XhjUawQ/A28l9LpTwqCOOVKD9as
         yFl5d8s6UdhOX4t3F+bs2cwPsaIxLSjS9MvUxoFy+zKsXboRNPk4U8m2a+U2zj8eHGv3
         +J6p/GERGP1UonEHfoq6Sq4C9iKQMfjdV36VylWDiKmP4Km0oRWrQFwNbbD6lE5nGtgN
         kEzA==
X-Forwarded-Encrypted: i=1; AJvYcCXkLF7Q7RRzIp573oJA5UXJ7637U0ua2socoBumh+Vf+tz+jJP/RNkJUn8P2XrdP7zJc3AA1nLOnfm86GqU8KJDa8npeM6Z
X-Gm-Message-State: AOJu0Yz+TPE8BbMfYFxiYmXVddk31eB6GpCxsOQ0v9EyjAJfNmHe0UW8
	oS69Q2MF+Y/KY6Q78ieD1T7SVxqyDsTFsZU3dMEZ924ewO22vWvum60Fhs82avYhtrNUMBFwNXc
	N
X-Google-Smtp-Source: AGHT+IF2EUkBbtjoxY0yn3TjeLKgqYZNDfBbPj7Rfpf6qhx+77pv2KbhnygJndDp17D3vM4GOa5WZg==
X-Received: by 2002:a05:600c:1c24:b0:420:1a72:69dd with SMTP id 5b1f17b1804b1-421081b9359mr1928915e9.10.1716488593136;
        Thu, 23 May 2024 11:23:13 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f69850sm31273065e9.26.2024.05.23.11.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 11:23:12 -0700 (PDT)
Date: Thu, 23 May 2024 21:23:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dan Cross <crossd@gmail.com>
Cc: lars@oddbit.com, Duoming Zhou <duoming@zju.edu.cn>,
	linux-hams@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4] ax25: Fix refcount imbalance on inbound connections
Message-ID: <61368681-64b5-43f7-9a6d-5e56b188a826@moroto.mountain>
References: <20240522183133.729159-2-lars@oddbit.com>
 <8fe7e2fe-3b73-45aa-b10c-23b592c6dd05@moroto.mountain>
 <CAEoi9W45jE_K6yDYdndYOTm375+r70gHuh3rWEtB729rUxNUWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEoi9W45jE_K6yDYdndYOTm375+r70gHuh3rWEtB729rUxNUWA@mail.gmail.com>

On Thu, May 23, 2024 at 11:22:43AM -0400, Dan Cross wrote:
> On Thu, May 23, 2024 at 11:05 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > > [snip]
> >
> > I've already said that I don't think the patch is correct and offered
> > an alternative which takes a reference in accept() but also adds a
> > matching put()...  But I can't really test my patch so if we're going to
> > do something that we know is wrong, I'd prefer to just revert Duoming's
> > patch.
> 
> Dan, may I ask how you determined that Lars's patch is incorrect?

The problem is that accept() and ax25_release() are not mirrored pairs.
We're just taking the reference and never dropping it.  Which fixes the
use after free but introduces a leak.

> Testing so far indicates that it works as expected. On the other hand,
> Lars tested your patch and found that it did not address the
> underlying issue
> (https://marc.info/?l=linux-hams&m=171646940902757&w=2).

Yeah.  I've said a couple times that my patch wasn't complete.  I keep
hoping that Duoming will chime in here...

> 
> If I may suggest a path forward, given that observed results show that
> Lars's patch works as expected, perhaps we can commit that and then
> work to incorporate a more robust ref counting strategy a la your
> patch?

The argument for this patch is that it works in testing even though we
think it's not totally correct.  That's not really a good argument.
Like we can revert patches that clearly don't work so we could revert
Duoming's patch, but when we're adding code then that should work.

regards,
dan carpenter


