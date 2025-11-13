Return-Path: <netdev+bounces-238481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AAEC5969F
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 19:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EBA9434F08A
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02980346768;
	Thu, 13 Nov 2025 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="36IUaeQx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF1A358D12
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057902; cv=none; b=Qhb/MWV8iu8aHY3MDS2mADiAWMJKqNqpHBKAGC0wVKGE8juEIhGP/gpXfUQCwigvIc8RodUKtCH+jJoO0qsjxTPgCIT+wREY0hUQ4Cm6wrJmjPdV+lDYP2e7xzdnz72z6PZum6lm38W6UVlLpgtgn4zpv2iCx6u5m8JAZ8k3/1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057902; c=relaxed/simple;
	bh=f93A8f9WizXVEioHDGwq53XkWjYdfcGuJMPgZoANb4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXA6GO3L/kw9MNHbPV3NYxUh/EFYUEGLLVwdUybntiAAKuEXj6GvvMJQ5tu3aGw9VtE4W9Apeq3RiQ1PB9uvyD1GjaslK2KI2Nwin9te3gEaqgAOM9EYZhwkg4zA8Ws6PNtVvQXsbiHY1bMnKVeR0Sw5YZoFrlYp6UaGXR25Ao0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=36IUaeQx; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ed7024c8c5so8544221cf.3
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 10:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763057900; x=1763662700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QBuS22KKbiezuFoBj2dmfv64zRYES6WVPNoY+VjaJ4=;
        b=36IUaeQxb9x+hgJn4O+0r/a0pAa8ZWuIf1qdKFUV1OeAehBQcIHYaZyENRrC5RjryL
         +EaWvQcxzZYPZbNbplErH3FzNhQMJ3inz9vJizmSqlxNOzpT318EmKAI21J7YooBhe+l
         PkxLU+HkWtqVeX9A8EkX30uJZ2AdUUlW/VjceselwtvkD2lKOnMTllKHKz9eNDhLbL6U
         XEU47QHSjeBmIxI5JBraMOyvxQELLzxcz2CLD3r8zCyFaHma40xhv/Qc2f0cUVu2fHP7
         Hhi7893zLNBBhiP3ngM8wlEm1+xy9XUoCEA/pWaqigZQ0HRauTRwrCmY5Ibzs+UheGCD
         Qarg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763057900; x=1763662700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/QBuS22KKbiezuFoBj2dmfv64zRYES6WVPNoY+VjaJ4=;
        b=egM3w7NuHNactRjvimQOPQ/kvWmo1r8FekAa2xaKL4ztyCHkd0E6OOKyveEYXfLi0R
         Ygxk8vXDtKdCc2USr2FPQPUNL7EOxctcP2WH5AuUYv8T442buhQSYwYaFbYGKwPy4jsP
         0NSSuZctb5DJ5Jq848Y38Vz0alh4tZ2evEXRxbvd/zBLzvHkyxfcp/0I7oaQ5IbV/z6N
         6xcGJfW9PS2sxA5iIW6hzeW//t4BZCnB1e5aF0hin8ihlqsPnBogqeW8QR6qBIV6Rsxd
         estbJY50aThZo7QSesoN63d0DH9GKuf+ivhn/RgUa3uBcyddFj2jMSsUtLyX9dA4TDyO
         9jWg==
X-Forwarded-Encrypted: i=1; AJvYcCVTqs6orERSRLjJIyTAGghL0QUK5XPqWL7jZc58btQS28mlF7UHUS/19d4KxCCEUJ2a+ALs2xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQjvz+x2eNvvo4VhvLSR6ptiX7no+VfFAyjkvzOtMNYA8yERqX
	MJD0bejBIdAK5uy3OHHNWPVkfszxMXLYINy2lkfjpn79aAdARszqiqxBt0Y0lHypLO+qkji9OoK
	mkSr8l10sXMxqwrMREndBI46KsaQxa2Ukepi2XMaC
X-Gm-Gg: ASbGncvEzGJUQaNE4NF/DMmtCCaNDPSstj+7/QIby5Rc6e/c8v1Ceg55LfhAyOylD56
	AX3AHquWKc1VyPbKnDn5lxUrHaWcVg0/8sUAnilldO8HLGjInCIaKzTF4CHx3LNE8SIj1T0uDHR
	urdHdaSo2SRvWjhgiPo80grkM4a/RreibM14kOMsCFHNC5KhYtbK92EJjfDtH+h6NbA76SWesMc
	vDn0N61feXZqsA4A1Hp9uZ46srfMxUCUNps57Yz5l5Elk4/UFqiHLXw/Ggx7TtSAgDvt4qWRzNt
	pjbmUXE=
X-Google-Smtp-Source: AGHT+IEQb04EFItfps7wK3T9VKeqI4lb3lIvgW5wj3WpfUwF+JMSWLO5U+qF/ZS6pMqBD4ypHVy70XyD0uBVStQarWs=
X-Received: by 2002:ac8:5f4c:0:b0:4e8:9e8a:294a with SMTP id
 d75a77b69052e-4edf214edcemr8281281cf.58.1763057899577; Thu, 13 Nov 2025
 10:18:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113154545.594580-1-edumazet@google.com> <c6020af6-83d0-46c9-aad9-2187b7f07cbe@intel.com>
In-Reply-To: <c6020af6-83d0-46c9-aad9-2187b7f07cbe@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 13 Nov 2025 10:18:08 -0800
X-Gm-Features: AWmQ_bm1U-Cyn1UVeB5sUpv_mHKHBP8-jEH0QzQq6Q_vk9iyjpxW3NSAMkJeXvI
Message-ID: <CANn89iJzcb_XO9oCApKYfRxsMMmg7BHukRDqWTca3ZLQ8HT0iQ@mail.gmail.com>
Subject: Re: [PATCH] x86_64: inline csum_ipv6_magic()
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 8:26=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 11/13/25 07:45, Eric Dumazet wrote:
> > Inline this small helper.
> >
> > This reduces register pressure, as saddr and daddr are often
> > back to back in memory.
> >
> > For instance code inlined in tcp6_gro_receive() will look like:
>
> Could you please double check what the code growth is for this across
> the tree? There are 80-ish users of csum_ipv6_magic().

Hi Dave

Sure (allyesconfig build)

Before patch:

size vmlinux
   text    data     bss     dec     hex filename
886947242 245613190 40211540 1172771972 45e71484 vmlinux

After patch:
 size vmlinux
   text    data     bss     dec     hex filename
886947242 245613190 40211540 1172771972 45e71484 vmlinux

I found this a bit surprising, so I did a regular build (our Google
production kernel default config)

Before:

size vmlinux
   text    data     bss     dec     hex filename
34812872 22177397 5685248 62675517 3bc5a3d vmlinux

After:

 size vmlinux
   text    data     bss     dec     hex filename
34812501 22177365 5685248 62675114 3bc58aa vmlinux

So it would seem the patch saves 371 bytes for this config.

>
> Or, is there a discrete, measurable performance gain from doing this?

IPv6 incoming TCP/UDP paths call this function twice per packet, which is s=
ad...
One call per TX packet.

Depending on the cpus I can see csum_ipv6_magic() using up to 0.75 %
of cpu cycles.
Then there is the cost in the callers, harder to measure...

Thank you.

