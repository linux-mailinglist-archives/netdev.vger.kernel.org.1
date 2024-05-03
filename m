Return-Path: <netdev+bounces-93368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66808BB4FE
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B141C210EA
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 20:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B832728DC9;
	Fri,  3 May 2024 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fz3bhjId"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291B723775
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 20:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714768825; cv=none; b=DUcVH4bm8nyBBdYL6pni1BDFBmiMVBxlUM0hqY+iJuM/GMgVAd9mCGVatI5zl/SzpTkL1/EuhOveSmvOSxpWvt3LJU4iD9yvEZzKZTz3ihQfXyMemFIGWjE1yANofhuY/M7Ab9wVElgbMnxmiNd8Kj0/kgDsJ58+MMAcu/RaHU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714768825; c=relaxed/simple;
	bh=FzWh89LnKN/2rPVaiDqcCRxHJiQvPMtsLZtBAhKO/80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMwQrVt8OhqjywX+sjT6okKa8ytFB9PasOpT61Aoypa1MJsFyZE1zh7zqlCgQ+IRg1tKVXyg2v8AgPILkLInb3i+cFNnYipT9TvxYUjetys1t1Y8QwPWPRFut+/xjoGZLZSxTWdApRp9zfmsnrAB80hUr/xrSgJOuTi3R0cHD/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fz3bhjId; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41dc9f98e8dso14149635e9.1
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 13:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714768822; x=1715373622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EDVI2lxNIEoHBnfc+c1mdxSwHaEoO/v2D+NGdQ5K8Ac=;
        b=Fz3bhjIdUieLRuYEOE3uyb23Ld5Lm53vdvJQp5O1U7TcMrhYJ9XUWlJfZGxfoTAZ8x
         yr/F3sUOAZoJDb6OpPk0ylskwvXSDbb5G1xjXHPZqU7PittfXMRibVFu94L5slv4gewr
         tur57wWgzbNFKLO7SWC/RqI7r87dAcmCqphkSIVSlhT6A4z65XV4gIJ0CUDWFhZw/4jE
         Jhejt9mtI7RF5kPPJhhNI299Bztlnh9qUi3dH2kNJSSRxgmIZ1MUZZgRv1xH7DitLXUY
         zyoUMidA/joOEB09HGpDDwwPmBNX2yFS/xPMohi3rT7U93ZkWQusGe38+xRexTyPiU/r
         dCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714768822; x=1715373622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDVI2lxNIEoHBnfc+c1mdxSwHaEoO/v2D+NGdQ5K8Ac=;
        b=MvYY7JHFllJVelK8rKLYrI0FBXZlrEG4jD6liQpHMtajWg5nyfqruLctQ8bV0wAym6
         xBraCenaHwKGA+aWtsgK2Tnk/WZyXuXoSZ+1sQBCXAPfZIJ/GYZf8s9Zn+dTbDZgFL7E
         sio9BMjMQNOpMVT6e/PuC3FIM6j9M3iv2v8DZU5O4k+ZO3id3aUrmMJO5ARevy4bwcZ7
         kw/VaibGI0v2zxQkKq+92iShcyLdo8Kif2QyaHzj/IYUJ90h5cNLoEcEzLY3U8Y1f1G9
         zhJSdpY3e+S20h3xG2C6Qc4NYwPIqDUsq3roF+RedEw+LkZ8Lu5+V0SGrHrb5B/guAvU
         ox0w==
X-Forwarded-Encrypted: i=1; AJvYcCXlWsAn8SU4/zvOMRAJWzOk0tg7Yh/uzjqBXqjNsBCy5rxwidKGaG5dVLPT5Fwgqj8E/4MIY9AM9ZdDqJ8GgGr/GS4luh2H
X-Gm-Message-State: AOJu0Yx7iHFslb9CgRKY0cEp8twEXbqDcD5Lp/7ZRnrpPdTo4LyGlIzN
	87cR1kIPHsa4Xm/n3tYRn0pmM+r/rypbuWQdvtRL7qeIuqUB3ZFk+lH1jvWaQ5I=
X-Google-Smtp-Source: AGHT+IFe4iSXZoJhuPdxqGmWEAclAE1SSjrlr58XewUMveIRQamI8LNDgaNu5eHGZFYo5X1d1Xs5ew==
X-Received: by 2002:a5d:47a7:0:b0:34e:8f88:e1f8 with SMTP id 7-20020a5d47a7000000b0034e8f88e1f8mr2101178wrb.30.1714768822193;
        Fri, 03 May 2024 13:40:22 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c359100b0041adf358058sm6770889wmq.27.2024.05.03.13.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 13:40:21 -0700 (PDT)
Date: Fri, 3 May 2024 23:40:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] gve: Avoid unnecessary use of comma operator
Message-ID: <00eaac4f-f8dc-4140-9eec-0c17bc6012aa@moroto.mountain>
References: <20240503-gve-comma-v1-0-b50f965694ef@kernel.org>
 <20240503-gve-comma-v1-1-b50f965694ef@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503-gve-comma-v1-1-b50f965694ef@kernel.org>

On Fri, May 03, 2024 at 09:31:26PM +0100, Simon Horman wrote:
> Although it does not seem to have any untoward side-effects,
> the use of ';' to separate to assignments seems more appropriate than ','.
> 

Huh.  Interesting.  I wrote a check for that in Smatch.  The only place
where it would matter would be in an if statement.

	if (foo)
		frob1(),
	frob2();

It's unexpected that frob2() is included in the if statement.  But I
was never able to find any of these actual bugs so I gave up.

regards,
dan carpenter


