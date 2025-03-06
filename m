Return-Path: <netdev+bounces-172343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7893FA5446E
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E3D1896205
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 08:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDE71F63F0;
	Thu,  6 Mar 2025 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNh0SBaK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530C41F3FF8
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 08:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741248896; cv=none; b=WBxyXUsvLgXoPb28WrkrODvV0MB2BOOl5joPwaky4zNO3mvisHKlkq91knFQxSley2T7roReNW0Ncx7dHn0BLU8qaOQgqPv7IMm4o5sDyZrYYO0ujuf3sjsYuiJ3v2Mu9+qGkvyII5+paIklWgml06NV2JXK70fYCyB5ZrcmM2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741248896; c=relaxed/simple;
	bh=MSqGkl4HkXjRFLMaLrGMGYEaxReJFJ+sp5N7/nPKSGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rRltN9XijZQVs/PK/nLhfsq0z1WpBkp2nhzNNQNNKbo6Vj/eBJWA3SxY9lzyNtU2KRYwd0/e0+AsBjok6ZopfPaST/5Q5whkx8bnuYHuoa31HksClifTncvtbebDC5wIHzwq+LPYc7jCDvhxyvIxlUL63Ln/Im7XhjHI8qTv0Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNh0SBaK; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-471f686642cso2410821cf.2
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 00:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741248893; x=1741853693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4d1O41jPY85hOen96d4YwY2ovCEgNa8I3VPgCTmoKbI=;
        b=dNh0SBaKTrIa4fgNFKzLWNJ8OE7wBwOm9m9+et8UEdzWKkrji6vB0FRhalZHJdKBKH
         y7N+2a4wGkgg0LRMSIPZFkAS/rvCVvJGBe6quz39rGu/il1dvqO1orcWTRJG1mMdldhe
         vylfeg6pHQhHzgWlfNMc6BCRfzgOZfbrvSl/0ci6Aw/Mfsyp8eAPSsFF0HT1PsiOHtPT
         kWrQW+px8/pk3ZeDcgT6D4z7heR6/hkPTBvK6KlKTqV21IwYYiAmX9/c+5KadSHAPAwg
         LyYO458S+qncuQoQ7vhUUeQna60TKN+ywGvaGXCDxxNyWg+qo3QYq3jK3ZEQO+ik7Qsl
         9ZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741248893; x=1741853693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4d1O41jPY85hOen96d4YwY2ovCEgNa8I3VPgCTmoKbI=;
        b=epa1YIN+yabRgOdnCKFWNpEUYRh1eCnkbqAuqDhoI8tJrwKilefDnrDqfSFu/nBMBU
         b/VDy1Lq00hjVbqGcWmWLaTeRFybXO8H8lk8Us9tXkeqeEXVk8nzSKHXAeXvUihlGkew
         7OdHfQCzyam5b1tYWWfYk7xX9k8AL6AvjH2N/ET85yPxYXzlILZMX1EC6gT2y2ciypX8
         pNrwhnFd3Zse1x56DT/XeuaDjbuz+aXRdjhL3T86k7pVTwzqfe0I0sn8Ao30lScOiqpm
         tBWDKweFS7hNE9cAUYmZnjc6ioPYgGik5vP8h4UuXUfkqAY5zsCtigR8gWuJYs/hU126
         /Aww==
X-Forwarded-Encrypted: i=1; AJvYcCWa6bbJnpVImOMRVnRwVYBIBVGsmIP7hsHo51jBZ59JQxh7OrO7EBr2w8wsoVZQrHOEvgDcDZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDe+X49gFHqmsze66rtNRUjKvp91IaC7IW/F2wrQ/jK87UwyUF
	coEQUWsY7rT1gCn7SQp+rirJik7mRXadhG5J9/zrslZe26coKPurkF/jsZ4K13FynXF8Ii9VVli
	7TwdzOrEmu3WwN0MsXWlESfLMtM1KImGXHd2v
X-Gm-Gg: ASbGncuJEUREJk2XEKx8j3N/BnqgZdmugOrqfDAg5BzB426J7KLetAvAS4sB/MK8j40
	sSfCGqjZIcRKv+KVDIGUmeLY9F8v1E8B6bL6E3/Wk43q6GmHAMLWUAqWEifVlq9Zk1QKuocqMzS
	7yBzbQTEm9qcTu5RdsArDsGWdBIg==
X-Google-Smtp-Source: AGHT+IHhtsb+51eMdPCM8dx8BQK0QayfxEvOEEBMtKRQSQXo72bWy96KhFU1PmFoZOkVnBr4DA+npl7z7ZUtzbVuN+0=
X-Received: by 2002:a05:622a:251a:b0:475:1dca:165a with SMTP id
 d75a77b69052e-4751dca4e39mr17557771cf.41.1741248892878; Thu, 06 Mar 2025
 00:14:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305034550.879255-1-edumazet@google.com> <20250305034550.879255-2-edumazet@google.com>
 <CAL+tcoAzeBGpv53cXdm7s_3C63fMR8vkeLyCReSbnSNuf6pWcg@mail.gmail.com>
In-Reply-To: <CAL+tcoAzeBGpv53cXdm7s_3C63fMR8vkeLyCReSbnSNuf6pWcg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Mar 2025 09:14:41 +0100
X-Gm-Features: AQ5f1Jq8ApYrdhcbjFxhcvLKgfQ-j1ZAzsE8eVChMrCo-br3Nvxu_G8gND2Nlk0
Message-ID: <CANn89iKLgA_BhiXik2_Xq4HMmA4vnU3JHC8CEsaH6dvD9QK_ng@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] inet: change lport contribution to
 inet_ehashfn() and inet6_ehashfn()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing <kernelxing@tencent.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 8:54=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Wed, Mar 5, 2025 at 11:46=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > In order to speedup __inet_hash_connect(), we want to ensure hash value=
s
> > for <source address, port X, destination address, destination port>
> > are not randomly spread, but monotonically increasing.
> >
> > Goal is to allow __inet_hash_connect() to derive the hash value
> > of a candidate 4-tuple with a single addition in the following
> > patch in the series.
> >
> > Given :
> >   hash_0 =3D inet_ehashfn(saddr, 0, daddr, dport)
> >   hash_sport =3D inet_ehashfn(saddr, sport, daddr, dport)
> >
> > Then (hash_sport =3D=3D hash_0 + sport) for all sport values.
> >
> > As far as I know, there is no security implication with this change.
>
> Good to know this. The moment I read the first paragraph, I was
> thinking if it might bring potential risk.
>
> Sorry that I hesitate to bring up one question: could this new
> algorithm result in sockets concentrating into several buckets instead
> of being sufficiently dispersed like before.

As I said, I see no difference for servers, since their sport is a fixed va=
lue.

What matters for them is the hash contribution of the remote address and po=
rt,
because the server port is usually well known.

This change does not change the hash distribution, an attacker will not be =
able
to target a particular bucket.

> Well good news is that I
> tested other cases like TCP_CRR and saw no degradation in performance.
> But they didn't cover establishing from one client to many different
> servers cases.
>
> >
> > After this patch, when __inet_hash_connect() has to try XXXX candidates=
,
> > the hash table buckets are contiguous and packed, allowing
> > a better use of cpu caches and hardware prefetchers.
> >
> > Tested:
> >
> > Server: ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog
> > Client: ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog -c -H=
 server
> >
> > Before this patch:
> >
> >   utime_start=3D0.271607
> >   utime_end=3D3.847111
> >   stime_start=3D18.407684
> >   stime_end=3D1997.485557
> >   num_transactions=3D1350742
> >   latency_min=3D0.014131929
> >   latency_max=3D17.895073144
> >   latency_mean=3D0.505675853
> >   latency_stddev=3D2.125164772
> >   num_samples=3D307884
> >   throughput=3D139866.80
> >
> > perf top on client:
> >
> >  56.86%  [kernel]       [k] __inet6_check_established
> >  17.96%  [kernel]       [k] __inet_hash_connect
> >  13.88%  [kernel]       [k] inet6_ehashfn
> >   2.52%  [kernel]       [k] rcu_all_qs
> >   2.01%  [kernel]       [k] __cond_resched
> >   0.41%  [kernel]       [k] _raw_spin_lock
> >
> > After this patch:
> >
> >   utime_start=3D0.286131
> >   utime_end=3D4.378886
> >   stime_start=3D11.952556
> >   stime_end=3D1991.655533
> >   num_transactions=3D1446830
> >   latency_min=3D0.001061085
> >   latency_max=3D12.075275028
> >   latency_mean=3D0.376375302
> >   latency_stddev=3D1.361969596
> >   num_samples=3D306383
> >   throughput=3D151866.56
> >
> > perf top:
> >
> >  50.01%  [kernel]       [k] __inet6_check_established
> >  20.65%  [kernel]       [k] __inet_hash_connect
> >  15.81%  [kernel]       [k] inet6_ehashfn
> >   2.92%  [kernel]       [k] rcu_all_qs
> >   2.34%  [kernel]       [k] __cond_resched
> >   0.50%  [kernel]       [k] _raw_spin_lock
> >   0.34%  [kernel]       [k] sched_balance_trigger
> >   0.24%  [kernel]       [k] queued_spin_lock_slowpath
> >
> > There is indeed an increase of throughput and reduction of latency.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Tested-by: Jason Xing <kerneljasonxing@gmail.com>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
>
> Throughput goes from 12829 to 26072.. The percentage increase - 103% -
> is alluring to me!
>
> Thanks,
> Jason

