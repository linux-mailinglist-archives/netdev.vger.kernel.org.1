Return-Path: <netdev+bounces-198118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C76ADB51F
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 17:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E244B16F384
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797D02405E5;
	Mon, 16 Jun 2025 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="N3jJYFLU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A78221736
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087129; cv=none; b=OqWCZzUPSU0U9bMeHDcNRJ8KTFUZL/XERGxD7Tgdz9nx15dPK2BSjmZ33OuL1CnE2X3aAMqerFup0Evukr7AJrijO2dYIyPpltjyYMVKkeApRIVRRON8niuQhW2ZIcNZuluDZ5VwiV4wvUXKSeiNVoEVMyY9d2+04UkSq5xdiMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087129; c=relaxed/simple;
	bh=39lxUy6Kl7N8Xdbo4R0KJwypS0sdGBPvBueU7ohtNYk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=layDkIxV63LM8W5E4Ge6c+JecxYWQ3M4KnIsaKHM79oyOOhuhZn4bslsklIzlRLlyE9GeT1yXwdpqK0c1Abm/rdks6OBGi8QW28Zj3t5lujMaJPXEaabfbrwNgJmA9hFt8hBPLtWd6BUgCPthfpRrN9kx3FI+ekZeZ16tOAc9cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=N3jJYFLU; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a522224582so2550207f8f.3
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 08:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1750087126; x=1750691926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v0AeV7KdBnWrsBf8ShQlZdXbD7DM9wx0kl8YAmF960o=;
        b=N3jJYFLUWeo2Ti/AeuGVbfk8Qf+g3JpuLjmnUWGLXu/uNoOVwxbEE/ap39N51ZY551
         7q7rMWryUQw7YvADWUF5nlNLS05FS7JfKG/XryhaFas/BDkeE/dk/AZ4RqPr58OcZOSv
         FP9mRgEpbJtq4o0P5dfRlDcmiDtyS3k6D1lfFEL7XvLnLWZdIp9AXjK4unTPjVP5fOzb
         QaIZMBL0to/tXuMbxGg6yaf2LQ8ioHkcRf7WIRVXS1u5B//ce8byyAE+PFKg0ach0puZ
         8mo8Wn1P6W6ZlDwZZqzi1eLB/dUjByJnbBCgoqs24QenOloV61F/gUIKcuEvzh+jnX0t
         Axxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750087126; x=1750691926;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v0AeV7KdBnWrsBf8ShQlZdXbD7DM9wx0kl8YAmF960o=;
        b=XGQ4etufOGa4Ea32I6kRzglo3XF+Q8PNrSftsthH4G+D9wdd9lcVEVeYyq4Oi5elo+
         4f7SmoCX+qjCCiBDcCvx7JcO3UX7dGCeJQhxHGPE0NXU+rRBrO4cGeBrcNchd+R0HVaO
         Ugvc/pPwPbGZH/MkJ7slLwKsjSyJjsqsnEfudmRJUO1cmJyS8xFm/aXMfVtLp+rwjsVb
         wiuIDz9zaQwF+5KiapcDH6ab1aQaxnh6rILwyWvDM8FRkPrxnuAPqIVMMkJOqsrWatW4
         Rkq8JMuWsWhD+zvWvLxyeo1Scnsg6xwFLn7Z+gbVTkKAIbzi3fqOD7G+bKVjD/IyNypq
         m18w==
X-Forwarded-Encrypted: i=1; AJvYcCXS6J6sm03VXXeLhJ3YPIoK3eri20FnIaOTpdzdh933yPv7HbDyaQdMlFTbDIah4b7GfqdrVfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5GEABGnr1z5FH+r/i/KG5QXiFhX648Cb7IfaOSbqIuowaP50H
	1qs62gXonnkxS0nVymKtlb/clUsUdvRoQCHx8ehPa7jZ0JOXrzNF+4chLohAbfWfNgg=
X-Gm-Gg: ASbGnctZqvJt+sfari13v/S9TN/vUZFT8zVNoctg+DoOro9I8f4Ur+1JzIHjJzA4Xke
	ZYKlOBz7ELwCs2q90ZQzVNGAe2TD3n4+GY2kf6qOxnw9mHuNYfFjXdVwtsqL0SDvVfyotS/eqka
	nqm8krCIcNYwWN+bmXOX7I294FmmjRKO+GGQ/N3/yW6MCIfAlhR1ZgfhiC2jCLYi2JWggqAHqtL
	hsBhT/dZTU+avAWJ/3xTn/alwXgL1DbJBEGM1PRGPuuZGlXUs03+83untzMF9X+kGC59Pv+q6E7
	hLdOkgZNfBKPojlIZ9tGLC9TcFnk0KaxdBKSofNDlDQQ1rcvOupskd8+1j2ADc3lSGk=
X-Google-Smtp-Source: AGHT+IFX0ZSZPV0qrxkApKvU1oCOg6Nkng3YwhpdKQfoD8SyAL1k0kPcO80udoBw00i73oPsFxsD7g==
X-Received: by 2002:a05:6000:2c13:b0:3a4:d0dc:184d with SMTP id ffacd0b85a97d-3a5723a2d79mr8584059f8f.27.1750087126052;
        Mon, 16 Jun 2025 08:18:46 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b1bc97sm11414339f8f.68.2025.06.16.08.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 08:18:45 -0700 (PDT)
Date: Mon, 16 Jun 2025 18:18:42 +0300
From: Joe Damato <joe@dama.to>
To: Dave Marquardt <davemarq@linux.ibm.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net v2] Fixed typo in netdevsim documentation
Message-ID: <aFA10n519_VP3pOX@MacBook-Air.local>
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

Forgot to include the link:

[1]: https://lore.kernel.org/netdev/aEr7J0UbSFhJ0Zn9@gmail.com/

