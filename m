Return-Path: <netdev+bounces-249958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A55A5D21A9D
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 23:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BB283029D2E
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 22:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7410033D6E8;
	Wed, 14 Jan 2026 22:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXXECRc6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E00535EDA7
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 22:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768431246; cv=none; b=DMYmtIlWBPcwAk0408QiZNBA9G8Qp61a/rivOQ1IEiytATkftyGYrxhtOxbejLjDK9F5MoOOuRPlgdxum0MYqqoWQ7QyV3XSJ2/OYAvHUvTQhg0gtBMmzBVUEv5OlUCT0mD4OZcajXvflsQvoCAnoqwNtRat8Dvc0lG9fcBBnyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768431246; c=relaxed/simple;
	bh=7WsxJU7FKkp41RYPPQz3X32Ge44pP2VLnRmModcDNf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McLX/lMrV8epQKCPhF3IxZ8CHxQUUEYxWTSM23LfCrIoB2+3NiiOQfRrmG5Wo3omLwins2uVLK3C0K4dnXXcdT8nwEROo7ZzdXPXR8+j103rSXscARwFzfPumnsuSzNGlGql+mZD3+oT5z8oIkp78gbyKFoCbAYO/pEOfK+MZNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXXECRc6; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c69ffb226eso2464485a.1
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 14:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768431243; x=1769036043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HLgCsqyyIABS0s1NbINga0N29+Yya9EPm6l3UVkUqlk=;
        b=CXXECRc6OCkyUIt4NKKmq8VFiuNCWEztho5Mx7qcDz2okZvGZ9uJX7m0v3IoOj7r/f
         rm4wHnlhhLmJJR5yhyeOfA0L5h1xnAkIvr5FIf5JjCzQxeE4Ln7dgHaIInsMWG/blKs6
         dwBEx8EOlfoZT9rlxDw+O0PkG+IrdHfOmJY0laBJ3pi+MdkPe2m7iXUw8ymE5Jgqm0vh
         d0xogJmxcJoEULkODhF5RrdoCMWjGX+sQ11O+NaXHYfB7ih1cryCu1U7HtaJ05jHCuBu
         x+UImKN0eq/BJgcuUl+OIuGHfyorhLr1ni8b51i1jIbPiLogEEyX7aUDd9EySsbjOkVV
         hVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768431243; x=1769036043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLgCsqyyIABS0s1NbINga0N29+Yya9EPm6l3UVkUqlk=;
        b=eqtbU0VmyPqUplrQzCJnMzYbahVeayMyfXEQ0wAORXLFpYr3xCe5X7etp5VldKlE/C
         8e+CFoV4aVoz4Z2r3NHHh4tD0kXeBFNta076dQFIkrz1Hlg7lxfd33kMgu7EmSYWihqH
         PheEUqsfs+mw8xDjlVupVr8E0ZmKZiWZ/J2QP2R4/GHR2Idx98hTSYv6qBB4ZndD7BQn
         BQwtNBgw6gfqFQxyaigQ9C8ZM7xRhXNhderkBhzT5z8c4aYZ+ozeg44ouB85Hh+WNqtl
         twyZLUQuUuLUIKJMZ8tBFaOzYZpXatVEJs8xn0g8gv8djOkoKpt8tIB5zav3kSSc5XPO
         GaAw==
X-Forwarded-Encrypted: i=1; AJvYcCVz7DkLjeVkeFlSkZMfl2aEq0UuGknfCPA67BHk9T8qxtT9506JPVWPkLcVdajag0mNkfM6OqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxN3If8mnP/+SJpFYuijAqIGGZCIBtulFr3HjBu0kWvmFce4Ub
	KmW0fQECeFvKr2lHly+PsdjXCdpPKOPiS2xeM7womm4LIyttRLh2DKI=
X-Gm-Gg: AY/fxX5MPp8Xs/ILRseuBwLcTB7WZJQDtnFkcnR2OhfUFkFyuGnibtOChglHQ3NExx6
	JEkx7LrvlLlapEI5y6QGVdtbUpyX6nusI9H/P9lH7Z14k6AsGPpUgPjmsEhR7UWVY1EW7WnoFo8
	Gut5RR3Qt/hjNw75nKLbXaOuUHtd5YsAqWmfww9TZH3YhKaRIhkSLdsOkH6QGA4ZBzINFDROl/2
	fcHU+6AtDodouspcdGZFJ1gSM15wao63AfyO6TKj8J/c/bimli2SuNH+sp5Mx/BgLkJGJcb4Dkn
	p0HH73uKs8WQ3qOkNyeqPNTI3Cn9oue/dwc4XgHzyGCEgu9QjoK7kZ1tmAP6/R9ahLmp4yuHJn1
	d936hWpu6HgA8as/MscjvGGW7GkCUcoAQO18Da1Pj6TuOpHCbSiLaoFZz90FOqoeQntjKEuZjCq
	1ABLPsxgty95gdTntzQi4rvyk497P86k2UeD3+rhC3tYr4aOfQDzrhsJTScykXY+l1NUtrrK9ku
	EEFcg==
X-Received: by 2002:a05:7022:1582:b0:123:34e8:ae8e with SMTP id a92af1059eb24-12336ae5ca6mr4266670c88.50.1768424199264;
        Wed, 14 Jan 2026 12:56:39 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248c246sm32065044c88.11.2026.01.14.12.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 12:56:38 -0800 (PST)
Date: Wed, 14 Jan 2026 12:56:38 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v6 0/2] xsk: move cq_cached_prod_lock
Message-ID: <aWgDBtepjbGNSA0z@mini-arch>
References: <20260104012125.44003-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260104012125.44003-1-kerneljasonxing@gmail.com>

On 01/04, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Move cq_cached_prod_lock to avoid touching new cacheline.
> 
> ---
> V6
> Link: https://lore.kernel.org/all/20251216025047.67553-1-kerneljasonxing@gmail.com/
> 1. only rebase

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

