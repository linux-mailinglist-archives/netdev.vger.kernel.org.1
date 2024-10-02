Return-Path: <netdev+bounces-131133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F19EC98CDC5
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 09:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30025283749
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 07:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3240E7DA83;
	Wed,  2 Oct 2024 07:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4cExjsRd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ECE2F2D
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 07:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727854439; cv=none; b=iTtsr16OeDUkdwcZpexdHEofb1YRrK97/fyieYNTTHtLwBoYiIr9GYtjsYePx327+H0/jq3t+c6hbdCRzoMUo/AP/OOTddQFVUqqZIFOTpRYcGgdQqucaZOwTwBcwcQwvRWQuyd90Ci/GdpU8xxMqksQY+hzPLfh3ZmiEBpyCdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727854439; c=relaxed/simple;
	bh=V4y23rlmqdzfrQZBOAAfrz/M4Z8y6Q4xzmnLAZx4W74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCRE0RugCNTbsrOWRwimkQxiSai96DX/H8lj1W0EeZpddg7PWKP4dhxtHxTe1Na6W7biZUBPNLw0jEZIFU1Deb2ozhSPNOhmTzQjNPJQ43BWZnUeUdB6Mwk1rZb+yhTuzoQBuEmzc1ABKspMxLQx/AVqJiVmHjjr/IbQXJteCOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4cExjsRd; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fabc9bc5dfso49033171fa.0
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 00:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727854435; x=1728459235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLU3JIjvGcpWz+NugR51TY6PTur7Me/ielLCAHwRqQA=;
        b=4cExjsRdg19KqKq0TLe1thH7XZR5I0WoE+yf1OQ6e9bHRx97Y037cT9xmzRW6o1lGR
         uLCUm6XlDj1ZAlI0QKe/EZLiIWIIRpXFKxICv4kU8vWV8chTVKoPxrAt0/qYKpgTkyaw
         r+qtXVJ945Eki43ImDlq6ctN/L55nH/pkYYYUSn6k7Rh07ERJ7DhuWTjBEawqJ8MWACR
         MmuOTGgU8XSoiwRO03MD5Pu/AOsQ3L24FVP6c6nh/7JdwxX5OvVz/eFRDN1Ow26Cy8v3
         gXmI0OYr5ZgyV03At79/HFz712V85O76r6insVTn5EDVUmDSjFrVozDYajTDCKYzkdz3
         YNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727854435; x=1728459235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLU3JIjvGcpWz+NugR51TY6PTur7Me/ielLCAHwRqQA=;
        b=Kv6ar7T9MJjg+m6HUjZ6SpKG/8tMcBeX1fDEhAVIIHu0Hw/gP8jmNPZs8WcX6gdcli
         gOngxO2oNkGLDz4W9WRW4of8rm/ImlQQOshvT9vw/bqoqWvw8dLcBYf47JTwKUNWTa3H
         xXt9P2iy4KaYwpInBgcZQd9hEBVUq4sGLJKF2MONN4+XK8Iti9TQbP9ZgE+Pz0fVw/i6
         4fMZDFEbuBK9UtggnzVk5SV66zfHCDGxudva1afYHU08eb1LuXMjT8K+0uSzJTiHDgAL
         8SkYrFDluwBWPXM2Z0TmUEMNJyxlPO4ClpYD6fOvunqRW+FKdM7IQh/AKCc6bapzn4Zh
         A7bw==
X-Gm-Message-State: AOJu0Yzldhv4eNShHSwOy44GbLutDqxaNKJ1sAcVFyHlddtUX+42Gb2X
	ILA91xwwvhsFKGCAMO8zC3m4tFxegl2IAWbxuDzLMfa0atGscEDn350M+fnbT9WWhic1z+twX5Z
	D47+GyF/CAZ2nfhlksJjmWW0j2oDKIKT5RKD+
X-Google-Smtp-Source: AGHT+IE3NE4xZ8gZxTyssnkNn9U/3K1cHlKUZhTKzL2n9vlIipnglEJfjK8oBO5MAIw8EwAc1X6invOy/6Q3BYEwn04=
X-Received: by 2002:a05:651c:2209:b0:2fa:d296:6fbf with SMTP id
 38308e7fff4ca-2fae0ffcb20mr13607111fa.1.1727854435185; Wed, 02 Oct 2024
 00:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1727849643-11648-1-git-send-email-guoxin0309@gmail.com>
In-Reply-To: <1727849643-11648-1-git-send-email-guoxin0309@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Oct 2024 09:33:44 +0200
Message-ID: <CANn89iLq0g=TmL+nABr=j4N2gw45yJgRr6g8YOX+iMdWrM3jOg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: remove unnecessary update for tp->write_seq
 in tcp_connect()
To: "xin.guo" <guoxin0309@gmail.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 8:14=E2=80=AFAM xin.guo <guoxin0309@gmail.com> wrote=
:
>
> From: "xin.guo" <guoxin0309@gmail.com>
>
> Commit 783237e8daf13("net-tcp: Fast Open client - sending SYN-data")
> introduce tcp_connect_queue_skb() and it would overwrite tcp->write_seq,
> so it is no need to update tp->write_seq before invoking
> tcp_connect_queue_skb()
>
> Signed-off-by: xin.guo <guoxin0309@gmail.com>
> ---
>  net/ipv4/tcp_output.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 4fd746b..f255c7d 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -4134,7 +4134,7 @@ int tcp_connect(struct sock *sk)
>         if (unlikely(!buff))
>                 return -ENOBUFS;
>
> -       tcp_init_nondata_skb(buff, tp->write_seq++, TCPHDR_SYN);
> +       tcp_init_nondata_skb(buff, tp->write_seq, TCPHDR_SYN);
>         tcp_mstamp_refresh(tp);
>         tp->retrans_stamp =3D tcp_time_stamp_ts(tp);
>         tcp_connect_queue_skb(sk, buff);
> --
> 1.8.3.1
>

At line 3616, there is this comment :

/* FIN eats a sequence byte, write_seq advanced by tcp_queue_skb(). */

I think you need to add a similar one. Future readers will thank you.

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 4fd746bd4d54f621601b20c3821e71370a4a615a..86dea6f022d36cb56ef5678add2=
bd63132eee20f
100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4134,7 +4134,10 @@ int tcp_connect(struct sock *sk)
        if (unlikely(!buff))
                return -ENOBUFS;

-       tcp_init_nondata_skb(buff, tp->write_seq++, TCPHDR_SYN);
+       /* SYN eats a sequence byte, write_seq updated by
+        * tcp_connect_queue_skb()
+        */
+       tcp_init_nondata_skb(buff, tp->write_seq, TCPHDR_SYN);
        tcp_mstamp_refresh(tp);
        tp->retrans_stamp =3D tcp_time_stamp_ts(tp);
        tcp_connect_queue_skb(sk, buff);

