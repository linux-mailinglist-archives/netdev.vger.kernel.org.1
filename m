Return-Path: <netdev+bounces-148446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD129E1A5C
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE33F284F83
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 11:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143C41E3777;
	Tue,  3 Dec 2024 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="flu+bSU6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3859F1E25E5
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224040; cv=none; b=fppWRjV7oTnjpwYByBPtn9gwZT5cosDpZ/TUvzjOHAMUeGljdvQJOtXQG+ZC5njY910Hnfrod5m5PaVc9uBIcpX5IeAdNHVXgcV3gmzbtEbiTaOle5yQA2s8LV0LZmejhaSpOHk1768RdjMTC0H2sJBlVvBI0dusnes2zGmZq6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224040; c=relaxed/simple;
	bh=BcLFJqF5R9LBzw/ZSdK7+ys5w76GtCBHQbe2mYPuFWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FW58xwprdGAfwWfhCi2LGXUp+QhWfynzWDCfOhKUJ9u6MRH8+cFhADajQfBmebuHxnlq9eP16Q6hy4sCUoGTHu/Hsrm34dfoXzeQIiMlfrPRnywxshgS5CimeZMM4CNu8cMUSNs6i8J7t+gRJhIxBGru2FXr42xsGk1ci/K1288=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=flu+bSU6; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa539d2b4b2so964970466b.1
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 03:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733224036; x=1733828836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxFrxVDfrOwjFXl5KkCLHRbcRXZZT5T9BXx+SADM3Uo=;
        b=flu+bSU6ZEl+AeU3y/jEL+bAY/q9dC1UbYOKCYt7PuiOwtZcFHLRhxslWVWWal9vy7
         vS10kxstb/PoIfZqeikr8AC2a/ASErX7Y/VGnw4uwp5cv2+Sl5LvUc0x1JSVyMvEKKMD
         F1pMK0zobYiLDzRju913j5G6po7uxXX38QKY7CxsEKhiFgREowyzG8Es6qX6fluNkQ3P
         tuGQmLRjr3Z/2875+lJNUBNuW1DbrQX1X7c9IYvbAwpDdGnwNkFk3JZVq/PKBw0GF/HB
         pjl+psix9j1ywyE8aQMXGPJr+uwGhLHVD/ma4NNsIMcVC56mi/adHwJftMZGSHhSlR28
         JHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733224036; x=1733828836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxFrxVDfrOwjFXl5KkCLHRbcRXZZT5T9BXx+SADM3Uo=;
        b=US66RTNRwjHZY59L0/m1+uTpF73uFC+/3zSjgqkETx3zFqC5KTwq1zprupF2CVuyFH
         UtIKOnuGcNLE3Bj+txrXkaro131+jWv9kSd/Gq7lZsSa0M6Lw9jqXMOPYmZZvuRfez7W
         pXyniGHutdSzjdO53PMQ+rDCqJh84EMIjJiINS1p7GaUDnbTN2gPtIt8995P+z+6l92F
         y1OeHYnaIT3SeBBMfmJq3+GpZcQyJE4Qo63KdUWso9f7xB35ylWu5GAOXt+l5ER3hPTl
         dk4LkQ3XATd21J1OU/svYOxRPmD3FBbak6lbQNXdb93rwccYx1J98KOHDTF5Llw1p+Pr
         H+Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWQSHV+VuYarnbsMtcAolQMINuqA/ichvG6fpFkPtGdRgnSEefRik3kGiYGO2cWGV80NA0A6xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH/5HbCG3YfSx3HQ8j/GxVnDIjOMi5x40xsYbTXsxKjReh15un
	ooR/b3UZ59WtdtJu6KB2UxCItE7rCUXV44tm7AW+9d1hEQXD7S+HXnwPlFX4HPf6uxMBbN9vCF9
	TyoAYDLp2F7Dz4yL6xJU0rbXVn38ArXHelfuP
X-Gm-Gg: ASbGnctA4MZBUFHKQID8MyW8xVItrbbzQEq7WWDYXo8PEo2eB7kY2/413i9AL3zBuon
	sLCBxFUfgzAUKy3tsMTEHXq1aY069lX8=
X-Google-Smtp-Source: AGHT+IFNBPCDBSWJ2rlSUeXx0fiZoz6zwSFf96PshdUcfQi7cbCtRJboavISixKJf7zAhgvyP4zRsca5clzUuPnPnFg=
X-Received: by 2002:a17:907:3e95:b0:aa5:ef1c:9dfc with SMTP id
 a640c23a62f3a-aa5ef1c9ee3mr464606566b.8.1733224036444; Tue, 03 Dec 2024
 03:07:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295@epcas2p2.samsung.com>
 <20241203081247.1533534-1-youngmin.nam@samsung.com>
In-Reply-To: <20241203081247.1533534-1-youngmin.nam@samsung.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Dec 2024 12:07:05 +0100
Message-ID: <CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
To: Youngmin Nam <youngmin.nam@samsung.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, dujeong.lee@samsung.com, 
	guo88.liu@samsung.com, yiwang.cai@samsung.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, joonki.min@samsung.com, hajun.sung@samsung.com, 
	d7271.choe@samsung.com, sw.ju@samsung.com, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 9:10=E2=80=AFAM Youngmin Nam <youngmin.nam@samsung.c=
om> wrote:
>
> We encountered the following WARNINGs
> in tcp_sacktag_write_queue()/tcp_fastretrans_alert()
> which triggered a kernel panic due to panic_on_warn.
>
> case 1.
> ------------[ cut here ]------------
> WARNING: CPU: 4 PID: 453 at net/ipv4/tcp_input.c:2026
> Call trace:
>  tcp_sacktag_write_queue+0xae8/0xb60
>  tcp_ack+0x4ec/0x12b8
>  tcp_rcv_state_process+0x22c/0xd38
>  tcp_v4_do_rcv+0x220/0x300
>  tcp_v4_rcv+0xa5c/0xbb4
>  ip_protocol_deliver_rcu+0x198/0x34c
>  ip_local_deliver_finish+0x94/0xc4
>  ip_local_deliver+0x74/0x10c
>  ip_rcv+0xa0/0x13c
> Kernel panic - not syncing: kernel: panic_on_warn set ...
>
> case 2.
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 648 at net/ipv4/tcp_input.c:3004
> Call trace:
>  tcp_fastretrans_alert+0x8ac/0xa74
>  tcp_ack+0x904/0x12b8
>  tcp_rcv_state_process+0x22c/0xd38
>  tcp_v4_do_rcv+0x220/0x300
>  tcp_v4_rcv+0xa5c/0xbb4
>  ip_protocol_deliver_rcu+0x198/0x34c
>  ip_local_deliver_finish+0x94/0xc4
>  ip_local_deliver+0x74/0x10c
>  ip_rcv+0xa0/0x13c
> Kernel panic - not syncing: kernel: panic_on_warn set ...
>

I have not seen these warnings firing. Neal, have you seen this in the past=
 ?

Please provide the kernel version (this must be a pristine LTS one).
and symbolized stack traces using scripts/decode_stacktrace.sh

If this warning was easy to trigger, please provide a packetdrill test ?



> When we check the socket state value at the time of the issue,
> it was 0x4.
>
> skc_state =3D 0x4,
>
> This is "TCP_FIN_WAIT1" and which means the device closed its socket.
>
> enum {
>         TCP_ESTABLISHED =3D 1,
>         TCP_SYN_SENT,
>         TCP_SYN_RECV,
>         TCP_FIN_WAIT1,
>
> And also this means tp->packets_out was initialized as 0
> by tcp_write_queue_purge().

What stack trace leads to this tcp_write_queue_purge() exactly ?

>
> In a congested network situation, a TCP ACK for
> an already closed session may be received with a delay from the peer.
> This can trigger the WARN_ON macro to help debug the situation.
>
> To make this situation more meaningful, we would like to call
> WARN_ON only when the state of the socket is "TCP_ESTABLISHED".
> This will prevent the kernel from triggering a panic
> due to panic_on_warn.
>
> Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
> ---
>  net/ipv4/tcp_input.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 5bdf13ac26ef..62f4c285ab80 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -2037,7 +2037,8 @@ tcp_sacktag_write_queue(struct sock *sk, const stru=
ct sk_buff *ack_skb,
>         WARN_ON((int)tp->sacked_out < 0);
>         WARN_ON((int)tp->lost_out < 0);
>         WARN_ON((int)tp->retrans_out < 0);
> -       WARN_ON((int)tcp_packets_in_flight(tp) < 0);
> +       if (sk->sk_state =3D=3D TCP_ESTABLISHED)

In any case this test on sk_state is too specific.

> +               WARN_ON((int)tcp_packets_in_flight(tp) < 0);
>  #endif
>         return state->flag;
>  }
> @@ -3080,7 +3081,8 @@ static void tcp_fastretrans_alert(struct sock *sk, =
const u32 prior_snd_una,
>                 return;
>
>         /* C. Check consistency of the current state. */
> -       tcp_verify_left_out(tp);
> +       if (sk->sk_state =3D=3D TCP_ESTABLISHED)
> +               tcp_verify_left_out(tp);
>
>         /* D. Check state exit conditions. State can be terminated
>          *    when high_seq is ACKed. */
> --
> 2.39.2
>

