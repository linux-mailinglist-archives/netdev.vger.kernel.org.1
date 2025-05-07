Return-Path: <netdev+bounces-188717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD3DAAE5A3
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 17:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819E718883DC
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6657828C02B;
	Wed,  7 May 2025 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdwszruL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B160F28BAB4
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746633285; cv=none; b=X69SPn+eoExAXW35FYSQz6NrVekc4JsZJzW6LPrRagiZhH82JDHXxWAAiIYyXSVoCk+Ypg91FvShzP1zUJ9RwZ4xKSQtlrbUOrnLk6c1U+Oi7WJ1S7JPBHw9Yw/JXQc4yPNzAedLeP1uoDgCoxBCoOf4QV4u47vtseuBPgLqyCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746633285; c=relaxed/simple;
	bh=ZTmRocbIlgidCiB8qAhF5u3HCmGNgSbVOzCnAG6cxyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSMErfix7a0KOWPrZJrS5qcYVa/3DOe3uMKnUlNy7WJ4BLttTrDpHgiexS57oY2WqczCIKsfaSVfW9oxRqi8JVHoUKfWrx9H1WUFCF/q4ejjiwbp0g4yTgiV6GspzOcNua/B9SuT1qm2JVxnT8ukSxEOcYuh0nXPpLg23BMWGlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdwszruL; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5fbee929e56so2002797a12.0
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 08:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746633282; x=1747238082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6HVL9BX+MplgPxa8q0GRBwUe8Z4JNQg8ytJJS9YZi4=;
        b=GdwszruLRUxd3cxD8ve7Gr43f0W/5fzo7M4OicdCCLyvJiwR0EfoZW4o1/oMjp+sBL
         7DRBmlWQcpzf3c0g3VtbiAvYcblcF0Byi3His842XDVUnF4DGenFe9rcUJNjsyv6xONE
         gJNVM6T2cMZ8mUFBMuikuj+Ie1rbnPsv7D+Qlt2trz8Jac6K8z6noyeQZdJymGiYPb0A
         Fy81FD+PZT2PrNC0XuHFxW8VIM1U+XDb7PDsvE97U25Xf6z2P2+sOY88EyO/OxnYB9bk
         92EAhbRNShO4dbNedaXZVbQBI2TJZlvOit94XVlah8+8OuhOcHNukRp7eThp1OKTtfUc
         3dPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746633282; x=1747238082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6HVL9BX+MplgPxa8q0GRBwUe8Z4JNQg8ytJJS9YZi4=;
        b=VHVt0BShts/U62TALT/9qbOYRj++/xTnsHlhwJjXw1PSzXePU3Gmz0ppKguU+Z+4aA
         NF/AeJH2oYYjFV8iY5H6KbXJxKaZrdUymJYZ+AkjHCvuILfEbcCZSseAZN6A23BTDM+p
         oorRma89mNiniCTih4EH5vuUjr90l4AuHekE7Yy0N+WYtJapLuXA57Yw3jGkfST1LP1P
         66tmp0j+A6WQtxkRj2CUJgZQHeI1ZJBAKCYsfcJnLj3Jw7/Rk375JYp1gNx6sLW+G8Ru
         FzWYaMb0XvSJBw8FxDl1hx7J7YRs+XmqiPYJ4eSbuzdIYbeMmnONMM20DcrXzTyZhEls
         k4uw==
X-Forwarded-Encrypted: i=1; AJvYcCVm/iPi+CHg44xoPfgyMyPU1AzI4K4M7PC/o4P5Ld1Pbac8YeHnBfzBAV2ue9srGPDBVAbx3cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZwjyvKkG3JoBikXzYhAXWyA7mRjoksOkdsg1CcE7SvTfDgwWF
	Bd/wvHwzkpcwRnhVWaPrcZMyJlP2KHMfGSb8F3sGXURuKBo2Y32rPOlwfg7xxuBZy8Z0Vz7bdEg
	jLzqDqwzHQlRUX0mRj8pwk7aUku4=
X-Gm-Gg: ASbGncvmKKS0VAMWNfg7RpuXrmqMzgLvJGmOl1w7G1QpE8IH9ck/FsWDj16O85iCH5r
	gVDyrx//EarVw9RYiJ1qYGtxLfU90rF2hWAa5kRAu08CrZfAnVxPPRVVJknfcuBu9fBKhuwAMjB
	Fv/C1fEr5/OrWPXSPii984awyWpn30ADU9AQ==
X-Google-Smtp-Source: AGHT+IGl8VIgo/rRLJkE1yiyZm2FLFgx6Y1+8OGwrDDf7ItJ/KRqA1QFBb08quZbIyylqSLrwp2XEObYZK7ahUPgfpI=
X-Received: by 2002:a05:6402:26d2:b0:5fa:fcda:bf57 with SMTP id
 4fb4d7f45d1cf-5fbe9e53b69mr3431797a12.17.1746633281702; Wed, 07 May 2025
 08:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506140858.2660441-1-ap420073@gmail.com> <20250506195526.2ab7c15b@kernel.org>
 <CAMArcTUx5cK2kh2M8BirtQRG5Qt+ArwZ_a=xwi_bTHyKJ7E+og@mail.gmail.com> <20250507062321.4acdf9e6@kernel.org>
In-Reply-To: <20250507062321.4acdf9e6@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 8 May 2025 00:54:30 +0900
X-Gm-Features: ATxdqUFjUKfefZ3y4ZtxFZK7swtA06XlsLH_JyBVmPclqvxrtHB9WG08ksK2Fjo
Message-ID: <CAMArcTW4-4=4XR+KshpPqVKXgTRNmXdwATrij9gAgYKrpOcOTw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: devmem: fix kernel panic when socket close
 after module unload
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, almasrymina@google.com, 
	sdf@fomichev.me, netdev@vger.kernel.org, asml.silence@gmail.com, 
	dw@davidwei.uk, skhawaja@google.com, willemb@google.com, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 10:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 7 May 2025 13:55:44 +0900 Taehee Yoo wrote:
> > So, it acquires a socket lock only for setting binding->dev to NULL,
> > right?
>
> Yes.
>
> BTW one more tiny nit pick:
>
>                 net_devmem_unbind_dmabuf(binding);
> +               mutex_unlock(&priv->lock);       << unlock
>                 netdev_unlock(dev);
> +               netdev_put(dev, &dev_tracker);
> +               mutex_lock(&priv->lock);         << re-lock
>
> The two marked ops are unnecessary. We only have to acquire the locks
> in order. Its perfectly fine to release netdev_unlock() and keep holding
> the socket lock.

Wow, I didn't know that.
As my knowledge is only ABBA is correct, and I've never thought about
whether ABAB is possible or not.
I will change it.

Thank you so much!
Taehee Yoo

