Return-Path: <netdev+bounces-145234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F4D9CDD3C
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 12:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5406B23C81
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 11:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B481B6CFF;
	Fri, 15 Nov 2024 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqrSKY3g"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670BB1B652B
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731668833; cv=none; b=JBoyT4niiZdWzckCfjf+4x04sb4V5vM8TnGgNfKzNDyVS+l1UIj6a/0GZQ4s0avYIJtNwJdvBna6Id40kJDDvBAAncGzU9g8r/2SzxQmxeUhjyGtX1KnwWunZ65MRUlGjz+JWFZs6SnEeR15SGJuA4HO0gMQroYEq0/Vk83qPcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731668833; c=relaxed/simple;
	bh=/Be/Q3Pv/gZYXqIqwnuQYODJ0P9sar7TAP2czlgo7NI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gf850M+e93c4XPs0UKWRdz6qzA2OyXEyxhU6cO+7F8UO2k6NA2dnn9KAAkey4X4FWSH6p+hy5dWibBVMeQ1o1vndl2tOVGiaoV5uMiOopYnv/MAU2pgtlAsPefJfIfPg38vqOzGZ5rfClEqiOZ3tmAqjXxS2nun13dXlEayLG5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TqrSKY3g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731668830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Be/Q3Pv/gZYXqIqwnuQYODJ0P9sar7TAP2czlgo7NI=;
	b=TqrSKY3gY4PCJVW6cu50J6FvMYKJf8ZGVtoCXh8ikody4Gz7KDbqQyCKsNk20FvfVT6DtI
	e1+ROKYObgUEKc2BYWdFSKHxyMoXphxUCHZ5dWtsJmM96jd3F7WLTY4IT8vsAellflL5/E
	AFJykrxM9O9VCTzIoh7B8e6mRqkROus=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-2VDkJo6iO22t0U76GK23cA-1; Fri, 15 Nov 2024 06:07:08 -0500
X-MC-Unique: 2VDkJo6iO22t0U76GK23cA-1
X-Mimecast-MFC-AGG-ID: 2VDkJo6iO22t0U76GK23cA
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5cf88ebda56so720750a12.0
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 03:07:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731668827; x=1732273627;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Be/Q3Pv/gZYXqIqwnuQYODJ0P9sar7TAP2czlgo7NI=;
        b=YjucaZAxVquY2cH59tU+cG4czw/BlBNDwIwqL0ZLmRCnGXIjd0TPNa7Uf/ILdi9rsO
         nElbxRiLvPF26WcXXz5VhvgZOz9dUMQLQAO1XtZjy8Sow8TvlKvqHhjfE/AHl6C1sl91
         saolFz4tualn0XzGZkSZz2OCSlipW+VeZanfrcFqNz+trr2cl8v+3w5figRbelH4tczo
         j5voCWKKhecIRnX5bBArfhDfGEo+QEh8n7zHxarycaEYZUA7j9Y1dhRdNnw2GHN2x1a9
         Jws2Ml/klSaezDPGeEQo9BLo+kN8X4OMOeU4lQUAnPH/BsaQUguNKZ/NSM1/XoyZ0ukA
         Gs+A==
X-Gm-Message-State: AOJu0YyFRl7hQ3TddxqstKt4p86jKpg8wcfYlWapxAk9EQHlYWFYPnkV
	nZ6h3RjxecSSWbJFku7E/cp1M/r64blm2nqPd8bB0JwYYRSWjWvSatqtLFml5u52XXsEJS8b4Ra
	CfF+jLiO9RgsBXQKcJbFpRHnDnAGQvyqZQE0rjwZDJpzUoUeiI5fTKPtfiKzs1Q==
X-Received: by 2002:a17:907:3ea6:b0:a9e:e1a9:792f with SMTP id a640c23a62f3a-aa48347e6acmr192610266b.25.1731668826832;
        Fri, 15 Nov 2024 03:07:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFErEXMy1ftFsgtlFkean6KMt2WjV+feVxB3C/tYQRW2vJwMK02kXKvbvss1qizejGe1PQew==
X-Received: by 2002:a17:907:3ea6:b0:a9e:e1a9:792f with SMTP id a640c23a62f3a-aa48347e6acmr192607366b.25.1731668826413;
        Fri, 15 Nov 2024 03:07:06 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df501f9sm167303366b.46.2024.11.15.03.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 03:07:05 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 964DE164D1A8; Fri, 15 Nov 2024 12:07:04 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Ryan Wilson <ryantimwilson@gmail.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 ryantimwilson@meta.com, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH bpf-next] bpf: Add multi-prog support for XDP BPF programs
In-Reply-To: <CA+Fy8Ub7b1SXByugjDo-D13H_12w0iWzQhO-rf=MMhSjby+maA@mail.gmail.com>
References: <20241114170721.3939099-1-ryantimwilson@gmail.com>
 <CAADnVQJ2V6JnDhvNuqRHEmBcK-6Aty9GRkdRCGEyxnWnRrAKcA@mail.gmail.com>
 <CA+Fy8Ub7b1SXByugjDo-D13H_12w0iWzQhO-rf=MMhSjby+maA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 15 Nov 2024 12:07:04 +0100
Message-ID: <874j48rc13.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ryan

I'll take a more detailed look at your patch later, but wanted to add
a few smallish comment now, see below:


Ryan Wilson <ryantimwilson@gmail.com> writes:
> On Thu, Nov 14, 2024 at 4:52=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Thu, Nov 14, 2024 at 9:07=E2=80=AFAM Ryan Wilson <ryantimwilson@gmail=
.com> wrote:
>> >
>> > Currently, network devices only support a single XDP program. However,
>> > there are use cases for multiple XDP programs per device. For example,
>> > at Meta, we have XDP programs for firewalls, DDOS and logging that must
>> > all run in a specific order. To work around the lack of multi-program
>> > support, a single daemon loads all programs and uses bpf_tail_call()
>> > in a loop to jump to each program contained in a BPF map.
>>
>> The support for multiple XDP progs per netdev is long overdue.
>> Thank you for working on this!

+1 on this!


[...]

> Note for real drivers, we do not hit this code. This is how it works
> for real drivers:
> - When installing a BPF program on a driver, we call the driver's
> ndo_bpf() callback function with command =3D XDP_QUERY_MPROG_SUPPORT. If
> this returns 0, then mprog is supported. Otherwise, mprog is not
> supported.

We already have feature flags for XDP, so why not just make mprog
support a feature flag instead of the query thing? It probably should be
anyway, so it can also be reported to userspace.

>> I think it will remove this branch and XDP performance will remain
>> the same ?
>> Benchmarking on real NIC matters, of course.
>
> Good point. I will migrate a real driver and add XDP benchmarking
> numbers to v2.

Yes, please, looking forward to seeing benchmark numbers!

-Toke


