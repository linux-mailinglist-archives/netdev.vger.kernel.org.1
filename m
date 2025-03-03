Return-Path: <netdev+bounces-171183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 156C1A4BC8F
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 11:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D32616FC14
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7DE1E5701;
	Mon,  3 Mar 2025 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvjfvYiX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DB31D7E4C
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998430; cv=none; b=tRTgTXvWBf/5xg2h2Amv5grBnK1MU5aieXy6jpoYpfyOjl3TvNY5yNVeSUDI9XDAl4Bg5IUTfJBgjsdRjUBrDMn4wFS1RITg2thg31LXPpHoU+hv7FPo0e2tndzSZN3ibkycxy6cES747UTSBZJDmh1W84vqmsrUWJiR7n6QhUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998430; c=relaxed/simple;
	bh=l+OMvRTVaYDVCnnuSAQ1Niz3Zh8MEqg0yHaCg5zNSPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrZ95zy2L2jkRB2O9s2PIhFYRSax0OW2pdFsL6E4uRItXFPYzwHaOXG07LoA69y95SRBps3jftTu13EAGwI/cYfUXVRrSwsS/pIOO/8ggclbiXCFaz8trvoX4HS43tMpA47REXTyaiARxkLTpQzspOJOAkPWRN7Sz3fbVcQsDRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvjfvYiX; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3cda56e1dffso13423405ab.1
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 02:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740998428; x=1741603228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KK4D1tBnKdC6vTjtgAV+68KXKX+DyJbeTVN0K4fU0Wk=;
        b=EvjfvYiX9UluXJO743oRgfzCRuiXjJyFxl2E4FfH9zYTSfJReADxNlivSEexPnB2lj
         QwbHBDTZRyGPDCL1PeBrkbEtzkgSWnuChE4A28iI4ls+Rcf45vn+T3bKz+Q+ChimPeEV
         NnOejZvugN4ihYIlRMUopl/qfEOgI+MT2Apfs5teZI3p309Z8m1RuV5bpAIsHzlj+Eov
         qGYceGVq9c7DfstwcgCuzvfGfPHlGFuufJPyjqaEL4Yl2JciKvTXarEzkH5pvMrAqVvl
         wBKEcYyT9WbtHg37bKLnEZZ8igA6OVbyb2ldyemEdqB3bhK1AcG4DktK8g/u+wwD/ubR
         gjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740998428; x=1741603228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KK4D1tBnKdC6vTjtgAV+68KXKX+DyJbeTVN0K4fU0Wk=;
        b=LHOo55MsGdozHEvrGNPBYuR5R1+VeXcY0sCzlrWRw8P2BC4U9F0s+wfhuj+VpP9/oR
         RyWAMUqZIzrhQ+s0zs65fesEdaxIWO2V5v5wTjT2A1Nq/GnP46ucHJyptCYuX6b0sQ56
         MLVnOzRSLmtbG2Hfadft2Tf3IeidLimu+jjvUOj/T6sdjyCQUp+oa8GZ3ma8Cy+OV+mg
         1Zdxsz9OEG0TK1HxcJsgNHCzt3L9eD4Vf9XS30yEAaNw/MHgBXt+cq+6LlbZbiLLLahX
         nOejE1rf8/OBnIltBd8aT5IsYjaWZ8xOrFiZ+Db9j4wvitXkWwPsQdujWR5yq4AAOAIA
         EFWg==
X-Forwarded-Encrypted: i=1; AJvYcCX+uLa4Wf3S4zbIWj74opJqtLWyYkZY64QVUiV+Ue//qrcxPzvULNTSCa1OG0WQhGYLXyFoIl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOdXXac+2XCiO//BS1uxFS7IIstCu6p/JIf2PBIH9LyLgYGcmG
	Yun/RctDLeWqMPz0bDEWjqeOoKm1Pilosw8WxZav3LGTbn8tPQDkPpBAhCHN2MjdiMA44qHg4Ed
	zF1WbGLU+TgfhI/m//szTE0JuH4w=
X-Gm-Gg: ASbGncvnnmJTouI70+9j7esbkkCdFNcNsHR5eO+xqHiC72Q2nDB9XlpkrOuSaC611KY
	J6+JmCss776Ywmp18pChgKmLJOb0wjbN4x1iL3LzXy3SIQB5dDP+4dSO2dPvTK4YTtSfxqcvZdb
	u1yovGgWWWhCGi3fPLZDNP+3AmiA==
X-Google-Smtp-Source: AGHT+IHzq1J4JVyR7MrqVT5hb7wWJAipFUlP5uTR6n/DWspppnNOEiR8zjyNqlJwVWVTBTjp+Zxm5rxUr2f8+QhpcpE=
X-Received: by 2002:a05:6e02:1a0b:b0:3d2:bac3:b45f with SMTP id
 e9e14a558f8ab-3d3e6e46267mr125959555ab.4.1740998427416; Mon, 03 Mar 2025
 02:40:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302124237.3913746-1-edumazet@google.com> <20250302124237.3913746-5-edumazet@google.com>
 <CAL+tcoCOLBJO1PZdKPu2tM3ByQbu9DKcsHn1g6q33CbpHtx5Cw@mail.gmail.com> <CANn89i+pAcJyB1hhOQYzXZKOeDoS1gz4xuDiMBQ3h4PqmVZAsA@mail.gmail.com>
In-Reply-To: <CANn89i+pAcJyB1hhOQYzXZKOeDoS1gz4xuDiMBQ3h4PqmVZAsA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 3 Mar 2025 18:39:51 +0800
X-Gm-Features: AQ5f1Jp8b797ccwqPjpekK58wUVcPn0Rh-kbwh81Y9TIDZ8DkTH-4Sa2UFdCb0w
Message-ID: <CAL+tcoBUBe110JtBtinrcoUZhgJZW7j8JROntpm4AwVv6_TSeA@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] tcp: use RCU lookup in __inet_hash_connect()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 6:25=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Mon, Mar 3, 2025 at 2:08=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > On Sun, Mar 2, 2025 at 8:42=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > When __inet_hash_connect() has to try many 4-tuples before
> > > finding an available one, we see a high spinlock cost from
> > > the many spin_lock_bh(&head->lock) performed in its loop.
> > >
> > > This patch adds an RCU lookup to avoid the spinlock cost.
> > >
> > > check_established() gets a new @rcu_lookup argument.
> > > First reason is to not make any changes while head->lock
> > > is not held.
> > > Second reason is to not make this RCU lookup a second time
> > > after the spinlock has been acquired.
> > >
> > > Tested:
> > >
> > > Server:
> > >
> > > ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog
> > >
> > > Client:
> > >
> > > ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog -c -H serve=
r
> > >
> > > Before series:
> > >
> > >   utime_start=3D0.288582
> > >   utime_end=3D1.548707
> > >   stime_start=3D20.637138
> > >   stime_end=3D2002.489845
> > >   num_transactions=3D484453
> > >   latency_min=3D0.156279245
> > >   latency_max=3D20.922042756
> > >   latency_mean=3D1.546521274
> > >   latency_stddev=3D3.936005194
> > >   num_samples=3D312537
> > >   throughput=3D47426.00
> > >
> > > perf top on the client:
> > >
> > >  49.54%  [kernel]       [k] _raw_spin_lock
> > >  25.87%  [kernel]       [k] _raw_spin_lock_bh
> > >   5.97%  [kernel]       [k] queued_spin_lock_slowpath
> > >   5.67%  [kernel]       [k] __inet_hash_connect
> > >   3.53%  [kernel]       [k] __inet6_check_established
> > >   3.48%  [kernel]       [k] inet6_ehashfn
> > >   0.64%  [kernel]       [k] rcu_all_qs
> > >
> > > After this series:
> > >
> > >   utime_start=3D0.271607
> > >   utime_end=3D3.847111
> > >   stime_start=3D18.407684
> > >   stime_end=3D1997.485557
> > >   num_transactions=3D1350742
> > >   latency_min=3D0.014131929
> > >   latency_max=3D17.895073144
> > >   latency_mean=3D0.505675853  # Nice reduction of latency metrics
> > >   latency_stddev=3D2.125164772
> > >   num_samples=3D307884
> > >   throughput=3D139866.80      # 190 % increase
> > >
> > > perf top on client:
> > >
> > >  56.86%  [kernel]       [k] __inet6_check_established
> > >  17.96%  [kernel]       [k] __inet_hash_connect
> > >  13.88%  [kernel]       [k] inet6_ehashfn
> > >   2.52%  [kernel]       [k] rcu_all_qs
> > >   2.01%  [kernel]       [k] __cond_resched
> > >   0.41%  [kernel]       [k] _raw_spin_lock
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> >
> > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> > Tested-by: Jason Xing <kerneljasonxing@gmail.com>
> >
> > I tested only on my virtual machine (with 64 cpus) and got an around
> > 100% performance increase which is really good. And I also noticed
> > that the spin lock hotspot has gone :)
> >
> > Thanks for working on this!!!
>
> Hold your breath, I have two additional patches bringing the perf to :
>
> local_throughput=3D353891          #   646 % improvement
>
> I will wait for this first series to be merged before sending these.

OMG, I'm really shocked... It would be super cool :D

Thanks,
Jason

