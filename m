Return-Path: <netdev+bounces-99084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CFD8D3AA1
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 17:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F92283CD2
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 15:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8574B181326;
	Wed, 29 May 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l9ruISG/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A6F181309
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716996030; cv=none; b=qSVdeGK4rdbIMSjrnbrrQi4tfXyFMAmdUX+QDcUBk8+/yMIrR1M2fAaw329eEQoda4Qex7QoXNbGs7tmSgquxsxPO3Xl4YKqZwX/mdglEAEbm8QNrHjuSyF0bWomNky4HHcczA3BCiMQVF7mEurPp/UDalSZ7Wj5tfj4dNURE48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716996030; c=relaxed/simple;
	bh=HKDPUklsnxlG+mVqbEl8APDzYt/yZRfVUStmJCPSB7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFMRlmqLwuHo1GvAPSEkVwSUfOqsrjCWPNo1n0hjCp50PruG8BbN2FlltRYe5ci3WE4xZEUvCzLb6jg1uLh52gj12i/j2X5Z8OQQQpoMn1K+2mFglTwcIjXxQ0nKmViP0ClQgwHsfAI1kImL2tQOQU6jkim/Ct19vMxz6m7v0hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l9ruISG/; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57857e0f464so2891018a12.0
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 08:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716996027; x=1717600827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ssWtE6S6mHdnxlC4elwxRIfkxjFvIJnV0sZqtOYQD9Q=;
        b=l9ruISG/OsgsirBK0J5th1WdfzZg8hE6xrm8PdA0IKvn+J9ubcDYs4pWLwIn3wDpxm
         fGHz0q8u+TELFoku9v1iKDqemT5iESF9yqEzp/ZYDACxV4xR0H0CuYWXcITCjEYmafEM
         l8iDYxDD9eMx30yXsVie5UfWOfgjfD2WdT6jcVOMKvRAxevuuh7z771RYMzaMRZPhSGv
         ZvRUPTl1g7irIZ3QJf4CHWLJPek17UYoNB3Ehd4gOSfnbdCtZnhOOXVzhTLqEVLi8mqm
         81wvvvyif0jlszSlxbU99T0ag7vUVUQzTsg6xaNRZSJWO0/gDxN2bB9sGTc+gQ688zR7
         4GVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716996027; x=1717600827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssWtE6S6mHdnxlC4elwxRIfkxjFvIJnV0sZqtOYQD9Q=;
        b=VOFc8MSG5QnPAs+7HtdzBwx4eiYobN0TJ6rSd4oAod0wX/bdskHCBND3CvypCArWLh
         swlf320lk3Ngfd8ABT3zVAaaszz9pRUWJUhlTc3J0c1a3pLpmiSEOQORk9DO8HloxKAF
         /9cLqqTtrnVUuw+pdFJ/sBXzrt73zRlwzZCu2Qn0buHbjikT/d8D/HdnbuPYWuKRQXbW
         vFc+A+xY48loDau+Mm0ZsaPwFYoTQXe/imclgZOPwyAHit/HzVe+coYMKaySae72T65x
         ARHzUYiztYkFWdXg2r/fB54+UxCdIJNPX8BuQ+5kjwt+y1vhJt8w2G++XTdO1u2wbInE
         cGiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdNRbipntEBefnDyx75OpS0+otDynqb3H9Qb9vEt1LIVvM7lUU8gt0fyGRy1gY0Envw+yD/Cqm9IHFw5dwxnuebULyvjvP
X-Gm-Message-State: AOJu0YwrFeAtxbOrT3eAPhNDgcAoD04PedzJE6Vuq/cpqZZXS3MGTa/l
	9djvoyGwJ6TTBYB4GguDi31jf1dPSeyFphZK9grXKtJgLLwbMjh2/0UlSemxUk8=
X-Google-Smtp-Source: AGHT+IGXJQft27bLZUlO9LEC0uwj8lCzAwFIpMjeEEzR4cf87fPK9kl1/HUFfyeDxdbCKBIDPDHafA==
X-Received: by 2002:a50:d617:0:b0:578:6198:d6fa with SMTP id 4fb4d7f45d1cf-579c4905902mr7299495a12.2.1716996027003;
        Wed, 29 May 2024 08:20:27 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579d018ef3fsm4580123a12.13.2024.05.29.08.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 08:20:26 -0700 (PDT)
Date: Wed, 29 May 2024 18:20:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lars Kellogg-Stedman <lars@oddbit.com>
Cc: Paolo Abeni <pabeni@redhat.com>, linux-hams@vger.kernel.org,
	netdev@vger.kernel.org, Duoming Zhou <duoming@zju.edu.cn>
Subject: Re: [PATCH v4] ax25: Fix refcount imbalance on inbound connections
Message-ID: <3ea61b17-c893-46ae-a338-090cf1c6618a@moroto.mountain>
References: <20240522183133.729159-2-lars@oddbit.com>
 <8e9a1c59f78a7774268bb6defed46df6f3771cbc.camel@redhat.com>
 <rkln7v7e5qfcdee6rgoobrz7yzuv7yelzzo7omgsmnprtsplr5@q25qrue4op7e>
 <962afcda-8f67-400f-b3eb-951bf2e46fb7@moroto.mountain>
 <7bfn3g46beatmbp3bzxauahdiitb67ncfixp6znjdc6e5gj6mc@ldmt3i2wnqpf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bfn3g46beatmbp3bzxauahdiitb67ncfixp6znjdc6e5gj6mc@ldmt3i2wnqpf>

On Wed, May 29, 2024 at 10:54:45AM -0400, Lars Kellogg-Stedman wrote:
> > 3) The other thing that I notice is that Duoming dropped part of his
> > commit when he resent v6.
> > https://lore.kernel.org/all/5c61fea1b20f3c1596e4fb46282c3dedc54513a3.1715065005.git.duoming@zju.edu.cn/
> > That part of the commit was correct.  Maybe it wasn't necessary but it
> > feels right and it's more readable and it's obviously harmless.  I can
> > resend that.
> 
> Just so that I'm clear, with that comment you're not suggesting any
> changes to my patch, right?

No, I just noticed it while reviewing the code.  I'll take care of it.

regards,
dan carpenter


