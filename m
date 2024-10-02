Return-Path: <netdev+bounces-131143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D8598CED0
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 10:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF47F1F23214
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 08:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B887B195962;
	Wed,  2 Oct 2024 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LujrkVR9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7E51420D0
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727858162; cv=none; b=NvMbRZmtM0xyqFP90R266125IlHJg1kg1xhbfsoRHOJF/HqvIX1ZavJjtUA7nN87lYZpi+7ZoN1AfKyaJLsHTvyBF7Qh4QnkgnNI5rhVF3r4SEqZHNV+2CRQTnsXm+tPYwYdf6tvUOFA3icTHEEEPJmRp3kHHRhOr7GHJjSc9Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727858162; c=relaxed/simple;
	bh=3Lqi/OXxA00eaLf8XiOP46D2ukKfPmvmLfoAbIztisU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HnuuFL5yXhZ5frg6HV/T4pmMEzTDUXENSQy+unyjPxO+MCaGhz76xETRlqVuSKmq3HPEFYK6rgocUnKfNvdq3AedM81haKzW4rsqJgrGU9ljo07Bkkok0dDtj+SmpFiXZEVBTYPrS3WkL2J6zXdRkn33K5RWr2RkwtkSNV5xtGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LujrkVR9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727858159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N0mOeG6DrEcLzm/NhKgCIaXI+fTzk5B5rgZ8qzhrCw4=;
	b=LujrkVR9YUtUJKkJxMRmDg1NnQ/RE9pktIetoBGd8vycbsKXCTJ3cWMTuaYx3AAiEC4xZG
	UYbAn/0pDKe7a4bHBzHoEz2n0srOg0IyrY+QtOaGE7wyx/5FQZSFJnaRz8C1RrNzXJeqMf
	wQIF4w733jGNkMynjYuc4LqeKnO2nJc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-GDMVrHvrPA6CAht56Wh2hQ-1; Wed, 02 Oct 2024 04:35:58 -0400
X-MC-Unique: GDMVrHvrPA6CAht56Wh2hQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c8adadc575so673239a12.0
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 01:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727858157; x=1728462957;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0mOeG6DrEcLzm/NhKgCIaXI+fTzk5B5rgZ8qzhrCw4=;
        b=CkGFyhOJMBsPHHSdjUQxEoNEZXhb0BzumLZCB7MpcQjDGRLmHDNT58v/bjks7imxlr
         l8m5NgIFrWOkMRvKl6mVW5yaiG8TEyQiGF8hpy2RAkDeH98Q318vsVZADiWE2z/XWLgv
         o5HMr569ypAi1iMuhiLW0PWonTcmUgU4BCW8e4B5HTdDkt40zfd+PWa0T/WGaJbwnbLu
         ko043Y5gEn+733xCKcLkk4XfjaV/nkIxmRUj+onpnNdJ/fHaCfHZ4KSoyj5UUsLd/vzd
         sohB+VVmFFIE9B4MIF43NHd4K6PmoDLqqB9JIqvlbMygSOVvT+uyxd7+AScA32fT9tiJ
         hwQA==
X-Forwarded-Encrypted: i=1; AJvYcCUWWMuuVNM7t1BODDQdWF/9nuH4Ei8vlXimu6VI92auDhgy1pJHKgk6qgrJILH24Cf/EJdxRnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLpLxGi8R0eVDNGT5mCtKBeH9ZE563hf71x5Nm/UtpzutvA8qR
	Q1mwddiqjfUnFC86U/92YoVTTHbeOG3W6NLHfjie4H2i6rhfEtYveHfsI/hVYTgfi6rzfThyKig
	bynnfd6F+AwtlEPZafahgSZrcCSRapjbNzfUZubO60YOb8NVmy16v9w==
X-Received: by 2002:a05:6402:5191:b0:5c2:1014:295a with SMTP id 4fb4d7f45d1cf-5c8a29f7c88mr5800961a12.2.1727858157430;
        Wed, 02 Oct 2024 01:35:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe9afha6qgSKtgnEwfoZIrqaGl4NvYrwm0BQ8Yeh1sL2Q9OmJ7WOhS8LXAKyAkwfZGwz/sjg==
X-Received: by 2002:a05:6402:5191:b0:5c2:1014:295a with SMTP id 4fb4d7f45d1cf-5c8a29f7c88mr5800928a12.2.1727858156917;
        Wed, 02 Oct 2024 01:35:56 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c882495491sm7278037a12.87.2024.10.02.01.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 01:35:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2FFE2158026D; Wed, 02 Oct 2024 10:35:55 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, Jesper Dangaard
 Brouer <brouer@redhat.com>
Cc: syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Make sure internal and UAPI bpf_redirect
 flags don't overlap
In-Reply-To: <4e04ef28-6c82-4624-ba40-c6072f8875a5@iogearbox.net>
References: <20240920125625.59465-1-toke@redhat.com>
 <4e04ef28-6c82-4624-ba40-c6072f8875a5@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 02 Oct 2024 10:35:55 +0200
Message-ID: <87r08yq4us.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 9/20/24 2:56 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> The bpf_redirect_info is shared between the SKB and XDP redirect paths,
>> and the two paths use the same numeric flag values in the ri->flags
>> field (specifically, BPF_F_BROADCAST =3D=3D BPF_F_NEXTHOP). This means t=
hat
>> if skb bpf_redirect_neigh() is used with a non-NULL params argument and,
>> subsequently, an XDP redirect is performed using the same
>> bpf_redirect_info struct, the XDP path will get confused and end up
>> crashing, which syzbot managed to trigger.
>>
>> With the stack-allocated bpf_redirect_info, the structure is no longer
>> shared between the SKB and XDP paths, so the crash doesn't happen
>> anymore. However, different code paths using identically-numbered flag
>> values in the same struct field still seems like a bit of a mess, so
>> this patch cleans that up by moving the flag definitions together and
>> redefining the three flags in BPF_F_REDIRECT_INTERNAL to not overlap
>> with the flags used for XDP. It also adds a BUILD_BUG_ON() check to make
>> sure the overlap is not re-introduced by mistake.
>>
>> Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast suppor=
t")
>> Reported-by: syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=3Dcca39e6e84a367a7e6f6
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>   include/uapi/linux/bpf.h | 14 ++++++--------
>>   net/core/filter.c        |  8 +++++---
>>   2 files changed, 11 insertions(+), 11 deletions(-)
> Lgtm, applied, thanks! I also added a tools header sync.I took this into=
=20
> bpf tree, so that stable can pick it up.

Great! Thanks for the fixups :)

-Toke


