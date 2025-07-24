Return-Path: <netdev+bounces-209725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFA7B109AE
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61DF717BED0
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 11:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C918C2BE638;
	Thu, 24 Jul 2025 11:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="R1rD5iD4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C012BE633
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 11:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358168; cv=none; b=iaelQzl+3Se4OuteoFp4DcqoUxnAEhcyxCgBvNGTNdHp+0FQ6wvS/IWGwcV8GtKwjvnefAUa6mwJIhvRyttUvMtHrhpDCYcNY1YiUnuMlzZIDQ7Y7A60wl3aTUHfRPxR7LOEGQ+EnxwkeiUgxnTCf7oIGhFH80cRNdHK95JAUwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358168; c=relaxed/simple;
	bh=urnvLDEnBW4wv6etiKCX8sOFla/G58/fHUKcD0ZzOhU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qsFqH/9Nl+go6Ah2i6RT9segf5u+9dVDEwZsCRpFbkXPxOSy0cm7bR50x0OBg3wWoPgdG8YPBZHsK4T7N1XFeFsD1jeOwmbE652hG5VsrPFcluwSaV/BHyLcG3B+ltgmugZ0YMwFi0E3DhgGYZ0OTzo0hiWCkp6LdXRsAlxpbMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=R1rD5iD4; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60c01b983b6so2183235a12.0
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 04:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753358165; x=1753962965; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=urnvLDEnBW4wv6etiKCX8sOFla/G58/fHUKcD0ZzOhU=;
        b=R1rD5iD4/I3JEgCwmvkiylHv/Qx+NeeRQx65/t8FH1Irfr3wTeW0DqWF8fFsVVISLo
         EFXZYoJZwwMkj6+QLrtF+B/ac5LkP9gn1p8zeFvPuEi7zS+3fpVzbhfzRBlDo1dE4NFI
         ZI26/J36NwNBzSD0JWWxAeuhGuvBadZ0S1I9qw37MqQgS4ecOG+YxDBX0osGnlGC8zmd
         O41oYjgMGMR2P3VZ/j6sIz5Em7C7HeQvEeS5wlY4vCrFOMhgAkxZH/7KNxOGuQZZ0eVf
         8nBY7cv6d37y9PngXp862lpVoJuAB+K0yjY2jTRfhqinMoifPP+wln0jFV9rZAsaHevP
         jSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753358165; x=1753962965;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=urnvLDEnBW4wv6etiKCX8sOFla/G58/fHUKcD0ZzOhU=;
        b=oYLVyjEcdAqmVy/9LQZ2tUJ2lXSCBFvsv2FEG120gipdueMWBn+N6xcdqFkD7HK98k
         TXG1kkEOFnS5BULbxM1SkGqA7eygJLX8NA/duj256Cnxf+rBKk5IvQyG5lVG6HIrNUaQ
         AImYt2p8xaSyshhtWCelNv8OtC2a687hUi34NwZnDP6DRgTU8+5Adj4KqOBB2NUo3DyB
         MzzccyY88if9qO5P79Vjok5FIpI4NrAIrh3ZEXeo9+8H21LO55iEKT7hhpL/oKd3mJ0Q
         9LgEVsadlQZ/FTJibq6TNyUxwJHIm+DX0NvgR+3eVzTZaCcsXlM6kIh7coSSIF/4Y361
         ow2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXHLOWHwTUGy5ou55oPz8u4zN0RN5FIKMSY6uNQiBdNa2lSqslzQZHoe2tVd7xA0sM+RPYhN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK02+/J4paZMK+2uwf7EdpZE012ng7h9iGyTxcsKC2rewku2Lc
	8XHULoFZqdZ0pXyQ5ysWlyw3X0/HyvZQmVdFY9/dtNnPtMuePOAmH3Iwgw0lnKBeQeo=
X-Gm-Gg: ASbGncupGmRNpD8rId2IQ9cHKvNdD4ShkKzDPNk4GGC+i0YWzOcOiAv0FJS8ntKzfr6
	u3xI1targxxqs2Jy4Eif2NHWlbGq6N2TH6PnKpMtS1i+D2PyF+8lhNaKRu1B8/StlFpwYgBTAA6
	cAp8X6Bynl9UY1UGTIG1ZdbZ/fvxtr+umbIM5Ik/6rPtzY0UpNxQtF7k0yuSWylREhsm7rUUbl+
	TV5vnBjntq1LHjm6dQ7IdZq4pOXuPtmmeQbW9NX05V576fKz14EkRpuHZcMGC6ixJacJzzQ3puQ
	o6KlxrzValYWpf9n5+DhpKrQYAbFjQW1bwusS5ZMLLq2K+KiaYGaaFhkxQAAyYiqtkkVot9eC2g
	6hAU1m/zi7GSxCkmQd0WiI9NOWA==
X-Google-Smtp-Source: AGHT+IF918c8okf/WACNVzYyYzvJD7eD9Ppe1ib0SvipyeviwFxo1UpP0mVqL02li897zwj8/2ETmA==
X-Received: by 2002:a17:907:86a4:b0:ae6:d3b8:81d7 with SMTP id a640c23a62f3a-af4c395c91amr183730266b.30.1753358164519;
        Thu, 24 Jul 2025 04:56:04 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:5f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47f44eaf5sm102705166b.80.2025.07.24.04.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 04:56:03 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,  Andrii Nakryiko
 <andrii@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Eduard Zingerman <eddyz87@gmail.com>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Jesper Dangaard Brouer <hawk@kernel.org>,  Jesse Brandeburg
 <jbrandeburg@cloudflare.com>,  Joanne Koong <joannelkoong@gmail.com>,
  Lorenzo Bianconi <lorenzo@kernel.org>,  Toke =?utf-8?Q?H=C3=B8iland-J?=
 =?utf-8?Q?=C3=B8rgensen?=
 <thoiland@redhat.com>,  Yan Zhai <yan@cloudflare.com>,
  kernel-team@cloudflare.com,  netdev@vger.kernel.org,  Stanislav Fomichev
 <sdf@fomichev.me>,  bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 1/8] bpf: Add dynptr type for skb metadata
In-Reply-To: <00a19156-cf90-48ca-be91-6c218b317044@linux.dev> (Martin KaFai
	Lau's message of "Wed, 23 Jul 2025 18:54:53 -0700")
References: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
	<20250723-skb-metadata-thru-dynptr-v4-1-a0fed48bcd37@cloudflare.com>
	<00a19156-cf90-48ca-be91-6c218b317044@linux.dev>
Date: Thu, 24 Jul 2025 13:56:02 +0200
Message-ID: <87pldpx0od.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 23, 2025 at 06:54 PM -07, Martin KaFai Lau wrote:
> On 7/23/25 10:36 AM, Jakub Sitnicki wrote:
>> More importantly, it abstracts away the fact where the storage for the
>> custom metadata lives, which opens up the way to persist the metadata by
>> relocating it as the skb travels through the network stack layers.
>> A notable difference between the skb and the skb_meta dynptr is that writes
>> to the skb_meta dynptr don't invalidate either skb or skb_meta dynptr
>> slices, since they cannot lead to a skb->head reallocation.
>
> There is not much visibility on how the metadata will be relocated, so trying to
> think out loud. The "no invalidation after bpf_dynptr_write(&meta_dynptr, ..."
> behavior will be hard to change in the future. Will this still hold in the
> future when the metadata can be preserved?
>
> Also, following up on Kuba's point about clone skb, what if the bpf prog wants
> to write metadata to a clone skb in the future by using bpf_dynptr_write?

Good point. If we decide to implement a copy-on-write in the future,
then this will be a problem. Why tie our hands if it's not a huge
nuissance for the user? Let me restrict it.

