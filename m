Return-Path: <netdev+bounces-240250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E807C71E29
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 03:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F04914E0F2B
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 02:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042A81A23A6;
	Thu, 20 Nov 2025 02:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PHP+1wHr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0C81624C0
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 02:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763606815; cv=none; b=bLF/Fw8Zw5452aMZDnr8DcjNcvogJohLpVdVqFHjN6w/5xBFuvtT/DR7pG0028B5L9vQEO/crB03nIOPqe5gh6UOzD2XnSHiMJAJQZY79VfFAkfjqVlnX/L3IVP/JWWIHnsIz++IrHmTpoTEdrYJvGKyGLoy5Il205u2Ho4MdUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763606815; c=relaxed/simple;
	bh=LWyMd9sRgLl8oxtiImFQ7UdupBsTnEiW062uZ9olqI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHxc02PkYWJO1/l9pzVLXQnC1gKVmJ6A0JG/a3r5hda1JBhHD0gem/9Bfz3omFp7Nyuytgz2knCcbmIdsenX/36OxOuGkZJHMwfE1EdR8Egw95WoxmsH0AMatSjqrgQZu7P7IoLpGbOyXTmwy3WmiEjZ9sxLkWd/vfwJt60zi7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=PHP+1wHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4AFC4CEF5
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 02:46:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PHP+1wHr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1763606812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dxwnO1tXJ08UsmEia1wxtoWT74hB995IOQ2mJYj07Xc=;
	b=PHP+1wHrf14kkqDgZ7PQXfpoNO0esyrlfD32qUTixIcDybamFhpnfu6CUGyUGnQKqQ3kLX
	Dtg/Z5HP4hMypyn+AoHgoDC7HLnt0TT/FyMXOvhLrR4jtsmf8vOKwZOiH5RImEKxAEMB4i
	CGhKvhFU27bwbkoB/dklV9oMHnOmFkA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bd3d1696 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <netdev@vger.kernel.org>;
	Thu, 20 Nov 2025 02:46:52 +0000 (UTC)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6567a0d456bso156658eaf.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 18:46:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUbZEvX7fWoaCyOUtMAlQi/T/7tMXzk0MZWNrKrrwv9rxakyf1kauW3bG6oEuEVBT3tqGGWo0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0X0TpONxoLKZ7ZK/LhWzncACe/U3rEtXZd4ei3/YCo/mwaDFD
	OVFPKseIZKcM+KSIxMowwgmRNe3fl4hgB1WAXbKZYlF3O/HSD0MCRKIFzVmxWp4iiAeiTeWGL5/
	go8VVlbdDFml8X3jRTuoZQTA4e3aYISU=
X-Google-Smtp-Source: AGHT+IHmjORnbezK3Cy07NtvvPgPVh6yeAFooDJrIRHJz+756dVK12SB8CSm/8U/DvKr9P39OdEDkooLwhAxsRASbsg=
X-Received: by 2002:a4a:ec4b:0:b0:657:6746:cd0a with SMTP id
 006d021491bc7-65784a1cbb6mr521777eaf.8.1763606810489; Wed, 19 Nov 2025
 18:46:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105183223.89913-1-ast@fiberby.net> <20251105183223.89913-12-ast@fiberby.net>
 <aRyNiLGTbUfjNWCa@zx2c4.com> <d2e84a2b-74cd-44a1-97a6-a10ece7b4c5f@fiberby.net>
 <aRz4eVCjw_JUXki6@zx2c4.com> <20251118170045.0c2e24f7@kernel.org>
 <aR5m174O7pklKrMR@zx2c4.com> <20251119184436.1e97aeab@kernel.org>
In-Reply-To: <20251119184436.1e97aeab@kernel.org>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 20 Nov 2025 03:46:39 +0100
X-Gmail-Original-Message-ID: <CAHmME9oO0sGnHrZUeETmL+CCj1UZ+aQx_CPArXKpFuBhE9UYbw@mail.gmail.com>
X-Gm-Features: AWmQ_bkifYdvGI4adpQOGVNgvq1ZnMxuy40DUXaEKHs2njG343EQtkBA194udnU
Message-ID: <CAHmME9oO0sGnHrZUeETmL+CCj1UZ+aQx_CPArXKpFuBhE9UYbw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 11/11] wireguard: netlink: generate netlink code
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jacob Keller <jacob.e.keller@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jordan Rife <jordan@jrife.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 3:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 20 Nov 2025 01:54:47 +0100 Jason A. Donenfeld wrote:
> > On Tue, Nov 18, 2025 at 05:00:45PM -0800, Jakub Kicinski wrote:
> > > On Tue, 18 Nov 2025 23:51:37 +0100 Jason A. Donenfeld wrote:
> > > > I mean, there is *tons* of generated code in the kernel. This is ho=
w it
> > > > works. And you *want the output to change when the tool changes*. T=
hat's
> > > > literally the point. It would be like if you wanted to check in all=
 the
> > > > .o files, in case the compiler started generating different output,=
 or
> > > > if you wanted the objtool output or anything else to be checked in.=
 And
> > > > sheerly from a git perspective, it seems outrageous to touch a zill=
ion
> > > > files every time the ynl code changes. Rather, the fact that it's
> > > > generated on the fly ensures that the ynl generator stays correctly
> > > > implemented. It's the best way to keep that code from rotting.
> > >
> > > CI checks validate that the files are up to date.
> > > There has been no churn to the kernel side of the generated code.
> > > Let's be practical.
> >
> > Okay, it sounds like neither of you want to do this. Darn. I really hat=
e
> > having generated artifacts laying around that can be created efficientl=
y
> > at compile time. But okay, so it goes. I guess we'll do that.
> >
> > I would like to ask two things, then, which may or may not be possible:
> >
> > 1) Can we put this in drivers/net/wireguard/generated/netlink.{c.h}
> >    And then in the Makefile, do `wireguard-y +=3D netlink.o generated/n=
etlink.o`
> >    on one line like that. I prefer this to keeping it in the same
> >    directory with the awkward -gen suffix.
>
> That should work, I think.
>
> > 2) In the header of each generated file, automatically write out the
> >    command that was used to generate it. Here's an example of this good
> >    habit from Go: https://github.com/golang/go/blob/master/src/syscall/=
zsyscall_linux_amd64.go
>
> You don't like the runes? :)
>
> /* Do not edit directly, auto-generated from: */
> /*      $YAML-path */
> /* YNL-GEN [kernel|user|uapi] [source|header] */
> /* YNL-ARG $extra-args */
>
> Do you care about the exact cmdline of the python tool, or can we just
> append:
>
> /* To regenerate run: tools/net/ynl/ynl-regen.sh */

The args are non-trivial, right? The idea is so that these files can
be regenerated in a few years when the ynl project has widely
succeeded and we've all paged this out of our minds and forgotten how
it all worked.

