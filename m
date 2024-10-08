Return-Path: <netdev+bounces-133242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA0D995629
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD151C246FE
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3818B212654;
	Tue,  8 Oct 2024 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0ULsd7z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8730C1DF75D
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728410748; cv=none; b=GiDbK/4L9KMTwCUO95OMyogmxUAf0zlBlN3pQh/g3IkfH9OkxXCDkb6JypMHoD5m8yb6eZC2vjnza7iVZKRk3ENTnuQ1nFYhaoeDuZAGM6DXSOhIUlBTACTuxkUZiz/qDrex/9pckjmMNKL5/p+GKc1H0HzUHT90Sha6pWcfBJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728410748; c=relaxed/simple;
	bh=5jnrWiF88k5I9mEvkkTZ/M8EPG4BVGPiOHqtxpZAdK0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BP8h1nYMPht9d5g+Fl1KQVQpec4KfSTIVEP8wlGTHr+3BPM7De5o94l8tG1dW30POb6kkA4985e6lxtAvibSQOzZGRo7sU5kMzOEXsi1sA7izKsocDm8C+OEgMWdEJ/78HnmELBnYbS67tZv2/YlM0lm83x3vssUhNWz/iIHQus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0ULsd7z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728410745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSBrsBHX+bOF/xalnqFlbySfgWCG2J84KmNwiiijxt0=;
	b=L0ULsd7z3iWGlRM2q3kQzSaxKob5BtWXvxvZDMubwLv/K2L2TaJgDu0rqqYv0jTli4TYXm
	WekEgXsxubH3mrwxLHFf2CeXrUndVsSg4DMyitQ0tvf1DH1JDPDciBXFYbUQXzpHiEaPZs
	t76DHsKfsGBdGtAVFwJsVcvdXEA4C38=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-BVMxuUJ2PtWllWoaGgW52A-1; Tue, 08 Oct 2024 14:05:44 -0400
X-MC-Unique: BVMxuUJ2PtWllWoaGgW52A-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c911a22768so450683a12.2
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 11:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728410743; x=1729015543;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSBrsBHX+bOF/xalnqFlbySfgWCG2J84KmNwiiijxt0=;
        b=hpKnR+unOPYVmVSY23nsw/BI87Umxvm9kNMy2N93OoEkMHgNSsQP5BzSuIepZLkmtK
         JHKRFXNzccEsnWyfAbhRR6mWspt0oCcgFfzIroDln18VHXay5y2tBTJDZLoVEE0kHor+
         e/TfdgNj+HTCyiiap+lpPpW4eednIfrxIeuJcHXUD8t05qqfelxlikX5lKtGwSFoOyJi
         W8+8GxnNCCKcBgL3r0lpNQSR7pUL4MWBAcX3M0i1sP4hD6R2YQi3Tl8sOp7jrTGuMmbo
         JErApP0/GpA2unWk3McjT+fmda/m7pxNUjUvzZq7aHNP4b/E3m6YgvwyCDAUv+KKmZ22
         IcQg==
X-Forwarded-Encrypted: i=1; AJvYcCUTgMTkdmY9gPt3IQo1rFMcn954Tq1KYk9MyjMjdXcw8cxg557dN1DY+FSZ7BrtMg/Xvp80aoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YylWv7vuqgRrejaC1zsCQP80sHzniucr2EO54awrQU5KzWgqkBu
	+AeP/LKk/Pha5ZmP9gHOpWVU5tqK4zEn5JCcmlJMMEfth44RxSG7JsTeHXcZOXzUvHo0DVxSPEw
	euffKddkVecxSAlrF0KAE9tUD27AOsyHtIEsxUVdrso/18qcNprO0Zw==
X-Received: by 2002:a05:6402:3811:b0:5c8:9f44:8145 with SMTP id 4fb4d7f45d1cf-5c8d2e8769dmr14049258a12.26.1728410743001;
        Tue, 08 Oct 2024 11:05:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGImQDma5QXpogq3kDV2BvTyqiPPtxuHsvPzGt2cQSE0/0TUikQD5HviL4wT8kioF60+Te2KA==
X-Received: by 2002:a05:6402:3811:b0:5c8:9f44:8145 with SMTP id 4fb4d7f45d1cf-5c8d2e8769dmr14049226a12.26.1728410742520;
        Tue, 08 Oct 2024 11:05:42 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05bc422sm4542269a12.42.2024.10.08.11.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 11:05:41 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 674CB15F3BCD; Tue, 08 Oct 2024 20:05:40 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Simon Sundberg <simon.sundberg@kau.se>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf 4/4] selftests/bpf: Add test for kfunc module order
In-Reply-To: <ZwVwBiT8XASa7Jy_@krava>
References: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
 <20241008-fix-kfunc-btf-caching-for-modules-v1-4-dfefd9aa4318@redhat.com>
 <ZwVwBiT8XASa7Jy_@krava>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 08 Oct 2024 20:05:40 +0200
Message-ID: <87h69msc5n.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jiri Olsa <olsajiri@gmail.com> writes:

> On Tue, Oct 08, 2024 at 12:35:19PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>
> SNIP
>
>> +static int test_run_prog(const struct bpf_program *prog,
>> +			 struct bpf_test_run_opts *opts, int expect_val)
>> +{
>> +	int err;
>> +
>> +	err =3D bpf_prog_test_run_opts(bpf_program__fd(prog), opts);
>> +	if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
>> +		return err;
>> +
>> +	if (!ASSERT_EQ((int)opts->retval, expect_val, bpf_program__name(prog)))
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +void test_kfunc_module_order(void)
>> +{
>> +	struct kfunc_module_order *skel;
>> +	char pkt_data[64] =3D {};
>> +	int err =3D 0;
>> +
>> +	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, test_opts, .data_in =3D pkt_dat=
a,
>> +			    .data_size_in =3D sizeof(pkt_data));
>> +
>> +	err =3D load_module("bpf_test_modorder_x.ko",
>> +			  env_verbosity > VERBOSE_NONE);
>> +	if (!ASSERT_OK(err, "load bpf_test_modorder_x.ko"))
>> +		return;
>> +
>> +	err =3D load_module("bpf_test_modorder_y.ko",
>> +			  env_verbosity > VERBOSE_NONE);
>> +	if (!ASSERT_OK(err, "load bpf_test_modorder_y.ko"))
>> +		goto exit_modx;
>> +
>> +	skel =3D kfunc_module_order__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "kfunc_module_order__open_and_load()")) {
>> +		err =3D -EINVAL;
>> +		goto exit_mods;
>> +	}
>> +
>> +	test_run_prog(skel->progs.call_kfunc_xy, &test_opts, 0);
>> +	test_run_prog(skel->progs.call_kfunc_yx, &test_opts, 0);
>
> nit, no need to pass expect_val, it's always 0

Sure, can get rid of that...

-Toke


