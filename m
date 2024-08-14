Return-Path: <netdev+bounces-118352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D52F59515CF
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 136C41C22CAC
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 07:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA88F13D503;
	Wed, 14 Aug 2024 07:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fgADI9D+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E21713CA8D
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 07:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723621701; cv=none; b=VARYdkiG8M+HUhaTOhLG9kBvgBwi1yOAPoUPu5Zn5F/MWHwntQuFeIk9GfIEeRV+vKaLEVgBbeHSSRDYybMgtOXaWTGk06r2hW5VM9shnh7OaOc9HnExLDaxJVWCriUlO8dFmud4R8TekYLiM5ZCuukHh1BlxY2qkVK8bc4rlos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723621701; c=relaxed/simple;
	bh=JZkPj2Cj5l6KrmXL0vbqvyYLl7gc6iX0WSxoSoidQqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDyFuSwgxJOg5gw7F24JZjOZm7jBmHPyHVnze26DtKSN7J00mDgukxWKbUO8hnPivb2lIsUBEov4EvNlMHTrwio2GNyUwKTn8VNiyiensJC1+7fiyR9+NL6etw+lmXeJCgd/JzKPDtlkVX5xudhPEFrUxEzz5pZOVkYr/AWXPm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fgADI9D+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a94478a4eso109630466b.1
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 00:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723621698; x=1724226498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZkPj2Cj5l6KrmXL0vbqvyYLl7gc6iX0WSxoSoidQqY=;
        b=fgADI9D+gR5x2mh9GZg64+hbX+ciNIADAOttC/YGkaJG6Lq04IY64kqr8w8O2skpiE
         KSfPlUv7HkwCvZZES44knERJASd1J22jK6f8V9S+0DdvJhfWqCS6BjmFsnpNA98BVb5i
         tgXedKmsbTdLIgrEHC81vWQ22WR5eShRSMmD73EwNKioOJiXsCImJVPHqUAKew8Mr4VN
         Mw5j3SJNr2VyrU+Eg7pFwdh8dEzdyl53I7RD6PzhvS7jedtTWQBEvIARruRCc+GtH+5r
         o57cSqmzepEy7lgPYKU+B8cWsYifeN/r26XDzHjen1geVTQa3fWbelbP6XGJxFHXWFBc
         yanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723621698; x=1724226498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZkPj2Cj5l6KrmXL0vbqvyYLl7gc6iX0WSxoSoidQqY=;
        b=R+04E1RSAX+NxUZsv/KLK+7a1v+T2YlbyYKNnqyjrJORRX1ZM0MlAsur2UizZtmvRy
         nMB1kt3G8Y86y3uuMNraoxy+ZRjBqLBjKQZLQU7+AP2hAKvFwgiW1Z3JA2wTL3mIm240
         EdlO5GUgoFiB6qXkTHPmGXXtF+BLg+Lsv1GGw4WBCl6WCj1SuiHZliLXpH5DbToCFLp2
         UlyAKEODaIBRe2SVMZXJD2pLye4kncCasW84xLH5w4dxyjH/7DFkgwubldlAqpftlYKH
         R9SXLPulkhH30Hgew4Vseyb+rzWISB+9OZTs8RI4JDfxXRYAVCb5AVh+7Y419JYt67vW
         bXcw==
X-Forwarded-Encrypted: i=1; AJvYcCUf5NSYQnVwRVunlNW4sSj3qWngCmKf/x8u/i4UOCMskWcUUGwoB4Q8+iNNr3u1NDoEOeRrcCmhAOL890gQn+u55P2SpxBH
X-Gm-Message-State: AOJu0Yx+s+hwja4kaJl9fQWkRBT433m/O72WafGzyZrT3AuXETlANv3k
	rPJYN5OGcdaFJ8OPTUBCELrbw1+bUeXlflOoFdrGPwWpufYTwqRHcTfRNRmsE8KdKtbSpbMyHE/
	5yZ5LGtudhwmsJUwTLG/rCqGicPvGH1CCG17B
X-Google-Smtp-Source: AGHT+IEw0FWddU2VM7FL4SB4ziEIiea9ZyXl/wiMmVamK8vTcv4llrjwTmWjCDjcfsY7rSUg1pZnLpq0uxNNch7PRO8=
X-Received: by 2002:a17:906:4796:b0:a77:ab9e:9202 with SMTP id
 a640c23a62f3a-a80f0a778c1mr394590666b.4.1723621698031; Wed, 14 Aug 2024
 00:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801111611.84743-1-kuro@kuroa.me> <CANn89iKp=Mxu+kyB3cSB2sKevMJa6A3octSCJZM=oz4q+DC=bA@mail.gmail.com>
 <CAL+tcoAHBSDLTNobA1MJ2itLja1xnWwmejDioPBQJh83oma55Q@mail.gmail.com>
 <CAL+tcoDnFCWpFvkjs=7r2C2L_1Fb_8X2J9S0pDNV1KfJKsFo+Q@mail.gmail.com>
 <CANn89iLNnXEnaAY8xMQR6zeJPTd6ZxnJWo3vHE4d7oe9uXRMUg@mail.gmail.com> <CAKD1Yr2rqFdtCNmvacEvd_DR3nGVo8+7+sbGPU=g6Gr45T9TQQ@mail.gmail.com>
In-Reply-To: <CAKD1Yr2rqFdtCNmvacEvd_DR3nGVo8+7+sbGPU=g6Gr45T9TQQ@mail.gmail.com>
From: Lorenzo Colitti <lorenzo@google.com>
Date: Wed, 14 Aug 2024 16:48:06 +0900
Message-ID: <CAKD1Yr0SkjAKLpsvRw9J82f0vHfqLv_VTFQjtZvamzJ7jwVcHw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix forever orphan socket caused by tcp_abort
To: Eric Dumazet <edumazet@google.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Xueming Feng <kuro@kuroa.me>, 
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 1:43=E2=80=AFPM Lorenzo Colitti <lorenzo@google.com=
> wrote:
> though unfortunately they don't pass on unmodified kernels (I didn't
> look into why - maybe Maciej knows).

Actually, they do: just git clone
https://android.googlesource.com/kernel/tests and from the kernel tree
do path/to/net/test/run_net_test.sh sock_diag_test.py

