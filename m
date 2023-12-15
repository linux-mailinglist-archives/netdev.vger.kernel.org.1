Return-Path: <netdev+bounces-57976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F5A814A7D
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 15:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070191C20E96
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 14:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE2C3172A;
	Fri, 15 Dec 2023 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eaROFdjA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D857F31A60
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-da077db5145so546438276.0
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 06:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702650527; x=1703255327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJwV8Ak+gq9x2mtfc2tfaMyEbAkvp48o/I9bnD8rRwQ=;
        b=eaROFdjA+5VlVdBGC7h3AlxjGmcEv+n6ijbngFnNH+IvuUOsQY3Gx3o11hAlTQRUQ6
         RqkDSeeckqtWF5HpguuJLgkexvDhKWY9ySD/Ez+cCv1/Bccy070erAPrQaUqNZsg5Lxu
         D17zerquJ83YWdjdBuOFhBse3lIUC0mg/kmM/WIRm56aUkNcIRWWXpXFy7QsP/OBZZj1
         9delQk7jbOgRZyc9824KT6XBx8s1TewF0tLPQ+sw4C+8YXJiW2m1z8HQcHn5UcpqJRl8
         26/FqSvd4o7MBJe9GUOeSQ8PZiiw+KuBI9HzEA6cS4Mtnv1veR6v+23a8Xhkv3/hkL1T
         ZTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702650527; x=1703255327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJwV8Ak+gq9x2mtfc2tfaMyEbAkvp48o/I9bnD8rRwQ=;
        b=hJZQUYadgvbkkvWfIU9IX+osvfTAzJqecIW32lBIJj147kfniC+DMCpZgmHKaol+94
         Ei1MA5sEvcVQT+6ex7E1KpQvtSglTHNoW7VFpWD2z9D+VLIgoxKmDJDt2Le8nTy8ixx8
         Jsuth/rBVNovdC0b+dShkByd6oGCL8NvKTipLlbquNagvgiIrIpPpdLR7sBCSagcsC/g
         pMVb/2bADBkEhqWnEpgWU9m2+yPJwJv1HMmkxxElXVaUV92eQG/K+NJZAYDrNq0lNK4L
         zwPBEaJnkVMRw5RQR2d72XXe/0CFheHRbcJoirgoUMGXVCRFoKoKU1Yo3D7eTt2xua+4
         c9SA==
X-Gm-Message-State: AOJu0Yz2ogl6usZPMjY5F6xYPzPlGddRg9yQb09fm2kw+EfuRAnpZ6eU
	1rZlirPAnU+7p+CPLCed1sZ94NFUiXrhfYUHFTv+dg==
X-Google-Smtp-Source: AGHT+IEAHufcCh6qxzHgMry8x0eJ0jCtrXsP+MRKmnGoQciFCK55wEG/ZdTo9kN7MCJ54mD75JIn3nJdH654J5EstwI=
X-Received: by 2002:a25:abe1:0:b0:dbc:ec97:d7dd with SMTP id
 v88-20020a25abe1000000b00dbcec97d7ddmr1502293ybi.97.1702650526815; Fri, 15
 Dec 2023 06:28:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215-new-gemini-ethernet-regression-v1-0-93033544be23@linaro.org>
 <20231215-new-gemini-ethernet-regression-v1-1-93033544be23@linaro.org> <CANn89iJo8ER1kZYB7La1jx5p00FrHxzSLnSsWcMNdj8-iG9_Rw@mail.gmail.com>
In-Reply-To: <CANn89iJo8ER1kZYB7La1jx5p00FrHxzSLnSsWcMNdj8-iG9_Rw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 15 Dec 2023 15:28:35 +0100
Message-ID: <CACRpkdbu_MjJCiC0bCx4EVA7krY=iTvqKyu0ym8n3QuzoPvOhA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: ethernet: cortina: Drop software checksumming
To: Eric Dumazet <edumazet@google.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 10:32=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:

> Depending on packet being gso or not, you would have to check skb->len
> or shinfo->gso_size
>
> The ndo_features_check could then take a more appropriate action
> (forcing GSO, and/or forcing software checksumming)

We had something like that before but it looked weird because
it was just looking at the MTU.

> This driver claims to support TSO, but I do not see it using
> shinfo->gso_size, something must be very wrong...
>
> I would simply remove this TSO part, before the driver really supports
> TSO properly.

I added a hunk dropping the TSO flags for v2. Sending out tomorrow!

Yours,
Linus Walleij

