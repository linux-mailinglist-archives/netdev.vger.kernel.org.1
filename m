Return-Path: <netdev+bounces-181057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2F9A837A7
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 06:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE373B661B
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE6C1EEA3E;
	Thu, 10 Apr 2025 04:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR7ftUIQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AC8F4E2
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 04:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744258085; cv=none; b=FD8EVHZAeALFEWk+Ifd3iCmY2ZExN/q1OWC50q7TngiLYEhckJ1rrzyJLbY6QMrmTVVakJQEe4IkCQY3iW1AB9JcjRvcTOWUXa8+7dOU35xvdXmIkUkiiDCBZBdud0xaaJNT5tf5UJKYcgalsvN22ArSmLitseYqvtYIDjULi94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744258085; c=relaxed/simple;
	bh=qLBlFSIeFrTNKs37j1BM0CJ0CgMLkJOWyCg4wkqijfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MY5/Z8V82LLlAqn8Zqv08VDj/YQeC7PfrC+AuFT+FojlPypnCCfvc0ihVq21n9eRQU8GKPIRS+DIeUAu0dfX0LxSb4WIOcBUBX1mcKNwpZ3YcD5VCXLYqXEUNfR6oVdhSfZwEyIy4PzAIhG3YZitD8XiobtH/rmjUXuIX4crWH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CR7ftUIQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so295888b3a.0
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 21:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744258083; x=1744862883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lprgBEmPY73QyKTvgOsAhH7ku1qJO3UMH0syLt+K+kE=;
        b=CR7ftUIQ92dxTzmbNW8yUfni+9O0K5G630ToO0blpCUs5L5NHaPEMJMS/OaqnkCyc4
         8LIzbvA0Tpz2UpIl7Wqpx0eRrrPURRscTMUojfko5O4FZ2kZ+yBZiVR48UcVWxyP9afx
         RMnLF/HTzBY9AAPm3i7PIr34ZA1JSJz/A6nMIWO4kDmPhXjotfaP4NLlZNWO5Ocknmqr
         vDMa6lztriFBV7B5nSUxqVo46zSW8Prm9me3zS0drW8ucv4qAOm2gK3LrGxT/BRvbjLX
         4QHASzvV0eeZGmyvfaDQ9rPkvnkF4dgP4k9DUra2r9lO8jBZEYQHMC8k/cGlQ9jN58Dx
         HK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744258083; x=1744862883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lprgBEmPY73QyKTvgOsAhH7ku1qJO3UMH0syLt+K+kE=;
        b=oP8TsgpkY7thlNbZF+DNO4HZ7suURWWCEtvN3D638N+y+NOEv/I4ynKJg+9Twfnv7E
         xa15bozFdhnjF8qH4aPHouZcCZ3EFj+BjS1f1HWyz5VRHjZBkNxNzdG/QY9brbPJN0Tk
         kPuZMSBSg4oODIGlVtcX+I/6K4QyTrmU8GKxIAGOX36mlGezfP4nCy13M1zQd0mxf17r
         FzsBX0qH+oL9+LDbU5tnodT0a95J0EQI3SMKKZrV7CN7oT+DQ/LG/jAISIMk0cB9KZGu
         MJ3oLeSxrvJVSIbPIBnj25EvItmrMD8PYOlRlyIwQtkkv71l+CURpql/0HiiVpkyzIqo
         skbA==
X-Forwarded-Encrypted: i=1; AJvYcCXBHFm19fIpIy3E/3sKrRUrkbXlQ9OC5L48IP+NRKGUJ3NRqC6NYXFNYG0ww2+vs1S0T5dq0/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvSwq7b+aogwFuZGx8Ss6BJMMmX7wDmlq3B233u+0r9JzAdFTy
	4jb+cFCBsylKi3DOXSC1W3YoLeEH206DnRlv27F2AKseCXq49nje
X-Gm-Gg: ASbGncs4S9yjZngqJT3UVaPwFLXmbkzaN3cN0DC1KGHNGgJSoxPjJcFylOEN65vs47e
	1EZYvGVhzCqvki9nvZH1R0aLvDeijSVuJ6Q0xLNcPkXMproMP1DhJD0R3pGKc/QSAbROB2EENvp
	fUzjlkCUZ3mKAp3/LwK18mfS2MPoMEwKPdVpgDQyTyIK4wcVSQ396bcwyIxV4QEfKkldN8pqrS1
	dPnorLPhsFLkRdKxyDxqhEC4lHd8lf8Slv3WDP0Z0iZEx+GLNu4u2inBW7Ae+A6E+2OyeFCC+gp
	20bj5sy1yoxWHrG+bRzDAyRqAESJ9tplcuMSAg6m+EUbEKZAJMmC5tVXJEaY
X-Google-Smtp-Source: AGHT+IHxXp+nsrloZBv+mDBjYp1AcBatuNevzAfAkMmZfwE6PNj4qqRuozrVOFXVjfSzPtoZkT7hyQ==
X-Received: by 2002:a05:6a00:179e:b0:736:a7ec:a366 with SMTP id d2e1a72fcca58-73bbee43c07mr1481863b3a.9.1744258083044;
        Wed, 09 Apr 2025 21:08:03 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d4676bsm2225564b3a.45.2025.04.09.21.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 21:08:02 -0700 (PDT)
Date: Wed, 9 Apr 2025 21:07:59 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "Arinzon, David" <darinzon@amazon.com>,
	David Woodhouse <dwmw2@infradead.org>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Woodhouse, David" <dwmw@amazon.co.uk>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	"Bshara, Saeed" <saeedb@amazon.com>,
	"Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bernstein, Amit" <amitbern@amazon.com>,
	"Allen, Neil" <shayagr@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v8 net-next 5/5] net: ena: Add PHC documentation
Message-ID: <Z_dEH9tKRCT0zOpt@hoboy.vegasvil.org>
References: <aecb8d12-805b-4592-94f3-4dbfcdcd5cff@lunn.ch>
 <55f9df6241d052a91dfde950af04c70969ea28b2.camel@infradead.org>
 <dc253b7be5082d5623ae8865d5d75eb3df788516.camel@infradead.org>
 <20250402092344.5a12a26a@kernel.org>
 <38966834-1267-4936-ae24-76289b3764d2@app.fastmail.com>
 <f37057d315c34b35b9acd93b5b2dcb41@amazon.com>
 <0294be1a-5530-435a-9717-983f61b94fcf@lunn.ch>
 <20250407092749.03937ada@kernel.org>
 <Z_U2-oTlrP6TPuOy@hoboy.vegasvil.org>
 <20250408082439.4bf78329@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408082439.4bf78329@kernel.org>

On Tue, Apr 08, 2025 at 08:24:39AM -0700, Jakub Kicinski wrote:
> On Tue, 8 Apr 2025 07:47:22 -0700 Richard Cochran wrote:
> > But overall I don't those interfaces are great for reporting
> > statistics.  netlink seems better.
> 
> Just to be clear, are you asking them to reimplement PTP config
> in netlink just to report 4 counters?

No, maybe four counters can go into debugfs for this device?

Thanks,
Richard

