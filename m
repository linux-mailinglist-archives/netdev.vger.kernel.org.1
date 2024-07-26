Return-Path: <netdev+bounces-113167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB1093D08A
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 11:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0591F22454
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 09:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C78178366;
	Fri, 26 Jul 2024 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y88s7rD5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D010178361
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721986854; cv=none; b=gftFKNxAS8Q5dm5mhF41x8Twy5Sm7Lg9ze51Kx4ffa/B14+JdROsHC5KdataqNHUpR206/fpnRRLM/2vken7xO4SARFJ8hqJLO+10j8hsmt6UxXN/XFGeOGrHTRlqkHqYuDZG38wJmuYTMNJ9kSol41M5FjjezFa0h+HCixnsLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721986854; c=relaxed/simple;
	bh=P25LvgYgVVRQUPeBf/BN0qLVDQc0AmcO0D7sEwPRnCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUtkUI5mGTP/+AuL/syvoWiyI5SAM3kSXnv+UR8vYapkK0j1Vk5JHqmhePQ9PjLYAqsKyfSgq6FPli+hy+Hwfmcst5xQMF139NZANZ5CZXhleQnm20bQrh8JmIi4QQfMMJsG80aqI3N3YjCwSMiCg9ZuxZ/Qa05Fh5Elzl8kzGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y88s7rD5; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52efce25f36so2183e87.1
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 02:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721986851; x=1722591651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFQxSVZw3ewtv2JPKD1OvmrmpCJl+7VZu/8n0cRjbAo=;
        b=y88s7rD5m019ZYVMcmHoVQzdzmOMqQUgP2MAIQtpfBtpFocQC5Twpr3fha6T1g4HDT
         Dm0tpyuntV2G44GnbLQrZ2VCLXmXh0pbkwk6yNEgWcTUA3CsiB/iYKCnWj8wX6jJgbr1
         yMUuxtBtJagl9KTCV+1iWNEpMUkUocA925GCCTrVqjGJoIBIpikCm+dbqwVGndvGpL8J
         WTmIybcQ//Xm7X7eVLvdSe5RHo00j2eIhzwJKewBanFOsrUhymNw7+Lm3PPWSPZUbqlV
         8CgPj4HdgSqrO7ID6q9euvujPV3MLWsVvXOa9pkpkXPkdjjAg8vbJ5pzfwTZ4VT3YcEF
         Lnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721986851; x=1722591651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFQxSVZw3ewtv2JPKD1OvmrmpCJl+7VZu/8n0cRjbAo=;
        b=QQw6BGV2nP7AL+WqBAZu/QoX8jwPFUQcip9QG/YZZgO3/0CzT7wS4iyYKaIezGMqa2
         KX7PXXi3QGtq9GCT92d734dEEY2FqXobDfvLaOL798ty/MR08WuoqEg4q48V4q4+0zwT
         0iApA76uqmiy7F9hkXcywNlh0ls9rR0N4EHKI3UiDUWROlTxy9z0Xz+6wJDWkvK/tIcH
         U2bgcxMVerNkwmx65UBgoYZK5EACuRD2UtaLYciH6wfsY3km3AAbjCipqdJyURcZLpxY
         upG280QGLeMg5LeOG5P1Am3qqD9+lgdae9ytTtMO3Tb7Vfj0a3SEvb+0dklkP5tfZ4w7
         fJmA==
X-Forwarded-Encrypted: i=1; AJvYcCVccciLnQjab2eofZQdITyL1gFHFlfVVG8k7uRDTk+Ny+OJzdSyLLOBQhWUkbcMIY6i5hPNUDXma0LSSZ94RoL/v+DJSXA4
X-Gm-Message-State: AOJu0YyiRN0b9dwV0QHDDI8n+mCajB4O78XdGRAzLHpUF+XZEn6HZhYu
	GBiXk7doaJqSd1M3Pc9qmWRF/4qj4gjuxZZM8ApjUAGnW93MetR18cbqszwFN/FTWKt6/4p6ezl
	tukaqFatSQqYHrPfxXs/SXlzhL3pH9anr348B0rz4TRcxEYIbdVAV
X-Google-Smtp-Source: AGHT+IGq9/LEJnS6R3zKMCM3unSqzdUyalqwmHn3RMPTcX6wwk4YsbpnVdi1YAs7k+fQqMSpnQc6fREUTqICAr4Bfw0=
X-Received: by 2002:a05:6512:3e21:b0:52c:cc9b:be20 with SMTP id
 2adb3069b0e04-52fdb52d825mr116398e87.1.1721986850785; Fri, 26 Jul 2024
 02:40:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725215542.894348-1-quic_subashab@quicinc.com>
In-Reply-To: <20240725215542.894348-1-quic_subashab@quicinc.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Jul 2024 11:40:39 +0200
Message-ID: <CANn89iJ5eGCGgF+_4VxXXV_oMv8Bi-Ugq+MG6=bs+74FR63GUQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: Adjust clamping window for applications
 specifying SO_RCVBUF
To: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
Cc: soheil@google.com, ncardwell@google.com, yyd@google.com, ycheng@google.com, 
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	Sean Tranchetti <quic_stranche@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 11:55=E2=80=AFPM Subash Abhinov Kasiviswanathan
<quic_subashab@quicinc.com> wrote:
>
> tp->scaling_ratio is not updated based on skb->len/skb->truesize once
> SO_RCVBUF is set leading to the maximum window scaling to be 25% of
> rcvbuf after
> commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> and 50% of rcvbuf after
> commit 697a6c8cec03 ("tcp: increase the default TCP scaling ratio").
> 50% tries to emulate the behavior of older kernels using
> sysctl_tcp_adv_win_scale with default value.
>
> Systems which were using a different values of sysctl_tcp_adv_win_scale
> in older kernels ended up seeing reduced download speeds in certain
> cases as covered in https://lists.openwall.net/netdev/2024/05/15/13
> While the sysctl scheme is no longer acceptable, the value of 50% is
> a bit conservative when the skb->len/skb->truesize ratio is later
> determined to be ~0.66.
>
> Applications not specifying SO_RCVBUF update the window scaling and
> the receiver buffer every time data is copied to userspace. This
> computation is now used for applications setting SO_RCVBUF to update
> the maximum window scaling while ensuring that the receive buffer
> is within the application specified limit.
>
> Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> Signed-off-by: Sean Tranchetti <quic_stranche@quicinc.com>
> Signed-off-by: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
> ---
>  net/ipv4/tcp_input.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 454362e359da..c8fb029a15a4 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -754,8 +754,7 @@ void tcp_rcv_space_adjust(struct sock *sk)
>          * <prev RTT . ><current RTT .. ><next RTT .... >
>          */
>
> -       if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf) &&
> -           !(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
> +       if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf)) {
>                 u64 rcvwin, grow;
>                 int rcvbuf;
>
> @@ -771,12 +770,24 @@ void tcp_rcv_space_adjust(struct sock *sk)
>
>                 rcvbuf =3D min_t(u64, tcp_space_from_win(sk, rcvwin),
>                                READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rm=
em[2]));
> -               if (rcvbuf > sk->sk_rcvbuf) {
> -                       WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
> +               if (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
> +                       if (rcvbuf > sk->sk_rcvbuf) {
> +                               WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
>
> -                       /* Make the window clamp follow along.  */
> -                       WRITE_ONCE(tp->window_clamp,
> -                                  tcp_win_from_space(sk, rcvbuf));
> +                               /* Make the window clamp follow along.  *=
/
> +                               WRITE_ONCE(tp->window_clamp,
> +                                          tcp_win_from_space(sk, rcvbuf)=
);
> +                       }
> +               } else {
> +                       /* Make the window clamp follow along while being=
 bounded
> +                        * by SO_RCVBUF.
> +                        */
> +                       if (rcvbuf <=3D sk->sk_rcvbuf) {

I do not really understand this part.
I am guessing this test will often be false and your problem won't be fixed=
.
You do not handle all  sysctl_tcp_adv_win_scale values (positive and negati=
ve)

I would instead not use "if (rcvbuf <=3D sk->sk_rcvbuf) {"

and instead :

else {
      int clamp =3D tcp_win_from_space(sk, min(rcvbuf, sk->sk_rcvbuf));

      if (clamp > tp->window_clamp)
            WRITE_ONCE(tp->window_clamp, clamp);
}

