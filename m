Return-Path: <netdev+bounces-63960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82F88305F0
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 13:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F42928A376
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 12:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4911DFEB;
	Wed, 17 Jan 2024 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BuvkPdym"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02A1EB27
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705495746; cv=none; b=DrEUISJt+Ef86OsPp05gQ9QEUf5l/EMQJiV4g3Y3xyCDfbvnDXdGBkq5hpLqukxOMEHqKcVPVI6S2ZUkN4gbKfYuIaneIeuqKQrk0lhQnyFZk/PlIVoyvpw1bfLMHZIiVDZlk/XHpSrXgRNYiXnM5fHgzFxvfVYEAyAZhxSldnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705495746; c=relaxed/simple;
	bh=V7uM71LtiV0FvnWZkwqSrNkKCNxE2zFVllc4GULWNZ8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=J4ALiwOJlaEgIYB3itl9MCsWLHYSQSqcSLAM+ofNvIT4oOggyr/y0rfmc+7SHaNvHaRT/Z8PabyBF/bKeaP5Lws1OoBtBRdH5GL1/19h5IEM5TtGKGwyd0+4x/jy11Dvi6ZC7GhLcH8ciRQjCi/IcHX9bZCDGr1cdhAH2NZT2/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BuvkPdym; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc236729a2bso891780276.0
        for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 04:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705495743; x=1706100543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7uM71LtiV0FvnWZkwqSrNkKCNxE2zFVllc4GULWNZ8=;
        b=BuvkPdymrqfJ0se9mB9oxLBaYBTdMkm3VZHZsnVz1Q8fnHZ4EqV2GdH96DG1q4xz+T
         yN4ZxqVntOabZwwuD7tzaqyrDBdqMuP57z0gL4Qsf1R2h24pxQJQDwl3Z+cf7AAx5Aa7
         W01U3eAfVr7BZAdnZtMPqj7DyunFDcq+6/q3JkI9yGg6w1fBkl1m/AXG9Zp5gC7Vn6ey
         RJcqwVv0l6zQZ2BfZ3InLXNL0dg8G/nFAQhYQMgRReHLjEDAu8J9YTJi03yY5BBwtFQk
         yL+fdBQ8LiY53zs8WD/2RAx3Zfp8VISoxgmMNzzj7QJSeHiqTXT3RpWTXXT+2Sg19GmM
         Qgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705495743; x=1706100543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7uM71LtiV0FvnWZkwqSrNkKCNxE2zFVllc4GULWNZ8=;
        b=rlZnhFoGeJQxHGAKwoStUG4HHB/ysMHNyWXMBYDvFSuCAEyKjzUvSuSKVTPvJaMfuR
         DzzLrtunrQKj355BK6r/QruitkMLurlve7gw8LWsNVNsC3C6ERyMyvSkPW83zdTIlx4N
         7c+5ggyZB8sEA3FvqubrqWqTlugBzEZl2s45O5xQo3yLmaNuJoyLUkpWHI/IpQHHKxt5
         6fWQKYfQrhujRsCH2p48N2SedvrKDP9O7oIcUUEC6vEGqL/vzZ7vhMd6EjFuhNC4rIht
         RnYtk+p/c4bEJxoi8UTGYCobF639x6ayAoCCO9c+MjbdgLZNwBzA/zWhaOhchjwmayvl
         VX1g==
X-Gm-Message-State: AOJu0YxKQHRt9sVV7EAsGE1+tzMsD6IlR88HAx83RDMR3olP0zDNeZMg
	Rgur3iS3G/ulG91cAGNh/NX1a4KAFFVFCWQBVoZPlFScjknBkA==
X-Google-Smtp-Source: AGHT+IG2dllBzfhsVjYnc/b62YEqjDxH7GaVFQPHWADCMzoFjHIZ8BE/8gITahGufq8QfJ5m7PbKmGRb34mRpsO4mno=
X-Received: by 2002:a05:6902:49:b0:dbe:3257:f23b with SMTP id
 m9-20020a056902004900b00dbe3257f23bmr4487022ybh.108.1705495743488; Wed, 17
 Jan 2024 04:49:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223005253.17891-1-luizluca@gmail.com> <20240115215432.o3mfcyyfhooxbvt5@skbuf>
 <9183aa21-6efb-4e90-96f8-bc1fedf5ceab@arinc9.com>
In-Reply-To: <9183aa21-6efb-4e90-96f8-bc1fedf5ceab@arinc9.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 17 Jan 2024 13:48:52 +0100
Message-ID: <CACRpkdaXV=P7NZZpS8YC67eQ2BDvR+oMzgJcjJ+GW9vFhy+3iQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/8] net: dsa: realtek: variants to drivers,
 interfaces to a common module
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org, 
	alsi@bang-olufsen.dk, andrew@lunn.ch, f.fainelli@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 11:26=E2=80=AFAM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.u=
nal@arinc9.com> wrote:
> On 16.01.2024 00:54, Vladimir Oltean wrote:

> > git format-patch --cover-letter generates a nice patch series overview
> > with a diffstat and the commit titles, you should include it next time.
>
> Thanks a lot for mentioning this. I didn't know this and now that I use i=
t,
> it helps a lot.

There are some even nicer tools you can use on top, i.e. "b4":
https://people.kernel.org/monsieuricon/sending-a-kernel-patch-with-b4-part-=
1

This blog post doesn't mention the magic trick:
b4 prep --set-prefixes net-next

And
b4 trailers -u

Which is what you need to make it an awesome net contribution
patch series tool.

Yours,
Linus Walleij

