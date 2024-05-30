Return-Path: <netdev+bounces-99292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7C18D44C3
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 07:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000751C21962
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 05:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B85143C59;
	Thu, 30 May 2024 05:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z5ecP7pU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E64143C43
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 05:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717046612; cv=none; b=f5JNi51POsWNgQF5xaMf8HmNI/UlbZCBl6E/rwk7Kevjllmt8sr8gbaxKyYNL2DYz1kHO4uBimLMKHpYk5a6JLDAum19O0pK1oD+nwkMwooKWeU15zC+1XU/EWOEX+NrAxQ5tpKu5R4QvFbm3xWqjb4Q1NBx0OrzojybJPiPa3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717046612; c=relaxed/simple;
	bh=TwgH/gtp7ud9+239CluIrGaOMiwBf3gKb2ExJUd3xZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eE48ZJ/LOTGzipzouSRKGdGsD+weFMmWCwFDwW32BGv3Nfz28AHn6RAwj+hQquvRiyddDp1HFdBsH6K0ibw0LLY0hpo8imi2HS3/af1qvEvCFfIJIX8mEyprogVXh7RtnI63I5RpkwBbBdTOWI2QTMXVKG5metnDVMe+RYlrXAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z5ecP7pU; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57857e0f45eso490075a12.0
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 22:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717046607; x=1717651407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2iZM41/7mDcxSquoq9LoXz/QTVE6+9mFjNqtqD1bGyU=;
        b=z5ecP7pUet8Rr5WmXPgJweB86JyLIUr1s1fduu59LwQ34njQGmHLc902a1FX10vocM
         pHzFe+rITXMnN7CsO1qcn8+5KvPSDUBanGpwEvScTC917icqNJMgC5ToIswNIQgbzd+B
         oQ705lR1d0bXV0fNZ+tgtSvUAGi72DP5UHbQ4hSkByrmGqplXNkEwa2M1KjXI6HsuFJ3
         k6nsfuSmVBzKkm4d/VCv5dFbVzXxnd/SsDMjGfrK8MBFAFyfY4+78YIg10jVJURd6/5u
         6Rfo2tUl9wnoVikfuqbSkJhKXRCtFj8oFWNb8L/9MqAVkHLc4YZkK8JZED6FfuH598IS
         +Nog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717046607; x=1717651407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iZM41/7mDcxSquoq9LoXz/QTVE6+9mFjNqtqD1bGyU=;
        b=HMv9qjvQVLDpeBZ7/COrDYH+gZa02SyqZZQ8oenjJHTWqvALqfNBRU85DeKGqliTiv
         pmPAXcdWQ6xPriFXBoH+yNx7Xop/w0x8cOUB1KOWV/qLGmUh2aRH+Vjj5qlGBezlN/Fz
         EKJ6PaJZzx8XDq02dYsYp+KISFHyyVGsl9bbD2aXIwDEKrasl2v0qrg3X57AQ9eY+QqO
         ZKx4fRl8B96REG0HGKV/nDFIUJOJHN3VC5oaiH4P2yQw3o39cUBLSLOxw4LygWcgrJpd
         BRVEt7B1XrfSaGmR4NMzz7W9ggW2I+2cFJsd4px/WsNcmQ2whN4FQw9Au+BOeY3dE7n5
         DYDw==
X-Gm-Message-State: AOJu0YzXVRH2SupQeNr0h1Spridbh94Nz1IZfhidTzzGakUmAdB8RcSW
	EdrK2pVqnmjcB2PsJGqNz8LJmBudyMQRuyfcZYSX1OnYWpVtgowBXu6qgc3WiKI=
X-Google-Smtp-Source: AGHT+IGiMaKK5C7BvwqxS4g/xaQp5YmZ3lVzVjOtS7XaVjrsTEqCqQs5N4b7kUks2zW4UQQDfV9kjw==
X-Received: by 2002:a17:906:1319:b0:a5a:5b23:c150 with SMTP id a640c23a62f3a-a65e8e7a77cmr111535866b.41.1717046607193;
        Wed, 29 May 2024 22:23:27 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc4ff24sm788862066b.130.2024.05.29.22.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 22:23:26 -0700 (PDT)
Date: Thu, 30 May 2024 08:23:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hams@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, jreuter@yaina.de, davem@davemloft.net
Subject: Re: [PATCH net] ax25: Replace kfree() in ax25_dev_free() with
 ax25_dev_put()
Message-ID: <69dee6e9-05c6-4d1e-9c69-a9b60125d7ab@moroto.mountain>
References: <20240530051733.11416-1-duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530051733.11416-1-duoming@zju.edu.cn>

On Thu, May 30, 2024 at 01:17:33PM +0800, Duoming Zhou wrote:
> The object "ax25_dev" is managed by reference counting. Thus it should
> not be directly released by kfree(), replace with ax25_dev_put().
> 
> Fixes: d01ffb9eee4a ("ax25: add refcount in ax25_dev to avoid UAF bugs")
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


