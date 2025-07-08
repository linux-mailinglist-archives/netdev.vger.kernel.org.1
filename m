Return-Path: <netdev+bounces-204834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6F0AFC385
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5AD21898BE0
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 07:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ECB1E25F8;
	Tue,  8 Jul 2025 07:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQCr5zfx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD31F21578F
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 07:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751958096; cv=none; b=tAiD7LEry1G3IKW0f6JwAxL8ytDHVAQfMLL4i8+gReiu8DHu5WtDnX+u17PWbyxLOAD2G3PbfO5/DV3EHJs2qLj5uhVh9pbrniyPuyf8T98KaGdQjn099fSqSZ3dkD4BtoOrH1iuPi5w5kQTSD50ZKsb4XmPZTGycoxtzpd/Ekk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751958096; c=relaxed/simple;
	bh=GVI35VAUAT2OMmnoqbZKkT6T+kvJP7awaxKgP9GoC/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhBuvJxt7+/tnHLF7JW3qKjQxrR+a4l+WtEV7fPefWCWap3Y8hkUtJdP+TOpW0n6JxdMaYE8J3e01Xbpjg+DSNaLl17aDbbFD+OsXZpnW9Y9xUG/8S4bBIhcokbR36u2ypSRW7dY1DpfmEJn2k0rreWczsbuqMn2MxI/176eOy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pQCr5zfx; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-87ec4ec218fso979872241.3
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 00:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751958093; x=1752562893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVI35VAUAT2OMmnoqbZKkT6T+kvJP7awaxKgP9GoC/g=;
        b=pQCr5zfxLUBk3cePF5zhqVC1h4DRrhEkEgYNP7h9lEJ3t/gChCO0E8O4bf8Gi96Ou4
         Bty9k4MjKuub72j2/JwrHVXs9rrN0ivE07r3xkLc1cHCRMpx82T79coSb998D722HT6e
         46UlbaKebC6BRiOmE4fwqeD5Jxc0EZBKBP8g04kXt1lpoAV005InLwKu/AV3AMkVWiMN
         gwjFcBNEnsurn8FOtopmENHXPMQElrEH7NuH/S+1idHXXaPbRRgCX1MXCS69JUF9VnHC
         tDMOM+HrWNCLTJFrwwYALcMPiHUaXOdT3zxehgGKFoynhF3xzClTaM7zLvuLw+/uHMbC
         SFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751958093; x=1752562893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVI35VAUAT2OMmnoqbZKkT6T+kvJP7awaxKgP9GoC/g=;
        b=mW62dNznuzWLr6aFyjq5mg+bvCrM2ZCiALe0hvOOa4sIjtcLNeilNXMvopeYTgBGdj
         IquXvzMMgBWIircnwO+qYlMnB8HCTN0JKFbDkn7vxLCt30TDyDvNpDR1J9SyGy2LHitY
         vC+diBaCDsTn9Jwnnu5GYHtk68kSeI4/x4WmXpJjWYiE9MSXpkFwYatGwFVW5nkL9fan
         cXE/urn1foPdgYbm/MXusz1FBbbyiLIPGdvBLwxovE23b/D8exAPtpC4jsFarGbaA9o+
         OYV21GwrHnlPZYyKfeh+cR5uz8mGhDM9UBH12UMyYvkViV6XVnattL8akehakL50qEUo
         eT1w==
X-Forwarded-Encrypted: i=1; AJvYcCXlEgrhC/5fz/9l1g5bSjg3pSxZqDK3+lVwt86BMcwxKi2C6Q2xEPctwHFv8nfBC5iG3+pB9JE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv79TF+ydJJbOSny6ZLmL6zAFnCzE7somy0ELGLl0RoXns1hYZ
	I0gQZpHcx2ATZ/hjjDO+A76GgYLQiNdavJfwW+T0XM1Qd8MYVI6vGd36gvmNipFWa3tFhr/797Y
	6u7Cq2dyrU4GgeyIR4WvihRx/YNvGLcfx1Jzkf9d9
X-Gm-Gg: ASbGncuCQqnWfBuyRkkKJ3ETf7Xp59cSU6shulPdyEW2KUVaJsX89Ezrfgd0/Cq1xCI
	kE164KVzQzrVj5pZhY08yXb6RfNQF/NwPT2OuaORqjsKbVQR6q5TsczOJJGaKGKMy7lPd6n2TBv
	diSCvW3b225Xeg5w9uCJe4t2TsLRiIfcxzz7lAroN3T5M=
X-Google-Smtp-Source: AGHT+IERc0LWrrJqbY+cXwFfEV1cbyKesjk8HzVKFdW+ImlmD5ADGt4VqW++1iX27GDXD4M44DAWL7sS4hlCdVzDmKA=
X-Received: by 2002:a05:6102:4b04:b0:4e9:bae0:7f9a with SMTP id
 ada2fe7eead31-4f2ee1ab639mr11116754137.12.1751958093290; Tue, 08 Jul 2025
 00:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707105205.222558-1-daniel.sedlak@cdn77.com>
 <CANn89i+=haaDGHcG=5etnNcftKM4+YKwdiP6aJfMqrWpDgyhvg@mail.gmail.com> <825c60bd-33cf-443f-a737-daa2b34e6bea@cdn77.com>
In-Reply-To: <825c60bd-33cf-443f-a737-daa2b34e6bea@cdn77.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Jul 2025 00:01:21 -0700
X-Gm-Features: Ac12FXxC4-Jc2OAV5RNVFrqcHyVllz1xzGsaQWzti7pEOlInSotqzWFdDeN3SBg
Message-ID: <CANn89iKQQ4TFx9Ch9pyDJro=tchVtySQfJTygCxjRP+zPkZfgg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: account for memory pressure signaled by cgroup
To: Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Christian Hopps <chopps@labn.net>, Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, Matyas Hurtik <matyas.hurtik@cdn77.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 11:45=E2=80=AFPM Daniel Sedlak <daniel.sedlak@cdn77.=
com> wrote:
>
> Hi Eric,
> Thank you for your feedback.
>
> On 7/7/25 2:48 PM, Eric Dumazet wrote:
> > On Mon, Jul 7, 2025 at 3:55=E2=80=AFAM Daniel Sedlak <daniel.sedlak@cdn=
77.com> wrote:
> >>
> >> Currently, we have two memory pressure counters for TCP sockets [1],
> >> which we manipulate only when the memory pressure is signalled through
> >> the proto struct [2].
> >>
> >> However, the memory pressure can also be signaled through the cgroup
> >> memory subsystem, which we do not reflect in the netstat counters.
> >>
> >> This patch adds a new counter to account for memory pressure signaled =
by
> >> the memory cgroup.
> >
> > OK, but please amend the changelog to describe how to look at the
> > per-cgroup information.
>
> Sure, I will explain it more in v2. I was not sure how much of a
> "storytelling" is appropriate in the commit message.
>
>
> > I am sure that having some details on how to find the faulty cgroup
> > would also help.
>
> Right now, we have a rather fragile bpftrace script for that, but we
> have a WIP patch for memory management, which will expose which cgroup
> is having "difficulties", but that is still ongoing work.
>
> Or do you have any suggestions on how we can incorporate this
> information about "this particular cgroup is under pressure" into the
> net subsystem? Maybe a log line?

Perhaps an additional trace point ?

bpftrace would require to ship a separate program...

Ideally we could trace the cgroup path, or at least the pid.

