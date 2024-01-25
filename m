Return-Path: <netdev+bounces-66035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FE383D067
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 00:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385A61C232F1
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 23:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC23B11C92;
	Thu, 25 Jan 2024 23:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v5HUMq6S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D3712B9B
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 23:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706224313; cv=none; b=RfcmmcjcINjjiAqD9SSdq18dX0PPMInm7lNt7blR8ltk2n+tm4AzFMZHmhDDrSXu+hD2hrcJaM6cqANLgnLW3obZl+Kx6Odo5d/Qy32TruN7eBC0nkW6n3FJkdKcbNnbKotVe5XOdOpRwlfVfZh/N7eZKT3HJHDUXH4B/Ys9xr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706224313; c=relaxed/simple;
	bh=YtS5xzfSbjTgH/ZCUwt55l0xlnBYN+jDXP4yQ7Ywvq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYK13EmerRw9kvYBgaiauCnU//dgQtLdIoLROU4o2bvqiFk8grv/i/DaQgD7Wg5HBegkAyK32glV3xwFmok0hv3/AkVpJ7nTnkr3gs7+Fl21KTx2OeqrvRTuwcmwTAxfj3TZPH8UzudTDskfB5DeB7pyJka4Oy3+aHTq34V0jz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v5HUMq6S; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6818aa07d81so293386d6.0
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 15:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706224311; x=1706829111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnbQ1xFcEmEwSTASAAMd8cxx311V8+6HftWzyQL8l5s=;
        b=v5HUMq6SEiO9204VtlNNEHPA+1fYXF30iVa70VKSaC91rljlS3ztk1dgUXkrYPeCUw
         jq4tFPiFldEZ52K9SGmGssagN5If4/gFq/YXLbuO5veu92VG3AR03zRc9ItiDGOlHKBY
         HWCZBjsm1KtfHTJv/Pr5kPNYu56pdn+k4iL7MBE7tuTrYU81g3BoJuhhxlKTRJrQiQVP
         E7DB3U3hURH5aCGyprpr2Up0bXoFg0Ey6WIDYEboooo3BvYbErt0AG7k8J90+iwLVDBk
         lw9OBSDbtDcw3YUB3UMGMDuY+TmvoLVxrlWdP6qi8eNSLgoD6gsXsEU6U7vi1ED19kPN
         663Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706224311; x=1706829111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnbQ1xFcEmEwSTASAAMd8cxx311V8+6HftWzyQL8l5s=;
        b=iLGJgwJWfLZT5pZX5NapKsSIkR220j2LX8MK+yVLIyTmh8nV6CjmYi0tMzmMynhpGQ
         hoNGWiean/ulZeKcsZnmY5SMqs+NoVX0PJxgb9/famUK9YOiFvOsjgAI9BLAQbeuyrBR
         vThnq/uh9F/uUet9xWq8uUocQC1fAgzH3be92AuGE0Wc2LsQ8rA8kcuZx3pnsQPJR6DF
         CCiDp8VWkBLQQ1odVJKtAQhrZOgjFfBXKSVcxuZTDejnJabMLtAZjdtDpjQ5YxU2RaPT
         MAcvH+aXG/gWTjloV49gyMMwLPAqzQBtgdIa696E0LDJ3N1q+NSYN/4IEAufiZcNUpL7
         VT/A==
X-Gm-Message-State: AOJu0Ywl03juZs0WWhxaEYZtqnXC9ru/T+Q4El0y9px+oTLAlHV26plE
	UGRCkI/5l5tCkJH2hq+NqJuo7sXAzhBR3jQbX1/X4GHTdCsVt4L82PdWgKoJVpTpRriMBGR0Nbr
	dpEf7I0EJ1tQ7y1LPIxbq/VFJHu6DOZijj+c1+tFPZcGb/E1931sX
X-Google-Smtp-Source: AGHT+IHrdoba1DSo/0fM62urAw5u7HaJ3YZxnlZOreWYMJ2EhF887qF4kEZPj/yExTB/03z/bQrtxkJh/uy7s4NgRgs=
X-Received: by 2002:ad4:5aa2:0:b0:686:ae74:f8b with SMTP id
 u2-20020ad45aa2000000b00686ae740f8bmr607903qvg.56.1706224310715; Thu, 25 Jan
 2024 15:11:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125003816.1403636-1-aahila@google.com> <4f3dc357-8c90-49fd-96ea-bc28932ea509@gmail.com>
In-Reply-To: <4f3dc357-8c90-49fd-96ea-bc28932ea509@gmail.com>
From: Aahil Awatramani <aahila@google.com>
Date: Thu, 25 Jan 2024 15:11:39 -0800
Message-ID: <CAGfWUPyDERLKTi2MSNY1ero7maFHAXmbZo11V5SFPkaCsC4J2A@mail.gmail.com>
Subject: Re: [PATCH] ip/bond: add coupled_control support
To: David Ahern <dsahern@gmail.com>
Cc: Mahesh Bandewar <maheshb@google.com>, David Dillow <dillow@google.com>, 
	Jay Vosburgh <j.vosburgh@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> This patch needs to be targeted at iproute2-next

> parse_on_off

> print_on_off

Thank you for your feedback. I have modified the patch name. I have
also dropped uapi and implemented the use of print_on_off and
parse_on_off for coupled_control as per David's suggestion.

On Thu, Jan 25, 2024 at 10:08=E2=80=AFAM David Ahern <dsahern@gmail.com> wr=
ote:
>
> On 1/24/24 5:38 PM, Aahil Awatramani wrote:
> > diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.=
h
> > index d17271fb..ff4ceeaf 100644
> > --- a/include/uapi/linux/if_link.h
> > +++ b/include/uapi/linux/if_link.h
> > @@ -1503,6 +1503,7 @@ enum {
> >       IFLA_BOND_AD_LACP_ACTIVE,
> >       IFLA_BOND_MISSED_MAX,
> >       IFLA_BOND_NS_IP6_TARGET,
> > +     IFLA_BOND_COUPLED_CONTROL,
> >       __IFLA_BOND_MAX,
> >  };
> >
>
> at best uapi changes should be a separate patch which gets dropped when
> we sync headers with the kernel.
>
> > diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
> > index 214244da..68bc157a 100644
> > --- a/ip/iplink_bond.c
> > +++ b/ip/iplink_bond.c
> > @@ -176,7 +184,7 @@ static int bond_parse_opt(struct link_util *lu, int=
 argc, char **argv,
> >  {
> >       __u8 mode, use_carrier, primary_reselect, fail_over_mac;
> >       __u8 xmit_hash_policy, num_peer_notif, all_slaves_active;
> > -     __u8 lacp_active, lacp_rate, ad_select, tlb_dynamic_lb;
> > +     __u8 lacp_active, lacp_rate, ad_select, tlb_dynamic_lb, coupled_c=
ontrol;
> >       __u16 ad_user_port_key, ad_actor_sys_prio;
> >       __u32 miimon, updelay, downdelay, peer_notify_delay, arp_interval=
, arp_validate;
> >       __u32 arp_all_targets, resend_igmp, min_links, lp_interval;
> > @@ -367,6 +375,13 @@ static int bond_parse_opt(struct link_util *lu, in=
t argc, char **argv,
> >
> >                       lacp_active =3D get_index(lacp_active_tbl, *argv)=
;
> >                       addattr8(n, 1024, IFLA_BOND_AD_LACP_ACTIVE, lacp_=
active);
> > +             } else if (strcmp(*argv, "coupled_control") =3D=3D 0) {
> > +                     NEXT_ARG();
> > +                     if (get_index(coupled_control_tbl, *argv) < 0)
> > +                             invarg("invalid coupled_control", *argv);
> > +
> > +                     coupled_control =3D get_index(coupled_control_tbl=
, *argv);
>
> parse_on_off
>
> > +                     addattr8(n, 1024, IFLA_BOND_COUPLED_CONTROL, coup=
led_control);
> >               } else if (matches(*argv, "ad_select") =3D=3D 0) {
> >                       NEXT_ARG();
> >                       if (get_index(ad_select_tbl, *argv) < 0)
> > @@ -659,6 +674,15 @@ static void bond_print_opt(struct link_util *lu, F=
ILE *f, struct rtattr *tb[])
> >                            lacp_rate);
> >       }
> >
> > +     if (tb[IFLA_BOND_COUPLED_CONTROL]) {
> > +             const char *coupled_control =3D get_name(coupled_control_=
tbl,
> > +                                                rta_getattr_u8(tb[IFLA=
_BOND_COUPLED_CONTROL]));
> > +             print_string(PRINT_ANY,
> > +                          "coupled_control",
> > +                          "coupled_control %s ",
> > +                          coupled_control);
>
> print_on_off
>
> > +     }
> > +
> >       if (tb[IFLA_BOND_AD_SELECT]) {
> >               const char *ad_select =3D get_name(ad_select_tbl,
> >                                                rta_getattr_u8(tb[IFLA_B=
OND_AD_SELECT]));
>
> pw-bot: cr

