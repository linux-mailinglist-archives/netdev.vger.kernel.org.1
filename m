Return-Path: <netdev+bounces-64283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5658320A2
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 21:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478801F24B15
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 20:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8312E652;
	Thu, 18 Jan 2024 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVCOjyrM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A770D2E83F
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 20:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705611380; cv=none; b=JnQC7E9ZKA9P/PwDsedITcZ7l6fAOcUCx0zs4hBgGPJM4yfQs/lyv0/u76M5gpAtQWg7RoSAHBzFKlU5qF3JBDhZ3MBrpzeSjjsIyw/bitbrwhMxQ4Y0eQdkOwUoGiFyInFpXUKoYFFRlhoOVm3pCYJrNqnQXJv3DsluH5U6Eyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705611380; c=relaxed/simple;
	bh=T/Nrim81j05FhYXQoyD1H5QDhK4/U7M9KJVAQg+Yb2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmqYu2j3I082pnoYl6pjBgNnkkdpJquxIPy+6qk1LgtMZL2MK659BgCpIV9aYCjIDAIBdHi75l8HXUumdJyaUu9eYQYvGeUWqkhqf75Lfk9uZuQ7newOgzD+3jrATV3gy7CtG4AaTmPFfKkOtXNaHjGdUrmpFdk2knUSnUkrsQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVCOjyrM; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7cbe98278f8so14491241.1
        for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 12:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705611378; x=1706216178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/Nrim81j05FhYXQoyD1H5QDhK4/U7M9KJVAQg+Yb2k=;
        b=IVCOjyrMsuMlrhOuotlL4Nz1IZmKRYDqgmwWNBbphfln66DcD6p8bNanvCSaIwT/fe
         yiiDYMoZeWXb/JPe+GcNekMK/Gkvw1QlakBH2YJb/IoT9Zz676bULrMlV70mHehC7Ecu
         DdYrqrrDRYpSLceptoDODEEJzbfYml8FnQxRjYzWeBFCZXnpypBnYFLOZhKmiO2lZ4dJ
         frvWyThRHgY96M8RmEg9sdcS1eCRSUUGmQixeJ1psmdQ4RpYxtuf3xlBjrN0/5Huw3q4
         wgUTFPUDebUZZ5JKsykoUm3SzEODtpzEwBHcUolp1n58cEYbeKmJMkPsc9P0dQrzfFaI
         1/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705611378; x=1706216178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/Nrim81j05FhYXQoyD1H5QDhK4/U7M9KJVAQg+Yb2k=;
        b=Gn3zZmOj5RLQ0mw56ui3kwcJl3Bp/YlgXhhA/2KF4LNzbaGab75As5J9j+wXclzGQw
         M+zmuIyrGg4sZtL/TrZHprWanp1J+6ep16mYHXxc0/K6nOyUf1Uiownaoaxel+cmk4cx
         ZbwUHyKAcv/HzckSAa52uEj5ixMyX9bWUOTLZhLlW7gyuN2ismq4O07hKGsqWSfBa2kj
         yzz20uvWQ4wA+0T3/D6Ky2GfRA+jHQVeTk8v7fSHVTyB4L2+nWaWsfO62hGM8S3GNr6h
         jbUJE7fxr0AbD2i9Ctv0yG9Da+NFZrTWvaMYcmp2oBinks7xxAS9GUQxO4cMQrcSmuq5
         Dw3w==
X-Gm-Message-State: AOJu0YwaPCcmYjnlNKlb2DyAHSKs7zNVyjtYtN5uLMaxpHHhzLas8M8g
	n7YGujPRm0y0BtlqIIb72LZKZD1vjdKUuIUrq0AVj5mf9XBJPwGCKAIi7V5jc3y18PGhT0SJGH5
	A7m4pEz6mS1qiJADnBloLYrS5z3E=
X-Google-Smtp-Source: AGHT+IFYIrNY+882qWpNgHSG+4/03uTCh+RD/zrbKYlrjrxs8sNX3jZqNq3Yhr3E4tEirBdwi3UsmAwp6eNKV4iLmjA=
X-Received: by 2002:a05:6102:a91:b0:467:9f70:e137 with SMTP id
 n17-20020a0561020a9100b004679f70e137mr1755700vsg.34.1705611378453; Thu, 18
 Jan 2024 12:56:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA85sZvvHtrpTQRqdaOx6gd55zPAVsqMYk_Lwh4Md5knTq7AyA@mail.gmail.com>
 <CAA85sZtZ9cL4g-SFSS-pTL11JocoOc4BAU7b4uj26MNckp41wQ@mail.gmail.com> <20240118082150.53a4d4b9@kernel.org>
In-Reply-To: <20240118082150.53a4d4b9@kernel.org>
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Thu, 18 Jan 2024 21:56:07 +0100
Message-ID: <CAA85sZsC3z0HNurp=xBUZmp9zVLYG42TCNJR3BzvioehY=dspA@mail.gmail.com>
Subject: Re: [mlx5e] FYI dmesg is filled with mlx5e_page_release_fragmented.isra
 warnings in 6.6.12
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, saeedm@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 5:21=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 18 Jan 2024 16:27:13 +0100 Ian Kumlien wrote:
> > > [ 1068.937977] WARNING: CPU: 0 PID: 0 at
> > > include/net/page_pool/helpers.h:130
> > > mlx5e_page_release_fragmented.isra.0+0x46/0x50 [mlx5_core]
>
> Is this one time or repeating / reproducible?
> What's the most recent kernel that did work?

Unknown, the dist kernel seems fine (5.14.x - frankenstein) - i wanted
a newer one to enable some offloads to improve UDP performance...

