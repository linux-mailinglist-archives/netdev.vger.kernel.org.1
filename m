Return-Path: <netdev+bounces-97530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A8F8CBF3C
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 12:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812001C20B31
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 10:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E44823B0;
	Wed, 22 May 2024 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="M/fcUBwc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D59D7E572
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716373610; cv=none; b=VmGUTAqvSBi6WLJQgvpdaLcqCIgWm2sLtFPD27AQWs3pQS/uzXeFLYUHgL+uOhhXkFnICu28IWdXpZ7XYFZyF1SzSX6hjVbQ+Zg/1a48QTJFXjLOLo5H8yjllnUArXfdKT2R2Lf5seQC7461LAL/PyuD+ybTLs6C3xVNpoMDNlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716373610; c=relaxed/simple;
	bh=EiqFByx4pqQUBLzEI8fePySLwwEEWt4/esFRg1FpJ8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LvwfV3/5JdY7zvRGQZ+X5xLrDmcWfN1lWOYwtgzEVadHiZBvJ2PFHdq/xwNMqTDPtTtodX4Be+hTHWzmboCh3kAtKNpaiBdbBJt/uX4JXul5Q8MEXsjZmr8lvpqboBLwlqpfOOqTtVTSv1AeibQW4Y2PUAfEko2TrPCloSkqnrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=M/fcUBwc; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5a7d28555bso1022436666b.1
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1716373607; x=1716978407; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EiqFByx4pqQUBLzEI8fePySLwwEEWt4/esFRg1FpJ8E=;
        b=M/fcUBwcDwYlRnSfLN1Dv4luk+jpdQZq+wFtII+jgdJB+qwDudKu9a6mSBdjsfacjV
         BEioc/uqLQsXAv2fM/7x4SEgQZjpnoI25Y2CyLWuebncHl18It3G/4rpTtoyrbUKCjf3
         ENxfvFFTtaynyqLmAmpxEJWTpj2dnY8l/CcAIsWmNqJHNtgGqHWhrgG6ABSizKlLMTmL
         RQ7jsd2WVDduJpPfBb+l1Kq3awBGNWG/ejDe1lPdoKgSE2SSAvqtol0fZ5CPf21nqETw
         8AMnxFsANmDCsAuIeyV6j4i0A+TuecnvBQQJE+0gLeFSvdT0isfupsWwLNavuV120mXQ
         NAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716373607; x=1716978407;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiqFByx4pqQUBLzEI8fePySLwwEEWt4/esFRg1FpJ8E=;
        b=nX6rbXkv+wpA2aJ7YhfNR31e5tMJF+gnJMjAakFbUhJJml1Kj6wXX19SVAc02h63Be
         sebW7OFjo2DCGxV3XFaVP6NDOcDv6r0WiTiC8CHHhB2reYF6++zWIBUyS+B42raHYWrF
         Vq04pkmm5hDrCbdyAtfwXZpV82vkH6CClpWuEDEc6oyAv52+MANuhzhgSVJ+pPbvpYva
         hh70QqldvOg4H/RSKLlRgOx68BM9GPiTVfBFZCPCpUNTeFhg91qTvcn0ioNsvZuZRgDL
         30miyHGW/6rUrcu8Cw88Vupm1WNGmHFZMwdbw5ujbZl6JOuSob7t4ui5kh3+is8EYtnJ
         xieA==
X-Forwarded-Encrypted: i=1; AJvYcCVfZzO8s6mIP1gIHjnOEmA2s79qXjVjBaiKXyXlV6fF35A1ot6/QSTxw+/3vXZXg3BlgvZBYwyeM99f2fy9A9ETD4RXN6yi
X-Gm-Message-State: AOJu0Yz8K/LUCgxzrzpdtrUmQdFfuh9RbPLf8QUcJEyV4P61fEOGcJe6
	SR7y1Sqc73b7SzmWBrxK1y7oGQiin+g7ute+wfayI5MrXXXOkLXAxYIHAZbzzHw=
X-Google-Smtp-Source: AGHT+IEP/6XynI+slqQOfjG7Oa0psj7j191FWOA/gt+y5Cr4KEWT51OKC8Yid974EYSzdefmC02jNg==
X-Received: by 2002:a17:906:b181:b0:a5a:88ff:fe81 with SMTP id a640c23a62f3a-a622809547fmr90147766b.20.1716373607565;
        Wed, 22 May 2024 03:26:47 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:b7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a691870absm1299004866b.124.2024.05.22.03.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 03:26:46 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Geliang Tang <geliang@kernel.org>
Cc: bpf@vger.kernel.org,  netdev@vger.kernel.org,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Andrii
 Nakryiko <andrii@kernel.org>,  John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: test_sockmap, use section names
 understood by libbpf
In-Reply-To: <ec9b6e588ab9c25e0c4f9d1d8822d91896e87b35.camel@kernel.org>
	(Geliang Tang's message of "Wed, 22 May 2024 18:12:31 +0800")
References: <20240522080936.2475833-1-jakub@cloudflare.com>
	<ec9b6e588ab9c25e0c4f9d1d8822d91896e87b35.camel@kernel.org>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Wed, 22 May 2024 12:26:44 +0200
Message-ID: <87zfsiw3a3.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, May 22, 2024 at 06:12 PM +08, Geliang Tang wrote:
> On Wed, 2024-05-22 at 10:09 +0200, Jakub Sitnicki wrote:

[...]

> prog_attach_type is still used by my commit:
>
> https://lore.kernel.org/bpf/e27d7d0c1e0e79b0acd22ac6ad5d8f9f00225303.1716372485.git.tanggeliang@kylinos.cn/T/#u
>
> Please review it for me.
>
> If my commit is acceptable, this patch will conflict with it. It's a
> bit strange to delete this prog_attach_type in your patch and then add
> it back in my commit. So could you please rebase this patch on my
> commit in that case. Sorry for the trouble.

If you want to help improve and modernize this test code, I suggest
switching attachments to bpf_link instead, they are now available for
sockmap:

https://lore.kernel.org/bpf/20240408152451.4162024-1-yonghong.song@linux.dev/

