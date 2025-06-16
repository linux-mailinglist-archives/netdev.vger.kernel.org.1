Return-Path: <netdev+bounces-198120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9F7ADB526
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 17:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9DD18847BE
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68D31F3FDC;
	Mon, 16 Jun 2025 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="yd9Tu8Hn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C65E1E501C
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087290; cv=none; b=JcSKKaZy6FaQXOfcNAxEojlIFT+5bLWRo2qJ68tV6gdEQ/ky5r6u6Y233qHewR1Zvk8SUtA+hnnrLXmbPglDV/fbE5AF9rroTmPrSM+uEAcBhhOSIX3ARgYY8NIx8UkvwnEyXaJGPKMy7ZnqsPnnKFd7hf0m6hnNvB5KmZYR1D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087290; c=relaxed/simple;
	bh=lVOaOw4puZ+d2S69mpBnuCByxyPmH7NGfMU2TEKOLnc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G36T4amHQMEjdl1V6jMT1n5NOU80Y1Ggq7B8lYVbo4bzyyqHpMZC+Y9czT0WyxfT0MDQKJLFyEk+kMlAuw0aR3X0RPrK/nBjERr8oIZM+jtPWKReL5zqO0l9w+VZvDigO+a77dBQVp/DtqR0U0/TYcfB4C4hMWRjvAHcQrGedaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=yd9Tu8Hn; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4531e146a24so28953965e9.0
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 08:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1750087287; x=1750692087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a+DIwXU2L+60g8uk6ftsIvso91a5Gq0Tzk23jdDrW4g=;
        b=yd9Tu8HndsGCaG3EaMcuwICN27D8NTKvK3xrPoY2u6kU7f7Zu7+F/vOI5W1Hw3yso3
         Fpy7XjstEeJ8V1UaagRWPYEFAHxe2iqYMc7wm3nmrTV9rwMlTLQxS8Y9aICLMkvxt4RM
         X5DBfffZrtvYOyTBHtSM61el59QdQeM7q4AFUc/WY6ShTRfgD0qwkDgn5iISazXzHBfx
         LUTE/GyJmnDerc9RA7M0oGqDtgmrT/8SNOafbiNy4lm+an053rhOHj3uaPCd55MyBbw9
         DZ9Kbh4TBporpCQJqsWu6tSO3d+U4t4k/7n4HEMcTpEgFPmmksxPBpsOFj2jJ7KBPNzC
         44EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750087287; x=1750692087;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a+DIwXU2L+60g8uk6ftsIvso91a5Gq0Tzk23jdDrW4g=;
        b=eRgV7O5sxf2wf3y/igkOUF3lhtiLPURkZeOy42TjwYbPjo9ZWxVKqgch+/PXReY3EX
         cwdqDiDtm3/hG1Wxb8GpJ04FY8REmw7V1JTRUPNxgBbiTQk2mxWIU4HRqyYKw30KW3Dr
         VaKX2cXx0hNWL6b41CMOstYbNL/SAB0k9ULmUqYCvEbFM4LIU6a68qhQa+cBv4FPB8Du
         neXx6ODvzgyCnyeVpChuirjz5BWE1vrArl8vVvffpu+7UhXK3pvdWusvWuuVnZ/zBiKu
         dO2uXJTu/fLIojg5XgcMC99Qb0HlEFNLX2ya4bK03V8Tm0lvdasE1yIkwrS4hcZcHQQY
         f4bw==
X-Forwarded-Encrypted: i=1; AJvYcCWIzxOwvGcYrYjzoQ8NTVlGWiWcShsgJ6gTA+TbCLVvYvPFSs6/Pqniln+9gwmaJ4sHOzBh7p0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVTepw60IG+zLaaQq+kB6q1SHqCLpxI5u+dbDzEGz0ksfFFO65
	rjHNeb+6ey1WvKO61gjHjxizkLDTGiCc1FH0A3jhTfw+aZcO8NG/Jx+zgTgiy5ndgZpYB1eLkIo
	CXs+HNr8=
X-Gm-Gg: ASbGnctfg2+zeLEnPAfGRP/jD1EVPd2lF9r9DRkku3paW48MlNQQAmnEZTtSXPHXAfk
	gdhKLHi40hi0FGNvOWx8bNvGNbW7BewTcNEhSkx1d02OPerRL4TSqoTkdxCUpPHbvZiwpOLCKTl
	sU+Jv+jczFNhujVPLDSqHWq6WLiwbp/UNEIKuHYOMt78bRsQ8HTaJEVCBZfFcdbasHftpheqq/2
	+SB6Cb6xfgPB9rEp3TipxLJ4vt0kMuCg1MCJpmOy9B/0Zde0AluhsYybuFt6Ko645Sy9Q5PuK+d
	5l8+eq4TKz22SlDvTP1Gm8vvlqzabWCqaQKcmxvDJDuJJK2mFmCS3wkzNJbmOEJPLkM=
X-Google-Smtp-Source: AGHT+IE+n0zcSmOYsebqtq7TETsjNPxycut/07W32TCEdCIwtKSu5T5aSW+1wl8qiRDR+g9UNxIPgA==
X-Received: by 2002:a05:600c:34c3:b0:43d:42b:e186 with SMTP id 5b1f17b1804b1-45343f2520bmr59719565e9.8.1750087287293;
        Mon, 16 Jun 2025 08:21:27 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2449f1sm151786325e9.23.2025.06.16.08.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 08:21:26 -0700 (PDT)
Date: Mon, 16 Jun 2025 18:21:23 +0300
From: Joe Damato <joe@dama.to>
To: Dave Marquardt <davemarq@linux.ibm.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net v2] Fixed typo in netdevsim documentation
Message-ID: <aFA2c96O-VFXms3G@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Dave Marquardt <davemarq@linux.ibm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250613-netdevsim-typo-fix-v2-1-d4e90aff3f2f@linux.ibm.com>
 <aFA1seeltkOQROVn@MacBook-Air.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFA1seeltkOQROVn@MacBook-Air.local>

On Mon, Jun 16, 2025 at 06:18:09PM +0300, Joe Damato wrote:
> On Fri, Jun 13, 2025 at 11:02:23AM -0500, Dave Marquardt wrote:
> > Fixed a typographical error in "Rate objects" section
> > 
> > Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
> > ---
> > - Fixed typographical error in "Rate objects" section
> > - Spell checked netdevsim.rst and found no additional errors
> > -
> > ---
> >  Documentation/networking/devlink/netdevsim.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> For future reference, since Breno gave a Reviewed-by for the last patch [1],
> you could have included his tag since there were no substantive changes.
> 
> In any case:
> 
> Reviewed-by: Joe Damato <joe@dama.to>

On second thought... this should target net-next (not net) and should also CC Breno.

Have a look at:

  https://www.kernel.org/doc/html/v5.16/process/submitting-patches.html

  and

  https://www.kernel.org/doc/html/v5.16/networking/netdev-FAQ.html

