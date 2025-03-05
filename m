Return-Path: <netdev+bounces-171952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADDFA4F98B
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 10:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A4016CE03
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 09:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F7820127B;
	Wed,  5 Mar 2025 09:09:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CC01FE468;
	Wed,  5 Mar 2025 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741165798; cv=none; b=TFHDd7cPS7eBtgEaGTrUyvuTLr+1/Ydw6e+2cI+bufQSXKYpSN+sZH65t2jMkVYueZpSea7Xyh+CfslgXUQMTDCHWuonJ3QUbOxj7yLZuDq99l6ufKspFaFdaGtb95UiMR9EHdab7tCLimzHlGJFXBd6tXbwJgTO/ainizhFzTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741165798; c=relaxed/simple;
	bh=ta7h9kJzzOpCkmH3Y9ri8PlU1tKaKgfFD46B2fQz+FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDkrhHbhf4fS5OMSfSGjicFs/eFiSSIXKe+lxeiqKfmm7RdNl7Uwjzd/qGRnaFatzSIhAxxQXJY/txkSmkndf2PJMixhZI2AYzPsv4MG1uoorTS0en/lCTQZfBHkshug3/eSQM8WwUfPJw8jE6ZnXdOk+S4kNURI1re6UB0w5KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43bd5644de8so2444065e9.3;
        Wed, 05 Mar 2025 01:09:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741165795; x=1741770595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABCkw2+2Rlqml5hDPabUnWsNj3V53k9SbOBBcg2SJvg=;
        b=YrLQ4yQq8zWzSFKV6l9V7ZRubrqrU554ErD1QK0ydTcxTGwSKZrl9ETGeMufNIfQBo
         c7dkm16r1rVLZm/r/HGDpP2DpkVmGhp95Kdh9bmkuj/SKiR7F6OuxNWIzcA/oEWQ+WBH
         PtAPCjV0F66Gehdk1Rr32CYqw5IefHv14hO/UKDnmAcgOqwqjteHJAzL3IAd5GUa58Vo
         Icla7QxtMagW5KUvOE+M3d1OJJgVXzO94NB6YhM7gzMcuAUtOWJ+FtYp2ednsOnOc7Ue
         11Ba6GdUUT4CK2vUg4t3TtOQ/f6ksERH/nucBpWfV4q6mPlRLgCiECSqvyDTKRd8KLb6
         l2jw==
X-Forwarded-Encrypted: i=1; AJvYcCWcJFgq0Zet7TtloDqxsQFqh5BM/MCG/N9w8S4z3ygx7L89gpO2hepBMm1H2xgW0K06YXOS2z4MCenWmIU=@vger.kernel.org, AJvYcCWtglsCJ56+4otMss27rlVv+tJqDtoatI9ArHSwelSE9pAoW8h56HDV6OAlD+8Uirpo2iuyJ7it@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl3fpnb5poxDZ20dCrZ4SO8x/xK3g94fI9En7npNELYEdkIycI
	YyyD+yjo/LqSKBmVs/q0QCAd4uWin6WZzZujyQXf7k2iV/dt31bU
X-Gm-Gg: ASbGncvq9FQs/WBZ0oomJgHsC/N5P+MvVSLFOczvjUezPXFGDK0KHKHbzbvjNEE2gLH
	TUMZh+tXgYG8POrtQ8NFiSP5e99rrz7NKgfkBE/9pHgGAJOptO99Xpxac1bT5LFEy8wv8PtnILr
	kKwqdCGBV2U0EMNCSJ7SzKr57YwFvmuZa1jyjvPNStHZmfLVYaY7wo/14fOQCSwcLomAgm/BiwD
	uvUbQlZrnhvpYy7PyFHRIQKaxrgCnUDxGczb3FzxFliKCfIvpwTtZcPkIiLAeU7fpcAEZG1Iu8m
	rs8KwUxYUF0C5O92o1dMbrKQdltAQEaAJ+k=
X-Google-Smtp-Source: AGHT+IHCP6MbdHeA0uf1m/nPCgxsCU7213iOQG3cSGpRJH6AaH38fFIBlamRTganZFvgNlL7vSOCjQ==
X-Received: by 2002:a05:6000:1f8b:b0:390:eb6f:46bf with SMTP id ffacd0b85a97d-3911f724befmr1837281f8f.5.1741165794688;
        Wed, 05 Mar 2025 01:09:54 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1e9576fb3sm313661066b.48.2025.03.05.01.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:09:54 -0800 (PST)
Date: Wed, 5 Mar 2025 01:09:49 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Amerigo Wang <amwang@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net] netpoll: guard __netpoll_send_skb() with RCU read
 lock
Message-ID: <20250305-tamarin-of-amusing-luck-b9c84f@leitao>
References: <20250303-netpoll_rcu_v2-v1-1-6b34d8a01fa2@debian.org>
 <20250304174732.2a1f2cb5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304174732.2a1f2cb5@kernel.org>

Hello Jakub,

On Tue, Mar 04, 2025 at 05:47:32PM -0800, Jakub Kicinski wrote:
> On Mon, 03 Mar 2025 03:44:12 -0800 Breno Leitao wrote:
> > +	guard(rcu)();
> 
> Scoped guards if you have to.
> Preferably just lock/unlock like a normal person..

Sure, I thought that we would be moving to scoped guards all across the
board, at least that was my reading for a similar patch I sent a while
ago:

	https://lore.kernel.org/all/20250224123016.GA17456@noisy.programming.kicks-ass.net/

Anyway, in which case should I use scoped guard instead of just being
like a normal person?

Thanks for the review,
--breno

