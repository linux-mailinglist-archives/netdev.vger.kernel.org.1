Return-Path: <netdev+bounces-139461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A5F9B2AC9
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 09:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D1C1C2184D
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 08:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D5F192B94;
	Mon, 28 Oct 2024 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G2om3ARN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BDB1925A3
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730105672; cv=none; b=p3J2H6614iAyPCWl27xSZln0gCffFkiOwBzeTvMsel+ZMsen9naLLH49WmRBbT9mYYJ7jxQjdbarOcxje/MgaYC1x5NheupacbX50uhfr0nvHmLp6HJZXg406LFovYJtjb3u8eu2N7uAHbru71Ox9OWNvfLFPtOOG09fqNn9cTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730105672; c=relaxed/simple;
	bh=YUetvKzd46adoVApbL2fh+0ppPiQVBMI3J39BvdqVfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COK4lEWSYgtai7cL8iLqXRia5N5/oXYivr4JQtsy1FHVsVppauIFvjVB2jDmXNJzyACgTPxpz+Dxltwbzuelv7ypkJ3BK95Ad8ajrXmwerUeVeslpanY4yz/bCWawazwqT+MZI5FG6prdLtjmlkP9glZbFdl40D+ktLO46Md2RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G2om3ARN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso39962605e9.1
        for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 01:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730105669; x=1730710469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l/R6e74JyYvRc6gOjM1TEYninS6Et/kGOYELmgbhJKQ=;
        b=G2om3ARNFMCLl8BRBfwQSGa3nytgttrYTOZcWlmlJDmTTTt2lTEj9Gku/54REDAZW5
         l+RIQepstitStoDf8m/fHYKUYmHKMJUgQq4X7xfl9RM5HcvfXJNCsm16unsk1BDf5owP
         qC8+sUB1lV988pdAM0N2gC7eAOoI+DbXw0KeJuSXZRC+/X2YdpUa5yQcWm0ueD9f3MKh
         qfSfDjxGYr8ZY3pAZILr6ds2l2XgiO33e5dmyX7Xzmx/xRjafRndAZFXZdtLY7SJxBTd
         6ZRCOib0uhp5NhwIwc6UYrrCyiyo7MJV8G07BPy53ViZfSrMq7/XCZOxmYlDf8+ZaePK
         kSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730105669; x=1730710469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/R6e74JyYvRc6gOjM1TEYninS6Et/kGOYELmgbhJKQ=;
        b=XtodDZryrCQ0pInXEUYUKYfLivlxcI6EwKpRZBY7vhR0XZD3VEUGuHx5SEu5DZVOrj
         Plh8t0MumVgN5vPEnM/g7Q+rkLxNbOwuNfdYEbxI+d8aR4IXl+m5Bl6EVCLhr7Dl6g+c
         vPt64Sjb/V8fxG0ljd2wjbAWXpI/LrxO/t3km7KMFbTJjxl9ip6EZNjD7Rgct6diaFAe
         3D0lxaAxRvTyPpsT1/wgCNgJ3KrOU2ZqMxV8CKC8UGb6YZSMWm8cc89O1zwRcd1B8/N6
         5uK+Ir+wWRMkR+h8kTa2w4m+cXVrgT7alvbcsgGlDngFQW4uzN2C3ZqUGaDa2xLcBasf
         JAAg==
X-Forwarded-Encrypted: i=1; AJvYcCW63D2NuHDJDfpjGlVaj2Lm1v/42xsBiqCaLTu0CBxh+kBzlj1679ThpG4GwGCFh5DMoCwCKbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH1fnxXBh0M46fg06typbZTDTQkyTPJz02a/fFAPArG2Snqpan
	UoIdcX4wjdaxaV7vhofE3zxI1H4vDaFiYcfd3vZ3zHwV6C7Ay25fV7zM96xO7I4=
X-Google-Smtp-Source: AGHT+IFAR7aw2P0zLeO2hMSdxBoiLLXBRMAWipIDAb/3G9chQY281aHj3wqQikEwOL/Sd7zLxykqDw==
X-Received: by 2002:a05:600c:4f56:b0:431:52c4:1069 with SMTP id 5b1f17b1804b1-4319ac997c7mr67096825e9.8.1730105668837;
        Mon, 28 Oct 2024 01:54:28 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b567e18sm131027405e9.26.2024.10.28.01.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 01:54:28 -0700 (PDT)
Date: Mon, 28 Oct 2024 11:54:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Christian Marangi <ansuelsmth@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Antoine Tenart <atenart@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, upstream@airoha.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Richard van Schagen <vschagen@icloud.com>
Subject: Re: [PATCH v4 3/3] crypto: Add Mediatek EIP-93 crypto engine support
Message-ID: <2347a34a-f82d-44bf-85fd-e220c45deb8d@stanley.mountain>
References: <20241025094734.1614-3-ansuelsmth@gmail.com>
 <8011818d-bdc1-433a-a348-648955c55535@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8011818d-bdc1-433a-a348-648955c55535@stanley.mountain>

On Mon, Oct 28, 2024 at 11:47:14AM +0300, Dan Carpenter wrote:
> drivers/crypto/inside-secure/eip93/eip93-hash.c:162 _eip93_hash_init() error: uninitialized symbol 'sa_record_hmac'.

This one is a false positive.  Smatch doesn't understand bit flags very well.

regards,
dan carpenter


