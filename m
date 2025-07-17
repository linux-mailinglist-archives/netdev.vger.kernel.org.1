Return-Path: <netdev+bounces-208017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4085B095E2
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 22:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A97F5606FA
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 20:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C5F225A32;
	Thu, 17 Jul 2025 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hi3+2qVK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EC31F92A
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 20:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752785102; cv=none; b=pK77JckjUJNaSQa7uhCk/GpYu3lplYj3CNYJaIJTF80rrt6t2PvoayDMEFSkxgQeI3rZkU0EvtTQp12ikp5vqAK0Ps3ziR3KpQzaOPkuZ1w2m+D7dtoWOUkYbzLojgVTLlqODh5MQvt9INvvy6L5bETzQzjqkwKTCqJc8EP58XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752785102; c=relaxed/simple;
	bh=kNynXvmUYtunimfTX4qpctCcM8zxRw/sXYLYJAc7daU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rf/iS8kBk4QO+voxe6i1gsnP1KTwmI/dY1tH1Kql244ai1y8cnuteRR/DOwm8ygfSzYeY0PlEuhAgjkVwM0dgvlG09j1Hn0FGBW012r/9IY5zYgdzLc65KD/GxFl1HhamkLC9AMvpQ5T6rA4+3ykp4eebcNHBpKWSe5GqvHt6sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hi3+2qVK; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2efdd5c22dfso861483fac.3
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 13:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752785100; x=1753389900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Xr98Bb9scvFxdBdFy7eQDVTDidxSK5gjyy+B8SL+bU=;
        b=hi3+2qVKrEAGCC/Q6FndpNb/sNPxYJp141eGq/oD3M+1vUwMm1CLNWVD++I0ZjzCOb
         J5BpH1CLQ3Ml/oQ9LmncAGyO/DTlUE4WytHxT073GG6wzBr9NwQqPZjqI7LghoBKmQXt
         FBwXJEYBgOVyRoRvHKnvAm+snxO3iE39s4XBSHdGoxEWdf8J85x499DzDvTlNXLg+lmC
         raP8+isJvS8O6dQHtQXFqwg9ZX8BKyRtJt1LBIjy5dvb9tviY2bBryyNDtH03Bggo3Fx
         USx1qXwWVCCcBkDvvR9BDO0dsEA971HI1h2y3Y9yR54DLthgGzv3UV1UJn/PLhPNkHHi
         6wHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752785100; x=1753389900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Xr98Bb9scvFxdBdFy7eQDVTDidxSK5gjyy+B8SL+bU=;
        b=a9U+EM97PWFyir9DF1VMeUUO1RpJ0iLG5T2RQY7bzUQO2Z6VYuHYUT56VpPkPzTXyo
         uAuO4f0vRF+fb9QGDpfXA+5mXyi2FnZotDw367XQpd/DysxC81SHCndKO0f+2zfUJ4xH
         T+Ja9/AGab7ZUXoRIPb/UyAhX5ujLw3Vlqb3ctbFMuEIyl+eerGZTcihS8ApGdSrE1e9
         UmoMG7u7SVOyR9AR/cbFJ1TCKuo5EnHImPt1R7p66yuiuB4vRddwl1h0HpCGsrpWa4Xr
         w6SDraNyRprZ9jQBf+azek1SzH9s2Bf41JsHhfVdWE19iHS9y9rIftDRXw0+xj5R5OxU
         zr8A==
X-Gm-Message-State: AOJu0YwhE0DesAmlFfMVRw/JbAGJzBa1levV8kwhemuWfHMfDrVSpGAS
	WqMXTcKUQRJXQdkRSa8yoMxB0+9DXb4AGjeqRTwZeIOorwtC2KakfDSuH9+Et9hW0AFXgr9JuZX
	pwZ5v
X-Gm-Gg: ASbGncsIxzvd6uQ2oOBbMKM5SPbFavcGV1UGCUzCrzk+tMd3zw6Leunk243zzepLAge
	Jc/vmyRTIXcW0ngwIGyUTau+gNv/I2f1VygkEO4wTj9s1GFpU9ofQgUJXkZxJCrDeDMuAP3FZj+
	GkrFpD930JjdwiCJ1ZdvmkZ9sbdgYdCeiZbEbzO8Z6bJaXsaINimx23BioGIgyi40G3erZASdgL
	3lCqgdiHRjs5kQF0Murn4zJxI1aFz+S2NUnfvWnGNSWNUAE2oAFFHAb9p4IXb5zDrMmnF/SMqqu
	T+FARh6qEz0/VUuCKKxYSUWuX4QiOCxgN63gOY9GiJWajmEwQYrjavMt/dDVKkdHNDUan1EKvCf
	qZRr+567Mwu7kuZbQWUncbcjlN3Dq
X-Google-Smtp-Source: AGHT+IH+Ehq5HbX0yZFWajsM7t8Vmf9gnX3EK0YGmFEDjB30+2zOww1ZuGVdcxgtMSlpNoSZUR4CpA==
X-Received: by 2002:a05:6871:780f:b0:2ff:8956:fd45 with SMTP id 586e51a60fabf-2ffb1eafe32mr6164529fac.0.1752785099635;
        Thu, 17 Jul 2025 13:44:59 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:2c38:70d4:43e:b901])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30103d1d43bsm14423fac.25.2025.07.17.13.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 13:44:58 -0700 (PDT)
Date: Thu, 17 Jul 2025 23:44:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org
Subject: Re: [bug report] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
Message-ID: <c25f3831-dee3-4eee-86ed-8eb6e58a3dad@suswa.mountain>
References: <4a04e0cc-a64b-44e7-9213-2880ed641d77@sabinyo.mountain>
 <aHlXt3HBd--0JGqZ@xps>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHlXt3HBd--0JGqZ@xps>

On Thu, Jul 17, 2025 at 01:06:15PM -0700, Xiang Mei wrote:
> Thanks Dan for the explanations. 
> 
> What do you think about this solution: We split qfq_destory_class to two 
> parts: qfq_rm_from_agg(q, cl) and the left calls. Since the race condition
> is about agg, we can keep the left calls out of the lock but moving 
> qfq_rm_from_agg into the lock.
> 
> This could avoid calling __qdisc_destroy in the lock. Please let me know 
> if it works, I can help to deliever a new version of patch.

What you're saying sounds reasonable to me, but I don't know this code
at all so my opinions on this are a bit worthless.

The patch was already merged into the net tree so you can't send a new
version.  It has a be a fixup patch based on top of the current tree
with a Fixes tag etc.

regards,
dan carpenter

