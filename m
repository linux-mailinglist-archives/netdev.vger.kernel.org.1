Return-Path: <netdev+bounces-85627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B326389BAD0
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 10:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1AF282247
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 08:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512283AC01;
	Mon,  8 Apr 2024 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SlTKG20M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B63939FDD
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566053; cv=none; b=KAWOpg+e5gm/s+T2Mw1B+M1++pG/Mnt23Di0L21aPIZRGQDSkd4lhxzjighFbVR0lchRpgTKJvZ+xGhyiTCP5Ae6fVwQYuIGeov7k+FkIC8lTne1o0HX9aWebsw6ZAApjbp32qpqaFcRPVCCTwGI6rZ+ldx0QLFj03otjQqGdAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566053; c=relaxed/simple;
	bh=QzcxQPI3IyP/jUjuwQ0bVrXwj/ZU/uIBvO/P66ZK9IY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VODAeOsTj7ZFZ5ZwWRDK5EeKToLPIWxMa3sLxaCnDju67ucCqLcRqE98MguGeFJACs9h4lcVD/dC2Gd0GPFGgR2RE5KcROM+ilk6G8f2+Jta6EC/yAw0t3fFFqfWTuZiRmfSS/iC7xpye2h6/1bdw8/3+67U4oT/omPRehi+Oug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SlTKG20M; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4154d38ce9dso102095e9.0
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 01:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712566049; x=1713170849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzcxQPI3IyP/jUjuwQ0bVrXwj/ZU/uIBvO/P66ZK9IY=;
        b=SlTKG20MmRipn3yEruDhbdhy1n/3GByixoWO09RhWkfRazZJ2fPKPSvuX2UA0ZRVm8
         SqlCdMrAnaNpZMcPqADxpA8dUHMyd/bsJpy9Lq9z586T0B3g+xYfj6iuUyj0XqsASTO3
         3kt3BGzdTpSXqDuB1kMaixXkl19wxk6qWmGoO+i/qRS5zvNHUcdeXA2hONs35VDceNtn
         VubifBcL7nC0fwpRPFuu148hQsY96uK2Ya79bbylLqsotLcIdT4Mgs+Sx5j5RsJsGKoS
         nAxSGd0yd+kmFimwGqhHMqqrPHqpwN2VqEzbZ4DbpYy/jVnadeuqM5yQLeXaNJA9qdzf
         a4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712566049; x=1713170849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzcxQPI3IyP/jUjuwQ0bVrXwj/ZU/uIBvO/P66ZK9IY=;
        b=uPt+mRDGMiUsuMjCwiYCb9Pc6XGNKT4Zd9My6douxt54jH5DWzE5pjnMSjPTKOnWv3
         tn/pjL8n3fLusNzdwRPfJ15xBYedokXNV9s7TmWf5wzskXEAlrOQgdFuWAFDdMrmDHmR
         KtMxXPxQtr1SJt0vFd4GPcvC8qDhmm7DOcEsQXY/TC/3bIhuMBADAe7LUH5Y/qPOye5h
         VdexYgbAOlhhgtYE+be7fpkn6XXdYttsABOG3VP7BIifPwOsy64R4kVfyReKo9hniBfX
         2hj2CWM613L3U4gi8PqL79gOzvb3z6hZrxMiWJ3OwYFaFbvNv8PmcFyZRQjbjhrih+W2
         wwFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAI8xhV0mMMGQNSuu9sB3OlSVr31+Sca+n8j6WR9KUblr8RId7j1t6yTOVrKj+vFyfhhAuUwbN73EATbD0/GdMUQn+zGTG
X-Gm-Message-State: AOJu0YzLR4LxqCiidrdPgThC8fxfw1zveG0EPaPfrsmNGF5CqtrPlz1O
	/OlilXP9lu0izDHkFhIUp4NlIVnxT+psLaooGxJCFUpyfqtASBgWRR5tbWvKiM2xr2/l75EAae7
	wqCcuRIwI20W7dAAOkVWeEjW0K5KqVdmeOXAQ
X-Google-Smtp-Source: AGHT+IGBU3W5b6Bbf2trBZ0RVAaeYUlTSMt5FGnz2wT1laELbiUMJrvAcX+Wn64szbd4/ezZ2w6YZ6LqT0zMbPg+TJU=
X-Received: by 2002:a05:600c:1f88:b0:415:4436:2a12 with SMTP id
 je8-20020a05600c1f8800b0041544362a12mr274354wmb.3.1712566049128; Mon, 08 Apr
 2024 01:47:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408074219.3030256-1-arnd@kernel.org> <20240408074219.3030256-2-arnd@kernel.org>
In-Reply-To: <20240408074219.3030256-2-arnd@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Apr 2024 10:47:15 +0200
Message-ID: <CANn89iJnBYSOU4QroWPNoo2eTt8R_2MtHJ+thWm-oz01O7TgKg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ipv4/route: avoid unused-but-set-variable warning
To: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Kunwu Chan <chentao@kylinos.cn>, Zhengchao Shao <shaozhengchao@huawei.com>, 
	Sriram Yagnaraman <sriram.yagnaraman@est.tech>, Maxime Bizon <mbizon@freebox.fr>, 
	Joel Granados <joel.granados@gmail.com>, Kyle Zeng <zengyhkyle@gmail.com>, 
	Beniamino Galvani <b.galvani@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 9:42=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The log_martians variable is only used in an #ifdef, causing a 'make W=3D=
1'
> warning with gcc:
>
> net/ipv4/route.c: In function 'ip_rt_send_redirect':
> net/ipv4/route.c:880:13: error: variable 'log_martians' set but not used =
[-Werror=3Dunused-but-set-variable]
>
> Change the #ifdef to an equivalent IS_ENABLED() to let the compiler
> see where the variable is used.
>
> Fixes: 30038fc61adf ("net: ip_rt_send_redirect() optimization")
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

A Fixes: tag like this seems overkill, I doubt W=3D1 was the norm for
old kernels...

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

