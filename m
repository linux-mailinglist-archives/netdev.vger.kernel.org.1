Return-Path: <netdev+bounces-124043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 051FE967676
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 14:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36ED11C212FA
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 12:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B401816A938;
	Sun,  1 Sep 2024 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mY7NvXh/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368221420B0;
	Sun,  1 Sep 2024 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725194246; cv=none; b=sbxOhZ7vH5bVTlRibDU3p1xgVa5D4thr/DnF++ImwdNdy3vTKppr/N3vZkPTBj0HW047oilZHpjcTIctXZoB0JP6KpL79erAS1kaoZvrvDNrrtbkkWLRkIGJsqyCzbFH8XS/5GnP4psAb3iWXHgS1afFYwPs7j2GcNpwqyYn3kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725194246; c=relaxed/simple;
	bh=/d+UPiGMFi+JwsZt2nRAF06IkfCkPLkejaRDF3v4yD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2r+fgKBBQetAaIkmtvc7ARP5Oix7/Xg9KGD8qLF2IHV+PRtzrcEOOea38/S/EB8Ds/wMeD2Ud4WcV2JIbKVprGIbAvNa2VZjgH85vGe+WgNtUh8CbkMrIk5ff0rpriWgIZsnuoBK/13JczPwL1uNboL5BDGWjFxrtT/JbD/TLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mY7NvXh/; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e1a9dc3efc1so798664276.2;
        Sun, 01 Sep 2024 05:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725194244; x=1725799044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCBZGfJE839k/86N97F9e99gDMLy1EXNtJ5mm3fEDRw=;
        b=mY7NvXh/o1Mtgf5g67d3gR1I4Fxa8QmN8vYrhaQLN3msBaJidirmEoR8s7+1yg7MrC
         PVixAdbzfL4Cu9ttRDgY4Ch+pwsIUKw5U8QpiSzSQtD4SECROXitJQ3TQPiWVVqC1f7I
         VRvzErZ7bnsdIaXITZJjlmoaHuYeuD4rydosZAixS5GnW9zbHk3oFgZHDJEbGq/ufJQZ
         h8EIrj0ODX4zY289x3P879pzUcYKveZ64Fnt3hj4+suEC5iBzIESWVFJpbPKUDrVhSRY
         TYc8d7YxDJ+uguLCmAc2CAcMESiyOT39UK7DPoLKtb3Co/KbaaY5GNRpxugKcclEpN2s
         7yxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725194244; x=1725799044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCBZGfJE839k/86N97F9e99gDMLy1EXNtJ5mm3fEDRw=;
        b=CFEx4+mVPVhcCP9WBEzOyx0EVSJZWcYgS5G7NnjVK5qX6rI9M34FKWMf/D8hfeeqZg
         t/+Fpl6eyk/spAl2U6bnRiflW9+dISrCwYNLb1S20sZloneDXrGCzy2QtMinuBdwImXS
         58kr2yVl2ATnrE4IMGXxuJ/WTxtIjQfUt98hyMUQ99a/mj8+cPGN4S4ncNWBXLQQGLGf
         RsOyic1AWK5l79S5tusbfx+oBEdeBaji9MbLHBpyO7bgJcyOawp3wZf1tDpxNvUVFsqm
         PCUSuZDIbJJq5qHsa4uCNbiWk0XEk//3/BNCxqOBS0+m1QiccEPn8yYjnG/PlHKpGDC+
         5zGg==
X-Forwarded-Encrypted: i=1; AJvYcCWQOYDZrYjRkq1NJbjWc0EqGYMmmJCq1DR78vJ0XxnJYpFIun7DQcf4MMrCYSV2qbLg3L61KOqu3S5BrvE=@vger.kernel.org, AJvYcCX8VJfTu+TVdEPLijGo8rgcxqM3Cy1+/TkstkrC2MQyqK5IazQER32aINYepWyanvg+E8yrp4Ve@vger.kernel.org
X-Gm-Message-State: AOJu0YwR7rBcnOcxvGvnaZ5C+rByfp4v2pyHXLTFcRLpKzS+PhObI7Yn
	fh9XCVHuK0H/z3UjkEZeyvOteQRVqOOSfN1guF/hxYt4FXKiXkoUUmAlgWWqSkdWq0RZr8Fo9wB
	588S8qTcakD23A7kBiRqtSUUrnBw=
X-Google-Smtp-Source: AGHT+IG/c5y7rEnYkrwEPzbLUPRhIbfSMTx7NWFb4Ir5J9z7XxVHzteq3q5SRF4uCbnlVOQ/hxiDk/HyFQfpzr2RPHo=
X-Received: by 2002:a05:6902:2584:b0:e16:6742:6e99 with SMTP id
 3f1490d57ef6-e1a7a1a295dmr7089294276.39.1725194244067; Sun, 01 Sep 2024
 05:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
 <20240830020001.79377-7-dongml2@chinatelecom.cn> <20240830153141.GP1368797@kernel.org>
In-Reply-To: <20240830153141.GP1368797@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sun, 1 Sep 2024 20:37:25 +0800
Message-ID: <CADxym3ZQt-FC0QGgHFx458ePJSTWXOEoVe2fFh_dN_Lxfe=sXA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 06/12] net: vxlan: make vxlan_set_mac() return
 drop reasons
To: Simon Horman <horms@kernel.org>
Cc: idosch@nvidia.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, 
	dongml2@chinatelecom.cn, amcohen@nvidia.com, gnault@redhat.com, 
	bpoirier@nvidia.com, b.galvani@gmail.com, razor@blackwall.org, 
	petrm@nvidia.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 11:31=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Fri, Aug 30, 2024 at 09:59:55AM +0800, Menglong Dong wrote:
> > Change the return type of vxlan_set_mac() from bool to enum
> > skb_drop_reason. In this commit, two drop reasons are introduced:
> >
> >   VXLAN_DROP_INVALID_SMAC
> >   VXLAN_DROP_ENTRY_EXISTS
> >
> > To make it easier to document the reasons in drivers/net/vxlan/drop.h,
> > we don't define the enum vxlan_drop_reason with the macro
> > VXLAN_DROP_REASONS(), but hand by hand.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  drivers/net/vxlan/drop.h       |  9 +++++++++
> >  drivers/net/vxlan/vxlan_core.c | 12 ++++++------
> >  2 files changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/vxlan/drop.h b/drivers/net/vxlan/drop.h
> > index 6bcc6894fbbd..876b4a9de92f 100644
> > --- a/drivers/net/vxlan/drop.h
> > +++ b/drivers/net/vxlan/drop.h
> > @@ -9,11 +9,20 @@
> >  #include <net/dropreason.h>
> >
> >  #define VXLAN_DROP_REASONS(R)                        \
> > +     R(VXLAN_DROP_INVALID_SMAC)              \
> > +     R(VXLAN_DROP_ENTRY_EXISTS)              \
> >       /* deliberate comment for trailing \ */
> >
> >  enum vxlan_drop_reason {
> >       __VXLAN_DROP_REASON =3D SKB_DROP_REASON_SUBSYS_VXLAN <<
> >                               SKB_DROP_REASON_SUBSYS_SHIFT,
> > +     /** @VXLAN_DROP_INVALID_SMAC: source mac is invalid */
> > +     VXLAN_DROP_INVALID_SMAC,
> > +     /**
> > +      * @VXLAN_DROP_ENTRY_EXISTS: trying to migrate a static entry or
> > +      * one pointing to a nexthop
>
> Maybe it is clearer to write: one -> an entry
>

Okay!

> > +      */
> > +     VXLAN_DROP_ENTRY_EXISTS,
> >  };
> >
> >  static inline void
>
> ...

