Return-Path: <netdev+bounces-171168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1756FA4BC02
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 11:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4E827A4493
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6644B1F0E3D;
	Mon,  3 Mar 2025 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HMVUByrH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B997B1D63F7
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997535; cv=none; b=g8IxKjpaFNDMDcn7IPy98jX5vxYTJvejGEYzxWKN/lTl0rL6Qphl2ZmocnPh8PYvsOMOpOj2YN5cx11Qog+dn/uBKSpZocggTMi5FY7w7J7QpLNfCLtWCGu58sEW3RsRgX6pT1UHrBA/2APFhPP5aIzvnHaKIkWafrHZgpxyS60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997535; c=relaxed/simple;
	bh=+jWFj+6c+tnA6viBFroBo8w6Ck4kM2IdVklx1ugRuaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQKH2eBkQMDCXs3urMqnXyx+I/avTuBUpaik6vy7twEfhnASTUjdmSwtZI+ew6sBq9/JIkw7NpPQUa+3+CUPjtlM2ZywHMQgTR0DLjR7PXORz2WhuEDSyTe4dPXgnuC9r+ru5TJYC84qAOn7StOcuZvi1uVcSUsjTMfOZsWvsy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HMVUByrH; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-471f4909650so38809231cf.2
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 02:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740997532; x=1741602332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Q+yp4lkhMYow7B6SfNJoDIbgF7POgJDcW/uEms7wn4=;
        b=HMVUByrHTI5esoiHo8cdz+qmfBMyCYge81PwzVa+zzsRF+tQuHzHUemWWr4629LhPk
         xdZHtuJQaI52GnpuIpQSeKlzbcFgELesxsEGY0E9eyKDCnNozLcD0P0xNHhjaZreQAsE
         JmB5NVH9IdWipnJZmQHcre0zGfG26qT3/VgTGkHtJd/YkSQ1DgO2jLBZUHYr1Kt1i5wm
         v4bPD9ozLxKsvd7TR4dG/wkvPNyDgF8KbE36WYthdhLImHW3wI9yfSeCUMTtAPaiPWUv
         xpgIc/zDB9yAw5BKaqOsmd3kfH3f5fzF5uZHLQ4tky6lP3LbabD0+r6vPUpK+NHVvuGr
         Hu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740997532; x=1741602332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Q+yp4lkhMYow7B6SfNJoDIbgF7POgJDcW/uEms7wn4=;
        b=WB3WtRbeIB/gQ7gkHLEtO2zrwnperSLkHdTM4LWhCDAwOLeXAj1jRGL78J3k7JpbxU
         SPddsps3sFowFG0M+kQV2FaJBoZ7uvDBighYdcatza4Mby4U97jwBHrfha1UcQ76BcHh
         mZAuYy3BbgAtxudXttJnEssQAQvzSPpf9aoazvxrWUhw2+9QE6hTtYGTYo7FyQHV3C5q
         drlXlxms5Fc51Ft0VH3pVfFuT3tQkAMOgBffKEtn+NyQXuRsv/g61t454BTP5qoNvYLP
         VlsMyDE3SvTte3+7Q9BF9WL7tImgnlj6apKQzr012fJAbX6u2oXv4tyzzg8sX9e9pmrz
         5AgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYFJ7MeyxXMe0fIlNcGM77W/vnbhHL0KrHoVaUznoILQ00GSFjG6HFDkVfAPUEMTbektUs5qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvGcQ1yrO1RGthv/WHLpqQVFNI8eTQif5a/3Pxsoc5avYK30An
	apHeAXYMJbModSNM9P4gHXzEfTf8YWi21i1nV7aKSxMadxSToRqH53VHXe7SeHYNurCWN33wuaf
	nklL4Rn+mwO4aHSPmr/+5zY3eJDvI/D2FuAJ0
X-Gm-Gg: ASbGncuMv8+UiWjtOwCf3oAp2lWrry+RYe4KC2m84JFEGoLRPpDIBpGPuOgUqgqinVY
	OMnM8lBYFg1y3QKZQAT3kUikT/s0f0Lim9Tnswr3TPPxYFrXduketWE6FYAAi3CvXUylrPLJ6Av
	EwfcpIvE1TyF6inpkSwn5Jx1pI
X-Google-Smtp-Source: AGHT+IFmXB7/xV9yKo4ib4wZlwm/dP579/VRVEVi5lBVpYgAXdK/mp2KpXjWJuoleiwLBUki8YFXUmPgBljWV+wbQLA=
X-Received: by 2002:a05:622a:1352:b0:472:1225:bda4 with SMTP id
 d75a77b69052e-474bc05180amr193715311cf.1.1740997532322; Mon, 03 Mar 2025
 02:25:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302124237.3913746-1-edumazet@google.com> <20250302124237.3913746-5-edumazet@google.com>
 <CAL+tcoCOLBJO1PZdKPu2tM3ByQbu9DKcsHn1g6q33CbpHtx5Cw@mail.gmail.com>
In-Reply-To: <CAL+tcoCOLBJO1PZdKPu2tM3ByQbu9DKcsHn1g6q33CbpHtx5Cw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 3 Mar 2025 11:25:21 +0100
X-Gm-Features: AQ5f1JqjFULk-2bq7M-vvpw3HTcfC_N6nz6uzs43yK2guBWAX4lDwcSInfr9h9w
Message-ID: <CANn89i+pAcJyB1hhOQYzXZKOeDoS1gz4xuDiMBQ3h4PqmVZAsA@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] tcp: use RCU lookup in __inet_hash_connect()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 2:08=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Sun, Mar 2, 2025 at 8:42=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > When __inet_hash_connect() has to try many 4-tuples before
> > finding an available one, we see a high spinlock cost from
> > the many spin_lock_bh(&head->lock) performed in its loop.
> >
> > This patch adds an RCU lookup to avoid the spinlock cost.
> >
> > check_established() gets a new @rcu_lookup argument.
> > First reason is to not make any changes while head->lock
> > is not held.
> > Second reason is to not make this RCU lookup a second time
> > after the spinlock has been acquired.
> >
> > Tested:
> >
> > Server:
> >
> > ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog
> >
> > Client:
> >
> > ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog -c -H server
> >
> > Before series:
> >
> >   utime_start=3D0.288582
> >   utime_end=3D1.548707
> >   stime_start=3D20.637138
> >   stime_end=3D2002.489845
> >   num_transactions=3D484453
> >   latency_min=3D0.156279245
> >   latency_max=3D20.922042756
> >   latency_mean=3D1.546521274
> >   latency_stddev=3D3.936005194
> >   num_samples=3D312537
> >   throughput=3D47426.00
> >
> > perf top on the client:
> >
> >  49.54%  [kernel]       [k] _raw_spin_lock
> >  25.87%  [kernel]       [k] _raw_spin_lock_bh
> >   5.97%  [kernel]       [k] queued_spin_lock_slowpath
> >   5.67%  [kernel]       [k] __inet_hash_connect
> >   3.53%  [kernel]       [k] __inet6_check_established
> >   3.48%  [kernel]       [k] inet6_ehashfn
> >   0.64%  [kernel]       [k] rcu_all_qs
> >
> > After this series:
> >
> >   utime_start=3D0.271607
> >   utime_end=3D3.847111
> >   stime_start=3D18.407684
> >   stime_end=3D1997.485557
> >   num_transactions=3D1350742
> >   latency_min=3D0.014131929
> >   latency_max=3D17.895073144
> >   latency_mean=3D0.505675853  # Nice reduction of latency metrics
> >   latency_stddev=3D2.125164772
> >   num_samples=3D307884
> >   throughput=3D139866.80      # 190 % increase
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
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> Tested-by: Jason Xing <kerneljasonxing@gmail.com>
>
> I tested only on my virtual machine (with 64 cpus) and got an around
> 100% performance increase which is really good. And I also noticed
> that the spin lock hotspot has gone :)
>
> Thanks for working on this!!!

Hold your breath, I have two additional patches bringing the perf to :

local_throughput=3D353891          #   646 % improvement

I will wait for this first series to be merged before sending these.

