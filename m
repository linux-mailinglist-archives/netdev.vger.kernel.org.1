Return-Path: <netdev+bounces-133478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980D899611A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 09:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA27B1C23E11
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 07:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E410B188591;
	Wed,  9 Oct 2024 07:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9BfDryM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F53A18787A
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 07:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728459599; cv=none; b=Ek8RISfEL0tSLmou8k1nZG1h/mDfIWunEOz1+BlUkeEl2Q5pW82PhwkhcecHZd1blixtOxtVwF5D/nEK3fa4Ha8ial6KSg+oG+Ak9+FsZkJmPjupZZ6xEHp2scBMKxkU80NqK1+4w8D85Mt3xCkRHE2cut1JgMLJbjoQ96+P8xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728459599; c=relaxed/simple;
	bh=9dJzKEPFAD4JUvaS3jyOf92XvdpMOg2X+Hnh+1QsXE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nqoy7dtwS2WwPTRqHp2bSFpHQMJIr/N1JJ1lmKlpzfCBcwaz8hCmhYQz6nm2b9CMhq7gc/sJ1rU/SCxbep4ibih20FPyjikLYKFqXaMgMak/m4yEf2CdtFPTZu0fCTXynV2regrKBt4G3a2hsxIWbQOHX0/rfIcjKUmIYgIdqnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R9BfDryM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728459597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9dJzKEPFAD4JUvaS3jyOf92XvdpMOg2X+Hnh+1QsXE4=;
	b=R9BfDryMtafKM49YBcbqgGFRYgzOtOj8QeXqjmyNogMqZ7eMGDL9dwwHExeWeHT9ZB7b5F
	L8wgbpcaAYQqws0pWPs+y2iDIZOiUyaNGERMtBKRqlONWVpzGBuWUglxTBJpOyVCNRVVBg
	g+tUUUXFce0Gr/7BtHMG0pg1TLw9YZY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-YswQTLczMwKB5cIEq9TFaA-1; Wed, 09 Oct 2024 03:39:13 -0400
X-MC-Unique: YswQTLczMwKB5cIEq9TFaA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37cd19d0e83so3017246f8f.2
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 00:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728459552; x=1729064352;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dJzKEPFAD4JUvaS3jyOf92XvdpMOg2X+Hnh+1QsXE4=;
        b=cS9ZWcWKB7le34icQM5yopy441n5FgHyrz+HD8BR1tNQaPpjxZbbLi55CEqvGOi4q9
         HxeW2XDcdRNerPftkpx/MDr+xHkv/ouo1gXVctAW6uXJdzhl/op1/xc4Zx2bz1CpgYGz
         NdL1rHRLO94jcieBJVgycMVTBv2lEo4bMPpCf/manHT0wGw0ePrtbmVu4cU7+5TQidkt
         yJHCKZVEUIkJS6JK1NtJNC8hPhdDEKtvA5nuUUeQTB73hZtidIk716qA/FmR/mBfcUAH
         pkBanCERe22YeCEdz4o1XZkBoHAazZtUDqJqhnAe1XshwgIr1QzqYWR8S738ZQcKNsga
         3/kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWF0qYcLO1s8Hsrc/hbhex7WvIf1UUuAk+RDQ8jzqvBxQ7ESXCbGP3Fm4p2s+FXOleXN62w5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+DMW4mOVD6FdTujN/b0c7gWLnNPbZtcwS1cvlNVRO/MeKIxtg
	ldQulKj9tQJiXkMEkG8x9rAmNn346ABpIn6OFWahckO5G2SFInSESoIxZbvgJ0mvMGj3JAnpmwS
	Ngw4moTls6KQjcFwu/PvF4YYXBmJylWVeBfdKx9kDZnyEQ+OMSxhrsw==
X-Received: by 2002:a5d:6a0f:0:b0:374:c56e:1d44 with SMTP id ffacd0b85a97d-37d3aa83f66mr741050f8f.48.1728459551775;
        Wed, 09 Oct 2024 00:39:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYf5a/YJ8kLTN40pKDIOibKodHb2C12vO2gw43Om2R8cyTwst05scLhW8CZw3n+kl2AFVxTA==
X-Received: by 2002:a5d:6a0f:0:b0:374:c56e:1d44 with SMTP id ffacd0b85a97d-37d3aa83f66mr741029f8f.48.1728459551321;
        Wed, 09 Oct 2024 00:39:11 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d748dd50sm11261915e9.47.2024.10.09.00.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 00:39:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 7136315F3D4A; Wed, 09 Oct 2024 09:39:08 +0200 (CEST)
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
In-Reply-To: <CAADnVQKM0Mw=VXp6mX2aZrHoUz1+EpVO5RDMq3FPm9scPkVZXw@mail.gmail.com>
References: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
 <20241008-fix-kfunc-btf-caching-for-modules-v1-2-dfefd9aa4318@redhat.com>
 <CAADnVQKM0Mw=VXp6mX2aZrHoUz1+EpVO5RDMq3FPm9scPkVZXw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 09 Oct 2024 09:39:08 +0200
Message-ID: <87bjztsp2b.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Oct 8, 2024 at 3:35=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
>>
>> The selftests build two kernel modules (bpf_testmod.ko and
>> bpf_test_no_cfi.ko) which use copy-pasted Makefile targets. This is a
>> bit messy, and doesn't scale so well when we add more modules, so let's
>> consolidate these rules into a single rule generated for each module
>> name, and move the module sources into a single directory.
>>
>> To avoid parallel builds of the different modules stepping on each
>> other's toes during the 'modpost' phase of the Kbuild 'make modules', we
>> create a single target for all the defined modules, which contains the
>> recursive 'make' call into the modules directory. The Makefile in the
>> subdirectory building the modules is modified to also touch a
>> 'modules.built' file, which we can add as a dependency on the top-level
>> selftests Makefile, thus ensuring that the modules are always rebuilt if
>> any of the dependencies in the selftests change.
>
> Nice cleanup, but looks unrelated to the fix and hence
> not a bpf material.
> Why combine them?

Because the selftest adds two more kernel modules to the selftest build,
so we'd have to add two more directories with a single module in each
and copy-pasted Makefile rules. It seemed simpler to just refactor the
build of the two existing modules first, after which adding the two new
modules means just dropping two more source files into the modules
directory.

I guess we could technically do the single-directory-per-module, and
then send this patch as a follow-up once bpf gets merged back into
bpf-next, but it seems a bit of a hassle, TBH. WDYT?

-Toke


