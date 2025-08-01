Return-Path: <netdev+bounces-211365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4F9B18458
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 16:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD15580513
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 14:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77D826F467;
	Fri,  1 Aug 2025 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcTW8mGX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C1D26C386
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754060337; cv=none; b=Osz6bS55ny8jq4AHqWogtXK7A9cuLxuFve9znp9LS2330BW/dPHfEAqN5/hqeybxunp6b01RYSjH1hqkGECE71O8n3YMshZXBMsIg2GfmzUqSLJFTz6yz6VEu6RRTpKkdCEAxmelWLw6/I4xSQ5sFcOvepvAgnzc/VtxD3z8P0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754060337; c=relaxed/simple;
	bh=acCvo63y8jiLdWx478DS9bn6Stz2NNVf0VfiNag/WCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zx2XscGL8nYuxE5VqNteHE9g8HQCY5Qy5ftRnZbj4otPL8Mmbd6P7oLrmFlHtiXy0NkPiYMIQFkPfveS5sNflmbfJfrkFsHqK27J573adk3npFFLCQ3WH9VR8LDBVeNy+RHXrs4D5Z1iXPlAN3tvU26gEXg6Er73yzOVnyFAGBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcTW8mGX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-236377f00a1so19783075ad.3
        for <netdev@vger.kernel.org>; Fri, 01 Aug 2025 07:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754060336; x=1754665136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f8aKDjx8KciSB3M51N0sJl74Y7jne/FY8U+KwDB53Bk=;
        b=HcTW8mGXZA1wKZm8AO5r/vAuC1UheZbKmzffSLO37T7JVSJ9W9c8VhbtC9FhBVv6KR
         kwXy7zdwhIL2g9lbkH0u7Rgs5U3Tqmg5pCi3/3OzUvB9KZrUwTCinVpePtQiFu4SJxrC
         /1FKjh1TiHdcxWjrC7qHctURU92Bo01JmxYdhFHlPEp9Mi9UJdRwxXE1gpQPlsK9kEyG
         MV/2WcsmGrn64m2ntDK3J0YKYS/TMcFhM/w/XgJeMU6tpyR0xsLN2cPLN8mNmx9GB/7G
         N4/f1oOlrQdvN/FcQnD4neUG8bnzxirYjYHf8aJoDii09cZceTl7ijI2HSTV1i2wvNH/
         xVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754060336; x=1754665136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8aKDjx8KciSB3M51N0sJl74Y7jne/FY8U+KwDB53Bk=;
        b=KQW6DBrabpXzXF0mhERifgLsPet+BGmw5xnWFfCh4TMIMkMUZjJhfD30Bk9GVG2lMP
         EijZVXgzj3hSZVcVyTCqu61eLON+noSVymgqir9JLUobicyEUgLfPDVl/UoWDAC1MEpP
         z6Hz/4FhSC8XsV0c8h19GjTyi5nBB46rYwq4da+/J3Wp3+fx2knA02lirfuc1EOYTCTM
         ZU9wCurZStnx1XEZwSc/HpM69luXOYbVk/ZrbqQvCrZtbnjEXmMd4x5g6mqL4+NQ+vGQ
         h2S0eZO+5Qr0HNu41uV7KahjpvVFAfNq/v+7NpCWwmoQhfeLjwkuSWAN5PrZYcaPurzp
         24jw==
X-Forwarded-Encrypted: i=1; AJvYcCUsj0+Xy7YScFxeqjlS23NLX9F5JZ0J6ocZFAW2Rd5eecd5pjbgKrWzgmha+xtpr+m0MEjmDhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiIJz98oeCQTLnBwTgXMhWakRCXOepiDBKp9PKjbSLeIc5SvTq
	Ar9Hvu3FrvIgBwsN7JXbySWHrxK8lU680gr/VP7sb8+FRyX69ckA2fY=
X-Gm-Gg: ASbGncu2E5dhqFzRIuWqXRuOzeL47hybrf8CmLexl9edTGtiA8NJukC8+0meB3RM1hM
	ZO02cS7icPGTZZebYBISuLGO5vv9U9V50bSYKTi2yNDY+B8VOdokjx/hQlNpguhhI0HgntO9OaA
	bgXTFyB9v58isMkG5oK6Zske7n1jNzEj9+2DPJ+1Yq4r1cFJ0UfP94JgJhAPSodxzNdLYvp1gKs
	xrLJPw7jcDaCS1x50MZ6zqUdh4kNGxrvh4bRnHgTbKzMdm5dTjib8MO1aXznVqreWGV7f6xclbv
	/5Ne+/Y8ndgUKCnIcwGbzu8HdwPuO7e5FMDsP9R9ExrxBG6gti6LtdYDyKedfgMfYgPXmQuDKmF
	87dLPbXkPipABTVR7UqkIW5qJ84nYWYbtz6NMoqRAj1007/5eZtE57R/ql9Vu/q86H6IoE0EF8S
	jpIjuS
X-Google-Smtp-Source: AGHT+IEMYyhG0EBgMl9Zx2pW6o6RyKSOiXSG2z1KLYJlpvdza/PZ8iEgj8uWSHHw987VvCj64Yyr/g==
X-Received: by 2002:a17:903:350d:b0:235:779:ede5 with SMTP id d9443c01a7336-24096b22e37mr153608815ad.40.1754060335699;
        Fri, 01 Aug 2025 07:58:55 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-241e899d28asm45625495ad.142.2025.08.01.07.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 07:58:55 -0700 (PDT)
Date: Fri, 1 Aug 2025 07:58:54 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	almasrymina@google.com, asml.silence@gmail.com, sdf@fomichev.me,
	dw@davidwei.uk, kaiyuanz@google.com
Subject: Re: [PATCH net] net: devmem: fix DMA direction on unmapping
Message-ID: <aIzWLgDXMUhRkq9p@mini-arch>
References: <20250801011335.2267515-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250801011335.2267515-1-kuba@kernel.org>

On 07/31, Jakub Kicinski wrote:
> Looks like we always unmap the DMA_BUF with DMA_FROM_DEVICE direction.
> While at it unexport __net_devmem_dmabuf_binding_free(), it's internal.
> 
> Found by code inspection.
> 
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Compile tested only. I could be missing something here.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

