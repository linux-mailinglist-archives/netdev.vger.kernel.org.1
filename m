Return-Path: <netdev+bounces-83447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DF5892473
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 20:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B91285178
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 19:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A747A13AA38;
	Fri, 29 Mar 2024 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhYmnGbk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF1E85C6C;
	Fri, 29 Mar 2024 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741595; cv=none; b=SjE7xRnK+3Bko97HFZd9QVYaXM0HTxO0k2hkADFdk/Eo68Jh6WbBNt11f6XQmgEnhp7BDo46kKqvN8sXG93oocXGkxLxCWV8X+7mmmMSAIwnZtNU6qMQrfQpGWL9hjTj7FBb/hKooIsfetDIVMPW6CyRhRJWHxyjIUJAx+f4jk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741595; c=relaxed/simple;
	bh=7R3QtvHYzMzuiw1RGORFqm02LVmLFTRbpuXiYqhc06w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dBFlcPrJrQovixBdTc850f/T5swARTQi0UeQHEZsJlrrkYxorbrWeLDHnoVzy4bU6z7qegV1Et7970emKwSOdYvAGSezvjcafE1NWNKjgubXrPpVPwOGzFNLceUH4dRI/YpiYl9V04WEu+lwtISe19/COSBoRDUIa+RggFTKi08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhYmnGbk; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a46cca2a979so139249466b.3;
        Fri, 29 Mar 2024 12:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711741592; x=1712346392; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iRbhTuKdGVdgcCtOxKjPCp9tzZ0RXndz1gW7/Urj2f8=;
        b=VhYmnGbkugOOYWpu4kk7MFsSNqqCYzQ6FTGWiaw2apYPrK7xWhFmL46U1xz9Sryh2V
         i4rJTO7U111ONA++lkX0J8eWVx7CUkvNVDPBEebr3pp1dbl7lsMKMldRgH5LTMQ0vV43
         wKKZE2XI3ZsKeE7N9rpKgacVzS2LQnoBvjQVH+q+CZdr2zslQUlRKMB0IhqIP0rhjscL
         rwn1vWL8I8ByiQIu1x+7xJpdkaFdJfjSQr+YTTXBZTgrKoT9GnbnI704a57CGIgWEZGl
         OqX9Wol5WLoeLzlouNKPBEnShSBVqU4mjPalkZ9vdITtR3BB2whiLVrqpAK4dksx9IEI
         clpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711741592; x=1712346392;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iRbhTuKdGVdgcCtOxKjPCp9tzZ0RXndz1gW7/Urj2f8=;
        b=RBS+eCZnLg1v/siGoXppPaNXu406A57imzWvq0OcHfditkeCIC8P2+wDqRjg4BK+M0
         4pdpBRUQTsg16ViGpSW04jiuXK5glDohF58MOzLVnMaVJTx6sPgz6AMSRzvjMCUv0Icr
         p0G+382qT2I6ewYoEILumbF2bDDRz5DVj7XTUsZKpG7p9V5d088iK11JkBA1NNQjrC5n
         hBivhGkoVxpqeDqngwpHqYZ8WeTKXfMCbuAMyRxHkR9SPS0jXvIVPucfcFQjQAzMaybz
         u/5Xeyn1E9mlrFBVCI0fyPnVB7mzgKOTBWBiYmanj5CA/pTFEw6/D+SPzLuY4p9hOt+R
         NGIA==
X-Forwarded-Encrypted: i=1; AJvYcCUmzE6iEPzugdHtjpbXRANcz1GCUfjpFfcgVhqFRs9E+vmGCiAi4oNmDBZiPPIGklSc8uZaMbswLYFDs4vCwNM+QoVSuV6+gLW2KI5UspMNoQSK8dfc9ia+WESD
X-Gm-Message-State: AOJu0Yz39WvV2hu+Leif70ad8nWexmucRYu7FChN71Dmi9bLz4euPB0r
	p+B8IGudzj3oG3Xd1BAAXQAeaQTrEgunx7e8tuarpeh3gDhO5mWCBbzjhiqn9X2z8w==
X-Google-Smtp-Source: AGHT+IFeoi9VX0eigQunOE3+7oIKVGDHZNovNgU3K34137TXC0OWeeil7vlqVFwtH1vghv5nVyPSMA==
X-Received: by 2002:a05:6402:13d6:b0:56c:5a7b:5dbf with SMTP id a22-20020a05640213d600b0056c5a7b5dbfmr3477343edx.2.1711741591953;
        Fri, 29 Mar 2024 12:46:31 -0700 (PDT)
Received: from ?IPv6:2a00:1858:1027:8084:dcff:fef3:4040:e18d? ([2a00:1858:1027:8084:dcff:fef3:4040:e18d])
        by smtp.gmail.com with ESMTPSA id l2-20020a056402124200b0056c4ca20d48sm2386458edw.49.2024.03.29.12.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 12:46:31 -0700 (PDT)
Message-ID: <f91237f311f183d57c4620bc2e6099df8aefccb0.camel@gmail.com>
Subject: Re: [PATCH bpf-next 0/5] Support local vmtest for riscv64
From: Eduard Zingerman <eddyz87@gmail.com>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org, 
	linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Mykola Lysenko <mykolal@fb.com>, Manu Bretelle
 <chantr4@gmail.com>, Pu Lehui <pulehui@huawei.com>
Date: Fri, 29 Mar 2024 21:46:14 +0200
In-Reply-To: <e995a1f1-0b48-4ce3-a061-5cbe68beb6dd@huaweicloud.com>
References: <20240328124916.293173-1-pulehui@huaweicloud.com>
	 <32b3358903bf8ba408812a2636f39a275493eb91.camel@gmail.com>
	 <e995a1f1-0b48-4ce3-a061-5cbe68beb6dd@huaweicloud.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-29 at 18:10 +0800, Pu Lehui wrote:
[...]

> > Apparently jammy does not have binaries built for riscv64, or I'm faili=
ng to find correct mirror.
> > Could you please provide some instructions on how to prepare rootfs?
>=20
> Hi Eduard, We need the mirror repository of ubuntu-ports, you could try=
=20
> http://de.ports.ubuntu.com/.

Hi Pu, thank you this mirrorm it works.

Unfortunately my local setup is still not good enough.
I've installed cross-riscv64-gcc14 but it seems that a few more
libraries are necessary, as I get the following compilation errors:

  $ PLATFORM=3Driscv64 CROSS_COMPILE=3Driscv64-suse-linux- ./vmtest.sh -- .=
/test_verifier
  ... kernel compiles ok ...
  ../../../../scripts/sign-file.c:25:10: fatal error: openssl/opensslv.h: N=
o such file or directory
     25 | #include <openssl/opensslv.h>
        |          ^~~~~~~~~~~~~~~~~~~~
  compilation terminated.
    CC      /home/eddy/work/bpf-next/tools/testing/selftests/bpf/tools/buil=
d/host/libbpf/sharedobjs/bpf.o
  In file included from nlattr.c:14:
  libbpf_internal.h:19:10: fatal error: libelf.h: No such file or directory
     19 | #include <libelf.h>
  ...

Looks like I won't be able to test this patch-set, unless you have
some writeup on how to create a riscv64 dev environment at hand.
Sorry for the noise.

