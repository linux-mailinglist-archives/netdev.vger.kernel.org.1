Return-Path: <netdev+bounces-71335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E0085301A
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A511C22540
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8001538DD9;
	Tue, 13 Feb 2024 12:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RkRKoVBP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FA838DD5
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825845; cv=none; b=uDF8vobPJEuN1F6feWGPqEMy7aCBIy+sv6I+Mpn0IxRdWuQjaoKjw5yDubiREK+H4mXeZHXtMXsUJdjgQQX49ZFzc+QevLi1ZlcC0SMfYcAaXq8QNqfdVA4Aa7CldCo7oHt0PI8GBF6irU5ib8QxwGFvXureKy2PLCPUrbUivZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825845; c=relaxed/simple;
	bh=Eg+MSbobvhT2In8ZArhO5mabfooH4XkfC/bLjoKgyQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ET7CqLPDZk6ze7P0bRrbFKHDFCFeD7NEKV0hRzP/Hkw5k1MVskK+s6tL5z/x0tl23UhLO8yGU8/MHfSYfj8EZ5cKCWuaMgxEB2n4/NNkqCsOCtQ6XIcvc+JEt331FLzJgOM0BbUsDC138L2yGVo/jGyS9K2EIXdY2ol7tP3GNO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RkRKoVBP; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56037115bb8so8765a12.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 04:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707825842; x=1708430642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gb0ppSryruG1g1MWG1VaIhGZuyzlFN236ROplx54MV0=;
        b=RkRKoVBP6ARjh7l18bHSCne+CJAkl/FdLDc1ps3wfBnvRR51B0BLWHGrhpu7uYWGbe
         jHegIFRtWBLD+Req7io56FaPmwyrlVbYeRc6FmePuixOK1J/nH7zQXzE/DCRfUIsOwDO
         ljuC/XmpTXp09j+Of4KhlGd8MSTTPqxCEn8pT4+n7G0+sdFTeocEvrDzgD5+j7ajuaJb
         oEq21K7ivkX1MmpsrP7feh+5iyiktn3WWskXO27HlPetTZWhSkrhL7Y+FVtgtgHu3Xk/
         KQfucOijjdvWUnyHGzQMhkZfe+fMopAdNxkBLvGGELJWgS4WeA2QGeASK+8Y6rAbxAa6
         CJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707825842; x=1708430642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gb0ppSryruG1g1MWG1VaIhGZuyzlFN236ROplx54MV0=;
        b=LzvxE0u2nvsiRh4uLPrENeGT530Itnes8K70l2BX/YAsbvty+ulIPtjGql9uKC0C15
         bIGz8p1b9GieAEdKbGLGuJLDQ5zVoxM/OmmFHAQl8b47vyH+ghbpDwHUQfDw97//11/v
         q/XU0jr3MuMrUKLgKW3Z2o2WwxVmu+NJNrSEJEzZjcLFDfhJbwsxMTr17xP9UdSUKfPt
         Vdzs41E9vpZdvOt55l9nfsOVuoJBG10M7u84agTTwXPtENLy6Zvmw/oCkyUGTrK9VkZG
         FV82lZj0XXnZcjMMN5VfNyJRIi6SLJenbmmojWsdmxAtBTeu7OlYrxe8I69zwmJWLD8j
         OV4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEZ8YFAd5mCj3vVREuvabnl0Huj0rRmluVQqE4vX8P+N8s0Oa7WDWF+W9Vl7eZKxHQLfdW8Sp78urGYpaTkjG3Kciy64Ie
X-Gm-Message-State: AOJu0Yw1531MVxtW9OX/M1zhPpJ9odCh8wALd/Zuq906DxOFBuzREJhr
	eLRC5OJ5HxaAn1aVtXnWwGaI+MhPfKmtuKGo02/Qj13dlE2iUirIgIuL5ESXX+D3s7ZyFxYUjpd
	6DQxgIp2yVPQ0AC47iHAvqFnmySG7hhonrl+8
X-Google-Smtp-Source: AGHT+IGJyS91rvDZXSzNOmEMEmY5/UU8oe72HGLVrlaLaD9JG/Z/XB73N4PxUdiZAWNi9nV1XKm/aNiiEzFXrZr1k6I=
X-Received: by 2002:a50:9fad:0:b0:55f:cb23:1f1b with SMTP id
 c42-20020a509fad000000b0055fcb231f1bmr132594edf.0.1707825841579; Tue, 13 Feb
 2024 04:04:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212092827.75378-1-kerneljasonxing@gmail.com>
 <20240212092827.75378-4-kerneljasonxing@gmail.com> <CANn89iKmG=PbXpCfOotWJ3_890Zm-PKYKA5nB2dFhdvdd6YfEQ@mail.gmail.com>
 <CAL+tcoAWURoNQEq-WckGs6eVQX6VFpHtw4CC9u4Nc7ab0aD+oA@mail.gmail.com>
 <CANn89iJar+H3XkQ8HpsirH7b-_sbFe9NBUdAAO3pNJK3CKr_bg@mail.gmail.com> <CAL+tcoB1BDAaL3nPNjPAKXM42LK509w30X_djGz18R7EDfzMoQ@mail.gmail.com>
In-Reply-To: <CAL+tcoB1BDAaL3nPNjPAKXM42LK509w30X_djGz18R7EDfzMoQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 13 Feb 2024 13:03:46 +0100
Message-ID: <CANn89iJwx9b2dUGUKFSV3PF=kN5o+kxz3A_fHZZsOS4AnXhBNw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/6] tcp: add dropreasons in tcp_rcv_state_process()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:30=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> On Tue, Feb 13, 2024 at 5:35=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > >
> > > Hi Eric, Kuniyuki
> > >
> > > Sorry, I should have checked tcp_conn_request() carefully last night.
> > > Today, I checked tcp_conn_request() over and over again.
> > >
> > > I didn't find there is any chance to return a negative/positive value=
,
> > > only 0. It means @acceptable is always true and it should never retur=
n
> > > TCP_CONNREQNOTACCEPTABLE for TCP ipv4/6 protocol and never trigger a
> > > reset in this way.
> > >
> >
> > Then send a cleanup, thanks.
> >
> > A standalone patch is going to be simpler than reviewing a whole series=
.
>
> I fear that I could misunderstand what you mean. I'm not that familiar
> with how it works. Please enlighten me, thanks.
>
> Are you saying I don't need to send a new version of the current patch
> series, only send a patch after this series is applied?
>

No. I suggested the clean up being sent before the series.

If acceptable is always true in TCP, why keep dead code ?

This would avoid many questions.

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 2d20edf652e6cb5eb56bda0107c99bed0b0a335f..b1c4462a0798c45e9b10d62715b=
c88fa35349078
100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6623,7 +6623,6 @@ int tcp_rcv_state_process(struct sock *sk,
struct sk_buff *skb)
        const struct tcphdr *th =3D tcp_hdr(skb);
        struct request_sock *req;
        int queued =3D 0;
-       bool acceptable;
        SKB_DR(reason);

        switch (sk->sk_state) {
@@ -6649,12 +6648,10 @@ int tcp_rcv_state_process(struct sock *sk,
struct sk_buff *skb)
                         */
                        rcu_read_lock();
                        local_bh_disable();
-                       acceptable =3D
icsk->icsk_af_ops->conn_request(sk, skb) >=3D 0;
+                       icsk->icsk_af_ops->conn_request(sk, skb);
                        local_bh_enable();
                        rcu_read_unlock();

-                       if (!acceptable)
-                               return 1;
                        consume_skb(skb);
                        return 0;
                }

