Return-Path: <netdev+bounces-70806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D59DF85084D
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 10:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C421F2279A
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 09:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9D85915D;
	Sun, 11 Feb 2024 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q0PuYQMw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8309045959
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707643803; cv=none; b=dmbviOogLui5BfpPfg8ERuyBOJ2y+IjlUotwF2ZPOBBX+iUBf4FX5X/526eYif0ureutCwC3+0MDSNS3LZK3Z2J5AwwE6wRWzmqiRNxeaON8MJKBsuSTu3PkenWChfHT4zYsEfcOIRvY9jvaySF3pnv40dBPS5W6mYnb2mcU3/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707643803; c=relaxed/simple;
	bh=r/dVsqbYCbIjb9Pvybo3o5sfJO+8c5aTctM6z+j9wo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQk5IB2zTb0BmDvs3n5UPaN8kLOzHB5rBZKzeUaQQKWtM39tX12F7IVWgVBCaUzc02zp07lV/iut21kFqfjJiWrbn6LmSBqM3Cqdx0ZCqpmYdfM5Kfm2wEJagFmVrXiGncxpq40LQNu4WMKH6Y4TUUZwqvAVMzwKqnvctU7TTpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q0PuYQMw; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-560530f4e21so6843a12.1
        for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 01:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707643800; x=1708248600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plvjJCu4IuPe8umFC/ZhvC8jroZegcHCP1zQ6F70iiI=;
        b=q0PuYQMwpU1eREplCzPPlJWK2HzS8fnX+yWzgmymlGDBeIf0FQ24AzMyMowMqtNfS5
         u6HACZ2AYbCvZHF4S+Jb4Om27WyYiHVZ4jcX/1JlsRj+byeWSAEXtTMs0UKXl03i1zsd
         HTjKgU+0RZA67ZXOLl4+4VnvgAHs50RRxz6WWiWA9eIlk+PyM2MN4AnanzH1jSVetJPD
         AKjAEx3nixK4DVTrB84y1kfswDCjgAx5ngxMqJZBK4ZZANPwlZcDUVt6uoDwH6tkotpJ
         I+6lTxXCZa5+LFfrxf/t9hmRmtd4K1851Y7FMux5gxlCpgFAze+57Jn/FDUHAp5t9XFE
         xSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707643800; x=1708248600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plvjJCu4IuPe8umFC/ZhvC8jroZegcHCP1zQ6F70iiI=;
        b=QrysN+83tgmBlXDlQGGAIC6wSydaaXbcOU8/LIbkggW0hDaXowLAfyvRQRZnCgYP2r
         XNZy0oHnXg6lAJ/L67TSrgpgU6EWPBvVx+FA2hQgLru9L7ljNFOzzTNRMDNgIjSeUF05
         AOq9wVWgummKYtJcbLEwu1L8Gw1s9iauEYesoRTjZZu/C4eR6O1feaoAVwpwIvgPKFqL
         D+F7TnedlAKxRYA0PbIlmAnqFf1ZWO6Kp3QDZGh+eSxYZXyPoH6YH+xBqa+y+QkSi2XH
         2pIY+1jQbloxzWQCEl18JxcWzaqhI3PCu39bX2hVnM+XjdaAJLWV3c1TfvqBOQgNdvH3
         ibKA==
X-Gm-Message-State: AOJu0YxfS2lfNzi3/s2HOV5DdZ9X7fQRo1DoPJ4k/LkPlRvwqiIFkSYm
	PwR7IMW8mGrF6fPRLuVxaW+1r1N0MBJhWzPLnYmfJmKgdhR38jyXmmeX1TUpr+Tz7UpH9gDIn4R
	ECLozLPGTR+vlBUCkQCS/kCDIskLePtRzg0ma3pIqU5+A5ytQ2Q==
X-Google-Smtp-Source: AGHT+IFXtpDPdWOFUwB/PBxH+quqk2FRNvcS11lCN3EfMDWcBTmG1JK7+R+xj+ZFqxXr+TCKICxVYDw2D2akw6AYyO0=
X-Received: by 2002:a50:8a9e:0:b0:560:f37e:2d5d with SMTP id
 j30-20020a508a9e000000b00560f37e2d5dmr85280edj.5.1707643799475; Sun, 11 Feb
 2024 01:29:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209181248.96637-1-edumazet@google.com>
In-Reply-To: <20240209181248.96637-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 11 Feb 2024 10:29:48 +0100
Message-ID: <CANn89i+yKN-9NSu1j-nws8u8vGnfJpz6o82JaF997r7NYNcXeA@mail.gmail.com>
Subject: Re: [PATCH net] net: add rcu safety to rtnl_prop_list_size()
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 7:12=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> rtnl_prop_list_size() can be called while alternative names
> are added or removed concurrently.
>
> if_nlmsg_size() / rtnl_calcit() can indeed be called
> without RTNL held.
>
> Use explicit RCU protection to avoid UAF.
>
> Fixes: 88f4fb0c7496 ("net: rtnetlink: put alternative names to getlink me=
ssage")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jiri Pirko <jiri@nvidia.com>
> ---
>  net/core/dev.c       |  2 +-
>  net/core/rtnetlink.c | 15 +++++++++------
>  2 files changed, 10 insertions(+), 7 deletions(-)

BTW, when testing this patch, adding many altnames to one device, I
saw that 'ifquery' would not see the device,
and all devices following in the dump.

This is orthogonal to this patch, just a reminder that some user space
programs do not cope well with one netdevice
needing more bytes than their recvmsg() buffer size.

Apparently ifquery is still using a buffer of 4096 bytes, while "ip
link " is using MSG_PEEK since 2017 to
sense what is the appropriate size.

