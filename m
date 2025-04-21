Return-Path: <netdev+bounces-184412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B2AA954EF
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 18:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49FB5171FEC
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 16:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FEA1DF74F;
	Mon, 21 Apr 2025 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxa22RqP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A3613D53B
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745254265; cv=none; b=SVnwdNGNOFL55fYHXaGsgkJxYvIljj4zLSlZtWcYbbPOKmw4pxioWXiR40IWu2jfmhpATpHbdTkWNWPC1sE791/CBOol42GnuAEekMmCJckOY23sIoBCRwrWZIvZKAL8YIFIu3fZXy8YttwkX29kE/HjfRG3J+8P1ZKF4tDWSzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745254265; c=relaxed/simple;
	bh=MEZHiFpIWEUkGffrMPQkTGhIe5PCBbFCE5rAIsKNHb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dN9zqDT+ABqGTnTBoQQ5pjLZdrp3YYTZBis26/qtDBLqn0k3CQ486xl/7TniJcRy32jcMJFhAuvHuxqJGtiQ3ndnXpmus0X152Ump6jCpHwjGz8BdMa5eyREmV8BaR+JHsuSOvaXqCVl345Z0fgf39D27ucXbx1j624BERy4dHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxa22RqP; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so39699755e9.3
        for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 09:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745254262; x=1745859062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgwUpSyaGSzqG7JjROyx+1HfaaO305df0HsP5LKVGGU=;
        b=cxa22RqPqcdTCfeIRcJWED1l946EOp19DMRKCPv5RbPLT4OxfTzz8y8hqOaKbtnox7
         yRSu1Ecf5nATgyAcz0bvtzaExE3o4WwasGSEDHY3WHWPCPxT3vQGh7aHaktFryg/G7yB
         Nn4ALxSCXSR6ayhP73KpLY+Kywf+rnlkZlaKRjcmQnE3J9wt0CCKWeQhLTPIF4vRvlN5
         KkemnmHVu55odt4fQvEDsUToa0wsakUlWl4IIeqzM6iv5uNw0ve6ZOYImrOw9aW8WVHA
         Pb8hdnd1haNYXWZuyHcjMCN9Alfk9fMmTyEjkQpp/ZReRDy5ASAevSZnEbNA34tl0Zez
         tzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745254262; x=1745859062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgwUpSyaGSzqG7JjROyx+1HfaaO305df0HsP5LKVGGU=;
        b=h4Q5Lq8h9gqOOUxxKEOE+nTjIg44CsJBPB6WdB+8fHrlvZizzxjodZWPhwj8D84ikF
         KGegYxOxCiEkU3LMVShFGppUqsM9nK9r0llC+TS01k0tq8Q3/EQ3FFfWGkffyDtGwaDA
         /NjmSW6WTjO1/tsvv/xPu3DDZGN6WMZfTV9FYdmvhdSakyr2vtOgkSygcP1w5BTV5S3/
         FYPKUSAUVec4eK8DpHRQP+IF5+WYGWN9/TTkCVBaCip0loVet3w0t4BO9S6YSSVvODbT
         teyUvhJNilSAAO/ISkQXtwnGabNoJE+pI8yz9IlVXbbf0X1AxW6CK4elk5EyjxP1Eh+z
         gCxw==
X-Gm-Message-State: AOJu0Yz1JJ9onXDkMr2jfl0/9Ak/5zlSmf2FGztAJrwk/Oz8PFEJeSbS
	wPJ5EjHbpJckB0iObg8yxJ67JvszmXN4WpxhtlB3YLy2eELVGr+JzUqIqcI+fdf1Ui6d0+X9VPm
	Ntm5tmUYKYh6//dsvVlMw4if83F8=
X-Gm-Gg: ASbGnctukZUSyBUnJCK4oCEj1X75++N5NDUmDfZz9589+pQ9h1OBaXsJmeUtKdzxNn9
	9nDMArjn6uSfcfLebwfHL4vuA2RX/5TPKJQ7wpFZfZq60sQ4DAgADsbI60lQkHR7mRUAaLwZmN+
	7DoCsdn1OPEIf6L8ISVI7Tsxp/Q5xtPm2nYfyCEogrkKsgIBqgw+e0x30=
X-Google-Smtp-Source: AGHT+IETFFxfCntGOL7iVLoK2HnCkk4/KhOHJw4RNoUu/hEbaoExGPnqerrqnyjXE00GhncVB3k/42W8qD8ZgsMwWiI=
X-Received: by 2002:a5d:47ad:0:b0:39e:cbe3:17c8 with SMTP id
 ffacd0b85a97d-39efba2ad3amr9236568f8f.12.1745254261969; Mon, 21 Apr 2025
 09:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174481691693.986682.7535952762130777433.stgit@ahduyck-xeon-server.home.arpa>
 <de130c97-c344-42ee-b3bc-0ca5f9dc36df@lunn.ch> <CAKgT0UcXY3y3=0AnbbbRH75gh2ciBKhQj2tzQAbcHW_acKeoQw@mail.gmail.com>
 <06490a1a-427c-4e35-b9c3-154a0c88ed60@lunn.ch> <CAKgT0UfeH4orZq5AnHvgeTL3i05fPu-GNmBwTnnrGFWOdU+6Cg@mail.gmail.com>
In-Reply-To: <CAKgT0UfeH4orZq5AnHvgeTL3i05fPu-GNmBwTnnrGFWOdU+6Cg@mail.gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 21 Apr 2025 09:50:25 -0700
X-Gm-Features: ATxdqUGWn4cy7yObxomP87GHjdSyqWsIRPXIYJy6fflx54ADqEocml-EFOSeclk
Message-ID: <CAKgT0Udw-XQmRan1qBaBEkCOqNd2FRNgPd8E8Au+Wmih7QVsWA@mail.gmail.com>
Subject: Re: [net-next PATCH 0/2] net: phylink: Fix issue w/ BMC link flap
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, hkallweit1@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 8:51=E2=80=AFAM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> On Sun, Apr 20, 2025 at 2:58=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrot=
e:
> >

...

> >
> > > 2. Expectations for our 25G+ interfaces to behave like multi-host NIC=
s
> > > that are sharing a link via firmware. Specifically that
> > > loading/unloading the driver or ifconfig up/down on the host interfac=
e
> > > should not cause the link to bounce and/or drop packets for any other
> > > connections, which in this case includes the BMC.
> >
> > For this, it would be nice to point to some standard which describes
> > this, so we have a generic, vendor agnostic, description of how this
> > is supposed to work.
> >
> >         Andrew
>
> The problem here is this is more-or-less a bit of a "wild west" in
> terms of the spec setup. From what I can tell OCP 3.0 defines how to
> set up the PCIe bifurcation but doesn't explain what the expected
> behavior is for the shared ports. One thing we might look into would
> be the handling for VEPA(Virtual Ethernet Port Aggregator) or VEB
> (Virtual Ethernet Bridging) as that wouldn't be too far off from what
> inspired most of the logic in the hardware. Essentially the only
> difference is that instead of supporting VFs most of these NICs are
> supporting multiple PFs.

So looking at 802.1Q-2022 section 40 I wonder if we don't need to
essentially define ourselves as an edge relay as our setup is pretty
close to what is depicted in figure 40-1. In our case an S-channel
essentially represents 2 SerDes lanes on an QSFP cable, with the
switch playing the role of the EVB bridge.

Anyway I think that is probably the spec we need to dig into if we are
looking for how the link is being shared and such. I'll try to do some
more reading myself to get caught up on all this as the last time I
had been reading through this it was called VEB instead of EVB.. :-/

