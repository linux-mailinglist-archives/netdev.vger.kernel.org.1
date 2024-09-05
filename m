Return-Path: <netdev+bounces-125426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C9196D134
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 10:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA863B21407
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 08:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3387D193091;
	Thu,  5 Sep 2024 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0vuRPbqp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7AF19340B
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523469; cv=none; b=ia7DvFHrOAjX88wYKTmoZTGz+Mrg73svHVBpYjj5UAjA+4KVKDgPozYWQ3XomstWiqV5G26D0QfcaL6JP4ZCIEU8NQgPSu0xMojJT4hgKDfTppi4uwxaHmG2KZpMswTFByPgBitAYonHCDp59IicVOHV1+tk7Y1x9DirQblyEM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523469; c=relaxed/simple;
	bh=nhjzPhbZdOIwhS4V+wg8CJkF4W2mZ8bF0vqcfEg02aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOsRfx5/WIS9uMS5LMYPv+Fg2RiXvuhvJLOkmWSGCqN7y+kN92hhq/UreHeZd8J7QXqGz7V3rTK5++wexoUoKoJ+UzatpZk8Ny6VaZ8b2fTO6aDtacVPllJ5/kHVWMII6c11hp15D4ORxJXj8lCDp4B7lX8rIHuxcO4d/CkYfI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0vuRPbqp; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53653682246so381552e87.1
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 01:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725523466; x=1726128266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azQkhYEOWQVBIINHFNC61+ioeVjCS9tbpuO3iLtCThM=;
        b=0vuRPbqpbhkswQRteJAQaG8BjgvALoFw4TV9SgNBFF6MB8HdKTno6oOH2tGv0vHGRQ
         Ddptj2w2PO2foezkY0hjwMZVXLM+JqI96bMVSwRqYg4s1xXz5RyhXLW/uJgxYQH+aMyV
         x4fKcPE3EfcTc/45YEPAO0fwuI67R7mA5dppDTqkjKKHKiCMBBwEXxPEU6XGOfF+20aP
         LyEmLKPP3PCquyOhmdWENvRsYX6kksNMstotKXAyt69u5V20O8siE8EwO4KP4f4VMOdY
         WTnPU/y9onp5ONDlfGnN6qnckqYwC+2MHhNGHCweMDBNruubC7H/03Je8uunuqO02ATv
         mcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725523466; x=1726128266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azQkhYEOWQVBIINHFNC61+ioeVjCS9tbpuO3iLtCThM=;
        b=tSEbOACAojOBdWcnQfv+86BlaYA4LYEuY05kIlH7Z8Hqew8B0qeq52JKmEEMpkzkh+
         dGvUghsZOrb2qlLZR3Xpj2a9ngjHDX948CU62MqVeaPvU/mnYWXpAUoGAR+pdbNwAxAF
         edwnv0mW5/hTHsor0s628rtFjk2X+8MdVRPtyJ/yQa6RMgsTAoh+cMYyazYuUABzK9ui
         kp5EZvKO+O7G6JVUxBj3uvV9LhY2S/BcBszZyU/qgg7v2SVbmnuw3ogu5A9QGALFsCDA
         6ulsO0zYDE71sPZnlUn1E1kp9FBrF41jIJ/IbFOo5wP/K6lcpiNB/a6SCqJCsoVMPGXU
         ApnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXPC1/akVaRCynpouWLHTRKdAnhDAnDzXhJHLnB0Q7veGCfRDRSgpgB5CG2yorz03aJDldB0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXN+mmKBesC7y7M797BfqBCiC4RHZfhqcrkJrCVqeFyuXkXF/+
	yVyriGGaJ3G627G7Igk5cGTArOE+vw3Hf8H80kK5Ig8RjBb5W7G2otlIhk2Bz7VzcADtBfHvsSp
	Q4w7HSxw+FxwCUsk6E5Xrwkx31pgXwEuur6an
X-Google-Smtp-Source: AGHT+IHR8HiUyJmdstJJcxGU2MOFKXxOOMDEFMh2vAfGxn+gzsWBtmLSd6+8Sol6Rv06L+OF6VRRSxcZX4WXteQVlew=
X-Received: by 2002:a05:6512:3b2b:b0:533:71f:3a53 with SMTP id
 2adb3069b0e04-53546b053admr17779245e87.19.1725523464706; Thu, 05 Sep 2024
 01:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000083b05a06214c9ddc@google.com> <CANn89iKt9Z7rOecB_6SgcqHOMOqhAen6_+eE0=Sc9873rrqXzg@mail.gmail.com>
 <f6443f4c-c3ab-478e-ba1d-aedecdcb353f@oracle.com> <13a58eb5-d756-46a3-81f0-aba96184b266@oracle.com>
In-Reply-To: <13a58eb5-d756-46a3-81f0-aba96184b266@oracle.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 5 Sep 2024 10:04:10 +0200
Message-ID: <CANn89iLfdNpdibU=kWZKgHPAeMSpekePovmBNbaox4d=Zyr+OA@mail.gmail.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
To: Shoaib Rao <rao.shoaib@oracle.com>
Cc: syzbot <syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>, 
	davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 9:35=E2=80=AFAM Shoaib Rao <rao.shoaib@oracle.com> w=
rote:
>

> >
> Hi All,
>
> I am not able to reproduce the issue. I have run the C program at least
> 100 times in a loop. In the I do get an EFAULT, not sure if that is
> intentional or not but no panic. Should I be doing something
> differently? The kernel version I am using is
> v6.11-rc6-70-gc763c4339688. Later I can try with the exact version.


Have you selected ASAN in your kernel build ?

CONFIG_KASAN=3Dy
CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=3Dy
CONFIG_KASAN_GENERIC=3Dy
CONFIG_KASAN_INLINE=3Dy
CONFIG_KASAN_STACK=3Dy
CONFIG_KASAN_VMALLOC=3Dy

>
> [rshoaib@turbo-2 debug_pnic]$ gcc cause_panic.c -o panic_sys
> [rshoaib@turbo-2 debug_pnic]$ strace -f ./panic_sys
> execve("./panic_sys", ["./panic_sys"], 0x7ffe7d271d38 /* 63 vars */) =3D =
0
> brk(NULL)                               =3D 0x18104000

