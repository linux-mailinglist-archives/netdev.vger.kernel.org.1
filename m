Return-Path: <netdev+bounces-65438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DE283A753
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 11:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C37E1C21D00
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 10:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2117B1AAA9;
	Wed, 24 Jan 2024 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e1L+sDet"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FE31AAB9
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 10:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706093883; cv=none; b=Ix5nDXwm9AyYbB74WIEnaL9Ais7onNicPuwM6cCO+lw+Vh9/1U8/js8tiN7gfbHZzAqclO7k2UwohIUhpIjDLy16+qBvzC2MbcgublDrhEnICX/8728ZTvqp1InbrNh7FO5dh5n0kF2KRyYUufs1EaxZtmOJAJUQvc1BtKF335c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706093883; c=relaxed/simple;
	bh=095eySjr9UdkzN6h8F///pYrDXdNnhrwqoAvJkhHULs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ob46D8KpZ4TD0ZV2hqLtHJbLxl9ig/DZtnX31Wjdfj9zR3zk0f5uU7jMGO2dY/AtYQPut8Y8d6n6EId103lcxtxie4qr/jDztEEadkd3X4f6PFmPwoQfe5/OkYl9DuWBjT7Jb1NaMgsW67A33HV+Zm8J6G4b27avQfa2YopyrK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e1L+sDet; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso13561a12.0
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 02:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706093879; x=1706698679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=095eySjr9UdkzN6h8F///pYrDXdNnhrwqoAvJkhHULs=;
        b=e1L+sDetBI1YtsLpOjLl+VO4HeiNaLjIEvXNzSSEKart/kF+Zh6xzqkOW0x4ipMz/y
         YGzzHomAOoc6Jrusyrzvc69L/20aHhm3Enkn+nii0MngahBGvW1JVMW3WwNDlgKqRqgH
         WX7w60pRllwL7r52s2vyLW1YIZETzlZKU4aOgqfJtddLV5XManymdP/g8Q4mDiwD92WT
         oFjvB3rfkEuumsOpHPxg67f/1dANoY9Qi4DhiAoDyhEAVs9NX5FQ9gbbV2By8iNeo3Dj
         pk3I9B88iCcQ8fPqBaGOPhjYT9stq+vWZZauR06GB3mHu5P9TOnXZix3WQ2BAqiTk3Vq
         ZjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706093879; x=1706698679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=095eySjr9UdkzN6h8F///pYrDXdNnhrwqoAvJkhHULs=;
        b=wOlfhNXNot2CWJ9yW05rhtYjUC6GHk+YJZwdZ2nnji1lAkjruxTSwChQS3sreYvmLm
         t5PqGH1UL5XYpzeKKNa6pc/C64w1PG75CtqqSVXjeoiR8pfNWAqcrxtv7uLsz/MLlMDe
         fjTH+fAh5pqLWPDhxxK5lGcWnkf8zrmdMMysZZERMM20n82ULKz2urAFve8kwwNy1iCp
         i2OIgrV+XwQmzzGLnxtr8xWe145ta59K+rY0ZXJFEab0tp8ateES2J3DYAbSM+g3bOwM
         nw/cyMQjnIP1cm7fseXaoZPvFf80EZMruAoUD5dHn8szzSFURHKQkoJH/emw9RuQ9lry
         Q+zw==
X-Gm-Message-State: AOJu0Ywno1XQY+6BKa+slf3YAlMHd9iKbbG76z0hCwriTde+JW+okjWP
	qcNLMUNxkRMNb/h20rQcT6e5KHu9HxUyAHXuDyaqEimNvDiC6sV3NEX/X+3OiAAA52IBE8jLyHn
	iGE8jdnEbC13nAE3Fy+viDvihTt7/yIgg2Skn
X-Google-Smtp-Source: AGHT+IEyJLEJeXzrz7WWPOPz319HwrQPvPDFw7AtqAnVFipnMCWC8jtIyoIoTMP7JJeoV+a2BjBgXMK8TZV1bSra9MA=
X-Received: by 2002:a05:6402:1d84:b0:55a:4959:4978 with SMTP id
 dk4-20020a0564021d8400b0055a49594978mr44083edb.7.1706093878885; Wed, 24 Jan
 2024 02:57:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124101404.161655-1-kovalev@altlinux.org> <20240124101404.161655-2-kovalev@altlinux.org>
In-Reply-To: <20240124101404.161655-2-kovalev@altlinux.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jan 2024 11:57:47 +0100
Message-ID: <CANn89iLKc8-hwvSBE=aSTRg=52Pn9B0HmFDneGCe6PMawPFCnQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] gtp: fix use-after-free and null-ptr-deref in gtp_genl_dump_pdp()
To: kovalev@altlinux.org
Cc: pablo@netfilter.org, laforge@gnumonks.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, osmocom-net-gprs@lists.osmocom.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, nickel@altlinux.org, 
	oficerovas@altlinux.org, dutyrok@altlinux.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 11:14=E2=80=AFAM <kovalev@altlinux.org> wrote:
>
> From: Vasiliy Kovalev <kovalev@altlinux.org>
>
> After unloading the module, an instance continues to exist that accesses
> outdated memory addresses.
>
> To prevent this, the dump_pdp_en flag has been added, which blocks the
> dump of pdp contexts by a false value. And only after these checks can
> the net_generic() function be called.
>
> These errors were found using the syzkaller program:
>
> Syzkaller hit 'general protection fault in gtp_genl_dump_pdp' bug.
> gtp: GTP module loaded (pdp ctx size 104 bytes)
> gtp: GTP module unloaded
> general protection fault, probably for non-canonical address
> 0xdffffc0000000001:0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> CPU: 0 PID: 2782 Comm: syz-executor139 Not tainted 5.10.200-std-def-alt1 =
#1

Oh wait, this is a 5.10 kernel ?

Please generate a stack trace using a recent tree, it is possible the
bug has been fixed already.

