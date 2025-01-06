Return-Path: <netdev+bounces-155408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2B4A02461
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3251646D7
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 11:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35011DDA14;
	Mon,  6 Jan 2025 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuSXSe0V"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F16B1DD86E
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736163371; cv=none; b=H5cd67RCveq8w8l2wAQAdn7IySLK1EoBFwcgaA2+atDDtny3xnZPJ48pmMWiQZ+0A02D1hsWbwuH44nv2f1gWSVmDhbs1+fciVpqfKtRtaT020tbChSUbPqX5tPQIJuJJTaGHZpmuqxLwZXE0Ngtk0zO/cQoePemt3Gploe+i64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736163371; c=relaxed/simple;
	bh=3YDXjdJpnP9CWdAvqGZ8om3mb5sK2X70TTZfDDQc11I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zww7eimKOMZmLkyOdrNtJkrf20oU4VorkEfsOBhwa/rRA/gdkjd2yi5wi1atKrKDTIxOFVtxSXmETsPdu6tFGOmqdzWITsuwl8xYEuQvggeCmYo0l2QMMJLdRbL51ogkrniIbwxTSpSgBvUrQs90He0Jb/z+9hO8hQGaXLCfwb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QuSXSe0V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736163368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qnKSX0BKG/HdluzM5T8vgNomi73KITmIl6+RxB1MXxc=;
	b=QuSXSe0VmrWnYdLR4GhXdgQJB9whfezi0y4HDzpJKNRn5vwOFKwRSoCIEyN0WQLU2QZGzl
	/UDHcddb7HV3YQgd+7J1un9FtwMjiZBmIu5C0/PQT/d0DvEUSjJYNsGq3J8q14cxJla3l6
	In2KhGOFXl1ocV/tRPnQ/vKmkxxCgtE=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-0cqbienkMumT53J_Ukbw9A-1; Mon, 06 Jan 2025 06:36:07 -0500
X-MC-Unique: 0cqbienkMumT53J_Ukbw9A-1
X-Mimecast-MFC-AGG-ID: 0cqbienkMumT53J_Ukbw9A
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-71e27b68f97so9564823a34.0
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 03:36:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736163366; x=1736768166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnKSX0BKG/HdluzM5T8vgNomi73KITmIl6+RxB1MXxc=;
        b=H3wIVNMtNHvQL8lGN/2K+6c7kI+DkBz52JrAiF767p3dng81jmxoiPvMNANk0OSf/y
         kG6JhTpHYmjnX5vWO4VDns2zlPO8vvZ8S1JuSBfSAmyatvdhA5p45V6gKE3/STIB93rv
         /spGCm/y00KMBMNyRe4f6Fy6kO4DT8TIV4hRC1o/AzWEij7pOKNBs0b01zIB/RqaHGiH
         UuuRDQ+WlsTyle49nmMW5u30ZydGJCiCtubjur1aCPw230MUUTMjhk3J4/shung43/da
         Q6V4Z4/dj06cljXoqzZ6Vh96wEDtUGtbc/FFbHb3ykQHU2+OixbTWStndTBuAnQCNXOd
         3AEg==
X-Forwarded-Encrypted: i=1; AJvYcCXvekwnwEmGjKKhoSHTi32FVbvhnZiQpALaHNh0OfvYm+WqSF3pnFAaBoTV9vQuC0SyUUnVE0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgeN6e+ZScH+NvagCb3YCtCuST+QChcdSQtL0QL4W5j9EGA++2
	8Ic5ORSzp3G4VyU1/Uvktgg6LK7zSOTx+x/bMoZRj9lFJGuxvCeMCRGbA/Z2bINW/7IL2wpRQt+
	Nkw1egcnyuK3qopU4SK9dBpFbFCxGH1ko6TWGM9OvRuRqIeAQc4ufhOWSE17cnTSGysUHA11Gxg
	SaFAfGzrbsoxNmrn+fJXQ9KnpnStEV
X-Gm-Gg: ASbGncuiLrLcx2Pg8XPyLhDKDHm6y1snhJJhF8hLgjLQlJ/+Hlo5r0La/obY+n+dlQ5
	SWKJRDgegoXp2bydnQM3uYjIVrvOejJXi5AYQEQ==
X-Received: by 2002:a05:6830:6486:b0:71d:f361:5cfb with SMTP id 46e09a7af769-720ff7ff009mr32403208a34.5.1736163366379;
        Mon, 06 Jan 2025 03:36:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoefZ9JinxRRtDbiP5Qxxe3GQXTXBtYSRA3Uf4WQe2cHdBnesnRyqQiRNl+xV9J+TtdpLiHPxPvbR3X0cePpc=
X-Received: by 2002:a05:6830:6486:b0:71d:f361:5cfb with SMTP id
 46e09a7af769-720ff7ff009mr32403198a34.5.1736163366143; Mon, 06 Jan 2025
 03:36:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1734345017.git.jstancek@redhat.com> <a2e4ffb9cbd4a9c2fd0d7944b603794bff66e593.1734345017.git.jstancek@redhat.com>
 <m2a5cv917h.fsf@gmail.com>
In-Reply-To: <m2a5cv917h.fsf@gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 6 Jan 2025 12:35:50 +0100
Message-ID: <CAASaF6zxdppxDVGCNsd_h8n2-yw7P-z+D62paykBcRQU7-16eA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] tools: ynl: add install target for generated content
To: Donald Hunter <donald.hunter@gmail.com>
Cc: stfomichev@gmail.com, kuba@kernel.org, jdamato@fastly.com, 
	pabeni@redhat.com, davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 3:10=E2=80=AFPM Donald Hunter <donald.hunter@gmail.=
com> wrote:
>
> Jan Stancek <jstancek@redhat.com> writes:
>
> > Generate docs using ynl_gen_rst and add install target for
> > headers, specs and generates rst files.
> >
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  tools/net/ynl/generated/.gitignore |  1 +
> >  tools/net/ynl/generated/Makefile   | 40 +++++++++++++++++++++++++++---
> >  2 files changed, 38 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/net/ynl/generated/.gitignore b/tools/net/ynl/generat=
ed/.gitignore
> > index ade488626d26..859a6fb446e1 100644
> > --- a/tools/net/ynl/generated/.gitignore
> > +++ b/tools/net/ynl/generated/.gitignore
> > @@ -1,2 +1,3 @@
> >  *-user.c
> >  *-user.h
> > +*.rst
> > diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated=
/Makefile
> > index 00af721b1571..208f7fead784 100644
> > --- a/tools/net/ynl/generated/Makefile
> > +++ b/tools/net/ynl/generated/Makefile
> > @@ -7,12 +7,19 @@ ifeq ("$(DEBUG)","1")
> >    CFLAGS +=3D -g -fsanitize=3Daddress -fsanitize=3Dleak -static-libasa=
n
> >  endif
> >
> > +INSTALL          ?=3D install
>
> nit: mix of tabs and spaces here
>
> > +prefix      ?=3D /usr
> > +datarootdir ?=3D $(prefix)/share
> > +docdir      ?=3D $(datarootdir)/doc
> > +includedir  ?=3D $(prefix)/include
> > +
> >  include ../Makefile.deps
> >
> >  YNL_GEN_ARG_ethtool:=3D--user-header linux/ethtool_netlink.h \
> >       --exclude-op stats-get
> >
> >  TOOL:=3D../pyynl/ynl_gen_c.py
> > +TOOL_RST:=3D../pyynl/ynl_gen_rst.py
> >
> >  GENS_PATHS=3D$(shell grep -nrI --files-without-match \
> >               'protocol: netlink' \
> > @@ -22,7 +29,11 @@ SRCS=3D$(patsubst %,%-user.c,${GENS})
> >  HDRS=3D$(patsubst %,%-user.h,${GENS})
> >  OBJS=3D$(patsubst %,%-user.o,${GENS})
> >
> > -all: protos.a $(HDRS) $(SRCS) $(KHDRS) $(KSRCS) $(UAPI)
> > +SPECS_PATHS=3D$(wildcard ../../../../Documentation/netlink/specs/*.yam=
l)
>
> You missed Jakub's request to factor out SPECS_DIR:
>
>   Maybe factor out:
>
>   SPECS_DIR :=3D ../../../../Documentation/netlink/specs
>
>   ? It's pretty long and we repeat it all over the place.
>
> > +SPECS=3D$(patsubst ../../../../Documentation/netlink/specs/%.yaml,%,${=
SPECS_PATHS})
> > +RSTS=3D$(patsubst %,%.rst,${SPECS})
> > +
> > +all: protos.a $(HDRS) $(SRCS) $(KHDRS) $(KSRCS) $(UAPI) $(RSTS)
> >
> >  protos.a: $(OBJS)
> >       @echo -e "\tAR $@"
> > @@ -40,8 +51,12 @@ protos.a: $(OBJS)
> >       @echo -e "\tCC $@"
> >       @$(COMPILE.c) $(CFLAGS_$*) -o $@ $<
> >
> > +%.rst: ../../../../Documentation/netlink/specs/%.yaml $(TOOL2)
>
> Did you miss Jakub's review comment: TOOL2 -> TOOL_RST ?

It seems I did miss his entire email. I'll double check with lore
archives before sending out v4.

Jan


>
> > +     @echo -e "\tGEN_RST $@"
> > +     @$(TOOL_RST) -o $@ -i $<
> > +
> >  clean:
> > -     rm -f *.o
> > +     rm -f *.o *.rst
>
> Also Jakub's comment:
>
>   No strong preference but I'd count .rst as final artifacts so I'd clean
>   them up in distclean target only, not the clean target. The distinction
>   itself may be a local custom..
>
> >  distclean: clean
> >       rm -f *.c *.h *.a
> > @@ -49,5 +64,24 @@ distclean: clean
> >  regen:
> >       @../ynl-regen.sh
> >
> > -.PHONY: all clean distclean regen
> > +install-headers: $(HDRS)
> > +     @echo -e "\tINSTALL generated headers"
> > +     @$(INSTALL) -d $(DESTDIR)$(includedir)/ynl
> > +     @$(INSTALL) -m 0644 *.h $(DESTDIR)$(includedir)/ynl/
> > +
> > +install-rsts: $(RSTS)
> > +     @echo -e "\tINSTALL generated docs"
> > +     @$(INSTALL) -d $(DESTDIR)$(docdir)/ynl
> > +     @$(INSTALL) -m 0644 $(RSTS) $(DESTDIR)$(docdir)/ynl/
> > +
> > +install-specs:
> > +     @echo -e "\tINSTALL specs"
> > +     @$(INSTALL) -d $(DESTDIR)$(datarootdir)/ynl
> > +     @$(INSTALL) -m 0644 ../../../../Documentation/netlink/*.yaml $(DE=
STDIR)$(datarootdir)/ynl/
> > +     @$(INSTALL) -d $(DESTDIR)$(datarootdir)/ynl/specs
> > +     @$(INSTALL) -m 0644 ../../../../Documentation/netlink/specs/*.yam=
l $(DESTDIR)$(datarootdir)/ynl/specs/
> > +
> > +install: install-headers install-rsts install-specs
> > +
> > +.PHONY: all clean distclean regen install install-headers install-rsts=
 install-specs
> >  .DEFAULT_GOAL: all
>


