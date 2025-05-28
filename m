Return-Path: <netdev+bounces-194048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5806AAC71B3
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 21:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A664D9E6003
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 19:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2971B2206B7;
	Wed, 28 May 2025 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICu4e34o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8147121FF44;
	Wed, 28 May 2025 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748461555; cv=none; b=Qg96V1v+bbinZ44CJrWWbCKXkrQRIuDQVc+fA9q+uuwKQvnDL+GLlUUPUVLJPoG9O26zpY2E6JEi9bf59c9HO4hY6F6l2itgao3ExyH5rsBum6pMd2U3mgtQbxLcr8wfGIUy6VV1XozJs4ulYoRjC9D3GdO5QarjZqg9Oo2rxhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748461555; c=relaxed/simple;
	bh=2WYsfpi4i8f0LBMEO0DT617i14NhS7BPxw7WwiazOec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HbF4PJslkUX4JwXsztHeOdayCBPsY79dKP0CeBI6y95YFY9X1pi6QZ7HcaVqs3aUdn2mIHpuL+wwwtMXF6IyDG+A/OnbyD7DF7ChiPjPuSlgpe8vBdDofVyrmqOSNFEBpZhLO/8yV0ntE2zHkEpaE+9bXAhWNNr/cldlDxygWvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICu4e34o; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4e45ebe7ac1so40038137.2;
        Wed, 28 May 2025 12:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748461552; x=1749066352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WYsfpi4i8f0LBMEO0DT617i14NhS7BPxw7WwiazOec=;
        b=ICu4e34o7vmIbai/UECVjcuFiwbevmlByzWmW6IuR+1e3YrIr7JjOujKeSxnNXkrb4
         nz9SULV+BZ6trGKfl+DiLQ2/DrcpPGinyXPdT3Qkl4/9M9smC4lCr4J/xkSsQeVEZW8a
         sXQQRI7HhdO4V1hQTrTH2c9FjQrbtqNdRWbSyA/tqAa3i5TZHUwrz8qHmpvboqycAuDU
         47XHtdvWNLfAL8cJ0LD/OfvgHWKIPYYxJ06y8CF8hXjrETa//R/IpC28Y81bcOAwDLIj
         GXhmdbKOjjCjtooOw/aKBL+6pZ98IjKwYGBqkGbRZ8KP0zkQuOk5/tbEWRNCS48RkreO
         PbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748461552; x=1749066352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WYsfpi4i8f0LBMEO0DT617i14NhS7BPxw7WwiazOec=;
        b=qP+jUJfxsLwW3HUukQnEVY6Spg8yakmxqgGbouqu8qLxHU+HxyR+itOQ4oo+jVM+LT
         uULrsRHNZGjJ+Bz1isnMoFHYI+9s9daUCQZJ9kAMcbzWjbGuDPN3PP4w41Yin4wi9YHM
         d161ZKH528tfvjzBJBbwdMXgy7XkwjMDEClHVnEqp6bnzy8jhtNY0n4tj1DlldlNfHhs
         n1OJaH8JRInHQ3q7jWo2q/ybY8CX3sMk5kpzWwoK8ZXTP6XMfL38rxClwEy7PQUnkFsp
         ZGn4j8qiIQ5Sln+6InX/tyK2wiRf5zdkYsPnfkZWrjRashIqoy5FYdSPvRyk+BxA1q7I
         TUMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYclBOgRnAXiHA3hhG1WYHbUmvdG4zszScoKzIicujgO8rDkWIjVzx3o15vtHBz+OQiAQR52+F@vger.kernel.org, AJvYcCW6MisNUDSO7NEIkgMEzSXxaaiMWXvULF9wKeKtuNwAHjKTN07wiNK9fcRZLfzr1JBjwyfKCgRK38BMXcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Nh2ZXQm9bj+rkCVBbUjPF2QZCnlAQf9Sx8EyOAZbScKhNj96
	h+X7rfKVEmZKetqegB9DIaqt6bniVpzzDEUYjITGHRg8E5l92eQszKxPaj0ENoCYV07IQBYO6ir
	UaQDYCHMin3oGOwcO43weqodoDN/9Gpc=
X-Gm-Gg: ASbGncsLDP5Oe76dzLAaiQhdTC2tGONoKdeqQTafhU94HN67jfawRzt8DydWWXvdAL4
	0wAowK/C2OO9g1HM2J4an/KDkAIpriMPTcChWnFOOrk7YUaALT58hgQ1J/4kSQwER9f281a33c1
	iJEW6WB/EIrLNpPo/I2RafMx7SiC/TIigmnA==
X-Google-Smtp-Source: AGHT+IEMvKPgfShf/MwU8EBntmzL2gLB5r9MeIt5Zff5sN3Hg4sMdylM4vuXLPE4sTB9F/25CeOcTFcD0aTeNKmZrbs=
X-Received: by 2002:a05:6102:441b:b0:4e5:9fbe:79f1 with SMTP id
 ada2fe7eead31-4e59fbe7f3amr3865881137.24.1748461552237; Wed, 28 May 2025
 12:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADvTj4qRmjUQJnhamkWNpHGNAtvFyOJnbaQ5RZ6NYYqSNhxshA@mail.gmail.com>
 <014d8d63-bfb1-4911-9ea6-6f4cdabc46e5@lunn.ch> <CADvTj4oVj-38ohw7Na9rkXLTGEEFkLv=4S40GPvHM5eZnN7KyA@mail.gmail.com>
 <aDbA5l5iXNntTN6n@shell.armlinux.org.uk> <CADvTj4qP_enKCG-xpNG44ddMOJj42c+yiuMjV_N9LPJPMJqyOg@mail.gmail.com>
 <f915a0ca-35c9-4a95-8274-8215a9a3e8f5@lunn.ch> <CAGb2v66PEA4OJxs2rHrYFAxx8bw4zab7TUXQr+DM-+ERBO-UyQ@mail.gmail.com>
 <CADvTj4qyRRCSnvvYHLvTq73P0YOjqZ=Z7kyjPMm206ezMePTpQ@mail.gmail.com>
 <aDdXRPD2NpiZMsfZ@shell.armlinux.org.uk> <CADvTj4pKsAYsm6pm0sgZgQ+AxriXH5_DLmF30g8rFd0FewGG6w@mail.gmail.com>
 <8306dac8-3a0e-4e79-938a-10e9ee38e325@lunn.ch>
In-Reply-To: <8306dac8-3a0e-4e79-938a-10e9ee38e325@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 28 May 2025 13:45:40 -0600
X-Gm-Features: AX0GCFvXBPujHS6_IsJk8UZ1tZBvuuAf4ZznRV1htx1eM1HjStthmVFSfduasE8
Message-ID: <CADvTj4rWvEaFyOm2HdNonASE4y1qoPoNgP_9n_ZbLCqAo1gGYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] net: stmmac: allow drivers to explicitly select
 PHY device
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, wens@csie.org, netdev@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Furong Xu <0x1207@gmail.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 1:27=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > I think a lot of ethernet drivers use phy_find_first() for phy scanning
> > as well so it's not limited to just stmmac AFAIU.
>
> You need to differentiate by time. It has become a lot less used in
> the last decade. DT describes the PHY, so there is no need to hunt
> around for it. The only real use case now a days is USB dongles, which
> don't have DT, and maybe PCIe devices without ACPI support.

I mean, hardware probing features for this sort of use case have been
getting added outside the network subsystem so I'm not sure what the
issue with this is as those use cases don't appear to be meaningfully
different.

> I suggest you give up pushing this. You have two Maintainers saying no
> to this, so it is very unlikely you are going to succeed.

So what should I be doing instead? It's not clear to me what the issue
with this approach is as it appears to be a rather non-invasive change.

> I personally don't like depending on the bootloader. I often replace
> the bootloader, because it is a crippled version that does not let me
> TFTP boot, does not have flash enabled for saving configuration, and i
> want to use barebox etc. I think it is much better when Linux drives
> the hardware, not the bootloader.

As you said earlier we don't want to rely on the bootloader(which I agree
with), so it's unclear how we should support SoC's that require runtime
autodetection like this in the kernel.

