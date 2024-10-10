Return-Path: <netdev+bounces-134120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AAD998166
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591EA1C25CCE
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 09:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEC01BCA0A;
	Thu, 10 Oct 2024 08:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q76ZqUCF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810671BCA02
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550798; cv=none; b=gm00sXmtkpH8zvrQspQ3wyJG11fTL8I484bYuVYJzGwDMqZZWFZOGvcseR5vUpTXhWLzoaENT+t1X4buPUNrMDPoz+prMG1MipfTReS4z6fyEueMFUAfPuYCSkkjzuKJo/MrGMv7lyujzJoosKofErw6hk7iJAWSLUg0JjGM8is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550798; c=relaxed/simple;
	bh=+G/YrbCxPH0eM1bgt8wmdfNzeFFqY49wGey7ifv6a+I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J1JAYb0Z71hpC/M96EDm7XiCmHtAcv9/Q4Pvz8ly5bJpMMjSc+VITM2I0bZJretA+xxxfGuG8OtLbYgTZF7W4vdv0NxpL8LY7uJY2LzeJ0YRak3cuBrC3qgw5fPu+XBEDi41FtuldhPJcGS2K1b/1caTFX+MUMJKkFrvSmtjtNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q76ZqUCF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728550795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+G/YrbCxPH0eM1bgt8wmdfNzeFFqY49wGey7ifv6a+I=;
	b=Q76ZqUCFq7U2oY0BEIL7ymfSGtx24IiKcvbrvQSrsVLnrMGSaTPfe6y1PvgfU5N1aDjo6q
	OWbG7L4Ojb37YkJhbl7dNPV5ce6+pV3Lrazj/bBbP6vmsB7dKi8Fiep9GhPlemF0Hy122E
	u7/oYVYjTEtQGEq/KfIKREFYGe6oByo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-uUbTxXlQO5KX8YGSK5iCtA-1; Thu, 10 Oct 2024 04:59:52 -0400
X-MC-Unique: uUbTxXlQO5KX8YGSK5iCtA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a995056fad9so54065866b.3
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 01:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728550791; x=1729155591;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+G/YrbCxPH0eM1bgt8wmdfNzeFFqY49wGey7ifv6a+I=;
        b=IaXdNCws5XdMOb7mUcndJ/VEfwM2XV+LFq69uo43zYj1Mri0aQUjtKZMjPkJdCgdHT
         wDdPiTKg4myp+rVtRDMfvnqau3whtfPYpo89gypYC7eUylYBMW5hj1gP/izbstKfyfZz
         9EQyfPJx8g9z8AR5D+kfmul/a6QYKvYf1NA9SDG0KeC4cGFrYCf3Hyl/5CxdbwDTSjGw
         2wWPVx6ydw9pDFU+f9bzxM3Hj61LwattVVIv5kAteSanvW2YV75M/jFlpTt2nuN76Zug
         XScFHl3QMbM/+24qpYLKSq1UpHbmQ/z2DLGzDJxGOnECLpkzj9JuFGe/1qm0kyG7j1EC
         fOhA==
X-Forwarded-Encrypted: i=1; AJvYcCVgMIYpVUityqvJBwpfJrr4OAoQiV7eUVzsMKTMaxoAENjxvQfCVmXLmTua1XoInLS6LeEXJQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXkAEx6hcNOZqxWBnvQqqJoovVTupBJsPfV8n6qq20lOFIrelr
	ikkvZWBt9lzd82VF/80UJ8hJLt2035xLECxMvqi0p22tpdlerjc/XORqYb1NonNdWy9rVIwqGMM
	XYLEE3szU9k7Fh4vqyAoQgo/vGHa+X/3PwslIhjIIOrQsyBFf8fYwVA==
X-Received: by 2002:a17:906:4786:b0:a99:4acc:3a0c with SMTP id a640c23a62f3a-a999e8ec058mr336833366b.53.1728550790866;
        Thu, 10 Oct 2024 01:59:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4LYy5Qqcg/C5y0i+TfiG+LCRjg4ILwCeslTPo/EVGqR3wOXn7Rp6NqCvSPpl+dhHSgg50mA==
X-Received: by 2002:a17:906:4786:b0:a99:4acc:3a0c with SMTP id a640c23a62f3a-a999e8ec058mr336829566b.53.1728550790497;
        Thu, 10 Oct 2024 01:59:50 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7ec585csm58270666b.3.2024.10.10.01.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:59:49 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 05B1A15F3E2D; Thu, 10 Oct 2024 10:59:49 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Simon
 Sundberg <simon.sundberg@kau.se>, bpf <bpf@vger.kernel.org>, Network
 Development <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf 2/4] selftests/bpf: Consolidate kernel modules into
 common directory
In-Reply-To: <CAADnVQKuw=HqtzRok5NyxMDLoe=AHQfwtBxpe9hs3G1HDRJmfA@mail.gmail.com>
References: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
 <20241008-fix-kfunc-btf-caching-for-modules-v1-2-dfefd9aa4318@redhat.com>
 <CAADnVQKM0Mw=VXp6mX2aZrHoUz1+EpVO5RDMq3FPm9scPkVZXw@mail.gmail.com>
 <87bjztsp2b.fsf@toke.dk>
 <CAADnVQKuw=HqtzRok5NyxMDLoe=AHQfwtBxpe9hs3G1HDRJmfA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 10 Oct 2024 10:59:48 +0200
Message-ID: <875xq0s58b.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Oct 9, 2024 at 12:39=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>>
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>> > On Tue, Oct 8, 2024 at 3:35=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote:
>> >>
>> >> The selftests build two kernel modules (bpf_testmod.ko and
>> >> bpf_test_no_cfi.ko) which use copy-pasted Makefile targets. This is a
>> >> bit messy, and doesn't scale so well when we add more modules, so let=
's
>> >> consolidate these rules into a single rule generated for each module
>> >> name, and move the module sources into a single directory.
>> >>
>> >> To avoid parallel builds of the different modules stepping on each
>> >> other's toes during the 'modpost' phase of the Kbuild 'make modules',=
 we
>> >> create a single target for all the defined modules, which contains the
>> >> recursive 'make' call into the modules directory. The Makefile in the
>> >> subdirectory building the modules is modified to also touch a
>> >> 'modules.built' file, which we can add as a dependency on the top-lev=
el
>> >> selftests Makefile, thus ensuring that the modules are always rebuilt=
 if
>> >> any of the dependencies in the selftests change.
>> >
>> > Nice cleanup, but looks unrelated to the fix and hence
>> > not a bpf material.
>> > Why combine them?
>>
>> Because the selftest adds two more kernel modules to the selftest build,
>> so we'd have to add two more directories with a single module in each
>> and copy-pasted Makefile rules. It seemed simpler to just refactor the
>> build of the two existing modules first, after which adding the two new
>> modules means just dropping two more source files into the modules
>> directory.
>>
>> I guess we could technically do the single-directory-per-module, and
>> then send this patch as a follow-up once bpf gets merged back into
>> bpf-next, but it seems a bit of a hassle, TBH. WDYT?
>
> The way it is right it's certainly not going into bpf tree.
> So if you don't want to split then the whole thing is bpf-next then.

ACK. Will see how cumbersome it is to split, and otherwise resubmit the
whole thing against bpf-next.

-Toke


