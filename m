Return-Path: <netdev+bounces-163289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6CBA29D32
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 00:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9BF3A6033
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 23:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD8521C178;
	Wed,  5 Feb 2025 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0aT3F2k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97D020E007
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 23:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738797008; cv=none; b=mF95ftvugHtKeD7eC7K/n55uptvKeYeDaAfYOoyCverh/xH5FYYKqTTO7AHofcxVD1UdGXl+An92gFxb9ErzOhDEoIphoWwiOizkpIDqkrCkuAKFaUMnL8K0lzvPX0Px9flGM+2ACIRuJgl8F4fyYbfQI+wsOXQtyDk2vX8f8Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738797008; c=relaxed/simple;
	bh=ZkpiFoH1jZ8mESZ21xRx9dgwJfBD4BJAQnny9KToe+w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IUTLHjQIqDYBrFfsIcZ7hXMqCaIx5hPmIOHhTEbKRepsqletoULZpu+296uJmHUOJLhs9Q/4F1gIta70FdqK3XVAi+6TKrZqXhHwPASlumfdceKwqiqrcJZojB6sKe4MbyWqZb7j0y5YUTdECKy492Pg7taIo/A50lSLeetkE/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0aT3F2k; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so1824265e9.1
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 15:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738797005; x=1739401805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rxN5CLR52JETTYBT/gf26dR+Vime7l90m+D0JakEPA=;
        b=P0aT3F2kqFo/ZPlbVpBNefIBREZDxYjoHfqB686X+vWr/mbZLUlSesYd06guEu1ses
         1UsDI6KWd2jhUWDnFn778TsQF7B2gLh9VkxQEP5Tp1XBwVaTemmOzZpPC/kqD2tktm/b
         d4E1HzG96VSuFlnHN/q8QdQq2TFn8d0UiR8bmoXU2B9hT3fPY+Zod/TWtby3vYWMI+Uo
         3F+JzLvy0v0bt6n8KMJOfabY8dfPmJ3KTTl+sRtPnIYT6CrYkzfbcN31e6+u+qaso7KI
         NLdMUldKU5B61Y8Zf7m0GSTlrUmGV84SeHRm2kn41QA8dm7em0+zgdPY3vmfEIxqctnO
         iELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738797005; x=1739401805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rxN5CLR52JETTYBT/gf26dR+Vime7l90m+D0JakEPA=;
        b=m038PtZEHXsisyN6KFPJ0eogX8NbLdwA+2B7w3aX8SGDNArzcg4IIrLErIqbujYDk8
         qOamdggjwl6D3jLk3u8BspQf3hbNZ0dfchTpehGsSGQKLMyNBAeGiwUPLQob9YD5p1z9
         wnXatOLyYKKtB6YSR+NDzsQz2tdKJg0Kj9+C+3QMRbs9/pytFgASH+H/r39lONAMCqd+
         3F+yiQ2/iylLVC6H5GwE7pSJyLiZ7TDgCM5+iLGN4KuCKIWyy0guWWz8gsI3u2w6KFKx
         li/JyTLqUxwKIrXgLCdIvcY2e7T14kX8av+nydT5HkfHKbjnrxCgnZRYmj5sOrzXPnAw
         0Jwg==
X-Forwarded-Encrypted: i=1; AJvYcCUa07Nu3qSJw4bCf87kQWL8tZVqjEkchLZq4rl/wOr0MO0VS3daPhN6fkLdvLCBxrZiXKciD3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnIFmiJnnFHB7DXIIVnGiLg418QGxmo76oljo74bFFbXjmAQ8m
	AOQozzjGKVtl49PysP3CKpPO96lUAYvKD3IQMo9UhU1QXweqaLdd
X-Gm-Gg: ASbGncv7EgMdjVFMNQnUhuHdd6pnOdbGrlm9/81vzn8TZC2Y0lr50+WnZWnZtVqmyEy
	4YJ6yV7J21dyY56Tu+76wstkLDvC6X0AogGyMhrSyiRuja/ZendrArhaIazBp1oBQA07lWo+hKr
	x+BATVeZCQhWR43JFxWABG0X8i42hnQbZBPzGqrINBff9u/HEiD+d0N4wKrp3PcQMeK/HM4R2bT
	v0ohclCarCG8aF80I2eLPqIyzAMhGMq7CiY2cprBaGLUKGsR2sNHV8gseTcNJqpTEfcNWt0Ojsm
	m2clqAEGGoNLD0yvXKw26WWBR2IlDUnA2zmmNv+hkh77/FbrD+FvYg==
X-Google-Smtp-Source: AGHT+IHt7IcGzL6lnraWzhT0gCAPhGWQV7+eNa9FvL4kccZhEt3Vqa79z5At1SuRCqtBLPdGT9d0vQ==
X-Received: by 2002:a05:600c:548e:b0:436:5fc9:309d with SMTP id 5b1f17b1804b1-4390d56f569mr42792445e9.30.1738797005083;
        Wed, 05 Feb 2025 15:10:05 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbdd55656sm68032f8f.50.2025.02.05.15.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 15:10:04 -0800 (PST)
Date: Wed, 5 Feb 2025 23:10:03 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller "
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, almasrymina@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/4] Add support to set napi threaded for
 individual napi
Message-ID: <20250205231003.49e5cc3f@pumpkin>
In-Reply-To: <20250205001052.2590140-2-skhawaja@google.com>
References: <20250205001052.2590140-1-skhawaja@google.com>
	<20250205001052.2590140-2-skhawaja@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Feb 2025 00:10:49 +0000
Samiullah Khawaja <skhawaja@google.com> wrote:

> A net device has a threaded sysctl that can be used to enable threaded
> napi polling on all of the NAPI contexts under that device. Allow
> enabling threaded napi polling at individual napi level using netlink.
> 
> Extend the netlink operation `napi-set` and allow setting the threaded
> attribute of a NAPI. This will enable the threaded polling on a napi
> context.
> 
> Tested using following command in qemu/virtio-net:
> ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>   --do napi-set       --json '{"id": 66, "threaded": 1}'

Is there a sane way for a 'real person' to set these from a normal
startup/network configuration script?

The netlink API is hardly user-friendly.

	David

