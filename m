Return-Path: <netdev+bounces-67362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAE9843074
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 23:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F3D1F21B50
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 22:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BF37EEFD;
	Tue, 30 Jan 2024 22:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="a9TsL7eq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68B07EEFE
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 22:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706655594; cv=none; b=J64j9cQ2BHpsa7rtXzRoE9y3j0Ga4+OTedRRU+OaBACSzqboqsdt9qkuJi8uRdll9GFIkMzY2s9J1ScoisWVuSfrtrLfgUEWhBmvyg1SiUv2svuqizZM9SJVmdaBbFUsU50sXDnMUr16hNxut3MRVUsBLOz0lFj0mI8nAJgazv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706655594; c=relaxed/simple;
	bh=idUO2uxaruTbpQD100whNahWL9QvzrV9EyyHrB2VU6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GkmdEtxJ/zA97JSlbV/3+cOXjoHGJPQ3Awktg3M/TuuLqAqmGPl/K+pD+FHcloA7c8YPn0jJYIeINujdHNZH2QRtuUIIivdL8b8r3Eq5QlIPLrdeTZv+QzkNoX/gk+Gale9YjIQyCxWMwtHs6mqPMkOyI3Muo0UwXT2hP/t1zxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=a9TsL7eq; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-58962bf3f89so1486953a12.0
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 14:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706655591; x=1707260391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I9zvkvCXyqckVuozVkVhrKwkHVAXtLklw8l24aE9o40=;
        b=a9TsL7eqONedG5GciOidI+K6yGft0Y/3MiGDBfMW3yjRg+Kjx1wyEndjc0Lk76vML5
         rO+gFmy53HvaxyeCGsQl6tYpl8VAdHBNLIX39cUIWEQLGPHnmiXoWzISI9ynDG1uNE56
         GTvqETUFP0NDsY9/Lzu6h3iPmpsUV9Z+BzJPajbLjgif/ACMGGWE4p8/eq0RSaqSk+Iv
         vDcL4406u4JC6vaeoZg2YJgDz5Y1fiwCsqelFNe6CtUmylydmy0aoW2JL5t0Ot1GdWcr
         6oirpkdGjBW8gpsnd6GjX4RMwXZaMXTcs+u4bAcYUvDBWs5yhK3yQ8QU9su9AQ4fhApq
         3E5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706655591; x=1707260391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9zvkvCXyqckVuozVkVhrKwkHVAXtLklw8l24aE9o40=;
        b=ReuxrZ/Xw8Xo7DeucnJAvHgt1+fU5G3bnxNb8wdWRxuJB5FvwcmMSUOYV8+hC/vWhT
         E4T3RYe2/7Ilu/galieOepw1alkgo/Szo4ZP18PWXc3bIfOXUw8ywNA2Pf8y96a6Wu5a
         fyUxS73Jspfs8FleDgCBGedslMhT67ciZn2Cq7a2/7Ozjq6YOl1xM8+Vd4RyiwD/GGuy
         D1RodUpOp9q6vWYvi9MH7eQFxLTHSHPaZG/5Zha6D68GZXQPSV4RSfcHj5DGX8QVSE3z
         By8rHiKAUSY2L1MHN+hK1q8Fr6ZQYcoKCZ8U7m/waqXB9Mw7sVWhgIiAkHv4UjEQXePk
         L0lw==
X-Gm-Message-State: AOJu0YzqnjIyPx15RbIu1uxnOu0qor8cN16ECdSYnsn+mMYT8b+lBWk0
	eQqLMrthZrwHi3N+vsvAQxiVoPsO/jU9saqnDCdGwysSKS1vgpsnzNuYi8k5QEU=
X-Google-Smtp-Source: AGHT+IFYwAA7H2idk2+JsDU6EYfbt71pnvyYu7tJXdxp/z1vPV7dZ7TH1IOwZ9Xg0KtlKEyTj7VmLw==
X-Received: by 2002:a05:6a20:8e06:b0:19c:9b7d:bb36 with SMTP id y6-20020a056a208e0600b0019c9b7dbb36mr14519772pzj.2.1706655591162;
        Tue, 30 Jan 2024 14:59:51 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090adac300b0028b845f2890sm11028829pjx.33.2024.01.30.14.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 14:59:50 -0800 (PST)
Message-ID: <2b238cec-ab1b-4160-8fb0-ad199e1d0306@kernel.dk>
Date: Tue, 30 Jan 2024 15:59:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 0/7] io_uring: add napi busy polling support
Content-Language: en-US
To: Olivier Langlois <olivier@trillion01.com>,
 Stefan Roesch <shr@devkernel.io>, io-uring@vger.kernel.org,
 kernel-team@fb.com
Cc: ammarfaizi2@gnuweeb.org, netdev@vger.kernel.org, kuba@kernel.org
References: <20230608163839.2891748-1-shr@devkernel.io>
 <58bde897e724efd7771229734d8ad2fb58b3ca48.camel@trillion01.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <58bde897e724efd7771229734d8ad2fb58b3ca48.camel@trillion01.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/30/24 2:20 PM, Olivier Langlois wrote:
> Hi,
> 
> I was wondering what did happen to this patch submission...
> 
> It seems like Stefan did put a lot of effort in addressing every
> reported issue for several weeks/months...
> 
> and then nothing... as if this patch has never been reviewed by
> anyone...
> 
> has it been decided to not integrate NAPI busy looping in io_uring
> privately finally?

It's really just waiting for testing, I want to ensure it's working as
we want it to before committing. But the production bits I wanted to
test on have been dragging out, hence I have not made any moves towards
merging this for upstream just yet.

FWIW, I have been maintaining the patchset, you can find the current
series here:

https://git.kernel.dk/cgit/linux/log/?h=io_uring-napi

-- 
Jens Axboe


