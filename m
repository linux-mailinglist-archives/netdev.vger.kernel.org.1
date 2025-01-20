Return-Path: <netdev+bounces-159697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A0AA16774
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 08:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FAAB3A7B3D
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 07:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BD8192B63;
	Mon, 20 Jan 2025 07:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bGNrYKsm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A590E1922E6
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 07:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737358813; cv=none; b=lfLdwm3RKzbi/y+uYuY0VixLveFnEruhJfPBt+12KzYsyMtIfbeHKMc3EZXMaFrxyXR8ABoe/8rhODBXLjryCaq4cJt8V0yDmRgiVsB2IN0JltXVlAQFdtjFZWHv3E8hw9HUnafyhb4F5pIr0cEy8yqGavSHlspPnZphGUdITNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737358813; c=relaxed/simple;
	bh=YWIHq1/W3DMDvM/aHqt8Pnp1a5M6SlkR2kR7Lyu/8RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XK8JosVh4gVyKWxPvGrW66dPQd4iMNkYjEMi+OeiutQt0qGjZb5Qas7jVC+m9nMcah0HeSZ8gIPGFeX09LCvifZD4UNRADIsxjAI06+IWR7RizlhNW3JFEwszAFMd+icmQ+RdGAp9rkYsyjHOq+ygZECJxzQifKKUfDyZFTRuGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bGNrYKsm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso31460725e9.0
        for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 23:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737358809; x=1737963609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AE5EKEi1Hcz44IBUtJMS+BPfCCLOfNQz5T/5k7bksgM=;
        b=bGNrYKsmgeE6C311llspLLfg3iqfRcZTh7JhxjlrxCT7/dp7XyriDewssYRuuHYBtV
         jpA7jN00pkdNMF+FUhmwCVJV9EQjGmikwOElI+2bg58zEZ72DKp+Zs3Ffc7ZhlgKArom
         QiK2Ew957ctKBoDSgk6mgGyNtYiXfpYL+D540NQhb/Z2KdJd5h8Zj+CtH3s5zEmr1pLm
         m5QCAFZfOj/3qbdUol/r98AJnAoOLbP+qH5yZ7sDvBEJTsy24vg04C+wIpG517XW9mHf
         pSp6kU7sg8RcYIHmwK6Vfr4KNIZyL9oEwEY+22I8SdaGYPl0u1MhuePuDNkoAuVqnWsu
         u+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737358809; x=1737963609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE5EKEi1Hcz44IBUtJMS+BPfCCLOfNQz5T/5k7bksgM=;
        b=DCM0uzGG5SSeIPWi0hMKPjQAxE2GuiSAgtQSWdwpuDEfVGqHimbeCkmQwUuBX5ylY9
         8xsz8/iCyf+61n5FYEtxv1gp4OExqAzOAGkM6uqL6TfLmRZ7LF/mH8Z33KQFjDQ/8oaB
         y6xFWzRXbKsBpuBI2veQCOxxGLZYKsWaFELANQyO16Q3mct5K0I616MS7B3wujyOyh8H
         xFBTiKomEMNO84SvcRMlKjF6h7JayIp1xK12b8cEy/ylml5Zw08eOcrRjo0QL5i1AZPh
         org9lfOtMx2Wk/XeWAnHYW+QHdrlI97K5dy8Dvfj9Bn3q5K1wps8Ptf8jOyvIVE2dmDV
         OFNw==
X-Forwarded-Encrypted: i=1; AJvYcCVEWuqIFOpEQPA/pcnm+P9RBj4nWdlE0n4oO45TIw8oxdkEVpepmyinJUK/kqKzDW30xbql/xw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybaj/juBmZD2lNZY4qa0l5+ElkDGjlYZ4pVEgfrntzcJBkIgxc
	id+Wxd4K8MaUrri+Vy+2sKHD6YQNQ2vave+1ak+IcCd6/cBRZaZpB6ryqOApQhw=
X-Gm-Gg: ASbGnctUHvD/ZeY2IUShexthDHyUTGjWQgZ5C1mjjB71rPKjdAiVpQ+aFuSgvPNnV9l
	YWM4pI1k9CNNDuWUIfzqN6dfpwva5wy9prehFLjxUc6f3QJ1/dvM9DYV0eeSAQjz3jJQ4h+PYvc
	v0idqXOoMDoCKay3j+EpHyYC74goTv1CKfyyd8FimpKobxQVulqXwhBLcU03X34AUZkuQ7PNxqf
	wSXa6I0/awbYj8li9gfM1JghfjCchZsASQ8sskexIWXkJdMl5tnWHAWaOJdA5/28+B9jbukgd4=
X-Google-Smtp-Source: AGHT+IHY++/helopgOYKIdJhr5Gy0IZlYkzhzZB7FO+q932DyRrjCnxNoMiK12Z8NjK0J30FLX967A==
X-Received: by 2002:a05:600c:4f55:b0:434:ea1a:e30c with SMTP id 5b1f17b1804b1-437c6b468a7mr183634345e9.13.1737358808951;
        Sun, 19 Jan 2025 23:40:08 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890413795sm126097405e9.14.2025.01.19.23.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 23:40:08 -0800 (PST)
Date: Mon, 20 Jan 2025 10:40:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"t.sailer@alumni.ethz.ch" <t.sailer@alumni.ethz.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-hams@vger.kernel.org" <linux-hams@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH v2] hamradio: baycom: replace strcpy() with strscpy()
Message-ID: <92b603cb-a007-4f02-bc81-34a113a04e7d@stanley.mountain>
References: <62yrwnnvqtwv4etjeaatms5xwiixirkbm6f7urmijwp7kk7bio@r2ric7eqhsvf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62yrwnnvqtwv4etjeaatms5xwiixirkbm6f7urmijwp7kk7bio@r2ric7eqhsvf>

On Sun, Jan 19, 2025 at 07:34:51PM -0500, Ethan Carter Edwards wrote:
> The strcpy() function has been deprecated and replaced with strscpy().
> There is an effort to make this change treewide:
> https://github.com/KSPP/linux/issues/88.
> 
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
>  v2: reduce verbosity

If you had resent this patch a week ago we would have happily merged it.
But now you've hit the merge window and you'll need to wait until
6.14-rc1 or -rc2 have been released and then rebase it on net-next again
and resend it.

Anyway, if you do resend it feel free to add a:

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


