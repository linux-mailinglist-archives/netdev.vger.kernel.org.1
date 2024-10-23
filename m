Return-Path: <netdev+bounces-138305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 796419ACEBE
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 17:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB182878AE
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B6F1CCECB;
	Wed, 23 Oct 2024 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mw38prtW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0541CC170
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697211; cv=none; b=BLjr9CeRdsPr6nzYDFzaOsD3p+CyrAn6CGw190H/fI6MIRb2F2Aa7co+zj5/wzpX5lZIYzgcMkmEGk5sLBsLhEi57heeP8uIeBekYCNv5SoG18cEBX1ciixsOl/2HpTcwBov4/ew6UfJheks8vRFSzipYLKp0cJyxBP82nHZdq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697211; c=relaxed/simple;
	bh=sdZiAGgb2N7x2+murESX9guviu/M88FNek3Ch11R+30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejkhHl39FYhuz0VsYEcLhad+f/Rc/Pi3GR6wq0acESHdD0P43XEcxwQQDXi1zTgMW9eNTS8K4JO3Be6yVcX1/w4w1qZwpPc5KLl8y45IqNh8jD0mMfIzoeAFy4Q01DMfkcIg/gJdINS6uXrAt0knODunP9dZEU4d/8m3pzs/y5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mw38prtW; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c962c3e97dso8366590a12.0
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729697208; x=1730302008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdZiAGgb2N7x2+murESX9guviu/M88FNek3Ch11R+30=;
        b=Mw38prtWN7hxyXbBTQO8w6zfYKuiQErvAER3aiknM2pE6tpFZmyk1pZIshGTjsDkSq
         fcLqIe4q0vRqI1Q5PVuPGVu56NcTaVioeM+ZU8178b2WxaSHMZM0NrE5IplrVR3zC2ji
         Tzx0bW2KaxHGer1nhhlIz1xW3v92h9ahSjbh5yGQYDC9HBWbF98GbGwGG9s1sbdScUpy
         E4dHAdWYhFItKHJTMHZbHYnoiPM4t212BEV6g2j1/iAWLJczFqwlKylki7CCMyfNSXoq
         MvtQUJF4A3cmdREK/VfTaIF5J8vUsrYbdVWL8xPPAKkeLMYUoyeyppCiMjyTl3aKiqQo
         6XuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729697208; x=1730302008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdZiAGgb2N7x2+murESX9guviu/M88FNek3Ch11R+30=;
        b=fYqp0/mTsRizngcQ8i5Wz5klfAOfIbn8bCP+00rGkaYz8Inrb/x5HwvVQUViVPTlaz
         EwpRi0ToK0MJPx4eyehvgblFNwZJg3rqPeS7BXafTFOkNqHbJ1HycTlvqR07up9chAch
         0tGAAR1MhufbkqZbXwmvf/UzFOikxWAMdvBfJjHiidjFqDWTbLOIxyy+LXZQIrSzrfFF
         BgRNrcI3z1asx6E3TC48sc8EhpnvjHcsqdaxTI3uzg4erZpZyhuXZBz/tfB/cpzEI9hS
         fvLDZ/YCCITwgAekyctz/ndyD3W7xHbq6W0cLCdQHp/zI0gqsxZ3LB8pMpHTMLd1xE0M
         e3jw==
X-Forwarded-Encrypted: i=1; AJvYcCVC5Ba2gQfm9dQabXlxkFC2y5AAh+jZf9VJiTbxykzoETBgj35S9i+xoEyjZkLiSGSWcaEtRX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVySUkqQybMYJlZ/xi3gEh0GXzDCiB3CQjheG20T02qp/4+eT+
	/puIRcOCki+/3v/+6rIRr3cTM/gpfxB3JoEGcJJ3OBQC5x4+RtQdVFIs4YTaAbkurA1ypebHmOS
	I0MpePTvrbkTG7DyUqFURhJVdQlT8SDhqBo9n
X-Google-Smtp-Source: AGHT+IEyqAhNLB/ldT9WXQiDYOs+P06Fnj3R421wz3co92KA4AFBqQCSq6a9K3TLERdDIvKrBl9GiTj9OdzTmdX5j2Q=
X-Received: by 2002:a17:907:3fa0:b0:a9a:2a55:d130 with SMTP id
 a640c23a62f3a-a9abf9ab909mr303523466b.55.1729697207910; Wed, 23 Oct 2024
 08:26:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017183140.43028-1-kuniyu@amazon.com> <20241017183140.43028-4-kuniyu@amazon.com>
In-Reply-To: <20241017183140.43028-4-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Oct 2024 17:26:36 +0200
Message-ID: <CANn89iLyzO3d169JJ2ACDTnr_+XQBLsE-VSCDyDKZ4bXraLozw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 3/9] phonet: Convert phonet_device_list.lock
 to spinlock_t.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Remi Denis-Courmont <courmisch@gmail.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 8:32=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> addr_doit() calls phonet_address_add() or phonet_address_del()
> for RTM_NEWADDR or RTM_DELADDR, respectively.
>
> Both functions only touch phonet_device_list(dev_net(dev)),
> which is currently protected by RTNL and its dedicated mutex,
> phonet_device_list.lock.
>
> We will convert addr_doit() to RCU and cannot use mutex inside RCU.
>
> Let's convert the mutex to spinlock_t.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

