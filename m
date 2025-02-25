Return-Path: <netdev+bounces-169568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A390A44A81
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFCEA3BB761
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04F91624C4;
	Tue, 25 Feb 2025 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="iEQmpNRr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28F2188CD8
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507599; cv=none; b=RfqOkaaSMRKKG8qjl4/ByRHMRCYgkOgdBV9UYRavcLi5CmRPFSpYp3605uqaQojnFo/sPIY0D2/gjGbH3i6WqzovaQuDackQIbRqxqlWTA8Fc1LxNHzXtI+TWn91gfp1xoGHGD+Ok+rJT8QgYowjkK2+vRXCV01PCyD0RbdV6ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507599; c=relaxed/simple;
	bh=3LHxDrqYr+HavOlBopTBYudGLbfK2gK+d9C2ExwkJ2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCobmAYPX5Jg//5OtWuS/cpqTujxZ65esi9xKSdY5sdN0h25N4te3vnlvCSnkN8A/c5WoTtowBT1f+lGqPsX/LGHbeYd+mGgRsAi0SCx3hr0u8J90s6zTk9rUFy5AxOL3ed6yqRi702BxgYerXxZSHyYRGRBORw5Nd+76JE7lME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=iEQmpNRr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-221050f3f00so135894625ad.2
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 10:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740507597; x=1741112397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjCRhvhWEpLHORdZ5NYEM571bXnvUkvwx2xxitEMOSw=;
        b=iEQmpNRr+uW6F1ZdwbZJ3UCeuADs8TPGrfQls/F67GsuhKJ86rm+NGIlcEAFTc5t4O
         J36J9KUlYcQ+1uudWmVI7Um8ta16jdVgirgDbfF2EBIngHNl+MIuaeMP2v1ocHDYCjwt
         fsXMCbDpdSRoFHcfag07y9x32g1xPD0VOcDlOxaUjs/PwL+vPxbMFtJN4B0gWKxRXj4z
         daf0MB2KnwpAcri0EIWNVM+vvzVkefUg5rFr8M5ZMvNYBCqitrPyZCGKQgI3XMtWBUEr
         UPxpepEctTWvh++i6M/xG7utaTbX4ze5HYgwobtjlT0ARjtSejLxX+NoWXaH123c4z04
         7TQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740507597; x=1741112397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjCRhvhWEpLHORdZ5NYEM571bXnvUkvwx2xxitEMOSw=;
        b=FcAN8X4HgQl6qN/xWyAhkyjw+Uu6psNiV3VvUPshFWQlQbIQm18QczgoDlEhIOX3gt
         v4oublhGC18zScWD+eAQeh7kFLIklMGM56ee7ywwz87jjW+5Y8luSnpuDM5blA7gm9/W
         jp45eEe05M5fedSSe4jlXqcJubNha/dw34xHoJ3fNI44p32lhzmlFX0f6Ic/ii2AEK7B
         MPsoJRDnXi4EVVztc2dhfwYL7qaTKLGRdnrY8fT5VV9fiqzsk5/VpANEiqbKFC8UHYOd
         k8c9tq7QWz2lmPqko8xU4pin//rurXR3TonxETsl8ElV5j1wY8pBmUCP01M9fWH/Xkte
         xPbQ==
X-Gm-Message-State: AOJu0Yzmc6JFQ24hbvWD7J/1B6rigt/Mp1CdczIW3rfUIZWRDFg2BLdZ
	1yuQTZd+v+6tc7x7UWxgtC5BeozY0idFwGYxyhI92joV7soUbUnxMSAFw5kIoR2uGW0lGaN9cJq
	JQYo=
X-Gm-Gg: ASbGnctVp69dprg6s0y22Auoorc8l+teWXhazUcItOIN8wkJAT/J4v781j9UDsXYcLz
	0J7cX83f02KI2d8jMwXAmzrLkTT4pXyyBz/9gxthgbFB9Oz1K/WNeieg/MckA1tKa9V5XFfrNgr
	OuWXuzhKig4AzW3Qbd3SU1vpqUXtc4xOVCCiMIHcjfn0u5fgyJ9/VNZ341/dxqCvs8yFC/h/Sw5
	V3+vne74ZMjZiesnNb7jmV8QkQi9IKxmyjk3PuW+/7gc5x8NqGB6+bFivHYOUVgouMcD1PiarMz
	gSmp68Sd0rd0bHiZBLY2wmjfTOe0imp+Ek8Lw3dfWw0plEGAuYrsIk71aqxVcJ9qdjXT61GMTDT
	4e6s=
X-Google-Smtp-Source: AGHT+IG26HjnsM2YqFX92zfJHr0SpmOQ0DUSK2233IbU3+ltpuQNKIpM0rpSTjVehw3//gEEHGyKQQ==
X-Received: by 2002:a17:902:dacd:b0:215:e685:fa25 with SMTP id d9443c01a7336-22307b5302bmr57966135ad.20.1740507596758;
        Tue, 25 Feb 2025 10:19:56 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a092f1dsm17387875ad.114.2025.02.25.10.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 10:19:56 -0800 (PST)
Date: Tue, 25 Feb 2025 10:19:54 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ziao Li <leeziao0331@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] NULL Pointer Dereference vulnerability and
 patch
Message-ID: <20250225101954.3fdb009f@hermes.local>
In-Reply-To: <CA+uiC5YJC0_PLGGpw_Say15-C4zd0bgCu+7VWaB1GYFd7j0xdg@mail.gmail.com>
References: <CA+uiC5YJC0_PLGGpw_Say15-C4zd0bgCu+7VWaB1GYFd7j0xdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Feb 2025 17:11:51 +0800
Ziao Li <leeziao0331@gmail.com> wrote:

> NULL Pointer Dereference vulnerability in iproute2.
> The vulnerability happens in load_ugly_table(), misc/nstat.c, in the
> latest version of iproute2 (41710ace5e8fadff354f3dba67bf27ed3a3c5ae7)
> How the vulnerability happens:
> 1. db is set to NULL at struct nstat_ent *db =3D NULL;
> 2. n is set to NULL at n =3D db;
> 3. NULL dereference of variable n happens at sscanf(p+1, "%llu", &n->val)=
 !=3D 1
> static void load_ugly_table(FILE *fp)
> {
>         char *buf =3D NULL;
>         size_t buflen =3D 0;
>         ssize_t nread;
>         struct nstat_ent *db =3D NULL;
>         struct nstat_ent *n;
>=20
>         while ((nread =3D getline(&buf, &buflen, fp)) !=3D -1) {
>                 char idbuf[4096];
>                 int  off;
>                 char *p;
>                 int count1, count2, skip =3D 0;
>=20
>                 p =3D strchr(buf, ':');
>                 if (!p) {
>                         fprintf(stderr, "%s:%d: error parsing history fil=
e\n",
>                                 __FILE__, __LINE__);
>                         exit(-2);
>                 }
>                 count1 =3D count_spaces(buf);
>                 *p =3D 0;
>                 idbuf[0] =3D 0;
>                 strncat(idbuf, buf, sizeof(idbuf) - 1);
>                 off =3D p - buf;
>                 p +=3D 2;
>=20
>                 while (*p) {
>                     ......
>                 }
>                 n =3D db;
>                 nread =3D getline(&buf, &buflen, fp);
>                 if (nread =3D=3D -1) {
>                         fprintf(stderr, "%s:%d: error parsing history fil=
e\n",
>                                 __FILE__, __LINE__);
>                         exit(-2);
>                 }
>                 count2 =3D count_spaces(buf);
>                 if (count2 > count1)
>                         skip =3D count2 - count1;
>                 do {
>                         p =3D strrchr(buf, ' ');
>                         if (!p) {
>                                 fprintf(stderr, "%s:%d: error parsing
> history file\n",
>                                         __FILE__, __LINE__);
>                                 exit(-2);
>                         }
>                         *p =3D 0;
>                         if (sscanf(p+1, "%llu", &n->val) !=3D 1) {
>                                 fprintf(stderr, "%s:%d: error parsing
> history file\n",
>                                         __FILE__, __LINE__);
>                                 exit(-2);
>                         }
>                         /* Trick to skip "dummy" trailing ICMP MIB in 2.4=
 */
>                         if (skip)
>                                 skip--;
>                         else
>                                 n =3D n->next;
>                 } while (p > buf + off + 2);
>         }
>         free(buf);
>         ......
> }
>=20
> ---
> Steps to reproduce:
> 1. Put attachment files file at misc/poc.c and misc/crash.txt
> 2. Compile poc.c file with:
> gcc -Wall -Wstrict-prototypes  -Wmissing-prototypes
> -Wmissing-declarations -Wold-style-definition -Wformat=3D2 -g -O0 -pipe
> -I../include -I../include/uapi -DRESOLVE_HOSTNAMES
> -DLIBDIR=3D\"/usr/lib\" -DCONF_USR_DIR=3D\"/usr/share/iproute2\"
> -DCONF_ETC_DIR=3D\"/etc/iproute2\" -DNETNS_RUN_DIR=3D\"/var/run/netns\"
> -DNETNS_ETC_DIR=3D\"/etc/netns\" -DARPDDIR=3D\"/var/lib/arpd\"
> -DCONF_COLOR=3DCOLOR_OPT_NEVER -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64
> -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -DHAVE_SETNS
> -DHAVE_HANDLE_AT -DHAVE_SELINUX  -DHAVE_RPC -I/usr/include/tirpc
> -DHAVE_ELF  -DNEED_STRLCPY -DHAVE_LIBCAP  -DHAVE_SETNS
> -DHAVE_HANDLE_AT -DHAVE_SELINUX  -DHAVE_RPC -I/usr/include/tirpc
> -DHAVE_ELF  -DNEED_STRLCPY -DHAVE_LIBCAP -o poc poc.c -lselinux
> -ltirpc -lelf -lcap ../lib/libutil.a ../lib/libnetlink.a -lselinux
> -ltirpc -lelf -lcap -lm
> 3. Run the poc by
> $ ./poc crash.txt
> zsh: segmentation fault (core dumped)  ./poc crash.txt
> ---
> Patch for the vulnerability:
>=20
> From 2f462d5adf071827285291d2ce13119e220681fd Mon Sep 17 00:00:00 2001
> From: lza <leeziao0331@gmail.com>
> Date: Wed, 19 Feb 2025 08:38:48 +0000
> Subject: [PATCH] Fix Null Dereference when no entries are specified
>=20
> ---
>  misc/nstat.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/misc/nstat.c b/misc/nstat.c
> index fce3e9c1..b2e19bde 100644
> --- a/misc/nstat.c
> +++ b/misc/nstat.c
> @@ -218,6 +218,10 @@ static void load_ugly_table(FILE *fp)
>             p =3D next;
>         }
>         n =3D db;
> +       if (n =3D=3D NULL) {
> +           fprintf(stderr, "Error: Invalid input =E2=80=93 line has ':' =
but
> no entries. Add values after ':'.\n");
> +           exit(-2);
> +       }
>         nread =3D getline(&buf, &buflen, fp);
>         if (nread =3D=3D -1) {
>             fprintf(stderr, "%s:%d: error parsing history file\n",


Thank you for finding and reporting a fix for a bug.
But this is not a vulnerability, just a bug.
And the patch is not formatted properly (line wrap) and
required Signed-off-by is missing.

Please fix and resubmit.



