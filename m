Return-Path: <netdev+bounces-195490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E1EAD074A
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 19:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57221890FA2
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 17:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAE5289E12;
	Fri,  6 Jun 2025 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNKd3Yv7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9066C288CA0;
	Fri,  6 Jun 2025 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749230372; cv=none; b=Dn6CSr0NVgvdOwQ5uVTclXFPYJBaQcllbE+nAwsXuvriWUZWQTBlWZa/7WI/dryKUf809Y1ucg4Ct2HKDRvduREtfFXug00tao+ajOlZZzibrlB6Nl32/v6atxTNPbJBfhiLRia1MAeyBaJrBk9R7i7GUGkXphzlHpnIvf2lRY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749230372; c=relaxed/simple;
	bh=x6laAoy3QD2K+2/AJoLXGeHldfereL54lffctppYl0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqxj5V1J3IqZvtbRokzRexPNHWxgpGtVp87DO2Mw/iz/kPfvJYRaRdST8369Z4ro+eL9RLfZsm5rqf2RAmAbXnE/8gzZH4AvihhXvWQojFC/cm8tqLHlwFEoNv1pC6cn0jP9a/ZKrjvzyegLajlMWpREksgcipMnIh2Mg3wFMw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNKd3Yv7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso21869595e9.2;
        Fri, 06 Jun 2025 10:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749230369; x=1749835169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NzYcJ7Nj5b2zwcKVWL6Rr1IRHpMp8BCZe/bISvoFqd8=;
        b=nNKd3Yv7KY5tHztN+k9eIbGdCFCe0oQnhctQ0M11oBdrNZmqxLX4k/dZHEey9S2J9t
         pcxtXSTNgtqXi27c0aoRE41Ytls44KkZQcKfNPGBeQc3Bp1FuAERkyF+b5bPOGQJioTC
         /IwcfkgnKsDOHV5g+T7P+piCt4RnJCKEZwyza36L3QviJQr33qvco9pjH8D0T3POZ7PM
         jrTwuZ9DcpS90YjQYP6vIxVfbuYbImvgVSif0XB9Lf38LIotSDLDcZDtAjtsQ5ZMhw/W
         sCjuCknyIlkaMWeBBTYgfCa5i9swIWjA4TpM/6au3ZkSzOyy8GVWUg5wHskZxOFZpNft
         iOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749230369; x=1749835169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzYcJ7Nj5b2zwcKVWL6Rr1IRHpMp8BCZe/bISvoFqd8=;
        b=UT1ld6H5dQ7vHIG+sZbqBMGlGV0whFPSX+dMcoEzkgLE3++8lwKTNuuV4nu51VGShq
         8aR91OJnnk1N8fNxp9zA6DH0wybloXISBptsRkitQe0E5SgraV6TcErvJhSavEc/2AZh
         y1RBXLmGSvlh1nGqbmnPdQLjKiQZzq1YFQXBTnCFOwEm54lPN5ZT/r1q6Na5KOWLOa3b
         oirZhCjW4ln6oKE+C/D+5/kl6pHpd0rcx+IEZ3CDjxoO2vjCwo/wdJr9r/KiweC1ID7n
         axw6CW4HvK9/QLknFIjOyGppnfanldhW5PH3CSJDXqgqK2P1sH+b+9kYxCx/dgpBS6LK
         DY2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUANl1aEMQzuDLuXUany/Vh4yLQ3lUdQxyRYeFAzi3FwJsbZeMY2mcLa6PDsy6tz0zqsX2OPVF4PsvS7YA=@vger.kernel.org, AJvYcCV52F2W0uCU8IuK7ijRY9LRqGq2+fYMrG+r987YHIUnjd3LJq6ZT9pmrVcTD4lwS5pDVdKag4A+@vger.kernel.org, AJvYcCXZIPrFJCjUC4MSd4q01jNMn5AiqJLI16TC7PaZc3lP/Z/NqxjGUo/jtc2Cg6uaPwgTFQNY9mCzj1mH@vger.kernel.org
X-Gm-Message-State: AOJu0YwhgKg93NsaNRMZ2jPs0T5TFDdLPA6w5eiB4+2qAz8SJuYYohOI
	dVmuYhnr65fvYf3hsCq3mVD6kt/h+x40kg+sjuOSqMs6LraBYf51flPi
X-Gm-Gg: ASbGncuvB5OZ5QhcjMkfpG1QO06R6V0GPUQvb1ZA5tFA2yb9e/XRUMUYjrQHgZXpNw/
	d70qIuBAykmj+5j5IOwPI5uCPM8Ot3AlegSyqvv9aHbDZlxI62m8jUfXyU9MzQpqs286Xvnimxb
	bfBHFoIo5c15hVn4f8ZUbckQEuuP+82egkQZ7BJPZGRH/Mf7o/uRelJVN7rj8wWaDWvi9mAvV56
	MVnrmxFsXgAPu6DeDjZPS14CUKtFdUEFwNQdhTX2VboMsOYG6+A0y1hzyD1BLRQ93LauCZwnND4
	9KByhdadOlxkllmnd1fLyXuHN+q6BTuV/i0yUTcoJ0KEdWYBEQ/XndSQVQfY
X-Google-Smtp-Source: AGHT+IGNgMP5C9900vobDulHCGStzylMDLNyV3zE2D76G5K6z3KVUNBhpwPmkrC3Mc6l9hShfAhLBA==
X-Received: by 2002:a05:600c:3b0e:b0:43c:f8fe:dd82 with SMTP id 5b1f17b1804b1-4520147f41emr47574495e9.18.1749230368682;
        Fri, 06 Jun 2025 10:19:28 -0700 (PDT)
Received: from gmail.com ([2a02:c7c:6696:8300:44e7:a1ae:b1f1:d5a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f82878acsm35979185e9.0.2025.06.06.10.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 10:19:27 -0700 (PDT)
Date: Fri, 6 Jun 2025 18:19:25 +0100
From: Qasim Ijaz <qasdev00@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ch9200: use BIT macro for bitmask constants
Message-ID: <aEMjFjQo1QZoKEXw@gmail.com>
References: <20250606160723.12679-1-qasdev00@gmail.com>
 <486738a4-c3ea-4af2-ba78-53bf8522ccb1@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <486738a4-c3ea-4af2-ba78-53bf8522ccb1@lunn.ch>

On Fri, Jun 06, 2025 at 06:46:25PM +0200, Andrew Lunn wrote:
> On Fri, Jun 06, 2025 at 05:07:23PM +0100, Qasim Ijaz wrote:
> > Use the BIT() macro for bitmask constants.
> 
> What you fail to answer is the question 'Why?'.

I made this change mainly as a small clean-up, it makes the code a tad
bit easier to read.

> 
> This driver is old and stable. It has in fact had no feature
> development work done on it since 2015. All the patches since then
> have been tree wide sort of changes.
> 
> Most would consider your change just pointless churn. It does not fix
> anything which is broken. So why make this change?

Yea that makes sense.

> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#clean-up-patches

Ah i see thank you, I will keep this in mind next time.

> 
> Do you have the hardware? If you do, maybe consider porting it to
> phylib?
> 

I don't, I did try to buy it but after searching for it but I couldn't
find it anywhere. I do however have the hardware for the this:
 
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/usb/dm9601.c

Would the phylib porting apply to this too? If so I would love to work
on it.

Thanks
Qasim
> 	Andrew

