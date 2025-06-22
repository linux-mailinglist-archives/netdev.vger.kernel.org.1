Return-Path: <netdev+bounces-200054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9EEAE2EF4
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 11:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7F8173099
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 09:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D33D1ACEAF;
	Sun, 22 Jun 2025 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGsTeCrC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4011A8F60;
	Sun, 22 Jun 2025 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750583348; cv=none; b=ZKLEqUW9kzc90xo5efsgz1rZwK4RQNkF5Xuv2BMfYvAgFnEkWIz0A2wWguhHzPyG2fTxZqKbR9E1PGci0/7DwavvYNFGkiY0r0+bzz9oqYc/C5EbyqIib5YJJnXs2ldHwYkkmc2KB7rGCTM6LfugJbq8cnRC9ld6b6FxgdycwsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750583348; c=relaxed/simple;
	bh=SG62WGaCLDI8YObRNSqb0QuUj6a8+t8Yq3aLnKYD40Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYi6S2yV18EnphqM1eU5Iku5canGnoViDcX85exUBLdiNEpO8SfCMBvUZE0r37S1Y+AuB3hcro2D+e9NA2vhTRlsZ0opwbzxqrRW0zsA5W0hVfJrSjz5kmzlJJ2U1rsROY1zuEXZ70IpApMoGohK1z4I0UQABYOdg6NZ7tyzONI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGsTeCrC; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e821a5354cdso412460276.1;
        Sun, 22 Jun 2025 02:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750583346; x=1751188146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujhMv3dGKnLx3efXHPVpQpjGtSxJ7hWBd9wshMdcgx0=;
        b=BGsTeCrCmukjBHfY7ifLRuD77d0gw3yAFZGOcXicHdQJBWCTS9Pj51EMWy/640hpzr
         CG65BenX4zQwCLUzmA50ZaHHjhaD1Bl8qoPHSwy/ik3QbNYMIYrAKQr0EWNX0ipFZORI
         eUvCVk7yrz49xui1BN+5bJYnlCvpooKCMKpxbG3LWnT2RJEssGUTyIgFMNDfzl4XKakk
         AC2ZmFR4qYtQF57AleMRsDxBztL7WrFhMhHIgVBq03qv3CBl+E606t00Pb2KHap5U7VP
         4krdKLzWODrYrvgZ/bW6tMQIA1odsHXb9w7Eh/+PMFuIFcyjKKiLOJSdN9r39rVMOfdY
         NeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750583346; x=1751188146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujhMv3dGKnLx3efXHPVpQpjGtSxJ7hWBd9wshMdcgx0=;
        b=hsn10T+aTcePl48dDQ1h3CGsYX2kgmy+Rkjg0IgPvv03qmoXgtmnus2KSO1NSMqmBf
         UFSazafbOQ0HzutK1eGWD7HzYwVs8NHAkhGInbGL/xim3hz4qJI7FoVvHnD2av7rqTxI
         f9e6+gOMtqY+QmNFztMbqrg0mHU7cLh0WI/Jvk9fbgiIfQBgPsfiJaDir45Hbtl6+mVe
         5K7u8n2aA+3FxLomdeNKKj3Z+zHpMOEdInDhxI+E4VNL67s9Vkg9SzS8k6UBHDjajXRe
         Jtu52jQ8V9GYADPjQkPvl09wbzLNJeusW2k8zsHEhh9K9HF6L4qz82sqsrHJBVtOtn1I
         2y1g==
X-Forwarded-Encrypted: i=1; AJvYcCUn6ACgSMkRkcQRz4JqM/5MftvqApuKYa9Cc603L5hk3+AqnaGA9BDEmV0o73jUmF9vborGyYQ3XZA=@vger.kernel.org, AJvYcCWiAXKytXa6gNivaW45vQkQ009dCNLFCGVhHc1juQii1yW+whytgeXA+T6nKUmDF3eVdpNvms3m@vger.kernel.org, AJvYcCWrrVV+srT/EAAWZ6+ekDw+1wuxxg7WyvYfj4c0K8/tyaObz5UYphcGBTBrtmxy2RF/HGrF01x10N4vOi1I@vger.kernel.org
X-Gm-Message-State: AOJu0YxemrcMkghJFOAzmUC+LE8Tgq5AanxgdqiL0oEKwmW8R7NG7Zz9
	4WYrxtyzuOwXc1btB6/BEcbMhOGF32V6d0xT5ixJayrOkbYJZI1RvV13+s7Ya/0mkES+9uzOxrH
	WamuBBEM95udsxnj47alg5B1vk1xURso=
X-Gm-Gg: ASbGncv+Dzx1a6WBK6SG23/YEIzvr3lcrWFNfwN6DezrklqkJmqlD/ZNOVBQOMwZWzP
	leGk9opmAq5CKwQTCcwq0CubLl0aHkFy+U0VgwU7KDm+RUvYeNtPY1Ory/V8HRWUWsLGeyU2Cq+
	n0ipTWNvCHUFRxRG0RnU8GOTm9iYVc3RaibBqvpEaeL2oLHeKEWwedcPah
X-Google-Smtp-Source: AGHT+IFh7WNJwFrHdEgYCRMpR1lM9TCow1HkjDHvL18GOEccw9ufr1mk8LWJVVZnElFIF2l8GUZ2uMbc1nexIy+kOmE=
X-Received: by 2002:a05:690c:4b10:b0:712:a286:2ca2 with SMTP id
 00721157ae682-712c654cc21mr58791337b3.7.1750583345877; Sun, 22 Jun 2025
 02:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250622062724.180130-1-abdelrahmanfekry375@gmail.com> <aFe62dzYPLktxZrH@archie.me>
In-Reply-To: <aFe62dzYPLktxZrH@archie.me>
From: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Date: Sun, 22 Jun 2025 12:08:54 +0300
X-Gm-Features: Ac12FXy3mdUs4tZkvbrDhBlGnrvP9jUXcybU85gnVa4vnDKPKn7VQarwzDhtloc
Message-ID: <CAGn2d8MjZ5J1eMCLaYNdJSbL4nbn9npxLedkRCgBXbfwq2i+Lg@mail.gmail.com>
Subject: Re: [PATCH net-next v4] docs: net: sysctl documentation cleanup
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: corbet@lwn.net, davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, linux-doc@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, skhan@linuxfoundation.com, jacob.e.keller@intel.com, 
	alok.a.tiwari@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 22, 2025 at 11:12=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.co=
m> wrote:
>
> On Sun, Jun 22, 2025 at 09:27:24AM +0300, Abdelrahman Fekry wrote:
> > @@ -1028,13 +1134,15 @@ tcp_shrink_window - BOOLEAN
> >       window can be offered, and that TCP implementations MUST ensure
> >       that they handle a shrinking window, as specified in RFC 1122.
> >
> > -     - 0 - Disabled. The window is never shrunk.
> > -     - 1 - Enabled.  The window is shrunk when necessary to remain wit=
hin
> > +     Possible values:
> > +
> > +     - 0 (disabled)  The window is never shrunk.
> > +     - 1 (enabled)   The window is shrunk when necessary to remain wit=
hin
> >                       the memory limit set by autotuning (sk_rcvbuf).
> >                       This only occurs if a non-zero receive window
> >                       scaling factor is also in effect.
>
> The indentation for enabled option outputted like a definition list,
> so I fix it up:
>
Noted , fixed it and checked for other problems like this , thank you
> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara

