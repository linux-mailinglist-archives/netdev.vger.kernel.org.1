Return-Path: <netdev+bounces-212190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3594CB1EA40
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DC3B4E45CA
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA7227E079;
	Fri,  8 Aug 2025 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="PZj0p3P5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1741F13AD38
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662888; cv=none; b=KaSlbgxo39ZbH6plD7dds/STdxaJBz09GhmosU25O1rl18CqrxVGmK6tzxgtroziQpiKGNcJl22cqrIfTTqBXT+hQPv1sOwv0M4QMSlJoX3o2ffi4KNU6HsXo9k5yN6uoaEf7AOPBfi9rklqW3DeNlcB8eHx+4+wVMHRiWIyNcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662888; c=relaxed/simple;
	bh=guHzSvaBeM/USIv5SatPspIVxLVMpHFVg5Q5uwqdIbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjEm2wqEJUQpfH4kHubgl5xP2MMMLHwmykGFBWRWwOFQQcnQZxsJoER/MqJuDbEEgb1ikk2r+s0Ellp1gmqU4kuPHEVv6iufE7fCe02wWb4dZg3YVkSXc61i65LrD/YjzmxebPjrV+Mp8CNGvQVuH6v1vcqgwrEVE23zhjDk2UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=PZj0p3P5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23ffdea3575so15041935ad.2
        for <netdev@vger.kernel.org>; Fri, 08 Aug 2025 07:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1754662886; x=1755267686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guHzSvaBeM/USIv5SatPspIVxLVMpHFVg5Q5uwqdIbc=;
        b=PZj0p3P5CBkpC1ECOz705VGFb8J6RNwNlXIudjLxUC7dW8mRAUK741EnSstTlbl79W
         j2NuDXxtVb8wAAe+GsljSTGc4JNhg6tPJeXLJCSena9bj7oR0yHhOE6HjwvNCLwXxlGt
         XNxUUza85f4MQBE+tnGrqiY1/yolvyryy19/SZLwUaO6ouNfZTRp060znR6ZEqaW3oCz
         SdYFPb2g3pG1LyChwiQH+E1pEv1MEOtlzlub24n7r6YCH7Eav0NRMK9iWCX3BgiD/Yrt
         SrOA6FqtAqE2j4dI06vYGeY4frLBiBLjCUC3VEzzMuRUUBQ8TjKxRud0ctjHkrH7aqWK
         /XBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754662886; x=1755267686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guHzSvaBeM/USIv5SatPspIVxLVMpHFVg5Q5uwqdIbc=;
        b=Zd7cBChz49w50hkyzK2ng3svR69WhmDqfpiJTZ22mwzWHkEuQyct+tiDdZJY60yYec
         //lsHk7lbMWObLsn48zJlI1LHszJvyTS6SJYSPPkgqJv/ierR6hTUy54EhWTGm9BzS0o
         9fk1y3m2ZX0HhkJwDXg4a2BRZqlL3skWdXKzfEydmt3Pj4Zg0N+9V0uzhVYrDlMYaNC5
         riga/jm3HiAijvR3b1wgUuSnkHL99dWdxEtuo26YNZcVHp+Kz4YO+iybn986NEgjZva4
         j9RthZoF42+y3rS6St8EjI7P01DAI+T58Fea0oxINDpWJaJm3OW2VOwy9EySpLVXhBCp
         TFrw==
X-Forwarded-Encrypted: i=1; AJvYcCUZqCwzyQeAu16m0lCv1doyHmrJZB1wt01tAVbgBF2wRuTz3gDJKUIgpVP/hdzQKYh/GK6FKCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhUxn9/WlZxlIdTsyId+EKQ/ZFz3giO1MUWoJoZSkuSGi8RUJ0
	Xjutq6bha8KVrnj8xImQ2j/jNHxlTV3vgj7as6W/GcNnLNeDzT9UblB13MCq997Yjr+fmyasOiu
	HLcpkDB2aswrjG8I1U17frWJDOHZJgxj8wO+iq573Ug==
X-Gm-Gg: ASbGncthFdpa31yBEp9nrrjG1ouzjCqceHzK12FPXZkRHn/+QCaPYcbJdJmq1N8YJF0
	fldgL7/fEJ25uRlxtVifNBah85q6GSYoqG0e6mA0eTzjouuWEtj12+zTwT+drI+dKVpXR3cqK/3
	aTfqMss++KbLfmbSv2jO5k9B0s6IZlPBSz554B8vVoIajT2bR4Aaa2rMSeRO/Otu81sqMAWtTa1
	ipMRzZctHHmGmRXaDkytdMRHJhWzc/JXg==
X-Google-Smtp-Source: AGHT+IFmZBg5ZwAP49VEb5vbGDIowxD/ct5MdC1b9On5aGdv3/h76JvUwtRiU/cQG4Jpl3vV708BLdqG7GyflYMwLpo=
X-Received: by 2002:a17:902:fc8f:b0:242:b42b:1335 with SMTP id
 d9443c01a7336-242c2059ca6mr52927975ad.22.1754662886384; Fri, 08 Aug 2025
 07:21:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722150152.1158205-1-matt@readmodwrite.com>
 <CAADnVQ+rLJwKVbhd6LyGxDQwGUfg9EANcA5wOpA3C3pjaLdRQw@mail.gmail.com>
 <CAENh_SS2R3aQByV_=WRCO=ZHknk_+pV7RhXA4qx5OGMBN1SnOA@mail.gmail.com> <CAADnVQLnicTicjJhH8gUJK+mpngg5rVoJuQGMiypwtmyC01ZOw@mail.gmail.com>
In-Reply-To: <CAADnVQLnicTicjJhH8gUJK+mpngg5rVoJuQGMiypwtmyC01ZOw@mail.gmail.com>
From: Matt Fleming <matt@readmodwrite.com>
Date: Fri, 8 Aug 2025 15:21:15 +0100
X-Gm-Features: Ac12FXx7v-SSukGf47arwGF9TbWihsALELCDJDlaUcJ6XfDaJwfnJlT_e7TVQHE
Message-ID: <CAENh_SRxK56Xr1=4MX4GhZuc0GF4z5+Q8VueTK0LDLj3wg_zXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Add LPM trie microbenchmarks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 5:41=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> well, random-key update when the map is full is also quite different from
> random-key update when the map is empty.
>
> Instead doing an update from user space do timed ops:
> 1 start with empty map, update (aka insert) all keys sequentially
> 2 lookup all sequentially
> 3 delete all sequentially
> 4 update (aka insert) all sequentially
> 5 lookup random
> 6 update random
> 7 delete all random
>
> The elapsed time for 1 and 4 should be exactly the same.
> While all others might have differences,
> but all can be compared to each other and reasoned about.

Having both sequential and random access for the benchmarks is fine,
but as far as I can tell the scheme you propose is not how the bpf
bench framework is implemented.

Plus, handing off a map between subtests is brittle and prone to
error. What if I just want to investigate the sequential access update
time? The cost of the most expensive op (probably delete) is going to
dwarf all over timings making it difficult to separate them and this
scheme is going to be susceptible to noise if I can't crank up the
number of iterations without altering the number of entries in the
map. Microbenchmarks mitigate noise/run-to-run variance by doing a
single op over and over again.

I agree we need a better approach to timing deletes than what I
suggested but I don't think is it.

