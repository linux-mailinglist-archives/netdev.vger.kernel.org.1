Return-Path: <netdev+bounces-52860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9C8800749
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 10:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690FD1F20F99
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 09:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69631DA3B;
	Fri,  1 Dec 2023 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WJbwxA9k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D2212B
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 01:39:12 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a195a1474easo137195266b.2
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 01:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701423551; x=1702028351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnFUtdIlVA2d9tBtQukci+iRJrwP/AAcyQDASJ91hoE=;
        b=WJbwxA9kuGtFoatgTd0wMQjlpE/H2K8s90pddAnKs2BLSHULxwoKs729i4kP0bF1lr
         jrc+F9l/+ZI/qedVAWKu8VKiMuzlVKo9ugH725e5UpjPUw8yxHpsZs8v6j0k+NAvKPwp
         hANHGX823UXrsDJL81/2fCO6ZK/v63Tc87k07nwI8+tyRZou7R1o8g4wFBOI4XbX1EV7
         0yfvzfFEgGckOpLvIRnyiOBS0nI7ovvKOITLnUN+ImA79qAa4TjGd8wFjiGVT4HQza8q
         qrkRVZ2a9b2hPjH/6+budsYQLyB+B2kbo3jX+yldhnWke+Q7mTN2fJ+/YnQInm0Ipzhr
         3c+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701423551; x=1702028351;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pnFUtdIlVA2d9tBtQukci+iRJrwP/AAcyQDASJ91hoE=;
        b=oFb77kgGm6glH5hVom5tT1/4MlTC8nxe7byFjIzg69V0L4B+yl+o6O0UMt+HTSxB3J
         ZqE48d/xFCdZZ11VQHXqX+tE70HnOlgAhX6QMNDDk8dw1/GZZsVp1Kb3QhjkdQnkzWCu
         9TkTUVmTjJA9qZndieMaB+T4xOgCBiQUQw9kqx5ob90+1jgqTopenyvNszFCevm20RGC
         adHp1cp7sp0wuXXzCJu7/DYtJSediD4pudiUDasK1Xw2NcqDgY/56to0fgihMzqew7dI
         Qjdl4/lPvEkPeUD/GKS62maYZlteR1i6xtE0l/RUFx/mWX4tx/nyVQ0nh1eIakvRiHLD
         3+1Q==
X-Gm-Message-State: AOJu0Yx51ERUKICWFqyea2aaiUb//IM8HbIh1ZaOd8X6fIgUBVcRSq0d
	+Iwrk0gWbIl42h4WS7UmngghZg==
X-Google-Smtp-Source: AGHT+IFh4SRWbrGt/QYaqztQ2PCTlQT+mzzgDginVCRhKBzxaJDHVJG03TQYHdbTTerjGqsXiumyDQ==
X-Received: by 2002:a17:906:44:b0:a01:bc90:736d with SMTP id 4-20020a170906004400b00a01bc90736dmr1226431ejg.40.1701423551382;
        Fri, 01 Dec 2023 01:39:11 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506e:2dc::49:54])
        by smtp.gmail.com with ESMTPSA id fw5-20020a170906c94500b00a1a26260b15sm340711ejb.13.2023.12.01.01.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:39:10 -0800 (PST)
References: <20231201032316.183845-1-john.fastabend@gmail.com>
 <20231201032316.183845-2-john.fastabend@gmail.com>
 <CANn89iJahyHqkMsUMPoz0xPCKE9miy0AC-P_cBYKGnLWEWX3zw@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>, Eric Dumazet
 <edumazet@google.com>
Cc: kuniyu@amazon.com, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: syzkaller found null ptr deref in unix_bpf
 proto add
Date: Fri, 01 Dec 2023 10:35:48 +0100
In-reply-to: <CANn89iJahyHqkMsUMPoz0xPCKE9miy0AC-P_cBYKGnLWEWX3zw@mail.gmail.com>
Message-ID: <87il5i2req.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 10:24 AM +01, Eric Dumazet wrote:
> On Fri, Dec 1, 2023 at 4:23=E2=80=AFAM John Fastabend <john.fastabend@gma=
il.com> wrote:

[...]

>> diff --git a/include/net/sock.h b/include/net/sock.h
>> index 1d6931caf0c3..ea1155d68f0b 100644
>> --- a/include/net/sock.h
>> +++ b/include/net/sock.h
>> @@ -2799,6 +2799,11 @@ static inline bool sk_is_tcp(const struct sock *s=
k)
>>         return sk->sk_type =3D=3D SOCK_STREAM && sk->sk_protocol =3D=3D =
IPPROTO_TCP;
>>  }
>>
>> +static inline bool sk_is_unix(const struct sock *sk)
>
> Maybe sk_is_stream_unix() ?
>

+1. I found it confusing as well.

[...]

