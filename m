Return-Path: <netdev+bounces-171074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A7FA4B5B4
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 02:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B15B188EF12
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 01:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AEE2C190;
	Mon,  3 Mar 2025 01:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V29oGLpt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B0BEADC
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 01:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740964110; cv=none; b=BUO56LiU06A6Rk8e7Igzx6WHi0+yunnOAcLSjHlcAfK/fcp8JzxK38HntK6JcoDk5EzPMugCbcLftuLR8QWvIwbrfEjVtSCKYv29FmErDY7IU5i/Wwc9AtSJttdQZheEk3fkg4o7dpQca2B6MfXBR7PJjinYzNB5/RkU3TopEPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740964110; c=relaxed/simple;
	bh=+0hl1538gX8JOdFJ4/z0PEvX5J/PGdnEssz/KL0Q1kE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VX5EsfXBDKzqG+A/9kHsqYjyg2p6m1eM03RyLvLIo5pXEuS/HQOXG7pjhVl61wvlNvAg+msg8X7+3cqWFk5vFYBH6CH7lHfGsRnRBLdCRvSKc9bMVFikXlvTlfbEyROErbCkkZUckS7y912u5mNY7bCNzgFNDbiiq7Yg5RaWw1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V29oGLpt; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3ce87d31480so14889645ab.2
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 17:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740964108; x=1741568908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mns/gzE49NlNZ8NWlBpdzLlxLzuoK8v9i++seN/Xz/o=;
        b=V29oGLptjkXHFkY7rKWzBqU5g3vwVEfoiQIJFV7sCf0wIdqtDqqylZ1By/2+P5hGFj
         SZr/3XCPKmfSD4yStqwLwoGuGKvGnJV+jsq6h0roBiAO66/Grrykxy25uwo3//UBb9iE
         yIqALKjTLVDSZDcjeipJd/AxOIYfXyAX0ILKdEEhL4vuAliit/biXdEii8UELtWwuN20
         0ZmAqyFnjKaP51w1bFA8gOXuxpyX2zIzfPYgMjEL3ymXwM29D17z3K4BHbmutaTWq9YN
         5BB4hQL1bpOl0lJEFlhxhRVu97mM/n9azOdTaUe8WC0K3IRo65xwGplELdAdSiMq0hGX
         7GJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740964108; x=1741568908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mns/gzE49NlNZ8NWlBpdzLlxLzuoK8v9i++seN/Xz/o=;
        b=iOzi4VVn7Y/jMdji+omAjYgcfxmIsDElDo2lLqL0KDOF07M+/qZL2Pgjc8lz5Fw0te
         7HjQVbIsxNAPzZjuxwxbxsNh/tM/PJn5hhAqdQfin8cKiuhKXelCk6FiDWYe/vmPVCBZ
         1ePezpVyOFI+1kSze0SCMEWSrq/ImqjgBrYmm3QCLTEPV0GtXMtLUdvJi9CaYhJjhtCJ
         zqhK3vMH1G7Z80ELEMKqZx6uUAQaIZKLWAaeTxCy0HVC6RQFe/ugaeCOh56hDB/JWdHM
         tV91Rnzup5ImZWANOdtdpKE6RNqLuEkbO5HaX3v4nRP2EmeY4l2V1/l+dM8gwDNpS4oC
         +8gg==
X-Forwarded-Encrypted: i=1; AJvYcCW2fffllKbCnNA689PGJpYuPG82mJ/v1vcvcpkmoE5lX95ScKaW60cCj8goqM5JiEopWW+ZpqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmhfqjoau2af4cW84+VDpYl6QjoOIRTKMITy30pkhtZZSQ8hmb
	atl7nyq1GnRxLYTFTIf/MIyV7ygqX+YHqZYDEdrwE1iWD0WZqTzjQMOHqnxNLu9RmjVsQaFuF+5
	WrL7aaVFy8j1DRSi4tVUGKi6UIv0=
X-Gm-Gg: ASbGncuQZIxtJDcVid+I2vDVQRgssV84b62xBmvfTiIPr2MPyvkwFd+Znmr2tIO734C
	gSVUo+Qu4MmMxXxmC+vGcZLP2G2QoCCeLOQWWiSFBFbaDA4wB5EAGKW2xl8jxKt2INOA9LsmXae
	9R6Jmp+Ix7pIB0u8GNhY6YG8u/0g==
X-Google-Smtp-Source: AGHT+IFbcdHq19InL5vdft3WvqjQiBV28q2vtDPj3e8oQtCQhDB1DkW2DFeP7yfIQgqlCWY9vt7hQVNt2j/fT4AsQJc=
X-Received: by 2002:a05:6e02:180d:b0:3d0:4e57:bbda with SMTP id
 e9e14a558f8ab-3d3e6e45cf7mr94073475ab.1.1740964108279; Sun, 02 Mar 2025
 17:08:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302124237.3913746-1-edumazet@google.com> <20250302124237.3913746-5-edumazet@google.com>
In-Reply-To: <20250302124237.3913746-5-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 3 Mar 2025 09:07:52 +0800
X-Gm-Features: AQ5f1JpA0gzteJ_Y0z9cqfKw4TRtPIt1UDZX4FE4XSI0zOHkR4x88eyuWQCxBs0
Message-ID: <CAL+tcoCOLBJO1PZdKPu2tM3ByQbu9DKcsHn1g6q33CbpHtx5Cw@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] tcp: use RCU lookup in __inet_hash_connect()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 8:42=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> When __inet_hash_connect() has to try many 4-tuples before
> finding an available one, we see a high spinlock cost from
> the many spin_lock_bh(&head->lock) performed in its loop.
>
> This patch adds an RCU lookup to avoid the spinlock cost.
>
> check_established() gets a new @rcu_lookup argument.
> First reason is to not make any changes while head->lock
> is not held.
> Second reason is to not make this RCU lookup a second time
> after the spinlock has been acquired.
>
> Tested:
>
> Server:
>
> ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog
>
> Client:
>
> ulimit -n 40000; neper/tcp_crr -T 200 -F 30000 -6 --nolog -c -H server
>
> Before series:
>
>   utime_start=3D0.288582
>   utime_end=3D1.548707
>   stime_start=3D20.637138
>   stime_end=3D2002.489845
>   num_transactions=3D484453
>   latency_min=3D0.156279245
>   latency_max=3D20.922042756
>   latency_mean=3D1.546521274
>   latency_stddev=3D3.936005194
>   num_samples=3D312537
>   throughput=3D47426.00
>
> perf top on the client:
>
>  49.54%  [kernel]       [k] _raw_spin_lock
>  25.87%  [kernel]       [k] _raw_spin_lock_bh
>   5.97%  [kernel]       [k] queued_spin_lock_slowpath
>   5.67%  [kernel]       [k] __inet_hash_connect
>   3.53%  [kernel]       [k] __inet6_check_established
>   3.48%  [kernel]       [k] inet6_ehashfn
>   0.64%  [kernel]       [k] rcu_all_qs
>
> After this series:
>
>   utime_start=3D0.271607
>   utime_end=3D3.847111
>   stime_start=3D18.407684
>   stime_end=3D1997.485557
>   num_transactions=3D1350742
>   latency_min=3D0.014131929
>   latency_max=3D17.895073144
>   latency_mean=3D0.505675853  # Nice reduction of latency metrics
>   latency_stddev=3D2.125164772
>   num_samples=3D307884
>   throughput=3D139866.80      # 190 % increase
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
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Tested-by: Jason Xing <kerneljasonxing@gmail.com>

I tested only on my virtual machine (with 64 cpus) and got an around
100% performance increase which is really good. And I also noticed
that the spin lock hotspot has gone :)

Thanks for working on this!!!

