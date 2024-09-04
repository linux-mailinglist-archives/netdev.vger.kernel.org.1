Return-Path: <netdev+bounces-125228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A5996C59A
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 19:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21181C20A3C
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D56A1E132C;
	Wed,  4 Sep 2024 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NH0fb0iB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5231DEFCD
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725471715; cv=none; b=A3bv3vLarR7f0V7f6ZfriR3cZHtDy4ONqfZxe18TShc005Klnbm1I6xcHSpIkijA054gnW3Uu7u4uTdtvcSL2vezsY7MiA4Hjcx0IvXdMKuPR/V9WqJmdcT97rCpW27gXD4bMkLS+nyzxZxKYOZlnfOingx9fbrotBrrjPnkLjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725471715; c=relaxed/simple;
	bh=wz75a11PFOpAUTxv6Um3DfxDwD2ROEFDNmtXnCYANjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JvU+spfpfc1J4MuNYLzHFkAQz2hPq7nVepbbm77fb4Ys0E0ueegjjff3uMfWY2eLL7VOeG50nEEveun+QeejWESsdALFHwjQGBk3+eZJdrtuBVKjxHqxsAj2voN44Gg8oWVR8DHGtnqEIzKTToZu70zlfBnUcIq8GA8Ps5M51x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NH0fb0iB; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-533488ffaddso8430310e87.1
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 10:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725471712; x=1726076512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wz75a11PFOpAUTxv6Um3DfxDwD2ROEFDNmtXnCYANjE=;
        b=NH0fb0iBRxrvQXl3KYTkXvJeU0vs+rVWHnbduZKq8RxHe5l5kpPdXCvIsrzlDusHUd
         RYA3qPSsoqQ2hY6oWdZ4cKFbAivifvZ4HTrXZaL7LJA7QIDawtv1QQsvw4ZR8j9B4O5S
         vAX/brKuvCxuG7S59ta5gh7hs7DsqQLd7H1XDjiGrUd225N+EekkEF3eGkaRb+dvPLNB
         L7W3udPUA50Lfkl6yT1q+s0pSfsnRJoJofh4Kt/8fzwq+BOCfZnkKAviBkVSB/YJAhfJ
         KIRvqQYDbi7Dijgxw9zfFoKsrVqJs4X8CkVVjjDurerIuv28g2fOJw3BrPUMfjYyGFY3
         6bcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725471712; x=1726076512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wz75a11PFOpAUTxv6Um3DfxDwD2ROEFDNmtXnCYANjE=;
        b=F5Ox94Q9SiWNgszKitQ652i3mTvMbJrkUBeoNzzJC+OGt2Jlzf0Dxk3Yn4hes/7oPQ
         e1YIUu3/WuBWJkkuQ1CoknIF6MCCWe+wd3IDf1n54jTh67i4tPci7CL9L7Lz766R3x42
         +a4Xzcv8Qv/DQc/RLUyqaxBGDcoxYDuCd44HzsYSC0JaXHGWXaVRJOdAZ3V6efLAMhWs
         iya/UXLpio+BFH1X7+Sov9VPOpGNDmMuHi7mJ+lIIw77K2lilcZ48Y2UGPoEInEjOuCE
         OiiHo3inz2HDo83f+RPU4jNsynTH6B6TDLlrvyJKm9uXB8AC7U3rxLWBdbetLvAgJAM5
         q6wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn5uB5o68yGPavwGMoYh8MLct4N6wwjQS5NgPoGJ8txh9bhHtiJl8rH6EbKmT97BVR7OZm6CE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhzZ647RIwRf9mK6JM4sWQr8P2k2z1J+IRhMPEyLtmtpra5fzx
	zWV7LPtl+Js7VmvcEchUvyr2LIL/3PHlDCJI/SiUyia6nKC6vm7qLXADbaUeezXsT/mxBtjlrNr
	P2KHUhojUEUXsvwIo0uQP2IyBuHFWr7A5NZcAS+JNL21L1PnSmPKKcsI=
X-Google-Smtp-Source: AGHT+IHmDorF9UEFr2wh/XizVS/wv5VK7RxpeUdWMtek3lrFs1iR+5ZvZDdP2aau8gadxQLLaRiq3DncFlO976/9gzQ=
X-Received: by 2002:a05:6512:3f1a:b0:52c:dac3:392b with SMTP id
 2adb3069b0e04-53546b432e8mr13160571e87.33.1725471711033; Wed, 04 Sep 2024
 10:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822200252.472298-1-wangfe@google.com> <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
 <20240831173934.GC4000@unreal> <ZtVs2KwxY8VkvoEr@gauss3.secunet.de>
 <20240902094452.GE4026@unreal> <CADsK2K9_MVnMp+_SQmjweUoX1Hpnyquc1nW+qh2DDVUqPpEw8w@mail.gmail.com>
 <20240903190418.GK4026@unreal>
In-Reply-To: <20240903190418.GK4026@unreal>
From: Feng Wang <wangfe@google.com>
Date: Wed, 4 Sep 2024 10:41:38 -0700
Message-ID: <CADsK2K-vMvX0UzWboPMstCoZuzGsFf2Y3mYpm4nNU4GAXDum3Q@mail.gmail.com>
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
To: Leon Romanovsky <leon@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, 
	antony.antony@secunet.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leon,

I'm looking at the MLX5 driver to understand how the SA information is
used. In mlx5e_ipsec_handle_tx_skb(), it appears we might leverage the
current MLX5 implementation to verify the xfrm id.
https://elixir.bootlin.com/linux/v6.10/source/drivers/net/ethernet/mellanox=
/mlx5/core/en_accel/ipsec_rxtx.c#L271

During the mlx5e_xfrm_add_state() function, the xfrm ID (x->if_id) is
passed to the driver along with the associated xfrm_state pointer.
Therefore, by checking the if_id within the skb tx function like
mlx5e_ipsec_handle_tx_skb(), we should be able to demonstrate the use
case effectively.

What=E2=80=99s your opinion?

Thanks for your help.

Feng

