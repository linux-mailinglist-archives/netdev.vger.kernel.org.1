Return-Path: <netdev+bounces-245252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 59929CC9B76
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 23:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2485D300D556
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 22:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E0531AF39;
	Wed, 17 Dec 2025 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlS+9TqY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867153191BA
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766010724; cv=none; b=mO06+6uqKgeXAxdozfwwhk+JUxVDpcg2XyYD75sfttBbNoKEgSZ8+LURdFylafIAfMEUaLVQSgzdsBDTw2d+qMxKw1Tthe+oW4yrYEJve1/NcTqKIIZThcfuy7f2YXL7INn7yKlrP6TEy1gxPcqx/UhJfGYfww73WELFUAnN/3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766010724; c=relaxed/simple;
	bh=T0qprnyzkCqllee0y3moUHDkLXu8Ov8u+m2G0gde7TI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSuvhsQ3lqoWF/+/Z3yr86TG7p1Nz+2GE/BuS22m3EkTwCLs1lVPkGFvDRy4eOjHs0vQn2YVCMmIKZHw3bWNb/yvBv2PFRFcHGlAeoSzEqaezV3FIlYVBYzmjextQQ3fYkYlTJmmIsNPCzyP6BKuhhgKFdSOpqxFr316b/0RiUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlS+9TqY; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fbc305552so3833507f8f.0
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 14:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766010718; x=1766615518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9xZC3AkWLvoYCE+LC0bupKfq74kKT5/LfsWMU3Z49U=;
        b=BlS+9TqYrE/HXv66I+FpgfH/iXbVtlJjxxSwpUJmz2S0iREc4gPZMlCsqGgK1jRQkq
         34HCZGDrIk+0SXRmhtIIajeZcBo83Ym5128v+1/pryMtVN52ZV6E2Yx3KFLXoZhSRLkA
         ysPR0gFtHcm1gq7Ig4K6qlbCEfmOg7AcOVv3/GdRyh6ATWzttzQFED475a+YYRgS7YLD
         aMViq+JF2yJomUMr3Sa+Ke4JT7rcQfCJSj2ccV657aJfXtWhK722T8F5RSqTATLKolo3
         wAejyZEa0vxTckStDoY5bgZeFsYoIwfP1BXnnPgP/auayZ34xTMcYhpS3k2sda7x1WO6
         0VNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766010718; x=1766615518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L9xZC3AkWLvoYCE+LC0bupKfq74kKT5/LfsWMU3Z49U=;
        b=V5Py9tkPmN3DAXKppiBUN25EhQ6hxxiq+HuUKhJY6TAPVzN21Ct932+lfB5R8vDoB2
         KK8ROxuVowC55dT598KztW/Du3vPMF4OtgGPgM1dyaZk8jwoDeWu1ni7NjKMlAKuvr1s
         5C0+9RCpVGOdQXXJMfGtwvJq1QWXGxcWrerqv7ZDIhHjZSrEWwC7SmFf4Iskdfa0n1AQ
         mwoZs3uMHwQEbmnux0Vi4317xExC4XkvFOSgszOPGfBxKKUXfjG8jtKQ2hu/+30xdL0o
         6ovANHPZnjPKmiGbaVTyERCMVzICRVDCky0lmJ27VmHykXdYk6t1BTbe4RgsXn9wwDip
         QUHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq6UQN2BHLwuXqjjgaQ1Q7DcWUHic1ux41cnXeM5NXAVxlvX5lB5Q832Ntz6Lgt6i9bs0PFJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhLMLNIzdycyuQjoLMLFkOFTEwrB8LWsMk1Cep/W4C9NCoT6WM
	hn/lKlEbTU/Pi3l/cv5N0TVJxswgD8yqitp/rXMF1DyIH9SUPQf+yluY
X-Gm-Gg: AY/fxX780TznGltu/lqdBxyAf9dDaeHsx5mzgVSa6onp882e7dEhue3LR3CGI+POsMO
	DNA5yX9TCptD7GkT+WR18KRvBlpGcON5chfiWc3lXx6EKg6rW+3GUw7AtQv6Xjk2XZL1PMlOxk7
	gjUKO92GZsdBXdeonkdR7nzhcDSgF4JrKgMGQVAD2Fd3jHQK++0LORQlCryZXpvRp8GDLylyq8s
	q+gCgEhjI2H1/2VslnNkVJYwNM3UMzBC30rCWF6AoNWw+6uLmo3IJyHFvoyfZJhpjV1/G0yYV/h
	ad/7oKAapY8k5E57wXPnZWXfxNehxFsGwaB8SICF82XG8hz0z4tLd+J4C0xKwO/cmjD05aPkV8p
	Jce+XxbVil45ssWlVXZLZ0Y/x17ZuYfeNp6CUq13ufOAakyfg9Y94sJEcbFf4IvMmc5RppHXbQx
	DVclW1/yRw2iVD56StnzBQ2gHaXjUYf4CuZcIXCOqRaxTFK7DZ+cPf
X-Google-Smtp-Source: AGHT+IGAjtsCe1CgOB6Bh4/hmtqRmC0JIqrqfOPjJTopW3ABFAivzVOgBF7fd2YchRnO35zq0uHieA==
X-Received: by 2002:a05:6000:2311:b0:430:ff0c:35f9 with SMTP id ffacd0b85a97d-430ff0c37damr11656138f8f.48.1766010717494;
        Wed, 17 Dec 2025 14:31:57 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324493fda5sm1364377f8f.17.2025.12.17.14.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 14:31:57 -0800 (PST)
Date: Wed, 17 Dec 2025 22:31:55 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, <linux-kernel@vger.kernel.org>,
 <linux-usb@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Crt Mori
 <cmo@melexis.com>, Richard Genoud <richard.genoud@bootlin.com>, "Andy
 Shevchenko" <andriy.shevchenko@intel.com>, Luo Jie <quic_luoj@quicinc.com>,
 Peter Zijlstra <peterz@infradead.org>, Jakub Kicinski <kuba@kernel.org>,
 <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, "Mika
 Westerberg" <mika.westerberg@linux.intel.com>, Andreas Noever
 <andreas.noever@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>,
 "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v2 08/16] bitfield: Simplify __BF_FIELD_CHECK_REG()
Message-ID: <20251217223155.52249236@pumpkin>
In-Reply-To: <20251217102618.0000465f@huawei.com>
References: <20251212193721.740055-1-david.laight.linux@gmail.com>
	<20251212193721.740055-9-david.laight.linux@gmail.com>
	<20251217102618.0000465f@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Dec 2025 10:26:18 +0000
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Fri, 12 Dec 2025 19:37:13 +0000
> david.laight.linux@gmail.com wrote:
> 
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > Simplify the check for 'reg' being large enough to hold 'mask' using
> > sizeof (reg) rather than a convoluted scheme to generate an unsigned
> > type the same size as 'reg'.
> > 
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>  
> Hi David,
> 
> Just one really trivial comment inline. Feel free to ignore.
> 
> Jonathan
> 
> > ---
> > @@ -75,8 +59,8 @@
> >  	})
> >  
> >  #define __BF_FIELD_CHECK_REG(mask, reg, pfx)				\
> > -	BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >		\
> > -			 __bf_cast_unsigned(reg, ~0ull),		\
> > +	BUILD_BUG_ON_MSG((mask) + 0U + 0UL + 0ULL >			\
> > +			 ~0ULL >> (64 - 8 * sizeof (reg)),		\  
> 
> Trivial.  sizeof(reg) is much more comment syntax in kernel code.
                                     (common)

Hmm. sizeof is an operator not a function.
Its argument is either a variable/expression or a bracketed type
(I don't usually put variables in brackets).
So 'sizeof(reg)' is nearly as bad as 'return(reg)'.

	David

> 
> >  			 pfx "type of reg too small for mask")
> >  
> >  #define __BF_FIELD_CHECK(mask, reg, val, pfx)				\  
> 


