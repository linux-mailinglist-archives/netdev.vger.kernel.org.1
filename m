Return-Path: <netdev+bounces-90607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A9F8AEB34
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 17:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 306271C21796
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 15:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414A813C693;
	Tue, 23 Apr 2024 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="hYOeB7z6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5112617BA8
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886554; cv=none; b=rBg9o8jkFsp4ZUvDjkANpLmIBZubS5b9z2Fd8Swl3qWzowYqpdEB4buSjpRnnmojwyUo0xWt+Es31Bs77Z1oC+b0OfONYMw1Wg4Ur2LZo7ZkZaywB9vvi3kqNRxxyHh1iPhxqDsNmiTigvGz+/VH8rfkhBdT4HknRKR1CcLVrSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886554; c=relaxed/simple;
	bh=9nIlwUOtmpD384D6HkHMU5/QhFXmw73i6aAmWrDlA4U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YU3/4/TGagY8VUasBJecgxNEYINFOH7V+utuv0G3azZsYPWM4PAbtxRrjSvSuhArcrNVfCB7vzOmuG+NFRcdB/PFYB3yHen/N1fjs+/Rr9rU2Ev8buGfqhJWS7OobyTQf5OdQbxFE1RRZ/zTCCQUmEBo3JOJn/521Csg1i2sDL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=hYOeB7z6; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed04c91c46so5673741b3a.0
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 08:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1713886551; x=1714491351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kH6MHwH0ATYkupQ6G0ONWYL+zKy07Fb1kbir+iloFt8=;
        b=hYOeB7z6MirvydNyt3gdP3T4fXP7uYmxdbAWVxQt4i7OTA6v3FJaSPtkRAR9S1R2Ic
         56un5Nrrg4KFsCgyTmN57Rj7kfBYpfrBTHHQ1lS2o4VVLMUmLJiZn53MQMg5wEwg88gM
         yqYbzzH0KOmK4/0hih0F1SaaiWa3EdU7c0mfiCb7MiAA8zZKh46vh8QHHzX7bodRkXxT
         5Sfq0PL25Tvp2FP9qErNlE8rQ5kH5NlmuPQ4Vat1kR3p/NLC7d/ZZYfZcEZrPFc2M8s8
         8cA6z7MNU748hZCCj2tArlG9PqBaN3T2y2qlJ2N05jd73zHOtHOjcWu8INTZHs5y2x2J
         NvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713886551; x=1714491351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kH6MHwH0ATYkupQ6G0ONWYL+zKy07Fb1kbir+iloFt8=;
        b=Z1+wZdLG5qF695D9ON5Bf0Tlv3eNtu7L2DFvOEcSNd68vCh9mCGcZTxF/1UynCmqe0
         +5mqOgbkGmhs8zYZHme0ILyDOs0cPVOflXGqdaHtg6cMkawitSVII32NFSHmTpdsteqH
         PkJbQ4pENci9WjleKW4KId5oHZ7AjZGPeHCAQIvkwLN6mnYizSd4AtKo2sVqL3aAJpaJ
         hg3uXThDomSzr4NjpbGVbCK8NBTB9NW/4AWCow+0SYfUVt+fkZODhS983KRFDqTDkSup
         YzE52tDhvZSTsYLIyfFIwJmoQS0VaMx6jhCkQo2LkpZ0UfSBLhRg6TwAZOV6v2sOTzGF
         hOBQ==
X-Gm-Message-State: AOJu0YzlyDj5wMItURpy02+d0CkvBEKUohomB0na4Jl0qjfKRhf7DE3u
	LLKAvlZAJT4JGCyLOKiyehCyYrubYYb9LaNHsY1WZlXT2gqNSSCNXs6b/hmrDgw=
X-Google-Smtp-Source: AGHT+IH30Oh0jj93oYOROHrxlbAwcjqIRFBL1l/evo5b2XzoYsKEiozlZFutGzrlJX5r6YWvkhOczQ==
X-Received: by 2002:a05:6a00:3a14:b0:6ec:ea14:b829 with SMTP id fj20-20020a056a003a1400b006ecea14b829mr15466272pfb.28.1713886551463;
        Tue, 23 Apr 2024 08:35:51 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id m12-20020a63710c000000b005f77b2c207dsm7572818pgc.12.2024.04.23.08.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 08:35:51 -0700 (PDT)
Date: Tue, 23 Apr 2024 08:35:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiayun Chen <chenjiayunju@gmail.com>
Cc: netdev@vger.kernel.org, shemminger@osdl.org
Subject: Re: [PATCH] man: fix doc ip will exit with -1
Message-ID: <20240423083548.49573c93@hermes.local>
In-Reply-To: <20240423070345.508758-1-chenjiayunju@gmail.com>
References: <20240423070345.508758-1-chenjiayunju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Apr 2024 15:03:46 +0800
Jiayun Chen <chenjiayunju@gmail.com> wrote:

> The exit code of -1 (255) is not documented:
> 
> $ ip link set dev; echo $?
> 255
> 
> $ ip route help; echo $?
> 255
> 
> It appears that ip returns -1 on syntax error, e.g., invalid device, buffer
> size. Here is a patch for documenting this behavior.
> 
> Signed-off-by: Jiayun Chen <chenjiayunju@gmail.com>
> ---
>  man/man8/ip.8 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I wish Alexey had used the semi-standard exit codes from bash.
The convention is to use 2 for incorrect usage.
Probably too late to fix now?

