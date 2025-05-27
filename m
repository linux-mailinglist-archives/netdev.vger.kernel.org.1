Return-Path: <netdev+bounces-193766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EF9AC5D66
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 00:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B32847B1850
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 22:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0F92153D8;
	Tue, 27 May 2025 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMbXdhY2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8FD213E89;
	Tue, 27 May 2025 22:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748386064; cv=none; b=qsNz5Och/RHzlhAD3dBtJ4IdR6nd1xXE0X+O/k73zHmTIgH+deRAWztrJ/RmTyuVEYNvcMDNCj8nopd4tuzYAxLqHE/Sy2f6IUl4SIdeGTr4ed6juDqRo8osPdHq0jjvNXGcZFRJWYYeJTebAuY5sugF8X9kwB/XvZ9CbyyUCZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748386064; c=relaxed/simple;
	bh=nxxTE8N1NiBs4G5g2I9AK/16Q2IKP+a3RuAqB4TehIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlgjO7CVceWVWmHyIt9gtdY9HenllYG/lFiaCu2P79zR7TTtNXPvJSe5Tlb53CmtFNe1KAF58CRsCwha1gvL2XvtX17HMfuXhE+Vuzj3oF5GekU9iYxmYe3z7SuYdbH1bvVFI8iA+yw/ZULbHTyV+inDKWzjTkAucbZdCld8DIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMbXdhY2; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5259331b31eso1293373e0c.0;
        Tue, 27 May 2025 15:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748386061; x=1748990861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxxTE8N1NiBs4G5g2I9AK/16Q2IKP+a3RuAqB4TehIU=;
        b=EMbXdhY2fT2nXo6Ak0tX8MszVdyYz9i1k0BTxDo79bG3SAuY5S8CGceUP/vXx2DPCh
         uKhvskQEaOJK2cYH1+nd1FIVfvIJOMngbheqv8/VOfUcERCA6IAvun0X9sCv7+YkZN5C
         zsU51x5NHRLs46W/MA82PKnPZ5Y43gr6F4iKsK/uCZoHotiwNuNggE50ZkeeycaeCtRA
         Ie2P0F+8OMvH18pBXBsjmb/IkwQhbiGIbH6w8wUSiXk7u8IdRCQlVHjMGBAp9nGK0bal
         PRNlIIIfJRnHjba/KUtM/4yMXT1jxXEfH/CdVnVOuIKsTVBg1jXP65oity5KhRZI0R42
         apcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748386061; x=1748990861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxxTE8N1NiBs4G5g2I9AK/16Q2IKP+a3RuAqB4TehIU=;
        b=iSWHFltzTdhihuFOuNKMq7MdbJAGYF9fuU3F3aJktpVcfE1FAc3Pb9tty4f7dG/K3k
         pK4uIGJnKd/M72//CAyXJHOorTiJhrh4mlLmAlbZAAPUS24jJxDMRrYFyaxoSDZgdseH
         Gxnblo1x6PVWjfWR1uG5YiBhTiDxRDCaIO2Ki6FU0u+hFheNGoIBcKQKRKHs4kRWQotl
         3/KNKkbKQXIp9Xezp8hgA4uEouqJMoFi9Qv5pVhotLYXNMsU3krqpMWSekFXECip3dOK
         jwwuGfXshlcx1ckmm3wbwiq0ApuTWle9hQZi4n/CzDaDndyNRhepJHBfYkJ/l8X2yzVT
         CXHA==
X-Forwarded-Encrypted: i=1; AJvYcCWzcgsdHes8f6D3aBnsu5nrexD+zy37vU4DBOo8NItDdYuZtU8BEYUw0Mz9eHlY0t1GGx9zVZcLibN89LE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/jmiRn5rr93GmfYH14PYoZPXYHcx9sHF4+sg1tgitTI1HLmML
	DV3+pelh/OFSqGkUNg6atWOg1Q6a2poZPjuyYSdKYmHamTAPZjfIAW5K1zU/r8RL0kLbOSLxNPY
	bGjIUWBMUBu0Hwh7K6nSAv9KNOS02MHQ=
X-Gm-Gg: ASbGncsSgVZ0sn2dm6h5Uie0KP4zMFkkbfuxTcRhevQL7TdunImRMw3eVJqSOcfoOX5
	jc2wPf8s4C6CFIYFvICHCDsTuspd+A0jnOYvPp1lY74odHtDEGnoR3dKW8iwS3pongpsBrCp3Jn
	FTCg6x9dnCb4lL9uVt1pGI+i6xelxJtBVHmA==
X-Google-Smtp-Source: AGHT+IEIHMkdlH/en+uXp0oVsAoqX5M/MWpWjcwQtNcI4RUU/vNIUEP2JP+Exp7QavSYY/Cs2DChtfMhjj8/xUWGVBU=
X-Received: by 2002:a05:6122:3087:b0:530:63d9:115a with SMTP id
 71dfb90a1353d-53063d913a6mr831217e0c.4.1748386061291; Tue, 27 May 2025
 15:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527175558.2738342-1-james.hilliard1@gmail.com>
 <631ed4fe-f28a-443b-922b-7f41c20f31f3@lunn.ch> <CADvTj4rGdb_kHV_gjKTJNkzYEPMzqLcHY_1xw7wy5r-ryqDfNQ@mail.gmail.com>
 <fe8fb314-de99-45c2-b71e-5cedffe590b0@lunn.ch> <CADvTj4qRmjUQJnhamkWNpHGNAtvFyOJnbaQ5RZ6NYYqSNhxshA@mail.gmail.com>
 <014d8d63-bfb1-4911-9ea6-6f4cdabc46e5@lunn.ch> <CADvTj4oVj-38ohw7Na9rkXLTGEEFkLv=4S40GPvHM5eZnN7KyA@mail.gmail.com>
 <93bfec74-c679-400f-8ce4-3bc84d6d803f@lunn.ch>
In-Reply-To: <93bfec74-c679-400f-8ce4-3bc84d6d803f@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 27 May 2025 16:47:30 -0600
X-Gm-Features: AX0GCFtPGtsaGbTe2C2G-Irv_0PosK6COEhRkyls49G6hbvQpWVi2Nid9Q5gamo
Message-ID: <CADvTj4oF4UOnDUvVUtuaM6U5RR4WF02qmheqg8fEafev2En3eQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] net: stmmac: allow drivers to explicitly select
 PHY device
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Furong Xu <0x1207@gmail.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 3:48=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, May 27, 2025 at 02:37:03PM -0600, James Hilliard wrote:
> > On Tue, May 27, 2025 at 2:30=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > > Sure, that may make sense to do as well, but I still don't see
> > > > how that impacts the need to runtime select the PHY which
> > > > is configured for the correct MFD.
> > >
> > > If you know what variant you have, you only include the one PHY you
> > > actually have, and phy-handle points to it, just as normal. No runtim=
e
> > > selection.
> >
> > Oh, so here's the issue, we have both PHY variants, older hardware
> > generally has AC200 PHY's while newer ships AC300 PHY's, but
> > when I surveyed our deployed hardware using these boards many
> > systems of similar age would randomly mix AC200 and AC300 PHY's.
>
> Are they pin compatible?

From my understanding they are entirely pin compatible.

> But i assume none of these boards .dts files are actually in mainline?
> So they need to go through review, and are likely to be horribly
> broken and need fixing? So you can fix up the PHY node as part of the
> cleanup.

The specific board I'm working with is not in mainline, however there
are boards in mainline that will have the exact same issue. They simply
do not currently have any hardline ethernet support in mainline at the
moment and have to rely on wifi for internet connectivity unless using
out of tree patches.

