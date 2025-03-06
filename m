Return-Path: <netdev+bounces-172345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E67F1A5448B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071C516B67A
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 08:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1261FCFE2;
	Thu,  6 Mar 2025 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecLVqboC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FD01FBEB1
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249192; cv=none; b=jUQjsZzqAE39t5q6IDogrHIkwJuh5PoeTyjRuEgLO9sqZ5EcLEWNGQet3AtsJ/kF/5e7DYya644rxF7w6pvWeI/dzwLh3nva5z/LEbUaXGFuErunlxs+/IdimIN9H5q9+yaK1mgGr0/LIqnvGbaWv6L8GqHMlCWeyjKk0AeGPTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249192; c=relaxed/simple;
	bh=9W3AU/dNsDB6L5vEie+ANoC31wnwyUPXsmhy3hT6+Fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRGu9IbHwN8TvYJ5ox5Y0eZsGng9nT/CMX/DcW717xDGYKTEyn8hEhXIMxuxLVEsxrG6hvB4jgj3r3M0+VzwxIEyu13b/0E5SGy8AzxEP0o0W1VPGT6pNAB3sb/UWlyoTtbY41rYtnSbwXq+kAa9vDs67Zy5QsA4pBXk2ccXmZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecLVqboC; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3cfc8772469so1316095ab.3
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 00:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741249190; x=1741853990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MAoTekFRytv8K8d2Axqqf6mEH29hUgz/VkOQlssyv0=;
        b=ecLVqboC2eNXgnM1C2bhTsKTFGWi79aX3lQBPxVrm+oHN7anD3Tnq4AcSwpysT/Ag/
         +lloMqMHy7XUGN0jGT1jdb4GqkgXmbDh2q4NMDAhlz4QHATRpTRT6ji/FWJ+k7v5gIXt
         VXNGHm2yk8lW2kgolUs/Oop5n1npJcRysDvL2E2dn9H1bWiFPOIWnT9MkUFIMEvC0ijL
         W8gEOPtPTeHmDBnhwADqp4MwK3Y19AP2ObF2NdHZNPd+tdzZ5nULSpyY8vxMCJf95GuY
         hEcr98B3fmoF5Kx9vcrPJrrCzwS3a7M5N5k6HxAOFgIXExogw1wFoJylzOQ8ZfOLNISB
         kjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741249190; x=1741853990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0MAoTekFRytv8K8d2Axqqf6mEH29hUgz/VkOQlssyv0=;
        b=vVcvWAS+fyG3UoazkUM21vP0EXa16UwfaedlbeEgA4s0bF3YGbMw8IhBJ+aeSwzA5b
         aHYxv+Lo9AsnbI9CnwxC9rVDke9DWvTIxa1vmzRJKzZx/hS8/IXaial6yp3u+yRSnGii
         R/UV2n5jmAiZwiRjo6p62E9NPmOoRuoubNl6tra8Bjm9B083ERJRvpjEapmBlnSCoYbP
         SpXYeoygCC6yaDlpu4gZVEGOCVIsMnvl4O+6QtuNmX7r/jFXm15C7/RE8KRL9Gqb73mz
         9/jxqBeffPvZlJUVMfT7/xdNRC+kQ60fs5SnLgaNLmW01e4UhvpS7y3SAJIo+21CTerJ
         iqdA==
X-Forwarded-Encrypted: i=1; AJvYcCVSXwpHspp/Qz7d5p59W5oZSrzqWHdg+BqDiECfewT88xE23SJBctenn/VrnuUodF8UvRcvOls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJAPBJYe/1d2FA6DZyLBbTaRfQhHgxxo44/QGzvneE3HWlxvke
	9pp9m53qH2oPFlOIzy/+3e3YGESomDO2sS19WZtrG8qVhoX6m7Ul7nHwgnGQZTeYgctlAHy9G19
	ZwPym8bOub+rx5Zf+D8e8BwtV0oexy3AT
X-Gm-Gg: ASbGncuTvvx3K/X6FryJyZOs9fHOi6C4U4PWDxi+ZBJkaaYF0eU5RLEeUBEoT348/4k
	rlwZiWig75Y/e5VKc9CG3bzFo9WQWpKSNqnfSfOw6QLDrOESMiTTliqNLn15+Z2CXSdYfe+G9iv
	6oOYjAFDU3rxpYTmLngrYr5xm8qw==
X-Google-Smtp-Source: AGHT+IEcJUtQ7n0JueRXmCjioncdVznfbGNj+ZLWGnEa6f7tVTkMP9Ezqpxdk6fAPEfgc+4vhDc65NcLk9vb3E7k0rI=
X-Received: by 2002:a05:6e02:1526:b0:3d3:dece:3dab with SMTP id
 e9e14a558f8ab-3d42b87cf0bmr70484545ab.1.1741249189774; Thu, 06 Mar 2025
 00:19:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305034550.879255-1-edumazet@google.com> <20250305034550.879255-2-edumazet@google.com>
 <CAL+tcoAzeBGpv53cXdm7s_3C63fMR8vkeLyCReSbnSNuf6pWcg@mail.gmail.com> <CANn89iKLgA_BhiXik2_Xq4HMmA4vnU3JHC8CEsaH6dvD9QK_ng@mail.gmail.com>
In-Reply-To: <CANn89iKLgA_BhiXik2_Xq4HMmA4vnU3JHC8CEsaH6dvD9QK_ng@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Mar 2025 16:19:13 +0800
X-Gm-Features: AQ5f1Joy8C8IW65KSNVTK2ZQkZ-O8btlInmpez_HRM9v-rlJzpJPum-kHo3r5Ak
Message-ID: <CAL+tcoC8qW_N62U9z+eQWsDwQ-w6f9Voy87E2a5MJC5C71fSYA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] inet: change lport contribution to
 inet_ehashfn() and inet6_ehashfn()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing <kernelxing@tencent.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 4:14=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, Mar 6, 2025 at 8:54=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > On Wed, Mar 5, 2025 at 11:46=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > In order to speedup __inet_hash_connect(), we want to ensure hash val=
ues
> > > for <source address, port X, destination address, destination port>
> > > are not randomly spread, but monotonically increasing.
> > >
> > > Goal is to allow __inet_hash_connect() to derive the hash value
> > > of a candidate 4-tuple with a single addition in the following
> > > patch in the series.
> > >
> > > Given :
> > >   hash_0 =3D inet_ehashfn(saddr, 0, daddr, dport)
> > >   hash_sport =3D inet_ehashfn(saddr, sport, daddr, dport)
> > >
> > > Then (hash_sport =3D=3D hash_0 + sport) for all sport values.
> > >
> > > As far as I know, there is no security implication with this change.
> >
> > Good to know this. The moment I read the first paragraph, I was
> > thinking if it might bring potential risk.
> >
> > Sorry that I hesitate to bring up one question: could this new
> > algorithm result in sockets concentrating into several buckets instead
> > of being sufficiently dispersed like before.
>
> As I said, I see no difference for servers, since their sport is a fixed =
value.
>
> What matters for them is the hash contribution of the remote address and =
port,
> because the server port is usually well known.
>
> This change does not change the hash distribution, an attacker will not b=
e able
> to target a particular bucket.

Point taken. Thank you very much for the explanation.

Thanks,
Jason

>
> > Well good news is that I
> > tested other cases like TCP_CRR and saw no degradation in performance.
> > But they didn't cover establishing from one client to many different
> > servers cases.
> >
> > >
> > > After this patch, when __inet_hash_connect() has to try XXXX candidat=
es,
> > > the hash table buckets are contiguous and packed, allowing
> > > a better use of cpu caches and hardware prefetchers.
> > >
> > > Tested:
> > >
> > > Server: ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog
> > > Client: ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog -c =
-H server
> > >
> > > Before this patch:
> > >
> > >   utime_start=3D0.271607
> > >   utime_end=3D3.847111
> > >   stime_start=3D18.407684
> > >   stime_end=3D1997.485557
> > >   num_transactions=3D1350742
> > >   latency_min=3D0.014131929
> > >   latency_max=3D17.895073144
> > >   latency_mean=3D0.505675853
> > >   latency_stddev=3D2.125164772
> > >   num_samples=3D307884
> > >   throughput=3D139866.80
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
> > > After this patch:
> > >
> > >   utime_start=3D0.286131
> > >   utime_end=3D4.378886
> > >   stime_start=3D11.952556
> > >   stime_end=3D1991.655533
> > >   num_transactions=3D1446830
> > >   latency_min=3D0.001061085
> > >   latency_max=3D12.075275028
> > >   latency_mean=3D0.376375302
> > >   latency_stddev=3D1.361969596
> > >   num_samples=3D306383
> > >   throughput=3D151866.56
> > >
> > > perf top:
> > >
> > >  50.01%  [kernel]       [k] __inet6_check_established
> > >  20.65%  [kernel]       [k] __inet_hash_connect
> > >  15.81%  [kernel]       [k] inet6_ehashfn
> > >   2.92%  [kernel]       [k] rcu_all_qs
> > >   2.34%  [kernel]       [k] __cond_resched
> > >   0.50%  [kernel]       [k] _raw_spin_lock
> > >   0.34%  [kernel]       [k] sched_balance_trigger
> > >   0.24%  [kernel]       [k] queued_spin_lock_slowpath
> > >
> > > There is indeed an increase of throughput and reduction of latency.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> >
> > Tested-by: Jason Xing <kerneljasonxing@gmail.com>
> > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> >
> > Throughput goes from 12829 to 26072.. The percentage increase - 103% -
> > is alluring to me!
> >
> > Thanks,
> > Jason

