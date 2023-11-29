Return-Path: <netdev+bounces-52291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B6B7FE27B
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 22:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38CF61C20B7A
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 21:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1D44CB2C;
	Wed, 29 Nov 2023 21:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfGCkFNE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8062103
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 13:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701294751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nsOWFI+vUP+El82R1ZGHIgrBBz5mRHPSPnsJvdp4NPE=;
	b=FfGCkFNEBrVAyhPh2VKfwLE7T+8iew9sv9zMxwuJ+CzvorUk8/6otI2iG9zcHxUmbsJ41Z
	0sAAyLIQ93npbBGg4osZKUxEavMbwP8NGAu9OtkAt1G0VIzqKpSDVZaJX7f7LDdIB/B1zA
	wJIgENY93aUdt6pF2FZfV49BjT5YzSo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-3yToNmGEN82Zd6hNJPqRhQ-1; Wed, 29 Nov 2023 16:52:30 -0500
X-MC-Unique: 3yToNmGEN82Zd6hNJPqRhQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a0c510419caso25147166b.1
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 13:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701294749; x=1701899549;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsOWFI+vUP+El82R1ZGHIgrBBz5mRHPSPnsJvdp4NPE=;
        b=ljhRpo8BC60U2REbuJ0ieflbRgqdWUw830OVwfpOueW8HD1lB5yPn3XRQmluvKtlvb
         hGeJQ5rbcp1Bwo2k7d2bZRVnnfA4SIXB6IXPp/8A7GhSbglbT24ZNPFfTyOOi3xZ5nsH
         BvXQA5TdruvYzJ42oh39NipF8FVVvZ9h01DtyycQsHzymjHRIVgtOwI32AlzIxakSH7I
         wtGY64d8hifkaEWCAbY+N66s3oiO229PgWWh0GpLEjAzTbuExsVo8gw4lVyxhCKO47F2
         DOXHzm190mWtUJwi8QUe9vySPPlUF8gekp97cV63fVpU7mRsNjLMd6oMn5A31rV1KmwN
         hL4Q==
X-Gm-Message-State: AOJu0Yzuu6q1yI9uPd4hGscTgBEks+YP/GBb6wvReEtc1hlmpdPDewb1
	63RYRXNBHs1V+cLGqfi6dTOtN2uNcn8RUiuEdYxBvZAgrWwCLsieGDoiFZQ6sHYmt/vaPs2Sjt9
	ZaOeOzhWAyafMPSXR
X-Received: by 2002:a17:907:d92:b0:a01:de07:5926 with SMTP id go18-20020a1709070d9200b00a01de075926mr17023713ejc.45.1701294748891;
        Wed, 29 Nov 2023 13:52:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFM+ZqFadYzBON+yqwh6Xt6KmCA4+hoiPEL3DM0nUkJHh8J0V+H06cCnMHPtzL1s0NIP/gR1A==
X-Received: by 2002:a17:907:d92:b0:a01:de07:5926 with SMTP id go18-20020a1709070d9200b00a01de075926mr17023704ejc.45.1701294748675;
        Wed, 29 Nov 2023 13:52:28 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id lb16-20020a170907785000b009fda665860csm8270304ejc.22.2023.11.29.13.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 13:52:28 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 16360F782D0; Wed, 29 Nov 2023 22:52:28 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Edward Cree <ecree.xilinx@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yan Zhai <yan@cloudflare.com>, Stanislav Fomichev <sdf@google.com>,
 Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, kernel-team <kernel-team@cloudflare.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Sitnicki <jakub@cloudflare.com>
Subject: Re: Does skb_metadata_differs really need to stop GRO aggregation?
In-Reply-To: <0b0c6538-92a5-3041-bc48-d7286f1b873b@gmail.com>
References: <92a355bd-7105-4a17-9543-ba2d8ae36a37@kernel.org>
 <21d05784-3cd7-4050-b66f-bad3eab73f4e@kernel.org>
 <7f48dc04-080d-f7e1-5e01-598a1ace2d37@iogearbox.net>
 <87fs0qj61x.fsf@toke.dk> <0b0c6538-92a5-3041-bc48-d7286f1b873b@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 29 Nov 2023 22:52:28 +0100
Message-ID: <87plzsi5wj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Edward Cree <ecree.xilinx@gmail.com> writes:

> On 28/11/2023 14:39, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> I'm not quite sure what should be the semantics of that, though. I.e.,
>> if you are trying to aggregate two packets that have the flag set, which
>> packet do you take the value from? What if only one packet has the flag
>> set? Or should we instead have a "metadata_xdp_only" flag that just
>> prevents the skb metadata field from being set entirely? Or would both
>> be useful?
>
> Sounds like what's actually needed is bpf progs inside the GRO engine
>  to implement the metadata "protocol" prepare and coalesce callbacks?

Hmm, yes, I guess that would be the most general solution :)

-Toke


