Return-Path: <netdev+bounces-98393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F74E8D13BB
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 07:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5432B21F1E
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 05:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D76B3E487;
	Tue, 28 May 2024 05:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NNGuHa3m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDBE3F9CC
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 05:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716873210; cv=none; b=V5HSlLyWtl35z5pO+qcbwLzEkuavdAkaZbV/GLj0N/9cNODLn3bFGJOBFbhVCptW0UGT8e0vhQ+vQ2PtFWNe/mXn0QLjEuN+W5EUKtdIMkazAoLGzmNPOYZhTyKrUFoR0RmqbIAUqMm4YevWZW7gjid4LSIw1FP/0vMHrR4nA38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716873210; c=relaxed/simple;
	bh=e0VONBs47LTXRHgu0JCQO5iWewHccLvl7AZCo6GhMAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJ4Cd9ClYtYRkZEpZlGFhZMHJrWJbK1CjAEx43h/PFQJrrALzNT6G/1am4shT4rCzpcKFgmzHkU9wHXNhjt76Pqw2Uis7nfxX9h2J4dPc1xVyce5md3Y9Jqt2FGdk29qJvtMSAlw83IdF84l1Ms8NI/D0q2zP8bZD7yyWW8R+jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NNGuHa3m; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so22594a12.0
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 22:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716873207; x=1717478007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04gPXfNDfISyTSha/E1WB4Hczl6iOykhLof2r+A7r20=;
        b=NNGuHa3mhx/nZvKhxwl/8OSQxIlwDPDES7eTBFdhodZx9hX7Jf833XZLKrSevA9Sx0
         0x4Yq2jRmVjgJiCG+znMXF+L3T8PCM8pl+n/YR0zQe3m9w2WmOiGstCKoSmIHN7YLQ7E
         j+Ri/dJX38FQu/y/ESy+XDaQJo2a+S1tdEfvI6gU4AcOG79GmQ6BPIUE+PgJBD5HwJqz
         W7m0QgBCMHZkc/46NndUyU7DUOJBBOLCk3XUX1nboGQkfLk7SyllGAeUb8nQ0wfkxiKZ
         lmAyDrMM/lwgzQjBljTpbmcZxxSAIuipCPXxLOJk1NElBDluYDOHWmJrEpBVLO0PmLGF
         bGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716873207; x=1717478007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04gPXfNDfISyTSha/E1WB4Hczl6iOykhLof2r+A7r20=;
        b=sSnS0xB/U63WTvYI0gv3hdyfoYmJBnVrAsqLvT5u2JCd3BKgAEFIQxxLvCIlogzPr2
         QLcWSkcOZLZfx3KeqCNN4bDJAMMSeeiPsuXbHbKXiBMWhNGkNnHWHDzncp2BL6ZXSvMK
         A9r4NK4S7vdOneUrDQANCMN6ty4bHG6A7XzluunagZzRctf0cvEloE+n9D8Wuoj27ebz
         Yn0RnklYU6tXd2b5u+6vJLqpj9EDDdaouUEQ7JuPO9iuls8RvLz09D1bRof6se8V1zdO
         zATVWoIi53J/yhVtGU9GW8+L6YJDaUFqsDVjoQ0HQcnTJForzFFBjNSeT1N6kqdGZfFt
         SYbg==
X-Forwarded-Encrypted: i=1; AJvYcCXzuukfeSb03OSdnwa9Ohc3uKRWn9zvKAmXXPDwMLiJ8dhzX0IkTpJEkZLCaywbkt4TMpZlpuezRYkjFwID9U6gN+f1V3+o
X-Gm-Message-State: AOJu0Yywl4Y93qj0rL46LUH5Y/eo4u6qgg6m3rl9j2xcaJ9w1W65j795
	NXzoG2cQyF3meeJpZX6yTBDUZyBIRx1VGfa6tecjqYPIQy/kquasgSFZao1k7t1C4xN3qlGDJpJ
	FosWFyQPm0mhj3u0BqP+6hDyIDa9rUkPTr1qRIdzdyDBwkddI9X9o
X-Google-Smtp-Source: AGHT+IEowgJ1I8SWRyuuNYJnVHcKZt4Ppl+lVZ5x/kWHeZ14FrCHZrcSphX8ax3yz3EaY+yocAO6T7O5HOjLNYDPeas=
X-Received: by 2002:a05:6402:1d27:b0:578:5f77:1e77 with SMTP id
 4fb4d7f45d1cf-578673f6657mr332779a12.0.1716873206598; Mon, 27 May 2024
 22:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528021149.6186-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240528021149.6186-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 May 2024 07:13:12 +0200
Message-ID: <CANn89iJQWj75y+QpLGQKZ6jBgSgpi0ZtPf4830O8S0Ld2PpqEg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: introduce a new MIB for CLOSE-WAIT sockets
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yongming Liu <yomiliu@tencent.com>, 
	Wangzi Yong <curuwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 4:12=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> CLOSE-WAIT is a relatively special state which "represents waiting for
> a connection termination request from the local user" (RFC 793). Some
> issues may happen because of unexpected/too many CLOSE-WAIT sockets,
> like user application mistakenly handling close() syscall.
>
> We want to trace this total number of CLOSE-WAIT sockets fastly and
> frequently instead of resorting to displaying them altogether by using:
>
>   netstat -anlp | grep CLOSE_WAIT

This is horribly expensive.
Why asking af_unix and program names ?
You want to count some TCP sockets in a given state, right ?
iproute2 interface (inet_diag) can do the filtering in the kernel,
saving a lot of cycles.

ss -t state close-wait

>
> or something like this, which does harm to the performance especially in
> heavy load. That's the reason why I chose to introduce this new MIB count=
er
> like CurrEstab does. It do help us diagnose/find issues in production.
>
> Besides, in the group of TCP_MIB_* defined by RFC 1213, TCP_MIB_CURRESTAB
> should include both ESTABLISHED and CLOSE-WAIT sockets in theory:
>
>   "tcpCurrEstab OBJECT-TYPE
>    ...
>    The number of TCP connections for which the current state
>    is either ESTABLISHED or CLOSE- WAIT."
>
> Apparently, at least since 2005, we don't count CLOSE-WAIT sockets. I thi=
nk
> there is a need to count it separately to avoid polluting the existing
> TCP_MIB_CURRESTAB counter.
>
> After this patch, we can see the counter by running 'cat /proc/net/netsta=
t'
> or 'nstat -s | grep CloseWait'

I find this counter quite not interesting.
After a few days of uptime, let say it is 52904523
What can you make of this value exactly ?
How do you make any correlation ?

>
> Suggested-by: Yongming Liu <yomiliu@tencent.com>
> Suggested-by: Wangzi Yong <curuwang@tencent.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/uapi/linux/snmp.h | 1 +
>  net/ipv4/proc.c           | 1 +
>  net/ipv4/tcp.c            | 2 ++
>  3 files changed, 4 insertions(+)
>
> diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
> index adf5fd78dd50..c0feefb4d88b 100644
> --- a/include/uapi/linux/snmp.h
> +++ b/include/uapi/linux/snmp.h
> @@ -302,6 +302,7 @@ enum
>         LINUX_MIB_TCPAOKEYNOTFOUND,             /* TCPAOKeyNotFound */
>         LINUX_MIB_TCPAOGOOD,                    /* TCPAOGood */
>         LINUX_MIB_TCPAODROPPEDICMPS,            /* TCPAODroppedIcmps */
> +       LINUX_MIB_TCPCLOSEWAIT,                 /* TCPCloseWait */
>         __LINUX_MIB_MAX
>  };
>
> diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
> index 6c4664c681ca..964897dc6eb8 100644
> --- a/net/ipv4/proc.c
> +++ b/net/ipv4/proc.c
> @@ -305,6 +305,7 @@ static const struct snmp_mib snmp4_net_list[] =3D {
>         SNMP_MIB_ITEM("TCPAOKeyNotFound", LINUX_MIB_TCPAOKEYNOTFOUND),
>         SNMP_MIB_ITEM("TCPAOGood", LINUX_MIB_TCPAOGOOD),
>         SNMP_MIB_ITEM("TCPAODroppedIcmps", LINUX_MIB_TCPAODROPPEDICMPS),
> +       SNMP_MIB_ITEM("TCPCloseWait", LINUX_MIB_TCPCLOSEWAIT),
>         SNMP_MIB_SENTINEL
>  };
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 681b54e1f3a6..7abaa2660cc8 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2659,6 +2659,8 @@ void tcp_set_state(struct sock *sk, int state)
>         default:
>                 if (oldstate =3D=3D TCP_ESTABLISHED)
>                         TCP_DEC_STATS(sock_net(sk), TCP_MIB_CURRESTAB);
> +               if (state =3D=3D TCP_CLOSE_WAIT)
> +                       NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPCLOSEWAI=
T);
>         }
>
>         /* Change state AFTER socket is unhashed to avoid closed
> --
> 2.37.3
>

