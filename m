Return-Path: <netdev+bounces-197490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DED5AD8C96
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5835189CAF0
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 12:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C12685C5E;
	Fri, 13 Jun 2025 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeLqN/GS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC9A347DD;
	Fri, 13 Jun 2025 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749819234; cv=none; b=Q4v2tvKWOG2Ilvn3XK3DJT/581+IRIsSORmLnsqIjgWE3F/5ptu02lTCyVIHWeLDqYmbCkiwL8PlDhUx0L/IBFUIRkyOXD9YmtcSv7FM6GAZaaKcldazBnJIZYKlS/FbQvdqC2r3g0rL+DTnFTmrS/YARHBvVFuz44dWcVx5QH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749819234; c=relaxed/simple;
	bh=xsyK3DDIp1rgLxrUI+jVN6D+Sh2hh46tvv4RC/83r74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBNIqPkccJQf55a4MsJMzbwO8nYgO26h8e/Hc7Lb/DMHOndqLOZoTgMQeDndn0GOlSrRRUECsYonAh7VX8ECHO2MpNBF2pgD8a/ThLWQjHU7qdrwBCVIoi4pgyhBBkKKfMu7K6INihmzxp0ZoCPKwAlY4LYo5xFrEtDI2M9+Bs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeLqN/GS; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-407a6c6a6d4so662619b6e.1;
        Fri, 13 Jun 2025 05:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749819232; x=1750424032; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9uK7NfXjMZE9zyAnGAVVRnIGOP/qUCD+jt4heNuFuQs=;
        b=FeLqN/GS2KD26DEN+Vt45XA4RqnQxDOxHo3/3vi1jaa3HClIXhOXgW/TMgQE/yTRwA
         vyADfkfJl9ePvVZTEYNhLw7xLpz+SUl9ifZ6BUST5yrPp0nVRn47p2qlb0gzj4y0RRce
         /qwgYznWGVOTdC07kFbcKWTAz26lK/61ictgbrteDDfNr1D/Znt8MWx4ti5WxBe50AYg
         jgInfiy4jhKfMOXEveEAd8Rr5JJUrtMrUEgdboDc9mUDiNWhhGQUBOXXqUVSA7uTRYo7
         /WtalYvTuds64RrAw++oxhM4UNjklODYlW3+0HtSf5gMn7b6C+aGJiDDIsUNuWdE3bYw
         sRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749819232; x=1750424032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9uK7NfXjMZE9zyAnGAVVRnIGOP/qUCD+jt4heNuFuQs=;
        b=GHnv9WfCdBpeE2gtEBPhs1NeiYJ9ily+4EThHb2i9I8NitzEDEKo+qNecyk3FMjtAn
         f/+T10RtS0cG4uNsWHdM5ppHUdVtUpaSsjmP3jgVl95uXtq38NvV0qGwgPc47bUu38hI
         eiwIIOyrdQZS5KTd/3NI9GTjFgVKJbI4Dmg4cU4qOoW5W4XeTQqVTJx3FNTI1NnSoxxs
         dDPqqLh+2AVY7bsIPApoM1CC6Hfocz7H9kmicPQeQGeTNhdMBmkQjP4faVaJB4gJ7ZFm
         M3ZGZST7YzVUPSaSp8ohRsU7y5QBtr71YWg5Nb0PGr836AwgNIsIqmEJYf5QkW7APmhW
         pX6w==
X-Forwarded-Encrypted: i=1; AJvYcCUd7h0FT+t6Y0ldHEl7tXiQYorjr1YF59hm8jHYm9RbEemD836CMxKiKdEpUHzNIQQHikaxnjPEgF1MK58=@vger.kernel.org, AJvYcCWZfoGtjHuGcIvzGymiNEBujgt+REPRRZnmylMC+O2ak7gG5bS/bgHgOGcvAF2dHJZA2tgSUqHA@vger.kernel.org
X-Gm-Message-State: AOJu0YxReKGjMDaRetfyMxZj6k6LTDu4m3gYEBs1A0dTPCbO1YyCP+N0
	sHakQxAiGvYxNLpWpXtUdTtsPq7lKyIMO101V8H0gXLg4zvkti9BA4yL0HiWuES4gBuqkIBMLdK
	EsuW55LrjAXQtmSxnMm4Ofn4TQwGyb8Q=
X-Gm-Gg: ASbGncsKqwT88ql9sruHK+mOf8P8B/GuxUaexwF78AGub4czwNa8bzbbE548TX80I+T
	1qL77QRTbF4oYsxfzi6FLOB93jfhNC5vWvXEu09x5pf6E/Lp36ERN2bFh4mS7vGk7ct47oy1uX9
	opGZiXIQaEec/urBQ7JWlPF3zSM8nKxF0odmx6f/9Q3y5zui+pNVUfnfNQMrDBg1Q+MavPjbocv
	g==
X-Google-Smtp-Source: AGHT+IG4oeSmNbFar9MLWvDxuCLCzS1cvjPlujNGI66zalqzF9G7WhJe/7gNkuUgdZQZqQaDPQKfIQiwXIfWMIU4QXY=
X-Received: by 2002:a05:6808:4fe9:b0:404:dd07:9703 with SMTP id
 5614622812f47-40a723a0827mr2330242b6e.26.1749819231675; Fri, 13 Jun 2025
 05:53:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749723671.git.mchehab+huawei@kernel.org>
 <08ac4b3457b99037c7ec91d7a2589d4c820fd63a.1749723671.git.mchehab+huawei@kernel.org>
 <m2y0tvnb0e.fsf@gmail.com> <20250613144014.5ae14ae0@foz.lan>
In-Reply-To: <20250613144014.5ae14ae0@foz.lan>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Fri, 13 Jun 2025 13:53:40 +0100
X-Gm-Features: AX0GCFueKdzQLScURrrCaq--58okmj1NFh4Gy-SFqVk9_ecMKypyt0JhaFhZIuE
Message-ID: <CAD4GDZwLW0yogWitN5vbfkDhpZZ=0YCnDh+taRzwnv_CY9Miag@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] scripts: lib: netlink_yml_parser.py: use classes
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Akira Yokosawa <akiyks@gmail.com>, Breno Leitao <leitao@debian.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Ignacio Encinas Rubio <ignacio@iencinas.com>, Jan Stancek <jstancek@redhat.com>, 
	Marco Elver <elver@google.com>, Paolo Abeni <pabeni@redhat.com>, Ruben Wauters <rubenru09@aol.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, joel@joelfernandes.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org, 
	stern@rowland.harvard.edu
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Jun 2025 at 13:40, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Fri, 13 Jun 2025 12:20:33 +0100
> Donald Hunter <donald.hunter@gmail.com> escreveu:
>
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> >
> > > As we'll be importing netlink parser into a Sphinx extension,
> > > move all functions and global variables inside two classes:
> > >
> > > - RstFormatters, containing ReST formatter logic, which are
> > >   YAML independent;
> > > - NetlinkYamlParser: contains the actual parser classes. That's
> > >   the only class that needs to be imported by the script or by
> > >   a Sphinx extension.
> >
> > I suggest a third class for the doc generator that is separate from the
> > yaml parsing.
>
> Do you mean moving those two (or three? [*]) methods to a new class?
>
>     def parse_yaml(self, obj: Dict[str, Any]) -> str:
>     def parse_yaml_file(self, filename: str) -> str:
>     def generate_main_index_rst(self, output: str, index_dir: str) -> None:
>
> Also, how should I name it to avoid confusion with NetlinkYamlParser?
> Maybe YnlParser?

On second thoughts, I see that the rst generation is actually spread
through all the parse_* methods so they are all related to doc generation.

I suggest putting all the parse_* methods into a class called
YnlDocGenerator, so just the 2 classes.

And I'm hoping that generate_main_index_rst can be removed.

> [*] generate_main_index_rst is probably deprecated. eventually
>     we may drop it or keep it just at the command line stript.
>
> > The yaml parsing should really be refactored to reuse
> > tools/net/ynl/pyynl/lib/nlspec.py at some point.
>
> Makes sense, but such change is out of the scope of this series.

Agreed

Thanks,
Donald.

