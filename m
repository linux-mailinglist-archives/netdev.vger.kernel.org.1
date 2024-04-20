Return-Path: <netdev+bounces-89813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CA08ABAFD
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 12:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49591F21DD3
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 10:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5D71803A;
	Sat, 20 Apr 2024 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJ8F9CSW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAEBEAE5
	for <netdev@vger.kernel.org>; Sat, 20 Apr 2024 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713608649; cv=none; b=iu4CjT6KKLx/oR2iZY1CcPO7VzKNKlpXt9cbDZAcFphnPToeoEXul8Pra1veXv+0bFB/HC6xFUjzdipHYREwTWo3HwBBhjczFAvVmGYth4zPpHOxq8LCDSvlKA5nlQG7w4l+aJo75Ib4flKOgdAIhMnCnXThsKDSYABW/sjRV8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713608649; c=relaxed/simple;
	bh=dvMpMzbby6bmNjJXP+mbiBh8jPKqiXSH30JU0IGxXc4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tVrDsGZO6WqD0csD5Y74iIq9wyXSWsUxVUEDIAY9MXNNmE/dSetj8QKrKKFsjaUmtcKExIf5MesAnK4eMp0/GD5pAvS5RyFwX3ft6k6/pqxsAjBocxPRTxGnrqK+LwxVJOuXnMX4zpwmWH7NnLY5utepLJAM5WxvpFQWZWQzNTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJ8F9CSW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713608646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X3YnVEKOXiBuwbJ79REQDk1GmD/fk0LPtFT3JEU16Qk=;
	b=WJ8F9CSWB3ftiHdZsS0BEpHmUG42hKACSAY+1CN1PBjSD2/k3VncMWizD1mHSvf0ijRJn7
	hC8jnRYkxJSVn1AW6+EGwQXi+YW3pZlvLiK52e/o2sQmoB1r6kObP4qgQchI8ZsC1T59PS
	aiZerbyVaP8UhkbJblM/aplbF8qyS4E=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-oZ1xXp77NJOAzlqLjQ4EPg-1; Sat, 20 Apr 2024 06:24:05 -0400
X-MC-Unique: oZ1xXp77NJOAzlqLjQ4EPg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a5532902a78so190653466b.2
        for <netdev@vger.kernel.org>; Sat, 20 Apr 2024 03:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713608644; x=1714213444;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3YnVEKOXiBuwbJ79REQDk1GmD/fk0LPtFT3JEU16Qk=;
        b=ltmyCR1/oAN0ssLw2tezmeIMvmfFBQYTQ0pom0/8ZGj9xosjlp3/vHqAivWDCUaBju
         ojWUFIsOn/GLkN+86kzdBSqV+MINAx7hgQQbIJ8MK+Ph2/sYt2rDTdpBvSlUVjYC6m0A
         dKKcyjKhFepUtGqIf+bg9CDg5HekSZ17ra6yYotroiXuL/mu5/vTeEsT1EmKdYxDiFlm
         GbtaRM3kUPhql1sJ8a9bdyrDxlvW+VI38vni7Z8Vxmh72x9dpNJdUiedRjt30b7jMCTB
         Jqe7dqpDpS5BdCdDKCdFnJ1+uIJuNffLEIS3IPRMCsz4k1LMTKCKkRvSIKsiVjKQleyv
         5pFw==
X-Forwarded-Encrypted: i=1; AJvYcCXxS0bG8Slyi03PtpmxdJ55Ybjy9CftgNVKvXZfRGjFHYSnrRyRZOBIB6sZSS7us6WVd1uThIzj0k6pnK8Xh4sJd9GpZTcV
X-Gm-Message-State: AOJu0YxLB7/palr5XHFPdNmKcyeR5foDGETZnJF4hF4C3meTDUtLE4xS
	7ni/1zFjx1Xc1KH757+NHahEqWkWFRdA1HmHD+UDWVrPrKB2hWlFeV21VGzoO3mV3b1wr2U+mwH
	r1mKM3b5AFBddugU6x95+ybdelwHbynpXD6uVoY/Btx4jMyIv9grCBQ==
X-Received: by 2002:a17:906:a90:b0:a52:401c:472b with SMTP id y16-20020a1709060a9000b00a52401c472bmr4256604ejf.73.1713608644038;
        Sat, 20 Apr 2024 03:24:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj0sfFL6Zt5mFMTc0fcVokTvzGD+RfSXTH5CP+lTHLZ2fV9Baj15lJTkhILGSGPgb1t0Dqog==
X-Received: by 2002:a17:906:a90:b0:a52:401c:472b with SMTP id y16-20020a1709060a9000b00a52401c472bmr4256582ejf.73.1713608643560;
        Sat, 20 Apr 2024 03:24:03 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id i19-20020a170906265300b00a4e7d03e995sm3248522ejc.45.2024.04.20.03.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 03:24:02 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 49F671234006; Sat, 20 Apr 2024 12:24:01 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John
 Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Hangbin Liu <liuhangbin@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH bpf] xdp: use flags field to disambiguate broadcast
 redirect
In-Reply-To: <d7938afa-fb2f-4872-b449-6ecaf5e29360@linux.dev>
References: <20240418071840.156411-1-toke@redhat.com>
 <d7938afa-fb2f-4872-b449-6ecaf5e29360@linux.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Sat, 20 Apr 2024 12:24:01 +0200
Message-ID: <878r18tjr2.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Martin KaFai Lau <martin.lau@linux.dev> writes:

> On 4/18/24 12:18 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> When redirecting a packet using XDP, the bpf_redirect_map() helper will =
set
>> up the redirect destination information in struct bpf_redirect_info (usi=
ng
>> the __bpf_xdp_redirect_map() helper function), and the xdp_do_redirect()
>> function will read this information after the XDP program returns and pa=
ss
>> the frame on to the right redirect destination.
>>=20
>> When using the BPF_F_BROADCAST flag to do multicast redirect to a whole
>> map, __bpf_xdp_redirect_map() sets the 'map' pointer in struct
>> bpf_redirect_info to point to the destination map to be broadcast. And
>> xdp_do_redirect() reacts to the value of this map pointer to decide whet=
her
>> it's dealing with a broadcast or a single-value redirect. However, if the
>> destination map is being destroyed before xdp_do_redirect() is called, t=
he
>> map pointer will be cleared out (by bpf_clear_redirect_map()) without
>> waiting for any XDP programs to stop running. This causes xdp_do_redirec=
t()
>> to think that the redirect was to a single target, but the target pointer
>> is also NULL (since broadcast redirects don't have a single target), so
>> this causes a crash when a NULL pointer is passed to dev_map_enqueue().
>>=20
>> To fix this, change xdp_do_redirect() to react directly to the presence =
of
>> the BPF_F_BROADCAST flag in the 'flags' value in struct bpf_redirect_info
>> to disambiguate between a single-target and a broadcast redirect. And on=
ly
>> read the 'map' pointer if the broadcast flag is set, aborting if that has
>> been cleared out in the meantime. This prevents the crash, while keeping
>> the atomic (cmpxchg-based) clearing of the map pointer itself, and witho=
ut
>> adding any more checks in the non-broadcast fast path.
>>=20
>> Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast suppor=
t")
>> Reported-and-tested-by: syzbot+af9492708df9797198d6@syzkaller.appspotmai=
l.com
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>   net/core/filter.c | 42 ++++++++++++++++++++++++++++++++----------
>>   1 file changed, 32 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 786d792ac816..8120c3dddf5e 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -4363,10 +4363,12 @@ static __always_inline int __xdp_do_redirect_fra=
me(struct bpf_redirect_info *ri,
>>   	enum bpf_map_type map_type =3D ri->map_type;
>>   	void *fwd =3D ri->tgt_value;
>>   	u32 map_id =3D ri->map_id;
>> +	u32 flags =3D ri->flags;
>>   	struct bpf_map *map;
>>   	int err;
>>=20=20=20
>>   	ri->map_id =3D 0; /* Valid map id idr range: [1,INT_MAX[ */
>> +	ri->flags =3D 0;
>>   	ri->map_type =3D BPF_MAP_TYPE_UNSPEC;
>>=20=20=20
>>   	if (unlikely(!xdpf)) {
>> @@ -4378,11 +4380,20 @@ static __always_inline int __xdp_do_redirect_fra=
me(struct bpf_redirect_info *ri,
>>   	case BPF_MAP_TYPE_DEVMAP:
>>   		fallthrough;
>>   	case BPF_MAP_TYPE_DEVMAP_HASH:
>> -		map =3D READ_ONCE(ri->map);
>> -		if (unlikely(map)) {
>> +		if (unlikely(flags & BPF_F_BROADCAST)) {
>> +			map =3D READ_ONCE(ri->map);
>> +
>> +			/* The map pointer is cleared when the map is being torn
>> +			 * down by bpf_clear_redirect_map()
>
> Thanks for the details explanation in the commit message. All make sense.

Great!

> It could be a dumb question.
>
>  From reading the "waits for...NAPI being the relevant context here..." c=
omment=20
> in dev_map_free(), I wonder if moving synchronize_rcu() before=20
> bpf_clear_redirect_map() would also work? Actually, does it need to call=
=20
> bpf_clear_redirect_map(). The on-going xdp_do_redirect() should be the la=
st one=20
> using the map in ri->map anyway and no xdp prog can set it again to
>  ri->map.

I think we do need to retain the current behaviour, because of the
decoupling between the helper and the return code. Otherwise, you could
have a program that calls the bpf_redirect_map() helper, but returns a
different value (say, XDP_DROP). In this case, the map pointer will
stick around in struct bpf_redirect_info, and if a subsequent XDP
program then returns XDP_REDIRECT (*without* calling
bpf_redirect_map()), it will use the stale pointer value and cause a
UAF.

-Toke


