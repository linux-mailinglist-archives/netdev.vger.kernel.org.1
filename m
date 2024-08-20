Return-Path: <netdev+bounces-120056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8724958203
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 11:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37981C240A7
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 09:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEB118B468;
	Tue, 20 Aug 2024 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xh02ydBV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDCF18A6C6
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145803; cv=none; b=WQZoP0uxi2HZ3maLDD+dgDrinOTxz/CLSEWDh87x57yBu9j9TXZS7U03DqWrSni8Np1YG85ZEqtdjP/1jpobtS2x0hI3bfYlyGyhuqNoIvu2uyTmiGp7+lRdaMom7vBn7gNYSocS4OOuPV5Z1FP6wB3E8/VBv55wNUTh4FI5ttg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145803; c=relaxed/simple;
	bh=WTK4GJtOEVJl3seAV6d04PdoGeLaK3tCiKuWtnZNVsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4zU2EL6nBIrYTQIAFnkl4cRWvQz1IG8UFAXHiPVppUUqLzp/K7a5Atu6gdoVyu34iA69Fv2bF1o4lZsuH8Kk0PbIvYK2Cc9TGp5UuHmLy3Dq7At643X66b6zQf2p963Z52jU3/Q761FNOMyLew1MKcn4qu79jFriPr72gCLRTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xh02ydBV; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-81f96eaa02aso285623139f.2
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 02:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724145801; x=1724750601; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WTK4GJtOEVJl3seAV6d04PdoGeLaK3tCiKuWtnZNVsQ=;
        b=Xh02ydBV6a+dteJWVF/tSFVeexPbrrLaVzw0PyIwpU61znUL5JFcPI6+51D/9fdFU9
         OiLWe1tytVXr7zla+Hj1cbSWWf1GkaE9Rl59LhOzI9SsghcFolD4t5mI+z4Jhh+d2XmI
         jjhUeSd6FdHt70yROCs17NUETDarN8IKzE666Y/NojclCE+Eg8WgwmamhVlYRzlpp2rs
         /6b3lyyKHFTd1r6ch9pb5AOMYH8uNosnKMqNz/ZiBC0ZLGAn0htuOhmbuAhNf41JEYrB
         bvRkcRGpbR8uoEULYh36GNfzV7312ZvwTJjyoa5kIplnvRC/CYMQjYVIxLhxJQtJuT+O
         OwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724145801; x=1724750601;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTK4GJtOEVJl3seAV6d04PdoGeLaK3tCiKuWtnZNVsQ=;
        b=k4eSlt3ppCUtyWgOEqON42n0XiDgnY65dY8jOGbtLXy4qbGfTVVcWy23aJXXUg1lj3
         GLgOvq/v+gUWJFuFslkokZwyX7UFC967aAB6L7WIGH2a8xemQ/ZQeuwphy6CpncvmEE/
         qiFruITiKlFim2Ir7CQR8KSNZXSNZVeQGSy6AdU3kIsQJ8GHhRhHX0GQbGQJ8rq5+ccf
         C4q49Tigpml52QG7jB/eLWeQKhfaxd2KpQkHb4hdM167favho4Rs3d7ZK18rEPE92s5B
         ZA59WylSn8rgSZ9JQ634hiOfVVpl0H2k/tllJ51BZpY6sKzKyJKSSeFqMuJTGZCcaWRl
         cO3A==
X-Forwarded-Encrypted: i=1; AJvYcCUqwnPbncbPdjzlrSagdGd6iYQBokDYCz54GMCzcw2DeR+Ofud20u73wVPIYz0Z/bMz5YTNEiLxGJzoRPskqGxsXQkzi2E0
X-Gm-Message-State: AOJu0YwcorbXy6bBflMTXVYuZYSNEUvIeEWlSl8sRBi9pAnbjQsKlzuJ
	FhbJEq6ftlbW3Ob57XzLoUOM7SuK4H65d3aT3Hj22fyVOTBKfeM/Rk21AgHn02n+sDiTHCqbf0t
	Kk2BxXFZLKxz+Uq+uIoL9OF5IfBM=
X-Google-Smtp-Source: AGHT+IHiE/bDZ1UN85PB40I3cbKn8VeE9RenUH5dhxBskiAX/It2bk//QSEmdepvzSQpD3MWbnbjIotFhM5Vi/xWZUU=
X-Received: by 2002:a05:6e02:1689:b0:397:d9a9:8769 with SMTP id
 e9e14a558f8ab-39d26d6ef73mr148560885ab.24.1724145800925; Tue, 20 Aug 2024
 02:23:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoAJic7sWergDhVqAvLLu2tto+b7A8FU_pkwLhq=9qCE1w@mail.gmail.com>
 <20240820045319.4134-1-kuniyu@amazon.com>
In-Reply-To: <20240820045319.4134-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 20 Aug 2024 17:22:44 +0800
Message-ID: <CAL+tcoBO9Y1+aX6hrt5cG_2V2WOXNvEJ58G8pBw2Nt9+VV3pnA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: change source port selection at bind() time
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kernelxing@tencent.com, kuba@kernel.org, ncardwell@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello Kuniyuki,

[...]
> > To be more concise, I would like to state 3 points to see if they are valid:
> > (1) Extending the option for bind() is the last puzzle of using an
> > older algorithm for some users. Since we have one in connect(), how
> > about adding it in bind() to provide for the people favouring the
> > older algorithm.
>
> Why do they want to use bind() to pick a random port in the first place ?
>

I feel sorry to bother you again.

Interesting thing is that I just found some of my personal records
that show to me: a lot of applications start active connections using
bind() to find a proper port in Google :) I'm not the only one :p
Probably coming up with the new algo selecting odd/even ports is the
reason/compromise for the bind() and non-bind() users. It gave range/2
for active flow using bind().

That's what I want to share with you :) Hope it will waste you and
Eric precious time :)

In my opinion, whatever the result is, technical communication is
important which can help the community grow. No hard feelings :)

Thanks,
Jason

