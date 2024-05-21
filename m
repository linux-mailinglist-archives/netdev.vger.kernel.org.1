Return-Path: <netdev+bounces-97323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAD88CAC29
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 12:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEEA21C21A72
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 10:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9BC7EF1F;
	Tue, 21 May 2024 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZH/sUGn8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC706CDD5
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716286757; cv=none; b=PzgZRl6D9DZ53K64eDp3g4a2uF78FWh1a69WUZAVtkltqNPqiM8EjyDlz62doKagIhCVmqD5VJdTreV89ec3WjZmUB5cfLJJvdj3UbMhA5tcWKPgaUgkTwzBJ2MvesDVkpoxq9jxXO0FiNU2ohL6Thsl6VA+ecqVHQf2/Pi2pig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716286757; c=relaxed/simple;
	bh=m/BnOv9IyIknk0taxfZ9in2qMKbBmTm62BEIyazTekA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MJOl0d1PRaUf/B/3dDBNPZI7dFCe5hTak2Q+Z9fOUHdsYo6DPPa2iyblVO0lhiVEqjj7f55mKsU3QUqz92cJCB2ScpUzN62ml9M219MrWeQfBluT8AyuLuR9pJVF0/CBz1B0F5Z1tAQiV8+ivIJpbpDuaHgF0WJtCAyBmm7nLrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZH/sUGn8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716286753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GDN4wBeS+zyaK3mckFLu3ekq1g2jhLMHXCljitfNdOI=;
	b=ZH/sUGn8K2YAspUoGR+gQSTolGOc20+vCPs/g2soRpUTAaYRQTtWGt0sUOfFtHHFiT+epV
	MAJjlG3sJYvYRws0G+0WYPi/1SCd6EC4LENX8YpITH6ZQakQkTkuRoQiJxoXmiSefdSs/h
	hHM5L+Jxs/eLI0ugbu0pGP2KaMqYVGI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-r4D7flVbMvCjNcg7YzBN8w-1; Tue, 21 May 2024 06:19:12 -0400
X-MC-Unique: r4D7flVbMvCjNcg7YzBN8w-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1ec401f87d3so141432375ad.1
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 03:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716286751; x=1716891551;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDN4wBeS+zyaK3mckFLu3ekq1g2jhLMHXCljitfNdOI=;
        b=odUVwlmn8OIcwUagP9OjtZl7/QhOwrd5qzEq1wbnGoPbp73FYxCsngdcgQGX5LFP8f
         DFUBQfBCqXVx31LBxKrRpXwpY/Af06CVltbhpLo/XqZh554Qw9Wu9vLIfAGeuXjvcXZO
         FnAxq8CBgVbqfoI+RSphbI4t56XZCGEgryjiLa8stM903+Zl+bv3oheoSI+7/3gNnc2x
         3CMWvZE8x7MPlWV7i0rlWQtzL5EPB3NtqP0y9epqh7zgcEzlC7vwTnH+XZ+pNMgFfowi
         YbgEZciNiTqUYaSingmDKddQDPaB6bdLyxx9qcpCuVvwhPZLG9qXJ43PKXuj+9Zja+Zp
         xEDg==
X-Forwarded-Encrypted: i=1; AJvYcCU3aGlmD6zT913EwAZB3qwoYqX/vExO5zLr+Cjh3RfFnXNyHjxLldY//1ko5oL94EfoPefvK1BwXag1qs0VzpmH9Z67dbDR
X-Gm-Message-State: AOJu0YxyhBtX2/y8E8YKbnlsMOm9vgFIHVcullpL3ZA/fOJ2DQ9kIfLE
	AmoOR52rax30zpuMnwESsW6IqmhWJqj9hcOEE44A0z1+hJTPkwYKLM22pa3QC6nTLMeq2fzH4oT
	sgzFJB3mkFKqi6A/2zUYmJ1ZB/jiWVCFx5gyGMmm7ftPQpfPomk5l0w==
X-Received: by 2002:a17:902:ec83:b0:1f2:f0d3:db30 with SMTP id d9443c01a7336-1f2f0d3e367mr98973225ad.64.1716286750933;
        Tue, 21 May 2024 03:19:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvvHcjqOjtYCqzf1Shk/DnxCibhC9dkl7mU3+4cXSE2zbcJWmISDdAei0dLnJPKrfutGYx0w==
X-Received: by 2002:a17:902:ec83:b0:1f2:f0d3:db30 with SMTP id d9443c01a7336-1f2f0d3e367mr98973045ad.64.1716286750535;
        Tue, 21 May 2024 03:19:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c2565b6sm217542135ad.295.2024.05.21.03.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 03:19:10 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B10B312F75B4; Tue, 21 May 2024 12:19:05 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netfilter-devel
 <netfilter-devel@vger.kernel.org>, Network Development
 <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Florian Westphal
 <fw@strlen.de>, Jesper Dangaard Brouer <hawk@kernel.org>, Simon Horman
 <horms@kernel.org>, donhunte@redhat.com, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] samples/bpf: Add bpf sample to offload
 flowtable traffic to xdp
In-Reply-To: <CAADnVQLV4=mQ3+2baLhfJi_m6A72khNxUhcgPuv+sdQqE7skgA@mail.gmail.com>
References: <cover.1716026761.git.lorenzo@kernel.org>
 <8b9e194a4cb04af838035183694c85242f78e626.1716026761.git.lorenzo@kernel.org>
 <CAADnVQLV4=mQ3+2baLhfJi_m6A72khNxUhcgPuv+sdQqE7skgA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 21 May 2024 12:19:05 +0200
Message-ID: <87ttira2na.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Sat, May 18, 2024 at 3:13=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.=
org> wrote:
>>
>> Introduce xdp_flowtable_offload bpf sample to offload sw flowtable logic
>> in xdp layer if hw flowtable is not available or does not support a
>> specific kind of traffic.
>>
>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> ---
>>  samples/bpf/Makefile                     |   7 +-
>>  samples/bpf/xdp_flowtable_offload.bpf.c  | 591 +++++++++++++++++++++++
>>  samples/bpf/xdp_flowtable_offload_user.c | 128 +++++
>>  3 files changed, 725 insertions(+), 1 deletion(-)
>>  create mode 100644 samples/bpf/xdp_flowtable_offload.bpf.c
>>  create mode 100644 samples/bpf/xdp_flowtable_offload_user.c
>
> I feel this sample code is dead on arrival.
> Make selftest more real if you want people to use it as an example,
> but samples dir is just a dumping ground.
> We shouldn't be adding anything to it.

Agreed. We can integrate a working sample into xdp-tools instead :)

-Toke


