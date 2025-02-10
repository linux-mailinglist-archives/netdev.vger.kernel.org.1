Return-Path: <netdev+bounces-164538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924BDA2E1EC
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 02:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71AFE3A1D7A
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 01:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09591F9C1;
	Mon, 10 Feb 2025 01:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSyFwvfL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44810243370;
	Mon, 10 Feb 2025 01:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739150263; cv=none; b=jLpn9j9DTCcmnV4NNKqt6SdmsST39ynhdsOEreT+qmTadbDI/eu8/edihMAd+5p0lZk0COKRMCUVRbMBoMcxJzpjQGSwL4xtp+oI+gf2zikSs7KV0DLr24MWJwoEVwRQp0z2SYSFv/pEmbdMtdX55febTnUlQP0GnxAFAtxqZe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739150263; c=relaxed/simple;
	bh=bKlpFT6PrHym8PX4uf7rFAciKgOW9Ca8NPYUAwletjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Id3v0URHxxtsEI8wtujR+IKF9cBzmFAQc5xnocefDp6M+9TXIpppTLyM/lgGDnQx3v1ItTSl9ViBv8vmimCepRvkKGpGO8s6etCLBs+MjA1SBHzCJInfQ+n/qLQQoS+Lnzw7o2SMD0VEz3BIo+KxzdaX45REKFXchoFh0+rxSzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSyFwvfL; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5de7519e5a7so719605a12.2;
        Sun, 09 Feb 2025 17:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739150260; x=1739755060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ks9udvKd96mPLbUFD9boqSQ9LwZ8UE6lqZxDKa9Cl+8=;
        b=NSyFwvfL0vKvWW/PkYkPPt/I+bnjn+jv6tsQNik86ygu3KYNjeIoMhuhLXWfAo/Tik
         76PIT/+t2V13Az64RolKkJAyMy+N0RbMcCP0uF0EaNEHN74cK2cSWS1PJ9x3++plZ7DL
         uVth1cszV9dXuXeWDFMDleBA0oUVxtHIVE1IlaxKkZy8YvL3+MiN+oeXZB17xzIasV7n
         dpsBVA8yoEQwScCE8upayP8n+hmL41iGr2Hp8tZ1N9YNYvOMqC1HsjnaDT+B/UiUjS57
         ZixdYMyHaD86w1IK/GXN8zsBThjSIlpzQ8Y94C/KAFvlvBIu8xWsyA3bKB5Wpw2t9QCJ
         jCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739150260; x=1739755060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ks9udvKd96mPLbUFD9boqSQ9LwZ8UE6lqZxDKa9Cl+8=;
        b=sYwlJrHcHnBa9y0T/QCIt+cvgYAp5SrtbEUSpH7OQEICkPxoCyMtisUDkoQJYykO40
         9+CsuFr+ehbhEioLUna9bFTEDK/0ZrwGJg3vuOG14h0zqCtfYvBMvowikkFKJyWAIW9p
         7l6WI+F59Scp6pz0d9ehG2y9vobRNxrTdrJUocMwHfRNi1FTOgc4S03Pb5QhtcgcZdeF
         vgswMlwMTG53ox2Vnx5l9ieC3GOcRQpNQ4PLjHfSSzOG0/7OhIoUX0f2IlHAuwzpBuNT
         v74BD9gixWxTza91+ZRpvHTVlBC34EIL1Oxjj7x4XhpDfskHUVjU8+KYpAI4LGH69hTv
         FJIA==
X-Forwarded-Encrypted: i=1; AJvYcCX0DARg8ItyeaGB1mIpOm/VPPPyPEzA8CO9iu4JbETyKcpf5dHITuK2NbI0kdCSx5Mu5VwT7mcb@vger.kernel.org, AJvYcCXl2XwIR0SiyzvXzEVr16yzBV7zDmMxHk8zQmaK9E615sUTWVqdDCiC62UeUP6j0Ez0ZrnmDcei8qyAA88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+1GWCAgbE8/w0ImYbR6VayUn5LpTl0f4Cyep7igNqHG161XCs
	wgmC7igqocVZsbiZdftu2JHivE7VGa0EKJbP6u96JakjTMeEJbuzgEnTMSnePSK/ct/4WSiWA9G
	t4JipPPcrn51Hi2hOtyY17cZONwk=
X-Gm-Gg: ASbGncvBU8GO+apYRQ0S/VdEWKoZUpeN47RHOlUqEMQiUzOVOTYD/D0UxwydJPkgW4q
	TdpZgU7YC13SxmwAf/YG0T7y45gjTtAkCW+rkYrfEwFcCiOpddZLohGjBpa2enB7g/jVEqCyY8w
	==
X-Google-Smtp-Source: AGHT+IHqdWdyJGHhDPdk2qUdT/YSoJ8MN8YkmKFvF4vWVU1IkrrYjnOolSTtN45eIsb0W8v10/Wt8QLl78LGUCKKdOM=
X-Received: by 2002:a17:907:3d91:b0:ab7:c426:f33 with SMTP id
 a640c23a62f3a-ab7c426114dmr146360766b.56.1739150260350; Sun, 09 Feb 2025
 17:17:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210003200.368428-1-jjcolemanx86@gmail.com> <db722f47-0b61-4905-a4a8-c0770fbf8945@lunn.ch>
In-Reply-To: <db722f47-0b61-4905-a4a8-c0770fbf8945@lunn.ch>
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Date: Mon, 10 Feb 2025 11:17:28 +1000
X-Gm-Features: AWEUYZkznMg4o2_S5g5_DWiaL3CmXwiLukTqn5lWww_rfG9VfcoPcjnZBz7igZs
Message-ID: <CAAvyFNiTgZyVX79FztAB-4LGrq6ygKNXYYkOdLF0AY5TGF58ug@mail.gmail.com>
Subject: Re: [PATCH net] ethtool: check device is present when getting ioctl settings
To: Andrew Lunn <andrew@lunn.ch>
Cc: John J Coleman <jjcolemanx86@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Ben Hutchings <bhutchings@solarflare.com>, David Decotigny <decot@googlers.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Feb 2025 at 10:51, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, Feb 09, 2025 at 05:31:56PM -0700, John J Coleman wrote:
> > An ioctl caller of SIOCETHTOOL ETHTOOL_GSET can provoke the legacy
> > ethtool codepath on a non-present device, leading to kernel panic:
> >
> >      [exception RIP: qed_get_current_link+0x11]
> >   #8 [ffffa2021d70f948] qede_get_link_ksettings at ffffffffc07bfa9a [qede]
> >   #9 [ffffa2021d70f9d0] __rh_call_get_link_ksettings at ffffffff9bad2723
> >  #10 [ffffa2021d70fa30] ethtool_get_settings at ffffffff9bad29d0
> >  #11 [ffffa2021d70fb18] __dev_ethtool at ffffffff9bad442b
> >  #12 [ffffa2021d70fc28] dev_ethtool at ffffffff9bad6db8
> >  #13 [ffffa2021d70fc60] dev_ioctl at ffffffff9ba7a55c
> >  #14 [ffffa2021d70fc98] sock_do_ioctl at ffffffff9ba22a44
> >  #15 [ffffa2021d70fd08] sock_ioctl at ffffffff9ba22d1c
> >  #16 [ffffa2021d70fd78] do_vfs_ioctl at ffffffff9b584cf4
> >
> > Device is not present with no state bits set:
> >
> > crash> net_device.state ffff8fff95240000
> >   state = 0x0,
> >
> > Existing patch commit a699781c79ec ("ethtool: check device is present
> > when getting link settings") fixes this in the modern sysfs reader's
> > ksettings path.
> >
> > Fix this in the legacy ioctl path by checking for device presence as
> > well.
>
> What is not clear to my is why ethtool_get_settings() is special. Why
> does ethtool_set_settings() not suffer from the same problem, or any
> of the other ioctls?

ethtool_set_settings() would suffer the same problem. Last time I did
this (with what became a699781c79ec) I was discouraged from fixing
additional theoretical problems which weren't the actual problem I
faced.

We did not review other ioctls. Looking now, I see commit
f32a213765739 ("ethtool: runtime-resume netdev parent before ethtool
ioctl ops") would have protected against this as it adds the
netif_device_present() check one function back in dev_ethtool(). We do
not yet have that commit in our kernel.

It seems we can forget this. Many thanks for the review Andrew.

Jamie

