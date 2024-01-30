Return-Path: <netdev+bounces-67314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D6D842BD5
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 19:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1E81C23B3F
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 18:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027B5762CD;
	Tue, 30 Jan 2024 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z4kgCRVw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A3E762C8
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639634; cv=none; b=u9VW8HUZsqO3FyeDrkntxHzmwNrO8voxFaODqvY76zDirhex3OHqicONckJyISFQq2Y0Ygy1o03U+hWJKN6dfyCJ/y16qcdyxEO+qVNtmzin4QjA30Ar7TElOb6yau/eOhdVPY0uhOcJCgTXN6nw8jtw50jWXBaiMv6eSiTog6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639634; c=relaxed/simple;
	bh=k47AUJB6ROgRfOT0WDPnEsj9abjtahVi1B2DJyIixs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEPqubo5dZ+m6Nzc+8F3iWkUtz9ba65YtaV7JVXOlUtETZPYZ9F4Uil+/tIFZnCniuNcU6rxCEVdkYusMtE6g4PsonR3OS0t+SIGaLS82qHQDB/EYaA6TvJMYF6cRW/BlCgzXh6WAdwscnjguBMBjPEHL8pm1xgHi9NkWdePxR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z4kgCRVw; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55f5d62d024so506a12.1
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 10:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706639631; x=1707244431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdGWsc0oH3bWWgxR/5+ywKCOsUUjq3kFGwbUvLrZ40E=;
        b=Z4kgCRVwW/yqvzqU1dzZN8rePeH9ZeskmRhgLRkPG9+tug6IlMMU+6ThXb4RO4mt8C
         F79OVn7aNMInBzhDphe80BoPcczxSeFNmS0vIYECVC54N5IkQDf5+OoMreOf2BIY2lQ6
         jkc50l6SMbwcjX+Sum6S7PCyJA+09LKTLwOUtPIp/33zMEW6crSYZgLLMa3pGKKIUGRr
         LsKv9rhoyy31fA9e9/SV+jj/SdZCtshbGoG98+QGirrS01jw7KWvOEhkxKWlC1B1oI/g
         JcFQYBRTvrP6x5My/V6l9kEm1TMt+3UztLp0IWQhFMy1nqoTThvp62rxn+jDa+selh8S
         U/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706639631; x=1707244431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdGWsc0oH3bWWgxR/5+ywKCOsUUjq3kFGwbUvLrZ40E=;
        b=AVsZyiy6mj/x8DnDJUh3Btiw4t9mQuAldyt0+o9BeAswHblFojCKgFgSun3ojq+Env
         DK07dTg1j/OOpY1EP2mLLdkIJxGhPHbRgVvGvPpiV7BFNFNcQjUznIsWu4e1k7oPCbVP
         Pc3r05pLFWqt5oUUxyWWMZ1hhSYH5rY0o7RvMcvyM7pRljLguZWmOJc+7GW9QjFnHSDN
         YjwLAAO8vQddDwW6HwTz+qbVNUbHBgLmT5Vvt/gAw8z1g5EPKUpmzf5RYzX6Fse7ssKF
         cK79XVyNZHa83Ol5GfSTtqFHXnHT6YTTTGUdOOtwoqPfmO8DKByLT8BSFDu4IfSp9zvQ
         HBAw==
X-Gm-Message-State: AOJu0YzEYE9+wgOssIDGcChz1lCz7tdEV6ZrfAlhtdscUYIAPZNgBtKL
	QoWCabHC2OtmBep9ZsQRIDuVeacjcyqdhKyUMdhS0XmdrtA4LbqrECXdYRvaRHKNvun2diYkwDb
	N+oMaKyL0ELdOrjDMGr9I4rnzfc/SgTMohZdj
X-Google-Smtp-Source: AGHT+IH0JnOwUNezNYdu4ljeiaqCHb1sKUhLBrQ2scptHLSnMIcNrZY0sfa0isfpckBxUC/zPaZay20bdb3kAZQTrH0=
X-Received: by 2002:a05:6402:1d96:b0:55f:5229:5e34 with SMTP id
 dk22-20020a0564021d9600b0055f52295e34mr124078edb.5.1706639631088; Tue, 30 Jan
 2024 10:33:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129190518.585134-1-edumazet@google.com>
In-Reply-To: <20240129190518.585134-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 30 Jan 2024 19:33:38 +0100
Message-ID: <CANn89iL6jEVPf3=zoxZSqME6gqRPttat_bZb7yYnRYYPLUcpQw@mail.gmail.com>
Subject: Re: [PATCH net] af_unix: fix lockdep positive in sk_diag_dump_icons()
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 8:05=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> syzbot reported a lockdep splat [1].
>
> Blamed commit hinted about the possible lockdep
> violation, and code used unix_state_lock_nested()
> in an attempt to silence lockdep.
>
> It is not sufficient, because unix_state_lock_nested()
> is already used from unix_state_double_lock().
>
> We need to use a separate subclass.
>
> This patch adds a distinct enumeration to make things
> more explicit.
>
> Also use swap() in unix_state_double_lock() as a clean up.
>
>

...

> +#define unix_state_lock(s)     spin_lock(&unix_sk(s)->lock)
> +#define unix_state_unlock(s)   spin_unlock(&unix_sk(s)->lock)
> +enum unix_socket_lock_class {
> +       U_LOCK_NORMAL,
> +       U_LOCK_SECOND,  /* for double locking, see unix_state_double_lock=
(). */
> +       U_LOCK_DIAG, /* used while dumping icons, see sk_diag_dump_icons(=
). */
> +};
> +
> +static void unix_state_lock_nested(struct sock *sk,
> +                                  enum unix_socket_lock_class subclass)

I will add an inline keyword in v2. Not sure why I did not see the
compiler warning.

> +{
> +       spin_lock_nested(&unix_sk(sk)->lock, subclass);
> +}
> +
>  #define peer_wait peer_wq.wait
>

