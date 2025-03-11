Return-Path: <netdev+bounces-173956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D431EA5C8D6
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 16:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61EBF3A4AF0
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A9D25BAB2;
	Tue, 11 Mar 2025 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7dpkxKA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BF71CAA87
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708184; cv=none; b=AYZ+Lj4XFWWVQEgrGf9WE7PzEJ11cNV4waVzK36bWMmQ6C6odQkPEbYDhBBeIRiAae+QfmaQf9C/M0BRJaruxxZL5dfsd5dP2lVuQBEAplb4UmBU93e1IzteQOvloGugoot0AsLMS6ulFJLzfRvbmZEWkuyYpQihC8Ewiu9nL0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708184; c=relaxed/simple;
	bh=foYqW9OK04J8Q2NqOBLUhmyFOU1zRNIIXOs5q7iC+q8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EU5bT2uO0mJhEtFzS1xaa/ciudha9xX2l0sOAWNF7wI+gngMqGp7fRkqc3QKiCfOfhkjtl7p/X1oxRlCTVLVbSrpoCjvjy+/LNQNygMWzc6OF6sHZPtmuop21oHWvk9vTtIeg4jcqF/9tdwFpHUsJLFuplQK5Y6MvOOmovOKa9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O7dpkxKA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741708181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=foYqW9OK04J8Q2NqOBLUhmyFOU1zRNIIXOs5q7iC+q8=;
	b=O7dpkxKAw0dBCokvlNOkBNi7zV68QM3qCdVOLW/mhvCeGVmXYa35mulqtYTCsSN0ZUKEKd
	E7pJ/J56rmrogUllaqGCObkkM3NoI4kBj33OtHF4lAzRd0Wnuy+FWNL1iw5LLuJLDCErxm
	at7OIb8ETqJjVSF47Pi1qsFYaeuVMa0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-8rHXCv00POqDG2Uv6EUIsw-1; Tue, 11 Mar 2025 11:49:40 -0400
X-MC-Unique: 8rHXCv00POqDG2Uv6EUIsw-1
X-Mimecast-MFC-AGG-ID: 8rHXCv00POqDG2Uv6EUIsw_1741708179
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5e5c76fd898so5690844a12.1
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 08:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741708179; x=1742312979;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foYqW9OK04J8Q2NqOBLUhmyFOU1zRNIIXOs5q7iC+q8=;
        b=PBHl2+ljQ8fpab9hoS38231ZuDoxwih9sVvb+6M/X0VaaAtLNKkNAe4Ss/UCQavATa
         RpCWF1SrTqUrHBUORMmkitNUIpsGulwke+81Noz4I1th02xNYTItV7wBH6ubcGWNLUmp
         8LSjEtOgjfafLO+tE97d+jqzjknMGN+ds5o0XGEIA1SrJj2k7KqvPyE6YCrWA8ajn5g6
         rP46hJdnj3m0quzYpVrvqQnzmF7gb8MA/HVWodkfK2uTOu0ncyz5IJBPpUMH/P420Jfl
         tSGKSFwBSqJP5/dv5P6+FFVET4I1/r71sDjTo+b3miV6/zKOb9sevVOzLtszmNoaMtWE
         ENNA==
X-Forwarded-Encrypted: i=1; AJvYcCV8hP5UHfYtpavyKeWoZ1KnKZDH1g0J4yNe4ekjjmwUtAbUo4OSBi8en82JSRoAv6e6B3nSawI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVQCmDYTuPHzBtejb3a/mWtLt+QANk355E5osuegr2Xh+7p3NS
	fGwx9sp7ZkVdbqOCffZU4lHsAHvSCwGB/XWiY9C2BwlJn78C9Tb/Aua9o9lxxlHXkJFvvIXNvuC
	6dczGgt0vtmhYP2QumUEAVnstJSdaqWE5/ylhS8WPRsq337sJMkipJQ==
X-Gm-Gg: ASbGncv0uaOdQTP/1F5WP/NfYZelXec1720RUG5Ir+IrQhQAcVwEjnHidz2DZDKcCdN
	kvc7W1kx+HfYOMf//VmU1OIwWmJJ0G+ty0EGF0mKJt8wiKhKXLJElvnrC0wjOb83uDVn5SRm2Xr
	lcNdL9MhkyVeL29jy0pCUkpXL7S9JDOcRQZaquNYEoHlkfN9a08CYdBVgInXmCoxI4pE0gJOL/m
	EFFjYtUFL06ckWMFKsXrlu70C5M4ZjJagri+CnyxNOthNh/tO+mfB0IXNESY1a5GEKlJ90ZbTar
	ZNC7dnWJHPqJQejbpEGlZIe2NhbkvcEdyV2/8+XI
X-Received: by 2002:a05:6402:2793:b0:5e7:73ad:60a2 with SMTP id 4fb4d7f45d1cf-5e773ad622fmr4182356a12.30.1741708179143;
        Tue, 11 Mar 2025 08:49:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzPIS3wp5ldLk9V7Xnw3rloWKV7sf8sHgpPlBshZma0PeF9lhF6/zpff8hxTefvLpwbyhYNA==
X-Received: by 2002:a05:6402:2793:b0:5e7:73ad:60a2 with SMTP id 4fb4d7f45d1cf-5e773ad622fmr4182318a12.30.1741708178728;
        Tue, 11 Mar 2025 08:49:38 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c733fd48sm8459938a12.9.2025.03.11.08.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 08:49:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4FAF518FA5E1; Tue, 11 Mar 2025 16:49:37 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>, Mina Almasry
 <almasrymina@google.com>, David Wei <dw@davidwei.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David
 S. Miller" <davem@davemloft.net>, Yunsheng Lin <linyunsheng@huawei.com>,
 Yonglong Liu <liuyonglong@huawei.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <2cb9c1fd-db44-4f66-9c5b-03155c6187d6@gmail.com>
References: <20250308145500.14046-1-toke@redhat.com>
 <CAHS8izPLDaF8tdDrXgUp4zLCQ4M+3rz-ncpi8ACxtcAbCNSGrg@mail.gmail.com>
 <87cyeqml3d.fsf@toke.dk> <edc407d1-bd76-4c6b-a2b1-0f1313ca3be7@gmail.com>
 <87tt7ziswg.fsf@toke.dk> <2cb9c1fd-db44-4f66-9c5b-03155c6187d6@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 11 Mar 2025 16:49:37 +0100
Message-ID: <87frjjin3i.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pavel Begunkov <asml.silence@gmail.com> writes:

> On 3/11/25 13:44, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Pavel Begunkov <asml.silence@gmail.com> writes:
>>=20
>>> On 3/9/25 12:42, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Mina Almasry <almasrymina@google.com> writes:
> ...
>>>> No, pp_magic was also my backup plan (see the other thread). Tried
>>>> actually doing that now, and while there's a bit of complication due to
>>>> the varying definitions of POISON_POINTER_DELTA across architectures,
>>>> but it seems that this can be defined at compile time. I'll send a v2
>>>> RFC with this change.
>>>
>>> FWIW, personally I like this one much more than an extra indirection
>>> to pp.
>>>
>>> If we're out of space in the page, why can't we use struct page *
>>> as indices into the xarray? Ala
>>>
>>> struct page *p =3D ...;
>>> xa_store(xarray, index=3D(unsigned long)p, p);
>>>
>>> Indices wouldn't be nicely packed, but it's still a map. Is there
>>> a problem with that I didn't consider?
>>=20
>> Huh. As I just replied to Yunsheng, I was under the impression that this
>> was not supported. But since you're now the second person to suggest
>> this, I looked again, and it looks like I was wrong. There does indeed
>> seem to be other places in the kernel that does this.
>
> And I just noticed there is an entire discussion my email
> client didn't pull :)
>
> At least that's likely the easiest solution. Depends on how
> complicated it is to fit the index in, but there is an option
> to just go with it and continue the discussion on how to
> improve it on top.

Didn't seem to be too complicated, assuming no problems appear with
using the middle bits of the pp_magic field. See v2 of the RFC, or here
for the latest version:

https://git.kernel.org/toke/c/df6248a71f85

-Toke


