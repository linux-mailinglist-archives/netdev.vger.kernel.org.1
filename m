Return-Path: <netdev+bounces-123788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D700996682A
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 19:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155E81C23F52
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 17:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD58E1BB69D;
	Fri, 30 Aug 2024 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlBE04YI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B1F1B78E8;
	Fri, 30 Aug 2024 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725039564; cv=none; b=nRRHHk59DGC82FEkWHSQPuNBFXCBn9BXsL4h6YNddInrfGbVgiHxOu7iLxb7sqPZ9lpOzb0IomVgmzStXZh+fcEA7YGIKO+HlnwPxozq+3fS2z9bvXjBEKJbBSWSHGj1dg08otreVgIOsDRcmTpXt0h5PlDgq1kYrdL1qHI5E30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725039564; c=relaxed/simple;
	bh=Rk4heNgJ07G/k/iHA74I2zVVomiFFtB6rWrgC2mix38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPWJw0DVBewf38yRjfMpJ/p27ckKJfVcxQDIUZ56YKCqoYFhiq8SN1uVkOvAlBj1IL7nE27JFNGaKxNBXSbnoG6R7+/R67eIddnnnQ/YcbJuKomiXGjXeGzINMvcovsB5CDSKLG9k2bGPZ37CGIr7+YZ5E+IYdUD4/6L6i5darc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlBE04YI; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f3eabcd293so23362601fa.2;
        Fri, 30 Aug 2024 10:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725039561; x=1725644361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rk4heNgJ07G/k/iHA74I2zVVomiFFtB6rWrgC2mix38=;
        b=AlBE04YIspEQZJ6zdA2ZZ2DMLVd8+5cJnqghpmvYKdyKMyVHyX0psesKZIHAJqMd2w
         qkIJM27uJ9FwMmxSsSc3BT8QEFB2aS6cfaUt5pQ4XGjcYPuxj1oA+EfSsq5pnY5yhJRt
         ejCagCa3xwvO74s+1MedplN3mk8WmcYw3Pa5B0SiC8eDGTn4bbUfqG/vqtQ+IAe0oPfI
         bhnzferuqRAgkIoo9FlvUArPhMIAvkVa7ne+LmWm6afDFbCwS6M/yeNKS0KlWu2O8tcr
         fyW8yy36P5QDWzDvKw+emZcpGrixIPuhuJt70eJKG6gLVPZBXsTq+DTZrdpUpB5CrWTg
         5O3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725039561; x=1725644361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rk4heNgJ07G/k/iHA74I2zVVomiFFtB6rWrgC2mix38=;
        b=lUQiNQSGQzKI6fWOuIWHs2hapVEzvWMuq64Wzbue+xlx+gDbmYPKN0PcXzPed21oKX
         li9uk5kOHAGR69Bn+JpPWprfXDWg1XucGYk+JCjqABMRevtCBuQZJhJnwWxoIpDVIGVt
         LI/ggM7P9kIOc0C52PBhfq27435L2AGzHmLjHJB8qAf86/43ayEk8hfQWxUDGAGU3qF9
         CbXzEVPVvA+UcEgRltdFPsxDDviNqvgQbRLODQgQ0z/E9obqHGb9JzjawfP/YeF1BO32
         k9iqpBV1XfP3l8Kr4vRdHJJPQLHA5l2gHfPq9pBidC8fixhrxjWbHdHngyI11e2ywtE9
         YoTg==
X-Forwarded-Encrypted: i=1; AJvYcCVsCC01pan7wGXCc+bM38oJSYXh69AjPXiP64zuPVrAKFONId0JbcMDvmIunxVon6cRNtfLtu4E@vger.kernel.org, AJvYcCW/s6x+Df6JHUqbQSxDXgsXE8gGLsPhG0aFla7npX1tJ7fs5mikSLch1CV8c0Bd/ewU9HyiKVPpg7tl69w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxVEsjXzCudjI2L8h+Ncn9ICXsZ2SuY/Mxs+y4xgTCBVbaUZag
	o1R8K/4EEGi/KQ6h+AT5kYXZdtiBQP6cuLzznALuTG3ktls2eSPDwMutqstqPCPDU0ELWK01K89
	VbmnXpvBEdpCUt4OvHfhXYBv0zGg=
X-Google-Smtp-Source: AGHT+IHIPtnQN/arvQ1wK8jEShi1exTWQ1UyHbiq7p/BailmKivA6twYQIVXOJkMyhl02xgSmdzh2epfYYNmdIcFBSE=
X-Received: by 2002:a05:651c:1507:b0:2f3:fd4a:eac6 with SMTP id
 38308e7fff4ca-2f6103a71femr50226941fa.18.1725039560666; Fri, 30 Aug 2024
 10:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830010423.3454810-1-yanzhen@vivo.com> <20240830154533.GS1368797@kernel.org>
In-Reply-To: <20240830154533.GS1368797@kernel.org>
From: Marcin Wojtas <marcin.s.wojtas@gmail.com>
Date: Fri, 30 Aug 2024 19:39:09 +0200
Message-ID: <CAHzn2R1A+9PMNN8OH2OFpAcvE5r_5Dmzxz35ZE65v-paZ4thCQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: mvneta: Use min macro
To: Simon Horman <horms@kernel.org>
Cc: Yan Zhen <yanzhen@vivo.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

pt., 30 sie 2024 o 17:45 Simon Horman <horms@kernel.org> napisa=C5=82(a):
>
> On Fri, Aug 30, 2024 at 09:04:23AM +0800, Yan Zhen wrote:
> > Using the real macro is usually more intuitive and readable,
> > When the original file is guaranteed to contain the minmax.h header fil=
e
> > and compile correctly.
> >
> > Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> > ---
> >
> > Changes in v3:
> > - Rewrite the subject.
>
> Thanks for the update.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>

Reviewed-by: Marcin Wojtas <marcin.s.wojtas@gmail.com>

Thanks!

