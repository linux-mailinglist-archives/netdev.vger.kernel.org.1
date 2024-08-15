Return-Path: <netdev+bounces-118802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0B5952D01
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA85C1F2298B
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2B87DA6B;
	Thu, 15 Aug 2024 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xryd6LvA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11427DA62;
	Thu, 15 Aug 2024 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723718935; cv=none; b=YuFCl8CDai9Hy0fxUqIx7594+UxmkN5FYxUHXlqa8sKJNMB8/4C2WzRiHlB8BuRsynDXLoCFqPZ0Nz+WCqbd0Ueh+xPexpEXpTrEdCQWlkbbXRG0somhByZny3F858AgIgE0JQxc1ybwFARm9JEt7HvpldqFKEmvNP+OiJJWO0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723718935; c=relaxed/simple;
	bh=GyDD3yza3z6x3taZ8nX69f5bL4Rz4uQTO9+7tRRZBsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTW+D2ksEa5xmnrYJ6YfPhjCA1myU3w5gb/3jloTHPMKXIkG9zndwarUlZ6R/fOxUzC3Se8kWY05pspZ1+TVRQPJNbx6GBZJu6sTXJYwio6QRBZP+VYluB0DASE3LZcatO7uFtlZYlPbabGK7/xzB4I2Ow13PhETnyVXuUMa9c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xryd6LvA; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-39b06af1974so3189335ab.2;
        Thu, 15 Aug 2024 03:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723718932; x=1724323732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uItcCny5ZpkIJczdfFLsxnmfv2Non+oTHPGtPs4FhnI=;
        b=Xryd6LvApKhb9qzR9kk48MmpgWX8+/MIY34ajibFaIWaPPq5NyrEyRMm2NPtmkPjrS
         i+Ka2i5Pa8NbcHKHSCAmytuWdLWbfK+SSJwJZOHzx0Ip4fun2/tMQbuTvKywjggyXDyf
         ao0K4Zy9W7o0stHG+S5zDf+yxV7aM/KLLhmJ1wS2I/+1ZfnB3WwfJLlPkVMeQIED+Hg8
         cod4VTQkmKhUvvu2f6NxvQUaoW0fJ/pDTVvKb9EH2a58G2RTHDecT84sOD16+kojiac8
         em+jM5gt+XR7eL5Yz0jHs1VLAxihISSd/46qD4bSyxvTUzdknD/Mz2DiCVmyaHbOqTdl
         e7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723718932; x=1724323732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uItcCny5ZpkIJczdfFLsxnmfv2Non+oTHPGtPs4FhnI=;
        b=uS+wgjEd/rfWvwCR7QPe0J7LNvTbtAM+KBOfPfEungdaLeggfhqdtc+C62D1AI/UsZ
         ERb6tjazxYRs6uVTMw6SUBLtuv9FZlaPcFdlJ/XgCZDHYAU4fKl+DdNobgZEBOdStCYm
         OdPWZbjZKfwsX/FjdtaG6dRfrxXNXcz5wIkRiPn+l4icFhGOy/h7gCxHrjY0gTbXRYAF
         pwK0bUbgL2quMN7RscQaWkb1netKNWY6vAOOYsKhHqAk4FZBD5f8HEZCkaixWLGsdQnL
         1dbAgE0+UtFG7VyRQvQ9qm8Os5PytbG7I7sqwV47Wn9yz2osivrYa0y522GY6Q8onkGZ
         USgg==
X-Forwarded-Encrypted: i=1; AJvYcCV3SRacDCz6iahrj8m4STQzKAIiCdL8Y+8sgZ0JEL5LKGzjAnfYxgvrxv2dMY3M3wIVFxIXRGrlQMLzdQxf3DpCo2FiTbKUJTqlkUxwoTyahquWmrEJiYvaPM1DQZcOsgSTrpwk
X-Gm-Message-State: AOJu0YyZAx6LsNC61hkMlOkK8Jl8nZ9sFWXaUZAbNMpLyRBkDkpOwoJr
	BcEq2Tnii1eUGANYcfNtmai00NaDi7z2dcHhwFFZzVO3JCgAUAvyTMftx2QamHLLLNosj58BVnc
	64HbArpkg14deDM2Vrs8X4Y4IJ90=
X-Google-Smtp-Source: AGHT+IFusiwxIxLhiiogzhKzID2xdWRdUbfeoUs5+6sigFZbG7D0YWWmTp0XuHTKZKmbr6q0+okAIhHR8voqz+7tdI8=
X-Received: by 2002:a92:c24f:0:b0:39a:ea86:d615 with SMTP id
 e9e14a558f8ab-39d124412a0mr66843225ab.6.1723718932601; Thu, 15 Aug 2024
 03:48:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815084330.166987-1-sunyiqixm@gmail.com>
In-Reply-To: <20240815084330.166987-1-sunyiqixm@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 15 Aug 2024 18:48:16 +0800
Message-ID: <CAL+tcoBoe+YA12ZEn+-R2r4YYR3by1VsnN6GGmQoAtOPiej+BA@mail.gmail.com>
Subject: Re: [PATCH] net: remove release/lock_sock in tcp_splice_read
To: sunyiqi <sunyiqixm@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 5:46=E2=80=AFPM sunyiqi <sunyiqixm@gmail.com> wrote=
:
>
> When enters tcp_splice_read, tcp_splice_read will call lock_sock
> for sk in order to prevent other threads acquiring sk and release it
> before return.
>
> But in while(tss.len) loop, it releases and re-locks sk, give the other
> thread a small window to lock the sk.
>
> As a result, release/lock_sock in the while loop in tcp_splice_read may
> cause race condition.
>
> Fixes: 9c55e01c0cc8 ("[TCP]: Splice receive support.")
> Signed-off-by: sunyiqi <sunyiqixm@gmail.com>

It's more of an optimization instead of a BUG, no?

I don't consider it as a bug, unless you can prove it... Let me ask
what kind of race issues could re-lock cause?

I think holding the socket lock too long is not a good idea because
releasing the lock can give others breathing (having the chance to
finish their own stuff). Please see release_sock().

Thanks,
Jason

> ---
>  net/ipv4/tcp.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index e03a342c9162..7a2ce0e2e5be 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -856,8 +856,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *=
ppos,
>
>                 if (!tss.len || !timeo)
>                         break;
> -               release_sock(sk);
> -               lock_sock(sk);
>
>                 if (sk->sk_err || sk->sk_state =3D=3D TCP_CLOSE ||
>                     (sk->sk_shutdown & RCV_SHUTDOWN) ||
> --
> 2.34.1
>
>

