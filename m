Return-Path: <netdev+bounces-213046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E03E3B22E84
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 19:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEBFF1A2479B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E78C2FAC1A;
	Tue, 12 Aug 2025 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AGqd+B6S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEAB1E835B
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018196; cv=none; b=AKmTxoM9uvC8TwDbuCzSCpWWekf6Hf9sjV0Y9/VI1PM81FaFR2zbU+jU2swALOD4OTWYY0p8u+QsU/1w+b26H2xOGmUx8IUTdGl1K9AZSjbtHSJRdpEeOXzbAbpVQcyK8FPkbnn/BzdDNRe+S3mjxFx0PLVaxKpSxGk7IgACTHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018196; c=relaxed/simple;
	bh=OWuuTvMfPyA+107W7mBI9T0en4MRUWzU9Hz6iht/BAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdIPWJZeHenXOuTV8j1dQKu5/yxnTrfLfJUo0DliRWXaUm3NRUhitod/wznz/Ud3IM7CigB5kLtE/AGj5E9hc95F9Q1j6KXd2GO/AhTFOtGt3MY591GoJwY/8OydEP3wFTp910D7YhJ02Th7Dbg7iogQEOpbMe02X4PX1//rVpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AGqd+B6S; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55cc715d0easo425e87.0
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 10:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755018193; x=1755622993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmMKlUXAZp3eKZ4PwgQ72Z7vvc5pT/7V2A2LMb9mhe0=;
        b=AGqd+B6STjvYl/IHnh6SGv4txrr+TsUEOWo7KIlv1a1gowHO0FOHoAdz7Dh6UwmHLs
         q+yBHQ6YRqyU8Om/mNbrAkunjCHbBGPgaebbxdkein1vIUm1EbT5O+RDs8SwZ8ekKZ6D
         bb1OXiHGQ/M3OEzvKxEPBArEam5/xOGEolJShLuJoF4UxEcWulHlQgPx+j5XQ0ky7bzW
         6Gi45Ua01l1MfhE5wMUa1wh5ZtcT5FawN1ChpIg2IfcCo8KsfqemgH5bX02YYJYixmGg
         aN+g+0PRdZdYSpl8JiIltSjWeB/HNU2eaKeQtUB3TonT2GESXrA8kSiGgL7FYV2E0Yo9
         SJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755018193; x=1755622993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmMKlUXAZp3eKZ4PwgQ72Z7vvc5pT/7V2A2LMb9mhe0=;
        b=SEo8KcuYIWU6KXuYAdouLLkdAVx8PhYAyGDM2Dudtl+xiRvy8YNvdgy0fn6V9aq+if
         RmPj5Kxcmgod3xQts/2QtM/QWcMx1ot9pJXJhWUpqVMSusv53fQqR8Zo3sNRa0oBZGwV
         gdOkW5bnqV6C+c0ZU4u1y5Bxy8ZFpiSW+CWE3Eg3T08nnX0OLbcI9S7lnMEqGa4PYB0m
         vjhiYVm5YTlofsqOvob+Lp9Fi3BwNfVuNU5ro9ymWvnnHiGTnbGqLtIL+781B+Dv22ic
         GKgCdzHXHiXjyW3+x9wM5itvwJKZLNkw93A6sNbitXElGA17dZniGF58KR/AsNjXdKDB
         pKGw==
X-Forwarded-Encrypted: i=1; AJvYcCV83e4kcoFrfg0aJJ60VRTv8fu2Y7XnCJuX4NDfzx1xKiMCoI8MX9dlpS3XzjnG/rm6hRJzI7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmAI7f6BxZGvq+qXXziyI6lxZ7ZMf9xYOXPKkENJblna1LeOjj
	JpFCroMIntrrw27oxWQdzlyQY2YG+WC7AXv0wi8ZsUpwBe9hl7EDna0gZwGlOR48sKA73fvUeLM
	cEpW4bfJXOPqZqj5vYTADxvknFQaCAtFPGFHygwHR
X-Gm-Gg: ASbGnctdacXf0wJ5H2v1POpeMt6CIOHLTKRT6JtNcYoXZ2N2j/8/HWz98XEXR6/jNit
	Qi1gmyRApAG628a6csuhyqF+L5/ZW7ayAQuHMgY0vMsUKm7eTiTXLBj9hE8UN5k83JgoLhQJVZ1
	+y1aP8nJ94AOOjtHJkyUGjRPSSmbC6oaKKC4AsdvwRtHAJO9b5HYrwbOYWEl5zfoBuE04B0po70
	8s0AJpLi05sbW9rw/+X446GqfqeIKgZ0lFMhj24wo99egh1
X-Google-Smtp-Source: AGHT+IFhtF4CeSf0xkbpb20x4AxC2mCxdHvNXx3p+5yro8kmMD5Y7rhUC492jZT6952EjCndfu7lMsaPU9kKTO+1tz4=
X-Received: by 2002:ac2:4f16:0:b0:55b:5e26:ed7b with SMTP id
 2adb3069b0e04-55cd92926c4mr447320e87.0.1755018192643; Tue, 12 Aug 2025
 10:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811231334.561137-1-kuba@kernel.org> <20250811231334.561137-5-kuba@kernel.org>
In-Reply-To: <20250811231334.561137-5-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 12 Aug 2025 10:02:59 -0700
X-Gm-Features: Ac12FXz9hgUmCbmNnyGlQXztiWauwAYP8otTJ0HXPRbUpIkQERsnZD1mo-yj4yE
Message-ID: <CAHS8izMbL0Yph4JmG35svABsuB5D_GwrvZuDiHLZ-TE4pwC1KA@mail.gmail.com>
Subject: Re: [PATCH net-next 4/5] selftests: net: terminate bkg() commands on exception
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	sdf@fomichev.me, noren@nvidia.com, linux-kselftest@vger.kernel.org, 
	ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 4:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> There is a number of:
>
>   with bkg("socat ..LISTEN..", exit_wait=3DTrue)
>
> uses in the tests. If whatever is supposed to send the traffic
> fails we will get stuck in the bkg(). Try to kill the process
> in case of exception, to avoid the long wait.
>
> A specific example where this happens is the devmem Tx tests.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

--=20
Thanks,
Mina
Acked-by: Mina Almasry <almasrymina@google.com>

