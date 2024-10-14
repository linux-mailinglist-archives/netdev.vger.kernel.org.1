Return-Path: <netdev+bounces-135210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F95999CCAF
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 16:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FF28B230C4
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 14:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C003B1AB501;
	Mon, 14 Oct 2024 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVN1/6Fd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351C51AAE02
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728915780; cv=none; b=Xc02h7mWgUIdNQiYht7MsobljDwAQYdKv/hbmgoIIjpf3ONyIbWS+Ei8V8MrYMMEk2u/CQK5Rg+EUUTOgqCBCdwObep/VPAVO/L52J13VU6AXo3lDKgN6z0l6pimClqBqVsGzjf9NHw43key9S/O75Dvy8dyleTweFYdpjCp6Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728915780; c=relaxed/simple;
	bh=COPuTgj1WCC+7Ns3FvKEo4lV+3CjnOZ1nutLaUiEiuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g82+22jjGDSwN8sH0ZDMUMy5L9Qg6PEpsh3EhhPHHFxiWo5WQFpUoQWho+YAtjXt7ntPMz57UWBNywSiJ1Y/KSEoyHlx9owxmKi3ZTb7DWMS3jvpubr+uC0FAVcBND2pqPdQJLhrxcxcp6MorWzp2JDxOpZ3TyFNCahZ/j9XbRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVN1/6Fd; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cbcd49b833so36717186d6.3
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 07:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728915778; x=1729520578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aayf3HsiSicPQ/JF2ofu9tBgvK8RdHFFqZNpiYe5XEw=;
        b=FVN1/6Fd2YqxZIgSpTqKg1PzVj3KwW40BTeJwsK5qABcYKtl/qQMRkpCtgWaGuaUh5
         IBhgJZkTU4w7a0kglzqZsW90MGdOqRRPdLgbd8pi3iR8U/+9nrFJy2b/zn1CE0rpSi2w
         0+bSxrIJPS3bano1uxRZaX5a/So79lDOntyBgqQuZJ6tXm2fETUztydgAMrbcrbkoMqu
         HLirgUjtIeKYmADvimbUvwavw7ut/6hJY4h4VapzHR08etQK+DPgvrYbtf/Hl6SgcZ32
         LFmlS6//XvkPDnO0FGg9dmeRmx/0QtvbVE7mB3OhUg22V9m7pwkTMZEOUzsZ0/yKFQ9l
         3fHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728915778; x=1729520578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aayf3HsiSicPQ/JF2ofu9tBgvK8RdHFFqZNpiYe5XEw=;
        b=O9+3PqA1wC3rkB/MmYXRfRWBRTmntspG9Vj7z5zimr/pvA0za2x7J/eGY23nG643Yx
         splaqAwQTJEWMBXr/lUJKZaM32Byq9PhiUb6N4nD8y8pudFSDelqgvtSPai3bhdr/m/+
         VpdErF4cP4bCt4x8ZRfKoX9RIzknpdCkRpD3fuHUguEM2CHUUkF+nyxZpKZLavYY3c6L
         dD0GssjzrvoUr3hqbrCq12SGVNIdOeejmpGB+VJblhdVbqy1eb5Gu23T8BydV84hIK6Q
         CiWT8DS+uZ4Q6EqnlM4Anp4kHUdQgg8o3OOXaKNfliEx0p44dI6OlGqe4LYlVFdWeX+e
         BOvA==
X-Forwarded-Encrypted: i=1; AJvYcCX59Uo/FVqVfC71c9Y4ne3uuqegnmXs6qqTJzgpEmfG/5dGOPkNZ9qXp45V0IQm7z0dwZVQsbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOG+0CUIbXA7VAqeRQ5lk8z8f9V3JXiNFlhv0YXNOpcI55j8Kn
	/tHM0RZhZ02C3XQ7sEwovUyVKXd3VSRrNBeSOSrnkFMiLWidc2hbMXwWDpQ1F4GEPxD21tP6wHc
	1ZEt21TPl1j5PKDhds00Ft5IScezF0/W/g/bc
X-Google-Smtp-Source: AGHT+IGDvP244liS9FCwlaFPH7v1mtszCXkBGgk/C6tSg9JDcOE4p7lU6t/kKSntnzin2LHOtIZ4r3vGxM6+zRUcRCg=
X-Received: by 2002:a05:6214:320b:b0:6cb:ec6a:7d52 with SMTP id
 6a1803df08f44-6cbf9d6121bmr116513516d6.31.1728915777871; Mon, 14 Oct 2024
 07:22:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010174817.1543642-1-edumazet@google.com> <20241010174817.1543642-5-edumazet@google.com>
In-Reply-To: <20241010174817.1543642-5-edumazet@google.com>
From: Brian Vazquez <brianvv@google.com>
Date: Mon, 14 Oct 2024 10:22:44 -0400
Message-ID: <CAMzD94QsX=RC3-5fvy5-2DXWAZ4G5=LMZ=K2SXR92NnFSxBbTg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 4/5] ipv6: tcp: give socket pointer to control skbs
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for this patch! This indeed helps to have more info within a
bpf program which is extremely useful!

On Thu, Oct 10, 2024 at 1:48=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> tcp_v6_send_response() send orphaned 'control packets'.
>
> These are RST packets and also ACK packets sent from TIME_WAIT.
>
> Some eBPF programs would prefer to have a meaningful skb->sk
> pointer as much as possible.
>
> This means that TCP can now attach TIME_WAIT sockets to outgoing
> skbs.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Brian Vazquez <brianvv@google.com>
> ---
>  net/ipv6/tcp_ipv6.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 7634c0be6acbdb67bb378cc81bdbf184552d2afc..597920061a3a061a878bf0f7a=
1b03ac4898918a9 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -967,6 +967,9 @@ static void tcp_v6_send_response(const struct sock *s=
k, struct sk_buff *skb, u32
>         }
>
>         if (sk) {
> +               /* unconstify the socket only to attach it to buff with c=
are. */
> +               skb_set_owner_edemux(buff, (struct sock *)sk);
> +
>                 if (sk->sk_state =3D=3D TCP_TIME_WAIT)
>                         mark =3D inet_twsk(sk)->tw_mark;
>                 else
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

