Return-Path: <netdev+bounces-208788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE28B0D216
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 08:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FA283ACF80
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 06:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307B628937F;
	Tue, 22 Jul 2025 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="enbUI7IS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88949289E15
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753167126; cv=none; b=kKDnq/TnTKEZIyFLkYL7EMh0YOvz52ivGQ4surEyO0P0nkjcIkRGUl5IeKPNptKMisVR4kLIE5ihgXIPOTbZcdhK1kUwmIrDMFXGxoHEJkx9j9/JRsaqIfeyx149zvtsuNhPBLiIwr3DQE6Dp4SCy6LTDsEkaYt0cZU/oW2n9BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753167126; c=relaxed/simple;
	bh=PeWIbC1zji8Rcv82/MombFa1BJRmw7d2fz/ARauiscU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fD1ZxJnQtqMZHIBe+Fj3vXH3H3acJiahLL1M9JAmRVZgjEqoSAujN7NAM6OIsMvZzkt/n92phOc85w48gvSYqduXdYcOHiu6+QMh7VaFtQI4Kk6GkR3z3Stg1xaK1SAmeyug9ykcGK68aOB6kBOAL6tlUOBdoOrZjCkH8BzGJNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=enbUI7IS; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ab554fd8fbso49892531cf.1
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 23:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753167123; x=1753771923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeWIbC1zji8Rcv82/MombFa1BJRmw7d2fz/ARauiscU=;
        b=enbUI7IS3Pdgii2vPn5xqVAV9iHcIBaXnKm8rDsTZxZmYkOsObKA9Wbx9YgYU5u+uB
         QHbXRHYM4ZDkl74xsJ/ItRDA8z5Esf8vZvQYgl0hImphZxc8HGnv4dhmXOlgryRfMU8e
         Vo5xjCKhokd948J5DnZ79YsdH2hueS8+ngC4yjBoMiUQArUWCgFYmQkvHUisJFmdo9UG
         eb1MdWwcLwblChsl0TTZcC8t4vF0ONHHexnNy/zfLp0+Y5YfroN7AwqJjg2vfs7F7Swb
         ZJbpfkdk+UBXvW4qT+MIUqt7pY+sqc8tPONwm3fz8+bFrXOXSrCiLxW0BiYu6bMYOtVh
         ExUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753167123; x=1753771923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeWIbC1zji8Rcv82/MombFa1BJRmw7d2fz/ARauiscU=;
        b=foyILSC5X0gsFE7W30nsC0KU5nQCf98QiGIkJf7JhoElsfCvgpG/Ao/VjYvyGjsdTw
         hDWrd/GbRq5zYevnh8+kRbyozNHK9KCmUO1QpQC87RbcUiKhLmcfq/EKAc6Y78Acqtjc
         zStYDnZEha3zaaBlexo3aJVVyvNjT3YD3hxQJAF9yMseuRa6GYFRbQ3XPa1p63CS8D0Q
         lgyVqUuShroFRPuo3QeoPpYsQOkS5iF7vNmfuyT8Bj1JT+fHiGHKpLbp2y2TjiyhJttk
         yqBt76fOJpWKWm+TYLA3F/LBTM+qO9rukSG4GK3hx8q5ol/+xqIRFqc4KlkYdEpQgRy/
         eZPg==
X-Forwarded-Encrypted: i=1; AJvYcCVlTlKjnc+/1GkZNEBa1XoE4elhC7j19uQos25luMcKdLwP60/yYUatR54zGQO54PPb0PaM7RE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO5F/qi3YwAp4B6t9bz1A4sBzJX9pgrk1v9MhLD9sXw3URSC2a
	hgA4XxBX91k+y4me7GT23FvhaM3J5J8jfkr3sF1lrl/dHRgYl0NVpC+yJuXAU6ULH/Bmxiob7Kh
	ouqm6ruN6LM8qlb91WWipKo7uWLd5sIK3WhNK2xaQ
X-Gm-Gg: ASbGncs4G07UbXt38aRx/ApbENh3w5s+0W6fwFTkaB8aW5NuA/4/r0A1AMPJL7t8Lv7
	AFVcgIBrtfOhFYA0Vyourgq+5lTNXRoQ3Llk0mu/0N9UJafetwDdsWY6tzAhdMm+OU8qns4sj6g
	R8Twt+topKtXbqNqbDpmzRdCuniXkxX7NikHRA6UfPyrZW0eVb+vrGYD2GkfCZ//GHdJsnI7VhS
	4sRuQ==
X-Google-Smtp-Source: AGHT+IHQtTROmOPjtYKNp3LrKieED28s9Ihtni6NoFl6cfc5Sc0h1mgzJXsDX15qgWH4HGDMdRBDDSThTKbNVJHA4jg=
X-Received: by 2002:a05:622a:114f:b0:49a:4fc0:56ff with SMTP id
 d75a77b69052e-4ae5b7e22bdmr37705791cf.12.1753167123226; Mon, 21 Jul 2025
 23:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1752870014-28909-1-git-send-email-haiyangz@linux.microsoft.com>
In-Reply-To: <1752870014-28909-1-git-send-email-haiyangz@linux.microsoft.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 21 Jul 2025 23:51:51 -0700
X-Gm-Features: Ac12FXz4iUeeGipOp3D_tB6KFKYfqAFLlbaMGXZvPSx57DSINr_rpmIyL81k98Y
Message-ID: <CANn89iJLnprFvLpRpJ7_br5EiyCF0xqcMM7seUVQNAfroc4Taw@mail.gmail.com>
Subject: Re: [PATCH net] net: core: Fix the loop in default_device_exit_net()
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
	haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, davem@davemloft.net, 
	sdf@fomichev.me, kuniyu@google.com, ahmed.zaki@intel.com, 
	aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, #@linux.microsoft.com, 5.4+@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 1:21=E2=80=AFPM Haiyang Zhang
<haiyangz@linux.microsoft.com> wrote:
>
> From: Haiyang Zhang <haiyangz@microsoft.com>
>
> The loop in default_device_exit_net() won't be able to properly detect th=
e
> head then stop, and will hit NULL pointer, when a driver, like hv_netvsc,
> automatically moves the slave device together with the master device.
>
> To fix this, add a helper function to return the first migratable netdev
> correctly, no matter one or two devices were removed from this net's list
> in the last iteration.
>
> Cc: stable@vger.kernel.org # 5.4+

We (network maintainers) prefer a Fixes: tag, so that we can look at
the blamed patch, rather than trusting your '5.4' hint.

Without a Fixes tag, you are forcing each reviewer to do the
archeology work, and possibly completely miss your point.

