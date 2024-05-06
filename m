Return-Path: <netdev+bounces-93654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AB18BC9CF
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 10:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7448B1C21311
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 08:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D1C1411C8;
	Mon,  6 May 2024 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kv6G/7Lj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2274F757E4
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 08:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985037; cv=none; b=MATOAYjYQFKLGm1pJxoE8J1+w/rhfVdFocwwqzfQOQ1UsD7SmYBsv1JMpF3q/2JC2qKRpfdSivzntakKNJ2YHJmY8HSvenNoTcFUH9q3yeEXpGeXxSdLReFdQkicS4Jr0QHD1dKA/BMC3paq3kxbGdiMAtCAom+Rt6+Vb26Niq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985037; c=relaxed/simple;
	bh=BV3dz2MstHWWAVsJkfbNDr5RDdsiyuYXv8b7W/z4Hqs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C9EjSTQ0imI9C/Qvab/Q20HF9WAWBWcJwlYXzhLSQWIyUM6LlFQhyqcuMpzgyGDEUJRRYWL55do15lheb0b9HlpsmEovkq3vSnGXVbxbAvRUR1RnEUeI2o2FozUSNE6McZKH/CeTRoHsJ2FMZAGwfcNJr5bMvk+koggxWv4xAZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kv6G/7Lj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714985035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aupKVGbKBUrSNsIL3b7oim4tCbgcEfpLZJObYCbAnN0=;
	b=Kv6G/7Ljg/YJsF8HOWCGoMVNOFCJa0fpIGfIOAoJp1b9WM5zJSxX5SK1ZTGFHNq6Q4Mp1i
	mhE5bQNVnGhGZq/KIVzaIdxl5X2zslIBF13bBVWMmRSQD1fhCESX1BnBb8bgaMQ6A3ZCkz
	b8lqu77yhDZmS9OYdrnVyPDY0zA5N1I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-kjHfRBDAOYWAAtceTiKWkA-1; Mon, 06 May 2024 04:43:52 -0400
X-MC-Unique: kjHfRBDAOYWAAtceTiKWkA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34eaba0b1ddso111905f8f.3
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 01:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714985031; x=1715589831;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aupKVGbKBUrSNsIL3b7oim4tCbgcEfpLZJObYCbAnN0=;
        b=EkSZEHyh62oCpBY3/Z9wKZt7El40uVJbmdChMA5MbQi7dm+YaHL27E5SotXqvaXzx8
         ej3d4G/4zocrg4Qi9RxHg+fu4LmjGP+rx0ukIn/ofJozbweAm3VZul6GZW2TIQzgSK/X
         m6FNh4OyIslC3V5XKwDgAZ2K2L/7c40sGTPnpdS18gU3AVEuG2Qw7sPatBq9U7ocDmvJ
         L/p5i18ZtLcfz8gv1Q/zXa3t572txcufccxK48dFnU01+LKEGQMSs3mBtkswRwdbgCtp
         G8Dkt4FTp2tQ/cG5byYPJh0ImZfGpC78M5HKP1EHhjIIFOq1/g8sf4IR6JAOehDtcLs0
         2qHg==
X-Forwarded-Encrypted: i=1; AJvYcCXeA/Y7gW51aV0fcFQqBwtgr0FUU7fz0b2HlmxYQut7ZDndmflRg2/Tl50HU1hHVn5AczEK19fnEaU1HFp5RaHubji/tS/H
X-Gm-Message-State: AOJu0YzOcCLHEl1gDJt3iEzDLIC/P5gZM2FpvyADRjO42Z+55eLZF4/I
	76s2VJzSiZmWI22dmnKwOxabplooAqLq1OIgAFfuWb+6OrFSOA720Zmo3yTiFzVB8Lu6BW+liI+
	Ppap6fnHC4yClJAgrwJBSSqYoAxsDKS9ioWpgm9npj1m9rdqBYIJUwQ==
X-Received: by 2002:a5d:558a:0:b0:34d:7d77:36fa with SMTP id i10-20020a5d558a000000b0034d7d7736famr5809661wrv.5.1714985031525;
        Mon, 06 May 2024 01:43:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFZCPDyLiMr52XP0lydmW+ohGJjR2ARRSxYihsZmyn3Q5OpwDsAV4GOwokXk/2IKp8YP+Dkw==
X-Received: by 2002:a5d:558a:0:b0:34d:7d77:36fa with SMTP id i10-20020a5d558a000000b0034d7d7736famr5809645wrv.5.1714985031100;
        Mon, 06 May 2024 01:43:51 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b09b:b810:c326:df35:5f81:3c32])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d4dc6000000b0034ea98a5660sm5827615wru.54.2024.05.06.01.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 01:43:50 -0700 (PDT)
Message-ID: <0d2eca9e80ae644583248a9e4a4bdee94999a8f8.camel@redhat.com>
Subject: Re: [PATCH v2 net-next 00/15] locking: Introduce nested-BH locking.
From: Paolo Abeni <pabeni@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Boqun Feng
 <boqun.feng@gmail.com>,  Daniel Borkmann <daniel@iogearbox.net>, Eric
 Dumazet <edumazet@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Date: Mon, 06 May 2024 10:43:49 +0200
In-Reply-To: <20240503182957.1042122-1-bigeasy@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-03 at 20:25 +0200, Sebastian Andrzej Siewior wrote:
> Disabling bottoms halves acts as per-CPU BKL. On PREEMPT_RT code within
> local_bh_disable() section remains preemtible. As a result high prior
> tasks (or threaded interrupts) will be blocked by lower-prio task (or
> threaded interrupts) which are long running which includes softirq
> sections.
>=20
> The proposed way out is to introduce explicit per-CPU locks for
> resources which are protected by local_bh_disable() and use those only
> on PREEMPT_RT so there is no additional overhead for !PREEMPT_RT builds.

Let me rephrase to check I understood the plan correctly.

The idea is to pair 'bare' local_bh_{disable,enable} with local lock
and late make local_bh_{disable,enable} no ops (on RT).

With 'bare' I mean not followed by a spin_lock() - which is enough to
ensure mutual exclusion vs BH on RT build - am I correct?

> The series introduces the infrastructure and converts large parts of
> networking which is largest stake holder here. Once this done the
> per-CPU lock from local_bh_disable() on PREEMPT_RT can be lifted.

AFAICS there are a bunch of local_bh_* call-sites under 'net' matching
the above description and not addressed here. Is this series supposed
to cover 'net' fully?

Could you please include the diffstat for the whole series? I
think/hope it will help catching the full picture more easily.

Note that some callers use local_bh_disable(), no additional lock, and
there is no specific struct to protect, but enforce explicit
serialization vs bh to a bunch of operation, e.g.  the
local_bh_disable() in inet_twsk_purge().

I guess such call site should be handled, too?

Thanks!

Paolo


