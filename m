Return-Path: <netdev+bounces-200635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294F6AE65D6
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 15:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3405716F796
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 13:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0516D2BE7BE;
	Tue, 24 Jun 2025 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPSWI2/a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3D513B5A9;
	Tue, 24 Jun 2025 13:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750770078; cv=none; b=P0PK4OvD0A0+vJRuugEIg2qNH0vPgzP32X4ZZU66CKLRJvBcEls7X7wW8JAtUmoP9jZiWhwTPjGvHT5VUeSg1BCfDkPMQduSW1HZPjb4mmEoBidluWt17Tkwn/aQrckZew34t2gGIIwg7ZrZV9uIT+abU2s9VcpnSrvfleU5M2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750770078; c=relaxed/simple;
	bh=otJz9LVuwF6pCnaDfgOrLQmmU3gXHoyW0WnWufGWW7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nwb0kTa7VKSQ1xMvgMobSTTNecAsIvsyYhxPD1BUZDYSuQiKoxWSyW90UhhmbuNBkGw+PT9MIXNIIgy+rzJx+7kplSRCEyTnMnVZdtfDnycJZPPNJ08g9fUd7z63Hq8EYTuTZnG/F1vpOjxRo4wzFESDwQ4J7O63EBlFHgJ9Ff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPSWI2/a; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32b855b468bso4411101fa.3;
        Tue, 24 Jun 2025 06:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750770075; x=1751374875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjQI5EbjeAe5NKcQmnn+wqp/o47u/8kr76QnSUrx4GI=;
        b=BPSWI2/aPvEXDkwXutqMx8k0nyM31h07IOgCqzq5LgB649LqPeg6dknIoiSiz76XkM
         J5sMO2JBYAQEpkOa0+EBYhW6zZ2UH5tdLYtBbEsQUB7jn/piOF66ogZLASlkAt4RD0KO
         gLvb3FguZY6Ml1Z6iGFEBHA4W1LB/Cj4WbvmMLkR4e9jbois1KEb2/GzoqhhouKXAhH3
         nww7v2lbtSY1UX9fCYcUm6ZE3wZffZjYBFwwHzh7jCJYM+b1vYO1QjZyBoTcVa19Zdyl
         IXGQbA2zSMtfMsrVjpW4hZHhM2l/475NMr8uLo/HQ49o352wFSPcMewndHSuEgP2KF5z
         U8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750770075; x=1751374875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjQI5EbjeAe5NKcQmnn+wqp/o47u/8kr76QnSUrx4GI=;
        b=Jch153F5vJ5B+ACr0t25iFf93nTRG8ftecAKZLcXSDT81KVpzXipCAg3hiubKieg4h
         gSUgpIa4kDndw2PChaNOHjtVFLhlRAK0WikbeQijwKizbMBjiyD5d4zByZeQqyg37FvK
         olI8J9cxk+JvG0mQp1fopcwBuyKV3Q27utu7UrFDSAOrnvHYoHT21N+8YOSlbWa+Wqsc
         S0XTuq/kD6ZRIOeymZH1Ua8XtiJQTl7wbdw8ffhSFp0deYlctwZkXRrfhMj1ndnaABVb
         8lkfwoZoKIZD2i+NFMxiPfsy8dzpvFjqBbgu+ZW5LoQ1VjzoQybrF5EJTz3tQOaqSOWe
         nkrg==
X-Forwarded-Encrypted: i=1; AJvYcCUnHO7aRtqa8I4czMRVJRnfK2jqc1zeEPgrFr9zYFmSM99jZS7FGXntcx6eYqqcUh/i13J/bAoMpLODS1NsdRo=@vger.kernel.org, AJvYcCUzrKaNMAs/hC5l5012QfUyQUeSGIpnssMWnh/kJ8iILp7SR/Fn+v9jk+bTiPYgDTV8WncRhzkR@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv+6JE35LxkRsuNfkX0jNsmgs/Q9OI6rmUxU7EW/5OJqfpJo6T
	gV99swAqbG0TwlWVk+d6IcWRmdKWqL2KCfZgMxXIOsLYtXVi94ywuJno9zFDjtViG249CnkL+ZT
	VR3EbcqOvNS4cvEvNJZGxrZcyuWsfRlMOcGY2aVI=
X-Gm-Gg: ASbGncsD1TwPryPN3EjoZvHlOeSa1K8Cn4ZsJYNVivzi1hHGSKcG7LHEZy9Ja61Qkj3
	4x1l5A9PXJtbR0ctHC1RtE8yzxY5FJdPXMTU2ldKzhVC8N+81pwvLA9oyaEva76h0D3VX3FdKqP
	SMM4VBXLCjfk6LHvt6An1ifoJiFXo2klVmDF4MlOCocA==
X-Google-Smtp-Source: AGHT+IEFkVWjvraGv2wE34pvJYK8o1Mw0X2tda2wFyYv+XBeu35t47Ovr3b0aasCPJZzUnPcm8WAyNGGCfQrb3f6VAI=
X-Received: by 2002:a2e:8a8a:0:b0:32a:8591:66a0 with SMTP id
 38308e7fff4ca-32b98eb142dmr34863751fa.1.1750770074460; Tue, 24 Jun 2025
 06:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623165405.227619-1-luiz.dentz@gmail.com> <99bea528-ca04-4f90-a05c-16bb06a4f431@redhat.com>
In-Reply-To: <99bea528-ca04-4f90-a05c-16bb06a4f431@redhat.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Jun 2025 09:01:01 -0400
X-Gm-Features: AX0GCFvEGGhumnJvujwmlkMufQYOPO07LkwtppIrDIGyoG5NDUVZ67Cdlzf1hB8
Message-ID: <CABBYNZ+C+HGgxaMg6L+rA4z1dsoSkPG8gSJLt3jvS63_egmSxw@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2025-06-23
To: Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kuniyuki,

On Tue, Jun 24, 2025 at 6:50=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
>
>
> On 6/23/25 6:54 PM, Luiz Augusto von Dentz wrote:
> > The following changes since commit e0fca6f2cebff539e9317a15a37dcf432e3b=
851a:
> >
> >   net: mana: Record doorbell physical address in PF mode (2025-06-19 15=
:55:22 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git=
 tags/for-net-2025-06-23
> >
> > for you to fetch changes up to 1d6123102e9fbedc8d25bf4731da6d513173e49e=
:
> >
> >   Bluetooth: hci_core: Fix use-after-free in vhci_flush() (2025-06-23 1=
0:59:29 -0400)
> >
> > ----------------------------------------------------------------
> > bluetooth pull request for net:
> >
> >  - L2CAP: Fix L2CAP MTU negotiation
> >  - hci_core: Fix use-after-free in vhci_flush()
>
> I think this could use a net-next follow-up adding sparse annotation for
> the newly introduced helpers:
>
> ./net/bluetooth/hci_core.c:85:9: warning: context imbalance in
> '__hci_dev_get' - different lock contexts for basic block
> ../net/bluetooth/hci_core.c: note: in included file (through
> ../include/linux/notifier.h, ../arch/x86/include/asm/uprobes.h,
> ../include/linux/uprobes.h, ../include/linux/mm_types.h,
> ../include/linux/mmzone.h, ../include/linux/gfp.h, ...):
> ../include/linux/srcu.h:400:9: warning: context imbalance in
> 'hci_dev_put_srcu' - unexpected unlock
>
> (not intended to block this PR!)

Can you address the above comments?

>
> Thanks,
>
> Paolo
>


--=20
Luiz Augusto von Dentz

