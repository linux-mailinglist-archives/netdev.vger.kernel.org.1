Return-Path: <netdev+bounces-74496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AAF8617D6
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 17:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73CA3285FC5
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A6283CA6;
	Fri, 23 Feb 2024 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAv8Tfxl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B72B28EB
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705606; cv=none; b=vCXHbJVihHEA149zedd3VyPvRdrw+SJEbChxV8w0447q8dtabXsixVmKRz05zd7mvzBI3c6YrE3t8oZKbuCT3o3MjfemE9wtBOKZiTFwcc4+XyRlKWuODzF6mFpU61hJlIBIQE4QozbbnQOnMmVKEPbt/dqCReVzkp7iV2GN1cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705606; c=relaxed/simple;
	bh=rBtmPjbDeLN3QT4AYhriELnXgXk0WWDDcWsB3SY+reY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBva6gOHX8InufzhdGnVDr6UHn5ZJ904Cm+Yb54UhKGhuo3fTvFMA/eKy6l5xaydXwhI38hhp8VynikK4urrH2aCJ00aygaxr8beGRDHMC08TptRB/HY6/T4530fEiOTelICOGmp3rWCxtpPWDbs7l9mKhfbosPvXlFu8S0UPC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAv8Tfxl; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-21f2f813e3bso215447fac.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 08:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708705604; x=1709310404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rBtmPjbDeLN3QT4AYhriELnXgXk0WWDDcWsB3SY+reY=;
        b=KAv8TfxlNoTsv4rh8RlEGLtyyE98nMlv6Iin1B10WZFxHHK9mWf8k13yMFAXlFvCzE
         EcRAIXnr4MI8A250Jj+QuWN+tDzrQw2cS60s24BPC2X90djjpCPgR6qjvSRgEBzcAsto
         kZHQfPCzqr4LopAU1oSZXhAa2rfpz9SToIDya9hgVzD+DVtASuBOfnbpzE7ZMmZiLakz
         Ta0n1jvdceFklHyxSVeS66X8COmCBgUi9kmvjHNIZx6Juzt0NJn3OvvIX+jPpOZ+D3Js
         EqfzwXjobp3Yz/egUafP82a367K6JMJo+2mMud9HG7rOUCgO9Olr8XNpiimRVHqyaSq7
         FlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708705604; x=1709310404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBtmPjbDeLN3QT4AYhriELnXgXk0WWDDcWsB3SY+reY=;
        b=npGt/WaI6OlF0MDrSZrMp5Cd1OPebULAngawb5N6d0s98BIGINmpQ6vJopGnV/7aNr
         1wKnxJj6DvvtIaw/5KknA3Zf/lTXvBoF9RtnZZd229Sk2GkPRkYQ0fGwq5A8poOShYMx
         MkZqRMXNrEV+n6KmqrgBKZIgT9oYXxP9qsoqO4IivMgiXp/O+EpgSCGEx0zcRJbXxWSK
         sXyaH2fuawbclHi5gPjcsRut/yl3wune8btSpdSrv3sAXVRb+WV7gmIdF41cGOyaxXcN
         PUAgNvF97rzrz05zO8L0+ptus3HRT1zeKsKoM7nNYn3TUHXsm7FNVRJjHHPhPKgiWJDO
         BHyA==
X-Forwarded-Encrypted: i=1; AJvYcCUrZyw36ocoGaiHZFUWZX1VSh6QgyfqePImkzOXVuJAxDmioybZ8jdx68xNxzBqrTAYyuEdugTwdLDajwYOZofJ/fu62Jha
X-Gm-Message-State: AOJu0YwH6bs0mk4iMM/yDpB7EPcF79/HBd67hdh5Xt3Q/G18efKa/ELu
	3VCX//Bk3JCU/mENrq6xDmDEWRAbd8JxeYWyhNJJCEbJVnIYbxcWBa45XF5QOwrj9TA5BOpAnM3
	i+PjOhAH0Mf4qWStchM9X3bKWr3g=
X-Google-Smtp-Source: AGHT+IF9kxdDF0dUx9B6rGX+sxkKJSFh5DxOXRyooJHMbsylOcFY/0kN56yQvruq9f28zJUqSdHz+re6m3an6AO95Q8=
X-Received: by 2002:a05:6870:e2cb:b0:21e:7d4a:aa67 with SMTP id
 w11-20020a056870e2cb00b0021e7d4aaa67mr131547oad.21.1708705604387; Fri, 23 Feb
 2024 08:26:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222235614.180876-1-kuba@kernel.org>
In-Reply-To: <20240222235614.180876-1-kuba@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Fri, 23 Feb 2024 16:26:33 +0000
Message-ID: <CAD4GDZzF55bkoZ_o0S784PmfW4+L_QrG2ofWg6CeQk4FCWTUiw@mail.gmail.com>
Subject: Re: [PATCH net-next 00/15] tools: ynl: stop using libmnl
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, jiri@resnulli.us, sdf@google.com, 
	nicolas.dichtel@6wind.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 23:56, Jakub Kicinski <kuba@kernel.org> wrote:
>
> There is no strong reason to stop using libmnl in ynl but there
> are a few small ones which add up.
>
> First, we do much more advanced netlink level parsing than libmnl
> in ynl so it's hard to say that libmnl abstracts much from us.
> The fact that this series, removing the libmnl dependency, only
> adds <300 LoC shows that code savings aren't huge.
> OTOH when new types are added (e.g. auto-int) we need to add
> compatibility to deal with older version of libmnl (in fact,
> even tho patches have been sent months ago, auto-ints are still
> not supported in libmnl.git).
>
> Second, the dependency makes ynl less self contained, and harder
> to vendor in. Whether vendoring libraries into projects is a good
> idea is a separate discussion, nonetheless, people want to do it.
>
> Third, there are small annoyances with the libmnl APIs which
> are hard to fix in backward-compatible ways.
>
> All in all, libmnl is a great library, but with all the code
> generation and structured parsing, ynl is better served by going
> its own way.

Is the absence of buffer bounds checking intentional, i.e. relying on libasan?

