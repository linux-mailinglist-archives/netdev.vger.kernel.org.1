Return-Path: <netdev+bounces-83203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51985891561
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 10:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F421F229B9
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 09:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DB937152;
	Fri, 29 Mar 2024 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6HkY3dK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E870428DD8;
	Fri, 29 Mar 2024 09:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703335; cv=none; b=cGWnXUQ5CRJyx5lf96bzUQJfe4bwSc55Uju/Q1tT7XxO6y4LMzGe2iZBxzcZufifVHsUvscaY0LeSUtWhsoBUukIgCPyVBj4km2kHg0FcTXSYW9kyTHUPMY7Z9VSEwqziv7uxJJ2DgzXf1bejsNe3O9cDG4U8RqUHBMCzdgrp9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703335; c=relaxed/simple;
	bh=bnC7LvgUUvJ5zLthw5oBT5mDQiNf1sIrcvqtm2DbeH4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M5xeBD97NYm2kLT8Vh8saE81/VVPuUJ1IthGl2ok8C1HyXn/JVgFGzaviOU+we/UbxAYINFIIMAitTbQ/yp68nDcI/Y0EJRdFzHMBtYzYPJPp/qJ+UPSBvfcMNJ0zHaBz3LUEb2heIWRFOD3X5ZGsAlCF/Nsh5C3jC6keR5B8sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6HkY3dK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-414925ba716so10818275e9.2;
        Fri, 29 Mar 2024 02:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711703330; x=1712308130; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vSvU75eALFtAgVLgzybRJGQPZckpP1X2THROU/cjxkI=;
        b=k6HkY3dKZs/GL94kliSN7A6VE1SWmVbxFn0h+yIdEnrQR3Kmwcy785HG/vXTRy+ybO
         BAmq4/QvAH2g2GAF4TKdubChrOV8Z7iQ8Rrit/K/lNv5wdeIbBP8hU7KPigWvu7B34xT
         xuHdowRKW1KB9pKEpzgFKwU13iGt1U2x6uRpn79Gl62bkWzatFbDasjQzHT2ubBDDt9z
         Jp/YixAU1raFIGCm5VS8GqJGQBVv/fTDSUrHqfgX0KLZODxHKMC3XYiZN3e1Fkm9o3Uw
         rqvEy3aRzrKnQ5CRJoGIbO98sedNEsnnjcpefOvFlH/u22u4o5sw79P8aE1L5eofp0zR
         nm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711703330; x=1712308130;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSvU75eALFtAgVLgzybRJGQPZckpP1X2THROU/cjxkI=;
        b=rsq1jmRmDTSj+01a0cwSWOEBzs3sj4v6vaOo148krUZps/YCCL7TP9MJ4NHXfaQKJn
         Lf05RkzYXXS0IMgJVe1CiJjH5yxGM25RYXHkk9+9STZfhdQhTQmD1bwSREI38haU1yAw
         xQGo/y6UrW87QOAB0yvPWUVu2Uo7natgfkBe5tQkm44OJmcIA6HUAf+FcEqWCMtCa2FF
         MoPjOLaO8BbNZu/a2QbkdR7Mw3u8bzjboKU/dGFpd13vzEp2fPf8AHqxItbSYxVY2Kt2
         LMyR7pxZM/tzupldM7XbIK2B3dx0YZ5yZAImAF2sZEsxIOobw0KG6D/iqPb67C3mvP/r
         XJcg==
X-Forwarded-Encrypted: i=1; AJvYcCUMHwDt1M3RRsiiv5xlzxpHy8za3dy6vDi0racRQ8wZ7W0+Z1FmCF0eStdAIjC/b8+6TScD4DoDwDZHmPVDd/RDCsIqpoL2Qn0mNYobVZxgji+t+4z1XUkH6PR8
X-Gm-Message-State: AOJu0Yy6vtkA7UjZn5gNLKxkhwE16bfnBZJaqjmQbm5q2yhoP0JVSjar
	E6thkGCrBsZM38MJBZ3BN6AEZWTfOVSUssNlQQBpSr3fbTqgQkxV
X-Google-Smtp-Source: AGHT+IFORsJ9E85QUnpfs36KzvJbwTYnnVDgnGqwgKOb5Hip9huHXYYlaEja87LGOTGnC5lLLgX+aA==
X-Received: by 2002:a05:600c:a0b:b0:414:60fe:8f2b with SMTP id z11-20020a05600c0a0b00b0041460fe8f2bmr1369503wmp.18.1711703330115;
        Fri, 29 Mar 2024 02:08:50 -0700 (PDT)
Received: from ?IPv6:2a00:1858:1027:8084:dcff:fef3:4040:e18d? ([2a00:1858:1027:8084:dcff:fef3:4040:e18d])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c1d8e00b0041551590becsm664022wms.4.2024.03.29.02.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:08:49 -0700 (PDT)
Message-ID: <32b3358903bf8ba408812a2636f39a275493eb91.camel@gmail.com>
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
Date: Fri, 29 Mar 2024 11:08:27 +0200
In-Reply-To: <20240328124916.293173-1-pulehui@huaweicloud.com>
References: <20240328124916.293173-1-pulehui@huaweicloud.com>
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

On Thu, 2024-03-28 at 12:49 +0000, Pu Lehui wrote:
> Patch 1 is to enable cross platform testing for local vmtest. The
> remaining patch adds local vmtest support for riscv64. It relies on
> commit [0] [1] for better regression.
>=20
> We can now perform cross platform testing for riscv64 bpf using the
> following command:
>=20
> PLATFORM=3Driscv64 CROSS_COMPILE=3Driscv64-linux-gnu- \
>     tools/testing/selftests/bpf/vmtest.sh -- \
>         ./test_progs -d \
>             \"$(cat tools/testing/selftests/bpf/DENYLIST.riscv64 \
>                 | cut -d'#' -f1 \
>                 | sed -e 's/^[[:space:]]*//' \
>                       -e 's/[[:space:]]*$//' \
>                 | tr -s '\n' ','\
>             )\"
>=20
> The test platform is x86_64 architecture, and the versions of relevant
> components are as follows:
>     QEMU: 8.2.0
>     CLANG: 17.0.6 (align to BPF CI)
>     OpenSBI: 1.3.1 (default by QEMU)
>     ROOTFS: ubuntu jammy (generated by [2])
>=20
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/com=
mit/?id=3Dea6873118493 [0]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/=
?id=3D443574b033876c85 [1]
> Link: https://github.com/libbpf/ci/blob/main/rootfs/mkrootfs_debian.sh [2=
]

Hello,

I wanted to do a test run for this patch-set but did not figure out
how to build rootfs for riscv64 system.

I modified mkrootfs_debian.sh as below, but build command fails:

$ ./rootfs/mkrootfs_debian.sh -d jammy -a riscv64 -m http://de.archive.ubun=
tu.com/ubuntu
...
E: Couldn't download http://de.archive.ubuntu.com/ubuntu/dists/jammy/main/b=
inary-riscv64/Packages

Apparently jammy does not have binaries built for riscv64, or I'm failing t=
o find correct mirror.
Could you please provide some instructions on how to prepare rootfs?

Thanks,
Eduard

--

diff --git a/rootfs/mkrootfs_debian.sh b/rootfs/mkrootfs_debian.sh
index dfe957e..1d5b769 100755
--- a/rootfs/mkrootfs_debian.sh
+++ b/rootfs/mkrootfs_debian.sh
@@ -16,6 +16,7 @@ CPUTABLE=3D"${CPUTABLE:-/usr/share/dpkg/cputable}"
=20
 deb_arch=3D$(dpkg --print-architecture)
 distro=3D"bullseye"
+mirror=3D""
=20
 function usage() {
     echo "Usage: $0 [-a | --arch architecture] [-h | --help]
@@ -25,6 +26,7 @@ By default build an image for the architecture of the hos=
t running the script.
=20
     -a | --arch:    architecture to build the image for. Default (${deb_ar=
ch})
     -d | --distro:  distribution to build. Default (${distro})
+    -m | --mirror:  mirror for distribution to build. Default (${mirror})
 "
 }
=20
@@ -44,7 +46,7 @@ function qemu_static() {
     # Given a Debian architecture find the location of the matching
     # qemu-${gnu_arch}-static binary.
     gnu_arch=3D$(debian_to_gnu "${1}")
-    echo "qemu-${gnu_arch}-static"
+    echo "qemu-${gnu_arch}"
 }
=20
 function check_requirements() {
@@ -95,7 +97,7 @@ function check_requirements() {
     fi
 }
=20
-TEMP=3D$(getopt  -l "arch:,distro:,help" -o "a:d:h" -- "$@")
+TEMP=3D$(getopt  -l "arch:,distro:,mirror:,help" -o "a:d:m:h" -- "$@")
 if [ $? -ne 0 ]; then
     usage
 fi
@@ -113,6 +115,10 @@ while true; do
             distro=3D"$2"
             shift 2
             ;;
+        --mirror | -m)
+            mirror=3D"$2"
+            shift 2
+            ;;
         --help | -h)
             usage
             exit
@@ -162,7 +168,8 @@ debootstrap --include=3D"$packages" \
     --arch=3D"${deb_arch}" \
     "$@" \
     "${distro}" \
-    "$root"
+    "$root" \
+    "${mirror}"
=20
 qemu=3D$(which $(qemu_static ${deb_arch}))
=20


