Return-Path: <netdev+bounces-136739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636929A2CE4
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 20:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27805281E74
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5E6219C85;
	Thu, 17 Oct 2024 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDv/vi6s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A2E1DED44;
	Thu, 17 Oct 2024 18:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191543; cv=none; b=VCTpjZv3NGk8ICKaATOfKUTBOYc5vM86Fcb1R0CVKAEq/jzypemokT41ngdgBaAUtBEV65VAjr3xhZ+QimEUuwIkFfko8FkqdcGYSs2/jGGHRgIiNvR0sp04F0FghDwBzlVE9wuBcAV+sHlAThJ8/iNg+gPl7Tiw29zD3HtiEag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191543; c=relaxed/simple;
	bh=FvGY+kyegglu6hHgiHzS/jYFOrhlp2cqld43oO903Ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+arJ3ysCO6HgUUNDIBTxOhqK16h9K3K22Ftjz9P9p5hJPba/CG6lk3zuCh59w2fSgm9m+u+CZlHQmLnWfOeYiQ8IceEfCROkrZuGj46WVXn4YiG2P9ofsJiIr2mZIqf7qVsoTUd+kKtEXPljx9KkBpW5t1Q9Sol5gEoW6if8J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDv/vi6s; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cb14ed25fso1071505ad.1;
        Thu, 17 Oct 2024 11:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729191541; x=1729796341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvGY+kyegglu6hHgiHzS/jYFOrhlp2cqld43oO903Ew=;
        b=PDv/vi6sxXzhN9ahPxDQLxAMOtpWunKh85j4HQyW2NX+wbdMQSqu42UP4ymHeNzX5C
         QLQbhAFWATeOr1BjRde+mj/3ssYiEOg9ketQ72Q9x5poBUxcWA+N65nxZcBTGHtfvf7z
         KSbg1F7eDrtqfPt939VdpHFEE3o2D34F2zxvAw0TYl1faFhWv5PBeLlwV1DEaciC19Hq
         CtJZJ64mShali452u1ariizMgtDGHTHMk4fq9H5+FPqpdqi8V0sYsrjv1DKXDyvSBb+9
         wNLXe8w8hEWgnN5DommIKWSd0vMCr7TOqLNccvI+1PXG1kEMjCRmY7j8yf/vOio3Xl+D
         2KhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729191541; x=1729796341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvGY+kyegglu6hHgiHzS/jYFOrhlp2cqld43oO903Ew=;
        b=AAPoRwaS7FX5psZG2s2PhhpWah0eJL9mIoE5jaursaT0wVp9+KgYbGmBXvuhitatiK
         rtw/rC4Sf9nvXGnKoekWc8FYeJQOY1cr5bIOhrWra5BI8y0tHPvkAjBB/9BaOkbJqfnY
         Q4ZuBkAgTLEv59rKuhOi+P41EdAjUMigOrgHCsffTitTwc4E1gJC0t3NqlNLeyB6cItZ
         g6PAh6Cb8YLfxH0G1d0BmTE5B/N8uwEkVfbmkVcESFgwbYJ+wVj8hYaRTWou7YQh0z+Z
         bnkV4SP6Decr6VAEspuEO9aF/J8BGixzQAgvbmIm8a3Q+MAzYWnG47kVPmT9D/jIGwE5
         ewgA==
X-Forwarded-Encrypted: i=1; AJvYcCVm6Xpeb4k6MvBjnLl4IdcXCimkDU4LcSy/YfDDXbCh5O18QgpAHOqZfwNBa32ggtQDnQgbX0dwz7UVAHE=@vger.kernel.org, AJvYcCWPPU3BdIuiJhV7pDY7l1VyjoWY16bNCFpFcEAQXJwshtT1ey6dIiegqcl013yJaoUUuXhACAsXVK0eQJQnOW4=@vger.kernel.org, AJvYcCWmmpPFkNxQ1gEzP9ojsZpJP5qmwasrisVKpxz+s2jdEnDzl/uOE3zShJM3QnIxeU0UD2PAAZhw@vger.kernel.org
X-Gm-Message-State: AOJu0YzRhS1RteL8P6iX34y7bCMSf4hriLRNbqs7PBsxdlvdEBvP2Qqf
	mhQmUVOUjC+sjFZghAFzJgRTDHrWIiQ9UPPnSse+EP5GNgSxqtpuCalMx6SXacJPtkrb5zJ7cl3
	GCno16NziatiK2hovSyKTl+66KJE=
X-Google-Smtp-Source: AGHT+IHqAEd+Z6vKcj/6y+M0+t6z5K+Qjjlna7RDsLyicLo8lYc+R09lYvrvCbCMvnZS5ZFGsgZUiq2sEfR5pcCWwSU=
X-Received: by 2002:a17:90b:249:b0:2e3:1af7:6ead with SMTP id
 98e67ed59e1d1-2e55dd1f397mr215856a91.5.1729191541074; Thu, 17 Oct 2024
 11:59:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-5-fujita.tomonori@gmail.com> <ZxAZ36EUKapnp-Fk@Boquns-Mac-mini.local>
 <20241017.183141.1257175603297746364.fujita.tomonori@gmail.com>
 <CANiq72mbWVVCA_EjV_7DtMYHH_RF9P9Br=sRdyLtPFkythST1w@mail.gmail.com> <ZxFDWRIrgkuneX7_@boqun-archlinux>
In-Reply-To: <ZxFDWRIrgkuneX7_@boqun-archlinux>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 17 Oct 2024 20:58:48 +0200
Message-ID: <CANiq72kWH8dGfnzB-wKk93NJY+k3vFSz-Z+bkPCdoehqEzFojA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/8] rust: time: Implement addition of Ktime
 and Delta
To: Boqun Feng <boqun.feng@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org, 
	tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 7:03=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> but one thing I'm not sure is since it looks like saturating to
> KTIME_SEC_MAX is the current C choice, if we want to do the same, should
> we use the name `add_safe()` instead of `saturating_add()`? FWIW, it
> seems harmless to saturate at KTIME_MAX to me. So personally, I like

Wait -- `ktime_add_safe()` calls `ktime_set(KTIME_SEC_MAX, 0)` which
goes into the conditional that returns `KTIME_MAX`, not `KTIME_SEC_MAX
* NSEC_PER_SEC` (which is what I guess you were saying).

So I am confused -- it doesn't saturate to `KTIME_SEC_MAX` (scaled)
anyway. Which is confusing in itself.

In fact, it means that `ktime_add_safe()` allows you to get any value
whatsoever as long as you don't overflow, but `ktime_set` does not
allow you to -- unless you use enough nanoseconds to get you there
(i.e. over a second in nanoseconds).

Cheers,
Miguel

