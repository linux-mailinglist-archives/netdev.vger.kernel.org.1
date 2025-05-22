Return-Path: <netdev+bounces-192658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8073AC0B9C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 14:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617A04E477C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 12:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194FF28A3FC;
	Thu, 22 May 2025 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAyZDtL2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87BEE571;
	Thu, 22 May 2025 12:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747917140; cv=none; b=gPmQsNrmstt7qunEEike7mLJSHmEKhYfLbCpko4D3P5XTt7iUHfUgcHEfd3bkpX3guzqB/bz96qmmOO0QV9wBEOS15HYCcP5bieXR/0NJRVwHGQ+TqaRUzLb3/C0GmczwjPcgTzW/Hff7U1YH9rdBEqDkDlR3rZDog7j+t7SAcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747917140; c=relaxed/simple;
	bh=ToHGua01XZthLHTpVBi5YtbE0FY+GFwlyD5Y+QMpN2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQTd/uNM+jwp9puKfTHNv65V6CQrIiUZ7qduUo45cJPxkK6PeWxBQmLSNCuYJ4RvmOnJEZEB1pg0j9Q6+JLfF7u0TXL/EESG3W/pYmYPzhbT5Rf3Fz7DDfQ+W24WDHLpWaBWI+Sytmw1fKFkHpJR6trUX5Zr2xzIgK86EHOHAn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAyZDtL2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74068f95d9fso6980863b3a.0;
        Thu, 22 May 2025 05:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747917138; x=1748521938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oDIjIB1yv5C8xZS9vpGnbU26kDAXmRu82EqhTb8+Ins=;
        b=MAyZDtL2IXr/79ElxlfhsX3zvPDzFnIyDQAsAnucOWg0yMmkmCH9NHwE7WGAG+Hhc6
         wfwm0e9vBszsI9BByuXGygGDkOXmyqNyrEqybAvvT3hekMXDizBl/CHzLdE6UGxbroaT
         8r/ePnusxHbvd/QZOZhBoiipirt4szrGf89/U/OEdOx8klZrPjca/Li2MNpUZo1rl+sp
         rbkmnBj6k/QYihgyxbOob3953kw40qYhG7hvSB1ykxkFcHJrY3qlEc5wTKcGMkwoipkO
         naKKPsXRA6RIrU76IsZgbzCN2J2vwabwoNO2Yz3x6OPB45ElgcusT+3NTwtgaOZF61hF
         qwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747917138; x=1748521938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDIjIB1yv5C8xZS9vpGnbU26kDAXmRu82EqhTb8+Ins=;
        b=f6YwBC0A1TD3Qa0kZQNWusGztC8Xu/Ix+p9b0lpJZeQS4CasuqpUceNQ5demmKNhcD
         8v9j5zqg8xT0uXXixlslqTC/tRuUDklFVV1JmjNT8b75BcVAfN9w2BpYr7Z9hApGes3n
         z4R0IApPNJZOND7cinKyi/PT4LOm7ysNiy8pXCjpJxblZP5sklHUbY2lULFRBwLEa5BV
         Ynp7xpqnkXP1Lzq1VxAKhQwLbZ6YkQU+B7gUKq2zYL5hRkjqje4dJmXDwb9sty+b+AUr
         Tl5sy6K894gR13nIKYf9w1KK09s6vF7VcMTduBFmyUEwp0YdxAdJa3nMsm4wQR5Od+Zl
         BLqg==
X-Forwarded-Encrypted: i=1; AJvYcCU3dJ7WT+NcmGUqn4EZ4ob1Zjw/Vp3m0w9qZqGXknwRShY5P+9qBDNAuF6q4bi0qNaK2TOGLZZ1@vger.kernel.org, AJvYcCW9/FOJ07lhhciHuUI3lZFTre3pVte1AMOJibiT4CnsrXwdz5AhAE3xizQM8DyKY6GWA7Xm0OiqTQm3how=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJPuKTlin3kj1timapEuFs9/K/uECDZem0disfnCzRcm5S01Pd
	gf1rSk+tggn2k0i+IB0Wbjf6tya1q9aZQPRBia+NDDMSA1iju/rAvm86
X-Gm-Gg: ASbGncu2q0nBSaAZpr/RPYzWyoX9h3wJaYaybiJUjeUP8LQ4ENDMOwZdVzW8EgtzdLn
	IRq9/naphpSgeWPtFe1jfFILLzYIwg2f4iUJrzycZRJIH6hFzoDXKiSAHsjoErS8gVnJwbfhvob
	9IWLdRAhiM+1wq9sB3JYqpeC7UkZiw8xWAz22XuuiPGRVOO5YzjpPu1rA32jdqj2lH7VZveNoEk
	gUZReEaA85uYRuFBYK4BZiG0GHrnOBQAGCCsZgYc+44tCTbrV4KF/92FHAnI2tYmyT7zj8HkJVd
	/xSf2gCCV5Kb5E3zk3Ia7gEmdeQdGoCzwJNE0JFu97u4JWT4WL155ZzgR8sRIuaXm+N+BT8=
X-Google-Smtp-Source: AGHT+IFfPoBmio27iD9bWRZOB7fRlexaRo8/BuzhWhYJcGwM3ygNETlAuLYZ7vPAlxe7gZTudTxXIQ==
X-Received: by 2002:a05:6a00:a81:b0:736:5dc6:a14b with SMTP id d2e1a72fcca58-742acce23fcmr32117205b3a.13.1747917137835;
        Thu, 22 May 2025 05:32:17 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96de0fbsm11479196b3a.18.2025.05.22.05.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 05:32:17 -0700 (PDT)
Date: Thu, 22 May 2025 05:32:15 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, yangbo.lu@nxp.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ptp: remove ptp->n_vclocks check logic in
 ptp_vclock_in_use()
Message-ID: <aC8ZT3MW2EhPSQGK@hoboy.vegasvil.org>
References: <20250520160717.7350-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520160717.7350-1-aha310510@gmail.com>

On Wed, May 21, 2025 at 01:07:17AM +0900, Jeongjun Park wrote:
> There is no disagreement that we should check both ptp->is_virtual_clock
> and ptp->n_vclocks to check if the ptp virtual clock is in use.
> 
> However, when we acquire ptp->n_vclocks_mux to read ptp->n_vclocks in
> ptp_vclock_in_use(), we observe a recursive lock in the call trace
> starting from n_vclocks_store().

> The best way to solve this is to remove the logic that checks
> ptp->n_vclocks in ptp_vclock_in_use().

Acked-by: Richard Cochran <richardcochran@gmail.com>

