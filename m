Return-Path: <netdev+bounces-121475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8F995D4C0
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 19:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7711F22FBD
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 17:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82159190675;
	Fri, 23 Aug 2024 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w3KW09pJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D695618DF81
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724435810; cv=none; b=dQ6xxf4iut7E3Z8f9jOl48sLSzocR/SggVm3GQ/5DwCWTeHHJRUFNd+zUqfNpTqxyNf1kvc5ZOqasvbraYZR8W656rGypA4iTcQEp5OjOQUymXP/UPlq61fZFW3ATjr7JDBtAti5bLgvZzhGefQRh+ayMAEAhCOFX4Y7yY4z5EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724435810; c=relaxed/simple;
	bh=5EAkUOO1eNEpKl7lKdwoXdo6q7cdLYxByZqnNvS2DqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMhRx+0uuveTfTP6fLLtfbl9cmQKfFmkVWTI+e5Kvamscw3QhQCj+zqdX5qya3dgZgbQ/kJ2/BUsnv91XAyDyLkNZhTUm4bzKB4C/rExck84k6NH4G8CJSFDzXj9chPYlPQNRUq1Wle9/B9yvkGyZW2fhjElSeCzR3ktfRbqzv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w3KW09pJ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a86b46c4831so2219366b.1
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 10:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724435807; x=1725040607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EAkUOO1eNEpKl7lKdwoXdo6q7cdLYxByZqnNvS2DqU=;
        b=w3KW09pJHwVoSx83XSoHMZVpqQ8WDKITgQEZZ992sW2HY01oc4hTZ2gzyuEkDkq/AU
         E0Ee7OisTrkFHlTzW41WlD8aOA2x0bQL7R59CHpmSGP17bDRVpXB9v2butLq+vMBLNZm
         EaLPJyLrN3apHRfS9mjDVTQEco+uED5XCHoviVFXTsinisYRqtPXY9tIP6KGD43Xoujb
         T4QqYAk7xiMjLz+mO3bPF4sgBjDVoWEpckdgSgahpNp2Hpet2p0rgDhIa6HMWEyKTRgQ
         O/Taj75+RxzQ50LunrA13gwoUY290UMkosxJFbB8D4PGygCrmod+ZiPMOwUPEilH82sp
         aSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724435807; x=1725040607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EAkUOO1eNEpKl7lKdwoXdo6q7cdLYxByZqnNvS2DqU=;
        b=rDyW9NAoKqnG/uL5BLjdKUJAXbL2aKaUNpSQSjFjgiGKF/tUzzo1U4CNPyB4Ch+yKz
         voi7CSPRQu3AI3TJ24rCAr3u7Yml+DLE87e3AnvBBlZMdBXsmsunRTfiHaIJo9xXHFYd
         xP3QbZYgdSSAk9tRCwsYPAfZTwU+k4oY7hxpp2SyPbbNfft3pyzdoWIpbl0lqbM7S3Ad
         cF+ajJ9h86BA1B934MxhOfrIn/htqn+PAa7y6M8gQ/WMKit4ivyZIBaVjHDA6+HAioua
         iXlG8/Yk4M8Msv+RthWrXxUrSTMAOruao4KMCKMI7vqmAjIjSRaGHKFEPTEKNnqSgOJw
         nj5w==
X-Gm-Message-State: AOJu0Yw1F0n3GBhwUxTdufkARZSEH88AICfrg5EnmDfHDdxAUP2waFim
	RmKWmk2/YkKQAaAjzCrrVgQrLKjzQxIcfEF6mO5+loonqnk6xvab0/44sXsyrVbLij6iTCQ2HPx
	VNsi+CrUeaTlRIoQ4GQLl/9j216Z5Tqip10BZqmDbGHeThY6Ogw==
X-Google-Smtp-Source: AGHT+IFwFUkQt4oN9JaPIbh+hQ2AzBqEeVIVAQ4tf/anTJHMyeMMgrfIltpAuTebGN8cKml67ilk6JUfiTdxWvuwcdI=
X-Received: by 2002:a17:907:1c20:b0:a7d:e84c:a9e7 with SMTP id
 a640c23a62f3a-a86a54d1acfmr234712566b.53.1724435806499; Fri, 23 Aug 2024
 10:56:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823173103.94978-1-jdamato@fastly.com> <20240823173103.94978-4-jdamato@fastly.com>
In-Reply-To: <20240823173103.94978-4-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Aug 2024 19:56:32 +0200
Message-ID: <CANn89iJmp2yviC=Z-n7-=suw8N=SJ7uoy0xy5LMQRKDhubNBZg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/6] net: Add control functions for irq suspension
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, amritha.nambiar@intel.com, 
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net, 
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org, 
	willy@infradead.org, willemdebruijn.kernel@gmail.com, skhawaja@google.com, 
	kuba@kernel.org, Martin Karsten <mkarsten@uwaterloo.ca>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 7:31=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> From: Martin Karsten <mkarsten@uwaterloo.ca>
>
> The napi_suspend_irqs routine bootstraps irq suspension by elongating
> the defer timeout to irq_suspend_timeout.
>
> The napi_resume_irqs routine effectly cancels irq suspension by forcing
> the napi to be scheduled immediately.
>
> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Co-developed-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> ---

You have not CC me on all the patches in the series, making the review
harder then necessary.

