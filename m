Return-Path: <netdev+bounces-209665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 876A8B10365
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 10:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587F34E2A38
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 08:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647492749FA;
	Thu, 24 Jul 2025 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDPM+Rsi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C48223DD5
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 08:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345250; cv=none; b=SgbJkmemd8R3005aXhQelXQQQMhPsfIIuDIYChgtSONZ6kqestE8hAs+3O3B8nUrY1oLPJ7CnHC7VTprNtYH17dbQnBnNP4E1FtuM0WNY/bBQ8fZ/P3hAHiKkJgpfFL8zuWKVbOV/1QVOwDfWLvfNz6R3wvl686az0QbJkLjhtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345250; c=relaxed/simple;
	bh=PY6FA72lx+rsHdWf/O1btP/hvDoM5PWlZyolAQrsaaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFdpcFj4XJ7EHUmWvNya6vMQnpQG1Q3yhE9X36GXf2mVJier+BVin/tS6B0yFZuZgA72cC3XfRR7aUFVhl3AElqUNFkc6F87nM3ePQH7Vvi8M/Utx+H0+oRY+9HhQafn1SLSmiOWkpUgHjdFrDfHvxnMKHGP+5knrT8EMFkVOSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fDPM+Rsi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753345246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ty1Nmgr/yohBN38P9mzD5LZanNswcBU4P2JN0tNImlQ=;
	b=fDPM+RsibIGxSoxwmPcGlqFOLjjIopUSuRqQQ0/nzf92YRxK0NGSqE2zjXJtb194VeFUag
	8G/f7i9DY2oofatXr9Ow2fxcQzQyAC0EtNmWKmMiV3FOzozEAoLT1cI1LQzwu8QfRns5Hj
	jRNG25b4UT28nnK6Xl87PHh3OFlUgGo=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-mXvuFT6OPiGrDW-HTucocw-1; Thu, 24 Jul 2025 04:20:44 -0400
X-MC-Unique: mXvuFT6OPiGrDW-HTucocw-1
X-Mimecast-MFC-AGG-ID: mXvuFT6OPiGrDW-HTucocw_1753345243
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-70e4269deb2so10746877b3.3
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 01:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753345243; x=1753950043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ty1Nmgr/yohBN38P9mzD5LZanNswcBU4P2JN0tNImlQ=;
        b=X+Ll0A0riynpohbfg017T2BEdrQd4R5ruEMxSFk7838LMBB8/zGw2TL7K3+1E2rGOX
         0aDRTSGua0Cd267fBB+oxj7reTkWQUMqmWyImSUJbOIthZ991xeuK6GsFV6LF2jCXudN
         3Ef0HPwwsIdAKopqf5VUHGqNnrWT+GYSqok6FFYcDQE18E3SsG0zFBze7178vvEKCArK
         LXh/YTlzTWh2b2OD7maUwCiHwqUgnNVSqTWHrIyDPQxcrAlrd5EbONYj/K0xnY1MXv9P
         uSixmMx7z2b1G2llZDEfpSbTujxOQk/aAU5oa+yHHEJ4rTgUbqCHlu4GkHpdpKr2rEHX
         fEOw==
X-Forwarded-Encrypted: i=1; AJvYcCUwDc7x0nBJzBrqAKiJY5HBhYsODmZAjRJWgLgXQi1nBltfRlB0K7FyeyVCkYN6VLj73USsTmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAQ+wNmCRKbeNWAZl85RlbROIjQL5rb+A8C0TeCV/RQKi649W4
	ikLJ1ghnjTyzgEleApQHjYMwlRIgyod2qGqtIcACNmfjI+mUXDguDeBMl1M5WNDDOpTcSgkV64m
	izGZQNE7d0dIPphDKbjhyJMj4Bo60CXlCFZQlHG2+iWcNW5j438e2+Ed5sI7BMImg09CkR5JLzN
	wHklO5l+jgnRXKLRNTb5kDhF76RxmNJy2M
X-Gm-Gg: ASbGncucMwf3p+BDZJxXjq5zhAYVB1yOXWvhNXmVjwaJOjuMwqCYZinFXLs/FHhtTHW
	EeNuotHF5ADnBVauVc5NOu6RpqHpG0weJPtsgO0N7MTz/zIQX2kXAj1bQPA8EERlWgtqS2MAPBR
	17aei7T4h8uPBiclTa8MUIwg==
X-Received: by 2002:a05:6902:310f:b0:e87:b33c:7981 with SMTP id 3f1490d57ef6-e8dc595b0abmr6776101276.33.1753345243354;
        Thu, 24 Jul 2025 01:20:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhtmOQZoG8MJqXUBbHZjrjfL2o69nkUHbskfHC38XgsD1gmsQVJ+5FqH2fq1iw+bluM/HBXchsFWiPGsWmksc=
X-Received: by 2002:a05:6902:310f:b0:e87:b33c:7981 with SMTP id
 3f1490d57ef6-e8dc595b0abmr6776091276.33.1753345242975; Thu, 24 Jul 2025
 01:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <238b803af900dfc5f87f6ddc03805cc42da2ca35.1753332902.git.xmu@redhat.com>
 <aIHRwwOl-FS8KOV0@fedora>
In-Reply-To: <aIHRwwOl-FS8KOV0@fedora>
From: Xiumei Mu <xmu@redhat.com>
Date: Thu, 24 Jul 2025 16:20:31 +0800
X-Gm-Features: Ac12FXzu1I7NXeznfsc628RU_1n_SK2CsVM_ZFesDKVFeRN_1fJs6j-4D1IwnIg
Message-ID: <CADdRzaF5Ck86fyEYaeWjvoVt=8qEhNKJ8J3ye+x0cb9EATqQ7Q@mail.gmail.com>
Subject: Re: [PATCH net] selftests: rtnetlink.sh: remove esp4_offload after test
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Long Xin <lxin@redhat.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shannon Nelson <sln@onemain.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

resent the reply again with "plain text mode"

On Thu, Jul 24, 2025 at 2:25=E2=80=AFPM Hangbin Liu <liuhangbin@gmail.com> =
wrote:
>
> Hi Xiumei,
> On Thu, Jul 24, 2025 at 12:55:02PM +0800, Xiumei Mu wrote:
> > The esp4_offload module, loaded during IPsec offload tests, should
> > be reset to its default settings after testing.
> > Otherwise, leaving it enabled could unintentionally affect subsequence
> > test cases by keeping offload active.
>
> Would you please show which subsequence test will be affected?
>
Any general ipsec case, which expects to be tested by default
behavior(without offload).
esp4_offload will affect the performance.

> >
> > Fixes: 2766a11161cc ("selftests: rtnetlink: add ipsec offload API test"=
)
>
> It would be good to Cc the fix commit author. You can use
> `./scripts/get_maintainer.pl your_patch_file` to get the contacts you
> need to Cc.

I used the script to generate the cc list.
and I double checked the old email of the author is invalid
added his personal email in the cc list:

Shannon Nelson <shannon.nelson@oracle.com>. -----> Shannon Nelson
<sln@onemain.com>

 get the information from here:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3Da1113cefd7d6

>
> > Signed-off-by: Xiumei Mu <xmu@redhat.com>
> > ---
> >  tools/testing/selftests/net/rtnetlink.sh | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/s=
elftests/net/rtnetlink.sh
> > index 2e8243a65b50..5cc1b5340a1a 100755
> > --- a/tools/testing/selftests/net/rtnetlink.sh
> > +++ b/tools/testing/selftests/net/rtnetlink.sh
> > @@ -673,6 +673,11 @@ kci_test_ipsec_offload()
> >       sysfsf=3D$sysfsd/ipsec
> >       sysfsnet=3D/sys/bus/netdevsim/devices/netdevsim0/net/
> >       probed=3Dfalse
> > +     esp4_offload_probed_default=3Dfalse
> > +
> > +     if lsmod | grep -q esp4_offload; then
> > +             esp4_offload_probed_default=3Dtrue
> > +     fi
>
> If the mode is loaded by default, how to avoid the subsequence test to be
> failed?

The module is not loaded by default, but some users or testers may
need to load esp4_offload in their own environments.
Therefore, resetting it to the default configuration is the best
practice to prevent this self-test case from impacting subsequent
tests

>
> >
> >       if ! mount | grep -q debugfs; then
> >               mount -t debugfs none /sys/kernel/debug/ &> /dev/null
> > @@ -766,6 +771,7 @@ EOF
> >       fi
> >
> >       # clean up any leftovers
> > +     [ $esp4_offload_probed_default =3D=3D false ] && rmmod esp4_offlo=
ad
>
> The new patch need to pass shellcheck. We need to double quote the variab=
le.

Thanks your comment, I will add double quote in patchv2

>
> Thanks
> Hangbin
> >       echo 0 > /sys/bus/netdevsim/del_device
> >       $probed && rmmod netdevsim
> >
> > --
> > 2.50.1
> >
>


