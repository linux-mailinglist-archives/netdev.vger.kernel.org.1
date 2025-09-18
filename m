Return-Path: <netdev+bounces-224238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B9EB82C35
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 05:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5DC41B2435F
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 03:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355CB1B2186;
	Thu, 18 Sep 2025 03:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OYUa5wZo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990B334BA27
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 03:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758166542; cv=none; b=Q2LWqn9guTSo15je31AZS7OFyxDCknPgzl/ci1QHqMW7VvAcXYQ6gALRFWguDanOsGh/AJE8gyJZAHOjkGIObe739rsdWfdfFW58O7ZXqC3meCMm3PDmNg2ozX986Z1w9KJ73I4cXKWB1pAbHOsycQV8u4vgANq32cYNAitFuGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758166542; c=relaxed/simple;
	bh=MytPbcLeoqTKdEFImR9c3V9Td2tYCsxkVlY/rDP+BlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+BrUfuQVLNRLtMx222lcGxks2ZmiyqUF0ar7UzT1gxSGm7QZtPHECVwJxhy56Umx6yXTHRZjhKItUm6XGJUlkYDbuosKcT97B/B4uc3hTuC2CW001/GdiuF4F7v6vgRyxiMY7GjkEhKSvmcr37DKgbpCkKIyC0wBd3njOiCz10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OYUa5wZo; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b33f71bb1dso12988171cf.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 20:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758166539; x=1758771339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MytPbcLeoqTKdEFImR9c3V9Td2tYCsxkVlY/rDP+BlY=;
        b=OYUa5wZofSrPzDEoAc8bVj3gRd0ka0knZO4+wx2B/LvG5TKl7hRb9IbB740bW58vZz
         2T2Cf4mV51IDqegVWEQmpzC6pn15YQpLlVj5qrEgDwrFL1IsOhUQ5c5EFfCQ5PwkdPWd
         1AgKV7NvH+nkwMiaK8Q8Zq/+/LQoUC8ewY4PUPVCEDIq/qUuHMgejs0yzGlwjzYVnOxL
         HTeVWeZfrF19QSHsx/P0CHPge4ItU+ahdoZ57kREIcWkVS7YKi7U+S4Wsv46/Zuh6i5o
         /VbY52QwrGk0ej+ercpbIbCXbB5a+elHUR7iiGlaD5fvM7C9fgAV1LmvqRisZ8xb6pUL
         S4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758166539; x=1758771339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MytPbcLeoqTKdEFImR9c3V9Td2tYCsxkVlY/rDP+BlY=;
        b=Ii7IC+VUqcG9MQCo5HETyQmXclis6isuoaPDE0CCWBM63y7TIUJUNKj8Ixtl1/Kj6u
         o9Ds8bNxlnpbqqgeSsm4OaGIqLB7zBvOJbs9GNR7kXp2Ai1vx8K1PidfRNTgCyj2PhR5
         BZkge7SHcRnbyCxl7xcCuz2Csqvlvyv8zGPuc8CQ4oqfoi+zFTvwksfjDzv9nTA0Sdss
         I8G5KOhOkPqxrTv5rSTpI/Bo2xVbJYAtVBmo0+dBhlOUWqGOPU0sw7xyO3UwUxtU105/
         LeB+RQoZKjDDIB/cY/GrSPt49OPlv+J2M7xc1snmVtHrMoArqmB844Ov8vaMu30Jeoak
         wkUw==
X-Forwarded-Encrypted: i=1; AJvYcCW8Rsz+fSc3umz9dvqNF8NmWnrnZQ0IwSE2KXbPyKqQ80zf148vGk1NJqRr+XFj2YDSYI3wXf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZwLKKluMqTs597PejN/sbYJJWaSZoogaWHgLLBF+CT6pI6PKA
	cJKUbgrpS/jm7TbYd4mrJmaYhL61KQQ42LyVhiQlBr/BYFySxieKE7R54HKbiAcElWIeviyXxTy
	xOxhElTEPeMX6jqni826O75sNcVNjT6XUiD1Ofu/z
X-Gm-Gg: ASbGncsFG74GUvp77HCcFKyEYP9fCGw40HdRUwyIRiFFuQ/Z1vrNqjAfSXHAhewIXR9
	t8slYJg2xuCe509PjBlbTrnbQ/KT1KH5xrI1LKZXi1mOyvDE1geasgCz/YIyQMvX9OZdMCRKwme
	fbqmX0u8wsnvVzl4fdLgIXdBB0Bzw7lKYD9PIlYeaZ9LFw61gchEb8Ps1CVExbvjFV4gShv+nzj
	wEVzjrD1OgEZ/C+1zlKfRMs5nEvmq+Q
X-Google-Smtp-Source: AGHT+IGOeiROfGHixV0anCqazpHquLV2K7RSafopG7KW2GEpnqFhjTcE82hJ6/TDEcBThPlsi0YHp7sVBdpdAZ6/3mw=
X-Received: by 2002:ac8:574e:0:b0:4b7:8d1c:10bb with SMTP id
 d75a77b69052e-4bdabc051b4mr25381721cf.34.1758166539246; Wed, 17 Sep 2025
 20:35:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917000954.859376-1-daniel.zahka@gmail.com> <20250917000954.859376-3-daniel.zahka@gmail.com>
In-Reply-To: <20250917000954.859376-3-daniel.zahka@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 20:35:28 -0700
X-Gm-Features: AS18NWCEa0pzqRtAYbWVb5CnI059jEDU5isxQ-HyzugRtLzBqebsLB53bLaT5JY
Message-ID: <CANn89iJWA9SmT+i_f=Hm55U107bdJ6jSSjCf0adaP6S=yXze-A@mail.gmail.com>
Subject: Re: [PATCH net-next v13 02/19] psp: base PSP device support
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Boris Pismenny <borisp@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Patrisious Haddad <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>, 
	Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Kiran Kella <kiran.kella@broadcom.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 5:09=E2=80=AFPM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> Add a netlink family for PSP and allow drivers to register support.
>
> The "PSP device" is its own object. This allows us to perform more
> flexible reference counting / lifetime control than if PSP information
> was part of net_device. In the future we should also be able
> to "delegate" PSP access to software devices, such as *vlan, veth
> or netkit more easily.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---

OK, phase bit seems to be in psphdr then ;)

Reviewed-by: Eric Dumazet <edumazet@google.com>

