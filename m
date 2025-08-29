Return-Path: <netdev+bounces-218398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D86B3C4A9
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 00:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 367D53BF842
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 22:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8B2263F5E;
	Fri, 29 Aug 2025 22:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d0iGB68k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1235325D533
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 22:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756505361; cv=none; b=giNZfkBgEJD8IagNBoY5ywbzhpgm3bCSKwaxzYiz3fk1P0bSCc1f9hMoTcWW6GMITHRD36qRNnr7NTvUazrdKpNGgMuXgLOsGv8uNdA+qyW2y9GVInt+2kHBqiGleHw9P/CVBerExDpsXQtjOmAm5wZxFEtdV3brv+ybWBs1xt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756505361; c=relaxed/simple;
	bh=ZUpwdLOuowMr13estHeGQaW273tDkTWnHhIpetx3zmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Js575a0S8cK+i2KU1ov8fhxY+7jzA9qAPnAx1uuElXATqbgNtG1UL+LpdkCAVwo5mWQEBar09g/Jcz7hnX8v9PmdMfmL9uCBNBVb+ABr3Z32uG7vhnsGdFxUv9R0TrXPMvf4NKk9r6Q8Dz4dMtmT2yYt19xChIvHkxgsgjntb44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d0iGB68k; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f62f93fdfso1855e87.0
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 15:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756505358; x=1757110158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRlni0LAZ2k/epuQ0hIRteWQTe5VolygiZX3mOllwaM=;
        b=d0iGB68kyqairueGQi4VXx+eZQvGeZXL2FU2rDLLAkEfqrVyEZRc20rQpjeaBr6Jh2
         VNCUrw54bhwTrVyemmKtVnydL1ucZ/7s28T3DNEdtNP0KX1qSiiPBWuHZKt3t45M1Osr
         ElSfzfgM8NBF5n/TXuHWvTCoyotPzjK+qeyA7Jq6cfylIzdmIXNKcAYun2wtzfJ4N7+8
         opEzFapvDpwlOazTYqKXu4v0yHl8VZCqhCWmFgoIJKNVd33QojTDxKRslx4hEUiMYmFS
         qum/jKgXTJB8qMFar0Iz3XH49n62KnHBFvhIq+6LydCI3Hkj+5pX5oDRu+9p9Xrqaqp2
         vvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756505358; x=1757110158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRlni0LAZ2k/epuQ0hIRteWQTe5VolygiZX3mOllwaM=;
        b=SN8M4Eos8aE27ZRiMEEsEZNUgx0T5JhgNE/b0EP8SZISf0bj1szAXbMNTgA4GBaTki
         OMh55Gt+SHFn/f/6jcIF1hvdeW528GBExLt2vCG7KK0OrtzwKkOdkIaLOPtooVlfeNoZ
         M0Tht6pa9LUas1eozmBDmWHzgtJASe/6R5EUMIPw+rkDVSo7fLzGyDjxAIQgc6UbDwW3
         +Bjne2lj65ZK8aGrI5bamQP7dcbd0Cst09sJYZWOshtJLO3QHBocjp1KyeFDydhGqE1g
         s9NnMIovlKwX+7YJksUO9imuk9BFYSAQS6+trwWA7XdejG5+da3sEX/xw5HerZ7a8ClT
         uy2w==
X-Forwarded-Encrypted: i=1; AJvYcCX+haAGXVRyVUeZbg07KwcQcFd470mK4Ztip3PTUX0nWMlugwctWLp0CD70Bbckb+yS1eeAgEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytpatoUKsD4xF6fHOfPPBML1AsqxbmcewzkWO5RgEYJx5qJgl/
	mClax2Q1GMgwVZ7gEAN7cWaRn8dVTLTpETLlw2SJeIP//JowN0wcqLvRr6rgk+vYEf5GqSNVuZv
	G5RQ0bK1jQyelYKaQqhcb6afQcqvuuvblVT7bBIkw
X-Gm-Gg: ASbGnctuWu4hOygsiBYAYyxasw1nJe8z2kk2V5Z7DuAMJf03yimHpMaVBKNdBcLGPW9
	jpQwnwopt48HN2OqFuLFm1R7klIy+BOnzGaG6+RfVu5+uglHRe5ntzYo615J8euaihlZcyxT8nk
	ld99z1JBkzFk5ndy0QkHz6TgSTQ/mTtkWUWSIaUHqTl4v1nrZgqMxvYNsw6NiAASN6jXNEYdoP5
	4bWW3XOWeiavTcWWU08jvgEkcZxSIjB0celFIRiPOtZ+CkGYoUXkzo=
X-Google-Smtp-Source: AGHT+IFrd353SiafeNmzxRHY8NvObaX9PSXHfMoWxY3IHXRgk1LpZe35ek7ha4JWhp7I2CODx81pKZ01rX9K1jgcf9s=
X-Received: by 2002:a19:6448:0:b0:55f:6a4b:b156 with SMTP id
 2adb3069b0e04-55f6f47f95fmr76317e87.1.1756505357918; Fri, 29 Aug 2025
 15:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829012304.4146195-1-kuba@kernel.org> <20250829012304.4146195-15-kuba@kernel.org>
In-Reply-To: <20250829012304.4146195-15-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 29 Aug 2025 15:09:06 -0700
X-Gm-Features: Ac12FXz8-EPMfSYgpgSb-1v6UbVfn3DOxWH53YxNVapKr0GuJvCI-VEtd741Kv4
Message-ID: <CAHS8izMevLVzi8JdZ4YPNkvEJB4WLcnEius25MME60NP1KSN1A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 14/14] eth: fbnic: support queue ops /
 zero-copy Rx
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, tariqt@nvidia.com, 
	dtatulea@nvidia.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	alexanderduyck@fb.com, sdf@fomichev.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 6:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Support queue ops. fbnic doesn't shut down the entire device
> just to restart a single queue.
>
>   ./tools/testing/selftests/drivers/net/hw/iou-zcrx.py
>   TAP version 13
>   1..3
>   ok 1 iou-zcrx.test_zcrx
>   ok 2 iou-zcrx.test_zcrx_oneshot
>   ok 3 iou-zcrx.test_zcrx_rss
>   # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

I don't have deep understanding of the internals of the driver but
from queue API interface POV I don't see any issues. FWIW:

Acked-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

