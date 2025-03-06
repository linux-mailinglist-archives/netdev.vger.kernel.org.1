Return-Path: <netdev+bounces-172347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B27A544BC
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3103ADAD6
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 08:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BAB20551C;
	Thu,  6 Mar 2025 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYtmBXrx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A252207A0C
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249393; cv=none; b=tksiBJpL3ukiGe2U1r67NN055yF0JeITTyJ0LNpRmhP5zvXd3cs6m5wSdtMEJcBR1+rbdj38kyN4oyRfR7kjLwPnn1/zOptWHv9vmVqthxPcZIIpJ/jONEFSHuphiKWtKyfXzt5cVcipByCyp+AfWbsrcQJXpZxXSqPWKKiO6jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249393; c=relaxed/simple;
	bh=ptMpDYumVJiwwSKfNXWaLs/fN2G0O4Z7oQwRuTyLdYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2NGP74M8MV/hnXcOoQY6A/p0Lmq6Ox/YmqSqGjqABAZgz2gVj4YuJFCbRb6NJejZdpgtJSCuhrChMgzz5p0lLoMlYU2IXt/nB1fpFB5Vd7JCOIu5K6bUaY45CKW1pi1n3PV6pYwTgUK8LOl6NpAEIv0J8OSzgSvTG2TLjLBFJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYtmBXrx; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d03ac846a7so1250555ab.2
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 00:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741249391; x=1741854191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUD1inkdx95XMBe6dYlvksX0k1TerYnZ1m/VCKjQs74=;
        b=AYtmBXrxOMvIIpuPJcLOhHCjRQov+o8coXggGsvioLW1IR5BJy7IfT4RXxMojpC6sk
         fXT8TGaXqRy7s1xM88Uahi3VZLtF8J83ZANq4qHc5uYQbzTuVJjklELc5E850XvtIihe
         jfSh8JNJUBuJbM5nDtoGqojgZ0Km0fpWGDyIJqN5JNRxRHVRlLu3alq552nShwwrowVU
         m6mLtLyrMjptmsXpUa41ST9RiFPWpyFvpIo+a2Wqdh3hm3TPphfx0N/k/5Z+iN+Si07P
         1+kyHWwckMnJSVk9kz6nCtU7Dx041drbsIuFARQ6xa0tshJ9zg0027di1UwkZP8SXYkz
         oOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741249391; x=1741854191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUD1inkdx95XMBe6dYlvksX0k1TerYnZ1m/VCKjQs74=;
        b=kuNeyEPC1rtP7qMH6ou8IzKWZ3pCpSHduahI76cSr6DTB5LnZdxzWVXhrHMYRMBBgZ
         gN0BTprq4hdLiZ05gDPWPQGHA6E/P11lX7FIGBIgxy3KW4BWMQkYXuKP8a70lBXngGc5
         USikQvW4msdouGniaZWV+Q/ZbvYsmDD+KlLe9OYLeX/BlXNMa+38UcYL6EuK3q6yzbMW
         t+4wDz+XSjWEIW1sbZUNOW9KS74xgV5d1HlKZvkIefdUhbMzwJEAphyqvB58lU4l/2Xo
         BCCt7Z8NuGoy5rV/0FNv+qS7nXq49RFwvLLNP5fH0kUVs4894fH8eXe7opfDBmtOBsxg
         0Psg==
X-Forwarded-Encrypted: i=1; AJvYcCVyqVLTDYYwsgLyh7a4JMhG38aw8Sq0D3/ZhucAXWnWoXxBpJkuyqgKYl4BHmWn+BbMpoLEtnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ngt4Hv/3Q+9ZbvJYH0PpX27tNcJeuOvE6SKkTZori+i0HT91
	MxqjrHfBQUcjEPb4XrpNTZd/QoHQ164Syo7/JMayWyH0bSuN2WjC6cvp8t29+FGP6TWcL8c/6at
	7f6b4llIaeJJOWER5yCTUtLB9+qw=
X-Gm-Gg: ASbGncu2Ay3yYVMBHrZD2ATo5cHTLZ2mUZnkquCHjf4QGw38K8L3QX5mK1B0oo/xy17
	uPvmvDFhzSc+04hmcUsFM7qMCWVwEAry30/FnGUGTX/66ML+ovceqvQ35XrXH2aGhkVJjUzcI39
	ythVOTch/Y6QNsjrR4du6Kw4OK8g==
X-Google-Smtp-Source: AGHT+IGk3spdw1RtNUiNdYKPYwJnNRc9AGMH1EgsxM+6tKCxArX+lM1375xmYSjcVaO7E6D1iG4DvFGSaZurvEFQM8M=
X-Received: by 2002:a05:6e02:3d08:b0:3d3:eeec:8a0b with SMTP id
 e9e14a558f8ab-3d42b8aa877mr76511875ab.10.1741249391361; Thu, 06 Mar 2025
 00:23:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305034550.879255-1-edumazet@google.com> <20250305034550.879255-3-edumazet@google.com>
In-Reply-To: <20250305034550.879255-3-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Mar 2025 16:22:35 +0800
X-Gm-Features: AQ5f1Jol_4XAAYJHZ4fed987p92hgSxCArY1hWlLS1-0lzx8EhQ2-PQdoj5zeys
Message-ID: <CAL+tcoCjZxM88TpvNDVzW+BBNU9V2a=kpBh=XZ8cHcHqsRjg1w@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] inet: call inet6_ehashfn() once from inet6_hash_connect()
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
> inet6_ehashfn() being called from __inet6_check_established()
> has a big impact on performance, as shown in the Tested section.
>
> After prior patch, we can compute the hash for port 0
> from inet6_hash_connect(), and derive each hash in
> __inet_hash_connect() from this initial hash:
>
> hash(saddr, lport, daddr, dport) =3D=3D hash(saddr, 0, daddr, dport) + lp=
ort
>
> Apply the same principle for __inet_check_established(),
> although inet_ehashfn() has a smaller cost.
>
> Tested:
>
> Server: ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog
> Client: ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog -c -H s=
erver
>
> Before this patch:
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
> After this patch:
>
>   utime_start=3D0.315047
>   utime_end=3D9.257617
>   stime_start=3D7.041489
>   stime_end=3D1923.688387
>   num_transactions=3D3057968
>   latency_min=3D0.003041375
>   latency_max=3D7.056589232
>   latency_mean=3D0.141075048    # Better latency metrics
>   latency_stddev=3D0.526900516
>   num_samples=3D312996
>   throughput=3D320677.21        # 111 % increase, and 229 % for the serie=
s
>
> perf top: inet6_ehashfn is no longer seen.
>
>  39.67%  [kernel]       [k] __inet_hash_connect
>  37.06%  [kernel]       [k] __inet6_check_established
>   4.79%  [kernel]       [k] rcu_all_qs
>   3.82%  [kernel]       [k] __cond_resched
>   1.76%  [kernel]       [k] sched_balance_domains
>   0.82%  [kernel]       [k] _raw_spin_lock
>   0.81%  [kernel]       [k] sched_balance_rq
>   0.81%  [kernel]       [k] sched_balance_trigger
>   0.76%  [kernel]       [k] queued_spin_lock_slowpath
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Thank you!

Tested-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

