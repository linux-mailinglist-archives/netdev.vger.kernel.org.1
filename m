Return-Path: <netdev+bounces-83777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEC98940C3
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 18:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1841F22684
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 16:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CCC38F84;
	Mon,  1 Apr 2024 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u29XHHbT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB7E1E525
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989245; cv=none; b=U/7p9FhSXY0l7dYJHZ9pIm03dDx7HrXgKXxJk1DhrUAu//+MzVS87oy7IjH7iRnHbYGKFF5JjPPqgrxuQfRSivVamEsARifgUK6+DKg8w8UBWLglu2iRxaiQXJMxs/dWZFVIZyP7i0uOw2gedU1Tyq8VyYTkyqbmGD6mkc9Z9ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989245; c=relaxed/simple;
	bh=IkGKi8KtrnpW/8di3TZEnullfPHFEvsBMv9pLk9mnz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aguL8pBhUPisxon367KnOjgNouvBguwf3EZS6y73c1dDndQaRQ5Gxw3a5kKk67PAfGSGBKkjzd9X5QFaE6EVFLOoffxQ6GkB7sG7yc1y7paBYL20kHWW0qdsboNEVKqYOdu9pIw3M7AnwD5ySK1PmYyMm0c2hBW0SdqF+ddkvd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u29XHHbT; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56c2cfdd728so30144a12.1
        for <netdev@vger.kernel.org>; Mon, 01 Apr 2024 09:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711989242; x=1712594042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkGKi8KtrnpW/8di3TZEnullfPHFEvsBMv9pLk9mnz8=;
        b=u29XHHbTeB6+yPPU/dQkFbeEjuoIbeUrankLlIWIqkaHTKlvVbjNTrarUeArTQEZY8
         MWuDc6rZNJDqpHQBeS++ius0FzGxG+q9wieZAbcAySIRMNSwBpUYRAF7xk6X8f3aY2tZ
         QhS0EUrCKYUIs4AELU1Wu0pCr6Dobr2BiHXDp0Limb+SHZiqDedf1jmmnr9TWf0d/g60
         OVXf5R2WaFhyAAP6Y7hZUR1YxSERGJopqaCQWgephv73SVUhkk9Eyc2pFXo91xrdT7Ng
         4si31P3X9B7PIGKSFIrKynz8UWIb9pD9bVx2jdByYdRMIv4LL2vHgWonVIBEKkbWZtCJ
         jNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711989242; x=1712594042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkGKi8KtrnpW/8di3TZEnullfPHFEvsBMv9pLk9mnz8=;
        b=QSzOxOvc0UT98hkH174y6dW5Wv/RmB5LLGehk9gfjeDccucXBlHOTWbwrhmyKCDLui
         AHFzWoH5wo8LzpQWJ75adUkGwafurLTBcJHv+ME51le5ET+Bz9WG1cYEAmi1JEVWJ4SZ
         vLuGLp0/+X7VxLh1FSCpZBXjixHhM4dZRI++AoKdqAhqQHT8rU0z3SqN1yzEJIgSKpTA
         Ee5Ktkm9/cfvHkl6JVxjSnLsn62H7CFk4xIZV5qEW/p73K7NRhLjuwjaQAx0pMsHpElV
         US8nKyolbLEVrAXeYIax58ujp1f4vVBtbvvEj0+PAkr3kxtyXeQm05rfIrbqDdZ+W7xJ
         2FSw==
X-Forwarded-Encrypted: i=1; AJvYcCXj1axyuOII5dCQlT0mebWb/nDDcwx0beMmR/ysLNn3ST0hvRBairUOvjYbXRdUiuI3nb3kmPgYcJslkZsVLD2osCNnSVHk
X-Gm-Message-State: AOJu0YwJ0vnOw+Sp4mBAI5JZgxJJcd2pjSwj306KwcLKZACNEIv2KjYL
	zSYsnX4aiLJ/jMLQqBt1UwvmGWxYBWiyVCSo0Q1dbyGAbKQu28r35TIZIqwebShjpriKwR4kKYV
	awTvRM0k8aeJLBW79ownwM153o7i3Rc8b9xYt
X-Google-Smtp-Source: AGHT+IEtnZqDFMgIoRf50wJe18d4l2MJNaB0mZX775VqIMdUcJyTB5Fn05+n73J0wVJUM0cjdyW0NH01APw3pEXvDy8=
X-Received: by 2002:a05:6402:35d1:b0:56c:63dc:c02b with SMTP id
 z17-20020a05640235d100b0056c63dcc02bmr495467edc.0.1711989242215; Mon, 01 Apr
 2024 09:34:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240331090521.71965-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240331090521.71965-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Apr 2024 18:33:48 +0200
Message-ID: <CANn89iJXZcsfDFTgwOptzSeutuC6w-v=m=EG9jr1U-U4tcos6g@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp/dccp: complete lockless accesses to sk->sk_max_ack_backlog
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2024 at 11:05=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Since commit 099ecf59f05b ("net: annotate lockless accesses to
> sk->sk_max_ack_backlog") decided to handle the sk_max_ack_backlog
> locklessly, there is one more function mostly called in TCP/DCCP
> cases. So this patch completes it:)
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

