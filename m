Return-Path: <netdev+bounces-142864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 373B29C07B7
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD921C23A85
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0C121262B;
	Thu,  7 Nov 2024 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U2CUzQ6v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EC7212179
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986677; cv=none; b=Vw7QEUsHEahJFGHqlbXnUVnqKW8W9X5yOEIfeYFAgs069bhxDg3LY8JovieK0wVMkSMNoaJyZXTJIL0btGT3Ev5HXngJQuHscifabC8Gzn6djYY8uFyJM3cBkxmoK2TYswMmwXiypcGBmHSxNB0k2x3kWblhV/qDS0/EeyrSNpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986677; c=relaxed/simple;
	bh=bYExxPs/zkT4nkC+V5hBiRXD91uP/lq+MGqhILYYYOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aD3EAdad8VL4OnL7Qsm+M7BWvr1cJcIbV5yX5dHPOscGFS678XqGzkM/RBRx8PQbQ4vYjsx19gdfMb15YsNCIquU7ILzKZjWFLf7vF3IlLfWKVRgdjTGvLGr22yhNUfvyAUjsSPdVFehxpxd3IsgK47SbwLndV7FrQHcfetdGG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U2CUzQ6v; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cb15b84544so1253467a12.2
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 05:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730986674; x=1731591474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYExxPs/zkT4nkC+V5hBiRXD91uP/lq+MGqhILYYYOU=;
        b=U2CUzQ6vLI4uvJ4GGL1f0UEHaD2xWW9qkrvQmOw4tRYtb3RLtYt3B+0sVaR1sUUdMJ
         UAiaZCnH1J7FX/RQonZpVlw4anyDX/FEchTaoYgWhuqaj2p+ansL2BdpJiMpld1ftyWU
         C9dd+/+PiBZxwsoVDN+Ea3sv3ZIb2ZHpF7QYykFKEgsEkbzj2wfb+Wep7Bzq9RWtplUf
         lvyFgaORQ1gdNoYTH7pPI7xyHQrMK7jr4PF3uKlU6CNmwh+IuAlkoUXdlRYfy8XGOvAa
         oG8anTntjYCO+oSGXjGy/QcYvm/Yoi+8udWJc+Smkso3qCNzCoQhzxgxbWozDqaU2+Xr
         BwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730986674; x=1731591474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYExxPs/zkT4nkC+V5hBiRXD91uP/lq+MGqhILYYYOU=;
        b=YjKvDUk3Bned3lbDGPDd50SD9Wkc5UuBiKr6OiNCsR004i7J2cmGVmBlXd3d+TP7dw
         BLHOa44KsEdSEv44i5Zj3seukZSMhhPaAs1r89VylheqNpCyqAsyr5apDSDXDRFde8Du
         ar1bD/X/ikrhzB1LeD3bPC1bh8mMSLLd6WoROJZKWYKAu/IBNS2MsN1X/FiIjTKIRiyR
         p0Afqzm+0AoupwC08yl41SYXPvTMMHUGLngiMaLEVkFEwP0aBM5KADFUzhei+fSRekfP
         w8lg/k53h6V5U4FPibKX2xFxKiFiILrUGzp7vcmnggPA0n9iNehXYsc4cadnDS+U9Nx7
         +h0w==
X-Gm-Message-State: AOJu0YxdWHqs6EBu5EjJ9/sY+dF2kOUNRGsOFoNYUd1WmKL2NBiHVGVX
	oNALfuOQCwi0W1la5H2TnapwYOcsTPgmYarAXU185V8cO7c+WvQy4C7kzSP5g5kfGATg+lK9lBw
	9pKIGINjI+YDYIf9fWPsjmdeXhnuSYJXX0rjh3LcLamGwZ4Hh9Q==
X-Google-Smtp-Source: AGHT+IFj/VoAYPwfj1qMXYn/keZw+BdB8CGX0gxPF/p+Y0NkDxp2Be9I3KxiQ0Bnuhcr/7xhhZgXPrcz0W3Y5Wu0t/0=
X-Received: by 2002:a05:6402:1d4a:b0:5cb:acdc:b245 with SMTP id
 4fb4d7f45d1cf-5ceb9282a67mr20397939a12.17.1730986674011; Thu, 07 Nov 2024
 05:37:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107133004.7469-1-shaw.leon@gmail.com> <20241107133004.7469-6-shaw.leon@gmail.com>
In-Reply-To: <20241107133004.7469-6-shaw.leon@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 14:37:42 +0100
Message-ID: <CANn89iLvC0H+eb1q1c9X6M1Cr296oLTWYyBhqTAyGW_BusHA_A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/8] net: ip_gre: Add netns_atomic module parameter
To: Xiao Liang <shaw.leon@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Jiri Pirko <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 2:30=E2=80=AFPM Xiao Liang <shaw.leon@gmail.com> wro=
te:
>
> If set to true, create device in target netns (when different from
> link-netns) without netns change, and use current netns as link-netns
> if not specified explicitly.
>

Sorry, module parameters are not going to fly.

Instead, add new rtnetlink attributes ?

