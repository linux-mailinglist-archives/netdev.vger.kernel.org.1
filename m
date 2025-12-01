Return-Path: <netdev+bounces-242948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9DCC96B77
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 11:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10B3E4E123A
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 10:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BDC3043C7;
	Mon,  1 Dec 2025 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="en7fphsj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A725E3043B2
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 10:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764586156; cv=none; b=cJTJLv5wpLBjyBUNy1coffwdYQZJG5+/18RMpG0YTlLVJynn79cOluId7SDiGjG2Udiz6nyPMfTZASYdQy185luaM5NaRciWPMgA70wzxdYpHKjANGWkYnhGRo8lGVObakt+Nu1YjMA0T3SqXyd85yNCVMf4Qu8yKyiwIXW0/rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764586156; c=relaxed/simple;
	bh=TnpLZv/eAabP1iHpY+pfjsPQM6Sa6zGvz4Sh2TFf9ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fryPgXz3Bg01crf7UJ5jgt3/8SOsOZHfdlW9uTxUpOLLriYAhn+LY9Yko/w9j66Xk26rn5sKI2JqlQ22GwH4B8hqu4GpCqmRfc2HDwlgAXLVB/k2Qxib4zPrDoETLgeR4n88b9rYswHZju0kp6H2SZYY7asMNO+iXXCy6WrK7XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=en7fphsj; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4edf1be4434so26865381cf.1
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 02:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764586153; x=1765190953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yihN9u3dF1KUw0IDsBYumhdTC5gzkqr3jpKi5G7muSI=;
        b=en7fphsjBWonaEu34O3kNIFbzo6yshGNN0E3tYEwrAhUt00Xh7BNPguaBj4pvq815h
         erqr9Q/L/V18DBvy0/a28/ehD1vO2ZL2vG4UyrjUaJ3U6RBT8jN234sQqEDb/knz6+Zg
         dGezRnP2gbe8lmffOAfWwMgtv4j9FKdA85aMc2BFe4XCp67EIuS7i+swst/pvRrcK4o+
         XRqWv79RvGRObfU/J8I3hTC/uFp/VLEh2JIK+c1b52QYeAhoLSIvEgkDW0ggbYd9m8M/
         zwVffMX3nlJa4xkIxo7QHLEgg/IfNvqNDe1eergXtp3c07GEFFHaRqd0y5RIe993BQtE
         G9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764586153; x=1765190953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yihN9u3dF1KUw0IDsBYumhdTC5gzkqr3jpKi5G7muSI=;
        b=bA4QzpUp4tut6SOCyi79OI2i4QMFK/C/gOZQQrd15XBPeQjpYgqqU2rZ9hB1XTdqH/
         75X51OPCN95zRiroxEvPAKhT5wWzsXtFxOnbI7TxAce/5W4eW6RhXDl358lpnbZxyOqt
         pypAKWPy9KD1uJwbv7FKHOI/O8w1rzA4VHLr7kPag8WClc5Yuuy7Vrl9zPNhZm8OcJIt
         5HBAEw9b99SqNETWAOZdTuAiUxHvmsZqWLxqAtJ3n/BVcYOw47l9msaK6mC28NMVBCqK
         xqHgF/sTxeWByjhoq/X0a9s2C9Q7XOTHv2o3pXGQ7K009ArrBBgT5oFlP/5gbYisGyC6
         fjFg==
X-Forwarded-Encrypted: i=1; AJvYcCUOnKYFx+4KzVLmRy2Z75Mmo/jYjtJaKb0tBrYKAb0KB0J22eFq4E1AMyoeWBYs3RrSv3fhqQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqW8PQA2aTo70itZwWx+yjLzZX1Mkg+RWTWzy2NfBmmou/ctGS
	oz0k3AxG6UwwWErTE3wjH6lf29ZGImtNuC0x9nJRMqGvUEj6/6j/siJbAzB7neUSPxhOPx8YuTW
	UlplRHtolNbW5EuLoPXYD8FnncOZItUb1HMGwGwNV
X-Gm-Gg: ASbGnctt7rExb+GDRekjVdiNECP9kSfKEKQ1Ajd8tZdc5iS1v1SEut8SS/SW5bhV8Z4
	sZw3iYq16Tz5sAHOis0RE6jl/RZKWxs7sldkHF1YAxqCGJdYLcYKMYH3GSNSzHTkGvgyUP7CLNU
	ZFQu90J4aYAOF+FtZ/8kIv8w+IUllWT7fWy6EWavkMWpPAchycPqqoDySajHAQO6w75BcCi6mPy
	4OqUCUjLnuD4PjywfmlmZPxUT4qT33MwbyZCiQ3Oh61lhEhzz3SOD3uyXor6B/8uy277uI=
X-Google-Smtp-Source: AGHT+IGqTMyLMeV3gzlRJ5J3VL0WOmmtcnKrZXIoiJ1bzkojBYcF7sQxz7mTmbSH1hosg/jSy8ZcU8HAn5LKIhuoRgA=
X-Received: by 2002:a05:622a:13d0:b0:4ee:1bc7:9d7b with SMTP id
 d75a77b69052e-4efbdacff00mr346898301cf.39.1764586153287; Mon, 01 Dec 2025
 02:49:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201104526.2711505-1-evan.li@linux.alibaba.com>
In-Reply-To: <20251201104526.2711505-1-evan.li@linux.alibaba.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Dec 2025 02:49:02 -0800
X-Gm-Features: AWmQ_bl7MiduXAikfTXo_VS5voLFOvo9DSXqCWHzDH__vp1XXmfflcmqJSAFGEE
Message-ID: <CANn89i+E1kVsY4nZ1jZowEiPLxjRbdtR-eoEs1KGTaj_iDUFVw@mail.gmail.com>
Subject: Re: [PATCH] net: tcp: avoid division by zero in __tcp_select_window
To: Evan Li <evan.li@linux.alibaba.com>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kitta <kitta@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 2:45=E2=80=AFAM Evan Li <evan.li@linux.alibaba.com> =
wrote:
>
> We discovered a division-by-zero bug in __tcp_select_window() since
> commit ae155060247b ("mptcp: fix duplicate reset on fastclose").
>
> Under certain conditions during MPTCP fastclose, the mss value passed to
> __tcp_select_window can be zero. The existing logic attempts to perform
> rounddown(free_space, mss) without validating mss, leading to a division
> operation in the helper (via do_div() or inline assembly) that triggers a
> UBSAN overflow and kernel oops:
>
> UBSAN: division-overflow in net/ipv4/tcp_output.c:3333:13
> division by zero
> RIP: __tcp_select_window+0x58a/0x1240
> Call Trace:
>  __tcp_transmit_skb+0xca3/0x38b0
>  tcp_send_active_reset+0x422/0x7e0
>  mptcp_do_fastclose+0x158/0x1e0
>  ...
>
> The issue occurs when tcp_send_active_reset() is called on a subflow with
> an unset or zero mss, which can happen during fastclose teardown due to
> earlier state transitions.
>
> This patch adds a guard to return 0 immediately if mss =3D=3D 0, preventi=
ng
> the unsafe rounding operation. This is safe because a zero MSS implies
> invalid or uninitialized state, and returning zero window reflects that n=
o
> reliable data transmission can proceed.
>
> Fixes: ae155060247b ("mptcp: fix duplicate reset on fastclose")
> Reported-by: kitta <kitta@linux.alibaba.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220820
> Co-developed-by: kitta <kitta@linux.alibaba.com>
> Signed-off-by: Evan Li <evan.li@linux.alibaba.com>
> ---
>  net/ipv4/tcp_output.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index b94efb3050d2..e6d2851a0ae9 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -3329,9 +3329,11 @@ u32 __tcp_select_window(struct sock *sk)
>                  * We also don't do any window rounding when the free spa=
ce
>                  * is too small.
>                  */
> -               if (window <=3D free_space - mss || window > free_space)
> +               if (window <=3D free_space - mss || window > free_space) =
{
> +                       if (unlikely(mss =3D=3D 0))
> +                               return 0;  /* Prevent division by zero */
>                         window =3D rounddown(free_space, mss);
> -               else if (mss =3D=3D full_space &&
> +               } else if (mss =3D=3D full_space &&
>                          free_space > window + (full_space >> 1))
>                         window =3D free_space;
>         }

I think you are missing a fix in MPTCP.

commit f07f4ea53e22429c84b20832fa098b5ecc0d4e35
Author: Kuniyuki Iwashima <kuniyu@google.com>
Date:   Tue Nov 25 19:53:29 2025 +0000

    mptcp: Initialise rcv_mss before calling tcp_send_active_reset()
in mptcp_do_fastclose().

