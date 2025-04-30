Return-Path: <netdev+bounces-187129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D60B4AA51F5
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 18:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D024E45F0
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 16:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BA92620C1;
	Wed, 30 Apr 2025 16:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YQwGuUdw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA70A25E817
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746031688; cv=none; b=aCXv1WwY96nB7ld9jvyZonPqyXgMp3D5gtJf+sDQsPD3YRT8gHQu+R2d3EnROBG1c5TZOgn6xxNOH0z+GYFFikG26/HkpKG5aURG5h2oIuy9B3fvdHA5k9B7geYy76aBHZ8np11kUXJOLAeKm1d+bpXrKwVIjGPjXljuhF05xAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746031688; c=relaxed/simple;
	bh=qAb1K49FvLk6Fvif254Pv2os+upsuqhkdxbpwo27QAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYOcU/TpDMx0SQCNbPT8F6W0tK2ergVLJnVaBnsuP0LntpgfI+4Rhc3pIlm3PmUIhxf8geC0+Vqk8ZzMldm1lzh3ktZM68OTKn/y9lBddmp55kRC5sDStT/4X/zFVti0bzUfKQYL0GJuExjJReLPmp3/zvx5mEvxAzhJe+z0eEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YQwGuUdw; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2264c9d0295so16165ad.0
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 09:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746031685; x=1746636485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAEBo9Df9LLxm1rw1yRDAT4lxZrUZ1QNKkJixvE12Jo=;
        b=YQwGuUdwyQBLYDPlTXQDs3hD4Vd8t91dGZaH5PzehE3tl9AVLALVbpdUPmX904WN6x
         yr3TemOFxwTabsgHi0oj6G2SLsm+RjHTyCU36F+LevKs98whgt8W8s9L94YhP7z34DAj
         GXPG+yflJcH+jEkgh/g3ry7JemnQNtc7ob1HyMgfNEP+GLXXfut51CDThsI/ahgkX3cj
         P26ZdOlqS7lo7VACMxhPwqtQ0Xy5whegbOOqAStfvoqOn++fCVC8ijRpmtPuSLsFevW2
         jZnA92F8nQmWcZyR+mgz/VfG5TNAom8SXSm6B7kVFkUmL0Se0ySZjDpAe0YWYWBgz4Ta
         rWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746031685; x=1746636485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAEBo9Df9LLxm1rw1yRDAT4lxZrUZ1QNKkJixvE12Jo=;
        b=HL+RwRs0TtyHe/XEUEEQUJ0+Z/h0NAt29xGUyrcYcUEis6JHYKjtgcM1kbrmaKKnkY
         5kZDRTPvI5YplGtRWYE15PpJon+R0Npn8kvmGEgnu/nkgzORAK3a/SIrTm/23x8bd2YP
         tT4fT1Xcva6YFQ5pxMTG25bdvd5voPhCt63GEQv6tLhxLJK4RQpJjG9iJRMrGO2bIBhG
         rSJ44FiFwige4usK9UQEmrIY/c/NIuXgGnk7AklGHVD3uU5RQUBdv/VWknwpmOxh3W7D
         CitK2A7rzzXJkcyjjjWww+lhXqlDuH8mF0fgs/6M3xasfEqamXHzCA3sGrnd2raURxCu
         iO9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGS2ruLeakPZe4QmyizV9x5KsUS6AkheT4U5IBQ8/MK51Fht0EyWfLAoywQslHG3BTGmpfH7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM/0ADDX4YYtnAGgaXhJ4f9TzZnRIPWafyF12kFTU08hdKKC/a
	J9r6UNjGomweZNhYLVrxu/jvcsk/QzmMIXv4H3l5+2B3+8nlJTButgw/jcVg4WVQsHaCB2RwP9v
	K4OF4wvz1++a1vvY4NMd6FhAxbvJih3gB15Z3
X-Gm-Gg: ASbGnctL0or27G8p9h++CfdbKnyJD/e7niP2pV8HrXrUYtSCWhYjNHFqson89RkDxIf
	utPNdASUQ7d5t/3ePsbatHtrwUziiLSHZeSDxuIdJ0TNDq1a+seY62D2aum1d0QE0Nnpdnsleze
	68OVfpOcUtvv/NRY4tIKKoTJF8yURs4cilaEBhSOsgQl9lz2deE9fSE7c=
X-Google-Smtp-Source: AGHT+IEITfEceKA4HZEaRpGypYrD8Xg06sEHPJWmfHPn+AcjTskf850muYQLJ3dxxhFseK21/2mLUVHM0pmTKncq3ms=
X-Received: by 2002:a17:902:f60a:b0:215:9ab0:402 with SMTP id
 d9443c01a7336-22df40757bemr3900405ad.18.1746031684980; Wed, 30 Apr 2025
 09:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424200222.2602990-1-skhawaja@google.com> <52e7cf72-6655-49ed-984c-44bd1ecb0d95@uwaterloo.ca>
 <680fb23bb1953_23f881294d9@willemb.c.googlers.com.notmuch>
 <aA-9aEokobuckLtV@LQ3V64L9R2> <680fc1f210fdf_246a60294b2@willemb.c.googlers.com.notmuch>
 <5fa8c9b8-527c-4392-9c9f-4e1e93ab5326@uwaterloo.ca> <20250430133734.0e78a746@pumpkin>
In-Reply-To: <20250430133734.0e78a746@pumpkin>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 30 Apr 2025 09:47:53 -0700
X-Gm-Features: ATxdqUEKpJ6Ex76WnRJAliDAbCrhEWRSQkpo-Mww7gANYgO3-1n_eRh7POfenkE
Message-ID: <CAAywjhSV93FBE+3oqQ4LyQ9GD8F8YMaiPnp4uTbcK9a2uGRStQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/4] Add support to do threaded napi busy poll
To: David Laight <david.laight.linux@gmail.com>
Cc: Martin Karsten <mkarsten@uwaterloo.ca>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Joe Damato <jdamato@fastly.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 5:37=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Mon, 28 Apr 2025 14:05:17 -0400
> Martin Karsten <mkarsten@uwaterloo.ca> wrote:
>
> ...
> > That's not the same. The existing busy-poll mechanism still needs an
> > application thread. This thing will just go off and spin, whether
> > there's an application or not.
>
> I think this (and elsewhere) should be 'busy spin' not 'busy poll'.
> That would make it much more obvious that it really is a cpu intensive
> spin loop.
"Busy Poll" is synonymous to polling a socket/napi/queue while
spinning. For example it is used for socket busy poll and epoll busy
poll. Calling it "busy spin" would be confusing I think. I will add a
note in documentation, as suggested, to explain that it will spin a
core and depending on requirements one might want to share the core by
using affinity and priority configurations.
>
> Note that on some cpu all the 'cores' run at the same speed.
> So that putting one into a 'spin' will cause the frequency of all of
> them to increase - thus speeding up a benchmark.
>
> Rather the opposite of tests where a cpu busy thread (doing work)
> gets bounced around physical cpu - so keeps being run on ones
> running a low clock speed.
>
>         David

