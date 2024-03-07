Return-Path: <netdev+bounces-78316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2376874AEA
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 10:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B762894E3
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B4182C9C;
	Thu,  7 Mar 2024 09:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T5MlrekY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963AC63131
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709804094; cv=none; b=qtRMxwiNWqVUQBEUJ/chHAWLe4vEoVF6X1tFsG48DKFh+HBHsVeZAZns2u3lDyGG0oqfYy3OAJir64KJ2mZV+QMejKopKPHHaWoF3OU0iH0MRXrrghMBhebvyVnmfRybLXnsqsMg2e41NNKHo/wh0PuZrCAMMWC5Vfm40zR71l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709804094; c=relaxed/simple;
	bh=L4Prq1rCt+z017mIQ/mC+oQIbZqm/g2+SGNg5Ce6zZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luz4txEN6yfpWBRcN3tbE5IDd8hp09jnDA6TJV+7sDtzQ9Tk1TdRmhPDWiyb6ERum5fHDtX5sryn0ZaFlxzw+4VBNyxdOW1+KwX4U83PXiNxAy9otMIrilX3AmMyukCkzQDljqL84zdBSj5/XHMhnk9Zd6R19u7w8Yifomeb6lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T5MlrekY; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso10511a12.0
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 01:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709804091; x=1710408891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfXdKbx16ArN7ryK6H8kWQYWNNdIWutOouoDUmboiHU=;
        b=T5MlrekY91Y2kyHroTHqAomROHtqZD3kmkZS/6vvo6nS68jKpOhYw+yfhRVNt0z5QH
         OZHoJBLdJzyIu/rehQ9325aGxlqutXYHPPRWYtqutU77IckpJd176kjlZ+fJxpxRGfPU
         pLzLd14AslZ88D+5lIZAD0bO0ArT5ZlDJB0GFarrbYIVstiVLK9xcBTwqktMJHHoxTkq
         zoCkVRZIA/+YeEwHl3luwtChbVGY4v+nJDvyAK+7whhi8RMYozoLSfVyWOc+YCE7dUgN
         U6AuhRmdxVeNGFaJTeAj7QAOdn6wiCqEC6czyKDif7LaaFXz/6SdWwgWlVOCUGXI2O8z
         nHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709804091; x=1710408891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfXdKbx16ArN7ryK6H8kWQYWNNdIWutOouoDUmboiHU=;
        b=lXavRmqs/MHCrCnFA0SJskz/tiCbIqoqfNkatffG2eHNhDS2uorwCjB/dXrGpqPWhZ
         +gobN98fdAUGooDaiVYYFNV4R2j46C7plE36bfHrFaYRlG6KbOItSYp8W7AdzeuIeZyF
         s1UkMuzWF6I50au5+vUxAu1S76cdAYnVVBpDGpgtAnc8qGDYT2QHKnt53FKDV3PSjAXa
         lIxuJq3d1nI3Ti+ULKIDsCPQHThtRuHcliRgMW4BEvA9aXUgYRuJapnZJOkTde9yNizc
         KIGi2zxc9zsjjmA7zL2RmKE1tqRlRKFbquYphtAIsbr3ZPthi1KBFzPgwNLVPviDgO33
         umIg==
X-Forwarded-Encrypted: i=1; AJvYcCVoTUGkFIvIx3kHeEIEXsDychVWZtHQ4+sLntYh8eZ9wQWFMUCLwD1OLY9qmWtPQCwyvDTpkD2c+Q4SZY3DZf63NP1iizpE
X-Gm-Message-State: AOJu0Yz3x5V6fGwcXbOHcTEjm6dD0qk7yh/m9iTt6ad5TwCSTicdTYq0
	zbZfx8ASzUSkAcJa/pddRv5Pu2a3A5cpAgN8lcse2VDDWrW9fLDLO4Ui2hc5EAKywbZjIBpRYPx
	rgs2Afxu39bZDx6A8tKxByIh+9oKSvlWhDFFJ
X-Google-Smtp-Source: AGHT+IE79WdC2DrfPAa4eNZibQ1IGJ8mhfMF4oJb/vbufsRgGyCkURPGVNvdq7sTOW1pSVHCVeBZQuGT254/sUcBCVE=
X-Received: by 2002:aa7:d5ca:0:b0:567:f451:bfb2 with SMTP id
 d10-20020aa7d5ca000000b00567f451bfb2mr188925eds.2.1709804090544; Thu, 07 Mar
 2024 01:34:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <70C97E7F-767B-4E75-A454-E4468505F248@suse.de> <CANn89iKseL-ihYhrGmbp3D7Fztg97re61wZuaqB61OMBeJbVxQ@mail.gmail.com>
 <D26DFFCB-1FF2-40E4-BD0B-F0410471650B@suse.de>
In-Reply-To: <D26DFFCB-1FF2-40E4-BD0B-F0410471650B@suse.de>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Mar 2024 10:34:36 +0100
Message-ID: <CANn89iLvfZisrqgqGkM-WaLFxSuVRVw3HvOKqKHjRyvadE5oog@mail.gmail.com>
Subject: Re: Doesn't compile commit 0d60d8df6f49 ("dpll: rely on rcu for netdev_dpll_pin()")
To: Coly Li <colyli@suse.de>
Cc: arkadiusz.kubalewski@intel.com, vadim.fedorenko@linux.dev, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 7:39=E2=80=AFAM Coly Li <colyli@suse.de> wrote:
>
>
>
> > 2024=E5=B9=B43=E6=9C=887=E6=97=A5 14:35=EF=BC=8CEric Dumazet <edumazet@=
google.com> =E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, Mar 7, 2024 at 7:14=E2=80=AFAM Coly Li <colyli@suse.de> wrote:
> >>
> >> Hi folks,
> >>
> >> The commit 0d60d8df6f49 ("dpll: rely on rcu for netdev_dpll_pin()=E2=
=80=9D) doesn=E2=80=99t compile and see the following error message,
> >>
> >> colyli@x:~/source/linux/linux> make
> >>  CALL    scripts/checksyscalls.sh
> >>  DESCEND objtool
> >>  INSTALL libsubcmd_headers
> >>  DESCEND bpf/resolve_btfids
> >>  INSTALL libsubcmd_headers
> >>  CC      net/core/dev.o
> >> In file included from ./arch/x86/include/generated/asm/rwonce.h:1:0,
> >>                 from ./include/linux/compiler.h:251,
> >>                 from ./include/linux/instrumented.h:10,
> >>                 from ./include/linux/uaccess.h:6,
> >>                 from net/core/dev.c:71:
> >> net/core/dev.c: In function =E2=80=98netdev_dpll_pin_assign=E2=80=99:
> >> ./include/linux/rcupdate.h:462:36: error: dereferencing pointer to inc=
omplete type =E2=80=98struct dpll_pin=E2=80=99
> >> #define RCU_INITIALIZER(v) (typeof(*(v)) __force __rcu *)(v)
> >>                                    ^~~~
> >> ./include/asm-generic/rwonce.h:55:33: note: in definition of macro =E2=
=80=98__WRITE_ONCE=E2=80=99
> >>  *(volatile typeof(x) *)&(x) =3D (val);    \
> >>                                 ^~~
> >> ./arch/x86/include/asm/barrier.h:67:2: note: in expansion of macro =E2=
=80=98WRITE_ONCE=E2=80=99
> >>  WRITE_ONCE(*p, v);      \
> >>  ^~~~~~~~~~
> >> ./include/asm-generic/barrier.h:172:55: note: in expansion of macro =
=E2=80=98__smp_store_release=E2=80=99
> >> #define smp_store_release(p, v) do { kcsan_release(); __smp_store_rele=
ase(p, v); } while (0)
> >>                                                       ^~~~~~~~~~~~~~~~=
~~~
> >> ./include/linux/rcupdate.h:503:3: note: in expansion of macro =E2=80=
=98smp_store_release=E2=80=99
> >>   smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
> >>   ^~~~~~~~~~~~~~~~~
> >> ./include/linux/rcupdate.h:503:25: note: in expansion of macro =E2=80=
=98RCU_INITIALIZER=E2=80=99
> >>   smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
> >>                         ^~~~~~~~~~~~~~~
> >> net/core/dev.c:9081:2: note: in expansion of macro =E2=80=98rcu_assign=
_pointer=E2=80=99
> >>  rcu_assign_pointer(dev->dpll_pin, dpll_pin);
> >>  ^~~~~~~~~~~~~~~~~~
> >> make[4]: *** [scripts/Makefile.build:243: net/core/dev.o] Error 1
> >> make[3]: *** [scripts/Makefile.build:481: net/core] Error 2
> >> make[2]: *** [scripts/Makefile.build:481: net] Error 2
> >> make[1]: *** [/home/colyli/source/linux/linux/Makefile:1921: .] Error =
2
> >> make: *** [Makefile:240: __sub-make] Error 2
> >>
> >> Can anyone help to take a look? Thanks.
> >
> > Look at past messages in netdev@ mailing list, refresh your tree to the=
 latest,
> > you will see this is already discussed and fixed.
> >
> > 289e922582af5b4721ba02e86bde4d9ba918158a dpll: move all dpll<>netdev
> > helpers to dpll code
> > 9224fc86f1776193650a33a275cac628952f80a9 ice: fix uninitialized dplls
> > mutex usage
> > 640f41ed33b5a420e05daf395afae85e6b20c003 dpll: fix build failure due
> > to rcu_dereference_check() on unknown type
>
>
> Indeed, I did that on Linus tree, but last commit of my local log is,
>
> commit 67be068d31d423b857ffd8c34dbcc093f8dfff76 (HEAD -> master, origin/m=
aster, origin/HEAD)
> Merge: 5274d261404c a50026bdb867
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Wed Mar 6 08:12:27 2024 -0800
>
>     Merge tag 'vfs-6.8-release.fixes' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/vfs/vfs
>
>
> Maybe it is a CDN synchronization delay, I will try to pull again later.

Network maintainers submit their pull requests to Linus every
Thursdays in general.

