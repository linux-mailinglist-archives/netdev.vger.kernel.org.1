Return-Path: <netdev+bounces-209127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2282B0E6B8
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 00:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6091C8832A
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 22:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97B3288C87;
	Tue, 22 Jul 2025 22:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="v3RA55QD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171A828505C
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 22:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753224659; cv=none; b=s0vA3rW+iYY9zqg6XOEmj/9ZVLelgPgUgPI94/zkwLPJQW9cWYwbMjD4GLYI8qcYqXx9mA6EXHdWTPkfIXeOz/NJdFa800aSlgvF8hcpcuYX6YQZoPy6qCJ/7/QkVWe3vZk6P94zYBfYe9kh9xzItjOlz9RqaK5iZwKrbLGP4CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753224659; c=relaxed/simple;
	bh=6uB2lZ5a3FhUwFntFS23O6jdsDBMwEqNb4UAXhcRzKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpQNObtn7CtbkMBwNbANlyq9JvK9sa4GqojP3MVzGUk5abBZVejlrUxUk2DYgcdXuRftsZEWplkzgY8rj0PVjtTgLkMeZRxJfumc/Hl3eKkjvEt46BvmS1qxilkgRpnN5tQZ7FtY3WCM5XvpqGYUWQyeT+jGdThUxXsU00tHWCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=v3RA55QD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2352400344aso55395685ad.2
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 15:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753224657; x=1753829457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQzRATxFUKQGYan/owFeZWMrnr0JMY054iWgwuSEiR0=;
        b=v3RA55QDcA5HTgfMBoZ4bD0VRZIDOiruZjlUg9BURUEmsNT1vd70w0WeQoIV+s3EKu
         oJgjtCYwRLYcJ2HJFXoPfAwqGh8jfLedjA1+lflbSlPrVqVkSEWGTOVfW3CtuvuUPFGt
         ujCgp0kDqwln3ke/wHRmpqvCVoseKN0ePF5lh1Ds+/7LjzJYC3eSaNhtwdQVXi+u/YuB
         uBQevYSp/8YLlnlOkTfQ/m7SHn0/vl4seaZca0aoEZujWrWTZjiPTm9qYvRnhRbAOz7l
         mOA4gfJit2DmN/yH5jdk0cpFWK5jZoEjXqb+ij6gbzAzE+TYxf5XFSZ/IaF93kJxh4ja
         MoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753224657; x=1753829457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQzRATxFUKQGYan/owFeZWMrnr0JMY054iWgwuSEiR0=;
        b=eJM01JYh5mJ07OoC0zDyAI7F/eOdqrEka2USx/XoF4nSydPXPSi3XaCDVwpwxQduOh
         x0ooIjiaTjxjf3sJK3oULi8ycWm4x8ajgcQ9FEbbh3rIm1z9wAKGJNSIYR4z7Ex+/NZ3
         zL0hd5EdjTKdBYrGl5rKYBzOgfzqkryPEoUZzuHB+gYiudaViBO+YLaWBTIRlEfCccxs
         p1N2jUMoLvXCJTlRlRyQoLT5AKdRlpt1Cu6B/z9W7oeBa2Fj6Lm2VfssEuQLtyWWEZc4
         Oke/cId0WXjBMiVu1l8wOSnAxQBKFtvF1H5jO/+6jZuOgaD2D78MYk1Gi6kdEEuDUlQZ
         cMLg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+IBBZ8kZ62bb5Ba8WAURLoN2gWmuQfkaixJHFgIyXKCHSt/+WsQJm3rsnXkkSwl1pCCZ+YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3dOyXpotANgdsx7ONFFpynou0i2d4coAzsdwPI9tO9KP8/xcv
	p9kQGkUFJP8Qo7+8XVk8/GzV4yHPXJfctvt6651DYllkBFIsTE9J7Bo6szQ7VDl922s=
X-Gm-Gg: ASbGnctkguBBrb5pcOnCNuKSMjmrQUPOpKiCo0dJyiiVg6FjZXIHGuYm7qa4C2ST+uN
	9CQevo2dJhh+apMx3kO6PamXO1Pkh8IyCWeoxol613brR0duPvmccdItqNcy/TsSDKRGJa20Y5r
	W9PFDL7MvbpvjSnoiuFRBbyquT07rvPhehw0T8dD47MsDGeZ0FgEPowxJbiF7zBJT6ytj1AkN0o
	oFw7ZeMe0lVxNDAFfHMyXx95AX9yvUCANwPi0eLx8cJsYawFh9XKMleBQbYevkd2ygxUz+tjhGT
	bXYTSx9dKRjVq8V8h6btVPjtagfERcgQKcf4pQEa90AVvFO7UiRXvanluwPa1j0q1Io0XiELoQu
	OqCSGsTX6IvjPJoff8UubY/AWY5GoU3f6b6IYnxaeJfb7IrmDOBBWFbaaBoUS4wJl5xcfu6HKKX
	k=
X-Google-Smtp-Source: AGHT+IFb6BfUi9++lrjruDrp1u8SDwu2XZE+PQZF8X0tcMFOL5inVJKagXvznCSDmVJiiqBwRvC8qA==
X-Received: by 2002:a17:902:e54e:b0:225:abd2:5e4b with SMTP id d9443c01a7336-23f98176ad5mr8911005ad.16.1753224657384;
        Tue, 22 Jul 2025 15:50:57 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b60e8e2sm83115645ad.52.2025.07.22.15.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 15:50:57 -0700 (PDT)
Date: Tue, 22 Jul 2025 15:50:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples:pktgen: This file was missing shebang line, so
 added it
Message-ID: <20250722155055.14bc916a@hermes.local>
In-Reply-To: <20250722220629.24753-1-unixbhaskar@gmail.com>
References: <20250722220629.24753-1-unixbhaskar@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 03:35:31 +0530
Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:

> This file was missing the shebang line, so added it.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---

NAK
This file is not meant to be executed directly it is
sourced from other files.

