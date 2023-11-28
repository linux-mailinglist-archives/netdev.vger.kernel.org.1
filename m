Return-Path: <netdev+bounces-51707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1A37FBCDF
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8681C20CBA
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 14:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9AD2FE26;
	Tue, 28 Nov 2023 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmSt20sH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DB31B5
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 06:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701182366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txWtad5w3ZYqRxS/4XatzmOiq0oyLE9c/t3xYYd7t08=;
	b=hmSt20sHsrmYjy+XGLBFDHDzvsvYrtx0bayy6pmXoMur9bfSD4GOTIZvdJIq3Mu3I2bu4A
	r32D7vZZXABL0WHOAvrLkWd+C+ybexv0l4MP2kH/hKxZpCDemGy+Sug0JbV6mv9gYnAZ8c
	B+ZUXVTFvg8TpNxei+N2UVOGBAN0ogE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-iCdAPWILMo621JcpiD0sjw-1; Tue, 28 Nov 2023 09:39:24 -0500
X-MC-Unique: iCdAPWILMo621JcpiD0sjw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50bbcec7b48so571296e87.3
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 06:39:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701182363; x=1701787163;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txWtad5w3ZYqRxS/4XatzmOiq0oyLE9c/t3xYYd7t08=;
        b=qwDJp2y4gp/rmitXBnKIZ4ytSIhKDl8D4WRQqcUSDhFtb8/29mGvKnByuMQB9ByP8a
         UBsPC7phcNVUqZ/EgBx6zJ2tk9nsQV5DOiN6ZIq6ai9GJeNZZQyzLpE5u6gIIM1Bmg17
         BNWneCp62le20X1hb2cqeDxsFhaI7uM6cjBZsTfSraA3ZgQwutIkaBf5VnIkdLOAQ0LA
         IszThUkqiEsYvyjZIL+ilQWYR1Y9x+/j3kVHkjU02qxkcMV/iDFhk+oAxMT4wALQSkT5
         DaXN9mwDKBClTN14WI39YDsceDZs0FrAo654OOUTLMHihNiY+3uxel2G/qxGZe1rsQtM
         Ce2g==
X-Gm-Message-State: AOJu0YwSbWXpsTVQDHCgVt80N3bGuG+WTuwKgSepWtww2z6Ki5V7uqfH
	5mXbhjaHhoGVxffg2egWwvUonhAiSUiIjF1K9nyZ2WkhGqg2aWWm6DCIilqQIieIQys/pEQ76er
	EP5TWLzLYmvttqd+2
X-Received: by 2002:ac2:5b04:0:b0:509:4599:f2bc with SMTP id v4-20020ac25b04000000b005094599f2bcmr9550552lfn.14.1701182363455;
        Tue, 28 Nov 2023 06:39:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGU2VZ8N/CK3iZZHsFbCHWGJOO3XC0L1xg0hxVL+f+BRqer+rsCWmolUix9V6Y64aW8RyWSbg==
X-Received: by 2002:ac2:5b04:0:b0:509:4599:f2bc with SMTP id v4-20020ac25b04000000b005094599f2bcmr9550537lfn.14.1701182363105;
        Tue, 28 Nov 2023 06:39:23 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id r21-20020a170906351500b00a0bd234566bsm4234123eja.143.2023.11.28.06.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:39:22 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6ED41F780EF; Tue, 28 Nov 2023 15:39:22 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>
Cc: Yan Zhai <yan@cloudflare.com>, Stanislav Fomichev <sdf@google.com>,
 Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, kernel-team <kernel-team@cloudflare.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Sitnicki <jakub@cloudflare.com>
Subject: Re: Does skb_metadata_differs really need to stop GRO aggregation?
In-Reply-To: <7f48dc04-080d-f7e1-5e01-598a1ace2d37@iogearbox.net>
References: <92a355bd-7105-4a17-9543-ba2d8ae36a37@kernel.org>
 <21d05784-3cd7-4050-b66f-bad3eab73f4e@kernel.org>
 <7f48dc04-080d-f7e1-5e01-598a1ace2d37@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 28 Nov 2023 15:39:22 +0100
Message-ID: <87fs0qj61x.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 11/28/23 2:06 PM, Jesper Dangaard Brouer wrote:
>> On 11/28/23 13:37, Jesper Dangaard Brouer wrote:
>>> Hi Daniel,
>>>
>>> I'm trying to understand why skb_metadata_differs() needed to block GRO=
 ?
>>>
>>> I was looking at XDP storing information in metadata area that also
>>> survives into SKBs layer.=C2=A0 E.g. the RX timestamp.
>>>
>>> Then I noticed that GRO code (gro_list_prepare) will not allow
>>> aggregating if metadata isn't the same in all packets via
>>> skb_metadata_differs().=C2=A0 Is this really needed?
>>> Can we lift/remove this limitation?
>>=20
>> (Answering myself)
>> I understand/see now, that when an SKB gets GRO aggregated, I will
>> "lose" access to the metadata information and only have access to the
>> metadata in the "first" SKB.
>> Thus, GRO layer still needs this check and it cannot know if the info
>> was important or not.
>
> ^ This exactly in order to avoid loosing information for the upper stack.=
 I'm
> not sure if there is an alternative scheme we could do where BPF prog can=
 tell
> 'it's okay to loose meta data if skb can get aggregated', and then we jus=
t skip
> the below skb_metadata_differs() check. We could probably encode a flag i=
n the
> meta_len given the latter requires 4 byte alignment. Then BPF prog can
> decide.

A flag seems sane. I guess we could encode some flag values in the upper
bits of the 'offset' argument of the bpf_xdp_adjust_meta() helper, since
valid values are guaranteed to be pretty small anyway? :)

I'm not quite sure what should be the semantics of that, though. I.e.,
if you are trying to aggregate two packets that have the flag set, which
packet do you take the value from? What if only one packet has the flag
set? Or should we instead have a "metadata_xdp_only" flag that just
prevents the skb metadata field from being set entirely? Or would both
be useful?

-Toke


