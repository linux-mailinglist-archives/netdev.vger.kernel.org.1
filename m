Return-Path: <netdev+bounces-158113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 100EFA107AB
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1193A2123
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ECB2361EC;
	Tue, 14 Jan 2025 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bP3R6fkU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEE0236A91
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736861028; cv=none; b=aNW5Khe6aabsPUSGJE9cI2LzqYnxAyi6DCNZnPHRPVUrZMkWMyis+nxXYrnfCc8Mo1lHABF1tND5Y+bgI0m0Lo9KDhDs8AFAGGeLVxVU+a8nQ9RMRGyvmXwgGDgnBULhLA5ofKZvquA6iaf57ZqV8waA47Zic+MgcPhmvk1LZ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736861028; c=relaxed/simple;
	bh=zUt2z/v+xYXYU6CurSPflaIbiSHerUVbIV31vtMrv04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnhIpB0D2IVoDcmQuX4Te97wKY69OlMdAh4ohpZgb/t9nydZAy6ZNP14lQ/v35V0G//Dqg29q0AoxxAC/CoNE9x3LxHPUnGOu9jYWIPWBirfaAFVEZCX8Q0aTvZHmghFGZePiO5+1ZHPAWjrGZqz5xCRRuXWyOvAIt5aUArXy6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bP3R6fkU; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3e9a88793so9162700a12.1
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 05:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736861025; x=1737465825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uw0ZgqtZUw3HomhdvzacQGq5HfrmisK01+KsYPwFWiQ=;
        b=bP3R6fkUzpRRiRe0TGBhy3+iEY02BFpMwjFI2FKsE9mlh6mjW/POwjZPLLYpdtrqQ7
         UB5jWIz6zM6s1a3kMOJL7w3G74rxFQeBpSHRtZl6as/JDIGy7s8d4V7OTrB7yAMrSzFg
         YYYl4rvCLKcpUz9DtVl8x/3eqfliBfWWAHZzxKWslp3QNNDDqx77SIUUz0RFuMjxcnjy
         wpZjauYV2+g4Je93wp7DK35xtbqvY61cSUOQNE6AgYLaXYX5XUzwPL4/6UgmyxQuxejb
         c07RpYI3P6XiLdXS9Hbq5naivo6fjQ7Q7Effhju/rzORpa+xr1g4qiFd66dZX07knV7j
         prPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736861025; x=1737465825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uw0ZgqtZUw3HomhdvzacQGq5HfrmisK01+KsYPwFWiQ=;
        b=L7nAc5MQiZ46pGH6yWrjuUcakwbarDqd5iH9BFdhzRZajtsABlGthtwvILGBBnNpJg
         ELIeDcvzYy5X9rz7XG99dgJIAosilHEgfe+TrFwG1yAruC4d7vdRL5CZUoeUOEaPlVXl
         FlRXTAlHbrMQn9+o0sHs4OFR46fPZNzwzogRWAr6HSbOTGsmSvoVRPKNkIrvSfMWxA2N
         vJfrygbrt4uUEkIzfed9D+bnw5hGVgmk1up2sT0v8IJ8i7q8R5haEWYHehb3PmNrz5HI
         GEwN2NM9ftYf598QoG6olNI4R7R+LRL/JpJ8vQq+wpUCinZSrv0Vc4XCA7zxhnVlSWyg
         TCMw==
X-Forwarded-Encrypted: i=1; AJvYcCUafl+w74hOdTOUj0WfLNtb3KSOA+Dxg6TMktNFXkWxXtNGK+CZgkltH4Bc+BNp2eYyP99dc4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIg/R8hQvouej5Zir/BHhDkchlSYdqbLUfjgqAruq791hiNKHc
	6yHpd1tCnNmy6I2Mp0HABPJuluoyZJYsZ7rtxwNqC32l+xdLGZX/7yNzqtmLjAh2lUrLjp8ucry
	YJ2Pv01Af7BVvInsOKhgfmpS7M7YAvsBDmpJV
X-Gm-Gg: ASbGncuKhwmq3ZwqRBTiLwqhDppGFokSSTTPxKW/qgd2n1ylB2DFGtlK+G0DezGeUdp
	es+bW/XK9vdJ+4SfhfXAxTckAbKfx/chLqsFetQ==
X-Google-Smtp-Source: AGHT+IE6djphQjL1MEwOnkEEvrvDrmMlU23zKRKNABMyX7EgjtISUfRVcUG7GMQHabQ3Hu6qLpyGTacqHTsW+Po9nLc=
X-Received: by 2002:a05:6402:4402:b0:5d3:ba42:e9d5 with SMTP id
 4fb4d7f45d1cf-5d972e06b36mr22872241a12.9.1736861024709; Tue, 14 Jan 2025
 05:23:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114035118.110297-1-kuba@kernel.org> <20250114035118.110297-11-kuba@kernel.org>
In-Reply-To: <20250114035118.110297-11-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Jan 2025 14:23:33 +0100
X-Gm-Features: AbW1kvYGmxwyNT37MSeXX6xiufm5ebasol5YbUWH97AMmMgZcLxEO6geCttS4Gk
Message-ID: <CANn89iLJtrMaoHY4td71x30O_s-FO-HNRhvUHBV-MWvb=uB6iw@mail.gmail.com>
Subject: Re: [PATCH net-next 10/11] net: protect NAPI config fields with netdev_lock()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 4:51=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Protect the following members of netdev and napi by netdev_lock:
>  - defer_hard_irqs,
>  - gro_flush_timeout,
>  - irq_suspend_timeout.
>
> The first two are written via sysfs (which this patch switches
> to new lock), and netdev genl which holds both netdev and rtnl locks.
>
> irq_suspend_timeout is only written by netdev genl.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

