Return-Path: <netdev+bounces-103319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DFD907868
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 18:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AD4FB21C8C
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979C3130E40;
	Thu, 13 Jun 2024 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="GvIQla0k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA81912D757
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 16:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296619; cv=none; b=dVuEZupqBkY7lr0OeA34XFq/LLXvc291+IWxVQlk4c4HfQ8172/LOJEa7/2NDcxnoDMs54ed+BgWcEEBrXmJ+o2xY0+TytEa9Nzx9xcZB9y5H+xVwllWnS/n3fqT6US9ZX1wuY5qLoDA4Va9+EHWTH/JhKZlUbUUMBTCm7O6mYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296619; c=relaxed/simple;
	bh=iWQAr8GIVC+/koyE7vLOgoBtDqMCweHhX9Rpm5M53uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1STzSmjqKGydfWy+LsX9hCnvUhBNdLw9RtAUu5ZtNudOQYSPHCS+ewY0ecvurj3V3u/t7Y1+MjkMO85OGSI9XQ5fbMVPkLtiLmgSztM4DZUxGyPCGRJUm2YFjDtfh/i0H9PVRJEzI56cgWygSt2zSkTDGD+d52CqDGvGN7wFFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=GvIQla0k; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ba70a0ed75so656728eaf.1
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 09:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1718296617; x=1718901417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpopBpL2xp2sAwF+psNFO7h0dsigzcYNgTusCPI4K8I=;
        b=GvIQla0kMbhcuvO/ceXrlKhn6Ee6l0L3szwEhisWrHaHjwEYtOxhySTe3wPQc7igkT
         AzmEhnQiYmiyJMb9V1s/7OlnV0vqRcryG3AmCmCx30+5l3oTchzqOlJadWP04CbhnkPo
         j/dnAbyNrKloFFBff+LDsJvqew5Ii5JsETQ3ESj2wrhJ7yNzhHq4F0oKYfjVepsBwM1B
         lpra6VJLpWIkK1FSLJVpggfUNgpPzEc+lGLfko46EQHJbNd82phzC5B9FPdWu3DFFlfu
         MKL66q9NtMiaUNBQ09An8qZnRbNhugDGDtDhGCE+WMuo2hV8Yuh9DAYz0JUrCr0iKLvt
         mHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718296617; x=1718901417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpopBpL2xp2sAwF+psNFO7h0dsigzcYNgTusCPI4K8I=;
        b=R5oTF5dv0xoVj6YMU5yIvp5wxzCcRk+ly8x0dJ+AObc8jXY7IHMMGQMC50SLnsbqNw
         QA11uuBFVPLE8VUpG1HlxJhe3+XU3+H0gWlXSZrPLUDJ7lDSAxa6C2XWwS06XbpZoasz
         bGv4BbCTvLC8Rom0V+aUgV26GOaBNmjzBABrIyfSPledl/FOC1JnliEhPeo1SBvgCzQX
         u7gnm6LsV5Hx42L2HXgZZ5YjJVKqWUOxYRskc3C4zPJWag2zyJnagGSVVhe0elhDPlAl
         f4DYi6czxPO3ts6+rqqKUVb0KEUhbJBZK0L2idl8Kq9GbNeW/t0CLuce+a1FA8UHXDKe
         2rSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu3VsqPtClsd4MOmRbBUnTuLE3GF2Gk5md+lus8hefnPjW7wpghPwA7XaM8pHwrmwAYQnUdpjweEydwOWMnKAWdYKsObHq
X-Gm-Message-State: AOJu0Yy9ofy0OSQFisQ81WRU5jWqUr7pQ56Kd+G6KfNt9cvrkvop8eQ4
	Ksgtuif/0UKLETyATQbbesZavnM5R87B82fUWwfoo+4L3wC+UBO6Sqdzy2MmrNbgv6Ye0tzEqjE
	q
X-Google-Smtp-Source: AGHT+IGFmDaToW4kSBVn6LzoXjVybycghwCxAmQAPnypCmydtyTEpJFgM6MIuiRkni4k0+d6jovTkQ==
X-Received: by 2002:a05:6358:786:b0:19f:4d27:fb77 with SMTP id e5c5f4694b2df-19fa9df7258mr34938255d.5.1718296616656;
        Thu, 13 Jun 2024 09:36:56 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedcf35688sm1106887a12.13.2024.06.13.09.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 09:36:56 -0700 (PDT)
Date: Thu, 13 Jun 2024 09:36:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Networking <netdev@vger.kernel.org>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [iproute2] No mst support for bridge?
Message-ID: <20240613093654.2d33d800@hermes.local>
In-Reply-To: <Zmsc54cVKF1wpzj7@Laptop-X1>
References: <Zmsc54cVKF1wpzj7@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 18:23:03 +0200
Hangbin Liu <liuhangbin@gmail.com> wrote:

> Hi David,
> 
> I can't recall why iproute2 doesn't have bridge mst support after
> ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode") and
> 122c29486e1f ("net: bridge: mst: Support setting and reporting MST port states")
> 
> Is there a reason that we rejected the iproute2 patch? Or Tobias didn't submit
> the patch?
> 
> Thanks
> Hangbin

I never saw a patch, and searching the archives does not show it either.
Maybe never submitted or blocked by spam filter.

