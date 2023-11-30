Return-Path: <netdev+bounces-52530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 789CC7FF0F8
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 14:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E861C20D37
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 13:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BE548787;
	Thu, 30 Nov 2023 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6jpkfrp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D401B3
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 05:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701352554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGrL90Etrr9V73ll7rDSIVqdC8n1ownVWJtUzMBU8oo=;
	b=U6jpkfrpTx5mc0SyezSPvaveGIJ77z7gg43rsNjWXNCrd+tDJ3is12Quy3lT7BBJPNGqC6
	B2VJNxc0Advn/lxxQ4VzhEvSjJQhZEnxJbV3kaWpGedMZ5s1ERTuUmly9dXXo892kcrBaV
	RW5pL+7Tz9wmunHkiAxNnGxI7piCmAc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-KquQBu2RPJaHRgV7Z_-etg-1; Thu, 30 Nov 2023 08:55:52 -0500
X-MC-Unique: KquQBu2RPJaHRgV7Z_-etg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1867751573so137332966b.1
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 05:55:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701352551; x=1701957351;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGrL90Etrr9V73ll7rDSIVqdC8n1ownVWJtUzMBU8oo=;
        b=FjfAGAij8rgD1C9VUDsHoTOnVrU1mALp58ahUpa6sWapilEL/ZiM8wN8t7Y+s3LdT5
         AC39XfB2dJfbuHiLhe+ZDA71zLcR8mvNJfmpPjrWg4ONZxxNxh2w/LbdstAjrHJS2gZN
         0S6AICacawD2jh3vn1PLxl34GmKfI4HxaT+zbeBgBTSdE6A/MsomQqTn7Q5msY+U62EZ
         X1WQJPHECiWyiMIH2KBYt/hmB7l1258odH9C42WUGlFrCh1wa3QAR3uzqFU8CnO4oCAK
         rR2GEdahKG+23vwOz161NWvYagBy2CmEGzmtm4Nbw9KOyrAecx3IMwGaQ/+uYixAym8S
         ywhA==
X-Gm-Message-State: AOJu0Ywbc7dD/hxS9cYIs8Pl+SNmWIXk/+jVT17MEWKMBgyi+dQZj/Ar
	wFe9nBflLMwNvXLhFupS3eegNThPpRRDRdd9CcMF8qPM5gGiS2y+BxNgIEOmYr++AszkegaSGMZ
	AlgfpOjX5PznW10K2
X-Received: by 2002:a17:906:2096:b0:a18:d028:1cce with SMTP id 22-20020a170906209600b00a18d0281ccemr1182184ejq.35.1701352551492;
        Thu, 30 Nov 2023 05:55:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHg3ne5YwP5WnJehuvdpfEMr2u2ALVAAGZQb8Dpga9/0bhigqzGIOq/KC7JDEHBRCT8qDexjg==
X-Received: by 2002:a17:906:2096:b0:a18:d028:1cce with SMTP id 22-20020a170906209600b00a18d0281ccemr1182160ejq.35.1701352551161;
        Thu, 30 Nov 2023 05:55:51 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906100d00b009b2ca104988sm698612ejm.98.2023.11.30.05.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:55:50 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6FF9BF784AC; Thu, 30 Nov 2023 14:55:50 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>, Edward Cree
 <ecree.xilinx@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yan Zhai <yan@cloudflare.com>, Stanislav Fomichev <sdf@google.com>,
 Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, kernel-team <kernel-team@cloudflare.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Sitnicki <jakub@cloudflare.com>
Subject: Re: Does skb_metadata_differs really need to stop GRO aggregation?
In-Reply-To: <1ff5c528-79a8-fbb7-8083-668ca5086ecf@iogearbox.net>
References: <92a355bd-7105-4a17-9543-ba2d8ae36a37@kernel.org>
 <21d05784-3cd7-4050-b66f-bad3eab73f4e@kernel.org>
 <7f48dc04-080d-f7e1-5e01-598a1ace2d37@iogearbox.net>
 <87fs0qj61x.fsf@toke.dk> <0b0c6538-92a5-3041-bc48-d7286f1b873b@gmail.com>
 <87plzsi5wj.fsf@toke.dk>
 <1ff5c528-79a8-fbb7-8083-668ca5086ecf@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 30 Nov 2023 14:55:50 +0100
Message-ID: <871qc72vmh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 11/29/23 10:52 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Edward Cree <ecree.xilinx@gmail.com> writes:
>>> On 28/11/2023 14:39, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> I'm not quite sure what should be the semantics of that, though. I.e.,
>>>> if you are trying to aggregate two packets that have the flag set, whi=
ch
>>>> packet do you take the value from? What if only one packet has the flag
>
> It would probably make sense if both packets have it set.

Right, so "aggregate only if both packets have the flag set, keeping the
metadata area from the first packet", then?

>>>> set? Or should we instead have a "metadata_xdp_only" flag that just
>>>> prevents the skb metadata field from being set entirely?
>
> What would be the use case compared to resetting meta data right before
> we return with XDP_PASS?

I was thinking it could save a call to xdp_adjust_meta() to reset it
back to zero before PASSing the packet. But okay, that may be of
marginal utility.

>>> Sounds like what's actually needed is bpf progs inside the GRO engine
>>>   to implement the metadata "protocol" prepare and coalesce callbacks?
>>=20
>> Hmm, yes, I guess that would be the most general solution :)
>
> Feels like a potential good fit, agree, although for just solving the
> above sth not requiring extra BPF might be nice as well.

Yeah, I agree that just the flag makes sense on its own.

-Toke


