Return-Path: <netdev+bounces-73271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A7A85BA79
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 12:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0611F25E9D
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 11:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7C867752;
	Tue, 20 Feb 2024 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tt3N7L2z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4349666B58
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428235; cv=none; b=rQq3fKxRHfQUQoIxVKhSUDzBE7qfLC9yI01d6Ivr0h8mGwRIHTh1WbJ+lGPsnGwrap6b4xSg6fAHL6Q/+g7Q9wMZctlNPq7+gIDvkDjGswE/1an9J4XksCZ3vgG6/Cgp1u8qgM3gr0v13M/UX87f4E2Wfcs4uW6cQPtll7KdahY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428235; c=relaxed/simple;
	bh=/m5l675lvhpdek52eIYzQ2WRIO9Em8rH6DpHO14nHoc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EnzzxtFBOAonX7eIrw/QVuqm6c9TAi8VrMPcSFa2SL/JijssGle2B+zISXFvPzp+S2fQQJ2GkWDJbkirjCQ/yJMLFuaAyiOa8JOdbKPIiVrajJpMHzymJ7QTAz/QrU7GxGz6XGo4s/i5NpLwkOhg96VcG+vOs793ufr41G/nikM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tt3N7L2z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708428232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHBopp27NiYjGG/312hFWNf4Ro7Aht8Q8wDQZilTwiY=;
	b=Tt3N7L2zHxfK1yCz8i+eaFnKrR8EtZ5lQSKtUEo5gRlCdWV0zj0nnlKm+hpLN4fUiDe3il
	DvS+ksHa1QNk8TQpgFIYwTLEalsaZv8GBfdITauz5OBE4NjCAEJucCx9R+mmv+NkaQKkdm
	hTXtDAtBC9ADlxC1w7l/YjRW1drV/us=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-cGki9KoKOs2Q9Ds0kaEakw-1; Tue, 20 Feb 2024 06:23:50 -0500
X-MC-Unique: cGki9KoKOs2Q9Ds0kaEakw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a2bc65005feso384808766b.0
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 03:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708428229; x=1709033029;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHBopp27NiYjGG/312hFWNf4Ro7Aht8Q8wDQZilTwiY=;
        b=RYJjUfY8s6eROiPFud6k5qpXeT13kNszIBYcv0E8iRw/azmHRgJOdDRgOcpeWUqPTB
         1v3WMGsABr/9piDBRLBxSM0EwPvFC2Ah5DGmG2fgYZ/Wq5SQnWlU7LlCgRGPwZRh5ULA
         CvWlcVcXREYxEc1tkStlKtJ9Ypsv3HsD31h6xFRuRiLvYSaPcaG9zSQgzOKfbCpd9hd9
         XZH4g2uHNeQ89S/6J/PPNP0F35JXMABEPRYzZeTdGOTMBgCZ4wY/aqiiGAsGdUU6LbkG
         MeBdtH4hb4pJ8a+uEJpr6RstS3XMZscxxWfV/LZHruvO/dCV3x8IpSJ0x5FaJmWtC/eQ
         eHiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQKb6pV85UbE9GzEeW1Vg+LqUvSMdBmC+m3euA/5hlWHQx/dsw0rgOJ/Zu6qSoF8QHt8bw1DMPaZMGdH0CRpWqe+rZOScv
X-Gm-Message-State: AOJu0Yyu4/VPJDOfNI/7Mtjp4jMVisI1xT0+qUzdi4GTrmWGDga4EiiK
	CHOyTf33K4xPlHgqquEvjmoik3lCFWaphngwJnsBhNoVFOhgq/LCpJsTlXjZ1pODSLcL/wdmXCE
	rx03DFqYWmH2+BxvB4kol1BloWQz+zZUprN96hMezbbfg+NwAZWql2w==
X-Received: by 2002:a17:906:6b99:b0:a3e:6a25:2603 with SMTP id l25-20020a1709066b9900b00a3e6a252603mr3484336ejr.33.1708428229728;
        Tue, 20 Feb 2024 03:23:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHn+dYqYLg6+WkxQUfBYPRXWnBfJq01cV9qnvwWwoJA6M4vithRhzp4KiPcpYPiB6huGquIYw==
X-Received: by 2002:a17:906:6b99:b0:a3e:6a25:2603 with SMTP id l25-20020a1709066b9900b00a3e6a252603mr3484320ejr.33.1708428229358;
        Tue, 20 Feb 2024 03:23:49 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ld1-20020a170906f94100b00a3e82ec0d76sm2214072ejb.113.2024.02.20.03.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 03:23:49 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8C19710F62CB; Tue, 20 Feb 2024 12:23:48 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
 <ast@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] Change BPF_TEST_RUN use the system page
 pool for live XDP frames
In-Reply-To: <631d6b12-fb5c-3074-3770-d6927aea393d@iogearbox.net>
References: <20240215132634.474055-1-toke@redhat.com>
 <87wmr0b82y.fsf@toke.dk>
 <631d6b12-fb5c-3074-3770-d6927aea393d@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 20 Feb 2024 12:23:48 +0100
Message-ID: <87o7cbbcqj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 2/19/24 7:52 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>>=20
>>> Now that we have a system-wide page pool, we can use that for the live
>>> frame mode of BPF_TEST_RUN (used by the XDP traffic generator), and
>>> avoid the cost of creating a separate page pool instance for each
>>> syscall invocation. See the individual patches for more details.
>>>
>>> Toke H=C3=B8iland-J=C3=B8rgensen (3):
>>>    net: Register system page pool as an XDP memory model
>>>    bpf: test_run: Use system page pool for XDP live frame mode
>>>    bpf: test_run: Fix cacheline alignment of live XDP frame data
>>>      structures
>>>
>>>   include/linux/netdevice.h |   1 +
>>>   net/bpf/test_run.c        | 138 +++++++++++++++++++-------------------
>>>   net/core/dev.c            |  13 +++-
>>>   3 files changed, 81 insertions(+), 71 deletions(-)
>>=20
>> Hi maintainers
>>=20
>> This series is targeting net-next, but it's listed as delegate:bpf in
>> patchwork[0]; is that a mistake? Do I need to do anything more to nudge =
it
>> along?
>
> I moved it over to netdev, it would be good next time if there are depend=
encies
> which are in net-next but not yet bpf-next to clearly state them given fr=
om this
> series the majority touches the bpf test infra code.

Right, I thought that was what I was doing by targeting them at net-next
(in the subject). What's the proper way to do this, then, just noting it
in the cover letter? :)

-Toke


