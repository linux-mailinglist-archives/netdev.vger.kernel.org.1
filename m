Return-Path: <netdev+bounces-140199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6C29B5837
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 01:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 393BCB213EB
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41007489;
	Wed, 30 Oct 2024 00:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qw5JAiph"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A056C1FB4;
	Wed, 30 Oct 2024 00:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730246835; cv=none; b=JmS5vqnkdd22LSc1Ja6VznWY3br4+ICtWN9kfhRA8bDrfqVHY+0dbyDY40YVNqZK+qtc4APhyEQtlVCDCfhUs5roiTPrLE0Om3NRt+DA2r8rYEcIF8zbgckJMRSBjRkAX6tB2iNfn/Bp3McSVXtjFmz9lR2KO05HsdM3TQqDuog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730246835; c=relaxed/simple;
	bh=S37voPQVDW68N9rTKPE3PrA1vjsOcLJcpFUAj8ajGPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ab2MzY+3HywmYAJl5GvecKJ3lcQB9w7yCTko7Y2WmF1BKhIOIQarfNctN4EgHhO6Zz8eukjZcggl39qLFlBF3gD1ia7AEcZtggk5tOKQLjYaeBPn9HFq6ZFwR76gXqBqebXR/tAEmbwrGXeE1BKSPA5kns/SUnV2xqR+V0RSwNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qw5JAiph; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4613162181dso33703981cf.3;
        Tue, 29 Oct 2024 17:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730246832; x=1730851632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uI1LGMbJbLYFsIhRBi1cS/8+vbTbIoNQWToq8qf8C0=;
        b=Qw5JAiph9lRWTP9OHan9430a95slTwePWJ51J11yXNYgnD+74afNFcc4VbVdfpDVj1
         u4qriWz+Box90xs4Nmh1373sSAPOE6A24OHqr9bXWC/iCrbHxyu0hnwU/5+an7Wom04J
         0Ri1yVohBqgJzQTO8vbOTMKKLdiZS5CvIOjP/r++8EviwHAoQTRYHunz7pb0hagxeFWD
         CCG+Q5mjtUq/SpCkI+x5xdwYATSXo30KyinBtT03duMeXeW+PVaFwwecPj5T7YMew9Ln
         tnYSNTdPuQU3RTYRAi0HznSEdDM1epFH1VP97gqjPlpIGDM7/GXfjECOFXqt9ivuNnYn
         jpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730246832; x=1730851632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uI1LGMbJbLYFsIhRBi1cS/8+vbTbIoNQWToq8qf8C0=;
        b=F7i103BjJvAyDFLV+6E49+OaqYgga0mssUXu7nFASUMNIOO7qP9UlRJpT4dUoqb56F
         23JTpquyy86G6M92qgJcK7X54nFQnOQUFZbgdfiLfXVHBVY8itF270atEuL5d1Keu+Vv
         K6/xgk7xegPCe1sU4SLhQGzN5PIpaJAqRTmrfvjIJvdy+boSBBimvfngPmtoDp7Aj+Rh
         S2hhQNNOwtJmwOb4ZKk0FTBZfc/e5niv9MCYiwYHd5Hl2p4hxYyHpMBokP1GFt9297ul
         5oaa23UeO3T0ac89/5oIwe7JKMkGhUnfiY3vKONxgNgrmWZ+5pkUjhwAXeNevSHDvFKx
         tyJg==
X-Forwarded-Encrypted: i=1; AJvYcCVBT9bS/NuMsGWYMty1COFaA+VC8tUCbp/ERcwm2N2+X29Q/iX39N+RIgwcH6AAKMc1S0BxxOHs@vger.kernel.org, AJvYcCVL+lTotKNMp1uXDCcrV4BTQXcy8N4c6XyDLeWGB2dUIYp6sbD/O/PDa1L06Ij/2DGAf9yVX6k7LegK6gk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc/V2WFYGgA8+svRr7AXfRGJYPGeAvw4EHDSH9nCJnCyaTXXZb
	js0QLicvmzUxJzbcj3PkurWrH41nK18bQ7fUHDbCpN0WRlgnGjXFaFMIgejV+WITjpLbiJEHpIK
	q7x0pf9TxmGPEt53D8abpDvfNntQ=
X-Google-Smtp-Source: AGHT+IEyJngScPS5OHIxi6FIdyEq17NJ5SRuD59LnStEz4kNTb9/OOaPPalri+LndQzJ2YR12dvQPd5oUNPLvZ3nRIA=
X-Received: by 2002:a05:622a:15d4:b0:460:f34c:12b6 with SMTP id
 d75a77b69052e-4613c11c0a3mr215403631cf.44.1730246832406; Tue, 29 Oct 2024
 17:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023012734.766789-1-rosenp@gmail.com> <20241029160323.532e573c@kernel.org>
 <CAKxU2N-5rZ3vi-bgkWA5CMorKEOv6+_a0sVDUz15o8Z7+GFLvQ@mail.gmail.com> <b4f4eace-117f-4d55-bcf7-6718d70cbf88@intel.com>
In-Reply-To: <b4f4eace-117f-4d55-bcf7-6718d70cbf88@intel.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 29 Oct 2024 17:07:01 -0700
Message-ID: <CAKxU2N8V7EydvrNDgps2-RzCg=gJvc-uHBQ8GFon4MzFKzG8jA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: broadcom: use ethtool string helpers
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Justin Chen <justin.chen@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra <manishc@marvell.com>, 
	Doug Berger <opendmb@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 4:55=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
>
>
>
> On 10/29/2024 4:43 PM, Rosen Penev wrote:
> > On Tue, Oct 29, 2024 at 4:03=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> >>
> >> On Tue, 22 Oct 2024 18:27:34 -0700 Rosen Penev wrote:
> >>> @@ -3220,13 +3212,13 @@ static void bnx2x_get_strings(struct net_devi=
ce *dev, u32 stringset, u8 *buf)
> >>>                       start =3D 0;
> >>>               else
> >>>                       start =3D 4;
> >>> -             memcpy(buf, bnx2x_tests_str_arr + start,
> >>> -                    ETH_GSTRING_LEN * BNX2X_NUM_TESTS(bp));
> >>> +             for (i =3D start; i < BNX2X_NUM_TESTS(bp); i++)
> >>> +                     ethtool_puts(&buf, bnx2x_tests_str_arr[i]);
> >>
> >> I don't think this is equivalent.
> > What's wrong here?
>
> I was trying to figure that out too...
>
> I guess the memcpy does everything all at once and this does it via
> iteration...?
>
> memcpy would actually result in copying the padding between strings in
> the bnx2x_tests_str_arr, while the ethtool_puts turns into strscpy which
> doesn't pad the tail of the buffer with zeros?
I'll remove the change in the next version.

Still doesn't make much sense.
>
> >>
> >> Also, please split bnx2x to a separate patch, the other drivers in thi=
s
> >> patch IIUC are small embedded ones, the bnx2x is an "enterprise
> >> product".
> >> --
> >> pw-bot: cr
>

