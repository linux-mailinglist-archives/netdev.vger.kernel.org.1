Return-Path: <netdev+bounces-150730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E6F9EB587
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 16:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6343B283171
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9A222FE04;
	Tue, 10 Dec 2024 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E43od2uu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129211BD4E5;
	Tue, 10 Dec 2024 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733846368; cv=none; b=HcDaE3mGm8+d8oFNaYd9/2CQI+QtkJ9rnnVTX0KZf3Cec1IphHUi/nazcL+nH2ttaqOIDTEz0ySE2DYgy+fjgFQJ1nYsdChewuSB6veHKUaHoo4VEMQeh7mMu5I8qP/Nw1VMX4mW2tLD683J/nPdj53cz3rdzS/3RATGLwtr4og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733846368; c=relaxed/simple;
	bh=6ap0bV+n7MBus+F2Ud2aD/1Nj0zSNnX+OxhYs144CGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kneAf8xPqMj3ZbKUycXgc+2o+OrXB+iCANB2RGfIhRxFkp7j3XjdcVyEo3E0LBRyMtWPHGQ3YKtBmxzQnfU5d9fynKZ2OM4JcsSZcBJ3btTRoIoDAlCbsmqymffGFE//+GoHY3mIFFR88WWFkkSGQXDD1+FnbyDJh6ebd9wn3oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E43od2uu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434f80457a4so13605965e9.0;
        Tue, 10 Dec 2024 07:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733846365; x=1734451165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wubk0prrUfZcPCKTjSsxQklCZ6pNG/rGo93+uqQj5JM=;
        b=E43od2uuGyNNBAq3/1I8gvHwCH60x5TiyZlEg6FptV2tM5a4Shf7TrGgf88SOPeaAc
         7PMQQNzB6uwPugtBiZwTg0fmLL+S4ZFpF2El6Lju7z4LA6VzPWgEpUKfGpPcyPjPQxOX
         X8bqsaiTAK2SHytiy4eGxbvyEX6CVdSic2fynkxbTe51TdDpEgKzDsRgfTt9YFSMfUEx
         ekHi4/2bzLordRXO1x+nirxpOuTh1E00UbuirJjKLk9uSGP2fZePaNkHVEzn1hpXDDBZ
         yt1ghWFsWgMUkW1zenZw+UUjQG3jjBTIzAaLumBGrYn1dwZsdQjM3WHE++3RT6MQkOe2
         cSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733846365; x=1734451165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wubk0prrUfZcPCKTjSsxQklCZ6pNG/rGo93+uqQj5JM=;
        b=FeQhUFIkwzZ+qR/HJuTDPaJ/r4ceIkj6erH8odyH6dgqzTr/BOCKbxgfRp5OqPbaG4
         m8/MpXb4FMNMZDTjWmcXFkJoaNXmZeapMWUxrcDYtdW7EJklXFQA++j/CPFD54QkOImW
         KVO7kjR99yv07/FQxz7HG/Gx0UGW5tCBgmHAtkcHz2OyEZktVZu3SKiP0BAgTJZDEV94
         bi9ptsTrAcju+sw/sxma8TRh4D6gDRB+uJC8sRldGeDOXjjgCpExXyOqF9MUc3hvygqw
         4e2q73eFlUFSUzuE/BvTEo4EUO5zr41Dc6nHOs/KI1rQv9E2xj4fMotA1bc0e7nXSeSM
         2ENw==
X-Forwarded-Encrypted: i=1; AJvYcCU+eaCq2AAL7cHK5GUp9DR6A7WGosKhbkCrEyMMFQLcYXz6+Fk/8IKrAjiv484FTFMoV8pL21wpnLdoL9A=@vger.kernel.org, AJvYcCWwbaQ9JohiyZKNclPJhMlLMUJUnJsDpBu7o8rjS9DqTfpK+YnLNAWaWn3ZqD2+/YGu7aMnNIsa@vger.kernel.org
X-Gm-Message-State: AOJu0YwwySjkYge3IMClNzUwuSUWS2yc8J8FMiO6jSZ1rqa7B1O+L+45
	yY/4EEQN8j1M9ccrcKQJKJPHHHaA88sPZ2s+z8p29d1tLk+NhRS5Vf+sKYMGaCT1z8ABJCuIp3y
	toXoShZdl6vD/7KLlESnk9Ij9PGMznA==
X-Gm-Gg: ASbGncu/7UF4MyQp90SKPgwkSAT3BjeFAiVwXXByVzUzXz4t7GCdzJ+gEng4qZUkdYj
	1ad1kLqDLYW+ZyE/wINyI7J7rW3KTOyXCXhJ/954eXoYuX+d2XXmhJy1jdl68aqfVFHOU
X-Google-Smtp-Source: AGHT+IEbRhG2/j/Qp5k/ecinTGRv5hY7zq64U1QHe6qQjpYUtAkrPBxMf5QU4PUu3agLMhJi6tRPf9V8cdr8WoRSw4E=
X-Received: by 2002:a05:600c:4a13:b0:436:17a6:32ee with SMTP id
 5b1f17b1804b1-43617a634b1mr17927285e9.10.1733846365108; Tue, 10 Dec 2024
 07:59:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206122533.3589947-1-linyunsheng@huawei.com>
 <CAKgT0UeXcsB-HOyeA7kYKHmEUM+d_mbTQJRhXfaiFBg_HcWV0w@mail.gmail.com>
 <3de1b8a3-ae4f-492f-969d-bc6f2c145d09@huawei.com> <CAKgT0Uc5A_mtN_qxR6w5zqDbx87SUdCTFOBxVWCarnryRvhqHA@mail.gmail.com>
 <15723762-7800-4498-845e-7383a88f147b@huawei.com>
In-Reply-To: <15723762-7800-4498-845e-7383a88f147b@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 10 Dec 2024 07:58:48 -0800
Message-ID: <CAKgT0Uf7V+wMa7zz+9j9gwHC+hia3OwL_bo_O-yhn4=Xh0WadA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/10] Replace page_frag with page_frag_cache (Part-2)
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 4:27=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/12/10 0:03, Alexander Duyck wrote:
>
> ...
>
> >
> > Other than code size have you tried using perf to profile the
> > benchmark before and after. I suspect that would be telling about
> > which code changes are the most likely to be causing the issues.
> > Overall I don't think the size has increased all that much. I suspect
> > most of this is the fact that you are inlining more of the
> > functionality.
>
> It seems the testing result is very sensitive to code changing and
> reorganizing, as using the patch at the end to avoid the problem of
> 'perf stat' not including data from the kernel thread seems to provide
> more reasonable performance data.
>
> It seems the most obvious difference is 'insn per cycle' and I am not
> sure how to interpret the difference of below data for the performance
> degradation yet.
>
> With patch 1:
>  Performance counter stats for 'taskset -c 0 insmod ./page_frag_test.ko t=
est_push_cpu=3D-1 test_pop_cpu=3D1 test_alloc_len=3D12 nr_test=3D51200000':
>
>        5473.815250      task-clock (msec)         #    0.984 CPUs utilize=
d
>                 18      context-switches          #    0.003 K/sec
>                  1      cpu-migrations            #    0.000 K/sec
>                122      page-faults               #    0.022 K/sec
>        14210894727      cycles                    #    2.596 GHz         =
             (92.78%)
>        18903171767      instructions              #    1.33  insn per cyc=
le           (92.82%)
>         2997494420      branches                  #  547.606 M/sec       =
             (92.84%)
>            7539978      branch-misses             #    0.25% of all branc=
hes          (92.84%)
>         6291190031      L1-dcache-loads           # 1149.325 M/sec       =
             (92.78%)
>           29874701      L1-dcache-load-misses     #    0.47% of all L1-dc=
ache hits    (92.82%)
>           57979668      LLC-loads                 #   10.592 M/sec       =
             (92.79%)
>             347822      LLC-load-misses           #    0.01% of all LL-ca=
che hits     (92.90%)
>         5946042629      L1-icache-loads           # 1086.270 M/sec       =
             (92.91%)
>             193877      L1-icache-load-misses                            =
             (92.91%)
>         6820220221      dTLB-loads                # 1245.972 M/sec       =
             (92.91%)
>             137999      dTLB-load-misses          #    0.00% of all dTLB =
cache hits   (92.91%)
>         5947607438      iTLB-loads                # 1086.556 M/sec       =
             (92.91%)
>                210      iTLB-load-misses          #    0.00% of all iTLB =
cache hits   (85.66%)
>    <not supported>      L1-dcache-prefetches
>    <not supported>      L1-dcache-prefetch-misses
>
>        5.563068950 seconds time elapsed
>
> Without patch 1:
> root@(none):/home# perf stat -d -d -d taskset -c 0 insmod ./page_frag_tes=
t.ko test_push_cpu=3D-1 test_pop_cpu=3D1 test_alloc_len=3D12 nr_test=3D5120=
0000
> insmod: can't insert './page_frag_test.ko': Resource temporarily unavaila=
ble
>
>  Performance counter stats for 'taskset -c 0 insmod ./page_frag_test.ko t=
est_push_cpu=3D-1 test_pop_cpu=3D1 test_alloc_len=3D12 nr_test=3D51200000':
>
>        5306.644600      task-clock (msec)         #    0.984 CPUs utilize=
d
>                 15      context-switches          #    0.003 K/sec
>                  1      cpu-migrations            #    0.000 K/sec
>                122      page-faults               #    0.023 K/sec
>        13776872322      cycles                    #    2.596 GHz         =
             (92.84%)
>        13257649773      instructions              #    0.96  insn per cyc=
le           (92.82%)
>         2446901087      branches                  #  461.101 M/sec       =
             (92.91%)
>            7172751      branch-misses             #    0.29% of all branc=
hes          (92.84%)
>         5041456343      L1-dcache-loads           #  950.027 M/sec       =
             (92.84%)
>           38418414      L1-dcache-load-misses     #    0.76% of all L1-dc=
ache hits    (92.76%)
>           65486400      LLC-loads                 #   12.340 M/sec       =
             (92.82%)
>             191497      LLC-load-misses           #    0.01% of all LL-ca=
che hits     (92.79%)
>         4906456833      L1-icache-loads           #  924.587 M/sec       =
             (92.90%)
>             175208      L1-icache-load-misses                            =
             (92.91%)
>         5539879607      dTLB-loads                # 1043.952 M/sec       =
             (92.91%)
>             140166      dTLB-load-misses          #    0.00% of all dTLB =
cache hits   (92.91%)
>         4906685698      iTLB-loads                #  924.631 M/sec       =
             (92.91%)
>                170      iTLB-load-misses          #    0.00% of all iTLB =
cache hits   (85.66%)
>    <not supported>      L1-dcache-prefetches
>    <not supported>      L1-dcache-prefetch-misses
>
>        5.395104330 seconds time elapsed
>
>
> Below is perf data for aligned API without patch 1, as above non-aligned
> API also use test_alloc_len as 12, theoretically the performance data
> should not be better than the non-aligned API as the aligned API will do
> the aligning of fragsz basing on SMP_CACHE_BYTES, but the testing seems
> to show otherwise and I am not sure how to interpret that too:
> perf stat -d -d -d taskset -c 0 insmod ./page_frag_test.ko test_push_cpu=
=3D-1 test_pop_cpu=3D1 test_alloc_len=3D12 nr_test=3D51200000 test_align=3D=
1
> insmod: can't insert './page_frag_test.ko': Resource temporarily unavaila=
ble
>
>  Performance counter stats for 'taskset -c 0 insmod ./page_frag_test.ko t=
est_push_cpu=3D-1 test_pop_cpu=3D1 test_alloc_len=3D12 nr_test=3D51200000 t=
est_align=3D1':
>
>        2447.553100      task-clock (msec)         #    0.965 CPUs utilize=
d
>                  9      context-switches          #    0.004 K/sec
>                  1      cpu-migrations            #    0.000 K/sec
>                122      page-faults               #    0.050 K/sec
>         6354149177      cycles                    #    2.596 GHz         =
             (92.81%)
>         6467793726      instructions              #    1.02  insn per cyc=
le           (92.76%)
>         1120749183      branches                  #  457.906 M/sec       =
             (92.81%)
>            7370402      branch-misses             #    0.66% of all branc=
hes          (92.81%)
>         2847963759      L1-dcache-loads           # 1163.596 M/sec       =
             (92.76%)
>           39439592      L1-dcache-load-misses     #    1.38% of all L1-dc=
ache hits    (92.77%)
>           42553468      LLC-loads                 #   17.386 M/sec       =
             (92.71%)
>              95960      LLC-load-misses           #    0.01% of all LL-ca=
che hits     (92.94%)
>         2554887203      L1-icache-loads           # 1043.854 M/sec       =
             (92.97%)
>             118902      L1-icache-load-misses                            =
             (92.97%)
>         3365755289      dTLB-loads                # 1375.151 M/sec       =
             (92.97%)
>              81401      dTLB-load-misses          #    0.00% of all dTLB =
cache hits   (92.97%)
>         2554882937      iTLB-loads                # 1043.852 M/sec       =
             (92.97%)
>                159      iTLB-load-misses          #    0.00% of all iTLB =
cache hits   (85.58%)
>    <not supported>      L1-dcache-prefetches
>    <not supported>      L1-dcache-prefetch-misses
>
>        2.535085780 seconds time elapsed

I'm not sure perf stat will tell us much as it is really too high
level to give us much in the way of details. I would be more
interested in the output from perf record -g followed by a perf
report, or maybe even just a snapshot from perf top while the test is
running. That should show us where the CPU is spending most of its
time and what areas are hot in the before and after graphs.

