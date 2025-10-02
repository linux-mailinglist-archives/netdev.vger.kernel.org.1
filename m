Return-Path: <netdev+bounces-227628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAC0BB3F3B
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 14:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163DB3A44F4
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 12:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE7D3112C3;
	Thu,  2 Oct 2025 12:56:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6DE3112BA
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759409785; cv=none; b=lK2ZQS341+T4y+fQYrGahyAAvbiFSFvPtiLi42W9T1juowWpK05WyRzlrZFepPTgJ0N1k8dk472WGm6fNn30sOj4MkxE1QEX1ld5SAS7tHViXIBhWsk6NYALB9EIwY14Ph2KEcy63xtmALUgt9da5FFldUMLCvue3Q+aZy9TIXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759409785; c=relaxed/simple;
	bh=Bzm3UVzy5UmWZcilLMKv+UlC3Okbitce2Is02Gaxtrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYSnLk9jcmgJNsCnpskp8Gbv1C6Xh/E07i8MAiGU+Hl8TgxZuqDc7GCzfIevB4/0ha1mPVBfdRlDZPJrkfgqGM5cGl0L3ESYMy4GbAbJGPjw5Rei+Fn8zdkn6nhjkLrWuKrQQzdUfCs093kCVlJjiCeluagFIfKZ2zpDJtoR+zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-54bc2d1feb2so244621e0c.1
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 05:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759409783; x=1760014583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ec+ndxQ3jnu1a8VNviNr06HkWUDsCBC6MfDIjOmWDIU=;
        b=GzHvRo/juc/lWfxUBDXU9iooRMvI0nbCQ7Mqv4TPTIvfJH2RgRfd3WKPMt/ykq0Uh3
         LIjoD9G0UlhS9Dm1ufbtneHKri3sA/9/YAk16F1QTPa1F7V7L+IjLJeUGakkFoBrOrwG
         WeRjqSNcC+naSwbIrGuSD3LrOmaGyxOXGKQKCA+WXcyroBf8XcV/ooN7WV7/GPms86JJ
         LMks8J3XKut0e2j+20cr50oti0Ae9dqB66Pka1ndgWmzsMbGTvvuWs92X1jxASwRmPt5
         l4x5clEyH/EfOtgYJaywpNGFwYuX8WI5fyl882bOZ2ZBJKK8DXBeVzXaEO6K20Najqbq
         ihPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRW5clnnN8+ZeFhNf3afTQKCcvsvBYjMHyLxFhoyrjpNCFzdXS6MKV9wOR/uDRZoCfdYP6zEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcA9NmScGltCbWJRuLHGMCEr5ZZP8fnLc+9E+VXaQBISWR3ARG
	CB0YfIxlAQdlf1JWWFrJ5vFY93YJtrwo6DRYqWuz184UCgsxJY3yoAhAKcCJiNG8Jvbo6g==
X-Gm-Gg: ASbGncs8bI3GBIC2EjqWMs2fPcLUeYFXivHSLihmPS25eCbNmHFu1mrC43BWHzTQbVp
	lJXbsa/muuliU45Z5iOZMpPpegom1f+3AmUGsLzCFhCD8DrijCvNyO8sCjG8ucUp3p92YDEVtJk
	/KmV/kVZ4fAtCf/GlI27EmWnzaHODlVx4G5NbvweHbRlnct9eRBjUOaxCXNrpo6bHaxozDG1/I/
	RPhldqSnmxxKzWp02fBBLAjVlONVXeGvkGT5raSEGd0IQly3MTLBmhmFD0JnJVrTOd8Y0EWM9QZ
	QFfjlVOZ53BRnJvpJJ/jrTBf+gOwHJFoT69jeHo6N2QrvGRBzK3esDcfB/mvzZHk/tvLaHnQFJV
	QkKd4fNaSK5Vx5jxMG8w8P9w4tmCoZJaAhtV8i9x0IbnAbikWwzjpdee9q0qyYcW4uxYdnIKacP
	jytPjskpui
X-Google-Smtp-Source: AGHT+IGzarExJZ4Xxofnuwxh2r/CoNWYKwfkicrENIoN/pyX7YQVjdGgOJwk/7Yqhtb0ghTWp9RhzA==
X-Received: by 2002:a05:6122:251a:b0:539:2a2c:6efe with SMTP id 71dfb90a1353d-5522d2a87afmr3036392e0c.4.1759409782642;
        Thu, 02 Oct 2025 05:56:22 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523cce7a75sm517593e0c.0.2025.10.02.05.56.20
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 05:56:20 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5a46c3b3a5bso522211137.0
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 05:56:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWHWnfWjUuQcxmY8cCEXYRh5dlAhhssfmTUnS4sBAde7LJT1mdcVTVgM+NouR2tqUyd310LsI=@vger.kernel.org
X-Received: by 2002:a67:f74a:0:b0:5d3:fecb:e4e8 with SMTP id
 ada2fe7eead31-5d3fecbe643mr2057033137.5.1759409779799; Thu, 02 Oct 2025
 05:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002081247.51255-1-byungchul@sk.com> <20251002081247.51255-3-byungchul@sk.com>
 <2025100255-tapestry-elite-31b0@gregkh>
In-Reply-To: <2025100255-tapestry-elite-31b0@gregkh>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Oct 2025 14:56:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWXuXh4SVu-ORghAqsZa7U6_mcW44++id9ioUm5Y4KTLw@mail.gmail.com>
X-Gm-Features: AS18NWCmqHU8DKNueQjpF6Ifrv2W5fzYfUTjQ8XBBt-1KrFWqeUHHsvmYo_0fpY
Message-ID: <CAMuHMdWXuXh4SVu-ORghAqsZa7U6_mcW44++id9ioUm5Y4KTLw@mail.gmail.com>
Subject: Re: [PATCH v17 02/47] dept: implement DEPT(DEPendency Tracker)
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org, kernel_team@skhynix.com, 
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com, 
	linux-ide@vger.kernel.org, adilger.kernel@dilger.ca, 
	linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org, 
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch, 
	duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu, 
	willy@infradead.org, david@fromorbit.com, amir73il@gmail.com, 
	kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org, 
	mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org, 
	vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, 
	cl@linux.com, penberg@kernel.org, rientjes@google.com, vbabka@suse.cz, 
	ngupta@vflare.org, linux-block@vger.kernel.org, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org, 
	dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org, 
	dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com, 
	melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com, 
	chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com, 
	max.byungchul.park@gmail.com, boqun.feng@gmail.com, longman@redhat.com, 
	yunseong.kim@ericsson.com, ysk@kzalloc.com, yeoreum.yun@arm.com, 
	netdev@vger.kernel.org, matthew.brost@intel.com, her0gyugyu@gmail.com, 
	corbet@lwn.net, catalin.marinas@arm.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org, 
	sumit.semwal@linaro.org, gustavo@padovan.org, christian.koenig@amd.com, 
	andi.shyti@kernel.org, arnd@arndb.de, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com, 
	mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, 
	samitolvanen@google.com, paulmck@kernel.org, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, josh@joshtriplett.org, 
	urezki@gmail.com, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	qiang.zhang@linux.dev, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, chuck.lever@oracle.com, neil@brown.name, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, 
	anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	mark.rutland@arm.com, ada.coupriediaz@arm.com, kristina.martsenko@arm.com, 
	wangkefeng.wang@huawei.com, broonie@kernel.org, kevin.brodsky@arm.com, 
	dwmw@amazon.co.uk, shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com, 
	yuzhao@google.com, baolin.wang@linux.alibaba.com, usamaarif642@gmail.com, 
	joel.granados@kernel.org, richard.weiyang@gmail.com, geert+renesas@glider.be, 
	tim.c.chen@linux.intel.com, linux@treblig.org, 
	alexander.shishkin@linux.intel.com, lillian@star-ark.net, 
	chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com, 
	link@vivo.com, jpoimboe@kernel.org, masahiroy@kernel.org, brauner@kernel.org, 
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com, 
	andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	rcu@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Thu, 2 Oct 2025 at 10:25, Greg KH <gregkh@linuxfoundation.org> wrote:
> > @@ -0,0 +1,446 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * DEPT(DEPendency Tracker) - runtime dependency tracker
> > + *
> > + * Started by Byungchul Park <max.byungchul.park@gmail.com>:
> > + *
> > + *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
> > + *  Copyright (c) 2024 SK hynix, Inc., Byungchul Park
>
> Nit, it's now 2025 :)

The last non-trivial change to this file was between the last version
posted in 2024 (v14) and the first version posted in 2025 (v15),
so 2024 doesn't sound that off to me.
You are not supposed to bump the copyright year when republishing
without any actual changes.  It is meant to be the work=E2=80=99s first yea=
r
of publication.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

