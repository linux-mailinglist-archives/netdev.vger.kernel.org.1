Return-Path: <netdev+bounces-214409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2620B294DB
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 21:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713AC1964079
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 19:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE1A1FE444;
	Sun, 17 Aug 2025 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZzYhwcz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D1E219EB;
	Sun, 17 Aug 2025 19:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755458268; cv=none; b=eARq5BeSz3sVWVROEd9W5toiXvQ0brWIY9S1DTFmpL0eLotoTbvPWqJibjKpnbu9aK8QOfXGsTGCU71QvYQDbDWkVcpxtXxTOO/nRIVanyySxbD+dp8+1hR38et9MYEzq8JwaTXqgiRf7oG200vAeIrQ0HMY9Ea8klBP6LmaToo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755458268; c=relaxed/simple;
	bh=pQmh+/rMC3Khd+GFeS6kXLNZhR3ipIoRR2wz218fZes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlF+CjIxvvxA4tXnkFFwgevSH6dZSCTM7EeO7Sjkc9+8Vzn9dkUo47+FRdhwIV3dKUBj897iV0mOBlLSjTqhNQZJGHWWjIY4zpFxv9Q7RGDVUQK2Baw+WQAktXVky74QWzIBtVD48YQlGaBmwo5IaFvqoMEnFkHbTxUc4UNCQDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZzYhwcz; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b109bd3f80so6457371cf.2;
        Sun, 17 Aug 2025 12:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755458266; x=1756063066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1oewm8//5zzqMzQPl1PxnhJclJc22to6grfT2wZ7V0=;
        b=GZzYhwcz4EvifjKzbrH886O7GgXnTRLpONeLCZPoip1lfQOxqNs6VtjfLcOwgJ5nYM
         1Pt+umUueo7vOQ/vZFS6LYenXbFzON5ODtyr4IQo+eRXyqCv2+tMrqBKoToVtYMRRAS6
         dKqG4YjZ9hDP/aoY7BeMOHnkgyPjfWHRpcYFbvFeWAYvehBcxlHJ5t07bR/ubmii2XxR
         q0XbTeMI+wTyQfnl/d/FcKVsd1mNT2IisvZ7EiZK57wscAzgcQCy5elR2EjN4D7TlY2v
         UvNICJr3y6CTvUuMMQfITdyZjZsfyvkEuZ+JB/TDrw4is8F9QO3KtINDqQuxWCuB0n9c
         PDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755458266; x=1756063066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1oewm8//5zzqMzQPl1PxnhJclJc22to6grfT2wZ7V0=;
        b=So/fhxWTfN9FkmPKU1mYMxgAZMIm8zGxSd9JXMGzywuoVWiNr3ITLJ6phpN89HoEmo
         qw9WMDYcuDlRS1LnGQ0YerPltzbGFeCXW40PwFjJrU/8mO3MjC9ZU/0x1nIC5YRVCoh6
         ypB3E8bhmHAKONXTWBNeGjAgRl5nDfEb/JqJog+Gw75sjA8oqWBw+E0lZwUtAMdXxLpr
         lK0J/Ks1+KlZ2ttdi4Dwr8h2FkL/azMdPBRSh0vnP7q+Nhk2w8QG1YVLXkZU289eMDNy
         uqmshcfiRm1IEucuxOM35wwSd67pUYgelz27RTg0DBUy5xx0UNOFmTQM1YHx6LKoFoQP
         YTVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM8CmOpEr3jTtCYCJOpqYgDG3Gz7/4FPD54SBoEbaIRT+xMlWsz6y5iGANokj7E28/mKNAKNr4@vger.kernel.org, AJvYcCWy05vOJnurP4P9Ta/uLbcTllS2nMo0Z/RW0AfV+SmVGjyR8y1X0Jere+01MuR5TN2D9ksrQwVauaNmdX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv6GBbSQV4zV6B03LlXK7O74WUgPwrRA9MnKsmMFqjr4PaoUtB
	dDbyDOY0j8AMa6iIBzNNgJwqnEhbi93KgczJUlEnNxEKYUZQK5DEHCNCVQITUAOJ+NbXqjtbCp+
	hZ/FsWuOLX4ycADgnmyA/JPQ+4prJjp0=
X-Gm-Gg: ASbGnctDZu+0iZHcnK4PKwPanDejzzXD8MDh+p+KdkAqI7IJJT19T4EvMb0f5XXWkwK
	q1fBjQbtHpfIceZQr6ABdqxmNXkmDfZ9HEJpkYqLuX9YT/Ka+2o8UoAKg1GEbDLBHBi3cWUM3V7
	C6m7wTosP9Wyk1XK0g7gMSSBmoR9rWbSnWiKxZdGXpI9r/Lu/yL+03FDrLkV6Q0qCNcVoec1vCu
	93NcA==
X-Google-Smtp-Source: AGHT+IF5Wjtv/qBVOACz2IQw2CXgLu1+h7c6wqUmWZhjl+mnd3gpUk4Y0JWwOnj24qvzHdOxH2nE0wFcqLN7OlqwAag=
X-Received: by 2002:ac8:59d2:0:b0:4a9:7fc9:d20d with SMTP id
 d75a77b69052e-4b11e127d10mr62965111cf.5.1755458266123; Sun, 17 Aug 2025
 12:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814193217.819835-1-miguelgarciaroman8@gmail.com> <aKHrttHa0W1RfZjB@secunet.com>
In-Reply-To: <aKHrttHa0W1RfZjB@secunet.com>
From: =?UTF-8?B?TWlndWVsIEdhcmPDrWEgUm9tw6Fu?= <miguelgarciaroman8@gmail.com>
Date: Sun, 17 Aug 2025 21:17:35 +0200
X-Gm-Features: Ac12FXyVutdXTJcwJlOf5NXD2jbTnjKyPa8rc-hXwfNQUvbsfJF4W10cZ4xXJeU
Message-ID: <CABKbRoLQQw_E0zFg5nxXwncf1EYA931_L7DUEc4TWvPjBc4j0Q@mail.gmail.com>
Subject: Re: [PATCH net-next] xfrm: xfrm_user: use strscpy() for alg_name
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El dom, 17 ago 2025 a las 16:48, Steffen Klassert
(<steffen.klassert@secunet.com>) escribi=C3=B3:
>
> On Thu, Aug 14, 2025 at 09:32:17PM +0200, Miguel Garc=C3=ADa wrote:
> > Replace the strcpy() calls that copy the canonical algorithm name into
> > alg_name with strscpy() to avoid potential overflows and guarantee NULL
> > termination.
> >
> > Destination is alg_name in xfrm_algo/xfrm_algo_auth/xfrm_algo_aead
> > (size CRYPTO_MAX_ALG_NAME).
> >
> > Tested in QEMU (BusyBox/Alpine rootfs):
> >  - Added ESP AEAD (rfc4106(gcm(aes))) and classic ESP (sha256 + cbc(aes=
))
> >  - Verified canonical names via ip -d xfrm state
> >  - Checked IPComp negative (unknown algo) and deflate path
> >
> > Signed-off-by: Miguel Garc=C3=ADa <miguelgarciaroman8@gmail.com>
>
> Patch applied, thanks!
Perfect, thanks!

