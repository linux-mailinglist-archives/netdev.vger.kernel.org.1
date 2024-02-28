Return-Path: <netdev+bounces-75625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A75FF86AB60
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 10:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFCD1F278B1
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 09:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B5236B0A;
	Wed, 28 Feb 2024 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="naRbPE7d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D62537171
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709112785; cv=none; b=dy6bfDQiwbRyiQfKqLWKilYq38bs5XmrwSo+B4355QOKT8ytAUHAIN1X1mpedGi6Rf4rSMPam3lDkKwrTmqKHvAiwXF8koUQn2ISGG+SZB6Yt6rpzq+8h2dW7ceDH03rzdDMXzwrl9p5Eyq4wz2N1Q3qWqr50z4bJiuEnKDldwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709112785; c=relaxed/simple;
	bh=+vEw4yu6BEkpuISizXp9gDSi/jYKQJzYyDhQ1Lqpquo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/f7sXqTmTLp+WP+ZvBgT/DDAfdRj5JhFL9tgFwDNG4o9oyZ5/g21M4B5KlYAOMFFgmyq5uXI6t6M1iDeIqkgzzAeD5JB5cOcCXR/DHUV8AEPrkpVdK1f+Hqj5AtLzg9NkPmy725MaqPgLhQiIRq8JkQvRUqT/d9Rj8yYUkBzsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=naRbPE7d; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso10507a12.0
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 01:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709112783; x=1709717583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymxFlaSd/RjrNJLnLxB6/F9mhAatakD+Om7yj8a55aY=;
        b=naRbPE7dzObWXC8d4DtcztCTQGvfAFfdIoD2/kP3p1KRd7D25GBfFgZ02ghlsq3h2E
         bETBw4KzrLWgm3sKDopwyjsOIbM3BDOfZkT090CQrrYn/tfHbwCy/8ldnkn2bzubvjav
         wvdTQz7fU0wdvzF0dPkC1lRU9nc5030YTRZAFIvFlE+kpblfoPuDcs9kRL/H7QnqryE1
         uad2QT63g53z8EvszWzNT2Vb3gaWLVopAQHzJzy6+K2N9flWI/voIMpKJMpGZqBm8lAD
         Rif+MouBzx0fV28WWIwB8xKjQKbpTKrvUKzCdl4NgRvBV3N9YCJKewkskIXNTch8Z+3n
         lICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709112783; x=1709717583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymxFlaSd/RjrNJLnLxB6/F9mhAatakD+Om7yj8a55aY=;
        b=iQvPka8zwxbc1AU0KmbIsZbQU4p5dHHeD8nYuZ1P8V1SVR/XODum6wWMpr81sT7U8G
         igBJpyQavwhDMeJwbeOxtPa8Ob18pToef30w9yMW2zZg4FbvjqKX/LTvKJy6HVqoji+g
         LfRR4ecfeOCGT8pqeRVz5LLqJTizuUjJ4/aH21GfXLVScfrk7Y5LKGNJmlw6yI0H1Cp4
         U7GSvimY/xb1/iB4jFRCnGfIXJTOAfmB5fb4eTDSY3kPM3sIVf53k/vM2o4tq8dnawnT
         cscvMOF2rSqqnXnrCsg2jaLB6VdtB0G86oNViv1y1lqJsxrBl9Im55ffc50DRGZMh41G
         HcjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZpwm9X2sWo+Vyvf7knkccI4UW1Aoi6fOLfT1MXcf8ioipnW4G2UBmeYJd63M/jJ77ffKLzAxN7BP7KGVMsz0QhpRKy0WH
X-Gm-Message-State: AOJu0Yyj1eyGxt2uJKdXcX3qSwlZYurjlY8H+pSST8V/0g8I456diOBx
	Dju7Q1ehRWI/755HE0YBZLCyfrb31lVi9cK+0eP/VHXmRrXFGnQQxjl8KazXpjNz4WLIca16J4N
	s5aGK7K/AN1ySPV2fB7vsvMLDk2huDXGQpQgx
X-Google-Smtp-Source: AGHT+IE1vhzjptOnLco79eT13kIH9gOiLX5epU1Ic/wFr3bjjDPwaQ7D/xo/TLfIQwXl4BIoxNKwwY6jIhEIlmf1qjA=
X-Received: by 2002:a50:c052:0:b0:565:4b98:758c with SMTP id
 u18-20020a50c052000000b005654b98758cmr41097edd.4.1709112782171; Wed, 28 Feb
 2024 01:33:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226022452.20558-1-adamli@os.amperecomputing.com>
 <CANn89iLbA4_YdQrF+9Rmv2uVSb1HLhu0qXqCm923FCut1E78FA@mail.gmail.com> <bc168824-25dd-7541-1a34-38b1a3c00489@os.amperecomputing.com>
In-Reply-To: <bc168824-25dd-7541-1a34-38b1a3c00489@os.amperecomputing.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 28 Feb 2024 10:32:47 +0100
Message-ID: <CANn89iKFPjSQhXRcyb+EDQiH0xJG1WdWVGXXLK6iOcMpM2zKyQ@mail.gmail.com>
Subject: Re: [PATCH] net: make SK_MEMORY_PCPU_RESERV tunable
To: "Lameter, Christopher" <cl@os.amperecomputing.com>
Cc: Adam Li <adamli@os.amperecomputing.com>, corbet@lwn.net, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
	yangtiezhu@loongson.cn, atenart@kernel.org, kuniyu@amazon.com, 
	wuyun.abel@bytedance.com, leitao@debian.org, alexander@mihalicyn.com, 
	dhowells@redhat.com, paulmck@kernel.org, joel.granados@gmail.com, 
	urezki@gmail.com, joel@joelfernandes.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	patches@amperecomputing.com, shijie@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:08=E2=80=AFAM Lameter, Christopher
<cl@os.amperecomputing.com> wrote:
>
> On Tue, 27 Feb 2024, Eric Dumazet wrote:
>
> >> sk_prot->memory_allocated points to global atomic variable:
> >> atomic_long_t tcp_memory_allocated ____cacheline_aligned_in_smp;
> >>
> >> If increasing the per-cpu cache size from 1MB to e.g. 16MB,
> >> changes to sk->sk_prot->memory_allocated can be further reduced.
> >> Performance may be improved on system with many cores.
> >
> > This looks good, do you have any performance numbers to share ?
> >
> > On a host with 384 threads, 384*16 ->  6 GB of memory.
>
> Those things also come with corresponding memories of a couple of TB...
>
> > With this kind of use, we might need a shrinker...
>
> Yes. No point of keeping the buffers around if the core stops doing
> networking. But to be done at times when there is no contention please.

I yet have to see the 'contention'  ?

I usually see one on the zone spinlock or memcg ones when
allocating/freeing pages, not on the tcp_memory_allocated atomic

We can add caches for sure, we had a giant one before my patch, and
this was a disaster really,
for workloads with millions of TCP sockets.

