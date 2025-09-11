Return-Path: <netdev+bounces-222031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115ECB52CEF
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 11:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A1A168218
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 09:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E053B2E9EB5;
	Thu, 11 Sep 2025 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yBHad4Al"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54AE2E8DE3
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582302; cv=none; b=NkwZpEiaTg5Xg95sdAGLUAiFSGEdkdB2YWDoIycMdOliUYjDj+zudceYUdQUjuWbF+8qAYmepCPMdXfy4xYcFZAguKhLzcrSjdjOkhU+w2hI77gnDnX6EZFiR6gZJDjDwZ89xcTOUpP0l4j4bVTOTwHOF8JP5BzgaLHSF5a4x3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582302; c=relaxed/simple;
	bh=1B3D6WIyM4uKCWTK+JvwjK5rmKnBn1DsJarcuewJmQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJxMqUn6vn92q6By4XjzTE+5vcnRjIDc98juZtGTjA6mbHyi74KBEhPI9JwhlNo2qKgm6jNMGbu/NlTgB5t4B+cKcGYToTkuwHdDDRPIXHOstSTBByQPyhl57enI6Fg2N3dSebLeP3yJfbfTP5wlLDaGHK5JIqBUeG7I0ga8lv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yBHad4Al; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-811b06efefdso61792685a.1
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 02:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757582299; x=1758187099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1B3D6WIyM4uKCWTK+JvwjK5rmKnBn1DsJarcuewJmQY=;
        b=yBHad4AlHhN6xy1ETyIXTUjHUNyn8b1AyhTsMHAfhIed9rD2urdwr25RkJl/3nbDmo
         1VWACUkvD7U3dYFobURlyHBwJJdDnpOtUHDT6WMqkM9y4XeoGBhk2Ru9hfAdfBfoTBqO
         mJ2sJEeVKNHoSwzDgOZD34o0CJ4wsOwF45aUg8OsHxQOV6BMVRBPjlHEPc3y1eg3xuWz
         w3lZ4EqqzNuLbF8ir0bMPq6eWdsBtOO4CNcj0NhrJ6o2WZw4K2d9JZIRCOMXo+ckdvK2
         WlHQ8DAKM5F5YmF8fLW7d3BWgiLPrKXsjMA72uWERZna9hnOKwmoDz9alq8MGWJg27kC
         ZA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757582299; x=1758187099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1B3D6WIyM4uKCWTK+JvwjK5rmKnBn1DsJarcuewJmQY=;
        b=TEzyQgo8zZocxUzo+v9Xfc6F+SfBoPbY/Amxa/GbbvbmV+vrTsHeyLp5t5ip4uIVlK
         bGhu9XCracDTTTzRUaTVSyZSOHZsoMjeXPsIz+I8KEKaq4kRMbffZ204yegfCGgZFvq2
         V4n7Q/BIzvKseagbiBGjoxAnV8Y+4vzlI/aaN4HAcxl325PaKgLwlDQDm1OccoIanMmv
         5GQnuvylFYyF553xb2Zx9cEp3uo842giv2mGzXvmPqomnbRx4nZBr1WJOi/2oygNRbj3
         jhmPxu9xwbInZgPO/atPpoaGYGFKOHaHy7nzI04Bbn55vN9hI6SU9bHcTCMAUc9g0i0h
         b8Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUhWePDvj6AcyMubBHxSF7glYgC3jzFlivbTFhTbn7OExgWeFVou8S14K90p6/hBxjmv36CSrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDpnwr07DaYei/T15s/GsqWik/Y12OxCekDFIVXhUOD7OmPzKx
	nvpVN5n6dD5+iydUDmMcNsNp2EeiVdtzCXbgS3YzZYmkLjFmolUbzNbvKW7HC+9dxhzx7wNN+Oa
	tgNDp5U6k+EFUS2nXPaMGt3kpjZsK+2ytLDiRu5jU
X-Gm-Gg: ASbGnctIlO6VJNzPVHUIdHAq2aDUKyFtSOGl77o/71G9bL0ortLmG8yEw8Xv9KlJdo5
	HAaCWc02BIx8PkH4CQUo0AtgolRHBJqYTDL7tAeFkH9NB3YmCUuIQsL6+G0hXKLCkLIQvD/Gjj1
	Q0E7LxfLQWkfX2ix+pRPAtwKxWxxuDrETJ1TVB5XieMQi+m5p7PA3LnLcDU2uqNCTHS6OMv8MNC
	pMkRr9x+3zXmxJWuJenKYcatwYpy8eLuLkiGGadL274
X-Google-Smtp-Source: AGHT+IEAdn2JRKDnhaL2qmt37A4l17luV2CMhXbLee/vFTGYZd/pxxVUthlBX8HJQeQEoIdvrbi8slCg3eRXyv3n/Qs=
X-Received: by 2002:a05:620a:45a7:b0:813:8842:93bf with SMTP id
 af79cd13be357-813c1e8e0femr1958044985a.40.1757582298381; Thu, 11 Sep 2025
 02:18:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910024328.17911-1-bagasdotme@gmail.com> <20250910024328.17911-8-bagasdotme@gmail.com>
In-Reply-To: <20250910024328.17911-8-bagasdotme@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 11 Sep 2025 11:17:41 +0200
X-Gm-Features: AS18NWC9Ax6HJ7xE41xsztIAoL9MxJcZhppucVI7C3-6QUaMqtQ6glgozKyha94
Message-ID: <CAG_fn=WPCtL2Knk7_so+9QMcUPY2wCG93BZN-rwJC+ELLgJ4nQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] Documentation: kasan: Use internal link to kunit
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Linux DAMON <damon@lists.linux.dev>, 
	Linux Memory Management List <linux-mm@kvack.org>, Linux Power Management <linux-pm@vger.kernel.org>, 
	Linux Block Devices <linux-block@vger.kernel.org>, Linux BPF <bpf@vger.kernel.org>, 
	Linux Kernel Workflows <workflows@vger.kernel.org>, Linux KASAN <kasan-dev@googlegroups.com>, 
	Linux Devicetree <devicetree@vger.kernel.org>, Linux fsverity <fsverity@lists.linux.dev>, 
	Linux MTD <linux-mtd@lists.infradead.org>, 
	Linux DRI Development <dri-devel@lists.freedesktop.org>, 
	Linux Kernel Build System <linux-kbuild@vger.kernel.org>, Linux Networking <netdev@vger.kernel.org>, 
	Linux Sound <linux-sound@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, SeongJae Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, Jens Axboe <axboe@kernel.dk>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>, tytso@mit.edu, Richard Weinberger <richard@nod.at>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Waiman Long <longman@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shay Agroskin <shayagr@amazon.com>, 
	Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, 
	Saeed Bishara <saeedb@amazon.com>, Andrew Lunn <andrew@lunn.ch>, 
	Alexandru Ciobotaru <alcioa@amazon.com>, 
	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Ranganath V N <vnranganath.20@gmail.com>, Steve French <stfrench@microsoft.com>, 
	Meetakshi Setiya <msetiya@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Bart Van Assche <bvanassche@acm.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Masahiro Yamada <masahiroy@kernel.org>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Jani Nikula <jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 4:44=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> Use internal linking to KUnit documentation.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

