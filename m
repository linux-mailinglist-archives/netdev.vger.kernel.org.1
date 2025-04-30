Return-Path: <netdev+bounces-186921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DF0AA404C
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 03:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 878B57AD1EC
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 01:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB07C10A1E;
	Wed, 30 Apr 2025 01:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Km++KIGJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73991BA53
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 01:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745975803; cv=none; b=FfxGpEaLzG1uV4k0xuJHJ/k3ER9+KOZYXnafFD7zooKcRkDT9pSYNTSvSaLNO89wMP+uA2lejr/Y0MxD3NtmX+i+JelLXm8P9gAo471/vJfMUSlIb7vhWUlVr5Yr/9p/vGr9kU0w6d1zIxSbE41lbvzUY8C19ufq55h6OIVGo60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745975803; c=relaxed/simple;
	bh=Gf6otcVsWG3Kq8pnqXz0E7aBQIZKTm0JDLM1JySTfmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=TytsWfAug/OeRaptMwmIDNyLtBfSNMsfNb/JeaxKev6niMp5AW//+WUx3S/yboeSsGEuQXspKx+a/qR7HJCN8BuzqpxJQ19Aw1M9uYMiN7t0H3tL9oQAMYAWSZy7wu1nPEgcJ0RIgVGdPYL6ZSVsDe/ST6qu+7JkDqfZPKi/5MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Km++KIGJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2263428c8baso104985ad.1
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 18:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745975802; x=1746580602; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZjUh49bUq+J6LZ1vnaSFx1/yTlvox3PDzG8hOLTego=;
        b=Km++KIGJhweGmFU5rzOMW0Sa3dQ0OGlZPAk3SDSwwYRW1usr/tJHK3YQrQhO7JvaIr
         2PusvhB9gyHceEFNffn1dYNvjtTQAPQDu9kBV3QjBr7L0nvucF/CdCoUD7vvSCjdU6tx
         djHbN/zR1B97v656gyDCEGYVX7ZFkVZP3MlVMil5ch9n68GeIUOPv3o/n3kY4+yzqbMg
         a92+5OJbAVjufL65OPRNGfEfShCw7j/pnVfvkFbOhT3hPhzWNPYnjzm/71lVwKxfphR+
         vdmqKawrqbcj8MLa0FyS8dMOkZ868CbPxtzGt9zJfL1UoZhWAKaVhiYaFr2v2Eiaibiw
         QTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745975802; x=1746580602;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZjUh49bUq+J6LZ1vnaSFx1/yTlvox3PDzG8hOLTego=;
        b=NW9MEpmVu5sTluQQ/178ByoNm2QJ2pnHog/aYzGiy/O9rPAUcQYZgjgYMvJK3cbwdP
         OH3+EHN/f+UafBV/CQ7vodcV/Rtm8jWspndvB7vhKTXzDGxDRL5rUwMVYSairp52eUtJ
         n7Te3T+9XXqtLuLIDXJQupOjG+VQ0xIvu1f8y50OWdSAmEPM8xHI613pLlVhM+Gru0GV
         V6Iu6U9Tp12Exuy9jtZj3EuILuiqt7Y5GowzQdPMWNUx6g+o4ond3SnXdW06Ohjmlg6Z
         AO48tt8l1yy+vHCYpLG/UeCnaYdazpwtT2ZmI/LhBaZTHfgEnd5kifsrOysg0e/5dyLN
         bnrw==
X-Forwarded-Encrypted: i=1; AJvYcCX01CNHtmDgUric3qmNb9xJ8S67D2gSzH4YoX2kCnHjqEK31Taijtbw1nzpLq6d9f3W25P4bzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4XDvBsryM75Dd3rrqr4cYl9XUuRTyiJZJIdyqNl6mLzTryJrp
	upIvwr/ZsVEaY20NbDmUGruviN5MsPMvguFvTwVe9jLlO+siAc+WQwPPc1k0ahnfgo0tmAhWuso
	YKgFNxJBGqBaeAARkE3C486wOsHUPZ4p7nCvY
X-Gm-Gg: ASbGncvdF9iZOAQ4xlOWltvpJbvdHaa1kELSvlLWiVEgEMM2NXT3ri9By8gX1aufP0W
	YGDHLCtAaBsB8lLc1d/zGN2kckbu/JH1sNA7ljgfZXCYiv1F+Ni1KgnmHc1ryPJ5bSviZqxuonP
	VPmuVa5O96TsMCz3TYhWMNCJ4CvFJ+VXwTptnFZyKumWQxeAJFi19N
X-Google-Smtp-Source: AGHT+IFnNoPdcTGhVwxx9EKERnGpna60pEwys6AJHvvBI5YbIox/5xZ7M0AHzJeZJToPVXwlfu1l0wkuMB1Qi2NqCJo=
X-Received: by 2002:a17:903:32c8:b0:21f:56e5:daee with SMTP id
 d9443c01a7336-22df3faf5b3mr1436345ad.6.1745975801406; Tue, 29 Apr 2025
 18:16:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429222656.936279-1-skhawaja@google.com> <aBFnU2Gs0nRZbaKw@LQ3V64L9R2>
In-Reply-To: <aBFnU2Gs0nRZbaKw@LQ3V64L9R2>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 29 Apr 2025 18:16:29 -0700
X-Gm-Features: ATxdqUFu8HG6XblmMQP6M1tauuncDSgqdq0420CRVFVQ4AYlhHH_VRboqBcKfxs
Message-ID: <CAAywjhQZDd2rJiF35iyYqMd86zzgDbLVinfEcva0b1=6tne3Pg@mail.gmail.com>
Subject: Re: [PATCH net-next v6] Add support to set napi threaded for
 individual napi
To: Joe Damato <jdamato@fastly.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 4:57=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Tue, Apr 29, 2025 at 10:26:56PM +0000, Samiullah Khawaja wrote:
>
> > v6:
> >  - Set the threaded property at device level even if the currently set
> >    value is same. This is to override any per napi settings. Update
> >    selftest to verify this scenario.
> >  - Use u8 instead of uint in netdev_nl_napi_set_config implementation.
> >  - Extend the selftest to verify the existing behaviour that the PID
> >    stays valid once threaded napi is enabled. It stays valid even after
> >    disabling the threaded napi. Also verify that the same kthread(PID)
> >    is reused when threaded napi is enabled again. Will keep this
> >    behaviour as based on the discussion on v5.
>
> This doesn't address the feedback from Jakub in the v5 [1] [2]:
>
>  - Jakub said the netlink attributes need to make sense from day 1.
>    Threaded =3D 0 and pid =3D 1234 does not make sense, and
Jakub mentioned following in v5 and that is the existing behaviour:
```
That part I think needs to stay as is, the thread can be started and
stopped on napi_add / del, IMO.
```
Please see my reply to him in v5 also to confirm this. I also quoted
the original reason, when this was added, behind not doing
kthread_stop when unsetting napi threaded.
>
>  - The thread should be started and stopped.
>
> [1]: https://lore.kernel.org/netdev/20250425201220.58bf25d7@kernel.org/
> [2]: https://lore.kernel.org/netdev/20250428112306.62ff198b@kernel.org/

