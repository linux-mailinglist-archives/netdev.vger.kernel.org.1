Return-Path: <netdev+bounces-247675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A123CFD40F
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 11:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 709AD303A39E
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 10:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0A332AABC;
	Wed,  7 Jan 2026 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8FV0YP7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F38311946
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 10:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767782444; cv=none; b=BMs8x0mWYinNr4MzNeA+vjLUZVnmKFMeBeRi/Zh4dcuYTUzN0KIpY6/f16D0iJ8h5PlWZ9Fo2a6niu6xFd4hW14CD5TzQcFQuxJCCWuik3syKEB43QNU/p8WPXWjwdzppElWXffsFatexLyGf7y1hP1mn3myZ/Ue+tPdWxc1y5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767782444; c=relaxed/simple;
	bh=W65ywHkxr/c/KCyfBI+l7f4LxqL8QCrEbzadamlZa8Y=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=h3VD4P7cQt/2pZi1pS0K+8knv56ziqAabuWmG3JbwTLY8ptSv0yZVxy2XOy9OBksO47v7ksZNVl7f0ltfM1AbqUdAmGanXrEHLF2iDj1XHqpPlR93fhaEOvUHAthxtlCCw2TEA45FaeRjKsRiKAHx8aGAlF9buo0JAusMRkT9hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8FV0YP7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47d3ffb0f44so12536635e9.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 02:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767782441; x=1768387241; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xlNKU8snKxPrM/xhzQl925n3je13gp0n7pC/W8KVq+k=;
        b=R8FV0YP7iWNsRxJgXmIE4SLGIkr6L4YJV6TfQvKTIX9+DKn/3DUiakPC/oDC6P3Pek
         vRKDpoh4552w0olL3+Tw18Egr6FBfPSz478Y3W6VxsaQ0RY6Nr/GvuMo0+maQ6gDMlDn
         6bW56EOEGhC3BZFKLwvtH6BUSVVL3mMCyFbVP6IvEJyoegaVLBiwwnB7xVQqi2/CpZOa
         MDs7jboRlCBJ0+4U16MVPIsjKJKwW7eQ0yRN0ehA9citOd1zfUvrU6lqwSN9uX4oYR71
         M0tXn2ank6Z5AHHifQEUBufxTEiA3RmtBtIUWJmhsr2boT6xuL+ICGfGFlKJtswvO7zN
         TLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767782441; x=1768387241;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xlNKU8snKxPrM/xhzQl925n3je13gp0n7pC/W8KVq+k=;
        b=B7vgszW3GgennmVdgqYqKaJoi76tCCyblLlwVOBwmdPzUtFL8zpZJbjy9PRY+IZHrn
         4DJprVMeN3YFYpuF3V74heHGRbmJek/j9XqHk8bYKaYuRDheNjzVkcamjIIxa6vgzlS0
         53Sj4L1fyvEEYbi8e/qgkme+BvnHVfM9gRgHqvkDdKeVeij3AaNwcTAJsoPyPse+Ef4F
         ZVr3bGF4gd3WBwoB+vMMmpNkr45EPQ4T4t+YTzMeZVmRa9em3cYuRAnWhftKDsVbOKZj
         RCmrHfxhv17HvV5zDgIYYIw0eICWGCbPWh4LtjEDF0obKt1GI1nis8wIfAeCnKKarQzE
         /SPg==
X-Forwarded-Encrypted: i=1; AJvYcCVyRj6icrDXLYON3VT3dYRdVF25tPG9+EVjHcvLha8TRc6tGhPonWCMqZIEAOt+XvA0xo9+OTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Ym/Ou4ZmwQu6iOQuWt0gUrKM5xji4w5BKsOB11FxHFz5JZUc
	jnDWw1pW7u/WoMwoRAYJYUNYURF0yxcXb/E65og6hxwnRtTR0fhXXm6D
X-Gm-Gg: AY/fxX5IQpR4JFGyrebjiXTrAo2jb4OpoYFtXlrx/X3UIUewNg7MtjMOZFyfulnAUbG
	QelPdVATB8AbiJRoUd8oBFpuX3UKamiEqhE/ABqeTJwpQikk1muGc3Bh/RA68zzWgmrifP+0cT5
	ZOH0C2EcN15A36KF+hiY7710D9EYVLIkPskoT+BbTg5+eKPkTgyg3B2OWbZ+T7ZMXiO2fZpvuNo
	UD8s/yWIJhtpJ2xk+kvKJiDRh0OU5u+G7aBbLHFZ5rc/dbJ7wAUwqMrEDajXXlYea67LxlghR4c
	KKUopfFYNqgbs+PA19C5aJSW3siVLFU5PxKDJ0Sa869xa++UemGA/Ujy4jlZ5JZWUhn4N95TG8T
	k1EkSrZqIYqDZMPd5VaFc4FB+tnXGUTJwY/ZEsrSJWJb9YfXCIusF4/5x2FOao3BV4x01cm7Ubv
	CdcmENY+74O/Xc/p6eGYndJLynImzqD2WynQ==
X-Google-Smtp-Source: AGHT+IEWznxiVsvoMd8i4NpdWHrf3h7fmSqNaQAER327WIZpo6FiFg15Y3vG4vyP3jxuFF3bkt/jNQ==
X-Received: by 2002:a05:600c:4fc3:b0:477:569c:34e9 with SMTP id 5b1f17b1804b1-47d84b3b9e6mr26180555e9.23.1767782441368;
        Wed, 07 Jan 2026 02:40:41 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:bc70:fb0c:12b6:3a41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f410c86sm92762115e9.3.2026.01.07.02.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 02:40:40 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jstancek@redhat.com,  liuhangbin@gmail.com,  matttbe@kernel.org
Subject: Re: [PATCH net] tools: ynl: don't install tests
In-Reply-To: <20260106163426.1468943-1-kuba@kernel.org>
Date: Wed, 07 Jan 2026 10:36:24 +0000
Message-ID: <m2fr8hwvyv.fsf@gmail.com>
References: <20260106163426.1468943-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> make's install target is meant for installing the production
> artifacts, AFAIU. Don't install test_ynl_cli and test_ynl_ethtool
> from under the main YNL install target. The install target
> under tests/ is retained in case someone wants the tests
> to be installed.
>
> Fixes: 308b7dee3e5c ("tools: ynl: add YNL test framework")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: jstancek@redhat.com
> CC: liuhangbin@gmail.com
> CC: matttbe@kernel.org
> ---
>  tools/net/ynl/Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
> index 7736b492f559..c2f3e8b3f2ac 100644
> --- a/tools/net/ynl/Makefile
> +++ b/tools/net/ynl/Makefile
> @@ -51,7 +51,6 @@ install: libynl.a lib/*.h
>  	@echo -e "\tINSTALL pyynl"
>  	@pip install --prefix=$(DESTDIR)$(prefix) .
>  	@make -C generated install
> -	@make -C tests install
>  
>  run_tests:
>  	@$(MAKE) -C tests run_tests

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

