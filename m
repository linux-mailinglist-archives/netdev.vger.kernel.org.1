Return-Path: <netdev+bounces-82935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDFD8903E9
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 16:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9891C2DDAE
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 15:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411D212E1D0;
	Thu, 28 Mar 2024 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOZDS/Ah"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B332B54BED
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711641263; cv=none; b=hvFVkQK+02nO5S5pYiNeVZ/kVEOjyYJgHfh49xpv5eMoE+OhjJdeb0Us9LpOtk0ILfFrGtlFOY4jkF8Bwnog1x8TebqjWlvB+h/+W2g5N3TEjev0hjHQa5ezg+xIpZdHqzElHP9ba2xCf/IsM6KlhnOAo2VdJy2Qjj1gefCq2xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711641263; c=relaxed/simple;
	bh=DdVbdbDrDFs2RTiS1Hx4Pdses+aj8Em2CA8hjdrZPfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYCy9VZxEBYb/1Jyq9YmoGBeIpTJF8Fs0qJuehHfGUGjPA9BtyW1J4VP+xO/rcUEWNEjeUw5Bt211Ymh3UofLaRz400cZEx+0FJ/SaAspgrUwCaYjgagdk3kqLW0jEPlcU7ew7fCrBRidz8Pf70qtvoOgMmKEI98qpGXuGvwqD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOZDS/Ah; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2220a389390so518618fac.0
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 08:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711641261; x=1712246061; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dkyOSAqnjnWoky7Ff1S/mAj3ec5VipKASoh7TgF31Q8=;
        b=TOZDS/Ahi8EkHgFCK/twvRQQdgDbrXLIQdy2wZqVuPGAgvutSH4DrF6d62D25o/hgr
         1mvLp/6i5PdAbpre5yqcbF9bF+CXXT9VtN5ZsQVp3F185BwVGNe7turKxMD14uj3X0vG
         YB4Pu/ZAjWa2ruDWDcz0bs6RdSXraCBSxPfax75qyvVAEhhCw7BrTQB3/IEQ2TrTPHDf
         6B3IKpWIFZIrr8rys+yfvoAIy0zBdAQIUP8vEw3r7w3iicS0BwO0iT9EkWUtT1BSEa+e
         LIt8m74ZDkQAb8s8ErEmYhLHFaFYRRvwvP17z1H43OjNvdSTHkDdyNfBNk0BY7j2wgPc
         S5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711641261; x=1712246061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkyOSAqnjnWoky7Ff1S/mAj3ec5VipKASoh7TgF31Q8=;
        b=B21zThWTkledLk4Ifry32GKZxqfdxg7KM1Fhp/IzG5NHcXgIzpCJCIvGpKy2aCrZfz
         vyC/2xq/tjo6V7ZDSyWWf9irk6MLwLq03e5s7vwdIx3lnVznhWtkgMVsIbsAjSIzmx/D
         nS6IkoCFpU1tF3C5Ak8AC83hE26+fhW5qSYK+tbqrKe3oqUrTmkHhjdR01zaH+Gh7Z6l
         XWO6btkzDsMKOboPnNsDG17ktXmgnV8KBVqGIy7HBmJuqQ07abpEBDtaJKL4OdVNiH9g
         WeWtfnqCcLkYLNbNPC1g+/bUded7bo6Pe7QFZAAfhqAHRwtIwevpVU4deoBxOt4BEANC
         Xs8g==
X-Gm-Message-State: AOJu0YwEcwweC77Onw3+RF/bqgQC1Ui20cFrgiGmr6ZSHg0kz/1AdOux
	GgG+99s+3Vgz2RVhIrLO3qs3Qt/JaFkp2nvi02oR2TCGr8kEGqdKgA+Qlg13bdLAUSPQXURkKvr
	CHpblOo8WsNpDdlHC7sESymEGd7o=
X-Google-Smtp-Source: AGHT+IFpE65PpW2PtxXTIA/h0t462n1/D8x+MuARcBEbuOf2SszydNvrwc9pFB/GKpvlC0aUNGvH/TkMxPtWdBcu0+I=
X-Received: by 2002:a05:6870:a712:b0:22a:57da:6fec with SMTP id
 g18-20020a056870a71200b0022a57da6fecmr1153124oam.16.1711641260813; Thu, 28
 Mar 2024 08:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326201311.13089-1-donald.hunter@gmail.com>
 <20240326201311.13089-3-donald.hunter@gmail.com> <ZgWF/fIGXo/C1LSh@gmail.com>
In-Reply-To: <ZgWF/fIGXo/C1LSh@gmail.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Thu, 28 Mar 2024 15:54:09 +0000
Message-ID: <CAD4GDZz+-3=fBqEkMJqORxF=1wwX84aXm3JW=K0tLG2vNF+Vdg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/3] doc: netlink: Add hyperlinks to generated
 Netlink docs
To: Breno Leitao <leitao@debian.org>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Alessandro Marcolini <alessandromarcolini99@gmail.com>, donald.hunter@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Mar 2024 at 15:00, Breno Leitao <leitao@debian.org> wrote:
>
> Hi Donald,
>
> On Tue, Mar 26, 2024 at 08:13:10PM +0000, Donald Hunter wrote:
> > Update ynl-gen-rst to generate hyperlinks to definitions, attribute
> > sets and sub-messages from all the places that reference them.
> >
> > Note that there is a single label namespace for all of the kernel docs.
> > Hyperlinks within a single netlink doc need to be qualified by the
> > family name to avoid collisions.
> >
> > The label format is 'family-type-name' which gives, for example,
> > 'rt-link-attribute-set-link-attrs' as the link id.
> >
> > Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> > ---
> >  tools/net/ynl/ynl-gen-rst.py | 44 +++++++++++++++++++++++++++---------
> >  1 file changed, 33 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
> > index 5825a8b3bfb4..4be931c9bdbf 100755
> > --- a/tools/net/ynl/ynl-gen-rst.py
> > +++ b/tools/net/ynl/ynl-gen-rst.py
> > @@ -82,9 +82,9 @@ def rst_subsubsection(title: str) -> str:
> >      return f"{title}\n" + "~" * len(title)
> >
> >
> > -def rst_section(title: str) -> str:
> > +def rst_section(prefix: str, title: str) -> str:
> >      """Add a section to the document"""
> > -    return f"\n{title}\n" + "=" * len(title)
> > +    return f".. _{family}-{prefix}-{title}:\n\n{title}\n" + "=" * len(title)
>
> Where is 'family' variable set? Is this a global variable somewhere?

Yes, here in parse_yaml(). I realise it's a bit of a hack but would
like to clean this up as part of switching to using ynl/lib/nlspec.py
for reading the specs, in a separate patchset.

-    title = f"Family ``{obj['name']}`` netlink specification"
+    # Save the family for use in ref labels
+    global family
+    family = obj['name']
+
+    title = f"Family ``{family}`` netlink specification"

