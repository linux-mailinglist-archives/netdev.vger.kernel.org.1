Return-Path: <netdev+bounces-148335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAB89E1282
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 05:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFB44B209BF
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 04:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A6B14B941;
	Tue,  3 Dec 2024 04:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Raexstf9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC35A3398B;
	Tue,  3 Dec 2024 04:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733201053; cv=none; b=LpvCeYMrEGJ6K7weRhALdJJnuDqPBIWLp7sXbLQWARN6vLms6Wy3BN8RqXxCnu1F4a6PxBofDeCatQoJ/r9+QjjMHlSF0jwF8KQB2uWQckEc6rUj8GABdsSYzblGLdYm3m0sj3SYcFcaI5x4QbU17bNc4Kk75MFDbYKJWtonAoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733201053; c=relaxed/simple;
	bh=WyUE7umPpTckjXjtaex+sl9CceGelbF7Fb3NFFPFZOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGvhhXN3BzLN7MC4iGoOQrrEv9VMiNLZDQIr2gNLzXQdCUlDPPn5S+NyU3IIys2ci4ZDQm8e6lAJq0huLv9LylSA5cFTSeFMPtinlExhu0zc5nZ8Dn29OPSrLdv/Ux/TcawxqDPCa+HUUQjGwS+OodEShAEgTC3GJhXlSGWH3as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Raexstf9; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-85bd4d330dfso59517241.2;
        Mon, 02 Dec 2024 20:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733201051; x=1733805851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WyUE7umPpTckjXjtaex+sl9CceGelbF7Fb3NFFPFZOU=;
        b=Raexstf96wXEXWZxLebp/TN/US2j87vmVQYTUyP9MP5aDt+72tnv4qw3MYwm2LgBVr
         GWOuyjlGgOmLmmkB0TlcF0XaiIPhhXLzTNSiTLQ4/ephgSLldQZcmXihrpv86qdhQR0/
         Qmofh/nNYrcW5ukD9pIU/aY/tnhtfajl2SEVlgW40rVbDIDMuii+tRf/HE/0Hgf3+Ghz
         DtbHwV5t5SB6Xp1nfpwmoUwojWrLsg9xTFdnyLh7LDrit5OkbVlYwK9iC2jFZ7jnnimC
         WF5Y9buB/muaNkLN/0tVGYp0XA4QBs5gLgYMXD2ZPznfjeaSBzWqXsa+q4xXGQDmYCwk
         VOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733201051; x=1733805851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WyUE7umPpTckjXjtaex+sl9CceGelbF7Fb3NFFPFZOU=;
        b=CGQZrw1eNqe2Si8Q/y4NWwVpU4t7USBVQvW/KISmONx9LUKWMjt0YzBHiYb4e541y3
         AzzqtvF0u3W+hSCtjmKM4wrUsm0jtN7Mp8HfWTT7urh8tCZc3tr1XTymrBK5lg5M0Ita
         RIBzoeC7SOGT8SQaxFqyHITWdgvW4eM3IyIwXyQKm1nAY9xggwgmGMdMaC0sNeWRA8cZ
         1arb0QJqKqRl6whsXCeKteAAhH/q7WSIgn/nNXqTDcAbU7UIXw7ZknEc4++kc70CDqEg
         3+vcs9Q50b2tCJHtTLm2RyCFqfoC8mewJrj5VIzh7drM/A/r8aJQ2z1CG4r8B3syIJB4
         SToQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf2xb472/YGlns3tPHpfc/aD9LMS6sLKfXM5r3ku2lgMusXx3qoG/gF5Ijm6ULiMHTkxXWyL83@vger.kernel.org, AJvYcCWcnDDMAKzfllHETVaZ43n9C65HYPHHIarZoW7Xf6d7NllncOefYnV/OCI62JaqyI1AQRO6lagdTnJ6vI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsx3l9z+t/1hoU2xHzn2jdKD/U9yETrOxskP7kpey3vWp6k1TU
	3ee+piQDnITnvFYpEQaMnyxY3SOgsmT5yHcrXiMVfF7A57iddgq9aYNkxTpykVKjUpaLZQgoKDW
	zXIXmF49dKPdGdVkfpYwP+srLtc9uFhvuhkSsXQ==
X-Gm-Gg: ASbGncuMehRY/uLHyPncIcskFswQ0PvBs5EcFW2P4ziXSSb1d0Rp2KWje/RYvrpBmJ/
	wnPE6lL6pGXxiniI59OuDuocMEd+cno5MbQ==
X-Google-Smtp-Source: AGHT+IE1pbgGu2IDhQN0qKV9B9+UyFNaEnoAVx294zpG69v+6ppm9kADeNbsUqswhU7w1d5gr1DKHjKhO39nFMnGlQY=
X-Received: by 2002:a05:6102:2924:b0:4af:4bc9:7872 with SMTP id
 ada2fe7eead31-4af9719ad21mr671555137.4.1733201050916; Mon, 02 Dec 2024
 20:44:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202195029.2045633-1-kmlinuxm@gmail.com> <690e556f-a486-41e3-99ef-c29cb0a26d83@lunn.ch>
 <CAHwZ4N3dn+jWG0Hbz2ptPRyA3i1SwCq1F7ipgMdwBaahntqkjA@mail.gmail.com> <aa36e5a4-e7d2-4755-b2a1-58dc5a60af1c@lunn.ch>
In-Reply-To: <aa36e5a4-e7d2-4755-b2a1-58dc5a60af1c@lunn.ch>
From: =?UTF-8?B?5LiH6Ie06L+c?= <kmlinuxm@gmail.com>
Date: Tue, 3 Dec 2024 12:44:01 +0800
Message-ID: <CAHwZ4N35tsBcxhn-NBzBtpWjpZm1rANWHTHFFhj+e2r8aA-DDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: phy: realtek: add combo mode support for RTL8211FS
To: Andrew Lunn <andrew@lunn.ch>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	willy.liu@realtek.com, Yuki Lee <febrieac@outlook.com>
Content-Type: text/plain; charset="UTF-8"

On 2024/12/3 11:53, Andrew Lunn wrote:
> No, it needs a lot more work than just that. Spend some time to really
> understand how the marvell driver handles either copper or fibre, and
> assume the Rockchip SDK is poor quality code.
>

I'm currently busy in a new IC project so I might not have much time
working on this patch, would you like to accept another patch about
broadcast PHY address?

> It might also be that the marvell scheme does not work. It will depend
> on how the PHY actually works.

In fact I don't familiar with how this code works and which
function will handle link-state change callback. But yeh, Rockchip SDK
is indeed filled with low-quality code,, although it works.

Maybe I'll get back to this patch several weeks later. I'm sorry for that.

Sincerely,
Zhiyuan Wan

