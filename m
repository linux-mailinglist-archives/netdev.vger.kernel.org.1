Return-Path: <netdev+bounces-237529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A2AC4CE65
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB6E421D81
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3720332AADE;
	Tue, 11 Nov 2025 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WT8q/Fqb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCD4320CC3
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855147; cv=none; b=gJozHm2ntrMcDnE7n3qqyuMH1G9nPeiQXTDjvh0W6MwBJeYfMTlmWwlNIyDTieSTtdb9jzS39cfyBvpMNvmlullDRD7jlIKN9n6Yw25iPRq0LFOOCAVdeZLN0z7XlAeKJ1FgcRoQqy49YiW5DUilQZwUXBcM7BWEgTcAciydHJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855147; c=relaxed/simple;
	bh=lOCIaq5MYiqkjF7JN9o1JXdIKKWp75UQH8ZqzpRmiK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzgyhOpdTfwYroLNfxqjVsFb7GbXp0cL+zR6AnI5BjyxDE1fxExvxzs4B6KAxkTSw/xjiShyE86uOnmroIx9k5jdEas3D/PuCHMhcq5SrxTLLCHcrxaSq26uOYfHdqeC9NPJtCmUA7JSZgMzAn4Xwa4BMUjGJSPslWN/dvdGpGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WT8q/Fqb; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b312a08a2so2028506f8f.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762855144; x=1763459944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjlk2cRXCuPrNRO+4Q+s712BaHBwWqkzdg7ZDqTvNUo=;
        b=WT8q/FqbP2eadLXthwJJn5z+xuQPjoCqwejuuerYPDyug3kui26cruq7aPMqlbm/aZ
         wWpRMsZyJ1d7WI3wRxoz8CAB0j4AcvxAz3+biCuNZ1mOIxt9XqCN3LJNRusMea8fNzTh
         EsSf4Np6r1KqobdEQzpob5ZV1rwqhGzLiJii21xrO0WeA4d1zOc/o1DxFGJDZY3grofU
         li8gqJlI9wX5MSRnXG2xAvL2xXaUUYbTlqj5+gFzPmz6M7G34BOgEP4VGylXtNMJ6E8n
         F3RU1rAInZp02DGnszTnCAFdjlEYGBpKHjTfzMXfEcOLdaCba/M7/GzWV8s6scKqhtzY
         qGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762855144; x=1763459944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cjlk2cRXCuPrNRO+4Q+s712BaHBwWqkzdg7ZDqTvNUo=;
        b=oDBjn6DilFEB+OevQj7KUxGNxt0c4mtyd0tQYBzBj33FnhrTHmhbDn0kvw3qhM5tbJ
         kDh0HKpqNmjzxx2LSO/ZBaJm6+eRJT65O0n5XNCpu6UvDv4zTTasLxA9WcwGKOh67You
         YcafnyxqUp/sjJIv1JmyRcxzRSYQJ8fCZoTpS6JzQcaZ6l4uPuMy2Qi/l4XZu5poLqD2
         y4Z1kVy1gTuEgr3QSUS6DcpdDpxdeeCrzYxfJAwxzQq5SIX4kQXxTEfCOLT3CYihZ8GY
         i0hmrso3r0jOGQcycv7pcbl/ti1IuDzquA4H5wPsCeS/LRz4+CH23nDy5SXgs8kGRMpq
         w+Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWIJZDKAQJMPz0NBsFl/6dPgG7/R2KMWiyVSEaH9N6I3FOuzKc/kChw8Ol0fMqVlN0leZzwJaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxauG5n8nufQOtIByS8K8knwRYCT2xk+q2aT55CW+nkKs4Z/gWH
	AZwC0LJdVZndn1SJPZk/qWm5DJroejiMcbfiJ9GL8VkFkF620tISxZ2Sp6Ws81A6Z/ZMzOwSrK5
	t9O+Ysk6zS3fxSXY1TYJKpJ8JVs5G86g=
X-Gm-Gg: ASbGnctqM5y24EwK4FuP2MFCNTW+VRvCoe9CmQHQQ3lTUmXGNzseD0ZCMn9fKa+znjt
	iUGzoEMdgtSbah6bNZMxypuIw/ydGGiXRWL4zbg9zJB//WmC+/5dSFIkpa+Kx+ivFOyfhkyuYKb
	nl2yx9NcsRb9xeixEhYQ46VFYcRn9UYFHaxtNRGBiEatliignnnzQ/K1xHAC7fCyETMCaeknHyN
	LrFjvFE71Tw+/f37BqxvF1o8nxqHOnCY/BShuiM775VNojlm3aGiXUvhLDK8cM94GF7kWWK
X-Google-Smtp-Source: AGHT+IGjntCvClMuhLxz7Fya0295cjdJ1m9OqTMAuyWKHxrVWXNBcWKh6jbg+Z6+nNLdGhpeB15uRACtQ6ldFO7VOgM=
X-Received: by 2002:a05:6000:2a0b:b0:42b:3dbe:3a43 with SMTP id
 ffacd0b85a97d-42b3dbe3f2emr3582660f8f.50.1762855143534; Tue, 11 Nov 2025
 01:59:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111091047.831005-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251111091047.831005-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <5be2d1a1-3eb5-44be-aa96-797be13ea7a2@microchip.com>
In-Reply-To: <5be2d1a1-3eb5-44be-aa96-797be13ea7a2@microchip.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 11 Nov 2025 09:58:37 +0000
X-Gm-Features: AWmQ_blGjwEL6cAjvRlCMCOm_yxAQYhX3C4hQ33OpP5_-OFXdvaWUMEmwRVdWuA
Message-ID: <CA+V-a8uJ2Cg6tUWQ_tyApQL6s0F3A2VeJw8mBLiCfqXp5-gyMQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: phy: mscc: Add support for PHY LED control
To: Parthiban.Veerasooran@microchip.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	Horatiu.Vultur@microchip.com, geert+renesas@glider.be, 
	vladimir.oltean@nxp.com, vadim.fedorenko@linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	biju.das.jz@bp.renesas.com, fabrizio.castro.jz@renesas.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Parthiban,

Thank you for the review.

On Tue, Nov 11, 2025 at 9:54=E2=80=AFAM <Parthiban.Veerasooran@microchip.co=
m> wrote:
>
> On 11/11/25 2:40 pm, Prabhakar wrote:
> > +static int vsc85xx_led_combine_disable_set(struct phy_device *phydev,
> > +                                          u8 led_num, bool combine_dis=
able)
> > +{
> > +       u16 mask =3D LED_COMBINE_DIS_MASK(led_num);
> > +       u16 val =3D LED_COMBINE_DIS(led_num, combine_disable);
> Follow reverse xmas tree variable declaration style.
>
Sure, will do.

Cheers,
Prabhakar

