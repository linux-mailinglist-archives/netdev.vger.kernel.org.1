Return-Path: <netdev+bounces-170994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABFEA4B04F
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 08:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E672D3BADCF
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 07:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2724E1C2DB2;
	Sun,  2 Mar 2025 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YuFnaPrD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3DD158DD8
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740899507; cv=none; b=H3QwH4FfsHlQ8I7zcFN4RGmT3S47zqNmle8x4wRemKOeuCSPY74uzQCYb9YUPSAFIiEbzY/YA+9WXMsmAJmV3VGQ14ReF8FDLUf+4yhFALCozb3pJTmUtBznspISP8t2us2S49mC9hsM73sT1x3sURm5AbKxTdBb/gONGJg77jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740899507; c=relaxed/simple;
	bh=WTRmP/t2UHNNln+V06noRfWKJiHkyBrBwU7UtDpGLZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrnl6LhfxF5eVPT9cfqZtlr1bKobr/b936iB4srP8Rrui1k4WiiBq+xfKgssPjF1crsY5jfq80S7O+VlXAghiEbraEkWDKn3hYm913sv9RE5scLI6Z4HWIvHC4MqTm7waK8L6Xa4z0c0yf43qwIoo7k5qICZcb5nB2IjNjIR6tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YuFnaPrD; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47208e35f9cso42613701cf.3
        for <netdev@vger.kernel.org>; Sat, 01 Mar 2025 23:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740899504; x=1741504304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTRmP/t2UHNNln+V06noRfWKJiHkyBrBwU7UtDpGLZc=;
        b=YuFnaPrDSNwBYz6b08EVHeP/Nf/30is18TzTH9vTfnA7NgIdxEQb7U+uuaylLeWZ0V
         IRWjUW6blIJvnunuSCHYg/tV/vM164o1Z4nWTdJd924goywtC9cJnMTl2MQI7S+HoQ5o
         iDNbIaB0Ktnr6nkeOjumotUzpxUocsNd4+fLg0biw37aLDj9YJXEY9h17H9xPzJgkbvW
         zAR4oEcmizEvcVZhdUeSuXVjaUGzgF8KMQW5ttS5so664wemtpEFw8FfYUK/3eXwb35e
         9Emut3+2rBbskG5hTbVYj7qLUj/FAe3iih5/HB9Z+Q+EyqJOSOaBqwW87VGff7jTEABP
         LQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740899504; x=1741504304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTRmP/t2UHNNln+V06noRfWKJiHkyBrBwU7UtDpGLZc=;
        b=A2suolLwjqeWts/sxqOmftEBBU4qes3YP3zFngpla/vL+Oy6M3RYm4aPzB4qD1ogV5
         6NoYNPVb0kc8jq8nZIfw3PMN/+97f625/P7uC3n8fljomyVeV25rnKVvr8wDMt5GffrP
         Nick/6tkWxWEP5f5yMxGbj2bDls3gXY39R7XpKhRvRgspyLKC82QkD8k2GpsC47a6gzU
         f9k8DppPd16CaZtGyMg9Vf8dmxajGOWL7BFZ+HeVq4uVwOJTvwWWYkKaLtAWNagnRdfv
         OcMjH0X+LSOBQZCIitWHUOHYtLB/kAEHznqf/jRSnHGEJ8p5IqDVYaNjNmI+MWcj3kuS
         JKQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlYRX1Xlpk6sxLLTKI1o+MZeqgQD9t+JbsIgBxlbR+iNZtfM7/676GbNXpxpTYy240+99eRqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVxk9gslJgCASjCpXI/qszeQ7mMZKS2N2gSuHJNvlaAfsrm+Pq
	VkR7hTF/dZxANzRCb0xK4ao+W65FA4gie5MnHcBur+hO0UqLwt+cpiWfjSZ39FF5LHsRT6F8o+P
	TQDcM5AmmEWAlQ5McWRGYxeJ6cgCwGnDbt3NB
X-Gm-Gg: ASbGncsL7hsl/I8NyrZozRBRSTNxnqfROfjJ9i1ODEqGxPfgoSdJ6yb5xki8GTb5D2y
	TOsZ35fqeZiLuPRe7n2Y8hOozwE2cW5j99ed/me2kVfZg7wffesXlShHMbpZFYsuHlHu2I+e5xo
	2HDuSiqgrUQrFGt2g0FjAPpBLxXqA=
X-Google-Smtp-Source: AGHT+IEqJaHTEGCVfws3nkUj8JkxdioNYPfO/8HJCYDPORYK4qSnTZ24n6j/5Nmmpa0t/pepjQDeVx3j4D9b6GdDFJg=
X-Received: by 2002:ac8:5890:0:b0:471:b8dd:6401 with SMTP id
 d75a77b69052e-474bc08ad3bmr133593931cf.21.1740899504087; Sat, 01 Mar 2025
 23:11:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301194624.1879919-1-edumazet@google.com> <CAL+tcoAY1xKgdFzQDcU4LJ7wEZ7oFSaY_aqwtiw4MV-W1RMBWg@mail.gmail.com>
In-Reply-To: <CAL+tcoAY1xKgdFzQDcU4LJ7wEZ7oFSaY_aqwtiw4MV-W1RMBWg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 2 Mar 2025 08:11:33 +0100
X-Gm-Features: AQ5f1JrVe7Kwrib-_J8qxFUThHxKSMXb7xbkvJkyfEhXdxo_a3wcZaTlQsHajsk
Message-ID: <CANn89iLpVW5bs7y8Hr5b07_7CAV2XkOgC9E7goCWpjCaiEKj6A@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: use RCU in __inet{6}_check_established()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 1:17=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Sun, Mar 2, 2025 at 3:46=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > When __inet_hash_connect() has to try many 4-tuples before
> > finding an available one, we see a high spinlock cost from
> > __inet_check_established() and/or __inet6_check_established().
> >
> > This patch adds an RCU lookup to avoid the spinlock
> > acquisition if the 4-tuple is found in the hash table.
> >
> > Note that there are still spin_lock_bh() calls in
> > __inet_hash_connect() to protect inet_bind_hashbucket,
> > this will be fixed in a future patch.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
>
> It can introduce extra system overhead in most cases because it takes
> effect only when the socket is not unique in the hash table. I'm not
> sure what the probability of seeing this case is in reality in
> general. Considering performing a look-up seems not to consume much, I
> think it looks good to me. Well, it's the only one I'm a bit worried
> about.
>
> As you said, it truly mitigates the huge contention in the earlier
> mentioned case where the available port resources are becoming rare.
> We've encountered this situation causing high cpu load before. Thanks
> for the optimization!

Addition of bhash2 in 6.1 added a major regression.

This is the reason I started to work on this stuff.
I will send the whole series later today, but I get a ~200% increase
in performance.
I will provide numbers in the cover letter.

neper/tcp_crr can be used to measure the gains.

Both server/client have 240 cores, 480 hyperthreads (Intel(R) Xeon(R) 6985P=
-C)

Server
ulimit -n 40000; neper/tcp_crr -6 -T200 -F20000 --nolog

Client
ulimit -n 40000; neper/tcp_crr -6 -T200 -F20000 --nolog -c -H server

Before this first patch:

utime_start=3D0.210641
utime_end=3D1.704755
stime_start=3D11.842697
stime_end=3D1997.341498
nvcsw_start=3D18518
nvcsw_end=3D18672
nivcsw_start=3D26
nivcsw_end=3D14828
num_transactions=3D615906
latency_min=3D0.051826868
latency_max=3D12.015396087
latency_mean=3D0.642949344
latency_stddev=3D1.860316922
num_samples=3D207534
correlation_coefficient=3D1.00
throughput=3D62524.04

After this patch:

utime_start=3D0.185656
utime_end=3D2.436602
stime_start=3D11.470889
stime_end=3D1980.679087
nvcsw_start=3D17327
nvcsw_end=3D17514
nivcsw_start=3D48
nivcsw_end=3D77724
num_transactions=3D821025
latency_min=3D0.025097789
latency_max=3D11.581610596
latency_mean=3D0.475903462
latency_stddev=3D1.597439931
num_samples=3D206556
time_end=3D173.321207377
correlation_coefficient=3D1.00
throughput=3D84387.19

