Return-Path: <netdev+bounces-172335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E10BBA5440E
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 08:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833681894FD2
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 07:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23229201270;
	Thu,  6 Mar 2025 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtCl2m2L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706C11F2C56
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741247692; cv=none; b=c2JRMFeNT7ZAjAXqcgRf9i5ZnLz+VUh8pYr50BTix67ayR9nreL+D6mUC0SBzY4Q5o70J0l94jPSJ3fPQ+GnaxsUgKEr+RbT92TF+e6dg15abtjat0YaumIlUUtTJbY6OqcR0y5lqalOnG/xt2WdBD1MXOzWKzyYSQMMTsaxda8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741247692; c=relaxed/simple;
	bh=yE7lXQjwlPMwX2ilrSc3nNJxU+XKmpMpvDxEbfmY/38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkwcfPGDHD6fx9k0EU0t0B+EtESInJMLWcNv1HFaGd3FD5tak6HPVzYVpLTzvPB47h3L7v4XXmzp86HVrO4RwPsn8rh4wy7YoKitkhQtv+ieYVvj1DjGqWHSPyIGBPgz70MKnd0ULw3vlw9eR36DVwL6OoDcXIowmwARgXLU5yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtCl2m2L; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d3e25323cfso3192295ab.3
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 23:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741247689; x=1741852489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsiFPjgJEEqmT9jsMBtvFa+R9P2U96nrRVtN2opkR38=;
        b=RtCl2m2LhQ2y1Sp2Cq5WN5w8P+OxXrkF9aCwWb69O0DPSm615jxYOGhgO6yv6PGDFO
         1qzS6QuG4aTZF1wt3l19ZCCm+vQlHdlfbwevoyOMRvqtzWDorDlMn2OT5uvI+Y6b1UhM
         5uTqBdNBD54SQ4eXzPEaUJ4155bDTfjA5WFwXdHSm1ahh5gSOrv5705i+RcZIvnsd1ci
         1g0E6Y9PLFHFbpHRbvIo6d228WQV/Zk+N5NqmP9lxElrmnm+e2pnHcxGVj8KT2HEMP4G
         BvoJ+tT65kP/phGdjhYzJ1wCDOni4xPJpfqM1t/AdD9pDX7ziXTdiBJ1KhV+hOCwipZd
         laCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741247689; x=1741852489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsiFPjgJEEqmT9jsMBtvFa+R9P2U96nrRVtN2opkR38=;
        b=u76El0bwVyobvVa++4XUWN2QSYNZV+YJuhqbgajuY9+GGmvWYiBNWGZV9ukKoZYnFH
         XWcJ77zr+PtoGGag0CYedzSU71T78i6lW/O6KaPY+4bmIROM57fiGBL/Jdmgn80VIUVo
         fSsBkuzFpD+v8Q64i39xlx/GqpeASm3ZcfNMpxP92I3EaHtGLJIUQNq7dcoFrFLlqRMr
         u3ULrfV8hdI7VIFKtJkZM5clMhUeEDFypta8VWuXjPHh+X/7md/JlXOjFX7JqIXNglr+
         BNipf6wkBcixOmJChkS7KhNZ4Isl0fzBSfR+RR0ySCtZDicjxPIHz3J++CLya35DV2K5
         U0wg==
X-Forwarded-Encrypted: i=1; AJvYcCXHIofy/AvXID+OJeNA7LeXLDuhutk3l1VlkEc6FbENsfu0NydnwdF6klv44ZFP69nHpL2KFFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuHeboePPgpoH4uZ2fbeenMewR/g5NO7dpPSmhIXAPjaeKTDrP
	V2QjFjE+TLfSREKl9lm2tVf8wzvL/6RX5ATh07W4c5m+DXVI1DVIgBibR/mtlWzlUQ8227vsTKu
	p26LmBffKyCEKEOLnJjp4BLVjP8g=
X-Gm-Gg: ASbGncue+FK/QLvW7olwKchYHfySKz1S/No/2JZYXfOPTnqnrFNdmt303xEVwKNzv6R
	cJCF6SoSrVJIC0Ll/NqlFbMQ9AQIUkQPFQK7wesRRN13gk+inRPIs+LpAkCZ7y7bcPu69FNJ9lK
	WzjFxWZzfZS3OzS6f8WjXUL2W4sQ==
X-Google-Smtp-Source: AGHT+IF4lQTTyTodZVQFTe9da2YDiFKn2ybMx0/nwAKoXfQ3ZOsFVMYh3x//e+GELKvGuMBQMj+y0T9CHMiIcVgHrEA=
X-Received: by 2002:a92:cd8a:0:b0:3d0:1fc4:edf0 with SMTP id
 e9e14a558f8ab-3d42b97bc11mr86180005ab.15.1741247689400; Wed, 05 Mar 2025
 23:54:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305034550.879255-1-edumazet@google.com> <20250305034550.879255-2-edumazet@google.com>
In-Reply-To: <20250305034550.879255-2-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Mar 2025 15:54:13 +0800
X-Gm-Features: AQ5f1Jq2ksERV3TQlpHm4FvBrs26IG1u01rYEtLdNRZ3wOnM6LcwG318iAI8ap0
Message-ID: <CAL+tcoAzeBGpv53cXdm7s_3C63fMR8vkeLyCReSbnSNuf6pWcg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] inet: change lport contribution to
 inet_ehashfn() and inet6_ehashfn()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing <kernelxing@tencent.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 11:46=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> In order to speedup __inet_hash_connect(), we want to ensure hash values
> for <source address, port X, destination address, destination port>
> are not randomly spread, but monotonically increasing.
>
> Goal is to allow __inet_hash_connect() to derive the hash value
> of a candidate 4-tuple with a single addition in the following
> patch in the series.
>
> Given :
>   hash_0 =3D inet_ehashfn(saddr, 0, daddr, dport)
>   hash_sport =3D inet_ehashfn(saddr, sport, daddr, dport)
>
> Then (hash_sport =3D=3D hash_0 + sport) for all sport values.
>
> As far as I know, there is no security implication with this change.

Good to know this. The moment I read the first paragraph, I was
thinking if it might bring potential risk.

Sorry that I hesitate to bring up one question: could this new
algorithm result in sockets concentrating into several buckets instead
of being sufficiently dispersed like before. Well good news is that I
tested other cases like TCP_CRR and saw no degradation in performance.
But they didn't cover establishing from one client to many different
servers cases.

>
> After this patch, when __inet_hash_connect() has to try XXXX candidates,
> the hash table buckets are contiguous and packed, allowing
> a better use of cpu caches and hardware prefetchers.
>
> Tested:
>
> Server: ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog
> Client: ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog -c -H s=
erver
>
> Before this patch:
>
>   utime_start=3D0.271607
>   utime_end=3D3.847111
>   stime_start=3D18.407684
>   stime_end=3D1997.485557
>   num_transactions=3D1350742
>   latency_min=3D0.014131929
>   latency_max=3D17.895073144
>   latency_mean=3D0.505675853
>   latency_stddev=3D2.125164772
>   num_samples=3D307884
>   throughput=3D139866.80
>
> perf top on client:
>
>  56.86%  [kernel]       [k] __inet6_check_established
>  17.96%  [kernel]       [k] __inet_hash_connect
>  13.88%  [kernel]       [k] inet6_ehashfn
>   2.52%  [kernel]       [k] rcu_all_qs
>   2.01%  [kernel]       [k] __cond_resched
>   0.41%  [kernel]       [k] _raw_spin_lock
>
> After this patch:
>
>   utime_start=3D0.286131
>   utime_end=3D4.378886
>   stime_start=3D11.952556
>   stime_end=3D1991.655533
>   num_transactions=3D1446830
>   latency_min=3D0.001061085
>   latency_max=3D12.075275028
>   latency_mean=3D0.376375302
>   latency_stddev=3D1.361969596
>   num_samples=3D306383
>   throughput=3D151866.56
>
> perf top:
>
>  50.01%  [kernel]       [k] __inet6_check_established
>  20.65%  [kernel]       [k] __inet_hash_connect
>  15.81%  [kernel]       [k] inet6_ehashfn
>   2.92%  [kernel]       [k] rcu_all_qs
>   2.34%  [kernel]       [k] __cond_resched
>   0.50%  [kernel]       [k] _raw_spin_lock
>   0.34%  [kernel]       [k] sched_balance_trigger
>   0.24%  [kernel]       [k] queued_spin_lock_slowpath
>
> There is indeed an increase of throughput and reduction of latency.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Tested-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Throughput goes from 12829 to 26072.. The percentage increase - 103% -
is alluring to me!

Thanks,
Jason

