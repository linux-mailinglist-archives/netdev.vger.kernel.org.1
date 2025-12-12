Return-Path: <netdev+bounces-244508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E78D0CB9327
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 16:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 799D43029BB3
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 15:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B17323416;
	Fri, 12 Dec 2025 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POZ68xxT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11513233FA
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765554230; cv=none; b=Atb35r2IWAEAbACbMBk8Jn8/5v9WQPklCa6MMdZtli/Z5b9xFPKTfHAP2AdDfVyI4YnJxCv8F+NxStFw+VZZeqHC6AobJhxcdkV27e23SiY+We3dNHZ3am6E6EnsyvD+iwqqNuiESWK02SCKMTc2VxWNv7rN1ucu2n/nQ7HpmMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765554230; c=relaxed/simple;
	bh=57/2QXmprtiDegZn0F8NQg3Qzp5N6UM87nK+a1oFiiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHW7glKAm/yCi7UoQamH/qPZWPl/ERuexr/lp7tZzKCyEOhPZVcgPt4BruaJhGaU4VY3W32RZlTbD3gQg4dlWeH3wM8xIoh6zjgydMYyWYsxRjgnnOKY5paTem2th0ZX7fugsRon3o/lcK5ZoVtKaaGuCjgqMBINrg9Vj6HozTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POZ68xxT; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-bc4b952cc9dso1126274a12.3
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 07:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765554228; x=1766159028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86AGtXOmh8bPVSUWpWu8yE4ZL4nYZrP63L43343qKlk=;
        b=POZ68xxTCYL0HmvzDbScfCBj7wg69C4ipVI71WLU4OI0iXVwsBW6MSo8LhBP09i5/p
         i5dOiZOmshJFCWzeBpvGjFhmiWreYdVN3sQF7TtLW1qyeLZYREqyU2oL/DlQlpUOoLDc
         rUPqpku6CR8ardpr3yxSQ8Tl3CVpsGR0cSXk1DiTMplakKAjvw7Vmtr1Wc2tFIIQbbu4
         KOHkO+5DZFs2lSPQr4BxMegXmDggiJQWRu8lrBsiaiYL4DLc98K13cZ+rrTaKn8wFtNu
         BDQgWxu3icXPjEiYjN3ASi4gs/eoSbSYKfbc8xez+sDDeVhVeGkEfIX6gaJWhm5U6nGX
         1g0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765554228; x=1766159028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=86AGtXOmh8bPVSUWpWu8yE4ZL4nYZrP63L43343qKlk=;
        b=BLfZWFrrBgbcytbX4WdXgPpoGaNBvo58Z/GUymkq0NoZRUqM26ykpHmV2aMCPyozvv
         46oLRqUpTj78Iy1wbgOEgiINXeKnxRLvrCTgzI2QFOsnNyXgRHkEK8+VfI7WXlUJBng9
         naaDy+Ap0qqdp3R3a0xDfwknOoWQDysPPCGZR9Yq8HhVbk6ta43W9eqMEZr10nkoAkGW
         35DT7jayT3I4PL369XSJQ+LSHySxaU3TgTjW2TBNqGsfECOszl2okiFHYTG342i1lw4b
         lOQ3gCrzU6BOnpqtmkMGv0/2Uc/F4Z/kUigAVJVxxtdc7knCAzwDgVf11MDBG1/dBEHQ
         6Tsg==
X-Forwarded-Encrypted: i=1; AJvYcCWN17A8+AOHpfBSeAMSgh89LmNkPVqVMZCyb8Tf+tvzL1GWZ2KTszgs+SbDkefKbh0Mqi3XdJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbL6NyLGD23fVFJG96/n1USIsvgAFuk1Z8VOTVOnHRg+2fP0cT
	2Jjs6qcRyX7qplxqGHDyax5ubge+ScSBwrOFbCQ/G0Oy67NMyFcTrt48PexFUvGai70To7cKQDK
	70uRQ/eAL5SwefNXM4psgmU+AIan12dc=
X-Gm-Gg: AY/fxX7OKeaQDTyW892/n6NO4VzdsYCFpUNibHJktessuGhjKWTa01w2U67AzzYpt8u
	uvw1ah6fd50dMX1BQD5aHbP0hd4qtfR/VtgvsPFfJji1Chh2YbZY2kb84KBioXznFp/70v3LD4p
	W2CxDt2HMxGh4niPLsg1zO0RKpIitcP91rPh4KSFKwJoVFGKtLxCZ6GwM1FF87cCMs+KTiG32Qa
	DUiY3tR/MqDqF370bqZYAKgF4vAXi3iTmQu0BxyPyxcIdOl2/plQhBe1dSM7z7C8sQ40co=
X-Google-Smtp-Source: AGHT+IGgsCkKd879py4tIU07CCUR7G051VQXSmmR5Yos1fJaCBJe3Uk3GzwbucF2eLremyYxLXQ1blGnpC2rIig6eOo=
X-Received: by 2002:a05:7301:7387:b0:2a7:2db:954 with SMTP id
 5a478bee46e88-2ac2f8a9b81mr1511398eec.15.1765554227968; Fri, 12 Dec 2025
 07:43:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADm8Tem-jtBmmOO9S6jW-jzffCqe7X_DpJcy25KRkyY9Tn+TZA@mail.gmail.com>
 <166381e1-5287-414c-baa4-be371fe46e3f@lunn.ch>
In-Reply-To: <166381e1-5287-414c-baa4-be371fe46e3f@lunn.ch>
From: Tuo Li <islituo@gmail.com>
Date: Fri, 12 Dec 2025 23:43:37 +0800
X-Gm-Features: AQt7F2pD0p5U6w663alqqGE6zOUi9j60C0Jr2UXuG_7q-t9Ni9nyQ6tuRQFNMNE
Message-ID: <CADm8Temw5Eq__N7RGuCfAiRE6qH7rUWObWiciFgf9FwOL6nziQ@mail.gmail.com>
Subject: Re: [BUG] net: 3com: 3c59x: Possible null-pointer dereferences caused
 by Compaq PCI BIOS32 problem
To: Andrew Lunn <andrew@lunn.ch>
Cc: klassert@kernel.org, andrew+netdev@lunn.ch, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, mingo@kernel.org, 
	tglx@linutronix.de, netdev@vger.kernel.org, 
	Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Dec 12, 2025 at 10:02=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Fri, Dec 12, 2025 at 03:52:01PM +0800, Tuo Li wrote:
> > Hi,
> >
> > I found a few potential null-pointer dereferences in vortex_probe1() in
> > Linux 6.18.
>
> You might want to look at the history of this driver. The last time
> anybody seemed to really care about this driver was:
>
> commit a6522c08987daa6f9ac25a9c08870041a43db6b0
> Author: Neil Horman <nhorman@tuxdriver.com>
> Date:   Thu Feb 25 13:02:50 2016 -0500
>
>     3c59x: mask LAST_FRAG bit from length field in ring
>
>     Recently, I fixed a bug in 3c59x:
>
>     commit 6e144419e4da11a9a4977c8d899d7247d94ca338
>     Author: Neil Horman <nhorman@tuxdriver.com>
>     Date:   Wed Jan 13 12:43:54 2016 -0500
>
>         3c59x: fix another page map/single unmap imbalance
>
>     Which correctly rebalanced dma mapping and unmapping types.  Unfortun=
ately it
>     introduced a new bug which causes oopses on older systems.
>
> Everything since then has been tree wide changes.
>
> > It looks like these issues stem from the call at line 987 used as a
> > workaround for the Compaq PCI BIOS32 problem:
>
> Also, maybe do some research into "Compaq PCI BIOS32". I _think_ that
> was from the time of the 80386? Maybe 80486? Support for those
> processors has been dropped, so i don't think it is even possible to
> boot such a machine to invoke this possible NULL pointer dereference.
>
> Please do some sanity checking before reporting potential issues. I
> _think_ you are wasting your own time, and valuable Maintainer time.
>
>         Andrew

Thanks for the explanation and for pointing me to the history of this
driver.

I apologize for the insufficient consideration. I'll be more careful about
checking the historical background and the practical reachability of code
paths before sending reports.

Thanks again for taking the time to clarify this.

Sincerely,
Tuo Li

