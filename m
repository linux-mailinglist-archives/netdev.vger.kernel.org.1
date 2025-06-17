Return-Path: <netdev+bounces-198543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CC5ADC9ED
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C43A1895EF9
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D83C2DF3E5;
	Tue, 17 Jun 2025 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gy30+hvU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B292DBF5B
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 11:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750161049; cv=none; b=EDA3fvCSfv8n9AfJkfR9+P/IUJ5sTOT17RkLSpkSi1ICyY+QTVukjm0R1VONqiFpJKeJeUnwWLUOVmvXyVi5qSO/d2OkeiDGCKBY9TUPKM/WRA3kuuvLrz5CtF/XOePI4qu3jNlkJCF3KfdYjnU/8Yswsk+inY5Jgs6h20w6t3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750161049; c=relaxed/simple;
	bh=CMEvHtovuOnGIc1rTZGMc9rVeZZhQF3JXBIvA0rIwko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tGTvVovtYs4ElxtYHW8+0pOkb7L+giJS/waFnmqXavwZcBNGvzbwxrTstWCnIH4sK9wH9iRG+19yfIghbW1jyl/MVDJ766Y93gfSCQ+m5upXqMZ/D1/l08bfAY8C+LFBGmXP/Vh6khmrTWaMMVeIRliho4dSqy7nL8X6U3gd1CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gy30+hvU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750161044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n6S7kglB5eHzSexcMtlRWN6miYn5xNKkF2nKI45AFNk=;
	b=Gy30+hvUflEOIR6BgJ4tM0MyAO+BL2iPbFepJ3esUBg9MBRa0vQ/nZA8q8Ab7oDWgw0XkN
	Lq12kv2GPajCU1Dhu+0UiTlcxdWg2VaxVj6XyEytVKnQjr3fWKnnHFCifL70xTHYKt6vbf
	6yqub/uVn7v8jHCQdqaim6NguUMr7KE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-YfcfEatFPaCZK2AClt81bg-1; Tue, 17 Jun 2025 07:50:43 -0400
X-MC-Unique: YfcfEatFPaCZK2AClt81bg-1
X-Mimecast-MFC-AGG-ID: YfcfEatFPaCZK2AClt81bg_1750161042
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ade6db50b98so567267066b.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 04:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750161042; x=1750765842;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6S7kglB5eHzSexcMtlRWN6miYn5xNKkF2nKI45AFNk=;
        b=p3wBVyzCjFu2MlZfxU/xVnAc0J7J1ja73fTgcdNHgO5rkvRJY8wMGdXprHvbIGKGB6
         GVSbjxI+PY5VhR/oaN/P2IlSaWyJPtqQ7z4LDELPe9/DLAYVRtOB8ckFN2FSj2ROZwtI
         sSwXDnhAq++4SKkd5gjCQJsrZ19N8H66amMrgjiPzZaFxcU/wG4DALEDQp+9NSvgv4Kj
         Y7Akl/3VKvWYalHqO6Z6lJrIK1tscMeDCGrQy7TOBms6YJxME7UfXp86HruqnnfeRfVZ
         7ELGKhdVQAL7rqX3M+B3W1eDqzexrh/XuL8Sr3BHStDUxtr7cPhGtuI09HxnUaR9A6Lc
         vZ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUaG+/gNR2JyqTXqCP6RM67WGh3CaxQ40DO5w7wPHr8nsfeZ7dP6R/wvAPTp4PkjZES7vDTw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDSR/qWWF3dtePNAS7uRhh/V8PXQIce3mGsbDJsx4AwD0jHZNA
	wBB07KuCPJUxrqZszyOYZR2Lc1iTVgh9NBG/u30RDHcZq2tJNQqetNM5SlSPLXp7kAUlWxqE73Q
	nOdAIfZR+icrYII+CsAJ5yZQbpH7KPST1tFdEyrXvwGWcK0w1DoDNOyUSSQ==
X-Gm-Gg: ASbGncudbrwfAOQyeoZNkD5JNY0DreSYa03djRMh/a/bqr2m4s9ZpFa1DWsLOtJxCox
	VRfLTutGObK+qa4bcHYPkcZ3PedDJUlBHpChdt79OAOZgf0a+40aohEi9YpLfI0arMpIe/8QlYT
	H9L/IXDEWU0H9uEsZ2ghOPSjeYCmqJmVu+BSS7HrYeAy8S3l6Od9yiqYiWRvuecakWJS7I9pej7
	6TuPbIVuZ8g/fjS3G/IhwZXLCTE4M55g5tGkuJVP++pEdDD3yxFGFWvqZZP44nHUlERyiMC8sml
	Le5cD5zi34fD5f10hGH8RIx2CbcoUeeMi+bzsnYYe45Bzm4=
X-Received: by 2002:a17:906:c109:b0:ad8:a41a:3cca with SMTP id a640c23a62f3a-adfad436e2emr1281446066b.14.1750161041624;
        Tue, 17 Jun 2025 04:50:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZGGf4xaqQr7bhH8IugHrJ1wzKfrOGGVQIis8pzSmJlubBKNCwyp888GTQnKMFW9Adq6XhqA==
X-Received: by 2002:a17:906:c109:b0:ad8:a41a:3cca with SMTP id a640c23a62f3a-adfad436e2emr1281440966b.14.1750161041107;
        Tue, 17 Jun 2025 04:50:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0109af268sm31140166b.172.2025.06.17.04.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 04:50:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 563C91AF70AB; Tue, 17 Jun 2025 13:50:39 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Stanislav Fomichev
 <stfomichev@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <borkmann@iogearbox.net>, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 sdf@fomichev.me, kernel-team@cloudflare.com, arthur@arthurfabre.com,
 jakub@cloudflare.com, Magnus Karlsson <magnus.karlsson@intel.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH bpf-next V1 7/7] net: xdp: update documentation for
 xdp-rx-metadata.rst
In-Reply-To: <aFBI6msJQn4-LZsH@lore-desk>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
 <174897279518.1677018.5982630277641723936.stgit@firesoul>
 <aEJWTPdaVmlIYyKC@mini-arch>
 <bf7209aa-8775-448d-a12e-3a30451dad22@iogearbox.net>
 <87plfbcq4m.fsf@toke.dk> <aEixEV-nZxb1yjyk@lore-rh-laptop>
 <aEj6nqH85uBe2IlW@mini-arch> <aFAQJKQ5wM-htTWN@lore-desk>
 <aFA8BzkbzHDQgDVD@mini-arch> <aFBI6msJQn4-LZsH@lore-desk>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 17 Jun 2025 13:50:39 +0200
Message-ID: <87h60e4meo.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> On 06/16, Lorenzo Bianconi wrote:
>> > On Jun 10, Stanislav Fomichev wrote:
>> > > On 06/11, Lorenzo Bianconi wrote:
>> > > > > Daniel Borkmann <daniel@iogearbox.net> writes:
>> > > > > 
>> > > > [...]
>> > > > > >> 
>> > > > > >> Why not have a new flag for bpf_redirect that transparently stores all
>> > > > > >> available metadata? If you care only about the redirect -> skb case.
>> > > > > >> Might give us more wiggle room in the future to make it work with
>> > > > > >> traits.
>> > > > > >
>> > > > > > Also q from my side: If I understand the proposal correctly, in order to fully
>> > > > > > populate an skb at some point, you have to call all the bpf_xdp_metadata_* kfuncs
>> > > > > > to collect the data from the driver descriptors (indirect call), and then yet
>> > > > > > again all equivalent bpf_xdp_store_rx_* kfuncs to re-store the data in struct
>> > > > > > xdp_rx_meta again. This seems rather costly and once you add more kfuncs with
>> > > > > > meta data aren't you better off switching to tc(x) directly so the driver can
>> > > > > > do all this natively? :/
>> > > > > 
>> > > > > I agree that the "one kfunc per metadata item" scales poorly. IIRC, the
>> > > > > hope was (back when we added the initial HW metadata support) that we
>> > > > > would be able to inline them to avoid the function call overhead.
>> > > > > 
>> > > > > That being said, even with half a dozen function calls, that's still a
>> > > > > lot less overhead from going all the way to TC(x). The goal of the use
>> > > > > case here is to do as little work as possible on the CPU that initially
>> > > > > receives the packet, instead moving the network stack processing (and
>> > > > > skb allocation) to a different CPU with cpumap.
>> > > > > 
>> > > > > So even if the *total* amount of work being done is a bit higher because
>> > > > > of the kfunc overhead, that can still be beneficial because it's split
>> > > > > between two (or more) CPUs.
>> > > > > 
>> > > > > I'm sure Jesper has some concrete benchmarks for this lying around
>> > > > > somewhere, hopefully he can share those :)
>> > > > 
>> > > > Another possible approach would be to have some utility functions (not kfuncs)
>> > > > used to 'store' the hw metadata in the xdp_frame that are executed in each
>> > > > driver codebase before performing XDP_REDIRECT. The downside of this approach
>> > > > is we need to parse the hw metadata twice if the eBPF program that is bounded
>> > > > to the NIC is consuming these info. What do you think?
>> > > 
>> > > That's the option I was asking about. I'm assuming we should be able
>> > > to reuse existing xmo metadata callbacks for this. We should be able
>> > > to hide it from the drivers also hopefully.
>> > 
>> > If we move the hw metadata 'store' operations to the driver codebase (running
>> > xmo metadata callbacks before performing XDP_REDIRECT), we will parse the hw
>> > metadata twice if we attach to the NIC an AF_XDP program consuming the hw
>> > metadata, right? One parsing is done by the AF_XDP hw metadata kfunc, and the
>> > second one would be performed by the native driver codebase.
>> 
>> The native driver codebase will parse the hw metadata only if the
>> bpf_redirect set some flag, so unless I'm missing something, there
>> should not be double parsing. (but it's all user controlled, so doesn't
>> sound like a problem?)
>
> I do not have a strong opinion about it, I guess it is fine, but I am not
> 100% sure if it fits in Jesper's use case.
> @Jesper: any input on it?

FWIW, one of the selling points of XDP is (IMO) that it allows you to
basically override any processing the stack does. I think this should
apply to hardware metadata as well (for instance, if the HW metadata
indicates that a packet is TCP, and XDP performs encapsulation before
PASSing it, the metadata should be overridden to reflect this).

So if the driver populates these fields natively, I think this should
either happen before the XDP program is run (so it can be overridden),
or it should check if the XDP program already set the values and leave
them be if so. Both of those obviously incur overhead; not sure which
would be more expensive, though...

-Toke


