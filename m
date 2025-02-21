Return-Path: <netdev+bounces-168632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAD6A3FE93
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 19:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625213BC6B3
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 18:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A0C2512CA;
	Fri, 21 Feb 2025 18:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2CC3h+vU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A6C1D5AA7
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161922; cv=none; b=FtK4Ybmg118cFm67jlW+F4GPmg56re/JpbWjXeJJ0eRtXddAz7i17QpYXSYzguvinzH+QUACl0DkL3mxreMiwk8kNozjyKE3Jfj94L+Zh4aiR9mdivIV6VzqqmCeWOGwo8tIFhqwLzAt8KTFz426X3tMwBNZNiSQPYRdlyaiUMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161922; c=relaxed/simple;
	bh=GGzFnXUDdo94zP/g/M0vl1gNFcXO3KuhwN3auxqRUAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5Ukk/iOz1SXjMgu1lh6G2GTjTDi9vYA6d1wi4kyjOgu6EUHk1BaWYExqI1ON1/Fj9HC2sNiYYdkx99iOyJNqdpiAdpT6Y65oRfLbnCGOgFelHO1Hq9jiMQKqdxdJoglQCgAmGp2vFj1EZFgmrfLwGF81mM7gKaReaBTuRJsCoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2CC3h+vU; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e04064af07so2879391a12.0
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 10:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740161918; x=1740766718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faRqCA81jH4txu0fAi9rdAQk4yfaELeIVteH/sliYZQ=;
        b=2CC3h+vUPUMa0M4uAc+cpZgbkYY4vKQHhCtAh0si/b+yP1wtL+cWKwOckjUBDD6qOv
         w6EnfRPDyMdtQ5aRTck42PcpNG8M7wxRLd3n3GclU9213Rnw65coV/FGpHQuwdTPiXaw
         tcU7Jyq1Mjig60TaW8Udl+tDKmSGz8t+I+tLazoCWChLaByB3+1z2OtGxgdxD4ousph9
         CMUP7E5yOQ2V84B5rWTeVowqjBFIMWbdTwkOdarLUA03LJqY0eM0Mq74eSJxaDcU/Lf1
         q/7iBtmxwGBFDyQWCtc9Cujn1VXKLUl6fN/sPME6++VtHDzZ2kFYIWq7iEDSeSG6iAvM
         UVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740161918; x=1740766718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faRqCA81jH4txu0fAi9rdAQk4yfaELeIVteH/sliYZQ=;
        b=exL3B19yDbDvcFKKbInEfh42leKbqnentKnM19dfjOF1Ky0r9vKqXnwaw+sI7fdFVO
         0sgEUc5t04avvBiykRAOSG0wQI0TMmQthRtDa32UBkJS4h6QrKC0ucO3Q2ti/qc3umQB
         F5N6h5cNbU597aCsj5LOonTliHnD+8aSHiYDLJq5yDHSFb2vCPsxyrphJhoU3kE2L/A8
         k7nx4adYLRs5avp10AaWuyC5XekM139Deh0+1/zw2cqxYWWWvZ3TWVpkPOAknGJHIyBG
         tiwSEIb6c89k93How7zrij4fV1usQrW8wEhm12pRRjcdPnZqBOe163U/bHYz2DspGUdU
         ceAA==
X-Forwarded-Encrypted: i=1; AJvYcCW+uwG16ytcluzKE+jKDAI2Np1r+IB1812733TDsBV6a/ZekBZi8ihuOTU41ya248bcm8ZoSBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ3oYQVuUj07ExXQjZWDs97ECxGcxVjsnHYP7T7oUNhHkY73SY
	FVuzmpAIL0xRTuIQOGSqySisEn8PCYiEj0dac8tpcHs/b+a2kHj8FSHnTcbQ9FFzQD+LXCDm6Da
	WI8M1dd7Ixb8rrWbq/YdJxGqK38M1gm/Rgrr0cURrfX/WuqaGCZ/0
X-Gm-Gg: ASbGncu7yTAM39GwHHbT8jF8ogwwVjizoI1mLD1rz3vstg9ApApvCLAPZS3+H4Tixiy
	vMHFCwANbZEC7No4D5qn9s9UVtZfVm2eOoXmnRCDBUCzztMyvH3Yg8IDdO2e/1vh+QhOT6mQnxw
	O6v9ecMLM=
X-Google-Smtp-Source: AGHT+IF6v8PIfym1PMyabOHdGTmRgwqRk4s4qoohzkIsffoZydOlVmaS6zsX3+sB8p+2yvlL2fXKdic+GCMXbK141jw=
X-Received: by 2002:a05:6402:4313:b0:5de:4b81:d3fd with SMTP id
 4fb4d7f45d1cf-5e0b70fa0efmr4107878a12.13.1740161917702; Fri, 21 Feb 2025
 10:18:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221-netcons_fix_shadow-v1-1-dee20c8658dd@debian.org>
In-Reply-To: <20250221-netcons_fix_shadow-v1-1-dee20c8658dd@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 21 Feb 2025 19:18:26 +0100
X-Gm-Features: AWEUYZlKwQ8cz6aUrcdxM4m4-YuXNW5btQgtHANtkvNmjfxNPFwqDaP_9afxZQ4
Message-ID: <CANn89iJ0ePmPZW6c3XzUbm_kND1r_EPxz7xNHgroAZwzDjn5eA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: Remove shadow variable in netdev_run_todo()
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 6:51=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Fix a shadow variable warning in net/core/dev.c when compiled with
> CONFIG_LOCKDEP enabled. The warning occurs because 'dev' is redeclared
> inside the while loop, shadowing the outer scope declaration.
>
>         net/core/dev.c:11211:22: warning: declaration shadows a local var=
iable [-Wshadow]
>                 struct net_device *dev =3D list_first_entry(&unlink_list,
>
>         net/core/dev.c:11202:21: note: previous declaration is here
>                 struct net_device *dev, *tmp;
>
> Remove the redundant declaration since the variable is already defined
> in the outer scope and will be overwritten in the subsequent
> list_for_each_entry_safe() loop anyway.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

