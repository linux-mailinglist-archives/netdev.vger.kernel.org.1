Return-Path: <netdev+bounces-89670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE838AB1AF
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 17:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BCEDB21532
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 15:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6E112F5A4;
	Fri, 19 Apr 2024 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="21ac3FV3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BDB4C8A
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540104; cv=none; b=jRQ404pWDo+Qi8ZXenqntROXdBW8MJeui7lg0yyrPV5tz3odlIPycHtHltWpYSQYMVuEcyxR+nY11lDxOFHamfRFZzFnT9eCF2pXPNrbioKBzQWPficcUdYJRJVhoYs8dEtor8NPDqSV4Hm+MA8KvHhlW2zWxLlOGZ6dl+6qBvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540104; c=relaxed/simple;
	bh=PPkEN85bJgO2rKMVRQL4rjGTqEvkqRqs2SHYFlHMLpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhqsBFyZBgylG1DF7Hn79R3jbCesyPUNzimKz6p5IVuVwN+8I0BhrNaC96Ia/dtoK25s6qzMFbCqLcCmJLJTyhL0kdCr32gWciQ0JvqScN9bXRt+HMoBXVFBoVc3REr18tWqb2mJJP0K9yROlCpcJ82Aewsn6LqjAddcqluWZe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=21ac3FV3; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so9980a12.1
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 08:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713540100; x=1714144900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBtImlFafSgtcWWDDnUNomhphyhmKBPdLP5RXHpAuis=;
        b=21ac3FV3rISd6JPJFuhv581Tg+ibRG2csfCdLlptrrf9VWdb3sHbLW5uJyP5Wr8Mf4
         2adkkyuAhdxxqk0f08Ibg83oTFeCxaNo4G7Jfq6lIfL/ajpc55ffxGPra5G+jrRYkmDO
         59y3ggSC/nLGiJObGpXi554IpAjcGRR3jYxEmjd5YjFl1qCarQcYTx9yJgjankDM6Q1O
         LeFukCUD9mD2cQ3C9+YwVWmkTPoOajfff+kQtFUbo4PpGCmATj56e9UnnW/Xb7uEh0Yx
         Q+KLzcSpL7laKdBbC9FudIlgeVUPiz2jhSQHHuPup9TRzNS5aKeKeBQUbmQ/VJJmG+d4
         aMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713540100; x=1714144900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBtImlFafSgtcWWDDnUNomhphyhmKBPdLP5RXHpAuis=;
        b=AAHd3JsM4B20/LtxGay1f0uCjD22JHNs4JcKbGY3QjHVnoCW9dFAIX3/iPcW+Nntww
         Z9eVmtYW5bosXwtzFi7NRUoiDeUsjeAWhTqZgAlgD+zgnSLovMuXHN4M6vknv9IAwKyh
         561R9y06xNaZcpL61cyw1WQKAKZnwXH2hoFqHRgfU4xjw4OhMgaqXlMMbHrbNfzd6aX9
         L5z7icvBAgxtih4a60E4OcpdHyZG3nLW4/Jv4/oSXMKlUGCK+F9W83UdgPQmD9uClW9s
         35UGbyuj2kbjSZGSj526VhNzqgRp7ZnzXzrgQljSdkFBDc9SvLONNk4ENmBhQmAi3/OK
         bnKw==
X-Gm-Message-State: AOJu0YxX8SWo3vqC2bhXXcC2vlBOgbQw/8XMWmXv1w1cbkn4v/plt8In
	sqqIbQiWsxfW7by2eEFmaqucWL7KowIeuZ+ALSRgoBsNXFEW79bA0U9Ia6iy1huEpORG8ItltFg
	2fzpeBYH/eGHu1lc6NmAZo0mA0neIZwW0s9IU
X-Google-Smtp-Source: AGHT+IF12rbfL8TOIJ0HDhaqilt6mbaa7v2N4rzIxpg3j24NEHjtdi/ZfxLSa7XLF+Lodwinj51NnGW41It7+CXEWz0=
X-Received: by 2002:a05:6402:1e94:b0:571:b9c7:2804 with SMTP id
 f20-20020a0564021e9400b00571b9c72804mr193531edf.5.1713540100184; Fri, 19 Apr
 2024 08:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <VI1PR01MB42407D7947B2EA448F1E04EFD10D2@VI1PR01MB4240.eurprd01.prod.exchangelabs.com>
In-Reply-To: <VI1PR01MB42407D7947B2EA448F1E04EFD10D2@VI1PR01MB4240.eurprd01.prod.exchangelabs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Apr 2024 17:21:26 +0200
Message-ID: <CANn89iLO_xpjAacnMB2H4ozPHnNfGO9_OhB87A_3mgQEYP+81A@mail.gmail.com>
Subject: Re: [REGRESSION] sk_memory_allocated counter leaking on aarch64
To: Jonathan Heathcote <jonathan.heathcote@bbc.co.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 4:46=E2=80=AFPM Jonathan Heathcote
<jonathan.heathcote@bbc.co.uk> wrote:
>
> Since Linux 6.0.0-rc1 (including v6.8.7), there appears to be a leak in
> the counter used to monitor TCP memory consumption which leads to
> spurious memory pressure and, eventually, unrecoverable OOM behaviour on
> aarch64.
>
> I am running an nginx web server on aarch64 which is running a media CDN
> style workload at ~350 GBit/s over ~100k HTTPS sessions. Over the course
> of a few hours, the memory reported as consumed by TCP in
> /proc/net/sockstat grows steadily until eventually hitting the hard
> limit configured in /proc/sys/net/ipv4/tcp_mem (see plot [0] -- the
> slight knee at about 18:25 coincides with the memory pressure threshold
> being reached).
>
> [0] https://www.dropbox.com/scl/fi/xsh8a2of9pluj5hspc41p/oom.png?rlkey=3D=
7dzfx36z5tnkf5wlqulzqufdl&st=3Dyk887z0e&dl=3D1
>
> If the load is removed (all connections cleanly closed and nginx shut
> down) the reported memory consumption does not reduce. Plot [1] shows a
> test where all connections are closed and nginx terminated around 10:22
> without memory reducing to levels seen before the test. A reboot appears
> necessary to bring the counter back to zero.
>
> [1] https://www.dropbox.com/scl/fi/36ainpx7mbwe5q3o2zfry/nrz.png?rlkey=3D=
01a2bw2lyj9dih9fwws81tchi&st=3D83aqxzwj&dl=3D1
>
> (NB: All plots show the reported memory in bytes rather than pages.
> Initial peaks coincide with the initial opening of tens of thousands
> of connections.)
>
> Prior to Linux v6.0.0-rc1, this issue does not occur. Plot [2] shows a
> similar test running on v5.19.17. No unbounded growth in memory
> consumption is observed and usage drops back to zero when all
> connections are closed at 15:10.
>
> [2] https://www.dropbox.com/scl/fi/dz2nqs8p6ogl7yqwn8cmw/expected.png?rlk=
ey=3Dco77565mr4tq4pvvimtju1xnx&st=3Dzu9j2id7&dl=3D1
>
> After some investigation, I noticed that the memory reported as consumed
> did not match system memory usage. Following the implementation of
> /proc/net/sockstat to the underlying counter, sk_memory_allocated, I put
> together a crude bpftrace [3] script to monitor the places where this
> counter is updated in the TCP implementation and implement my own count.
> The bpftrace based counts can be seen to diverge from the value reported
> by /proc/net/sockstat in plot [4] suggesting that the 'leak' might be an
> intermittent failure to update the counter.
>
> [3] https://www.dropbox.com/scl/fi/17cgytnte3odh3ovo9psw/counts.bt?rlkey=
=3Dry90zdyk0qwrhdf4xnzhkfevq&st=3Dbj9jmovt&dl=3D1
> [4] https://www.dropbox.com/scl/fi/ynlvbooqvz9e38emsd9n7/bpftrace.png?rlk=
ey=3Ddae6s68lekct1605z9vq7h7an&st=3Dykmeb4du&dl=3D1
>
> After a bit of manual looking around, I've come to suspect suspect that
> commit 3cd3399 (which introduces the use of per-CPU counters with
> intermittent updating of the system counter) might be at least some way
> relevant to this regression. Manually reverting this change in 6.x
> kernels appears to fix the issue in any case.
>
> Unfortunately whilst I have binary-searched the kernel releases to find
> the regressing release, I have not had the time to bisect between 5.19
> and 6.0. As such, I cannot confirm that the commit above was
> definitively the source of the regression, only that undoing it appears
> to fix it! My apologies if this proves a red-herring!
>
> For completeness, a more thorough description of the system under test
> is given below:
>
> * CPU: Ampere Altra Max M128-30 (128 64 bit ARM cores)
> * Distribution: Rocky Linux 9
> * Linux kernel: (compiled from kernel.org sources)
>   * Exhibits bug:
>     * 6.8.7 (latest release at time of writing)
>     * ... and a few others tested inbetween ...
>     * 6.0.0-rc1 (first release containing bug)
>   * Does not exhibit bug:
>     * 5.19.17 (latest version not to exhibit bug)
>     * ... and a few others back to 5.14.0 ...
> * Linux kernel config consists of the config from Rocky Linux 9
>   configured to use 64kb pages. Specifically, I'm using the config from
>   the kernel-64k package version 5.14.0-284.30.1.el9_2.aarch64+64k,
>   updated as necessary for building newer kernels using `make
>   olddefconfig`. The resulting configuration used for v6.8.7 can be
>   found here: [5].
> * Workload: nginx 1.20.1 serving an in-RAM dataset to ~100k synthetic
>   HTTPS clients at ~350 GBit/s. (Non-hardware accelerated) kTLS is used.
>
> [5] https://www.dropbox.com/scl/fi/x0t2jufmnlcul9vbvn48p/config-6.8.7?rlk=
ey=3Dhwu0al2p6k7f92o1ks40deci9&st=3D9ol3cc45&dl=3D1
>
> I have also spotted an Ubuntu/AWS bug report [6] in which another person
> seems to be running into (what might be) this bug in a different
> environment and distribution. The symptoms there are very similar:
> aarch64, high connection count server workload, memory not reclaimed on
> connections closing, fixed by migrating from a 6.x kernel to a 5.x
> kernel. I'm mentioning here in case that report adds any useful
> information.
>
> [6] https://bugs.launchpad.net/ubuntu/+source/linux-signed-aws-6.2/+bug/2=
045560
>
> Thanks very much for your help!
>
> Jonathan Heathcote
>
> #regzbot introduced: v5.19.17..v6.0.0-rc1

Ouch.

Hi Jonathan, thanks a lot for this detailed and awesome report !

Could you try the following patch ?

Thanks again !

diff --git a/include/net/sock.h b/include/net/sock.h
index f57bfd8a2ad2deaedf3f351325ab9336ae040504..1811c51d180d2de8bf8fc45e06c=
aa073b429f524
100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1416,9 +1416,9 @@ sk_memory_allocated_add(struct sock *sk, int amt)
        int local_reserve;

        preempt_disable();
-       local_reserve =3D
__this_cpu_add_return(*sk->sk_prot->per_cpu_fw_alloc, amt);
+       local_reserve =3D
this_cpu_add_return(*sk->sk_prot->per_cpu_fw_alloc, amt);
        if (local_reserve >=3D READ_ONCE(sysctl_mem_pcpu_rsv)) {
-               __this_cpu_sub(*sk->sk_prot->per_cpu_fw_alloc, local_reserv=
e);
+               local_reserve =3D
this_cpu_xchg(*sk->sk_prot->per_cpu_fw_alloc, 0);
                atomic_long_add(local_reserve, sk->sk_prot->memory_allocate=
d);
        }
        preempt_enable();
@@ -1430,9 +1430,9 @@ sk_memory_allocated_sub(struct sock *sk, int amt)
        int local_reserve;

        preempt_disable();
-       local_reserve =3D
__this_cpu_sub_return(*sk->sk_prot->per_cpu_fw_alloc, amt);
+       local_reserve =3D
this_cpu_sub_return(*sk->sk_prot->per_cpu_fw_alloc, amt);
        if (local_reserve <=3D -READ_ONCE(sysctl_mem_pcpu_rsv)) {
-               __this_cpu_sub(*sk->sk_prot->per_cpu_fw_alloc, local_reserv=
e);
+               local_reserve =3D
this_cpu_xchg(*sk->sk_prot->per_cpu_fw_alloc, 0);
                atomic_long_add(local_reserve, sk->sk_prot->memory_allocate=
d);
        }
        preempt_enable();

