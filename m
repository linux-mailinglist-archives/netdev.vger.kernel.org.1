Return-Path: <netdev+bounces-169867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E772A46102
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 14:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B902D189B18B
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 13:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BB918B492;
	Wed, 26 Feb 2025 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uJPKbnUL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A8B1624C3
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576894; cv=none; b=R80/Pogx6MEwDc7rjieEqScMmLSXxwCAjOneeD+ThgzSAfd9REQkU2KEipfA2HADi7fa+8LdzS/AIQYcP485FdYKgzfO26MlnYF4Cs5waa1oqVOGBIU5+kvIOSJjk9GFiHF6uzZnD6Vh+CpxbH1obJrxiwd2y6MjFxVgKGHJ9/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576894; c=relaxed/simple;
	bh=DIzYRqRFyYOa53u6xfU8L6+PRUgNNVXsQx7isekoETU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/gPWF9TWCljMpSHgENdWgkWCIubW9ATxTBN2T7hQzQlI56GyxtH1lkhVvz5l3QlB+oyZ2eXAKS804KV3K+rlAa1Abqg1mgDMgQvBTjOH7zUBu/D6kf99YXIzOt7wLNqsitilEJbJNn6LUAFX0up3cgS+rTvs/0zabXx2g0Xbrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uJPKbnUL; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so12161829a12.1
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 05:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740576891; x=1741181691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIzYRqRFyYOa53u6xfU8L6+PRUgNNVXsQx7isekoETU=;
        b=uJPKbnULGR2vCJntS9rFs+3+kmYIjSgKv4TTFkRg3JVjbFmbBx3hXzxQlliVjDijow
         LXI7NeWmTu0Vl0hkQAlJHhXlUTAMhumBjav6rU6n8qblWYAAFB8ZwOdUnvIg4wS+3Xl2
         TR9j7J7lYuaVdUAemz2xo73r7A+LF5gZQCYp6a4N3igq1vP3h/FnJUAN0gE/UYe1qwD+
         fnOcc9PLELKt59sLgsSudDEcpCtffMKGBWVmUgtDc6fYA91o7s0cK6lnEID7lMk9yr/8
         Ol/Du+E1L2iEbsxJz6aZn0CveiUhB3pLBBnd9KHGpbbYRz/AtP6A1aH4HtIkWizNgzRv
         IacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740576891; x=1741181691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIzYRqRFyYOa53u6xfU8L6+PRUgNNVXsQx7isekoETU=;
        b=vDdmihKgPn+5jc7HdLZaCj2+noKmDi/M8yZJxKl/NjFlSTDkzLOQaycsgdE79sdPb9
         neWzvB8eLOFgMQifXXkJPYfnbdEjTWSVAF4B/6X0f+XOXviaa5YlvOOSy1UI9E4iMgmB
         /NIUW6TFbfn/6glvUBYiJXo7Efa5zaiZSh2TJ827UlWDSeaJKzZdnJ5hb10DzlGocMNa
         pk8EOtgxiQREdxSxvQMNaO+gVbZBs5ggNu7sIOsnXbVF+e10cW/U8KdyQzPR0FbFEuKT
         Mjv+sMUvewId+ClQKt6IzPHe6SNASX0SdakqCME4ONOmsC4yuqXmq5h5Kc53bwKdUw15
         4Qfw==
X-Forwarded-Encrypted: i=1; AJvYcCXqxc6HwT6WbFE3Y3GQQSuV9l1r41g3q3oGzW3eqIix7SfPYCHEANlNn9mn3etKnWZUrfmbf34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywj28oTFjgHDeu8Iv7d0td1KmkCbTr7mZxIQpM5wm/4DZFRJLO
	wxbyXdmttWXxo6RM6kTpE/APKhKGEMlXUGT4Bm8+pFnMI99HhfmoHoPDEBN5n/vtn0Vg7Fss8ne
	yLsYssIKp1mLenuY2Pms75yZ114xHD2r+zUFpucEboQaKm0u9M536
X-Gm-Gg: ASbGncvhWYohdL4V9e9SoihUjGGbB0jAvL/cbRHXylcwnUwo9QMGVuYp8b2PwawxnUR
	4kuSfszadCpwpSLpQxTAHs9pDPNSgbtvvPTjUKlf9NjT2rJAUhhUM4pGlOSPRPbJB5Wmj/AWkyO
	eTwvZpbGs=
X-Google-Smtp-Source: AGHT+IGW6oMB/55DkXWA0LLasiWq5S5+A9NXO3XUybwbuwmJAv6UNSnhAEHmQHk8wdhRjs//iRBVdydqkyBots+Z1vQ=
X-Received: by 2002:a05:6402:1ece:b0:5e0:3447:f6b7 with SMTP id
 4fb4d7f45d1cf-5e4455c2e30mr7504271a12.8.1740576890809; Wed, 26 Feb 2025
 05:34:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223221708.27130-1-frederic@kernel.org> <CANn89iLgyPFY_u_CHozzk69dF3RQLrUVdLrf0NHj5+peXo2Yuw@mail.gmail.com>
 <Z78VaPGU3dzKdvl1@localhost.localdomain>
In-Reply-To: <Z78VaPGU3dzKdvl1@localhost.localdomain>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Feb 2025 14:34:39 +0100
X-Gm-Features: AQ5f1JrFcA4Lv4LOIeGP9ZDQ3eWx1CPhGwwMoKSGSc7bhZoOJr-kdVosyBIItuo
Message-ID: <CANn89i+3+y1br8V4BP5Gq58_1Z-guYQotOKAr9N1k519PLE7rA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: Handle napi_schedule() calls from non-interrupt
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Francois Romieu <romieu@fr.zoreil.com>, Paul Menzel <pmenzel@molgen.mpg.de>, 
	Joe Damato <jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 2:21=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>

> That looks good and looks like what I did initially:
>
> https://lore.kernel.org/lkml/20250212174329.53793-2-frederic@kernel.org/
>
> Do you prefer me doing it over DEBUG_NET_WARN_ON_ONCE() or with lockdep
> like in the link?

To be clear, I have not tried this thing yet.

Perhaps let your patch as is (for stable backports), and put the debug
stuff only after some tests, in net-next.

It is very possible that napi_schedule() in the problematic cases were
not on a fast path anyway.

Reviewed-by: Eric Dumazet <edumazet@google.com>

