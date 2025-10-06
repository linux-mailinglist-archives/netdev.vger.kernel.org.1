Return-Path: <netdev+bounces-228024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5394BBF1CF
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 21:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9936834B498
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 19:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22B823D7E6;
	Mon,  6 Oct 2025 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A36nYUK+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2287E215F5C
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759779550; cv=none; b=ZaiO3sfsmOjiccyGQ65MBecDv054Vp0T02NdBRTfe0iZ3g1jqlHJNVZ1tMnr+DA+ddYOJY2Mk0gqdRLvP3FWVAHlhwBhXbUE8171WfO8HspMNMqkY7msdXq9mCuYbLVwOSmO+FhW0wfpIBDMv8p6amHq7odGd2Yx/sgTDEA0R3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759779550; c=relaxed/simple;
	bh=8NnvCwxXFYrb2eeT9L1TzNbphG1m9VKlU9TVZvha8u4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOLsNjWDkZLklSCUso31AatlTwjP7iCX93mUbNZHkwVK/Na8ejzA19ZVO7yjRA3vuvRlP+k4cAyeQD0k7F87H8qWN2fqDVpKJJXBdF89egK+m3uVXvI6nm1oXwz29CHNkIwpb7/FrI8sIDaxsKSYzL5YYYiR2vK/r8Au4EjV/gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A36nYUK+; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4da3019b6b6so49852771cf.3
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 12:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759779548; x=1760384348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsNd+WFo5daOEVQEUGVa/XJKJwpYI4DKaFcUkLpF5uo=;
        b=A36nYUK+NnN8ACNbyYHeHJxjMI7DPOvE5svnlUUrNO1bzuGEIXT/LIQCxr9ZfRp7b/
         ggelqk6fAhDGy+qg83j8peqEXNpqHAVaRJSCFZvNKhYTm5lPpHw38z+Cqi+UOMRasULj
         FU89LC8V5JxCBq8W9/hvuidA3nQNBBJYkG13cH3Jwvv9Ts6h1X5CWm7s4jzPcF415Cij
         38NF9dO5YQJUwu1nqbi1yrD0sJL941a0Zo5ukj7fjBzgwP1xyOFJvWiYon6fFfy+OKTl
         hj7xcmt2BMppHs0DvCM09aIr1QXJBN/jF+7j9dQkWQ62GcKSa8q/Fu26LO6P69swwRZt
         9bjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759779548; x=1760384348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsNd+WFo5daOEVQEUGVa/XJKJwpYI4DKaFcUkLpF5uo=;
        b=qn74NVfhCoAqoXrGj3sM+5lS0e0312EgTotQ1Sh1kf/1BZOotpz73ANeO0KRaPof+6
         f8ayw0P8WLLlyvmd6txFwCdSgzEP7tErSjrWaHW6VS+nIvIIZkYVZD35RR+Q2875eHsZ
         h2QMlq7xNPESFE+qXxJIGGLEVHAW5m3re02qS5RrnfeccuuqcondfLXo8i1GycUtCp/V
         TB1D67SIdWQfMu0Luw1D5x3JJtdF3njW2god5kcR/7jXW3VYCbvSaHf3YO/Z6lfH52go
         /vRlqU0MVRTeNGfAMmY70mRpitMAhL3B00jAuNe8VFqlcRdHjxf/PYkcxy3MhO2I/HC1
         yp0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpsUTXZ36BxQmOzRXJX2vco+eF3zVUQMCZs1iGiibWTXOluCINXZWGC/Dse9OnNvpGbxpD18E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo6T4Szx7F0hSZYMlADRCAQgrjq/+1gx4Br2RlEAuKt6jloD/Z
	qn+grZmzkoLO/u+Eqczu55GxRC84XBNIhc94SewjniE1/Ne9uZJZXa7P0eBTRHa6irJnOlZKBax
	BxkbHQVzGBWFZJTJ1uoKD1z44eo2u/JNTReagCiJi
X-Gm-Gg: ASbGncswYnq3NI8ciChU3YUwvTVoQTZdmc/xE1+MeEoGq5FuyoC3ixxHk//m28xFAzA
	9JAXCFdVM3n/g96m5P1P/yTCWz9aJQuyPUkW2fpEEhxSBjReqsKorARVpVdd/V+L0coNGO4nDwk
	pgHB8kerR+2MbqifDcwnSkooF/rd1BuDnja9A+KOpQDYNuctCm9fwcNzMwO7gPM7JhE2f8vuj0r
	m97am6zg8MPrdGwWrCkMPMRQ0/WXCepzFBY
X-Google-Smtp-Source: AGHT+IEtOW0pmO9Mlev1TknSRJ9buDcC4Z9vzyuOoSlC22KMrLQIT/182wPD2YuP83eTBEAQRq5Pd8XhP7L9SiFElus=
X-Received: by 2002:a05:622a:124b:b0:4e0:a152:6feb with SMTP id
 d75a77b69052e-4e576a469c4mr165842711cf.12.1759779547415; Mon, 06 Oct 2025
 12:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006193103.2684156-1-edumazet@google.com> <20251006193103.2684156-2-edumazet@google.com>
In-Reply-To: <20251006193103.2684156-2-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 6 Oct 2025 12:38:54 -0700
X-Gm-Features: AS18NWAp6kcI-5n1nXurlWyv6vtHpgKQBgnM5wgdOLr4TEbzVNikDo96MFw7roM
Message-ID: <CANn89i+J4aHWWsOVBhUVz6qqX8_O7zzjZOvDKCfD7NAiBrQpVg@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 1/5] net: add add indirect call wrapper in skb_release_head_state()
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 12:31=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> While stress testing UDP senders on a host with expensive indirect
> calls, I found cpus processing TX completions where showing
> a very high cost (20%) in sock_wfree() due to
> CONFIG_MITIGATION_RETPOLINE=3Dy.
>
> Take care of TCP and UDP TX destructors and use INDIRECT_CALL_3() macro.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/skbuff.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index bc12790017b0b5c0be99f8fb9d362b3730fa4eb0..c9c06f9a8d6085f8d0907b412=
e050a60c835a6e8 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1136,7 +1136,9 @@ void skb_release_head_state(struct sk_buff *skb)
>         skb_dst_drop(skb);
>         if (skb->destructor) {
>                 DEBUG_NET_WARN_ON_ONCE(in_hardirq());
> -               skb->destructor(skb);
> +               INDIRECT_CALL_3(skb->destructor,
> +                               tcp_wfree, __sock_wfree, sock_wfree,
> +                               skb);

This will probably not compile well with  "# CONFIG_INET is not set".

I will fix this when submitting the non RFC verson.

