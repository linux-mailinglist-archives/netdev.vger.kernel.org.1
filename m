Return-Path: <netdev+bounces-162792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3C0A27E6A
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 23:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D73E77A1766
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E854921A446;
	Tue,  4 Feb 2025 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLB5g6Me"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC62204F94;
	Tue,  4 Feb 2025 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709179; cv=none; b=XD+abgZfb9CUCbj+HMuBhAe5Vzm1kAUhVMCA+Oi2nipa8CpIqDxiF6rJfnv/xn5RjizuPqxtr6fXhGTJtOZd9imgPlIFHVqw+kaQvsNWjNS4adiY7tJ8amjZvf4PpHUfMeHbgaTO2H6KRBCtVrQnEoEUEV9eRkVHfp+a52T4uv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709179; c=relaxed/simple;
	bh=4l5qtFI+5r2dhzj/k6xDjkZqRF/xI07K8S1Gcvh1Q+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcqOMUJlletps40QR7OOHCVuahEVQeVBCGsmiV76cE9sAmA8yz6eWc5Y2xOH6Ga4SBV+hLVI/mW3s6nX4dNUwDQD/PFM08pyYkkHPLJ6LzWJWrmnSk/KPdR8XvE7exV4JG3TzoGXNyDM/DzPlR5dYV/HNxOnxjlngR+PBeK1cMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLB5g6Me; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38dae70f5d9so635948f8f.1;
        Tue, 04 Feb 2025 14:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738709176; x=1739313976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tt+CBW2LvYos3Mcns35PKRqc8bckhvK9KyHON/qBnYU=;
        b=cLB5g6MecrYfTl6DIAj+2gy+vao/kbm39SfjfbZzZENLyATHjBTwVmbH3FqrQHG/be
         CzCZrdU1r2tmbkpALC3F0womxZNpDc8KOvDZ5ToIAkLBmEVieY7Bwlt+ogmclomVsDeM
         URG1+Ngnk0GmmlLbU8M6Spyc1nK+knTG6N1GvxyeSiR1Y2J5Vy8mTIv2/psxSxdL4mh9
         I34VGjgrWqnnGDnwWhkj8Am/R+A3apjYw0th2zvdnzV1VYDIAO2PIRHj+WvEW/4uyiVc
         F4cG6zxiufmuy1FdDs0REVLC11IukkgwxBXQGxNLQFypsTFCgfMvC1P4W0FGcmZUT+nu
         JzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738709176; x=1739313976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tt+CBW2LvYos3Mcns35PKRqc8bckhvK9KyHON/qBnYU=;
        b=SiLnuSa1W3EEtb/JWLrmfvVWoFuwuntJSr6SjtLkCfZJmLMaqv8UFmzEfK5Y4iFHht
         zUJzuO8vW5EWc8NYr7wCPwP86jYwcsbpQYC1Mrl4qR0M7IhzVbctSsGWoX5U0WSPA+pl
         W3pQuDCgW3N1mQ1sbbtSUlO9a/kKBaJQr7D/3Gm/SKpTTIlpQf8Evg8K5nSyTh7f3rhy
         NIt9vPWCEl0uC6iBztOZz5jFaF75bze8lhp628K095HgvyIYttQdLNtFz+2VjVDX9Shf
         0c9uHtQcEFPUARlTiYlTWzthgBTJZqGWs4Gn6gJKuI6VCyrNILWXZHmzosgY6eEJaY/v
         jwDA==
X-Forwarded-Encrypted: i=1; AJvYcCUZqAT+EcoFrbfCnfpfh0efwkdRtD5kmUFRSCdpCN8peIkauoxUcT2N6rnS3wBaUsZdeZmHB9jVbQcR@vger.kernel.org, AJvYcCUeNgDsja40S+A8I+iSlXodyozo+gzY2+5KeRd/VY1zCOqoMc97yzao89pqTR8C5HQaW4Q5InPa@vger.kernel.org, AJvYcCXJUvQyF0WuUArSKhOqLwqRGxnoOecmM8bzU6f2b8QkOpdznRjoJEhrbfTOg9mwhcnOtNugCgwyQI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXRmDUtt7pSatOFE5ukdbXyK1+XVT7MR72Nal0raRxvkyrRzB2
	xPFKkcJTDnQFNmtNqR+5oc/EvJAYRCpZWJDsE4Hz7eDfheXKG1jW
X-Gm-Gg: ASbGnct5DNHtPibV6BuxhC5z1CSXIKNexQdu+aOiMccTZtZK59FFl85uq6Q1oAft9Kc
	CJpVrrC760IBDV4SqLbIz0JUnWIV7Qn8gkBvBiVcjZGpszI0QojvDcYDLMZtg0hB37JIyqaNPOX
	JIq5+HqrntoTITKK74tE9uHaXnTuMHwOpWj22v3D4CLdkSnbYkLcaMa/DPh3SAInKQsQehbqi98
	gFKLv8Dqy4X3vuBhmJ1TFv3PDXByi9a4Whshn462iNu+X5tQWYF5d+DhPAhikGtk3t13HsYmbTn
	M7NUsKiryGLm0BN2G1RSfF3OIHvsaOFfa10jtNNNpY2oPDkJy+fBuQ==
X-Google-Smtp-Source: AGHT+IGHQr0UqcWS1oxDPytTjqk1W2koAW8DrAz2ZmlNnUgGZv5GOxgxgtgrSisiG6PNWZt+uxbP8w==
X-Received: by 2002:a5d:5f41:0:b0:385:e8dd:b143 with SMTP id ffacd0b85a97d-38db487375amr321169f8f.19.1738709176171;
        Tue, 04 Feb 2025 14:46:16 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1cee41sm16775035f8f.81.2025.02.04.14.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 14:46:15 -0800 (PST)
Date: Tue, 4 Feb 2025 22:46:12 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Simon Horman <horms@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexandre Ferrieux
 <alexandre.ferrieux@gmail.com>, netdev@vger.kernel.org,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net] docs: netdev: Document guidance on inline functions
Message-ID: <20250204224612.766689a1@pumpkin>
In-Reply-To: <874j1bt6mv.fsf@trenco.lwn.net>
References: <20250203-inline-funk-v1-1-2f48418e5874@kernel.org>
	<874j1bt6mv.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

... 
> > +Inline functions
> > +----------------
> > +
> > +The use of static inline functions in .c file is strongly discouraged
> > +unless there is a demonstrable reason for them, usually performance
> > +related. Rather, it is preferred to omit the inline keyword and allow the
> > +compiler to inline them as it sees fit.
> > +
> > +This is a stricter requirement than that of the general Linux Kernel
> > +:ref:`Coding Style<codingstyle>`  
> 
> I have no objection to this change, but I do wonder if it does indeed
> belong in the central coding-style document.  I don't think anybody
> encourages use of "inline" these days...?


Apart from the cases where the compiler really ought to inline something
but fails to do so because it doesn't notice just how much code collapses
out.
But in that case you need always_inline.

For instance get_sigset_argpack (fs/select.c) is marked inline but isn't
being inlined by gcc 12.2 (clang 18 is inlining it).

I've also seen places where #defines generate much better code than
inline functions because they get processed much earlier.

	David

