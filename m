Return-Path: <netdev+bounces-134051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBFB997BAA
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 06:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619101F243F4
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6D0190059;
	Thu, 10 Oct 2024 04:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvP8438f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF4120334
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 04:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728533513; cv=none; b=b+XELAym7YJIhXWwuRgysmQNmGxRkdGwb3mX8vecSgQbNQZSoQz6Xhe77HuZyMKZ8D47r5vK0XN+kaS2lVjUbmyEXoHtATrtPcyilI8VEK9WaN+8SuQgdPpO5pAArHXN3NGUvfIfDFNhHpDaoNEroT41mNACt8xUthp9CpZg5CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728533513; c=relaxed/simple;
	bh=CgYevYwG0CSfzneOC397ia+aGdKxn/Q4LSvx68lmwCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEZEhrAaE7j4Nnho+wl308bkiombtFRLHLFXjxyKcy1YCDTtA8rVaf0OyFq+HjIkTGNcbxz7oOJdDqQy4oNE/tYqcriSUr3zMmk0RwgD+BVNtlMeZ0GAOF7T1ZLJhvZXG9dabvyyVaQMbAKSIauCXbUS7ANBFKTt3lT5tWAo9wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TvP8438f; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c8a2579d94so506718a12.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 21:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728533511; x=1729138311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgYevYwG0CSfzneOC397ia+aGdKxn/Q4LSvx68lmwCM=;
        b=TvP8438fdPwqHGkvjHCVpBqucAeT5oHq5N+xwIYxGJHhwfV6bJqUXUOTnimwdkPriD
         +qQVwpjn5YepCqpxM4GVzkfCg27AO7nzpwbH7Uu9E4Cv8f9CeG+xqQedi/Cg3IW/CQEK
         PTAotdO7212/8R1rv6N/fxhLcmTG+/3kebkCwPKe7k+5WUQNqcTL0dYAvOIOS3XRKo3q
         9WqhQfHdlExa1MejrwNpYFd86qH53TG1C0xjb1kQxWWvj0khRzYo70C0K3mIO7Hm2D38
         z+HbD9ehPDmZowLBr3+9dg7Y6tjA7Is/ohOgVGi6uz9Oxe9RttjIsMj2F948QgLXMQhK
         ZFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728533511; x=1729138311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgYevYwG0CSfzneOC397ia+aGdKxn/Q4LSvx68lmwCM=;
        b=OFN7VGw2pxUngk4MXPrr/y6VzCq3VTjBACllbKAr3AISYBGHPCjEsCaQPxWLbPnDYI
         sdCgZuUIl8GceQ8vA+EmdhBwqKSvVAwW29REIxbuYmsEPa8d1H4o4TnQJgZdFzO1DNqM
         2CKIE4aj8neE23+ec2QDfPieaL/8DSTGtMoodTN/BKa+FcW++sWu2FlH3aXNjDMSZelm
         UEqNf2zave04A6ILuWHpYgQdL9xoZshXqdyu2UzLFToaqghwbTQmqXa1AprvyErgH5F5
         rTNV7Kg5cJ+JJiMDVv82r6JlL6NiAgVwH+wwXsbUbs8gyjPIiKAflgeIJtmpWzSJDpqM
         wTJw==
X-Gm-Message-State: AOJu0YwysJNLXqBrrpkliqvFi912XMkSbYxoD4m8oMy+3NdLlYrKPZ2M
	rd6paCgx9vx7W3h3oOiLpiT7/rUKb7UMlzxjz2I5z8+YrDryra8fwcF74IRo6pHoKpEJKpSyBMa
	gU4ppS1GFfXz1T+YV+xm4FJWhPIuDvlmn22euNKonppr5jxMU7w==
X-Google-Smtp-Source: AGHT+IEggKIp4ZTuRW/SWbztS18yX1MQLhoMfJi16i5VVNUe3ApWhL59KgIghcZllZFMTyqKV54Pq8mwJubV+doV0Bw=
X-Received: by 2002:a05:6402:34cc:b0:5c5:b90a:5b78 with SMTP id
 4fb4d7f45d1cf-5c91d54303dmr4299427a12.5.1728533510356; Wed, 09 Oct 2024
 21:11:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009005525.13651-1-jdamato@fastly.com> <20241009005525.13651-3-jdamato@fastly.com>
In-Reply-To: <20241009005525.13651-3-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 06:11:39 +0200
Message-ID: <CANn89i+nY7TpYY8jREiixSNiZ+63n2PkHq5aaR+G39WWKqbSvg@mail.gmail.com>
Subject: Re: [net-next v5 2/9] netdev-genl: Dump napi_defer_hard_irqs
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com, 
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com, 
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Daniel Jurgens <danielj@nvidia.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 2:55=E2=80=AFAM Joe Damato <jdamato@fastly.com> wrot=
e:
>
> Support dumping defer_hard_irqs for a NAPI ID.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

