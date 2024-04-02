Return-Path: <netdev+bounces-84202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52599896053
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 01:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E5A1F230BC
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 23:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49FE5A4E9;
	Tue,  2 Apr 2024 23:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvqZ6zcZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0C72260B;
	Tue,  2 Apr 2024 23:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712101225; cv=none; b=T+L9i4q4VJdRnBal/vUBeQ4z7YNi4Ncb2xU3ZJxdvuLdsNw+nV7BF2xSgmMkYOrT7mXww99E3HgXLLmFkZW+m4FhNSuFwJ5CHA57/Wd3XgZfbzAmQjt7/Xg9UqlCyswADOIOO8H8vNUSTfdn7nDCndPJfzA37ojIfHqOEZrhgak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712101225; c=relaxed/simple;
	bh=x6z872LQ9vBBcv0Ttum6VN6DVyYSl4z83zhLtUBuoJY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fjD+3+YuodI/vh2ZsFb+ciMZrj7lRKCK4pBDRqkMWvpmhbthXCnQGo+s6ptFztpxALHqDH6fJlirINkmzm3nUNlJCM8si4zKmptseIAiiV4YJS7h49uG0xTyi7B4wdcy0kLGJvP0y8zIEfKJkspIXZqjTykxVY6MVntQUDS8ch0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvqZ6zcZ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56df87057bbso1038781a12.3;
        Tue, 02 Apr 2024 16:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712101222; x=1712706022; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=loPuGZvFw7w7LRVaWYgctsCo+62m5RzROUBjXyR2dwA=;
        b=SvqZ6zcZBV9poNU5TXo/iUYMvOAd6m0NxFoKU+smi+NOA8dBR2lzD0oTfbVAhWJnQ6
         ZPidP4TPSjAawSN+lVoacAFf0DJV9jRVZgXDCg0t405CZMIagz8D8mH96xl1my+k0Ml2
         RFUcTGpWhhVcv1pLRInmKEIY5OX07s/axTF+kUr0jI57lCRM0NlcksXi0Eg55ktFFkDz
         ggMhB2QEuD4vVyxoonQyB15eXShuu7GBiHjO30lphCIcLlyvwwJ6GlpHrEaCL8hKqpn8
         BLpUjnRvKKp69QGXDSUK0CKS1YdiO79r3oRSEqcQMBN7/vW5RcCouzScRTDIbLl0axQq
         Sc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712101222; x=1712706022;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=loPuGZvFw7w7LRVaWYgctsCo+62m5RzROUBjXyR2dwA=;
        b=ZDzdVOphI7zOJQQP0yTj0bABUJ8EtKH3pt6JjZqeRm+HFao8oxQzu5kQwzfDi0e+ss
         ney/5Vf4N2Bp0u4BskogxfmoSkWploHWZAh18lixDPczh/rEr5hb9/nh/E+/DrFCwPaG
         3+G6/xioUwhRcH3f5srx+dk7dchywvpLmfs95M3hkNa4jxKYd0QZzESa9TxuOPfyMqEr
         dtx7VwWC9QRm0/vSgcEEkoyW+mW2Zpay3CrLQP4ITUSdiT787s95X3lZCktpeL/6qe15
         IZ7VF8i9L7CdGGpklxfqUMBXFYH+UW930hHKjRBOHLDcc5oSgZqNv4a/UKGIZFcfKnoE
         +w7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUW2fSGgL0Z0rjQXjc/qVH+UA3bDw8xwpW9Jgth40HfdOoR0uVv3RnBIlCu+vNrCDLRGHoXK0vf27APE6g7B/Mh8+6b4kA3lsZftbwl5atQniwFyCppGfl0H86K
X-Gm-Message-State: AOJu0Yyz4+ijXhF/v3UtHX8MeEhMm8abT0vf+nxyAEPFc2JKd/qD/JHT
	rsdLgURI+1JCaW9A8Xmn1I6KNxex32S87WnMvPwOLpBGMTYvI07K
X-Google-Smtp-Source: AGHT+IE4IvdVSybvfrO0pA7dyCkt2gquEU61qYsV7TNGj5+LUts+YXpDVQv9SuIOKyWehdTwysjT6Q==
X-Received: by 2002:a17:906:e202:b0:a47:5182:3b83 with SMTP id gf2-20020a170906e20200b00a4751823b83mr7710360ejb.61.1712101222329;
        Tue, 02 Apr 2024 16:40:22 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id gc9-20020a170906c8c900b00a4e440989f5sm5056824ejb.159.2024.04.02.16.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 16:40:21 -0700 (PDT)
Message-ID: <f20d1e2a2f5fa10f29bf1fddbaf99c3f185e8530.camel@gmail.com>
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
Date: Wed, 03 Apr 2024 02:40:19 +0300
In-Reply-To: <52117f9c-b691-409f-ad2a-a25f53a9433d@huaweicloud.com>
References: <20240328124916.293173-1-pulehui@huaweicloud.com>
	 <32b3358903bf8ba408812a2636f39a275493eb91.camel@gmail.com>
	 <e995a1f1-0b48-4ce3-a061-5cbe68beb6dd@huaweicloud.com>
	 <f91237f311f183d57c4620bc2e6099df8aefccb0.camel@gmail.com>
	 <52117f9c-b691-409f-ad2a-a25f53a9433d@huaweicloud.com>
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

On Sat, 2024-03-30 at 18:12 +0800, Pu Lehui wrote:
[...]

> > Looks like I won't be able to test this patch-set, unless you have
> > some writeup on how to create a riscv64 dev environment at hand.
> > Sorry for the noise
>=20
> Yeah, environmental issues are indeed a developer's nightmare. I will=20
> try to do something for the newcomers of riscv64 bpf. At present, I have=
=20
> simply built a docker local vmtest environment [0] based on Bjorn's=20
> riscv-cross-builder. We can directly run vmtest within this environment.=
=20
> Hopefully it will help.
>=20
> Link: https://github.com/pulehui/riscv-cross-builder/tree/vmtest [0]

Hi Pu,

Thank you for sharing the docker file, I've managed to run the tests
using it. In order to avoid creating files with root permissions I had
to add the following lines at the end of the Dockerfile:

+ RUN useradd --no-create-home --uid 1000 eddy
+ RUN passwd -d eddy
+ RUN echo 'eddy ALL=3D(ALL) NOPASSWD:ALL' >> /etc/sudoers
+ # vmtest.sh does 'mount -o loop',
+ # ensure there is a loop device in the container
+ RUN mknod /dev/loop0 b 7 20

Where 'eddy' is my local user with UID 1000.
Probably this should be made more generic.
I used the following command to start the container:

docker run -ti -u 1000:1000 \
    --rm -v <path-to-kernel-dir>:/workspace \
    -v <path-to-rootfs-image-dir>:/rootfs \
    --privileged ubuntu-vmtest:latest /bin/bash

Also, I had to add '-d /rootfs/bpf_selftests' option for vmtest.sh in
order to avoid polluting user directory inside the container.
Maybe OUTPUT_DIR for vmtest.sh should be mounted as a separate volume.

I agree with Daniel, it would be great to document all of this
somewhere in the repo (or even scripted somehow).

Using the specified DENYLIST I get the following stats for test_progs:

  #3/2     arena_htab/arena_htab_asm:FAIL
  #3       arena_htab:FAIL
  #95      get_branch_snapshot:FAIL
  #172/1   perf_branches/perf_branches_hw:FAIL
  #172     perf_branches:FAIL
  #434/3   verifier_arena/basic_alloc3:FAIL
  #434     verifier_arena:FAIL
  Summary: 531/3581 PASSED, 64 SKIPPED, 4 FAILED

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

> PS: Since the current rootfs of riscv64 is not in the INDEX, I simply=20
> modified vmtest.sh to support local rootfs.

Could you please add this change to the patch-set?

[...]

