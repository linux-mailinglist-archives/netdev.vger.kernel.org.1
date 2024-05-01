Return-Path: <netdev+bounces-92812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E15E18B8F25
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 19:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BC41C2130A
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 17:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6677312FF8F;
	Wed,  1 May 2024 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUPQZn5d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5A4182DF
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714585426; cv=none; b=HQDunCNCXqZrat2THRCUk+uRGUV1vx6JvbAlYKDvnynt7UUTNey2lh1WsxsO9EWMT6M6QW0enGQbrHlZjeFvGj2sPZTo4Q7poGXTyjfTwwNUUBll6if8uG+FW5teLSz8CuME9tbcqvi/f5DJvROYiNTYcKVvhSQNaWZhSEYtezk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714585426; c=relaxed/simple;
	bh=3bmTWYwRFWLcqerdJa5XqE+bQEiJYPRaVhoVBhWPBHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0NpOkiYpduRQWO0Z5VLh9U7h5DWENM8ZTzO2aw32GLWapSy3IvoGIT4nC7xJUpJRTIL5/3DHrXcYofUYdXGVUNOkSwT0E+qjRAWzg53DphxsWWEkDWniTkE9RpH3aOlhTy7rNUq+CA3kaoW3pq9Tpl/PEBLGy3ABZxfsRDMhcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eUPQZn5d; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51ef64d04b3so520671e87.3
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 10:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714585423; x=1715190223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3bmTWYwRFWLcqerdJa5XqE+bQEiJYPRaVhoVBhWPBHU=;
        b=eUPQZn5d7TaEoJSsjp25jtx5rg24DhMR4W3IErzep++MHMNOXuhjd6NvpVSKMnfD9h
         rQKPXgZ2yTuLdTi/CfX5xCCDONQ1KaJ+r9cGfA6qQ8pI85hP878bIKTIGHLL54QUYtWj
         7XbaotcFIBR9yID2Wt88+uenUlqXW4gZDVseFiShCE4ZXLFJ/hDMhuI9PjzQcFqBMv8W
         jS6Ip9nsARfaCXNYnA2jTOt/8HH85VLcUIZkc4+KF6kFYLKyyqDPAOwEx6OWHS2AGP4P
         s2CSq71js5XPP7h9FndO1C62XnEn0OwanCYV8LkX1SndpoQhSlEhy+fJiynNzHg+PL62
         RXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714585423; x=1715190223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bmTWYwRFWLcqerdJa5XqE+bQEiJYPRaVhoVBhWPBHU=;
        b=gfyUmrE6oaAcgDhqBB1kg0zHASDOZFsoTF3VqQb/RsA2p1UgM7TPFUmUTX4/egOPJJ
         E9DTT+4dFKG35iNwd3yGJ75gp2Z1jAVPcBk+WCRkRLj4pxncl4ubGZPfE9yjaV6qbyS+
         Fw691AR8imost3sr/cCzpaIsqqI1FfnhI780V7x8aBKqhz4plflOompoV/15GQtX47Ik
         dMNDCGOuUvpaJlQjC4W1oXeU5+Y2yKqa0WC4DhR8SAO1jhFkZFGtznjcyy1QGbyAuQQT
         t6hXL60QoWSYIteFWTonK5/o/9U/J5SOfwczU7lRf8dK5hGjz4WuFUojPai7NxbGyzKn
         d3DA==
X-Forwarded-Encrypted: i=1; AJvYcCXj2pPmsAkNWmBtauZy2i2bm9V7qdU1TTBlW2MDn5kFBJU2u2TJD7Juj0LGFh0KK+qa5BYU+FuIkYeY1qclbReh5VWQgydG
X-Gm-Message-State: AOJu0YxG+PL888nk7yn/hBb3uykqffRjyXGaJZu1NDtthe0nX0AXDeWo
	CsabF01p53UNjfrdDICRI0VK+kmIeNUvkA8axXs0l3RpX0YwgWVTHrrpNcVPUXk=
X-Google-Smtp-Source: AGHT+IEfCIWUVgqYXG41TceguPXTQ+LH1imEyNeUiPyIb+1mgoogJOusr6dty/3f0bMhz+BELrLJZQ==
X-Received: by 2002:ac2:48a1:0:b0:51d:9e17:29f0 with SMTP id u1-20020ac248a1000000b0051d9e1729f0mr2326819lfg.24.1714585422462;
        Wed, 01 May 2024 10:43:42 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id c15-20020a056512238f00b0051c76aff880sm2212482lfv.43.2024.05.01.10.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 10:43:42 -0700 (PDT)
Date: Wed, 1 May 2024 20:43:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-hams@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, jreuter@yaina.de,
	lars@oddbit.com, Miroslav Skoric <skoric@uns.ac.rs>
Subject: Re: [PATCH net] ax25: Fix refcount leak issues of ax25_dev
Message-ID: <7fcfdc9a-e3f3-49a1-9373-39b5ad745799@moroto.mountain>
References: <20240501060218.32898-1-duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501060218.32898-1-duoming@zju.edu.cn>

I'm always happy to take credit for stuff but the Reported by should go
to Lars and Miroslav.

Reported-by: Lars Kellogg-Stedman <lars@oddbit.com>
Reported-by: Miroslav Skoric <skoric@uns.ac.rs>

Lars, could you test this please and let us know if it helps?

regards,
dan carpenter



