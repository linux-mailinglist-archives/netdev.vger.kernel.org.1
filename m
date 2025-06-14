Return-Path: <netdev+bounces-197768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B65B9AD9D7D
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 16:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C1C189BC09
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 14:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D052DA741;
	Sat, 14 Jun 2025 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHGI1h5a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B032D9EFD;
	Sat, 14 Jun 2025 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749910950; cv=none; b=bjPPP9Zv/0H1Ep7gV4s9J8Ith2KOcHHYRPeff384610bm63bk1JpxveF4ojQfaSSuGHMAOmkAe6IA+oZSzdp5WbJRJjMN/iFTalTRHBmk8OlMpOdylN9tu/0Z0z5Xyj3D398O9KKok3IimvxRgV5YSXJJJmoZvIj6ME5kx+xWTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749910950; c=relaxed/simple;
	bh=Rg+fgZCwsIUrfRiu8mTCYByi4MeRpBOzpFg5lYgvIBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KrrqLhFSryPwK+fOsYKvray3aAIVl6LZu/NyA24HdZpUZXycbFdewqaZdWNhFSDdeXoXjzWt53/bsoGn+TvfsREcKvRvaNYUlSBarIGxJTe2/orzvqjLDK+Ltw5ZTImM7kGmZs5Lok9BJw7yduTouhrzmCTiZIrNZSmAfqk656M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHGI1h5a; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-73a44512c8aso4502a34.0;
        Sat, 14 Jun 2025 07:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749910947; x=1750515747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X3hWngazZR49X9JH2w9golPTcAudBQyhGLqPPLoGo5c=;
        b=iHGI1h5aj6vf1CP667ZR8LV4/Wi7F6f0WMlsj5ta++n7L8n5kvkbYi7KO9E1Kwcwc9
         INSExVOJKUxAHGReLZuSxm/YYBQPL28we/oIs9Q88iC7STeA9oevgF7tb+933rNDB/+V
         0yH0/JMWqfLTMcF4PvxFOtwCCzKzTo35RHwHyTR0q9V5OBFuh86/dRaMrERNksl38EYG
         ot+oyQx8ak3IxD5H+A4ie8wMv2fVZTv6XiIKoiSnPpDeDhc2FwuWS0TOCEAtM5l+9YEN
         L92nQs17oONPSGOk6WKWTeFYqG5/xVhiqwyw0W04LS9rAxgCznXYehln85zDKWuIP7jH
         mVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749910947; x=1750515747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3hWngazZR49X9JH2w9golPTcAudBQyhGLqPPLoGo5c=;
        b=YqjuhAZm7oI91iUcW0dndSk12oJRmaIUMPeUypK0AbYa4FKS3mlAQ5iwf6afY0VDAX
         CESaucZvqHgRUkuOfHz/0d6tTacxkEndb8AGtVRQopOVIofWmI+3WETdCLLG6tZ+nksw
         YAdFS0nq+V0z++TrUS5H9RwUVxWCnYjyRzmJ8HRSUaYX3BMOanwGgk8RxsqpMAooymcQ
         U0GTtEt1KUEN9p7BRdliP+0l4PHrIb5G3daGMqN8EIZptl2x9MOmPpJwyrIikvr0tpu/
         0AbsFJqI1uxBgXajrkHS0zrZBam+fPgjaea6UAzxGA6z5r5Gxoa3BdFRIme4dzvg1ZqJ
         HBOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN69Ekrjxw8gWOR3K0zhNwG+4GxZFmHWRHzFuHTJvwhqjy+otrMOaob45gax0wBK0M3fifsEHhDzvPRCE=@vger.kernel.org, AJvYcCXeUgzVRgOyPUkvC3RKq24KHX/gphzLdjK23Fr7bSvaKVs45Upki5NU/7CMg6spikyC28mSQmvQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwDth2doHwFwP0VJLFHFTPYTUlsdUFxk/8xfIAn4Yi4PXUxYXwY
	Q2r1aR4D6BdDZQk61mLdMNinuUv+JJEFlxNseqvR5DRG6y2Kt1zOMnnpafyYs/drPImCAs/vxOs
	HCae3BWiM0e28TBQzJGNR+0AV3IfxT+s=
X-Gm-Gg: ASbGncud5oUKlucbMi2rI7YtAwQZl/OZqRGNTYNi5857U3vLBLQO5rUTMuU+wMiBhYt
	Tzb8dqcJrPYASxS5rb1VgFd05eHapUg3f1jgyC22Si8WG5Woien10YHHhopQcsqFYg/RK+lMYrY
	D8r2/fNXhhjRfIUmdPBDujimKzDszPG+TfPl9JKUOuSYRJsWgTjBszOYKTjbcI6kwZyGTzjEuWQ
	w==
X-Google-Smtp-Source: AGHT+IEZSMKfIhF5Wtgl7BPD+RHoz/6+X0THEcMGujucKXpF3oqL7pzaETbvgouujlQgGh81A5s/QdODg0dTieqaME8=
X-Received: by 2002:a05:6870:3925:b0:2d4:e420:926c with SMTP id
 586e51a60fabf-2eaf02c9159mr2147858fac.0.1749910947449; Sat, 14 Jun 2025
 07:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749891128.git.mchehab+huawei@kernel.org> <ba75692b90bf7aa512772ca775fde4c4688d7e03.1749891128.git.mchehab+huawei@kernel.org>
In-Reply-To: <ba75692b90bf7aa512772ca775fde4c4688d7e03.1749891128.git.mchehab+huawei@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Sat, 14 Jun 2025 15:22:16 +0100
X-Gm-Features: AX0GCFtp1S-v0cvoFkINvtULliHiL3lSbK0RuVnxFH7wmNXiGSQZkNSI3JO8tjs
Message-ID: <CAD4GDZzA5Dj84vobSdxqXdPjskBjuFm7imFkZoSmgjidbCtSYQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/14] MAINTAINERS: add maintainers for netlink_yml_parser.py
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Akira Yokosawa <akiyks@gmail.com>, Breno Leitao <leitao@debian.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Ignacio Encinas Rubio <ignacio@iencinas.com>, Jan Stancek <jstancek@redhat.com>, 
	Marco Elver <elver@google.com>, Paolo Abeni <pabeni@redhat.com>, Ruben Wauters <rubenru09@aol.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, joel@joelfernandes.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org, 
	stern@rowland.harvard.edu
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Jun 2025 at 09:56, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> The parsing code from tools/net/ynl/pyynl/ynl_gen_rst.py was moved
> to scripts/lib/netlink_yml_parser.py. Its maintainership
> is done by Netlink maintainers. Yet, as it is used by Sphinx
> build system, add it also to linux-doc maintainers, as changes
> there might affect documentation builds. So, linux-docs ML
> should ideally be C/C on changes to it.

This patch can be dropped from the series when you move the library
code to tools/net/ynl/pyynl/lib.

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a92290fffa16..2c0b13e5d8fc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7202,6 +7202,7 @@ F:        scripts/get_abi.py
>  F:     scripts/kernel-doc*
>  F:     scripts/lib/abi/*
>  F:     scripts/lib/kdoc/*
> +F:     scripts/lib/netlink_yml_parser.py
>  F:     scripts/sphinx-pre-install
>  X:     Documentation/ABI/
>  X:     Documentation/admin-guide/media/
> @@ -27314,6 +27315,7 @@ M:      Jakub Kicinski <kuba@kernel.org>
>  F:     Documentation/netlink/
>  F:     Documentation/userspace-api/netlink/intro-specs.rst
>  F:     Documentation/userspace-api/netlink/specs.rst
> +F:     scripts/lib/netlink_yml_parser.py
>  F:     tools/net/ynl/
>
>  YEALINK PHONE DRIVER
> --
> 2.49.0
>

