Return-Path: <netdev+bounces-133239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E82B995610
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 19:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE75C1F23A4A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 17:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA8220CCDC;
	Tue,  8 Oct 2024 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGIbKZQT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C2220CCD7
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 17:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728410120; cv=none; b=SZgzW9MDoTeUlwgwVSJE7PQCvNg53ruZp8gHCW4D/pU0BFX5ichg/gRdHHa7M+CvuCizGOyK5dabe0pN0Zj9WMlA5pWHs3yjcLLyUXrE7cz0+jMEFYCei5IxnnBwlZY73k98Wd8+xPdpNxSQYiX8es0jUVINPT/QzEiBc4RBig4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728410120; c=relaxed/simple;
	bh=2Kdiiov3SlSQX5rM/dYCWp/iUsWesT4L/qcM9kd8+S4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qFRq9Bjkc2s3R6Mf2UHSDVMxSwzAaTcqr2IFuiKGJAechsOvKFvj/aTybZjAEHaurGpF67qCRUajYcNFNkBCdZ+ZNmeEQAu8G2id8DUk5oF5c5nsjcUV9B50hKiVdhM3fiI2VZoS2YCyF0fYL9clHjmrKnsHl2YePRtJLpDY9nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HGIbKZQT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728410117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Kdiiov3SlSQX5rM/dYCWp/iUsWesT4L/qcM9kd8+S4=;
	b=HGIbKZQTTxl1aAZjRJHhWylP3ZowQw5KOGmHb+2zvavZylnjz92f72azUuasBcUmnd8oq9
	0MtFZVkfDg721eWVdLa5gzUbbV43Q3PKCQgCIscDEwxTY4XjEZEEIQck7bd8IP/jleB64/
	lp5gtXPUYDEunj84CjOXr1hA7BV9R78=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-Cl3ZfLlONryLshLa8yi3gg-1; Tue, 08 Oct 2024 13:55:16 -0400
X-MC-Unique: Cl3ZfLlONryLshLa8yi3gg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9960ef689dso122741866b.0
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 10:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728410115; x=1729014915;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Kdiiov3SlSQX5rM/dYCWp/iUsWesT4L/qcM9kd8+S4=;
        b=cH1p74jPnqH9DzRpypbqs6FBGk95AeuT/Po22ssxe6xaf64qCDP2Z6i3t7Iow0QhIB
         NbAtt0RAmhhB82fnmupl1QXYTSZ7iHiG9pTqaFXQSN2Z2EoSoo6a0hjsYmBiXJ22mtPX
         MHnub1QHGy0BEERbvrJgM+GxxD1jvhj71H+IA8TF4S2F7Ir3lJ0+SG3J6LdtQowFR5QT
         6Ocw5Gmnejw4AEvuNZD172jkHSdo06puKUDsjcHvbtGZJ0j06I8HJch2GTWKZwRsaaO7
         TpYYNck9uW9xnlB5/9EU5f7wPPJhaGn3gMZ/n8UPBCxH15o4L1Qsoz+gnwHHt42HiCM1
         QSPg==
X-Forwarded-Encrypted: i=1; AJvYcCUr/B8u803jpI4KVsMB+NKHwBffxhnpuODlOdgGzc4hqAthGgzguMgtg9SX/u5V2TzCHx3khZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgey7HrYNpkM6kx3Q3cQiKqOsChAOkFaBZvC8DbtVv5QLaQgb+
	rcXb5c58uyRltLPRlFvEBap31fF6QFu+eqby25Rgva3aIMgYVTwhRMqRyold/2Cc8o7EmgUG/BV
	X4dJD3Qph5Rvv8Nn6ipDgNYDoaQWkYaMdk7ALkksp+Oj7q8tfDuK20A==
X-Received: by 2002:a17:907:26c1:b0:a86:8ff8:1dd8 with SMTP id a640c23a62f3a-a991c02863dmr1850927666b.46.1728410114844;
        Tue, 08 Oct 2024 10:55:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8exjWPNPM+wo7ZbSPNcUlEw1hHxXLcWxRxDWAnJAZ87z1FAn9OJl5bXYqcNHgCWTFfwf9Mw==
X-Received: by 2002:a17:907:26c1:b0:a86:8ff8:1dd8 with SMTP id a640c23a62f3a-a991c02863dmr1850924866b.46.1728410114477;
        Tue, 08 Oct 2024 10:55:14 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9944d35ae0sm422152166b.179.2024.10.08.10.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 10:55:13 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 31E5B15F3BC4; Tue, 08 Oct 2024 19:55:13 +0200 (CEST)
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
Subject: Re: [PATCH bpf 2/4] selftests/bpf: Consolidate kernel modules into
 common directory
In-Reply-To: <ZwVv_ZOvh2mTGAlK@krava>
References: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
 <20241008-fix-kfunc-btf-caching-for-modules-v1-2-dfefd9aa4318@redhat.com>
 <ZwVv_ZOvh2mTGAlK@krava>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 08 Oct 2024 19:55:13 +0200
Message-ID: <87ploascn2.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jiri Olsa <olsajiri@gmail.com> writes:

> On Tue, Oct 08, 2024 at 12:35:17PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>
> SNIP
>
>> diff --git a/tools/testing/selftests/bpf/bpf_testmod/.gitignore b/tools/=
testing/selftests/bpf/test_kmods/.gitignore
>> similarity index 100%
>> rename from tools/testing/selftests/bpf/bpf_testmod/.gitignore
>> rename to tools/testing/selftests/bpf/test_kmods/.gitignore
>> diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/tes=
ting/selftests/bpf/test_kmods/Makefile
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..393f407f35baf7e2b657b5d7=
910a6ffdecb35910
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/test_kmods/Makefile
>> @@ -0,0 +1,25 @@
>> +TEST_KMOD_DIR :=3D $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIS=
T)))))
>> +KDIR ?=3D $(abspath $(TEST_KMOD_DIR)/../../../../..)
>> +
>> +ifeq ($(V),1)
>> +Q =3D
>> +else
>> +Q =3D @
>> +endif
>> +
>> +MODULES =3D bpf_testmod.ko bpf_test_no_cfi.ko
>> +
>> +$(foreach m,$(MODULES),$(eval obj-m +=3D $(m:.ko=3D.o)))
>> +
>> +CFLAGS_bpf_testmod.o =3D -I$(src)
>> +
>> +all: modules.built
>> +
>> +modules.built: *.[ch]
>
> curious, the top Makefile already checks for test_kmods/*.[ch], do we
> need *.[ch] ?

Not really for building from the top-level Makefile, that is for running
'make' inside the subdir, in case anyone tries that. Don't feel strongly
about it, so can remove it if you prefer?

-Toke


